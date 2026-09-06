-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorRankView.lua

module("logic.extensions.festiveflower.view.GoddesscollectorRankView", package.seeall)

local GoddesscollectorRankView = class("GoddesscollectorRankView", ViewComponent)

function GoddesscollectorRankView:ctor()
	GoddesscollectorRankView.super.ctor(self)
end

function GoddesscollectorRankView:unbindEvents()
	GoddesscollectorRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GoddesscollectorRankView:bindEvents()
	GoddesscollectorRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GoddesscollectorRankView:buildUI()
	GoddesscollectorRankView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._txtTime = self:getTxt("myRank/txtCollectTime/txtTime")
	self._txtCollectTime = self:getGo("myRank/txtCollectTime")
	self._empty = self:getGo("empty")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")

	local tableView = self:getGo("tableView")
	local cell = self:getGo("cell")

	self._tablecell = self:getGo("tablecell")
	self._rankList = ScrollerList.create(tableView, cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function GoddesscollectorRankView:onExit()
	GoddesscollectorRankView.super.onExit(self)
	self._rankList:dispose()
end

function GoddesscollectorRankView:onEnter()
	GoddesscollectorRankView.super.onEnter(self)

	self._scrollerHandlers = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = GoddesscollectorModel.instance:getActivityId()
	end

	GoddessCollectorAgent.instance:sendPM_GoddessCollectorRankReq(self._activityId)
	self.addGEvent(self, GlobalNotify.GoddessCollectorRank, self._updatePersonInfo, self)
end

function GoddesscollectorRankView:_updateRankCell(view, cell, info, tag)
	local mainGO = cell.gameObject
	local head = goutil.findChild(mainGO, "head")
	local tableview = goutil.findChild(mainGO, "tableview")
	local imgRank = goutil.findChildComponent(mainGO, "imgRank", ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(mainGO, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGO, "txtRank")
	local txtArea = goutil.findChildTextComponent(mainGO, "txtArea")
	local txtCollectTime = goutil.findChildTextComponent(mainGO, "txtCollectTime")
	local name = info.headInfo.userName
	local rank = info.rank
	local time = info.time
	local area = info.headInfo.areaName
	local headInfo = info.headInfo

	HeadItemController.instance:setHeadCellByInfo(head, headInfo, true)

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	if time then
		local timeStr = ""
		local timeSec = checknumber(time)

		if timeSec > 0 then
			local timeDate = os.date("*t", timeSec / 1000)

			timeStr = string.format("%d %02d.%02d\n%02d:%02d:%02d", timeDate.year, timeDate.month, timeDate.day, timeDate.hour, timeDate.min, timeDate.sec)
		end

		txtCollectTime.text = timeStr
	end

	txtName.text = name
	txtRank.text = rank
	txtArea.text = area

	local scroll = self._scrollerHandlers[cell]

	if not scroll then
		scroll = ScrollerList.create(tableview, self._tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollerHandlers[cell] = scroll
	end

	local prizeCfg = self:_getRankPrizeCfg(rank)
	local prizeStrList

	scroll:reloadData((prizeCfg or nil) and string.split(prizeCfg.prize, "#"))
end

function GoddesscollectorRankView:_updateRewardCell(view, cell, cfgStr, tag)
	MaterialMgr.resetAll(cell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)

	proxy.binder:setEffStatus(false)
end

function GoddesscollectorRankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function GoddesscollectorRankView:_getRankPrizeCfg(rank)
	local cfgs = GoddesscollectorConfig.instance:getCollectorPrizeCfg(self._activityId)

	for i, v in pairs(cfgs) do
		if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			return v
		end
	end

	return nil
end

function GoddesscollectorRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)

	if self._scrollerHandlers[cell] then
		self._scrollerHandlers[cell]:dispose()
	end
end

function GoddesscollectorRankView:_updatePersonInfo()
	local str = ""
	local myRank = GoddesscollectorModel.instance:getMyRank()
	local time = GoddesscollectorController.instance:getPersonRankInfo(myRank)

	if myRank < 0 then
		str = "未上榜"

		GameUtil.SetActive(self._txtCollectTime, false)
	else
		str = myRank

		GameUtil.SetActive(self._txtCollectTime, true)
	end

	self._txtTime.text = "--"

	if time then
		local timeStr = ""
		local timeSec = checknumber(time)

		if timeSec > 0 then
			local timeDate = os.date("*t", timeSec / 1000)

			timeStr = string.format("%d %02d.%02d\n%02d:%02d:%02d", timeDate.year, timeDate.month, timeDate.day, timeDate.hour, timeDate.min, timeDate.sec)
		end

		self._txtTime.text = timeStr
	end

	self._txtMyRank.text = str

	self:_updateAllRank()
end

function GoddesscollectorRankView:_updateAllRank()
	local rankList = GoddesscollectorModel.instance:getRankInfos()

	self._rankList:reloadData(rankList)

	if #rankList <= 0 then
		GameUtil.SetActive(self._empty, true)
	else
		GameUtil.SetActive(self._empty, false)
	end
end

return GoddesscollectorRankView
