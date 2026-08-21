-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/modalmask/ModalMask.lua

module("logic.common.viewlib.modalmask.ModalMask", package.seeall)

local kMaskRoot = PoolRootUtil.createUIPoolRoot("Masks")
local M = class("ModalMask")

M.maskRoot = kMaskRoot

function M.addEmptyMask(mainGO)
	local mask = EmptyMaskImpl:createInstance()

	mask:setBackgroundMask(mainGO)

	return mask
end

function M.addBlackMask(mainGO, colorStr)
	local mask = BlackMaskImpl:createInstance()

	mask:setBackgroundMask(mainGO)
	mask:setColor(colorStr)

	return mask
end

function M.releaseMask(mask)
	if mask then
		mask:returnSelf()
	end
end

function M.internal_setFullScreen(mainGO)
	local transform = mainGO.transform

	RectTransformUtils.SetAnchorMin(transform, 0, 0)
	RectTransformUtils.SetAnchorMax(transform, 1, 1)
	RectTransformUtils.SetOffset(transform, -150, -150, 150, 150)
end

return M
