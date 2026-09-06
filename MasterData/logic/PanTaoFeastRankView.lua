-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastRankView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastRankView", package.seeall)

local PanTaoFeastRankView = class("PanTaoFeastRankView", ViewComponent)

function PanTaoFeastRankView:ctor()
	PanTaoFeastRankView.super.ctor(self)
end

function PanTaoFeastRankView:unbindEvents()
	PanTaoFeastRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PanTaoFeastRankView:bindEvents()
	PanTaoFeastRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PanTaoFeastRankView:buildUI()
	PanTaoFeastRankView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")

	local goCellRank = self:getGo("tablecellRank")
	local goTableRank = self:getGo("tableviewRank")

	self._tableViewRank = ScrollerList.create(goTableRank, goCellRank, GameUtil.handler(self._updateCellRank, self), GameUtil.handler(self._clearCellRank, self))
	self._subTableviewDic = {}
	self._itemCell = self:getGo("itemCell")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtMyProgress = self:getTxt("myRank/txtMyProgress")
	self._goEmpty = self:getGo("goEmpty")
end

function PanTaoFeastRankView:onExit()
	PanTaoFeastRankView.super.onExit(self)
	self._tableViewRank:dispose()
end

function PanTaoFeastRankView:onEnter()
	PanTaoFeastRankView.super.onEnter(self)
	table.clear(self._subTableviewDic)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastGetRankInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = PanTaoFeastController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	PanTaoFeastController.instance:getRankInfo(self._activityId)
end

function PanTaoFeastRankView:_updateUIByCfg()
	local buildingCfgs = PanTaoFeastConfig.instance:getBuildingCfgs(self._activityId) or {}

	self._buildingCount = #buildingCfgs
end

function PanTaoFeastRankView:_updateUIByInfo()
	local myRank = -1
	local myScore = 0
	local myReachTimeMillis = 0
	local rankInfos = {}
	local info = PanTaoFeastModel.instance:getRankInfo(self._activityId)

	if info then
		rankInfos = info.rankInfoList or {}
		myRank = info.myRank or -1
		myScore = info.myScore or 0
		myReachTimeMillis = info.myReachTimeMillis or 0
	end

	self._tableViewRank:reloadData(rankInfos)
	GameUtil.SetActive(self._goEmpty, #rankInfos <= 0)

	self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")
	self._txtMyProgress.text = string.format("%s/%s", myScore, self._buildingCount)
end

function PanTaoFeastRankView:_updateCellRank(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDate = goutil.findChildTextComponent(go, "txtDate")
	local txtProgress = goutil.findChildTextComponent(go, "txtProgress")
	local itemListGo = goutil.findChild(go, "itemTableView")
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

	if not rankInfo.value then
		txtProgress.text = string.format("%s/%s", rankInfo.value, self._buildingCount)

		local date = GameUtil.time2date(checknumber(rankInfo.time) / 1000)

		txtDate.text = string.format("%02d-%02d-%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

		local prizes = self:_getPrizesByRank(rankInfo.rank)

		if itemListGo and self._itemCell then
			local subTableview = self._subTableviewDic[go]

			if not subTableview then
				subTableview = ScrollerList.create(itemListGo, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
				self._subTableviewDic[go] = subTableview
			end

			local prizeStrArr = string.split(prizes, "#")

			subTableview:reloadData(prizeStrArr)
			subTableview:MoveCellToBegin(0)
			subTableview:dragNotifyParent()
		end
	end
end

function PanTaoFeastRankView:_clearCellRank(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local prizeScrollList = self._subTableviewDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._subTableviewDic[go] = nil
	end
end

function PanTaoFeastRankView:_updateItemCell(view, cell, data)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function PanTaoFeastRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function PanTaoFeastRankView:_getPrizesByRank(rank)
	local data = PanTaoFeastConfig.instance:getRankPrizeCfgByRank(self._activityId, rank)

	return (data or nil) and (data.prize or "")
end

return PanTaoFeastRankView
