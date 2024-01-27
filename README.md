You're probably wondering what did I even make. Well you wont be disappointed when you see it. But first!

I remembered a blog my old programming teacher wrote. (Can be found at snakehillgames.com). This blog talks about a lot of really cool sophisticated techniques and research, mostly way above my pay grade! (You should check it out btw). But there was one section which seemed perfect for a small project. It was the part about exploring techniques used to calculate surface normals for irregular terrain. This part was specifically written to show the reader the technique in a generic way. Using black and white pixels to describe the terrain and "void", an image accompanied the technical description. 

The gist of it is, imagine you have a 2D world made up of black and white pixels. The black pixels represent the terrain and the white is "void" or the sky. Each black pixel has surface normals but since pixels are squares, the surface normals are always aligned with the cardinal axes, always being either horizontal or vertical. 

I like to think of this algorithm as grabbing a bunch of black pixels and attempting to calculate a surface normal for the group of pixels, rather than each individual pixel. This way we don't have to be stuck with a bunch of horizontal and vertical surface normals, and get one nice surface normal.

### The algorithm

The way it works is:
1. Grab the position of all the black (terrain) pixels
2. Calculate the average position of them.
3. Grab the position of all the white (void/sky) pixels
4. Calculate the average position of these as well.
5. The surface normal is the normalised vector from the average position of the black pixels to the average position of the white pixels.
6. Done!

Short and simple but very cool nonetheless.

And here's what it looks like!

https://youtube.com/shorts/7bV1cbSMbsc?feature=share

![Pasted image 20240127155221](https://github.com/Pingimingi22/pixel-surface-normal-calculation/assets/42440463/2d7ad360-c26e-4500-a6e8-7ded0bf57a12)
![Pasted image 20240127155147](https://github.com/Pingimingi22/pixel-surface-normal-calculation/assets/42440463/1bf489ae-7920-47d3-a6fe-3a958d9e073b)
![Pasted image 20240127155121](https://github.com/Pingimingi22/pixel-surface-normal-calculation/assets/42440463/c8449183-1f77-489e-8b12-8b8d249740d9)
