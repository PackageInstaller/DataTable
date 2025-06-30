-- chunkname: @IQIGame\\UI\\ResourceStageUI.lua

local ResourceStageUI = {
	isIdenticalActivityId = false,
	selectedTagId = 1,
	dupCalls = {}
}

ResourceStageUI = Base:Extend("ResourceStageUI", "IQIGame.Onigao.UI.ResourceStageUI", ResourceStageUI)

local dupTagCall = require("IQIGame.UI.Dup.DupTagCell")
local dupCall = require("IQIGame.UI.Dup.DupCell")
local bossStageItemClass = require("IQIGame.UI.Dup.ResourceStageUI_bossStageItem")
local baseResItemClass = require("IQIGame.UI.Dup.ResourceStageUI_baseResItem")
local equipStageItemClass = require("IQIGame.UI.Dup.ResourceStageUI_equipStageItem")
local roleDevelopmentStageItemClass = require("IQIGame.UI.Dup.ResourceStageUI_roleDevelopmentStageItem")
local intergralRewardView = require("IQIGame.UI.Dup.IntergralRewardView")
local multipleParentView = require("IQIGame.UI.Chapter.MultipleParentView")

function ResourceStageUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function ResourceStageUI:InitMembers()
	self.tagCalls = {}
	self.bossStageCellList = {}
	self.baseResCellList = {}
	self.equipStageCellList = {}
	self.roleDevelopmentStageCellList = {}
	self.chapterDataArray = {}
end

function ResourceStageUI:InitComponent()
	self.tagScroll = self.tabScroll:GetComponent("OptimizedScrollRect")

	self.tagScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTagScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.dupScroll = self.stageScroll:GetComponent("OptimizedScrollRect")

	self.dupScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateDupScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.bossStageScroll = self.bossStageScroll:GetComponent("OptimizedScrollRect")

	self.bossStageScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateBossStageScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.baseResourceScroll = self.baseResourceScroll:GetComponent("OptimizedScrollRect")

	self.baseResourceScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateBaseResStageScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.equipStageScroll = self.equipStageScroll:GetComponent("OptimizedScrollRect")

	self.equipStageScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateEquipStageScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.roleDevelopmentStageScroll = self.roleDevelopmentStageScroll:GetComponent("OptimizedScrollRect")

	self.roleDevelopmentStageScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateRoleDevelopmentStageScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.commonReturnBtn:RegisterReturnEvent(function()
		GameChapterModule.ClearCache()
		UIModule.CloseSelf(self)
	end)

	self.intergralRewardView = intergralRewardView.New(self.IntergralRewardPanel)
	self.multipleParent = multipleParentView.New(self.MultipleParent)
	self.snapper = self.bossStageScroll:GetComponent("Com.TheFallenGames.OSA.Core.Snapper8")
	self.snapper.SnappingEndedOrCancelled = self.snapper.SnappingEndedOrCancelled + self.onSnapperEndDelegate
	self.GraphicRayCaster = self.gameObject:GetComponent(typeof(UnityEngine.UI.GraphicRaycaster))
end

function ResourceStageUI:OnOpen(userData)
	self.tagId = userData.tagId
	self.selectedTagId = userData.selectedTagId
	self.selectedTag = nil

	self:InitData()
	self:ShowTag()
	GameChapterModule.SetPlayingMethodDuoTag(self.tagId)

	if self.selectedTagId then
		for _, v in pairs(self.tagCalls) do
			if v.data.Id == self.selectedTagId then
				v:OnClick()

				break
			end
		end
	else
		local viewsHolder = self.tagScroll:GetItemViewsHolder(0)

		if viewsHolder then
			local instanceID = viewsHolder.instanceID

			self.tagCalls[instanceID]:OnClick()
		end
	end

	self.intergralRewardView:Hide()
end

function ResourceStageUI:OnClose(userData)
	return
end

function ResourceStageUI:InitDelegate()
	function self.onSnapperEndDelegate()
		self:OnSnapperEnd()
	end

	function self.DelegateOnClickforwardBtn()
		self:OnClickforwardBtn()
	end

	function self.DelegateOnClickbackBtn()
		self:OnClickbackBtn()
	end

	function self.DelegateOnClickIntergralRewardBtn()
		self:OnClickIntergralRewardBtn()
	end

	function self.DelegateOnTaskNotifyFinish(tasks)
		self:OnTaskNotifyFinish(tasks)
	end

	function self.DelegateOnTaskNotifyTask(tasks)
		self:OnTaskNotifyFinish(tasks)
	end

	function self.DelegateOnActivityCloseEvent()
		self:OnActivityCloseEvent()
	end

	function self.delegateOnClickBossButtonLeft()
		self:OnClickBossButtonLeft()
	end

	function self.delegateOnClickBossButtonRight()
		self:OnClickBossButtonRight()
	end
