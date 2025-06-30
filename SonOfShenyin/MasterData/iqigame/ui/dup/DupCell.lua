-- chunkname: @IQIGame\\UI\\Dup\\DupCell.lua

local multipleParentView = require("IQIGame.UI.Chapter.MultipleParentView")
local m = {
	lockStatus = true,
	resourceCell = {},
	equipCell = {},
	bossCell = {},
	towerCell = {},
	resourceWeek = {},
	resourceProfession = {},
	resourceRewardItem = {},
	equipRewardItem = {},
	boosRewardItem = {},
	baseResourceCell = {}
}

function m.New(go)
	local o = Clone(m)

	o:Initialize(go)

	return o
end

function m:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.resourceStageItem.gameObject, self.resourceCell)
	LuaCodeInterface.BindOutlet(self.equipStageItem.gameObject, self.equipCell)
	LuaCodeInterface.BindOutlet(self.bossStageItem.gameObject, self.bossCell)
	LuaCodeInterface.BindOutlet(self.towerStageItem.gameObject, self.towerCell)
	LuaCodeInterface.BindOutlet(self.resourceStageItem1.gameObject, self.baseResourceCell)

	function self.DelegateOnClick()
		self:OnClick()
	end

	function self.DelegateOnActivityCloseEvent()
		self:OnActivityCloseEvent()
	end

	for i = 1, 7 do
		local obj = UnityEngine.GameObject.Instantiate(self.resourceCell.item, self.resourceCell.openingTimeGrid.transform)

		obj:SetActive(true)
		table.insert(self.resourceWeek, obj)
	end

	self.multipleParentView = multipleParentView.New(self.MultipleParent)

	self:AddListener()
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.multipleParentView:Dispose()
	LuaCodeInterface.ClearOutlet(self.resourceStageItem.gameObject, self.resourceCell)
	LuaCodeInterface.ClearOutlet(self.equipStageItem.gameObject, self.equipCell)
	LuaCodeInterface.ClearOutlet(self.bossStageItem.gameObject, self.bossCell)
	LuaCodeInterface.ClearOutlet(self.towerStageItem.gameObject, self.towerCell)
	LuaCodeInterface.ClearOutlet(self.resourceStageItem1.gameObject, self.baseResourceCell)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function m:AddListener()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	EventDispatcher.AddEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityCloseEvent)
end

function m:RemoveListener()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	EventDispatcher.RemoveEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityCloseEvent)
end

function m:_OnClick()
	return
end

function m:RefreshMultipleShow()
	if self.isIdenticalActivityId == false and self.chapterCfg.ActivityTag ~= nil and self.chapterCfg.ActivityTag ~= 0 then
		local activityPod = ActivityModule.GetActivityPodByActivityTag(Constant.ActivityType.ActivityType_DupMultiple_12, self.chapterCfg.ActivityTag)

		if activityPod ~= nil then
			self.multipleParentView:Show()
			self.multipleParentView:SetData(activityPod)

			return
		end
	end

	self.multipleParentView:Hide()
end

