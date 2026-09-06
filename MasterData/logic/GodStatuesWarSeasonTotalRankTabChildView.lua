-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonTotalRankTabChildView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonTotalRankTabChildView", package.seeall)

local GodStatuesWarSeasonTotalRankTabChildView = class("GodStatuesWarSeasonTotalRankTabChildView", ViewComponent)

function GodStatuesWarSeasonTotalRankTabChildView:buildUI()
	GodStatuesWarSeasonTotalRankTabChildView.super.buildUI(self)

	local rankScrView = goutil.findChild(self.mainGO, "rankCol/rankScrView")
	local rankScrCell = goutil.findChild(self.mainGO, "rankCol/rankScrCell")

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._emptyGo_txt = goutil.findChildTextComponent(self.mainGO, "rankCol/emptyGo/txt")
end

function GodStatuesWarSeasonTotalRankTabChildView:bindEvents()
	GodStatuesWarSeasonTotalRankTabChildView.super.bindEvents(self)
end

function GodStatuesWarSeasonTotalRankTabChildView:unbindEvents()
	GodStatuesWarSeasonTotalRankTabChildView.super.unbindEvents(self)
end

function GodStatuesWarSeasonTotalRankTabChildView:onEnter()
	GodStatuesWarSeasonTotalRankTabChildView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._rankType = params[2]

	local isInTime = FamilyWarController.instance:isInSeasonTimeOfNfsRank(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d | export_赛季配置 | j家族赛季榜(新) )", self._seasonId))
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.handlePM_FamilySeasonRankViewNewRankRes, self._onUpdate, self)
	FamilyWarController.instance:sendPM_FamilySeasonRankViewNewRankReq(self._rankType, self._seasonId)
end

function GodStatuesWarSeasonTotalRankTabChildView:onExit()
	GodStatuesWarSeasonTotalRankTabChildView.super.onExit(self)
	self:_onClear()
end

function GodStatuesWarSeasonTotalRankTabChildView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateRuleColUI()
end

function GodStatuesWarSeasonTotalRankTabChildView:_onClear()
	self:_onClearRuleCol()
end

function GodStatuesWarSeasonTotalRankTabChildView:_onUpdateData()
	self._msg = FamilySeasonRankModel.instance:getNfsNewMsg()
	self._rankInfos = self._msg.rankInfos or {}
end

function GodStatuesWarSeasonTotalRankTabChildView:_onUpdateRuleColUI()
	self._rankScrollList:reloadData(self._rankInfos)

	local isEmpty = #self._rankInfos <= 0

	GameUtil.SetActive(self._emptyGo, isEmpty)
end

function GodStatuesWarSeasonTotalRankTabChildView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function GodStatuesWarSeasonTotalRankTabChildView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local rank = info.rank
	local familyIconId = info.familyIconId
	local familyName = info.familyName
	local cheifName = info.cheifName
	local areaName = info.areaName
	local score = info.score
	local imgPetIcon = goutil.findChild(mainGo, "imgPetIcon")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtFamilyName = goutil.findChildTextComponent(mainGo, "txtFamilyName")
	local txtPlayerName = goutil.findChildTextComponent(mainGo, "txtPlayerName")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	GameUtil.setUIImageSpriteIdx(imgPetIcon, familyIconId)

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtFamilyName.text = familyName
	txtArea.text = areaName
	txtPlayerName.text = cheifName
	txtScore.text = score
end

function GodStatuesWarSeasonTotalRankTabChildView:_clearRankCell(cell)
	return
end

return GodStatuesWarSeasonTotalRankTabChildView
