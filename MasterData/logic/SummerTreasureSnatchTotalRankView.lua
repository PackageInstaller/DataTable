-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchTotalRankView.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchTotalRankView", package.seeall)

local SummerTreasureSnatchTotalRankView = class("SummerTreasureSnatchTotalRankView", ViewComponent)

function SummerTreasureSnatchTotalRankView:ctor()
	SummerTreasureSnatchTotalRankView.super.ctor(self)
end

function SummerTreasureSnatchTotalRankView:unbindEvents()
	SummerTreasureSnatchTotalRankView.super.unbindEvents(self)
end

function SummerTreasureSnatchTotalRankView:bindEvents()
	SummerTreasureSnatchTotalRankView.super.bindEvents(self)
end

function SummerTreasureSnatchTotalRankView:buildUI()
	SummerTreasureSnatchTotalRankView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._emptyGo = self:getGo("empty")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._rankScrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function SummerTreasureSnatchTotalRankView:onExit()
	SummerTreasureSnatchTotalRankView.super.onExit(self)
	self._rankScrollList:dispose()
end

function SummerTreasureSnatchTotalRankView:onEnter()
	SummerTreasureSnatchTotalRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SummerTreasureSnatchRankViewRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 623001
	end

	SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchRankViewReq(self._activityId, true)
	self:_onUpdate(self._activityId)
end

function SummerTreasureSnatchTotalRankView:_onUpdate(activityId)
	if checknumber(activityId) > 0 and checknumber(activityId) ~= self._activityId then
		return
	end

	local rankInfo = SummerTreasureSnatchModel.instance:getRankInfo(self._activityId) or {}

	if not rankInfo.infoList then
		local infoList = {}
		local myRank = checknumber(rankInfo.myRank)
		local myDamage = checknumber(rankInfo.myDamage)

		self._txtMyRank.text = myRank > 0 and myRank or lang("未上榜")

		GameUtil.SetActive(self._emptyGo, #infoList <= 0)
		self._rankScrollList:reloadData(infoList)
	end
end

function SummerTreasureSnatchTotalRankView:_updateRankCell(view, cell, info)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "head")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local rank = checknumber(info.rank)

	if not info.headInfo then
		local headInfo = {}

		txtRank.text = rank
		txtScore.text = checknumber(info.value)
		txtName.text = headInfo.userName

		local isTop3 = rank > 0 and rank <= 3

		GameUtil.SetActive(imgRank.gameObject, isTop3)
		GameUtil.SetActive(txtRank.gameObject, not isTop3)

		if isTop3 then
			imgRank:SetState(rank - 1)
		end

		local timeSec = checknumber(info.time)
		local timeStr = ""

		if timeSec > 0 then
			local timeDate = os.date("*t", timeSec / 1000)

			timeStr = string.format("%d.%02d.%02d\n%02d:%02d:%02d", timeDate.year, timeDate.month, timeDate.day, timeDate.hour, timeDate.min, timeDate.sec)
		end

		txtTime.text = timeStr

		HeadItemController.instance:setHeadCellByInfo(imgIcon, headInfo, true)
	end
end

function SummerTreasureSnatchTotalRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(imgIcon)
end

return SummerTreasureSnatchTotalRankView
