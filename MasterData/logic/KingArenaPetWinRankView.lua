-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/rank/KingArenaPetWinRankView.lua

module("logic.extensions.kingarena.view.rank.KingArenaPetWinRankView", package.seeall)

local KingArenaPetWinRankView = class("KingArenaPetWinRankView", ViewComponent)

function KingArenaPetWinRankView:buildUI()
	KingArenaPetWinRankView.super.buildUI(self)

	self._rankScrView = self:getGo("rankScrView")
	self._rankScrCell = self:getGo("rankScrCell")
	self._emptyGo = self:getGo("emptyGo")
	self._rankScrollerList = ScrollerList.create(self._rankScrView, self._rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._dropdown = self:getGo("dropdown")
	self._dropdownComp = DropDownAdapter.Get(self._dropdown)
end

function KingArenaPetWinRankView:bindEvents()
	KingArenaPetWinRankView.super.bindEvents(self)
end

function KingArenaPetWinRankView:unbindEvents()
	KingArenaPetWinRankView.super.unbindEvents(self)
end

function KingArenaPetWinRankView:onEnter()
	KingArenaPetWinRankView.super.onEnter(self)

	self._rankType = KingArenaEnum.RankType_Pet_Two
	self._seasonId = KingArenaController.instance:getSeasonId()
	self._rankInfoList = {}

	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaPetRankViewRes, self._handlePM_KingArenaPetRankViewRes, self)
	self._dropdownComp:ClearOptions()

	for _, side in ipairs(KingArenaEnum.RankSideList) do
		local name = KingArenaEnum.RankSideNames[side]

		self._dropdownComp:AddOptions(name)
	end

	self._dropdownComp:AddOnValueChanged(function(handler, value)
		self:_sendGetInfoReq()
	end, self)

	if self._dropdownComp:GetValue() == 0 then
		self:_sendGetInfoReq()
	else
		self._dropdownComp:SetValue(0)
	end

	self:_onUpdate()
end

function KingArenaPetWinRankView:onExit()
	KingArenaPetWinRankView.super.onExit(self)
	self._dropdownComp:RemoveOnValueChanged()
	self._dropdownComp:SetValue(-1)
	self._dropdownComp:ClearOptions()
	self._rankScrollerList:dispose()
end

function KingArenaPetWinRankView:_sendGetInfoReq()
	local curSize = self:_getCurSide()
	local isInTime = KingArenaController.instance:isInTimeOfSeason(self._seasonId)

	if curSize > 0 and isInTime then
		KingArenaController.instance:sendPM_KingArenaPetRankViewReq(self._seasonId, self._rankType, curSize)
	end
end

function KingArenaPetWinRankView:_getCurSide()
	local value = self._dropdownComp:GetValue()

	return KingArenaEnum.RankSideList[value + 1]
end

function KingArenaPetWinRankView:_handlePM_KingArenaPetRankViewRes(msg)
	if msg.type ~= self._rankType or msg.side ~= self:_getCurSide() or msg.seasonId ~= self._seasonId then
		return
	end

	self._rankInfoList = msg.rankInfoList

	self:_onUpdate()
end

function KingArenaPetWinRankView:_onUpdate()
	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
	self._rankScrollerList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollerList:MoveCellInView(idx, isMotion)
end

function KingArenaPetWinRankView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local raceId = info.raceId
	local formCount = info.formCount
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtFormCount = goutil.findChildTextComponent(mainGo, "txtFormCount")
	local txtWinCount = goutil.findChildTextComponent(mainGo, "txtWinCount")
	local txtWinRatio = goutil.findChildTextComponent(mainGo, "txtWinRatio")

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtFormCount.text = formCount
	txtWinCount.text = (info:HasField("winCount") or nil) and info.winCount
	txtWinRatio.text = string.format("%s%%", (info:HasField("winRatio") or nil) and info.winRatio)

	local petData = CharacterConfig.instance:getPetCo(raceId)

	if petData then
		txtName.text = petData.name or ""
	end

	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, head)
end

function KingArenaPetWinRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	MaterialMgr.resetAll(head)
end

return KingArenaPetWinRankView
