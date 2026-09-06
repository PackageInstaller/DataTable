-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerStagePrizeView.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerStagePrizeView", package.seeall)

local UltimateWarTowerStagePrizeView = class("UltimateWarTowerStagePrizeView", ViewComponent)

function UltimateWarTowerStagePrizeView:buildUI()
	UltimateWarTowerStagePrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtLevel = self:getTxt("txtLevel")

	local scrView = self:getGo("stageCol/scrView")
	local scrCell = self:getGo("stageCol/scrCell")

	self._itemScrollercell = self:getGo("stageCol/itemScrCell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._stageScrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
end

function UltimateWarTowerStagePrizeView:bindEvents()
	UltimateWarTowerStagePrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function UltimateWarTowerStagePrizeView:unbindEvents()
	UltimateWarTowerStagePrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function UltimateWarTowerStagePrizeView:onEnter()
	UltimateWarTowerStagePrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._towerId = checknumber(params[2])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._towerInfo = self._ultimateWarMo:getTowerInfo(self._towerId)
	self._actData = UltimateWarConfig.instance:getActData(self._activityId)
	self._towerData = UltimateWarConfig.instance:getTowerData(self._activityId, self._towerId)

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarSecondStepInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarNotifyTowerFightRes, self._onUpdate, self)
	self:_onUpdate()
end

function UltimateWarTowerStagePrizeView:onExit()
	UltimateWarTowerStagePrizeView.super.onExit(self)
	self._stageScrollList:dispose()
end

function UltimateWarTowerStagePrizeView:_onUpdate()
	local stageCfg = UltimateWarConfig.instance:getStageCfg(self._activityId, self._towerId)

	self._stageScrollList:reloadData(stageCfg or {})

	local cur, max = self._towerInfo:getMaxPassStageId(), self._towerInfo:getMaxStageCount()

	self._txtLevel.text = string.format("%s/%s", cur, max)
end

function UltimateWarTowerStagePrizeView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local isHasGain = self._towerInfo:isPassStage(stageId)
	local mainGo = cell.gameObject
	local txtStage = goutil.findChildTextComponent(mainGo, "txtStage")
	local imgHasGain = goutil.findChild(mainGo, "imgHasGain")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")

	txtStage.text = string.format("第%d关", data.stageId)

	GameUtil.SetActive(imgHasGain, isHasGain)

	if itemScrView and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrView, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function UltimateWarTowerStagePrizeView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function UltimateWarTowerStagePrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function UltimateWarTowerStagePrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

return UltimateWarTowerStagePrizeView
