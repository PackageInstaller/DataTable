-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/tab/FamilyHoudingClgTabRankFamilyView.lua

module("logic.extensions.familyhoundingclg.view.tab.FamilyHoudingClgTabRankFamilyView", package.seeall)

local FamilyHoudingClgTabRankFamilyView = class("FamilyHoudingClgTabRankFamilyView", ViewComponent)

function FamilyHoudingClgTabRankFamilyView:buildUI()
	FamilyHoudingClgTabRankFamilyView.super.buildUI(self)

	local rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	local rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")

	self._rankScrollList = ScrollerList.create(rankScrollerview, rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._emptyGo_txt = goutil.findChildTextComponent(self.mainGO, "rankCol/emptyGo/txt")
	self._txtRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtRank")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtScore")
end

function FamilyHoudingClgTabRankFamilyView:bindEvents()
	FamilyHoudingClgTabRankFamilyView.super.bindEvents(self)
end

function FamilyHoudingClgTabRankFamilyView:unbindEvents()
	FamilyHoudingClgTabRankFamilyView.super.unbindEvents(self)
end

function FamilyHoudingClgTabRankFamilyView:onEnter()
	FamilyHoudingClgTabRankFamilyView.super.onEnter(self)

	self._fhId = FamilyHoudingClgController.instance:getCurPlanId()

	local isInTime = FamilyHoudingClgController.instance:isInTime(self._fhId)

	if not isInTime then
		self:close()

		return
	end

	self._planTimeData = FamilyHoudingClgConfig.instance:getFhPlanTimeData(self._fhId)

	self.addGEvent(self, GlobalNotify.handlePM_FamilyHounding_ViewFamilyRankRes, self._onUpdate, self)
	FamilyHoudingClgController.instance:sendPM_FamilyHounding_ViewFamilyRankReq()
end

function FamilyHoudingClgTabRankFamilyView:onExit()
	FamilyHoudingClgTabRankFamilyView.super.onExit(self)
	self:_onClear()
end

function FamilyHoudingClgTabRankFamilyView:_onUpdate()
	local myRank = FamilyHoudingClgController.instance:getMyFamilyRankOfFamily()

	self._txtRank.text = myRank > 0 and myRank or "未上榜"

	local myScore = FamilyHoudingClgController.instance:getMyFamilyScoreOfFamily()

	self._txtScore.text = myScore > 0 and myScore or "未上榜"

	self:_onUpdateRuleColUI()
end

function FamilyHoudingClgTabRankFamilyView:_onClear()
	self:_onClearRuleCol()
end

function FamilyHoudingClgTabRankFamilyView:_onUpdateRuleColUI()
	local rankInfoList = FamilyHoudingClgController.instance:getRankInfoListOfFamily()

	self._rankScrollList:reloadData(rankInfoList)

	local isEmpty = #rankInfoList <= 0

	GameUtil.SetActive(self._emptyGo, isEmpty)
end

function FamilyHoudingClgTabRankFamilyView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function FamilyHoudingClgTabRankFamilyView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local rank = info.rank
	local name = info.familyName
	local score = info.score
	local iconId = info.iconId
	local imgPetIcon = goutil.findChild(mainGo, "imgPetIcon")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	GameUtil.setUIImageSpriteIdx(imgPetIcon, iconId)

	txtRank.text = info.rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtName.text = name
	txtScore.text = score
end

function FamilyHoudingClgTabRankFamilyView:_clearRankCell(cell)
	return
end

return FamilyHoudingClgTabRankFamilyView
