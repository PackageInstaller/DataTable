-- chunkname: @IQIGame\\UI\\Dup\\ResourceStageUI_baseResItem.lua

local ResourceStageUI_baseResItem = {}
local multipleParentView = require("IQIGame.UI.Chapter.MultipleParentView")

function ResourceStageUI_baseResItem.New(go, mainView)
	local o = Clone(ResourceStageUI_baseResItem)

	o:Initialize(go, mainView)

	return o
end

function ResourceStageUI_baseResItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.resourceRewardItem = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ResourceStageUI_baseResItem:InitComponent()
	self.multipleParentView = multipleParentView.New(self.MultipleParent)
end

function ResourceStageUI_baseResItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function ResourceStageUI_baseResItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function ResourceStageUI_baseResItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function ResourceStageUI_baseResItem:OnClickButtonClick()
	if not self.lockStatus then
		NoticeModule.ShowNotice(19001)
	else
		GameChapterModule.SetupCurChapterUserData(self.userData)
		UIModule.Open(Constant.UIControllerName.StageUI, Constant.UILayer.UI, self.userData)
	end
end

function ResourceStageUI_baseResItem:OnDestroy()
	self.multipleParentView:Dispose()
end

function ResourceStageUI_baseResItem:Refresh(Data, dupTagCfg, isIdenticalActivityId)
	self.data = Data
	self.userData = {
		dupTagCfg = dupTagCfg,
		data = Data
	}
	self.isIdenticalActivityId = isIdenticalActivityId

	LuaUtility.SetText(self.stageInfoText, ActivityModule.GetActivityDesc(self.data.ActivityId))
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.data.TabImg), self.stageTitleImg:GetComponent("Image"))
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.data.ChapterNameImg), self.stageImg:GetComponent("Image"))

	if not LuaUtility.StrIsNullOrEmpty(self.data.NameImg) then
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.data.NameImg), self.ResNameImg:GetComponent("Image"))
	end

	for i, v in pairs(self.resourceRewardItem) do
		LuaUtility.SetGameObjectShow(self.resourceRewardItem[i], false)
	end

	for k, v in ipairs(self.data.ItemID) do
		local obj = self.resourceRewardItem[k]

		if not obj then
			obj = UnityEngine.GameObject.Instantiate(self.rewardItem, self.rewardParent.transform)

			table.insert(self.resourceRewardItem, obj)
		end

		local cfgItem = CfgUtil.GetItemCfgDataWithID(v)

		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), obj.transform:Find("rewardItemImg").gameObject:GetComponent("Image"))
		obj.transform:Find("diySkillBg").gameObject:SetActive(cfgItem.DiySkillBg)
		obj:SetActive(true)
	end

	LuaUtility.SetText(self.stageTips, self.data.Desc)

	self.lockStatus = ConditionModule.Check(self.data.UnlockConditionId)

	LuaUtility.SetGameObjectShow(self.lockState, not self.lockStatus)

	local cfgCondition = CfgUtil.GetCfgConditionDataWithID(self.data.UnlockConditionId)

	LuaUtility.SetText(self.ConditionText, cfgCondition.Name)
	self:RefreshMultipleShow()
end

function ResourceStageUI_baseResItem:RefreshMultipleShow()
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

return ResourceStageUI_baseResItem
