-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingRankView.lua

module("logic.extensions.chopking.view.ChopKingRankView", package.seeall)

local ChopKingRankView = class("ChopKingRankView", ViewComponent)

function ChopKingRankView:ctor()
	ChopKingRankView.super.ctor(self)
end

function ChopKingRankView:unbindEvents()
	ChopKingRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnType_1)
	GameUtil.rmClickHandler(self._btnType_2)
	GameUtil.rmClickHandler(self._btnClose)
end

function ChopKingRankView:bindEvents()
	ChopKingRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnType_1, function()
		self:_onClcikTab(1)
	end, self)
	GameUtil.addClickHandler(self._btnType_2, function()
		self:_onClcikTab(2)
	end, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ChopKingRankView:buildUI()
	ChopKingRankView.super.buildUI(self)

	self._subTitle_1 = self:getGo("right/subTitle_1")
	self._subTitle_2 = self:getGo("right/subTitle_2")
	self._btnClose = self:getGo("btnClose")
	self._goEmpty = self:getGo("right/goEmpty")
	self._cell = self:getGo("right/cell")
	self._rankScrollRect = self:getGo("right/rankScrollRect")
	self._rankTableList = ScrollerList.create(self._rankScrollRect, self._cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._btnType_1 = self:getGo("btnType_1")
	self._changeGroupBtnType1 = self._btnType_1:GetComponent(ComponentType.UIChangeGroup)
	self._btnType_2 = self:getGo("btnType_2")
	self._changeGroupBtnType2 = self._btnType_2:GetComponent(ComponentType.UIChangeGroup)
	self._itemTablecell = self:getGo("itemTablecell")
	self._itemTableview = self:getGo("right/myRank/itemTableview")
	self._itemTableList = ScrollerList.create(self._itemTableview, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	self._txtMyStep = self:getTxt("right/myRank/txtMyStep")
	self._txtEmptyTips = self:getGo("right/myRank/txtEmptyTips")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtMyStepTitle = self:getTxt("right/myRank/txtMyStepTitle")
end

function ChopKingRankView:onExit()
	ChopKingRankView.super.onExit(self)
	self._itemTableList:dispose()
	self._rankTableList:dispose()

	for k, v in pairs(self._itemTableListDir) do
		v:dispose()

		self._itemTableListDir[k] = nil
	end
end

function ChopKingRankView:onEnter()
	ChopKingRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingRankRes, self._refreshView, self)

	self._itemTableListDir = {}
	self._activityId = checknumber(self:getFirstParam())
	self._curType = 0

	self:_onClcikTab(1)
end

function ChopKingRankView:_refreshView()
	GameUtil.SetActive(self._subTitle_1, self._curType == 1)
	GameUtil.SetActive(self._subTitle_2, self._curType == 2)

	local rankList = ChopKingModel.instance:getRankList()

	self._rankTableList:reloadData(rankList)
	GameUtil.SetActive(self._goEmpty, #rankList <= 0)

	if self._curType == 1 then
		self._changeGroupBtnType1:SetState(1)
		self._changeGroupBtnType2:SetState(0)
	else
		self._changeGroupBtnType1:SetState(0)
		self._changeGroupBtnType2:SetState(1)
	end

	local myPrizeArray = {}
	local myRank = ChopKingModel.instance:getMyRank()

	self._txtMyRank.text = myRank <= 0 and lang("未上榜") or myRank

	local rankPrizeCfgs = ChopKingConfig.instance:getFirstRankPrizeCfgs(self._activityId)

	for k, v in pairs((self._curType == 2 or nil) and ChopKingConfig.instance:getTotalRankPrizeCfgs(self._activityId)) do
		if myRank >= v.rankRange[1] and myRank <= v.rankRange[2] then
			myPrizeArray = string.split(v.prize, "#")

			break
		end
	end

	self._itemTableList:reloadData(myPrizeArray)
	GameUtil.SetActive(self._txtEmptyTips, #myPrizeArray <= 0)

	if self._curType == 1 then
		self._txtMyStepTitle.text = lang("我的层数")
		self._txtMyStep.text = ChopKingModel.instance:getRoguePassNum(self._activityId)
	elseif self._curType == 2 then
		self._txtMyStepTitle.text = lang("我的积分")
		self._txtMyStep.text = ChopKingController.instance:getTotalScore(self._activityId)
	end
end

function ChopKingRankView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local itemTableView = goutil.findChild(go, "itemTableview")
	local rankInfo = data

	txtRank.text = rankInfo.rank

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo, true)

	txtName.text = rankInfo.headInfo.userName
	txtScore.text = rankInfo.value

	local date = GameUtil.time2date(checknumber(rankInfo.time) / 1000)

	txtTime.text = langPara("%d月%d日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local prizeArray = {}
	local rankPrizeCfgs = ChopKingConfig.instance:getFirstRankPrizeCfgs(self._activityId)

	for k, v in pairs((self._curType == 2 or nil) and ChopKingConfig.instance:getTotalRankPrizeCfgs(self._activityId)) do
		if v.rankRange[1] <= rankInfo.rank and v.rankRange[2] >= rankInfo.rank then
			prizeArray = string.split(v.prize, "#")

			break
		end
	end

	if itemTableView and self._itemTablecell then
		if not self._itemTableListDir[itemTableView] then
			local itemTableList = ScrollerList.create(itemTableView, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemTableListDir[itemTableView] = self._itemTableListDir[itemTableView]

			self._itemTableListDir[itemTableView]:reloadData(prizeArray)
		end
	end
end

function ChopKingRankView:_clearRankCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)
end

function ChopKingRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function ChopKingRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function ChopKingRankView:_onClcikTab(type)
	self._curType = type

	ChopKingAgent.instance:sendPM_ChopKingRankReq(self._activityId, type)
end

function ChopKingRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return ChopKingRankView
