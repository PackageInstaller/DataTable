-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerRankView.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerRankView", package.seeall)

local PsychicedTowerRankView = class("PsychicedTowerRankView", ViewComponent)

function PsychicedTowerRankView:ctor()
	PsychicedTowerRankView.super.ctor(self)
end

function PsychicedTowerRankView:buildUI()
	PsychicedTowerRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._ranktableGo = goutil.findChild(self.mainGO, "right/rankListView")
	self._ranktableCell = goutil.findChild(self.mainGO, "right/rankCell")
	self._rankTableList = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "right/goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyRank")
	self._myScoreTitle = self:getGo("right/myRank/txtMyStepTitle")
	self._txtMyScore = self:getTxt("right/myRank/txtHistory/txtNum")
	self._tabTableView = self:getGo("tableview")
	self._tabTableCell = self:getGo("tablecell")
	self._tabTableList = ScrollerList.create(self._tabTableView, self._tabTableCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function PsychicedTowerRankView:bindEvents()
	PsychicedTowerRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PsychicedTowerRankView:unbindEvents()
	PsychicedTowerRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PsychicedTowerRankView:destroyUI()
	PsychicedTowerRankView.super.destroyUI(self)
	self._rankTableList:dispose()
	self._tabTableList:dispose()
end

function PsychicedTowerRankView:onEnter()
	PsychicedTowerRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.PM_PsychicedTowerRankInfoRes, self._refreshView, self)

	self._tabList = {}

	table.insert(self._tabList, PsychicedTowerModel.TOTLE_RANK_TABID)

	local towersCfg = PsychicedTowerConfig.instance:getTowerCfgs(self._activityId)

	if #towersCfg > 1 then
		for i, v in ipairs(towersCfg) do
			table.insert(self._tabList, v.towerId)
		end
	end

	self._tabId = PsychicedTowerModel.TOTLE_RANK_TABID

	self._tabTableList:reloadData(self._tabList)

	self._rankInfoInit = {}

	self:_onClickTab(PsychicedTowerModel.TOTLE_RANK_TABID)
end

function PsychicedTowerRankView:onExit()
	PsychicedTowerRankView.super.onExit(self)
	table.clear(self._rankInfoInit)
	self._rankTableList:dispose()
	self._tabTableList:dispose()
end

function PsychicedTowerRankView:_refreshView()
	self._rankInfoInit[self._tabId] = true

	local rankInfo = PsychicedTowerModel.instance:getRankInfo(self._activityId, self._tabId)

	self._rankTableList:reloadData(rankInfo.rankInfos)

	if #rankInfo.rankInfos > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._txtMyRank.text = (rankInfo.myRank > 100 or rankInfo.myRank <= 0) and lang("未上榜") or rankInfo.myRank
	self._txtMyScore.text = rankInfo.myStar / 2

	self._tabTableList:reloadData(self._tabList)
end

function PsychicedTowerRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
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

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if rankInfo.headInfo.userId then
				self:onHeadClick(rankInfo.headInfo.userId, imgIcon)
			end
		end)
	end

	txtArea.text = rankInfo.headInfo.areaName
	txtName.text = rankInfo.headInfo.userName
	txtScore.text = data.value / 2

	local date = GameUtil.time2date(checknumber(rankInfo.time / 1000))

	txtTime.text = langPara("%02d月%02d日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
end

function PsychicedTowerRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function PsychicedTowerRankView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local selectGo = goutil.findChild(go, "imgSelected")
	local txtColorChange = goutil.findChildComponent(go, "txtName", "UITextColorChange")

	if data == PsychicedTowerModel.TOTLE_RANK_TABID then
		txtName.text = lang("总分塔")
	else
		local towerCfg = PsychicedTowerConfig.instance:getTowerCfg(self._activityId, data)

		txtName.text = towerCfg.name
	end

	GameUtil.SetActive(selectGo, data == self._tabId)

	if data == self._tabId then
		txtColorChange:SetState(0)
	else
		txtColorChange:SetState(1)
	end

	GameUtil.addClickHandler(go, function()
		self:_onClickTab(data)
	end)
end

function PsychicedTowerRankView:_clearTabCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function PsychicedTowerRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function PsychicedTowerRankView:_onClickTab(tabId)
	self._tabId = tabId

	if self._rankInfoInit[tabId] then
		self:_refreshView()
	elseif tabId == PsychicedTowerModel.TOTLE_RANK_TABID then
		PsychicedTowerAgent.instance:sendPM_PsychicedTowerTotalRankInfoReq(self._activityId)
	else
		PsychicedTowerAgent.instance:sendPM_PsychicedTowerRankInfoReq(self._activityId, tabId)
	end
end

return PsychicedTowerRankView
