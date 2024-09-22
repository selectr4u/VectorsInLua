---@class Vector2D
---@field x number
---@field y number
local Vector2D = {}
Vector2D.__index = Vector2D

local epsilon = 1e-10

-- Creates a new Vector2D object.
---@param x number
---@param y number
---@return Vector2D
function Vector2D.new(x, y)
    local self = setmetatable({}, Vector2D)
    self.x = x
    self.y = y
    return self
end

-- Checks if the given parameter is a Vector2D object.
---@param a any
---@return boolean
function Vector2D._checkIfVector(a)
    if type(a) == "number" or type(a) == "string" or type(a) ~= "table" then return false end
    return a.__index == Vector2D
end

function Vector2D.__add(a, b)
    if (Vector2D._checkIfVector(a)) and (Vector2D._checkIfVector(b)) then
        -- they are both vectors
        return Vector2D.new(a.x + b.x, a.y + b.y)
    else
        error("Incompatible types to perform operation on with vector")
    end
end

function Vector2D.__sub(a, b)
    if (Vector2D._checkIfVector(a)) and (Vector2D._checkIfVector(b)) then
        -- they are both vectors
        return Vector2D.new(a.x - b.x, a.y - b.y)
    else
        error("Incompatible types to perform operation on with vector")
    end
end

function Vector2D.__mul(a, b)
    if (Vector2D._checkIfVector(a)) and (type(b) == "number") then
        -- scalar and vector
        return Vector2D.new(a.x * b, a.y * b)
    elseif (Vector2D._checkIfVector(b)) and (type(a) == "number") then
        -- scalar and vector
        return Vector2D.new(b.x * a, b.y * a)
    else
        error("Incompatible types to perform operation on with vector")
    end
end

function Vector2D.__div(a, b)
    if (Vector2D._checkIfVector(a)) and (type(b) == "number") then
        -- scalar and vector
        return Vector2D.new(a.x / b, a.y / b)
    elseif (Vector2D._checkIfVector(b)) and (type(a) == "number") then
        -- scalar and vector
        return Vector2D.new(b.x / a, b.y / a)
    else
        error("Incompatible types to perform operation on with vector")
    end
end

function Vector2D.__eq(a, b)
    local function isCloseEnough(x, y)
        return math.abs(x - y) < epsilon
    end

    if (Vector2D._checkIfVector(a)) and (Vector2D._checkIfVector(b)) then
        return isCloseEnough(a.x, b.x) and isCloseEnough(a.y, b.y)
    else
        return false
    end
end

function Vector2D.__tostring(a)
    return a.x .. ", " .. a.y
end

-- Calculates the dot product of two Vector2D objects.
---@param v1 Vector2D
---@param v2 Vector2D
---@return number
function Vector2D.dotProduct(v1, v2)
    if (Vector2D._checkIfVector(v1)) and (Vector2D._checkIfVector(v2)) then
        return (v1.x * v2.x) + (v1.y * v2.y)
    else
        error("Incompatible types to perform operation on with vectors")
    end
end

-- Calculates the dot product of the current Vector2D object and another.
---@param v2 Vector2D
---@return number
function Vector2D:dot(v2)
    if (Vector2D._checkIfVector(v2)) then
        return (self.x * v2.x) + (self.y * v2.y)
    else
        error("Incompatible types to perform operation on with vectors")
    end
end

-- Calculates the cross product of two Vector2D objects.
---@param v1 Vector2D
---@param v2 Vector2D
---@return number
function Vector2D.crossProduct(v1, v2)
    if (Vector2D._checkIfVector(v1)) and (Vector2D._checkIfVector(v2)) then
        return (v1.x * v2.y) - (v1.y * v2.x)
    else
        error("Incompatible types to perform operation on with vectors")
    end
end

-- Calculates the cross product of the current Vector2D object and another.
---@param v2 Vector2D
---@return number
function Vector2D:cross(v2)
    if (Vector2D._checkIfVector(v2)) then
        return (self.x * v2.y) - (self.y * v2.x)
    else
        error("Incompatible types to perform operation on with vectors")
    end
end

-- Calculates the angle between the current Vector2D object and another.
---@param v2 Vector2D
---@return number
function Vector2D:angleTo(v2)
    local dotProduct = Vector2D.dotProduct(self, v2)
    local v1Magnitude = self:magnitude()
    local v2Magnitude = v2:magnitude()
    local cosTheta = dotProduct / (v1Magnitude * v2Magnitude)
    cosTheta = math.max(-1, math.min(1, cosTheta)) -- clamp bc floating point precision error
    return math.deg(math.acos(cosTheta))
end

-- Projects the current Vector2D object onto another.
---@param v2 Vector2D
---@return Vector2D
function Vector2D:projectOnto(v2)
    local dotProduct = Vector2D.dotProduct(self, v2)
    local projectionScalar = (dotProduct) / v2:magnitude() ^ 2
    return v2 * projectionScalar
end

-- Calculates the distance between the current Vector2D object and another.
---@param v2 Vector2D
---@return number
function Vector2D:distanceTo(v2)
    return math.sqrt((v2.x - self.x) ^ 2 + (v2.y - self.y) ^ 2)
end

-- Linearly interpolates between the current Vector2D object and another.
---@param v2 Vector2D
---@param t number
---@return Vector2D
function Vector2D:lerp(v2, t)
    return Vector2D.new(((1 - t) * self.x) + (t * v2.x), ((1 - t) * self.y) + (t * v2.y))
end

-- Rotates the current Vector2D object by a given angle.
---@param degrees number
---@return Vector2D
function Vector2D:rotateByAngle(degrees)
    local radians = math.rad(degrees)
    local x = (self.x * math.cos(radians)) - (self.y * math.sin(radians))
    local y = (self.x * math.sin(radians)) + (self.y * math.cos(radians))
    return Vector2D.new(x, y)
end

-- Reflects the current Vector2D object across a given normal.
---@param normal Vector2D
---@return Vector2D
function Vector2D:reflectAcross(normal)
    local dotProduct = Vector2D.dotProduct(self, normal)
    return Vector2D.new(self.x - 2 * dotProduct * normal.x, self.y - 2 * dotProduct * normal.y)
end

-- Calculates the magnitude of the current Vector2D object.
---@return number
function Vector2D:magnitude()
    return math.sqrt((self.x ^ 2) + (self.y ^ 2))
end

-- Normalizes the current Vector2D object.
---@return Vector2D
function Vector2D:normalise()
    local magnitude = self:magnitude()
    return Vector2D.new(self.x / magnitude, self.y / magnitude)
end

return Vector2D
