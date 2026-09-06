-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTabChildRankAreaEnergyView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTabChildRankAreaEnergyView", package.seeall)

local GodStatuesWarTabChildRankAreaEnergyView = class("GodStatuesWarTabChildRankAreaEnergyView", ViewComponent)

function GodStatuesWarTabChildRankAreaEnergyView:buildUI()
	GodStatuesWarTabChildRankAreaEnergyView.super.buildUI(self)

	local rankScrView = goutil.findChild(self.mainGO, "rankCol/rankScrView")
	local rankScrCell = goutil.findChild(self.mainGO, "rankCol/rankScrCell")

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._emptyGo_txt = goutil.findChildTextComponent(self.mainGO, "rankCol/emptyGo/txt")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "myRank/txtMyRank")
	self._energy_txt = goutil.findChildTextComponent(self.mainGO, "myRank/energy/txt")
end

function GodStatuesWarTabChildRankAreaEnergyView:bindEvents()
	GodStatuesWarTabChildRankAreaEnergyView.super.bindEvents(self)
end

function GodStatuesWarTabChildRankAreaEnergyView:unbindEvents()
	GodStatuesWarTabChildRankAreaEnergyView.super.unbindEvents(self)
end

function GodStatuesWarTabChildRankAreaEnergyView:onEnter()
	GodStatuesWarTabChildRankAreaEnergyView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self._zoneId = GodStatuesWarController.instance:getMyZoneId(self._seasonId)

	if self._zoneId == nil then
		printError(string.format("缺失战区配置( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleRankViewRes, self._onUpdate, self)
	GodStatuesWarController.instance:sendPM_NewFamilyBattleRankViewReq(self._seasonId)
end

function GodStatuesWarTabChildRankAreaEnergyView:onExit()
	GodStatuesWarTabChildRankAreaEnergyView.super.onExit(self)
	self:_onClear()
end

function GodStatuesWarTabChildRankAreaEnergyView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateRuleColUI()
end

function GodStatuesWarTabChildRankAreaEnergyView:_onClear()
	self:_onClearRuleCol()
end

function GodStatuesWarTabChildRankAreaEnergyView:_onUpdateData()
	self._msg = GodStatuesWarController.instance:getRankViewResMsg(self._seasonId)
	self._rankInfos = self._msg.rankInfo or {}
	self._myFamilyRank = self._msg.myFamilyRank
	self._myFamilyEnergy = self._msg.myFamilyEnergy
end

function GodStatuesWarTabChildRankAreaEnergyView:_onUpdateRuleColUI()
	self._txtMyRank.text = self._myFamilyRank > 0 and self._myFamilyRank or "未上榜"
	self._energy_txt.text = self._myFamilyEnergy

	self._rankScrollList:reloadData(self._rankInfos)

	local isEmpty = #self._rankInfos <= 0

	GameUtil.SetActive(self._emptyGo, isEmpty)
end

function GodStatuesWarTabChildRankAreaEnergyView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function GodStatuesWarTabChildRankAreaEnergyView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local rank = info.rank
	local areaName = info.areaName
	local energy = info.energy
	local familyName = info.familyName
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtName.text = familyName
	txtArea.text = areaName
	txtScore.text = energy
end

function GodStatuesWarTabChildRankAreaEnergyView:_clearRankCell(cell)
	return
end

return GodStatuesWarTabChildRankAreaEnergyView
