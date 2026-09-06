-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/view/RomanticGiftsRankView.lua

module("logic.extensions.romanticgifts.view.RomanticGiftsRankView", package.seeall)

local RomanticGiftsRankView = class("RomanticGiftsRankView", ViewComponent)
local rootTabList = {
	romantic = 2,
	sweet = 1
}
local rootTabCfg = {
	{
		isRoot = true,
		rootName = "情义排行",
		tabId = rootTabList.sweet
	},
	{
		isRoot = true,
		rootName = "友爱排行",
		tabId = rootTabList.romantic
	}
}

function RomanticGiftsRankView:ctor()
	RomanticGiftsRankView.super.ctor(self)
end

function RomanticGiftsRankView:unbindEvents()
	RomanticGiftsRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function RomanticGiftsRankView:bindEvents()
	RomanticGiftsRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._closeView, self)
	self._btnRule:AddClickListener(self._ruleOnClick, self)
end

function RomanticGiftsRankView:onExit()
	RomanticGiftsRankView.super.onExit(self)
	MaterialMgr.resetAll(self._rewardIcon)
	self._tabList:dispose()
	self._rankList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.QiXiSendGiftGetRankReq, self._refreshRankList, self)
end

function RomanticGiftsRankView:buildUI()
	RomanticGiftsRankView.super.buildUI(self)

	self._btnClose = self:getBtn("Close")
	self._btnRule = self:getBtn("title/btnRule")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._txtRecord = self:getTxt("right/description/txtRecord")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtRewardGo = self:getGo("right/myRank/txtReward")
	self._txtMyScore = self:getTxt("right/myRank/txtMyScore/txtNum")
	self._txtScoreName = self:getTxt("right/myRank/txtMyScore")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._rewardIcon = self:getGo("right/myRank/rewardIcon")
	self._goEmpty = self:getGo("right/goEmpty")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._rankTab = self:getGo("right/rankListView")
	self._rankcell = self:getGo("right/rankCell")
	self._tabList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._rankList = ScrollerList.create(self._rankTab, self._rankcell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function RomanticGiftsRankView:onEnter()
	RomanticGiftsRankView.super.onEnter(self)

	self._curSelectRoot = 0
	self._curSelectZoneId = RomanticGiftsModel.instance:getPlayerZoneId()
	self._isFold = true
	self._tabListData = {}

	self:_initTabList()
	self:_setTabList(self._curSelectZoneId)

	self._curActId = RomanticGiftsModel.instance:getActId()

	GlobalDispatcher:addListener(GlobalNotify.QiXiSendGiftGetRankReq, self._refreshRankList, self)
end

function RomanticGiftsRankView:_updateRankCell(view, cell, data)
	local btnSupport = goutil.findChild(cell, "btnSupport")
	local head = goutil.findChild(cell, "imgPetIcon")
	local rankImg = goutil.findChild(cell, "imgRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell, "score/txtScore")

	goutil.clearChildren(head)
	goutil.setActive(btnSupport, data.headInfo.userId ~= RoleModel.instance:getUserId())

	local proxy = HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, head)
		end)
	end

	txtRank.text = data.rank
	txtScore.text = data.maxScore
	txtName.text = data.headInfo.userName
	txtArea.text = data.headInfo.areaName

	GameUtil.rmClickHandler(btnSupport)
	GameUtil.addClickHandler(btnSupport, function()
		UIStateManager.instance:push(ViewName.QixiSendflowerView, data.headInfo)
	end, self)

	if data.rank ~= nil and checknumber(data.rank) <= 3 and checknumber(data.rank) > 0 then
		goutil.setActive(rankImg, true)
		goutil.setActive(txtRank.gameObject, false)
		rankImg:GetComponent("UIImageSpriteChange"):SetState(checknumber(data.rank) - 1)
	else
		goutil.setActive(rankImg, false)
		goutil.setActive(txtRank.gameObject, true)
	end
end

function RomanticGiftsRankView:_clearRankCell(cell)
	return
end

