-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionExtResultView.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionExtResultView", package.seeall)

local OriginLightDimensionExtResultView = class("OriginLightDimensionExtResultView", ViewComponent)

function OriginLightDimensionExtResultView:ctor()
	OriginLightDimensionExtResultView.super.ctor(self)
end

function OriginLightDimensionExtResultView:unbindEvents()
	OriginLightDimensionExtResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function OriginLightDimensionExtResultView:bindEvents()
	OriginLightDimensionExtResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function OriginLightDimensionExtResultView:buildUI()
	OriginLightDimensionExtResultView.super.buildUI(self)

	self._tableCell = self:getGo("tableCell")
	self._tableView = self:getGo("tableView")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableList:setCenterMode(true)

	self._btnSure = self:getGo("btnSure")
	self._empty = self:getGo("empty")
	self._btnCancel = self:getGo("btnCancel")
	self._imgResult1 = self:getGo("imgResult1")
	self._imgChangeResult1 = self._imgResult1:GetComponent(ComponentType.UIImageSpriteChange)
	self._imgResult2 = self:getGo("imgResult2")
	self._imgChangeResult2 = self._imgResult2:GetComponent(ComponentType.UIImageSpriteChange)
	self._txtCondition_2 = self:getTxt("txtCondition_2")
	self._txtCondition_1 = self:getTxt("txtCondition_1")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtBuffType = self:getTxt("txtBuffType")
end

function OriginLightDimensionExtResultView:onExit()
	OriginLightDimensionExtResultView.super.onExit(self)
end

function OriginLightDimensionExtResultView:onEnter()
	OriginLightDimensionExtResultView.super.onEnter(self)

	local resultInfo = OriginLightDimensionModel.instance:getExtClgResult()

	self._imgChangeResult1:SetState(resultInfo.isWin ~= true and 1 or 0)

	local extCfg = OriginLightDimensionConfig.instance:getExtremeStageCfg(resultInfo.activityId, resultInfo.stageId)
	local isReachBuffTime = resultInfo.buffActivate >= extCfg.activateCount

	self._imgChangeResult2:SetState(not isReachBuffTime and 1 or 0)

	local activityCount = math.max(resultInfo.buffActivate, 0)

	self._txtCondition_2.text = langPara("空间次数≥%s（<color=%s>%s</color>/%s）", extCfg.activateCount, (isReachBuffTime or nil) and (GameEnum.ColorConst.Green or GameEnum.ColorConst.Red), activityCount, extCfg.activateCount)
	self._txtTitle.text = resultInfo.isPass == true and lang("挑战成功") or lang("挑战失败")

	if not resultInfo.lockRaceIds then
		local lockPetList = {}

		GameUtil.SetActive(self._empty, #lockPetList == 0 or resultInfo.isPass ~= true)

		local buffCfg = OriginLightDimensionConfig.instance:getExtremeBuffCfg(resultInfo.activityId, resultInfo.lastBuff)

		self._txtBuffType.text = buffCfg and langPara("当前激活：%s·<color=#EB4642>%s</color>", buffCfg.name, resultInfo.buffActivate) or lang("当前激活：无")

		self._tableList:reloadData(lockPetList)
	end
end

function OriginLightDimensionExtResultView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function OriginLightDimensionExtResultView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function OriginLightDimensionExtResultView:_onClickSure()
	BattleController.instance:endBattle()
end

function OriginLightDimensionExtResultView:_onClickCancel()
	BattleController.instance:endBattle()
end

return OriginLightDimensionExtResultView