end

function ResourceStageUI:OnAddListeners()
	self.forwardBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickforwardBtn)
	self.backBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickbackBtn)
	self.integralRewardBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickIntergralRewardBtn)
	self.bossButtonLeft:GetComponent("Button").onClick:AddListener(self.delegateOnClickBossButtonLeft)
	self.bossButtonRight:GetComponent("Button").onClick:AddListener(self.delegateOnClickBossButtonRight)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyTask)
	EventDispatcher.AddEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityCloseEvent)
end

function ResourceStageUI:OnRemoveListeners()
	self.forwardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickforwardBtn)
	self.backBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickbackBtn)
	self.integralRewardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickIntergralRewardBtn)
	self.bossButtonLeft:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickBossButtonLeft)
	self.bossButtonRight:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickBossButtonRight)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyTask)
	EventDispatcher.RemoveEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityCloseEvent)
end

function ResourceStageUI:OnClickBossButtonLeft()
	local distance
	local viewsHolder = self.snapper:GetMiddleVH(distance)
	local index = viewsHolder.ItemIndex

	if index <= 0 then
		return
	end

	index = index - 1
	self.GraphicRayCaster.enabled = false

	self.bossStageScroll:SmoothScrollTo(index, 0.3, 0.5, 0.5, nil, function()
		self:OnSnapperEnd()

		self.GraphicRayCaster.enabled = true
	end)
end

function ResourceStageUI:OnClickBossButtonRight()
	local distance
	local viewsHolder = self.snapper:GetMiddleVH(distance)
	local index = viewsHolder.ItemIndex

	if index >= #self.chapterDataArray - 1 then
		return
	end

	index = index + 1
	self.GraphicRayCaster.enabled = false

	self.bossStageScroll:SmoothScrollTo(index, 0.3, 0.5, 0.5, nil, function()
		self:OnSnapperEnd()

		self.GraphicRayCaster.enabled = true
	end)
end

function ResourceStageUI:OnSnapperEnd()
	local distance
	local viewsHolder = self.snapper:GetMiddleVH(distance)
	local instanceID = viewsHolder.instanceID
	local view = self.bossStageCellList[instanceID]

	if self.currentBossCheckItem then
		self.currentBossCheckItem:CheckOff()

		self.currentBossCheckItem = nil
	end

	view:CheckOn()

	self.currentBossCheckItem = view
end

function ResourceStageUI:GetPreloadAssetPaths()
	return nil
end

function ResourceStageUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ResourceStageUI:IsManualShowOnOpen(userData)
	return false
end

function ResourceStageUI:GetBGM(userData)
	return nil
end

function ResourceStageUI:OnPause()
	return
end

function ResourceStageUI:OnResume()
	return
end

function ResourceStageUI:OnCover()
	return
end

function ResourceStageUI:OnReveal()
	return
end

function ResourceStageUI:OnRefocus(userData)
	return
end

function ResourceStageUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ResourceStageUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ResourceStageUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ResourceStageUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ResourceStageUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.intergralRewardView:Dispose()
	self.commonReturnBtn:Dispose()
	self.multipleParent:Dispose()

	for i, v in pairs(self.tagCalls) do
		v:OnDestroy()
	end

	for _, v in pairs(self.dupCalls) do
		v:OnDestroy()
	end

	for _, v in pairs(self.baseResCellList) do
		v:OnDestroy()
	end

	for _, v in pairs(self.equipStageCellList) do
		v:OnDestroy()
	end

	for _, v in pairs(self.roleDevelopmentStageCellList) do
		v:OnDestroy()
	end

	for _, v in pairs(self.bossStageCellList) do
		v:OnDestroy()
	end
end

function ResourceStageUI:OnClickforwardBtn()
	return
end

function ResourceStageUI:OnClickbackBtn()
	return
end

function ResourceStageUI:OnTaskNotifyFinish(tasks)
	self:OnClickIntergralRewardBtn()
end

function ResourceStageUI:OnActivityCloseEvent()
	self:RefreshMultipleShow()
end

