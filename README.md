# Vector Library

This project provides a simple vector library in Lua, including 2D and 3D vector classes.

## Vector2D Class

The `Vector2D` class represents a 2D vector and provides various methods for vector operations.

### Methods

- `new(x, y)`: Creates a new `Vector2D` instance.
- `dot(other)`: Computes the dot product with another `Vector2D`.
- `cross(other)`: Computes the cross product with another `Vector2D`.
- `angleTo(other)`: Computes the angle to another `Vector2D`.
- `projectOnto(other)`: Projects this vector onto another `Vector2D`.
- `distanceTo(other)`: Computes the distance to another `Vector2D`.
- `lerp(other, t)`: Linearly interpolates between this vector and another `Vector2D`.
- `rotateByAngle(degrees)`: Rotates this vector by a given angle.
- `reflectAcross(normal)`: Reflects this vector across a given normal.
- `magnitude()`: Computes the magnitude of this vector.
- `normalize()`: Normalizes this vector.

### Example Usage

```lua
local Vector2D = require("vectors.vector2d")

local v1 = Vector2D.new(1, 2)
local v2 = Vector2D.new(3, 4)
local v3 = v1:add(v2)
print(v3)  -- Output: 4, 6
```

## Vector3D Class
The Vector3D class represents a 3D vector and provides various methods for vector operations.

### Methods
`new(x, y, z)`: Creates a new Vector3D instance.
`dot(other)`: Computes the dot product with another `Vector3D`.
`cross(other)`: Computes the cross product with another `Vector3D`.
`angleTo(other)`: Computes the angle to another `Vector3D`.
`distanceTo(other)`: Computes the distance to another `Vector3D`.
`lerp(other, t)`: Linearly interpolates between this vector and another `Vector3D`.
`projectOnto(other)`: Projects this vector onto another `Vector3D`.
`reflectAcross(normal)`: Reflects this vector across a given normal.
`magnitude()`: Computes the magnitude of this vector.
`normalize()`: Normalizes this vector.

### Example Usage

```lua
local Vector3D = require("vectors.vector3d")

local v1 = Vector3D.new(1, 2, 3)
local v2 = Vector3D.new(4, 5, 6)
local v3 = v1:add(v2)
print(v3)  -- Output: 5, 7, 9
```

## License

The project is licensed under the MIT license