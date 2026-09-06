-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchRankView.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchRankView", package.seeall)

local TianYanMatchRankView = class("TianYanMatchRankView", ViewComponent)

function TianYanMatchRankView:ctor()
	TianYanMatchRankView.super.ctor(self)
end

function TianYanMatchRankView:unbindEvents()
	TianYanMatchRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TianYanMatchRankView:bindEvents()
	TianYanMatchRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TianYanMatchRankView:buildUI()
	TianYanMatchRankView.super.buildUI(self)

	self._rankScrollRect = self:getGo("right/rankScrollRect")
	self._cell = self:getGo("right/cell")
	self._rankTableList = ScrollerList.create(self._rankScrollRect, self._cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._goEmpty = self:getGo("right/goEmpty")
	self._btnClose = self:getGo("btnClose")
	self._itemTableview = self:getGo("right/myRank/itemTableview")
	self._itemTablecell = self:getGo("itemTablecell")
	self._itemTableList = ScrollerList.create(self._itemTableview, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	self._txtMyStep = self:getTxt("right/myRank/txtMyStep")
	self._txtEmptyTips = self:getGo("right/myRank/txtEmptyTips")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtMyStepTitle = self:getTxt("right/myRank/txtMyStepTitle")
end

function TianYanMatchRankView:onExit()
	TianYanMatchRankView.super.onExit(self)
	self._itemTableList:dispose()
	self._rankTableList:dispose()

	for k, v in pairs(self._itemTableListDir) do
		v:dispose()

		self._itemTableListDir[k] = nil
	end
end

function TianYanMatchRankView:onEnter()
	TianYanMatchRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.TianYanMatchGetInfo, self._refreshView, self)

	self._itemTableListDir = {}
	self._activityId = checknumber(self:getFirstParam())

	TianYanMatchAgent.instance:sendPM_TianYanMatchRankViewReq(self._activityId)
end

function TianYanMatchRankView:_refreshView()
	local rankInfo = TianYanMatchModel.instance:getRankInfo()

	if not rankInfo.rankList then
		local rankList = {}

		self._rankTableList:reloadData(rankList)
		GameUtil.SetActive(self._goEmpty, #rankList <= 0)

		local myPrizeArray = {}
		local myRank = rankInfo.myRank

		self._txtMyRank.text = myRank <= 0 and lang("未上榜") or myRank

		local rankPrizeCfgs = TianYanMatchConfig.instance:getRankPrizeCfgs(self._activityId)

		for k, v in pairs(rankPrizeCfgs) do
			if myRank >= v.rankRange[1] and myRank <= v.rankRange[2] then
				myPrizeArray = string.split(v.prize, "#")

				break
			end
		end

		self._itemTableList:reloadData(myPrizeArray)
		GameUtil.SetActive(self._txtEmptyTips, #myPrizeArray <= 0)

		self._txtMyStepTitle.text = lang("我的积分")
		self._txtMyStep.text = rankInfo.myScore
	end
end

function TianYanMatchRankView:_updateRankCell(view, cell, data, tag)
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

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo, true)

	txtName.text = langPara("%s\n%s", rankInfo.headInfo.areaName, rankInfo.headInfo.userName)

	local date = GameUtil.time2date(checknumber(rankInfo.time) / 1000)

	txtTime.text = langPara("%d月%d日\n%02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
	txtScore.text = rankInfo.value

	local prizeArray = {}
	local rankPrizeCfgs = TianYanMatchConfig.instance:getRankPrizeCfgs(self._activityId)

	for k, v in pairs(rankPrizeCfgs) do
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

function TianYanMatchRankView:_clearRankCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)
end

function TianYanMatchRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function TianYanMatchRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function TianYanMatchRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return TianYanMatchRankView
