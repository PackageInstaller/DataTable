-- chunkname: @IQIGame\\UI\\Map\\MainMap\\MapItemCell.lua

local m = {
	isCanClick = true,
	isMark = false
}
local alpha = {
	half = 0.5,
	normal = 1
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickChapter()
		self:OnClickChapter()
	end

	function self.DelegateOnOpenChapterDetailsEvent(itemId)
		self:OnOpenChapterDetailsEvent(itemId)
	end

	function self.DelegateOnCloseChapterDetailsEvent()
		self:OnCloseChapterDetailsEvent()
	end

	self.stageImgCanvasGroup = self.onStageImg:GetComponent("CanvasGroup")

	self:OnDefaultState()
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChapter)
	EventDispatcher.AddEventListener(EventID.OpenChapterDetailsEvent, self.DelegateOnOpenChapterDetailsEvent)
	EventDispatcher.AddEventListener(EventID.CloseChapterDetailEvent, self.DelegateOnCloseChapterDetailsEvent)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChapter)
	EventDispatcher.RemoveEventListener(EventID.OpenChapterDetailsEvent, self.DelegateOnOpenChapterDetailsEvent)
	EventDispatcher.RemoveEventListener(EventID.CloseChapterDetailEvent, self.DelegateOnCloseChapterDetailsEvent)
end

function m:SetData(worldItemCfg, isMark)
	self.worldMapItemCfg = worldItemCfg
	self.isMark = isMark
	self.View.name = self.worldMapItemCfg.Id
	self.stageID = self.worldMapItemCfg.Id

	LuaUtility.SetAnchoredPositionWithRectTransform(self.View:GetComponent("RectTransform"), self.worldMapItemCfg.Location[1], self.worldMapItemCfg.Location[2])

	if isMark == true then
		self:RefreshMarkInfo()
	else
		local stageType = self.worldMapItemCfg.Type

		if stageType == Constant.MapStageType.MainLine then
			self:RefreshMainLineInfo()
		elseif stageType == Constant.MapStageType.BranchLine then
			self:RefreshBranchLineInfo()
		else
			self:RefreshDailyInfo()
		end
	end

	self:RefreshCommonInfo()
end

function m:RefreshCommonInfo()
	self:OnResetOtherSelectState()
end

function m:RefreshMarkInfo()
	UGUIUtil.SetText(self.chapterName, self.worldMapItemCfg.Name)
	LuaUtility.SetGameObjectShow(self.commonState, false)
	LuaUtility.SetGameObjectShow(self.markItem, true)
	LuaUtility.SetScaleWithTransform(self.onStageImg.transform, self.worldMapItemCfg.MarkReduce, self.worldMapItemCfg.MarkReduce, self.worldMapItemCfg.MarkReduce)
	LuaUtility.SetScaleWithTransform(self.selectStageImg.transform, self.worldMapItemCfg.MarkReduce, self.worldMapItemCfg.MarkReduce, self.worldMapItemCfg.MarkReduce)
	LuaUtility.SetScaleWithTransform(self.nameItem.transform, self.worldMapItemCfg.NameReduce, self.worldMapItemCfg.NameReduce, self.worldMapItemCfg.NameReduce)

	if self.onStageImg then
		local stageImgCom = self.onStageImg:GetComponent("Image")

		AssetUtil.LoadImage(self, self.worldMapItemCfg.OffSign, stageImgCom, function()
			stageImgCom:SetNativeSize()
		end)
	end

	if self.selectStageImg then
		local selectStageImgCom = self.selectStageImg:GetComponent("Image")

		AssetUtil.LoadImage(self, self.worldMapItemCfg.OnSign, selectStageImgCom, function()
			selectStageImgCom:SetNativeSize()
		end)
	end

	self.newStageCfg = MapModule.GetMainLineNewUnlock()

	if not ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self.newStageCfg.ShowConditionId)) then
		LuaUtility.SetGameObjectShow(self.nameItem, false)

		self.isCanClick = false

		return
	end

	self.isCanClick = true

	if self.newStageCfg ~= nil and self.newStageCfg.WorldMapMarkID == self.worldMapItemCfg.Id then
		UGUIUtil.SetText(self.chapterName, string.format(ColorCfg.Purple, CfgWorldMapItemTable[self.newStageCfg.Id].Name))

		self.stageID = self.newStageCfg.Id

		LuaUtility.SetGameObjectShow(self.nameItem, true)
	else
		UGUIUtil.SetText(self.chapterName, string.format(ColorCfg.White, self.worldMapItemCfg.Name))
		LuaUtility.SetGameObjectShow(self.selectBg, false)

		self.stageID = nil

		local isOpenNameShow = CfgDiscreteDataTable[97].Data[1] == 1

		LuaUtility.SetGameObjectShow(self.nameItem, isOpenNameShow)
	end
end

