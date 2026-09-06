-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/view/GuardDestroyRankView.lua

module("logic.extensions.guarddestroy.view.GuardDestroyRankView", package.seeall)

local GuardDestroyRankView = class("GuardDestroyRankView", ViewComponent)

function GuardDestroyRankView:ctor()
	GuardDestroyRankView.super.ctor(self)
end

function GuardDestroyRankView:unbindEvents()
	GuardDestroyRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPrize)
end

function GuardDestroyRankView:bindEvents()
	GuardDestroyRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
end

function GuardDestroyRankView:buildUI()
	GuardDestroyRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._cell = self:getGo("right/cell")
	self._rankScrollRect = self:getGo("right/rankScrollRect")
	self._rankTableList = ScrollerList.create(self._rankScrollRect, self._cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemTableview = self:getGo("right/myRank/itemTableview")
	self._itemTablecell = self:getGo("itemTablecell")
	self._myItemTableList = ScrollerList.create(self._itemTableview, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	self._btnPrize = self:getGo("right/myRank/btnPrize")
	self._txtMyStep = self:getTxt("right/myRank/txtMyStep")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtEmptyTips = self:getGo("right/myRank/txtEmptyTips")
end

function GuardDestroyRankView:onExit()
	GuardDestroyRankView.super.onExit(self)
	self._myItemTableList:dispose()
	self._rankTableList:dispose()

	for k, v in pairs(self._itemTableListDir) do
		v:dispose()

		self._itemTableListDir[k] = nil
	end
end

function GuardDestroyRankView:onEnter()
	GuardDestroyRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GuardDestroyGetRankViewRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._itemTableListDir = {}

	GuardDestroyAgent.instance:sendPM_GuardDestroyGetRankViewReq(self._activityId)
end

function GuardDestroyRankView:_refreshView()
	local rankInfo = GuardDestroyModel.instance:getRankInfo(self._activityId)

	if not rankInfo.recordList then
		local list_1 = {}

		self._rankTableList:reloadData(list_1)

		local myPrizeArray = {}
		local myRank = rankInfo.myRank
		local rankPrizeCfgs = GuardDestroyConfig.instance:getRankPrizeCfgs(self._activityId)

		for k, v in pairs(rankPrizeCfgs) do
			if myRank >= v.rankRange[1] and myRank <= v.rankRange[2] then
				myPrizeArray = string.split(v.prize, "#")

				break
			end
		end

		self._txtMyRank.text = myRank > 0 and myRank or lang("未上榜")

		self._myItemTableList:reloadData(myPrizeArray)

		if checknumber(rankInfo.balanceAchieveTimeMillis) > 0 then
			local date = GameUtil.time2date(checknumber(rankInfo.balanceAchieveTimeMillis) / 1000)

			self._txtMyStep.text = langPara("%d月%d日 %d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
		else
			self._txtMyStep.text = lang("无")
		end

		GameUtil.SetActive(self._goEmpty, #list_1 <= 0)
		GameUtil.SetActive(self._txtEmptyTips, #myPrizeArray <= 0)
	end
end

function GuardDestroyRankView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
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

	txtName.text = rankInfo.headInfo.userName
	txtArea.text = rankInfo.headInfo.areaName

	local date = GameUtil.time2date(checknumber(rankInfo.time) / 1000)

	txtTime.text = langPara("%d月%d日 %d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local prizeArray = {}
	local rankPrizeCfgs = GuardDestroyConfig.instance:getRankPrizeCfgs(self._activityId)

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

function GuardDestroyRankView:_clearRankCell(cell)
	local go = cell.gameObject
	local itemTableView = goutil.findChild(go, "itemTableview")

	if self._itemTableListDir[itemTableView] then
		self._itemTableListDir[itemTableView]:dispose()

		self._itemTableListDir[itemTableView] = nil
	end
end

function GuardDestroyRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function GuardDestroyRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function GuardDestroyRankView:_onClickPrize()
	UIStateManager.instance:push(ViewName.GuardDestroyPrizeView, self._activityId)
end

function GuardDestroyRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return GuardDestroyRankView
