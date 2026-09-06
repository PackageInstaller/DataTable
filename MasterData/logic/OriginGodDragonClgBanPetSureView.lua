-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgBanPetSureView.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgBanPetSureView", package.seeall)

local OriginGodDragonClgBanPetSureView = class("OriginGodDragonClgBanPetSureView", ViewComponent)

function OriginGodDragonClgBanPetSureView:buildUI()
	OriginGodDragonClgBanPetSureView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTips = self:getTxt("tips/txt")

	local curPetScrView = self:getGo("curPet/scrView")
	local curPetScrCell = self:getGo("curPet/scrCell")

	self._curPetScrollerList = ScrollerList.create(curPetScrView, curPetScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	local oldPetScrView = self:getGo("oldPet/scrView")
	local oldPetScrCell = self:getGo("oldPet/scrCell")

	self._oldPetScrollerList = ScrollerList.create(oldPetScrView, oldPetScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function OriginGodDragonClgBanPetSureView:bindEvents()
	OriginGodDragonClgBanPetSureView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function OriginGodDragonClgBanPetSureView:unbindEvents()
	OriginGodDragonClgBanPetSureView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginGodDragonClgBanPetSureView:onEnter()
	OriginGodDragonClgBanPetSureView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._subMo = OriginGodDragonClgController.instance:getSubMo(self._activityId)

	local stageData = OriginGodDragonClgConfig.instance:getStageData(self._activityId, self._stageId)

	self._zoneId = stageData.zoneId

	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonClgConfirmRes, self._handlePM_OriginGodDragonClgConfirmRes, self)
	self:_onUpdate()
end

function OriginGodDragonClgBanPetSureView:onExit()
	OriginGodDragonClgBanPetSureView.super.onExit(self)
	self._curPetScrollerList:dispose()
	self._oldPetScrollerList:dispose()
	BattleController.instance:endBattle()
end

function OriginGodDragonClgBanPetSureView:_handlePM_OriginGodDragonClgConfirmRes()
	self:close()
end

function OriginGodDragonClgBanPetSureView:_onUpdate()
	local fightResultMsg = self._subMo:getFightResultMsg()

	if fightResultMsg then
		if not fightResultMsg.lockRaceIds then
			local curLockRaceIds = {}
			local oldLockRaceIds = self._subMo:getLockRaceIds(self._stageId)

			self._curPetMoList = {}

			for _, raceId in ipairs(curLockRaceIds) do
				local petMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

				table.insert(self._curPetMoList, petMo)
			end

			self._oldPetMoList = {}

			for _, raceId in ipairs(oldLockRaceIds) do
				local petMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

				table.insert(self._oldPetMoList, petMo)
			end

			self._curPetScrollerList:reloadData(self._curPetMoList)
			self._oldPetScrollerList:reloadData(self._oldPetMoList)
		end
	end
end

function OriginGodDragonClgBanPetSureView:_updatePetCell(view, cell, petMo, tag)
	local skinId = petMo.curFaceId
	local mainGo = cell.gameObject
	local mask = goutil.findChild(mainGo, "mask")
	local con = goutil.findChild(mainGo, "mask/con")

	MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
	GameUtil.addClickHandler(mask, function()
		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)
end

function OriginGodDragonClgBanPetSureView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local mask = goutil.findChild(mainGo, "mask")
	local con = goutil.findChild(mainGo, "mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(mask)
end

function OriginGodDragonClgBanPetSureView:_onClickCancel()
	OriginGodDragonClgController.instance:sendPM_OriginGodDragonClgConfirmReq(self._activityId, self._zoneId, self._stageId, false)
end

function OriginGodDragonClgBanPetSureView:_onClickSure()
	OriginGodDragonClgController.instance:sendPM_OriginGodDragonClgConfirmReq(self._activityId, self._zoneId, self._stageId, true)
end

return OriginGodDragonClgBanPetSureView