function m:RefreshMainLineInfo()
	self.isCanClick = true

	UGUIUtil.SetText(self.chapterName, self.worldMapItemCfg.Name)

	local path = self.worldMapItemCfg.OnSign

	LuaUtility.SetGameObjectShow(self.commonState, true)
	LuaUtility.SetGameObjectShow(self.markItem, false)

	if not LuaUtility.StrIsNullOrEmpty(self.worldMapItemCfg.OffSign) and self.onStageImg then
		local stageImgCom = self.onStageImg:GetComponent("Image")

		AssetUtil.LoadImage(self, self.worldMapItemCfg.OffSign, stageImgCom, function()
			stageImgCom:SetNativeSize()
		end)
	end

	if not LuaUtility.StrIsNullOrEmpty(self.worldMapItemCfg.OnSign) and self.selectStageImg then
		local selectStageImgCom = self.selectStageImg:GetComponent("Image")

		AssetUtil.LoadImage(self, self.worldMapItemCfg.OnSign, selectStageImgCom, function()
			selectStageImgCom:SetNativeSize()
		end)
	end

	if MapModule.GetIsFinishByStageID(self.worldMapItemCfg.Id) then
		LuaUtility.SetGameObjectShow(self.selectBg, false)
		UGUIUtil.SetText(self.chapterName, string.format(ColorCfg.White, self.worldMapItemCfg.Name))
	else
		UGUIUtil.SetText(self.chapterName, string.format(ColorCfg.Map.Purple, self.worldMapItemCfg.Name))
	end
end

function m:RefreshBranchLineInfo()
	return
end

function m:RefreshDailyInfo()
	return
end

function m:OnClickChapter()
	if not self.isCanClick then
		return
	end

	MapModule.LastSelectedStageID = self.stageID

	EventDispatcher.Dispatch(EventID.ClickStageItemCellEvent, self.stageID)
end

function m:OnLocationState()
	if self:IsMainlineStage() or self.isMark then
		if self.isMark then
			self:SetMarkName(ColorCfg.White)
		else
			UGUIUtil.SetText(self.chapterName, string.format(ColorCfg.White, self.worldMapItemCfg.Name))
		end

		LuaUtility.SetGameObjectShow(self.selectBg, false)
	end

	LuaUtility.SetGameObjectShow(self.onLocation, true)

	if self.isMark == true then
		LuaUtility.SetGameObjectShow(self.onStageImg, false)
		LuaUtility.SetGameObjectShow(self.selectStageImg, true)
	elseif self:IsMainlineStage() then
		LuaUtility.SetGameObjectShow(self.commonOnStageImg, true)
		LuaUtility.SetGameObjectShow(self.commonOnSelect, false)
	else
		LuaUtility.SetGameObjectShow(self.onStageImg, false)
		LuaUtility.SetGameObjectShow(self.selectStageImg, false)
	end
end

function m:OnSelectState()
	if self:IsMainlineStage() or self.isMark then
		if self.isMark then
			self:SetMarkName(ColorCfg.Map.Purple)
		else
			UGUIUtil.SetText(self.chapterName, string.format(ColorCfg.Map.Purple, self.worldMapItemCfg.Name))
		end
	end

	LuaUtility.SetGameObjectShow(self.onLocation, true)

	if self.isMark == true then
		LuaUtility.SetGameObjectShow(self.selectBg, true)
		LuaUtility.SetGameObjectShow(self.onStageImg, false)
		LuaUtility.SetGameObjectShow(self.selectStageImg, true)
		LuaUtility.SetGameObjectShow(self.selectBg, true)
	elseif self:IsMainlineStage() then
		LuaUtility.SetGameObjectShow(self.commonOnStageImg, false)
		LuaUtility.SetGameObjectShow(self.commonOnSelect, true)
	else
		LuaUtility.SetGameObjectShow(self.onStageImg, false)
		LuaUtility.SetGameObjectShow(self.selectStageImg, true)
	end
end

function m:OnDefaultState()
	if self:IsMainlineStage() or self.isMark then
		if self.isMark then
			self:SetMarkName(ColorCfg.White)
		else
			UGUIUtil.SetText(self.chapterName, string.format(ColorCfg.White, self.worldMapItemCfg.Name))
		end

		LuaUtility.SetGameObjectShow(self.selectBg, false)
	end

	LuaUtility.SetGameObjectShow(self.onLocation, false)

	if self.isMark == true then
		LuaUtility.SetGameObjectShow(self.onStageImg, true)
		LuaUtility.SetGameObjectShow(self.selectStageImg, false)
	elseif self:IsMainlineStage() then
		LuaUtility.SetGameObjectShow(self.commonOnStageImg, true)
		LuaUtility.SetGameObjectShow(self.commonOnSelect, false)
	else
		LuaUtility.SetGameObjectShow(self.onStageImg, true)
		LuaUtility.SetGameObjectShow(self.selectStageImg, false)
	end
end

function m:SetMarkName(color)
	if self.newStageCfg ~= nil and self.newStageCfg.WorldMapMarkID == self.worldMapItemCfg.Id then
		UGUIUtil.SetText(self.chapterName, string.format(color, CfgWorldMapItemTable[self.newStageCfg.Id].Name))
	else
		UGUIUtil.SetText(self.chapterName, string.format(color, self.worldMapItemCfg.Name))
	end
end

function m:OnOtherSelectState()
	self:OnDefaultState()

	if self.isMark == true then
		-- block empty
	elseif self:IsMainlineStage() then
		self.View:GetComponent("CanvasGroup").alpha = alpha.half
	else
		self.stageImgCanvasGroup.alpha = alpha.half
	end
end

function m:OnResetOtherSelectState()
	self:OnDefaultState()

	if self.isMark == true then
		-- block empty
	elseif self:IsMainlineStage() then
		self.View:GetComponent("CanvasGroup").alpha = alpha.normal
	else
		self.stageImgCanvasGroup.alpha = alpha.normal
	end
end

function m:IsMainlineStage()
	return self.worldMapItemCfg ~= nil and Constant.MapStageType.MainLine == self.worldMapItemCfg.Type
end

function m:OnCloseChapterDetailsEvent()
	return
end

function m:GetPos()
	return self.View.transform.position
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self.newStageCfg = nil

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)
end

return m
