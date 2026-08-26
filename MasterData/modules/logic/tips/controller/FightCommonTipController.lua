-- chunkname: @modules/logic/tips/controller/FightCommonTipController.lua

module("modules.logic.tips.controller.FightCommonTipController", package.seeall)

local FightCommonTipController = class("FightCommonTipController", BaseController)

function FightCommonTipController:onInit()
	return
end

FightCommonTipController.Pivot = {
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

local TempParam = {}

function FightCommonTipController:openCommonView(title, desc, screenPos, anchorMinAndMax, pivot, offsetPosX, offsetPosY, ignoreClick)
	TempParam.title = title
	TempParam.desc = desc
	TempParam.screenPos = screenPos
	TempParam.anchorMinAndMax = anchorMinAndMax or FightCommonTipController.Pivot.TopLeft
	TempParam.pivot = pivot or FightCommonTipController.Pivot.TopLeft
	TempParam.offsetPosX = offsetPosX or 0
	TempParam.offsetPosY = offsetPosY or 0
	TempParam.ignoreClick = ignoreClick

	ViewMgr.instance:openView(ViewName.FightCommonTipView, TempParam)
end

FightCommonTipController.instance = FightCommonTipController.New()

return FightCommonTipController
