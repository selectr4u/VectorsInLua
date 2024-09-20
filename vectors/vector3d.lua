local Vector3D = {}
Vector3D.__index = Vector3D

local epsilon = 1e-10

function Vector3D.new(x, y, z)
    local self = setmetatable({}, Vector3D)
    self.x = x
    self.y = y
    self.z = z
    return self
end

function Vector3D._checkIfVector(a)
    if type(a) == "number" or type(a) == "string" or type(a) ~= "table" then return false end
    return a.__index == Vector3D
end

function Vector3D.__add(a, b)
    if (Vector3D._checkIfVector(a)) and (Vector3D._checkIfVector(b)) then
        -- they are both vectors
        return Vector3D.new(a.x + b.x, a.y + b.y, a.z + b.z)
    else
        error("Incompatible types to perform operation on with vector")
    end
end

function Vector3D.__sub(a, b)
    if (Vector3D._checkIfVector(a)) and (Vector3D._checkIfVector(b)) then
        -- they are both vectors
        return Vector3D.new(a.x - b.x, a.y - b.y, a.z - b.z)
    else
        error("Incompatible types to perform operation on with vector")
    end
end

function Vector3D.__mul(a, b)
    if (Vector3D._checkIfVector(a)) and (type(b) == "number") then
        -- scalar and vector
        return Vector3D.new(a.x * b, a.y * b, a.z * b)
    elseif (Vector3D._checkIfVector(b)) and (type(a) == "number") then
        -- scalar and vector
        return Vector3D.new(b.x * a, b.y * a, b.z * a)
    else
        error("Incompatible types to perform operation on with vector")
    end
end

function Vector3D.__div(a, b)
    if (Vector3D._checkIfVector(a)) and (type(b) == "number") then
        -- scalar and vector
        return Vector3D.new(a.x / b, a.y / b, a.z / b)
    elseif (Vector3D._checkIfVector(b)) and (type(a) == "number") then
        -- scalar and vector
        return Vector3D.new(b.x / a, b.y / a, b.z / a)
    else
        error("Incompatible types to perform operation on with vector")
    end
end

function Vector3D.__eq(a, b)
    local function isCloseEnough(x, y)
        return math.abs(x - y) < epsilon
    end

    if (Vector3D._checkIfVector(a)) and (Vector3D._checkIfVector(b)) then
        return isCloseEnough(a.x, b.x) and isCloseEnough(a.y, b.y) and isCloseEnough(a.z, b.z)
    else
        return false
    end
end

function Vector3D.__tostring(a)
    return a.x .. ", " .. a.y .. ", " .. a.z
end

function Vector3D.dotProduct(v1, v2)
    if (Vector3D._checkIfVector(v1)) and (Vector3D._checkIfVector(v2)) then
        return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z)
    else
        error("Incompatible types to perform operation on with vectors")
    end
end

-- supporting this sort of style as well where its a method of the class
function Vector3D:dot(v2)
    if (Vector3D._checkIfVector(v2)) then
        return (self.x * v2.x) + (self.y * v2.y) + (self.z * v2.z)
    else
        error("Incompatible types to perform operation on with vectors")
    end
end

function Vector3D.crossProduct(v1, v2)
    if (Vector3D._checkIfVector(v1)) and (Vector3D._checkIfVector(v2)) then
        local cx = (v1.y * v2.z) - (v1.z * v2.y)
        local cy = (v1.z * v2.x) - (v1.x * v2.z)
        local cz = (v1.x * v2.y) - (v1.y * v2.x)
        return Vector3D.new(cx, cy, cz)
    else
        error("Incompatible types to perform operation on with vectors")
    end
end

-- supporting this sort of style as well where its a method of the class
function Vector3D:cross(v2)
    if (Vector3D._checkIfVector(v2)) then
        local cx = (self.y * v2.z) - (self.z * v2.y)
        local cy = (self.z * v2.x) - (self.x * v2.z)
        local cz = (self.x * v2.y) - (self.y * v2.x)
        return Vector3D.new(cx, cy, cz)
    else
        error("Incompatible types to perform operation on with vectors")
    end
end

function Vector3D:angleTo(v2)
    local dotProduct = Vector3D.dotProduct(self, v2)
    local v1Magnitude = self:magnitude()
    local v2Magnitude = v2:magnitude()
    return math.deg(math.acos(dotProduct / (math.abs(v1Magnitude) * math.abs(v2Magnitude))))
end

function Vector3D:distanceTo(v2)
    return math.sqrt((v2.x - self.x) ^ 2 + (v2.y - self.y) ^ 2 + (v2.z - self.z) ^ 2)
end

function Vector3D:lerp(v2, t)
    return Vector3D.new(((1 - t) * self.x) + (t * v2.x), ((1 - t) * self.y) + (t * v2.y), ((1 - t) * self.z) + (t * v2.z))
end

function Vector3D:projectOnto(v2)
    local dotProduct = Vector3D.dotProduct(self, v2)
    return (dotProduct / v2:magnitude() ^ 2) * v2
end

function Vector3D:reflectAcross(normal)
    local dotProduct = Vector3D.dotProduct(self, normal)
    return Vector3D.new(self.x - 2 * dotProduct * normal.x, self.y - 2 * dotProduct * normal.y,
        self.z - 2 * dotProduct * normal.z)
end

function Vector3D:magnitude()
    return math.sqrt((self.x ^ 2) + (self.y ^ 2) + (self.z ^ 2))
end

function Vector3D:normalise()
    local magnitude = self:magnitude()
    return Vector3D.new(self.x / magnitude, self.y / magnitude, self.z / magnitude)
end

return Vector3D
