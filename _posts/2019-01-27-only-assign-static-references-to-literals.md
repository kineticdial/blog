---
layout: post
title:  "Only assign static references to literals"
date:   2019-01-27 16:02:38 -0700
categories: java
header_image: /assets/images/java_code.jpg
header_image_caption: Photo by Maximilian Weisbecker on Unsplash
---

Assigning a static reference to a non-literal can be perilous. In this post
we'll examine why.

Let’s take a look at an example Java class:

```java
/**
 * Foo.java
 */

public class Foo {
    public static String foo = Config.getInstance().getFoo();
}
```

Seems pretty innocuous in itself, but ostensibly we’re just assigning static
reference in `Foo` to a `Config` singleton call. For our purposes, assume
`Config` has both setters and getters for values we want to store configurations
for. In my experience, these configuration objects are a common pattern and can
be handily dependency injected for ease of testing (note how we’re _not_ doing
that here). However, this code can behave quite unexpectedly if you’re not
careful. The below test suite exemplifies this:

```java
/**
 * FooTest.java
 */

import org.junit.Test;

public class FooTest {
    @Test
    public void TestSetFooA() {
        Config.getInstance().setFooConfig("bar");
        assert Foo.foo == "bar";
    }

    @Test
    public void TestSetFooB() {
        Config.getInstance().setFooConfig("fizz");
        assert Foo.foo == "fizz";
    }
}
```

Each test does performs the exact same behavior:
- Set the foo configuration to a string value.
- Tests to see if that configuration is properly read from Foo.foo.

These tests pass if you run each test in isolation. **Unfortunately, when we run
the entire suite we get a failure on the second test case.**

This is because `Foo.foo` still contains the value that the first test case set for it (specifically, `"bar"`). Because `Foo.foo` is a static value, it is only set the first time the Foo class is put in memory (in our case, the second line of the first test case). For as long as the JVM exists thereafter, that value will always be the same. Why? Well, because it’s _static_.

So what if we want the `Foo.foo` value to read from its configuration each time? We have two options that I like.

Firstly, we could use a static method instead of a static reference.

```java
/**
 * Foo.java
 */

public class Foo {
    public static String foo() {
        return Config.getInstance().getFoo();
    }
}
```

A static method will perform the logic inside of it each time it is called, therefore picking up any change to our configuration object. However, I still don’t think this is the best possible solution.

I foreshadowed dependency injection above, which in my opinion, is the most elegant solution. Here’s an example of what I mean:

```java
/**
 * Foo.java
 */

public class Foo {
    public static String foo(Config config) {
        return config.getFoo();
    }
}
```

This allows us to inject a mock of the `Config` object in our tests which also gives us the benefit of not having to mutate global state in a singleton (an anti-pattern in itself). Our test suite gets a much-needed facelift after this change:

```java
/**
 * FooTest.java
 */

import org.junit.Test;
import static org.mockito.Mockito.*;

public class FooTest {
    @Test
    public void TestSetFooA() {
        Config mockedConfig = mock(Config.class);
        when(mockedConfig.getFoo()).thenReturn("bar");

        assert Foo.foo(mockedConfig) == "bar";
    }

    @Test
    public void TestSetFooB() {
        Config mockedConfig = mock(Config.class);
        when(mockedConfig.getFoo()).thenReturn("fizz");

        assert Foo.foo(mockedConfig) == "fizz";
    }
}
```

To summarize:
- Never assign a static reference to an instance method. Use static references for literals only (strings, integers, etc).
- Consider using dependency injection for configuration objects. Mock these objects in your tests.
- Consider avoiding singletons when possible. [Here’s a great Stack Overflow thread on exactly why.][solink]

[solink]: https://stackoverflow.com/questions/137975/what-is-so-bad-about-singletons