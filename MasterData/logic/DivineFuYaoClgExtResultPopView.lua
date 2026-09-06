-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/view/DivineFuYaoClgExtResultPopView.lua

module("logic.extensions.divinefuyaoclg.view.DivineFuYaoClgExtResultPopView", package.seeall)

local DivineFuYaoClgExtResultPopView = class("DivineFuYaoClgExtResultPopView", ViewComponent)

function DivineFuYaoClgExtResultPopView:buildUI()
	DivineFuYaoClgExtResultPopView.super.buildUI(self)

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
end

function DivineFuYaoClgExtResultPopView:bindEvents()
	DivineFuYaoClgExtResultPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, GameUtil.handler(self._onClickBtnSure, self, true))
	GameUtil.addClickHandler(self._btnCancel, GameUtil.handler(self._onClickBtnSure, self, false))
end

function DivineFuYaoClgExtResultPopView:unbindEvents()
	DivineFuYaoClgExtResultPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function DivineFuYaoClgExtResultPopView:onEnter()
	DivineFuYaoClgExtResultPopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1]
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
	self._subMo = DivineFuYaoClgController.instance:getSubMo(self._activityId)

	local msg = self._subMo:getExtremeFinishMsg()
	local lockRaceIds = msg.lockRaceIds
	local formationMo = self._fmtMo:getCurFormation()
	local positions = formationMo:GetPositions()

	self._petMoMap = {}

	for posId, petId in pairs(positions) do
		if posId > 0 and petId > 0 then
			local petMo = formationMo:_getPet(petId)

			if petMo then
				self._petMoMap[petMo:getDefineId()] = petMo
			end
		end
	end

	self._petScrollerList:reloadData(lockRaceIds)
	GameUtil.SetActive(self._imgEmpty, #lockRaceIds <= 0)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineFuYaoClgExtremeConfirmRes, self._handlePM_DivineFuYaoClgExtremeConfirmRes, self)
end

function DivineFuYaoClgExtResultPopView:onExit()
	DivineFuYaoClgExtResultPopView.super.onExit(self)
	self._petScrollerList:dispose()
end

function DivineFuYaoClgExtResultPopView:_handlePM_DivineFuYaoClgExtremeConfirmRes(status, msg)
	self:close()
	BattleController.instance:endBattle()
end

function DivineFuYaoClgExtResultPopView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local tmpMo = self._petMoMap[raceId]
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, item)

	if proxy and tmpMo then
		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(tmpMo, false)
		end)
	end
end

function DivineFuYaoClgExtResultPopView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function DivineFuYaoClgExtResultPopView:_onClickBtnSure(isSave)
	DivineFuYaoClgController.instance:sendPM_DivineFuYaoClgExtremeConfirmReq(self._activityId, self._stageId, isSave)
end

return DivineFuYaoClgExtResultPopView
