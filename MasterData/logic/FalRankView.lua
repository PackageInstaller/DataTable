-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalRankView.lua

module("logic.extensions.landlords.view.FalRankView", package.seeall)

local FalRankView = class("FalRankView", ViewComponent)

function FalRankView:ctor()
	FalRankView.super.ctor(self)

	self._scrollList = {}
end

function FalRankView:buildUI()
	FalRankView.super.buildUI(self)

	self._closeBtn = goutil.findChild(self.mainGO, "closeBtn")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function FalRankView:bindEvents()
	FalRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function FalRankView:unbindEvents()
	FalRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function FalRankView:destroyUI()
	FalRankView.super.destroyUI(self)

	self._scrollList = nil
end

function FalRankView:onEnter()
	FalRankView.super.onEnter(self)

	self._activityId = FightAgainstLandlordsController.instance:getActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKRankViewRes, self._onUpdateUI, self)

	self._baseData = FightAgainstLandlordsConfig.instance:getFalBaseData(self._activityId)

	FightAgainstLandlordsController.instance:sendPM_LandlordsPKRankViewReq(self._activityId)
end

function FalRankView:onExit()
	FalRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKRankViewRes, self._onUpdateUI, self)
	self:_onClearRankCol()
end

function FalRankView:_onUpdateUI(msg)
	local myRank = msg.myRank

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"

	local infoList = msg.ranks

	self._rankScrollList:reloadData(infoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)
end

function FalRankView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function FalRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")
	local txtWin = goutil.findChildTextComponent(mainGo, "txtWin")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local itemPrize = goutil.findChild(mainGo, "itemPrize")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtScore.text = info.tokenScore
	txtWin.text = info.winNum
	txtTime.text = GameUtil.getFormatTimeByStamp(checknumber(info.time) / 1000)

	local matList
	local rankPrizeCfg = FightAgainstLandlordsConfig.instance:getPrizeCfg(self._activityId, info.rank)
	local scorll = self:_getScroll(goTableview, goTablecell)

	scorll:reloadData((rankPrizeCfg or nil) and string.split(rankPrizeCfg.prize, "#"))
	HeadItemController.instance:setHeadCellByInfo(imgIcon, info.headInfo)

	local function callBack()
		FriendController.instance:showInfoView(info.headInfo.userId, imgIcon)
	end

	GameUtil.addClickHandler(btnIcon, callBack)
end

function FalRankView:_getScroll(goTableview, goTablecell)
	local scroll = self._scrollList[goTableview]

	if not scroll then
		scroll = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollList[goTableview] = scroll
	end

	return scroll
end

function FalRankView:_updateRewardCell(view, cell, cfgStr, tag)
	MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)
end

function FalRankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function FalRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")
	local itemPrize = goutil.findChild(mainGo, "itemPrize")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")

	HeadItemController.instance:resetHeadCell(imgIcon)
	GameUtil.rmClickHandler(btnIcon)
	MaterialMgr.resetAll(itemPrize)

	local scorll = self:_getScroll(goTableview, goTablecell)

	scorll:dispose()
end

return FalRankView
