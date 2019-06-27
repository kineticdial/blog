---
layout: post
title:  "Optimizing for Safari Reader"
date:   2019-06-26 17:10:00 -0700
categories: safari apple html
header_image: /assets/images/safari_reader_green.png
header_image_caption: How this website looks in Safari Reader
published: true
---

One of my goals for building this website was to make the best possible Safari
Reader experience (how I personally consume blogs). This post documents my
findings in how to optimize a blog for Safari Reader.

## Use the `<article>` tag

Safari Reader will look for a couple of container tags, but for a blog post
`<article>` makes the most semantic sense. I recommend wrapping all content
that you would want to appear in the reader. For example, You'll notice that my
header image is inside of my `<article>` tag, which informs Safari Reader to
include it.

## The title should be a `<h1>` tag

Additionally, it should be the first text-containing tag that is under the
opening `<article>` tag.

## Write enough content

I haven't diagnosed exactly how many words/characters are required to trigger
the Safari Reader button, but I have noticed when there's only one or two
sentences on a page, it will not appear. Usually a chunky paragraph or two
smaller ones is enough to trigger the button.

## Properly format your byline

In order to get your name and publication date to properly appear in Safari
Reader you'll have to add a few bits of metadata to your HTML. Directly under
the `<h1>` tag, you'll notice I have the following.

```html
<span itemprop="author">Patrick Brown</span>
<time datetime="2019-06-26 11:40:38 -0700">June 26, 2019</time>
```

The `itemprop` property and `<time>` tag will correctly format your byline. If
you're using [Jekyll][jekyll], you can template it like the following:

```html
<span itemprop="author">{% raw %}{{ site.author }}{% endraw %}</span>
<time datetime="{% raw %}{{ page.date }}{% endraw %}">{% raw %}{{ page.date | date: date_format }}{% endraw %}</time>
```

## All together now

So you scrolled to the bottom of this in hopes to copy/paste the entire
template. You're in luck! Here's the complete template for a Safari Reader
optimized blog post for Jekyll, as used in this website (extraneous tags
and classes have been stripped for clarity).

```html
<article>
    <h1>{% raw %}{{ page.title }}{% endraw %}</h1>
    {% raw %}{%- assign date_format = site.minima.date_format | default: "%B %-d, %Y" -%}{% endraw %}

    <span itemprop="author">{% raw %}{{ site.author }}{% endraw %}</span> •
    <time datetime="{% raw %}{{ page.date }}{% endraw %}">{% raw %}{{ page.date | date: date_format }}{% endraw %}</time>

    <figure>
        <img src="{% raw %}{{ page.header_image }}{% endraw %}">
        <figcaption>{% raw %}{{ page.header_image_caption }}{% endraw %}</figcaption>
    </figure>

    {% raw %}{{ content }}{% endraw %}
</article>
```

[jekyll]: https://jekyllrb.com