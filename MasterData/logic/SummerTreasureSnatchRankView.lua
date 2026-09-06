-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchRankView.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchRankView", package.seeall)

local SummerTreasureSnatchRankView = class("SummerTreasureSnatchRankView", ViewComponent)

function SummerTreasureSnatchRankView:ctor()
	SummerTreasureSnatchRankView.super.ctor(self)
end

function SummerTreasureSnatchRankView:unbindEvents()
	SummerTreasureSnatchRankView.super.unbindEvents(self)
end

function SummerTreasureSnatchRankView:bindEvents()
	SummerTreasureSnatchRankView.super.bindEvents(self)
end

function SummerTreasureSnatchRankView:buildUI()
	SummerTreasureSnatchRankView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._reward = self:getGo("reward")
	self._emptyGo = self:getGo("empty")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._rankScrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function SummerTreasureSnatchRankView:onExit()
	SummerTreasureSnatchRankView.super.onExit(self)
	self._rankScrollList:dispose()

	for _, scroll in pairs(self._scrollMap or {}) do
		if scroll then
			scroll:dispose()
		end
	end

	self._scrollMap = nil
end

function SummerTreasureSnatchRankView:onEnter()
	SummerTreasureSnatchRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SummerTreasureSnatchRankViewRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 623001
	end

	self._week = SummerTreasureSnatchController.instance:getCurWeek(self._activityId)
	self._scrollMap = {}

	SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchRankViewReq(self._activityId, false)
	self:_onUpdate(self._activityId)
end

function SummerTreasureSnatchRankView:_onUpdate(activityId)
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

function SummerTreasureSnatchRankView:_updateRankCell(view, cell, info)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "head")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local rewardView = goutil.findChild(mainGo, "rewardView")

	self._scrollMap[cell] = self._scrollMap[cell] or ScrollerList.create(rewardView, self._reward, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

	local rank = checknumber(info.rank)

	if not info.headInfo then
		local headInfo = {}
		local prizeList = self:_getPrizeListByRank(rank)

		self._scrollMap[cell]:reloadData(prizeList)

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

function SummerTreasureSnatchRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "head")

	if self._scrollMap then
		if self._scrollMap then
			self._scrollMap:dispose()

			self._scrollMap[cell] = nil
		end

		HeadItemController.instance:resetHeadCell(imgIcon)
	end
end

function SummerTreasureSnatchRankView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function SummerTreasureSnatchRankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function SummerTreasureSnatchRankView:_getPrizeListByRank(rank)
	local cfg = SummerTreasureSnatchConfig.instance:getRankPrizeCfgByRank(self._activityId, self._week, rank)

	if cfg then
		if not cfg.prize then
			local prize = ""

			if string.nilorempty(prize) then
				return {}
			end

			return string.split(prize, "#")
		end
	end
end

return SummerTreasureSnatchRankView
