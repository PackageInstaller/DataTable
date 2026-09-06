-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/qualifier/PTQualifierRankView.lua

module("logic.extensions.peaktournament.view.qualifier.PTQualifierRankView", package.seeall)

local PTQualifierRankView = class("PTQualifierRankView", ViewComponent)

function PTQualifierRankView:ctor()
	PTQualifierRankView.super.ctor(self)
end

function PTQualifierRankView:buildUI()
	PTQualifierRankView.super.buildUI(self)

	self._closeBtn = goutil.findChild(self.mainGO, "closeBtn")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function PTQualifierRankView:bindEvents()
	PTQualifierRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function PTQualifierRankView:unbindEvents()
	PTQualifierRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function PTQualifierRankView:destroyUI()
	PTQualifierRankView.super.destroyUI(self)
end

function PTQualifierRankView:onEnter()
	PTQualifierRankView.super.onEnter(self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	self._zoneId = PeakTournamentController.instance:getMyZoneId(self._activityId)

	if self._zoneId == nil then
		FloatWordMgr.instance:show("赛区不存在")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentQualifierRankInfoRes, self._onUpdateUI, self)
	PeakTournamentController.instance:sendPM_PeakTournamentQualifierRankInfoReq(self._activityId, self._zoneId)
end

function PTQualifierRankView:onExit()
	PTQualifierRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentQualifierRankInfoRes, self._onUpdateUI, self)
	self:_onClearRankCol()
end

function PTQualifierRankView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateRankColUI()
end

function PTQualifierRankView:_onUpdatePlaneUI()
	local myRank = PeakTournamentModel.instance:getMyRankAsQua()

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
end

function PTQualifierRankView:_onUpdateRankColUI()
	local infoList = PeakTournamentModel.instance:getrankInfoListAsQua()

	self._rankScrollList:reloadData(infoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)
end

function PTQualifierRankView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function PTQualifierRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")
	local levelIcon = goutil.findChild(mainGo, "levelIcon")
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local zoneData = PeakTournamentConfig.instance:getPtZoneData(self._activityId, self._zoneId)
	local levelData = PeakTournamentConfig.instance:getPtQuaLevelDataByScore(self._activityId, info.rankScore)

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtArea.text = zoneData.name
	txtScore.text = info.rankScore

	levelIcon:GetComponent(ComponentType.UIImageSpriteChange):SetState(levelData.quaLevelId - 1)

	txtLevel.text = levelData.levelName

	HeadItemController.instance:setHeadCellByInfo(imgIcon, info.headInfo)

	local function callBack()
		FriendController.instance:showInfoView(info.headInfo.userId, imgIcon)
	end

	GameUtil.addClickHandler(btnIcon, callBack)
end

function PTQualifierRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)
	GameUtil.rmClickHandler(btnIcon)
end

return PTQualifierRankView
