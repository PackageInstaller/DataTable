-- chunkname: @IQIGame\\UI\\ActivityList\\DupMultipleActivity\\DupMultipleActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local ActivityItemView = {}

function ActivityItemView.New(view)
	local obj = Clone(ActivityItemView)

	obj:Init(view)

	return obj
end

function ActivityItemView:Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)

	function self.DelegateOnClickJumpBtn()
		self:OnClickJumpBtn()
	end

	self:AddListeners()
end

function ActivityItemView:AddListeners()
	self.JumpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickJumpBtn)
end

function ActivityItemView:RemoveListeners()
	self.JumpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickJumpBtn)
end

function ActivityItemView:SetData(activityPOD)
	self.activityCfg = CfgActivityTable[activityPOD.cid]

	UGUIUtil.SetText(self.Name, DupMultipleActivityUIApi:GetChapterNameByTag(self.activityCfg.ExtraParam[4]))
	UGUIUtil.SetText(self.DayNumText, string.format("(%s/%s)", self.activityCfg.ExtraParam[2] - activityPOD.dupDropPOD.dayNum, self.activityCfg.ExtraParam[2]))
	UGUIUtil.SetText(self.AllNumText, string.format("(%s/%s)", self.activityCfg.ExtraParam[1] - activityPOD.dupDropPOD.sumNum, self.activityCfg.ExtraParam[1]))
end

function ActivityItemView:OnClickJumpBtn()
	JumpModule.Jump(self.activityCfg.Source[1])
	UIModule.Close(Constant.UIControllerName.DupMultipleActivityUI)
end

function ActivityItemView:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local m = Clone(ActivityViewBase)

m.ActivityItemList = {}
m.ActivityDatas = {}

function m:__Init()
	self.wrapContent = self.ScrollView:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.DelegateOnClickDetailBtn()
		self:OnClickDetailBtn()
	end
end

function m:__AddListeners()
	self.DetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDetailBtn)
end

function m:__RemoveListeners()
	self.DetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDetailBtn)
end

function m:__SetData(activityListCfg)
	self.activityListCfg = activityListCfg

	self:RefreshActivityShow()
end

function m:RefreshActivityShow()
	self.ActivityDatas = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_DupMultiple_11,
		Constant.ActivityType.ActivityType_DupMultiple_12
	})

	local activityPOD = self.ActivityDatas[1]

	for i = 1, #self.activityListCfg.ActivityID do
		activityPOD = table.search(self.ActivityDatas, function(k, v)
			if v.cid == self.activityListCfg.ActivityID[i] then
				return true
			end
		end)

		if activityPOD ~= nil then
			break
		end
	end

	self.activityCfg = CfgActivityTable[activityPOD.cid]

	UGUIUtil.SetText(self.allNotUsedText, self.activityCfg.ExtraParam[1] - activityPOD.dupDropPOD.sumNum)
	UGUIUtil.SetText(self.allCountText, "/" .. self.activityCfg.ExtraParam[1])
	UGUIUtil.SetText(self.dayNotUsedText, self.activityCfg.ExtraParam[2] - activityPOD.dupDropPOD.dayNum)
	UGUIUtil.SetText(self.dayCountText, "/" .. self.activityCfg.ExtraParam[2])
	UGUIUtil.SetText(self.activityDesc, self.activityListCfg.Desc)
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.activityListCfg.ChapterNameImg), self.activityImg:GetComponent("Image"))
	self:RefreshCountdown()
end

function m:RefreshCountdown()
	self.endTime = cfgDateTimeToTimeStamp(self.activityCfg.OpenTime) + self.activityCfg.Duration[1]

	self:UpdateSurplusTime()

	if self.timer == nil then
		self.timer = Timer.New(function()
			self:UpdateSurplusTime()
		end, 1, -1)

		self.timer:Start()
	end
end

function m:UpdateSurplusTime()
	local surplusTime = math.floor(self.endTime - tonumber(PlayerModule.GetServerTime()))

	surplusTime = math.max(0, surplusTime)

	UGUIUtil.SetText(self.timeText, DateStandardFormation(surplusTime))
end

function m:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()
	end

	self.timer = nil
end

function m:OnClickDetailBtn()
	JumpModule.Jump(self.activityCfg.Source[1])
end

function m:__Dispose()
	self:StopTimer()
end

return m