function m:Refresh(data, dupTagCfg, isIdenticalActivityId)
	self.userData = {
		dupTagCfg = dupTagCfg,
		data = data
	}
	self.isIdenticalActivityId = isIdenticalActivityId
	self.chapterCfg = data

	self.resourceStageItem.gameObject:SetActive(dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.RoleDevelopment and dupTagCfg.DupType == Constant.ChapterPassType.TYPE_RESOURCES)
	self.bossStageItem.gameObject:SetActive(dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Boss)
	self.equipStageItem.gameObject:SetActive(dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Equip)
	self.towerStageItem.gameObject:SetActive(dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Tower)
	self.resourceStageItem1.gameObject:SetActive(dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.BaseResource)

	if dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.RoleDevelopment and dupTagCfg.DupType == Constant.ChapterPassType.TYPE_RESOURCES then
		UGUIUtil.SetText(self.resourceCell.stageInfoText, ActivityModule.GetActivityDesc(data.ActivityId))
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.TabImg), self.resourceCell.stageTitleImg:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.ChapterNameImg), self.resourceCell.stageImg:GetComponent("Image"))

		if data.ElementImg and data.ElementImg ~= "" then
			AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.ElementImg), self.resourceCell.elementImg:GetComponent("Image"))
			self.resourceCell.elementImg.gameObject:SetActive(true)
		else
			self.resourceCell.elementImg.gameObject:SetActive(false)
		end

		if data.NameImg ~= "" and data.ElementImg ~= "" then
			AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.NameImg), self.resourceCell.nameImg:GetComponent("Image"))
			self.resourceCell.stageNameText.gameObject:SetActive(false)
			self.resourceCell.nameImg.gameObject:SetActive(true)
		else
			self.resourceCell.nameImg.gameObject:SetActive(false)
			self.resourceCell.stageNameText.gameObject:SetActive(true)
			UGUIUtil.SetText(self.resourceCell.stageNameText, data.Name)
		end

		self.resourceCell.centerItem.gameObject:SetActive(data.IsTrue)

		local openWeeks = CfgActivityTable[data.ActivityId].OpenTimeParam

		for k, v in ipairs(self.resourceWeek) do
			if table.indexOf(openWeeks, k) ~= -1 then
				v:GetComponent("Toggle").isOn = true
			else
				v:GetComponent("Toggle").isOn = false
			end
		end

		self:ResetRewardItemStatus(self.resourceRewardItem)

		for k, v in ipairs(data.ItemID) do
			local obj = self.resourceRewardItem[k]

			if not obj then
				obj = UnityEngine.GameObject.Instantiate(self.resourceCell.rewardItem, self.resourceCell.rewardParent.transform)

				table.insert(self.resourceRewardItem, obj)
			end

			local cfgItem = CfgUtil.GetItemCfgDataWithID(v)

			AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), obj.transform:Find("rewardItemImg").gameObject:GetComponent("Image"))
			obj.transform:Find("diySkillBg").gameObject:SetActive(cfgItem.DiySkillBg)
			obj:SetActive(true)
		end

		self:ResetRewardItemStatus(self.resourceProfession)

		for k, v in ipairs(data.ProfessionImg) do
			local obj = self.resourceProfession[k]

			if not obj then
				obj = UnityEngine.GameObject.Instantiate(self.resourceCell.professionImg, self.resourceCell.professionGrid.transform)

				table.insert(self.resourceProfession, obj)
			end

			local storyDataPath = string.format(CfgResourceTable[2309].Url, v)

			AssetUtil.LoadImage(self, storyDataPath, obj.gameObject:GetComponent("Image"))
			obj:SetActive(true)
		end

		self.resourceCell.stageInfoText.gameObject:SetActive(true)
		self:CheckLock(self.resourceCell)
		self.resourceCell.extraAllNum.gameObject:SetActive(false)
		self.resourceCell.extraPresentNum.gameObject:SetActive(false)
	elseif dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Equip then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.TabImg), self.equipCell.stageTitleImg:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.ChapterNameImg), self.equipCell.stageImg:GetComponent("Image"))
		self:ResetRewardItemStatus(self.equipRewardItem)

		for k, v in ipairs(data.ItemID) do
			local obj = self.equipRewardItem[k]

			if not obj then
				obj = UnityEngine.GameObject.Instantiate(self.equipCell.rewardItem, self.equipCell.rewardParent.transform)

				table.insert(self.equipRewardItem, obj)
			end

			local cfgItem = CfgUtil.GetItemCfgDataWithID(v)

			AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), obj.transform:Find("rewardItemImg").gameObject:GetComponent("Image"))
			obj:SetActive(true)
		end

		UGUIUtil.SetText(self.equipCell.stageNameText, data.Name)
		self.equipCell.stageInfoText.gameObject:SetActive(false)
		self:CheckLock(self.equipCell)
	elseif dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Tower then
		UGUIUtil.SetText(self.towerCell.stageNameText, data.Name)
		self.towerCell.stageInfoText.gameObject:SetActive(false)
		self:CheckLock(self.towerCell)
	elseif dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.BaseResource then
		LuaUtility.SetText(self.baseResourceCell.stageInfoText, ActivityModule.GetActivityDesc(data.ActivityId))
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.TabImg), self.baseResourceCell.stageTitleImg:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.ChapterNameImg), self.baseResourceCell.stageImg:GetComponent("Image"))

		if data.ElementImg and data.ElementImg ~= "" then
			AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.ElementImg), self.baseResourceCell.elementImg:GetComponent("Image"))
			self.baseResourceCell.elementImg.gameObject:SetActive(true)
		else
			self.baseResourceCell.elementImg.gameObject:SetActive(false)
		end

		if not LuaUtility.StrIsNullOrEmpty(data.NameImg) then
			AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(data.NameImg), self.baseResourceCell.ResNameImg:GetComponent("Image"))
		end

		LuaUtility.SetGameObjectShow(self.baseResourceCell.centerItem, data.IsTrue)

		local openWeeks = CfgActivityTable[data.ActivityId].OpenTimeParam

		for k, v in ipairs(self.resourceWeek) do
			if table.indexOf(openWeeks, k) ~= -1 then
				v:GetComponent("Toggle").isOn = true
			else
				v:GetComponent("Toggle").isOn = false
			end
		end

		self:ResetRewardItemStatus(self.resourceRewardItem)

		for k, v in ipairs(data.ItemID) do
			local obj = self.resourceRewardItem[k]

			if not obj then
				obj = UnityEngine.GameObject.Instantiate(self.baseResourceCell.rewardItem, self.baseResourceCell.rewardParent.transform)

				table.insert(self.resourceRewardItem, obj)
			end

			local cfgItem = CfgUtil.GetItemCfgDataWithID(v)

			AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), obj.transform:Find("rewardItemImg").gameObject:GetComponent("Image"))
			obj.transform:Find("diySkillBg").gameObject:SetActive(cfgItem.DiySkillBg)
			obj:SetActive(true)
		end

		self.baseResourceCell.stageInfoText.gameObject:SetActive(true)
		self:CheckLock(self.baseResourceCell)
		self.baseResourceCell.extraAllNum.gameObject:SetActive(false)
		self.baseResourceCell.extraPresentNum.gameObject:SetActive(false)
		LuaUtility.SetText(self.baseResourceCell.stageTips, data.Desc)
	end

	self:RefreshMultipleShow()
end

function m:ResetRewardItemStatus(rewardItem)
	for i = 1, #rewardItem do
		local obj = rewardItem[i]

		obj:SetActive(false)
	end
end

function m:CheckLock(obj)
	if ConditionModule.Check(self.userData.data.UnlockConditionId) then
		obj.lockState.gameObject:SetActive(false)

		self.lockStatus = false
	else
		obj.lockState.gameObject:SetActive(true)

		self.lockStatus = true
	end
end

function m:OnClick()
	if self.lockStatus then
		NoticeModule.ShowNotice(19001)
	else
		GameChapterModule.SetupCurChapterUserData(self.userData)
		UIModule.Open(Constant.UIControllerName.LoopTowerDungeonUI, Constant.UILayer.UI)
	end
end

function m:OnActivityCloseEvent()
	self:RefreshMultipleShow()
end

return m
