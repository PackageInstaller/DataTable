-- chunkname: @/tmp/or_script/lua_compile/foundation/math/Vector.lua

local vector = {}

function vector.make(p1, p2)
	local p_1 = {}

	if p1[1] == nil and p1.x ~= nil then
		p_1[1] = p1.x
	end

	if p1[2] == nil and p1.y ~= nil then
		p_1[2] = p1.y
	end

	if p1[3] == nil and p1.z ~= nil then
		p_1[3] = p1.z
	end

	local p_2 = {}

	if p2[1] == nil and p2.x ~= nil then
		p_2[1] = p2.x
	end

	if p2[2] == nil and p2.y ~= nil then
		p_2[2] = p2.y
	end

	if p2[3] == nil and p2.z ~= nil then
		p_2[3] = p2.z
	end

	local vec = {}

	if p_1[1] and p_1[2] and p_2[1] and p_2[2] then
		vec[1] = p_2[1] - p_1[1]
		vec[2] = p_2[2] - p_1[2]
	end

	if p_1[3] and p_2[3] then
		vec[3] = p_2[3] - p_1[3]
	end

	return vec
end

function vector.radian(vec1, vec2)
	return math.acos(vector.dot(vec1, vec2) / math.sqrt(vector.sqmod(vec1) * vector.sqmod(vec2)))
end

function vector.angle(vec1, vec2)
	local angle = vector.radian(vec1, vec2) * 180 / math.pi

	if vec1[2] > vec2[2] then
		angle = angle * -1
	end

	return angle
end

function vector.dot(vec1, vec2)
	local l = #vec1

	if l > #vec2 then
		l = #vec2
	end

	local t = 0

	for idx = 1, l do
		t = t + vec1[idx] * vec2[idx]
	end

	return t
end

function vector.sqmod(vec)
	local t = 0

	for idx = 1, #vec do
		t = t + vec[idx] * vec[idx]
	end

	return t
end

function vector.mod(vec)
	return math.sqrt(vector.sqmod(vec))
end

vec2 = vector
vec3 = vector
