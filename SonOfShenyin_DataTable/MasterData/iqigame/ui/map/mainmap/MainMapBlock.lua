-- chunkname: @IQIGame\\UI\\Map\\MainMap\\MainMapBlock.lua

local m = {
	isUnlock = false,
	isHasMainLine = false
}

function m.New(view, mapId)
	local obj = Clone(m)

	obj:Init(view, mapId)

	return obj
end

function m:Init(view, mapId)
	self.View = view
	self.MapID = mapId

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnEnterClick()
		self:OnEnterClick()
	end

	self.weatherImgCom = self.weatherImg:GetComponent("Image")

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnEnterClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnEnterClick)
end

function m:SetData()
	self:Refresh()
	self:RefreshChapterState()
end

function m:Refresh()
	self.isUnlock = ConditionModule.Check(CfgWorldMapTable[self.MapID].UnlockCondition) and CfgWorldMapTable[self.MapID].UnlockCondition ~= 0

	LuaUtility.SetGameObjectShow(self.LockState, not self.isUnlock)
	LuaUtility.SetGameObjectShow(self.ChapterState, self.isUnlock)
	LuaUtility.SetGameObjectShow(self.ChapterInfo, self.isUnlock)
	UGUIUtil.SetText(self.chapterName, CfgWorldMapTable[self.MapID].Name)
end

function m:RefreshChapterState()
	local classifitaionStages = MapModule.GetMapHasStageByMapID(self.MapID)

	LuaUtility.SetGameObjectShow(self.MainLineMark, #classifitaionStages[Constant.MapStageType.MainLine] > 0)
	LuaUtility.SetGameObjectShow(self.BranchLineMark, #classifitaionStages[Constant.MapStageType.BranchLine] > 0)
	LuaUtility.SetGameObjectShow(self.DailyMark, #classifitaionStages[Constant.MapStageType.Daily] > 0)

	self.isHasMainLine = #classifitaionStages[Constant.MapStageType.MainLine] > 0
end

function m:GetIsHasMainline()
	return self.isHasMainLine
end

function m:OnEnterClick()
	if not self.isUnlock then
		NoticeModule.ShowNotice(49005)

		return
	end

	if CfgWorldMapTable[self.MapID].PartLocation ~= 0 then
		EventDispatcher.Dispatch(EventID.ClickStageItemCellEvent, CfgWorldMapTable[self.MapID].PartLocation, true, true)
	else
		logError(string.format("%s地图定位位置不正确", self.MapID))
	end

	UIModule.Close(Constant.UIControllerName.ChapterMapUI)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
