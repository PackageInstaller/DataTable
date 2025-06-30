-- chunkname: @IQIGame\\UI\\Dup\\ResourceStageUI_roleDevelopmentStageItem.lua

local ResourceStageUI_roleDevelopmentStageItem = {}
local multipleParentView = require("IQIGame.UI.Chapter.MultipleParentView")

function ResourceStageUI_roleDevelopmentStageItem.New(go, mainView)
	local o = Clone(ResourceStageUI_roleDevelopmentStageItem)

	o:Initialize(go, mainView)

	return o
end

function ResourceStageUI_roleDevelopmentStageItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.resourceRewardItem = {}
	self.resourceProfession = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ResourceStageUI_roleDevelopmentStageItem:InitComponent()
	self.multipleParentView = multipleParentView.New(self.MultipleParent)
end

function ResourceStageUI_roleDevelopmentStageItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function ResourceStageUI_roleDevelopmentStageItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function ResourceStageUI_roleDevelopmentStageItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function ResourceStageUI_roleDevelopmentStageItem:OnClickButtonClick()
	if not self.lockStatus then
		NoticeModule.ShowNotice(19001)
	else
		GameChapterModule.SetupCurChapterUserData(self.userData)
		UIModule.Open(Constant.UIControllerName.StageUI, Constant.UILayer.UI, self.userData)
	end
end

function ResourceStageUI_roleDevelopmentStageItem:OnDestroy()
	self.multipleParentView:Dispose()
end

function ResourceStageUI_roleDevelopmentStageItem:Refresh(Data, dupTagCfg)
	self.data = Data
	self.userData = {
		dupTagCfg = dupTagCfg,
		data = Data
	}

	LuaUtility.SetText(self.stageInfoText, ActivityModule.GetActivityDesc(self.data.ActivityId))
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.data.TabImg), self.stageTitleImg:GetComponent("Image"))
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.data.ChapterNameImg), self.stageImg:GetComponent("Image"))

	local haveElement = not LuaUtility.StrIsNullOrEmpty(self.data.ElementImg)

	LuaUtility.SetGameObjectShow(self.elementImg, haveElement)

	if haveElement then
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.data.ElementImg), self.elementImg:GetComponent("Image"))
	end

	local haveNameImg = not LuaUtility.StrIsNullOrEmpty(self.data.NameImg)

	if haveNameImg then
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.data.NameImg), self.nameImg:GetComponent("Image"))
		LuaUtility.SetGameObjectShow(self.stageNameText, false)
		LuaUtility.SetGameObjectShow(self.nameImg, true)
	else
		LuaUtility.SetGameObjectShow(self.stageNameText, true)
		LuaUtility.SetGameObjectShow(self.nameImg, false)
		LuaUtility.SetText(self.stageNameText, self.data.Name)
	end

	LuaUtility.SetGameObjectShow(self.centerItem, self.data.IsTrue)

	for i, v in pairs(self.resourceRewardItem) do
		LuaUtility.SetGameObjectShow(v, false)
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

	for i, v in pairs(self.resourceProfession) do
		LuaUtility.SetGameObjectShow(v, false)
	end

	for k, v in ipairs(self.data.ProfessionImg) do
		local obj = self.resourceProfession[k]

		if not obj then
			obj = UnityEngine.GameObject.Instantiate(self.professionImg, self.professionGrid.transform)

			table.insert(self.resourceProfession, obj)
		end

		local storyDataPath = string.format(CfgUtil.GetCfgResourceUrl(2309), v)

		LuaUtility.LoadImage(self, storyDataPath, obj.gameObject:GetComponent("Image"))
		obj:SetActive(true)
	end

	self.lockStatus = ConditionModule.Check(self.data.UnlockConditionId)

	LuaUtility.SetGameObjectShow(self.lockState, not self.lockStatus)

	local cfgCondition = CfgUtil.GetCfgConditionDataWithID(self.data.UnlockConditionId)

	LuaUtility.SetText(self.ConditionText, cfgCondition.Name)
	self:RefreshMultipleShow()
end

function ResourceStageUI_roleDevelopmentStageItem:RefreshMultipleShow()
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

return ResourceStageUI_roleDevelopmentStageItem
