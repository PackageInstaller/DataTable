-- chunkname: @modules/common/others/FrameworkExtend.lua

module("modules.common.others.FrameworkExtend", package.seeall)

local FrameworkExtend = class("FrameworkExtend", LuaCompBase)

function FrameworkExtend.init()
	UILayerName.PopUpSecond = "POPUP_SECOND"
	UILayerName.PopUpBlur = "POPUPBlur"
end

return FrameworkExtend
