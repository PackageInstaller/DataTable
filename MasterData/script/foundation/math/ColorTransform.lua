-- chunkname: @/tmp/or_script/lua_compile/foundation/math/ColorTransform.lua

function ColorTransform(r, g, b, a, offr, offg, offb, offa)
	return {
		mults = {
			x = r or 1,
			y = g or 1,
			z = b or 1,
			w = a or 1
		},
		offsets = {
			x = offr or 0,
			y = offg or 0,
			z = offb or 0,
			w = offa or 0
		}
	}
end

function ctIsIdentity(ct)
	local mults = ct.mults
	local offsets = ct.offsets

	return mults.x == 1 and mults.y == 1 and mults.z == 1 and mults.w == 1 and offsets.x == 0 and offsets.y == 0 and offsets.z == 0 and offsets.w == 0
end
