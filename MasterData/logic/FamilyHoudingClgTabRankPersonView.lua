-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/tab/FamilyHoudingClgTabRankPersonView.lua

module("logic.extensions.familyhoundingclg.view.tab.FamilyHoudingClgTabRankPersonView", package.seeall)

local FamilyHoudingClgTabRankPersonView = class("FamilyHoudingClgTabRankPersonView", ViewComponent)

function FamilyHoudingClgTabRankPersonView:buildUI()
	FamilyHoudingClgTabRankPersonView.super.buildUI(self)

	local rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	local rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")

	self._rankScrollList = ScrollerList.create(rankScrollerview, rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._emptyGo_txt = goutil.findChildTextComponent(self.mainGO, "rankCol/emptyGo/txt")
	self._txtRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtRank")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtScore")
end

function FamilyHoudingClgTabRankPersonView:bindEvents()
	FamilyHoudingClgTabRankPersonView.super.bindEvents(self)
end

function FamilyHoudingClgTabRankPersonView:unbindEvents()
	FamilyHoudingClgTabRankPersonView.super.unbindEvents(self)
end

function FamilyHoudingClgTabRankPersonView:onEnter()
	FamilyHoudingClgTabRankPersonView.super.onEnter(self)

	self._fhId = FamilyHoudingClgController.instance:getCurPlanId()

	local isInTime = FamilyHoudingClgController.instance:isInTime(self._fhId)

	if not isInTime then
		self:close()

		return
	end

	self._planTimeData = FamilyHoudingClgConfig.instance:getFhPlanTimeData(self._fhId)

	self.addGEvent(self, GlobalNotify.handlePM_FamilyHounding_ViewPersonRankRes, self._onUpdate, self)
	FamilyHoudingClgController.instance:sendPM_FamilyHounding_ViewPersonRankReq()
end

function FamilyHoudingClgTabRankPersonView:onExit()
	FamilyHoudingClgTabRankPersonView.super.onExit(self)
	self:_onClear()
end

function FamilyHoudingClgTabRankPersonView:_onUpdate()
	local myRank = FamilyHoudingClgController.instance:getMyFamilyRankOfPerson()

	self._txtRank.text = myRank > 0 and myRank or "未上榜"

	local myScore = FamilyHoudingClgController.instance:getMyFamilyScoreOfPerson()

	self._txtScore.text = myScore > 0 and myScore or "未上榜"

	self:_onUpdateRuleColUI()
end

function FamilyHoudingClgTabRankPersonView:_onClear()
	self:_onClearRuleCol()
end

function FamilyHoudingClgTabRankPersonView:_onUpdateRuleColUI()
	local rankInfoList = FamilyHoudingClgController.instance:getRankInfoListOfPerson()

	self._rankScrollList:reloadData(rankInfoList)

	local isEmpty = #rankInfoList <= 0

	GameUtil.SetActive(self._emptyGo, isEmpty)
end

function FamilyHoudingClgTabRankPersonView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function FamilyHoudingClgTabRankPersonView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local rank = info.rankInfo.rank
	local headInfo = info.rankInfo.headInfo
	local playerName = info.rankInfo.headInfo.userName

	if not info.familyName then
		local familyName = ""
		local score = info.rankInfo.value
		local head = goutil.findChild(mainGo, "head")
		local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
		local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
		local txtPlayer = goutil.findChildTextComponent(mainGo, "txtPlayer")
		local txtFamily = goutil.findChildTextComponent(mainGo, "txtFamily")
		local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

		HeadItemController.instance:setHeadCellByInfo(head, headInfo, true)

		local isTop3 = checknumber(rank) <= 3

		imgRank.gameObject:SetActive(isTop3)
		txtRank.gameObject:SetActive(not isTop3)

		if isTop3 then
			imgRank:SetState(rank - 1)
		end

		txtRank.text = rank
		txtPlayer.text = playerName
		txtFamily.text = familyName
		txtScore.text = score
	end
end

function FamilyHoudingClgTabRankPersonView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)
end

return FamilyHoudingClgTabRankPersonView
