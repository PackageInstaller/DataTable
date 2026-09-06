-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/view/OriginKingCiYuanDragonClgSurePopView.lua

module("logic.extensions.originkingciyuandragonclg.view.OriginKingCiYuanDragonClgSurePopView", package.seeall)

local OriginKingCiYuanDragonClgSurePopView = class("OriginKingCiYuanDragonClgSurePopView", ViewComponent)

function OriginKingCiYuanDragonClgSurePopView:buildUI()
	OriginKingCiYuanDragonClgSurePopView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._btnClose = self:getGo("btnClose")
	self._txtDesc = self:getTxt("txtDesc ")
	self._txtProgress = self:getTxt("txtProgress")
	self._txtBuff = self:getTxt("txtBuff")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function OriginKingCiYuanDragonClgSurePopView:bindEvents()
	OriginKingCiYuanDragonClgSurePopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginKingCiYuanDragonClgSurePopView:unbindEvents()
	OriginKingCiYuanDragonClgSurePopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginKingCiYuanDragonClgSurePopView:onEnter()
	OriginKingCiYuanDragonClgSurePopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]
	self._subMo = OriginKingCiYuanDragonClgController.instance:getSubMo(self._activityId)

	local msg = self._subMo:getFightResultMsg()

	self._stageId = msg.stageId or 0

	local stageData = OriginKingCiYuanDragonClgConfig.instance:getStageData(self._activityId, self._stageId)

	if stageData then
		if not stageData.blockId then
			local blockId = 0

			self.addGEvent(self, GlobalNotify.HandlePM_OriginKingCiYuanDragonClgConfirmRes, self._handlePM_OriginKingCiYuanDragonClgConfirmRes, self)

			if not msg.lockRaceIds then
				self._petScrollerList:reloadData(msg.lockRaceIds)

				local stageCount = self._subMo:getStageCount(blockId)

				self._txtProgress.text = string.format("修复进度：+%d%%", 1 / stageCount * 100)
				self._txtBuff.text = string.format("修复影响：%s", stageData and stageData.buffDesc)
			end
		end
	end
end

function OriginKingCiYuanDragonClgSurePopView:onExit()
	OriginKingCiYuanDragonClgSurePopView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginKingCiYuanDragonClgSurePopView:_handlePM_OriginKingCiYuanDragonClgConfirmRes(status, msg)
	BattleController.instance:endBattle()
end

function OriginKingCiYuanDragonClgSurePopView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, item)

	if proxy then
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)

		local function func()
			CommonTipsMgr.instance:showPetTips(tmpMo, true)
		end

		proxy.binder:setClickCallBack(func)
	end
end

function OriginKingCiYuanDragonClgSurePopView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function OriginKingCiYuanDragonClgSurePopView:_onClickBtnSure()
	OriginKingCiYuanDragonClgController.instance:sendPM_OriginKingCiYuanDragonClgConfirmReq(self._activityId, self._stageId)
end

function OriginKingCiYuanDragonClgSurePopView:_onClickBtnCancel()
	BattleController.instance:endBattle()
end

return OriginKingCiYuanDragonClgSurePopView
