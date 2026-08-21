-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsHardSetPosComp.lua

module("logic.extensions.tooltips.component.ToolTipsHardSetPosComp", package.seeall)

local M = class("ToolTipsHardSetPosComp", ViewComponent)

function M:onEnter()
	local info = self:getFirstParam()
	local posX, posY, posZ = info.posX, info.posY, info.posZ
	local pivotX, pivotY = info.pivotX, info.pivotY

	if pivotX and pivotY then
		RectTransformUtils.SetPivot(self.mainGO.transform, pivotX, pivotY)
	end

	if info.popType == CommEnum.TipsPopType.Top then
		RectTransformUtils.SetPivot(self.mainGO.transform, 0, 0)
	elseif info.popType == CommEnum.TipsPopType.Bottom then
		RectTransformUtils.SetPivot(self.mainGO.transform, 0, 1)
	elseif info.popType == CommEnum.TipsPopType.Left then
		RectTransformUtils.SetPivot(self.mainGO.transform, 1, 0.5)
	end

	Astral.TransformUtil.SetPos(self.mainGO.transform, posX, posY, posZ)
	GlobalDispatcher:dispatchEvent(EventType.TIPS_CHANGE_ENABLE_EVENT, true, self._viewPresentor:getViewName())
end

return M