function RomanticGiftsRankView:_updateTabCell(view, cell, data)
	local rootCell = goutil.findChild(cell, "rootCell")
	local leafCell = goutil.findChild(cell, "leafCell")
	local rootSelected = goutil.findChild(cell, "rootCell/imgSelected")
	local leafSelected = goutil.findChild(cell, "leafCell/imgSelected")
	local rootName = goutil.findChildTextComponent(cell, "rootCell/txtName")
	local leafName = goutil.findChildTextComponent(cell, "leafCell/txtName")
	local txtColorChange = leafName:GetComponent("UITextColorChange")

	goutil.setActive(rootCell, data.isRoot)
	goutil.setActive(leafCell, not data.isRoot)

	if data.zoneId then
		goutil.setActive(leafSelected, data.zoneId == self._curSelectZoneId)
		txtColorChange:SetState(data.zoneId == self._curSelectZoneId and 0 or 1)
	end

	if data.isRoot then
		goutil.setActive(rootSelected, data.tabId == self._curSelectRoot)

		rootName.text = data.rootName
	else
		leafName.text = data.name
	end

	GameUtil.rmClickHandler(rootCell)
	GameUtil.addClickHandler(rootCell, function()
		if self._curSelectRoot == data.tabId and self._isFold then
			self._tabList:reloadData(rootTabCfg)
			self._rankList:reloadData({})
			goutil.setActive(self._goEmpty, true)

			self._isFold = false

			return
		end

		self:_setTabList(data.tabId)
	end, self)
	GameUtil.rmClickHandler(leafCell)
	GameUtil.addClickHandler(leafCell, function()
		self._curSelectZoneId = data.zoneId

		self._tabList:reloadData(self._tabListData)

		if data.rootId == rootTabList.romantic then
			QiXiSendGiftAgent.instance:sendPM_QiXiSendGiftGetRomanceRankReq(data.zoneId)
		else
			QiXiSendGiftAgent.instance:sendPM_QiXiSendGiftGetSugarRankReq(data.zoneId)
		end
	end, self)
end

function RomanticGiftsRankView:_clearTabCell(cell)
	return
end

function RomanticGiftsRankView:_initTabList()
	local zoneCfg = RomanticGiftsConfig.instance:getZoneCfg()

	for i, v in ipairs(rootTabCfg) do
		table.insert(self._tabListData, v)
	end

	for i, v in ipairs(zoneCfg) do
		v.isRoot = false
		v.rootId = rootTabList.sweet

		table.insert(self._tabListData, v)
	end
end

function RomanticGiftsRankView:_setTabList(rootTab)
	self._isFold = true

	if self._curSelectRoot ~= rootTab then
		self._curSelectRoot = rootTab
		self._curSelectZoneId = RomanticGiftsModel.instance:getPlayerZoneId()
	else
		self._tabList:reloadData(self._tabListData)
		self:_refreshRankList()

		return
	end

	for i, v in ipairs(self._tabListData) do
		if not v.isRoot and rootTab then
			v.rootId = rootTab
		end
	end

	table.sort(self._tabListData, function(a, b)
		if a.isRoot and b.isRoot then
			return a.tabId < b.tabId
		elseif a.isRoot or b.isRoot then
			if a.isRoot then
				return a.tabId == rootTab
			else
				return b.tabId > a.rootId and b.tabId ~= rootTab
			end
		else
			return a.zoneId < b.zoneId
		end
	end)
	self._tabList:reloadData(self._tabListData)

	if rootTab == rootTabList.romantic then
		QiXiSendGiftAgent.instance:sendPM_QiXiSendGiftGetRomanceRankReq(self._curSelectZoneId)
	else
		QiXiSendGiftAgent.instance:sendPM_QiXiSendGiftGetSugarRankReq(self._curSelectZoneId)
	end
end

function RomanticGiftsRankView:_refreshRankList()
	local info = {}

	if self._curSelectRoot == rootTabList.romantic then
		info = RomanticGiftsModel.instance:getRomanticRankInfo(self._curSelectZoneId)
		info.rankCfg = RomanticGiftsConfig.instance:getRomanRankPrize(self._curActId)
		self._txtScoreName.text = "我的友爱值"
		self._txtRecord.text = "友爱值"
	else
		info = RomanticGiftsModel.instance:getSweetRankInfo(self._curSelectZoneId)
		info.rankCfg = RomanticGiftsConfig.instance:getSweetRankPrize(self._curActId)
		self._txtScoreName.text = "我的情义值"
		self._txtRecord.text = "情义值"
	end

	local prize = self:getPrizeByRank(info.rankCfg, info.myRank)

	MaterialMgr.resetAll(self._rewardIcon)
	MaterialMgr.setCellByCfg(prize, self._rewardIcon)
	GameUtil.SetActive(self._txtRewardGo, string.nilorempty(prize))
	self._rankList:reloadData(info.ranks)

	if info.myRank > 0 then
		self._txtMyRank.text = info.myRank or "未上榜"
	end

	self._txtMyScore.text = info.value
	self._txtTip.text = string.nilorempty(info.rankCfg.text) and "提示：排行榜非实时刷新" or info.rankCfg.text

	goutil.setActive(self._goEmpty, not info.ranks)
end

function RomanticGiftsRankView:_closeView()
	self:close()
end

function RomanticGiftsRankView:_ruleOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "romanticgifts_rank")
end

function RomanticGiftsRankView:getPrizeByRank(cfg, rank)
	if rank <= 0 then
		return ""
	end

	for i, v in ipairs(cfg) do
		if rank <= v.rightTop then
			return v.prize
		end
	end

	return ""
end

return RomanticGiftsRankView
