-- chunkname: @IQIGame\\UI\\ActivityList\\TreasureHuntActivity\\TreasureHuntActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local TreasureHuntActivityItemView = require("IQIGame/UI/ActivityList/TreasureHuntActivity/TreasureHuntActivityItemView")
local m = Clone(ActivityViewBase)

function m:__Init()
	self.awardsItemCell = {}

	ForTransformChild(self.AwardRoot.transform, function(_trans, _index)
		local item = TreasureHuntActivityItemView.New(_trans.gameObject)

		table.insert(self.awardsItemCell, item)
	end)
	UIEventUtil.AddClickEventListener_Button(self, "BtnRoot", self.__OnRaffle)
end

function m:__OnRaffle()
	if self.__isAllFinished then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, "您已经获取了所有奖励")

		return
	end

	if self.__isAnimShow then
		return
	end

	net_activity.raffle(self.__activityCid)
end

function m:__SetData(activityListCfg)
	self.activityListCfg = activityListCfg
	self.__activityCid = self.activityListCfg.ActivityID[1]

	local activityCfg = CfgActivityTable[self.__activityCid]
	local itemCid = activityCfg.ExtraParam[1]
	local needCount = activityCfg.ExtraParam[2]
	local haveCount = WarehouseModule.GetItemNumByCfgID(itemCid)

	self.CostText:GetComponent("Text").text = string.format("%s/%s", haveCount, needCount)

	local activityPOD = ActivityModule.GetActivityPodByID(self.__activityCid)
	local awardsTable = {}

	if activityPOD ~= nil then
		if activityPOD.treasureHuntPOD ~= nil then
			awardsTable = activityPOD.treasureHuntPOD.awards
		else
			logError("找不到抽奖活动数据 ActivityCid: {0}", self.__activityCid)
		end
	else
		logError("找不到活动数据 ActivityCid: {0}", self.__activityCid)
	end

	self.awardItems = {}

	ForPairs(CfgTreasureHuntActivityTable, function(_, _cfg)
		if _cfg.ActivityId ~= self.__activityCid then
			return
		end

		table.insert(self.awardItems, _cfg.Id)
	end)
	table.sort(self.awardItems, function(a, b)
		return a < b
	end)

	self.__isAnimShow = false
	self.__isAllFinished = true

	ForArray(self.awardsItemCell, function(_index, _cell)
		local cfgId = self.awardItems[_index]
		local isClose = ValueInArray(awardsTable, cfgId)

		if not isClose then
			self.__isAllFinished = false
		end

		_cell:Show(cfgId, isClose)
	end)
end

function m:__AddListeners()
	EventUtil.AddEventListener(self, EventID.OnRaffleResult, self.__OnRaffleResultHandler)
end

function m:__RemoveListeners()
	EventUtil.ClearEventListener(self)
end

function m:__OnRaffleResultHandler(awardCid, shows)
	self.__isAnimShow = true
	self.__animEndCid = awardCid
	self.__awardShows = shows
	self.__animIndex = 1
	self.__roundIndex = 0

	self:__ShowSelectAnim(self.__animIndex)

	self.__animTime = Timer.New(function()
		self:__ShowSelectAnim(self.__animIndex + 1)
	end, 0.15, -1)

	self.__animTime:Start()
end

function m:__ShowSelectAnim(index)
	local lastCell = self.awardsItemCell[self.__animIndex]

	lastCell:SetSelectShow(false)

	if index > #self.awardsItemCell then
		self.__roundIndex = self.__roundIndex + 1

		if self.__roundIndex < 3 then
			index = 1
		end
	end

	local cell = self.awardsItemCell[index]

	if cell == nil then
		self:__OnAnimEnd()

		return
	end

	if not cell:SetSelectShow(true) then
		self:__ShowSelectAnim(index + 1)

		return
	end

	self.__animIndex = index

	if self.__roundIndex < 2 then
		return
	end

	if cell.awardCid == self.__animEndCid then
		self:__OnAnimEnd()
	end
end

function m:__OnAnimEnd(notNext)
	if self.__animTime == nil then
		return
	end

	self.__animTime:Stop()

	self.__animTime = nil

	if notNext then
		return
	end

	UIModule.Open(Constant.UIControllerName.GetPanelUI, Constant.UILayer.UI, {
		items = self.__awardShows
	})
	self:__SetData(self.activityListCfg)
end

function m:__Dispose()
	self:__OnAnimEnd(true)
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
	ForArray(self.awardsItemCell, function(_, _itemCell)
		_itemCell:Dispose()
	end)
end

return m
