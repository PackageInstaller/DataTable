-- chunkname: @IQIGame\\UI\\Dup\\ResourceStageUI_bossStageItem.lua

local ResourceStageUI_bossStageItem = {}
local multipleParentView = require("IQIGame.UI.Chapter.MultipleParentView")

function ResourceStageUI_bossStageItem.New(go, mainView)
	local o = Clone(ResourceStageUI_bossStageItem)

	o:Initialize(go, mainView)

	return o
end

function ResourceStageUI_bossStageItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.boosRewardItem = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ResourceStageUI_bossStageItem:InitComponent()
	self.multipleParentView = multipleParentView.New(self.MultipleParent)
end

function ResourceStageUI_bossStageItem:InitDelegate()
	function self.DelegateOnClick()
		self:OnClick()
	end

	function self.DelegateOnActivityCloseEvent()
		self:OnActivityCloseEvent()
	end
end

function ResourceStageUI_bossStageItem:AddListener()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	EventDispatcher.AddEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityCloseEvent)
end

function ResourceStageUI_bossStageItem:RemoveListener()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	EventDispatcher.RemoveEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityCloseEvent)
end

function ResourceStageUI_bossStageItem:OnDestroy()
	self.multipleParentView:Dispose()
	self:RemoveListener()
end

function ResourceStageUI_bossStageItem:Refresh(data, dupTagCfg, isIdenticalActivityId)
	self.data = data
	self.userData = {
		dupTagCfg = dupTagCfg,
		data = data
	}
	self.isIdenticalActivityId = isIdenticalActivityId

	self:CheckOff()
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(data.TabImg), self.bossTabImage:GetComponent("Image"))
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(data.ChapterNameImg), self.bossBg:GetComponent("Image"))
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(data.BossChapterImg), self.stageImg:GetComponent("Image"))
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(data.BigImg), self.bossImage1:GetComponent("Image"), function()
		self.bossImage1:GetComponent("Image"):SetNativeSize()
	end)

	if not LuaUtility.StrIsNullOrEmpty(data.SmallImg) then
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(data.SmallImg), self.bossImage2:GetComponent("Image"))
		LuaUtility.SetGameObjectShow(self.bossImage2, true)
	else
		LuaUtility.SetGameObjectShow(self.bossImage2, false)
	end

	self:ResetRewardItemStatus(self.boosRewardItem)

	for k, v in ipairs(data.ItemID) do
		local obj = self.boosRewardItem[k]

		if not obj then
			obj = UnityEngine.GameObject.Instantiate(self.rewardItem, self.rewardGrid.transform)

			table.insert(self.boosRewardItem, obj)
		end

		local cfgItem = CfgUtil.GetItemCfgDataWithID(v)

		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), obj.transform:Find("rewardItem").gameObject:GetComponent("Image"))
		LuaUtility.SetGameObjectShow(obj, true)
	end

	LuaUtility.SetGameObjectShow(self.line1, data.IsTrue)
	LuaUtility.SetText(self.stageNameText, data.Name)
	LuaUtility.SetGameObjectShow(stageInfoText, false)
	self:CheckLock(self)
	self:RefreshMultipleShow()
end

function ResourceStageUI_bossStageItem:ResetRewardItemStatus(rewardItem)
	for i = 1, #rewardItem do
		local obj = rewardItem[i]

		LuaUtility.SetGameObjectShow(obj, false)
	end
end

function ResourceStageUI_bossStageItem:CheckLock(obj)
	if ConditionModule.Check(self.userData.data.UnlockConditionId) then
		LuaUtility.SetGameObjectShow(obj.lockState, false)

		self.lockStatus = false
	else
		LuaUtility.SetGameObjectShow(obj.lockState, true)

		self.lockStatus = true
	end
end

function ResourceStageUI_bossStageItem:OnClick()
	if self.lockStatus then
		NoticeModule.ShowNotice(19001)
	else
		GameChapterModule.SetupCurChapterUserData(self.userData)
		UIModule.Open(Constant.UIControllerName.StageUI, Constant.UILayer.UI, self.userData)
	end
end

function ResourceStageUI_bossStageItem:OnActivityCloseEvent()
	self:RefreshMultipleShow()
end

function ResourceStageUI_bossStageItem:RefreshMultipleShow()
	if self.isIdenticalActivityId == false and self.data.ActivityTag ~= nil and self.data.ActivityTag ~= 0 then
		local activityPod = ActivityModule.GetActivityPodByActivityTag(Constant.ActivityType.ActivityType_DupMultiple_12, self.data.ActivityTag)

		if activityPod ~= nil then
			self.multipleParentView:Show()
			self.multipleParentView:SetData(activityPod)
			LuaUtility.SetGameObjectShow(self.doubleRoot, true)

			return
		end
	end

	LuaUtility.SetGameObjectShow(self.doubleRoot, false)
	self.multipleParentView:Hide()
end

function ResourceStageUI_bossStageItem:CheckOn()
	LuaUtility.SetGameObjectShow(self.checkState, true)
end

function ResourceStageUI_bossStageItem:CheckOff()
	LuaUtility.SetGameObjectShow(self.checkState, false)
end

return ResourceStageUI_bossStageItem
