-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTabChildRankFamilyView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTabChildRankFamilyView", package.seeall)

local GodStatuesWarTabChildRankFamilyView = class("GodStatuesWarTabChildRankFamilyView", ViewComponent)

function GodStatuesWarTabChildRankFamilyView:buildUI()
	GodStatuesWarTabChildRankFamilyView.super.buildUI(self)

	local rankScrView = goutil.findChild(self.mainGO, "rankCol/rankScrView")
	local rankScrCell = goutil.findChild(self.mainGO, "rankCol/rankScrCell")

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._emptyGo_txt = goutil.findChildTextComponent(self.mainGO, "rankCol/emptyGo/txt")
end

function GodStatuesWarTabChildRankFamilyView:bindEvents()
	GodStatuesWarTabChildRankFamilyView.super.bindEvents(self)
end

function GodStatuesWarTabChildRankFamilyView:unbindEvents()
	GodStatuesWarTabChildRankFamilyView.super.unbindEvents(self)
end

function GodStatuesWarTabChildRankFamilyView:onEnter()
	GodStatuesWarTabChildRankFamilyView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarMapRes, self._onUpdate, self)
	GodStatuesWarController.instance:sendPM_NewFamilyBattleGetDivinePillarMapReq(self._seasonId)
end

function GodStatuesWarTabChildRankFamilyView:onExit()
	GodStatuesWarTabChildRankFamilyView.super.onExit(self)
	self:_onClear()
end

function GodStatuesWarTabChildRankFamilyView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateRuleColUI()
end

function GodStatuesWarTabChildRankFamilyView:_onClear()
	self:_onClearRuleCol()
end

function GodStatuesWarTabChildRankFamilyView:_onUpdateData()
	self._rankInfoList = {}

	local pillarEntryCfg = GodStatuesWarConfig.instance:getNfbPillarEntryCfg(self._seasonId)

	if pillarEntryCfg then
		for _, data in ipairs(pillarEntryCfg) do
			local pillarId = data.pillarId

			if not GodStatuesWarController.instance:isEmptyPillar(self._seasonId, pillarId) then
				local info = {}

				info.pillarId = pillarId
				info.familyId = GodStatuesWarController.instance:getFamilyIdInGroup(self._seasonId, pillarId)
				info.energy = GodStatuesWarController.instance:getEnergyInGroup(self._seasonId, pillarId)
				info.energy = checknumber(info.energy)
				info.totalZdl = GodStatuesWarController.instance:getTotalZdlInGroup(self._seasonId, pillarId)
				info.totalZdl = checknumber(info.totalZdl)
				info.familyName = GodStatuesWarController.instance:getFamilyNameInGroup(self._seasonId, pillarId)

				table.insert(self._rankInfoList, info)
			end
		end
	end

	table.sort(self._rankInfoList, function(a, b)
		if a.energy == b.energy then
			return a.totalZdl > b.totalZdl
		end

		return a.energy > b.energy
	end)
end

function GodStatuesWarTabChildRankFamilyView:_onUpdateRuleColUI()
	self._rankScrollList:reloadData(self._rankInfoList)

	local isEmpty = #self._rankInfoList <= 0

	GameUtil.SetActive(self._emptyGo, isEmpty)
end

function GodStatuesWarTabChildRankFamilyView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function GodStatuesWarTabChildRankFamilyView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local rank = cell.index + 1
	local energy = info.energy
	local familyName = info.familyName
	local imgPetIcon = goutil.findChild(mainGo, "imgPetIcon")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtName.text = familyName
	txtScore.text = energy
end

function GodStatuesWarTabChildRankFamilyView:_clearRankCell(cell)
	return
end

return GodStatuesWarTabChildRankFamilyView
