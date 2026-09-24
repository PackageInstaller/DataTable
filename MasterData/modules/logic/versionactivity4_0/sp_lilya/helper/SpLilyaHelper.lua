-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/helper/SpLilyaHelper.lua

module("modules.logic.versionactivity4_0.sp_lilya.helper.SpLilyaHelper", package.seeall)

local SpLilyaHelper = _M

function SpLilyaHelper.ConvertOriginPos(x, y, halfWidth, halfHeight)
	halfWidth = halfWidth or 0
	halfHeight = halfHeight or 0

	return x - halfWidth, y - halfHeight
end

return SpLilyaHelper