function ResourceStageUI:SetIntergralRewardBtnState(dupTagId)
	local dupTagCfg = CfgDupTagTable[dupTagId]
	local isShow = false

	LuaUtility.SetGameObjectShow(self.intergralRewardParent, isShow)

	if not isShow then
		return
	end

	self.curScheduleNum = 0
	self.needScheduleNum = 0
	self.taskList = TaskSystemModule.GetSortForTypeDataList(dupTagCfg.Type, dupTagCfg.TypeExtend, TaskSystemModule.sortType.Id, true, true)

	for i = 1, #self.taskList do
		self.curScheduleNum = self.curScheduleNum + self.taskList[i].schedule
	end

	self.curScheduleNum = WarehouseModule.GetItemNumByCfgID(110)
	self.needScheduleNum = self.taskList[#self.taskList].needSchedule

	UGUIUtil.SetText(self.curIntergralText, self.curScheduleNum)
	UGUIUtil.SetText(self.AllIntergralText, "/" .. self.needScheduleNum)
end

function ResourceStageUI:OnClickIntergralRewardBtn()
	if self.curScheduleNum == nil or self.needScheduleNum == nil then
		return
	end

	self.intergralRewardView:Show()
	self.intergralRewardView:SetData(self.taskList, self.curScheduleNum, self.needScheduleNum)
end

function ResourceStageUI:InitData()
	self.tagDatas = {}

	for k, v in pairs(CfgDupTagTable) do
		if v.ParentID == self.tagId then
			table.insert(self.tagDatas, v)
		end
	end

	table.sort(self.tagDatas, function(a, b)
		local unLockA = false

		for i = 1, #a.UnlockConditionId do
			unLockA = ConditionModule.Check(a.UnlockConditionId[i])
		end

		local unLockB = false

		for i = 1, #b.UnlockConditionId do
			unLockB = ConditionModule.Check(b.UnlockConditionId[i])
		end

		if unLockA ~= unLockB then
			return unLockA == true
		end

		return a.Id < b.Id
	end)
end

function ResourceStageUI:RefreshMultipleShow()
	local activityType

	if self.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_RESOURCES then
		activityType = Constant.ActivityType.ActivityType_DupMultiple_12
	elseif self.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_EQUIP then
		activityType = Constant.ActivityType.ActivityType_DupMultiple_11
	end

	self.isIdenticalActivityTag, self.chapterActivityTag = GameChapterModule.GetIsIdenticalActivityTag(self.dupTagCfg)

	if self.isIdenticalActivityTag == true then
		local activityPod = ActivityModule.GetActivityPodByActivityTag(activityType, self.chapterActivityTag)

		if activityPod ~= nil then
			self.multipleParent:Show()
			self.multipleParent:SetData(activityPod, true)

			return
		end
	end

	self.multipleParent:Hide()
end

function ResourceStageUI:RefreshDup(id)
	self.dupTagCfg = CfgUtil.GetCfgDupTagDataWithID(id)
	self.chapterDataArray = ChapterModule.GetCfgChapterDataWithType(id)
	GameChapterModule.lastSelectChapterTagId = id

	self:RefreshMultipleShow()
	LuaUtility.SetGameObjectShow(self.dupScroll.gameObject, false)
	LuaUtility.SetGameObjectShow(self.bossStageScroll.gameObject, false)
	LuaUtility.SetGameObjectShow(self.baseResourceScroll.gameObject, false)
	LuaUtility.SetGameObjectShow(self.equipStageScroll.gameObject, false)
	LuaUtility.SetGameObjectShow(self.roleDevelopmentStageScroll.gameObject, false)
	LuaUtility.SetGameObjectShow(self.bossCountPanel.gameObject, false)

	if self.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Boss then
		local useCount = BossChapterModule.ReduceRewardCount()
		local limitcount = CfgDiscreteDataTable[Constant.DiscreteData.BOSS_COUNT].Data[1]

		UGUIUtil.SetText(self.countText, math.max(limitcount - useCount, 0) .. "/" .. limitcount)
		LuaUtility.SetGameObjectShow(self.bossCountPanel.gameObject, true)
		LuaUtility.SetGameObjectShow(self.bossStageScroll.gameObject, true)
		self.bossStageScroll:RefreshByItemCount(#self.chapterDataArray)
		self.bossStageScroll:SetNormalizedPosition(0)
		self:OnClickBossButtonLeft()
	elseif self.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.BaseResource then
		LuaUtility.SetGameObjectShow(self.baseResourceScroll.gameObject, true)
		self.baseResourceScroll:RefreshByItemCount(#self.chapterDataArray)

		if #self.chapterDataArray > 0 then
			self.baseResourceScroll:ScrollTo(0)
		end
	elseif self.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Equip then
		LuaUtility.SetGameObjectShow(self.equipStageScroll.gameObject, true)
		self.equipStageScroll:RefreshByItemCount(#self.chapterDataArray)

		if #self.chapterDataArray > 0 then
			self.equipStageScroll:ScrollTo(0)
		end
	elseif self.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.RoleDevelopment then
		LuaUtility.SetGameObjectShow(self.roleDevelopmentStageScroll.gameObject, true)
		self.roleDevelopmentStageScroll:RefreshByItemCount(#self.chapterDataArray)

		if #self.chapterDataArray > 0 then
			self.roleDevelopmentStageScroll:ScrollTo(0)
		end
	elseif self.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Tower then
		LuaUtility.SetGameObjectShow(self.dupScroll.gameObject, true)
		self.dupScroll:RefreshByItemCount(#self.chapterDataArray)

		if #self.chapterDataArray > 0 then
			self.dupScroll:ScrollTo(0)
		end
	end
end

function ResourceStageUI:RefreshDup_old(id)
	self.dupTagCfg = CfgDupTagTable[id]

	self:RefreshMultipleShow()

	self.dupDatas = {}
	self.baseResDataArray = {}

	if self.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_RESOURCES then
		self:FilterDup(CfgDailyDupChapterTable)
	elseif self.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_EQUIP then
		self:FilterDup(CfgEquipDupChapterTable)
	elseif self.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_BOSS then
		self:FilterDup(CfgBossChapterTable)
	elseif self.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		self:FilterDup(CfgTowerChapterTable)
	end

	table.sort(self.dupDatas, function(a, b)
		return a.Index < b.Index
	end)
	LuaUtility.SetGameObjectShow(self.dupScroll.gameObject, false)
	LuaUtility.SetGameObjectShow(self.bossStageScroll.gameObject, false)

	if self.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Boss then
		LuaUtility.SetGameObjectShow(self.bossStageScroll.gameObject, true)
		self.bossStageScroll:RefreshByItemCount(#self.dupDatas)

		if #self.dupDatas > 0 then
			self.bossStageScroll:ScrollTo(0)
		end
	else
		LuaUtility.SetGameObjectShow(self.dupScroll.gameObject, true)
		self.dupScroll:RefreshByItemCount(#self.dupDatas)

		if #self.dupDatas > 0 then
			self.dupScroll:ScrollTo(0)
		end
	end

	self:SetIntergralRewardBtnState(id)
end

function ResourceStageUI:FilterDup(cfg)
	for k, v in pairs(cfg) do
		if ConditionModule.Check(v.UnlockConditionId) then
			if #self.dupTagCfg.FilterIds > 0 then
				if table.indexOf(self.dupTagCfg.FilterIds, k) ~= -1 then
					table.insert(self.dupDatas, v)
				end
			else
				table.insert(self.dupDatas, v)
			end
		end
	end
end

function ResourceStageUI:ShowTag()
	self.tagScroll:RefreshByItemCount(#self.tagDatas)

	if #self.tagDatas > 0 then
		self.tagScroll:ScrollTo(0)
	end
end

function ResourceStageUI:UpdateTagScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex

	if not self.tagCalls[instanceID] then
		self.tagCalls[instanceID] = dupTagCall.New(viewGameObject, self)
	end

	self.tagCalls[instanceID]:Refresh(self.tagDatas[index + 1], index + 1)
end

function ResourceStageUI:UpdateDupScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex

	if not self.chapterDataArray[instanceID] then
		self.dupCalls[instanceID] = dupCall.New(viewGameObject)
	end

	self.dupCalls[instanceID]:Refresh(self.chapterDataArray[index + 1], self.dupTagCfg, self.isIdenticalActivityTag)
end

function ResourceStageUI:UpdateBossStageScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex + 1
	local data = self.chapterDataArray[index]

	if not self.bossStageCellList[instanceID] then
		self.bossStageCellList[instanceID] = bossStageItemClass.New(viewGameObject, self)
	end

	self.bossStageCellList[instanceID]:Refresh(data, self.dupTagCfg, self.isIdenticalActivityTag)

	self.bossStageCellList[instanceID].gameObject = index
end

function ResourceStageUI:UpdateBaseResStageScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex + 1
	local data = self.chapterDataArray[index]

	if not self.baseResCellList[instanceID] then
		self.baseResCellList[instanceID] = baseResItemClass.New(viewGameObject, self)
	end

	self.baseResCellList[instanceID]:Refresh(data, self.dupTagCfg, self.isIdenticalActivityTag)

	self.baseResCellList[instanceID].gameObject.name = index
end

function ResourceStageUI:UpdateEquipStageScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex + 1
	local data = self.chapterDataArray[index]

	if not self.equipStageCellList[instanceID] then
		self.equipStageCellList[instanceID] = equipStageItemClass.New(viewGameObject, self)
	end

	self.equipStageCellList[instanceID]:Refresh(data, self.dupTagCfg, self.isIdenticalActivityTag)

	self.equipStageCellList[instanceID].gameObject.name = index
end

function ResourceStageUI:UpdateRoleDevelopmentStageScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex + 1
	local data = self.chapterDataArray[index]

	if not self.roleDevelopmentStageCellList[instanceID] then
		self.roleDevelopmentStageCellList[instanceID] = roleDevelopmentStageItemClass.New(viewGameObject, self)
	end

	self.roleDevelopmentStageCellList[instanceID]:Refresh(data, self.dupTagCfg, self.isIdenticalActivityTag)

	self.roleDevelopmentStageCellList[instanceID].gameObject.name = index
end

return ResourceStageUI
