-- chunkname: @IQIGame\\UI\\SummerActivity\\SummerActivityStageUI_stagePanel_stageItem.lua

local SummerActivityStageUI_stagePanel_stageItem = {}

function SummerActivityStageUI_stagePanel_stageItem.New(go, mainView)
	local o = Clone(SummerActivityStageUI_stagePanel_stageItem)

	o:Initialize(go, mainView)

	return o
end

function SummerActivityStageUI_stagePanel_stageItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SummerActivityStageUI_stagePanel_stageItem:InitComponent()
	return
end

function SummerActivityStageUI_stagePanel_stageItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function SummerActivityStageUI_stagePanel_stageItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function SummerActivityStageUI_stagePanel_stageItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function SummerActivityStageUI_stagePanel_stageItem:OnClickButtonClick()
	if not self.isUnlock then
		NoticeModule.ShowNotice(51022)

		return
	end

	EventDispatcher.Dispatch(EventID.SummerActivityStageUI_ShowStageDetailPanel, self.data.Id)
	self.mainView:OnStageSelected(self)
end

function SummerActivityStageUI_stagePanel_stageItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SummerActivityStageUI_stagePanel_stageItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function SummerActivityStageUI_stagePanel_stageItem:Selected()
	LuaUtility.SetGameObjectShow(self.selected, true)
end

function SummerActivityStageUI_stagePanel_stageItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.selected, false)
end

function SummerActivityStageUI_stagePanel_stageItem:Refresh()
	local idStr = string.gsub(self.gameObject.name, "stage_", "")
	local id = tonumber(idStr)

	self.data = CfgUtil.GetCfgWorldMapItemDataWithID(id)

	if not self.data then
		return
	end

	if self.bgGame ~= nil then
		if self.data.IsFight == 3 then
			LuaUtility.SetGameObjectShow(self.bgGame, true)
			LuaUtility.SetGameObjectShow(self.bgPlot, false)
			LuaUtility.SetGameObjectShow(self.bgBattle, false)
		else
			LuaUtility.SetGameObjectShow(self.bgGame, false)
			LuaUtility.SetGameObjectShow(self.bgPlot, self.data.PlotID > 0)
			LuaUtility.SetGameObjectShow(self.bgBattle, self.data.PlotID == 0)
		end
	else
		LuaUtility.SetGameObjectShow(self.bgPlot, self.data.PlotID > 0)
		LuaUtility.SetGameObjectShow(self.bgBattle, self.data.PlotID == 0)
	end

	LuaUtility.SetGameObjectShow(self.Finish, StoryChapterModule.GetStageIsCompleteWithID(self.data.Id))
	LuaUtility.SetText(self.textName, self.data.Name)

	self.isUnlock = ConditionModule.CheckConditionIsAllPass(self.data.EnterConditionId)

	LuaUtility.SetGameObjectShow(self.lockRoot, not self.isUnlock)
	LuaUtility.SetGameObjectShow(self.realLineRoot, self.isUnlock)

	if self.data.ShowConditionId and self.data.ShowConditionId[1] then
		local cfgCondition = CfgUtil.GetCfgConditionDataWithID(self.data.ShowConditionId[1])

		LuaUtility.SetText(self.textLock, cfgCondition.Name)
	else
		LuaUtility.SetText(self.textLock, "")
	end

	self:UnSelected()
end

function SummerActivityStageUI_stagePanel_stageItem:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return SummerActivityStageUI_stagePanel_stageItem
