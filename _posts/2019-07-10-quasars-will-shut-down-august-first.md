---
layout: post
title:  "Quasars will shut down August 1st, 2019"
date:   2019-07-10 17:10:00 -0700
categories: ruby quasars projects
header_image: /assets/images/quasar.jpg
header_image_caption: An artist's rendition of a quasar
published: true
---

At the beginning of the next month I'll be pulling the plug on [Quasars][quasars]. While it might be easy to remember Quasars as another web application that nobody used but, for my purposes, it was incredibly successful. This document both celebrates Quasars and serves as a reminder of its successes.

**Quasars taught me Kubernetes**. When Quasars was first released, I used blue/green deployments. However, I recognized that [Kubernetes][k8s] was making waves in the industry and knew that it was going to be important to learn. Over a couple of weeks (hey, I have a life too) I migrated from the traditional box deployment to the k8s cluster I stood up seemlessly with no downtime. It seems very silly to have a web application that nobody uses to be migrated to a Google-level piece of infrastructure with high availability, but it was more about learning for me. It was the journey, not the destination, that had value to me.

**Quasars was listed as a Lobsters sister site**. It is no secret that Quasars takes heavy inspiration from the [Lobsters][lobsters] link-aggregation website for industry software developers. JCS's work on Lobsters has really informed my opinions on (a) choosing boring tools, (b) not over-styling your web application, and (c) knowing when it's time to move on. Quasars very easily could of been a Rust or Go application but, for a link-aggregation website, Ruby on Rails was more than enough. Quasars serves requests at ~140ms at the 50th percentile which is more than sufficient in today's internet.

**Quasars got me a job**. Most importantly, Quasars did _work_ in the job interviews I had this winter. Never underestimate how powerful having a side-project to talk about in job interviews can be. Depending on the interviewer, it can be more interesting than less-exciting work projects you've done in the past. It was great to, when given a toy app to whiteboard, to have recently built an app from scratch to have that mindset fresh as well.

"So, why are you shutting down Quasars?" You might be asking. Well, that's pretty simple.

- It has, on average, 0 monthly active users.
- It costs me money, and it's actually kind of expensive.

With that said, it's been a good run Quasars. See you on the other side.

{% include image.html url="/assets/images/quasars_screenshot.png" caption="A screenshot of the Quasars website" %}

[quasars]: https://quasa.rs
[k8s]: https://kubernetes.io
[lobsters]: https://lobste.rs
