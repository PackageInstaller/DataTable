-- chunkname: @/tmp/or_script/lua_compile/foundation/math/Matrix.lua

local matrix4x4 = {}

function matrix4x4.transformPoint(m, pt)
	if not pt.x then
		if not pt.y then
			local py = 0

			if not pt.z then
				local pz = 0

				if not pt.w then
					local pw = 1

					return {
						x = pt.x * m[1] + py * m[5] + pz * m[9] + pw * m[13],
						y = pt.x * m[2] + py * m[6] + pz * m[10] + pw * m[14],
						z = pt.x * m[3] + py * m[7] + pz * m[11] + pw * m[15],
						w = pt.x * m[4] + py * m[8] + pz * m[12] + pw * m[16]
					}
				end
			end
		end
	end
end

function matrix4x4.transformVector(m, vec)
	local v1 = vec[1]
	local v2 = vec[2]
	local v3 = vec[3]
	local v4 = vec[4]

	return {
		v1 * m[1] + v2 * m[5] + v3 * m[9] + v4 * m[13],
		v1 * m[2] + v2 * m[6] + v3 * m[10] + v4 * m[14],
		v1 * m[3] + v2 * m[7] + v3 * m[11] + v4 * m[15],
		v1 * m[4] + v2 * m[8] + v3 * m[12] + v4 * m[16]
	}
end

mat4 = matrix4x4
