-- chunkname: @IQIGame\\UI\\Dup\\ResourceStageUI_equipStageItem.lua

local ResourceStageUI_equipStageItem = {}
local multipleParentView = require("IQIGame.UI.Chapter.MultipleParentView")

function ResourceStageUI_equipStageItem.New(go, mainView)
	local o = Clone(ResourceStageUI_equipStageItem)

	o:Initialize(go, mainView)

	return o
end

function ResourceStageUI_equipStageItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.equipRewardItem = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ResourceStageUI_equipStageItem:InitComponent()
	self.multipleParentView = multipleParentView.New(self.MultipleParent)
end

function ResourceStageUI_equipStageItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function ResourceStageUI_equipStageItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function ResourceStageUI_equipStageItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function ResourceStageUI_equipStageItem:OnClickButtonClick()
	if not self.lockStatus then
		NoticeModule.ShowNotice(19001)
	else
		GameChapterModule.SetupCurChapterUserData(self.userData)
		UIModule.Open(Constant.UIControllerName.StageUI, Constant.UILayer.UI, self.userData)
	end
end

function ResourceStageUI_equipStageItem:OnDestroy()
	self.multipleParentView:Dispose()
end

function ResourceStageUI_equipStageItem:Refresh(Data, dupTagCfg, isIdenticalActivityId)
	self.data = Data
	self.userData = {
		dupTagCfg = dupTagCfg,
		data = Data
	}
	self.isIdenticalActivityId = isIdenticalActivityId

	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.data.TabImg), self.stageTitleImg:GetComponent("Image"))
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.data.ChapterNameImg), self.stageImg:GetComponent("Image"))

	for i, v in pairs(self.equipRewardItem) do
		LuaUtility.SetGameObjectShow(self.equipRewardItem[i], false)
	end

	for k, v in ipairs(self.data.ItemID) do
		local obj = self.equipRewardItem[k]

		if not obj then
			obj = UnityEngine.GameObject.Instantiate(self.rewardItem, self.rewardParent.transform)

			table.insert(self.equipRewardItem, obj)
		end

		local cfgItem = CfgUtil.GetItemCfgDataWithID(v)

		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), obj.transform:Find("rewardItemImg").gameObject:GetComponent("Image"))
		obj:SetActive(true)
	end

	LuaUtility.SetText(self.stageNameText, self.data.Name)

	self.lockStatus = ConditionModule.Check(self.data.UnlockConditionId)

	LuaUtility.SetGameObjectShow(self.lockState, not self.lockStatus)

	local cfgCondition = CfgUtil.GetCfgConditionDataWithID(self.data.UnlockConditionId)

	LuaUtility.SetText(self.ConditionText, cfgCondition.Name)
	self:RefreshMultipleShow()
end

function ResourceStageUI_equipStageItem:RefreshMultipleShow()
	if self.isIdenticalActivityId == false and self.data.ActivityTag ~= nil and self.data.ActivityTag ~= 0 then
		local activityPod = ActivityModule.GetActivityPodByActivityTag(Constant.ActivityType.ActivityType_DupMultiple_11, self.data.ActivityTag)

		if activityPod ~= nil then
			self.multipleParentView:Show()
			self.multipleParentView:SetData(activityPod)
			LuaUtility.SetGameObjectShow(self.doubleRoot, true)

			return
		end
	end

	self.multipleParentView:Hide()
	LuaUtility.SetGameObjectShow(self.doubleRoot, false)
end

return ResourceStageUI_equipStageItem
