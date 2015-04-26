MarchingCubesOnGPU
------------------

This is an attempt at making a surface shader which works in conjunction with
compute shaders. The compute shaders in this example construct an isosurface
mesh from 4D Perlin noise volume with using [the marching cubes algorithm]
(http://en.wikipedia.org/wiki/Marching_cubes). The surface shader retrieves
vertex data from the compute buffer, and renders it with the physically based
standard shader.

The compute shaders in this example are borrowed from [Scrawk's example]
(http://scrawkblog.com/2014/10/16/marching-cubes-on-the-gpu-in-unity/).
