-- chunkname: @modules/logic/tips/controller/FightDeviceCardTipController.lua

module("modules.logic.tips.controller.FightDeviceCardTipController", package.seeall)

local FightDeviceCardTipController = class("FightDeviceCardTipController", BaseController)

function FightDeviceCardTipController:onInit()
	return
end

FightDeviceCardTipController.Pivot = {
	TopLeft = Vector2.New(0, 1),
	TopCenter = Vector2.New(0.5, 1),
	TopRight = Vector2.New(1, 1),
	CenterLeft = Vector2.New(0, 0.5),
	Center = Vector2.New(0.5, 0.5),
	CenterRight = Vector2.New(1, 0.5),
	BottomLeft = Vector2.New(0, 0),
	BottomCenter = Vector2.New(0.5, 0),
	BottomRight = Vector2.New(1, 0)
}
FightDeviceCardTipController.OpenType = {
	DeviceSkillInfo = 1,
	DeviceInfo = 2
}

local TempParam = {}

function FightDeviceCardTipController:openCommonView(deviceSkillInfo, entityUid, screenPos, anchorMinAndMax, pivot, offsetPosX, offsetPosY, ignoreClick)
	TempParam.openType = FightDeviceCardTipController.OpenType.DeviceSkillInfo
	TempParam.deviceSkillInfo = deviceSkillInfo
	TempParam.entityUid = entityUid
	TempParam.screenPos = screenPos
	TempParam.anchorMinAndMax = anchorMinAndMax or FightDeviceCardTipController.Pivot.TopLeft
	TempParam.pivot = pivot or FightDeviceCardTipController.Pivot.TopLeft
	TempParam.offsetPosX = offsetPosX or 0
	TempParam.offsetPosY = offsetPosY or 0
	TempParam.ignoreClick = ignoreClick

	ViewMgr.instance:openView(ViewName.FightDeviceCardTipView, TempParam)
end

function FightDeviceCardTipController:openCommonViewByDeviceInfo(deviceInfo, screenPos, anchorMinAndMax, pivot, offsetPosX, offsetPosY, ignoreClick)
	if not deviceInfo then
		return
	end

	TempParam.openType = FightDeviceCardTipController.OpenType.DeviceInfo
	TempParam.deviceInfo = deviceInfo
	TempParam.entityUid = deviceInfo.uid
	TempParam.screenPos = screenPos
	TempParam.anchorMinAndMax = anchorMinAndMax or FightDeviceCardTipController.Pivot.TopLeft
	TempParam.pivot = pivot or FightDeviceCardTipController.Pivot.TopLeft
	TempParam.offsetPosX = offsetPosX or 0
	TempParam.offsetPosY = offsetPosY or 0
	TempParam.ignoreClick = ignoreClick

	ViewMgr.instance:openView(ViewName.FightDeviceCardTipView, TempParam)
end

FightDeviceCardTipController.instance = FightDeviceCardTipController.New()

return FightDeviceCardTipController
