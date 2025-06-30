-- chunkname: @IQIGame\\UI\\Formation\\FormationRoleInfoView.lua

local m = {
	OpenDetailsPanel = false,
	curSelectTabIndex = 1,
	TabList = {},
	ViewList = {}
}
local formationAttributeView = require("IQIGame.UI.Formation.RoleDetailsInfo.FormationAttributeView")
local formationBaseSkillView = require("IQIGame.UI.Formation.RoleDetailsInfo.FormationBaseSkillView")
local formationDiySkillView = require("IQIGame.UI.Formation.RoleDetailsInfo.FormationDiySkillView")
local commonRoleStar = require("IQIGame.UI.Common.RoleStar.CommonRoleStar")

function m.New(view, mainUIController)
	local obj = Clone(m)

	obj:Init(view, mainUIController)

	return obj
end

function m:Init(view, mainUIController)
	self.View = view
	self.MainUIController = mainUIController

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickTrainBtn()
		self:OnClickTrainBtn()
	end

	function self.DelegateOnClickTab(isOn)
		self:OnClickTab(isOn)
	end

	function self.DelegateOnHeroAttrChangeEvent(heros)
		self:OnHeroAttrChangeEvent()
	end

	for i = 1, self.TabGroup.transform.childCount do
		table.insert(self.TabList, self.TabGroup.transform:GetChild(i - 1).gameObject)
	end

	self.FormationAttributeView = formationAttributeView.New(self.AttributePanel)
	self.FormationBaseSkillView = formationBaseSkillView.New(self.BaseSkillPanel)
	self.FormationDiySkillView = formationDiySkillView.New(self.DiySkillPanel)

	table.insert(self.ViewList, self.FormationAttributeView)
	table.insert(self.ViewList, self.FormationBaseSkillView)
	table.insert(self.ViewList, self.FormationDiySkillView)

	self.TweenPanel = self.View:GetComponent("TweenPosition")
	self.commonRoleStar = commonRoleStar.New(self.CommonRoleStar)

	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.TrainBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTrainBtn)
	self.CloseBtnForMask:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)

	for k, v in pairs(self.TabList) do
		v:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTab)
	end

	EventDispatcher.AddEventListener(EventID.RoleUpdateData, self.DelegateOnHeroAttrChangeEvent)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.TrainBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTrainBtn)
	self.CloseBtnForMask:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)

	for k, v in pairs(self.TabList) do
		v:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end

	EventDispatcher.RemoveEventListener(EventID.RoleUpdateData, self.DelegateOnHeroAttrChangeEvent)
end

function m:SetData(heroData, boxIndex, isActiveCultivateBtn)
	self.heroData = heroData

	local isCanTrainRole = false

	if FormationModule.FormationInTheMaze then
		isCanTrainRole = false
		boxIndex = nil
	else
		if FormationModule.FormationTypeIsMaze then
			boxIndex = nil
		else
			self.stageMap = FormationModule.GetFormationTerrainData(FormationModule.CfgDupStageOrStoryBattleCfg, true)
		end

		isCanTrainRole = self.heroData == nil or not self.heroData.isTempHeroData and not self.heroData.isHelpHeroData
	end

	self.TrainBtn:SetActive(isCanTrainRole and isActiveCultivateBtn)
	self.RoleInfoParent:SetActive(self.heroData ~= nil)
	self.NoSelectRoleParent:SetActive(self.heroData == nil)

	if self.heroData ~= nil then
		self:RefreshHeroInfo()

		self.TabList[1]:GetComponent("Toggle").isOn = true

		self:ShowTab(1)
		self:RefreshHeroTerrainInfo(boxIndex)
	else
		self:Hide()
	end
end

function m:RefreshHeroInfo()
	self.commonRoleStar:RefreshStar(self.heroData)
	UGUIUtil.SetText(self.curLv, self.heroData.lv)

	if self.heroData.TheType == CombatFormationModel.WarkLockType.NPC then
		AssetUtil.LoadImage(self, WarlockApi:GetProfessionIconPath(CfgMonsterTable[self.heroData.MonsterId].Profession), self.RoleProfessionImg:GetComponent("Image"))
		AssetUtil.LoadImage(self, WarlockApi:GetElementIconPath(CfgMonsterTable[self.heroData.MonsterId].Elements), self.RoleElementImg:GetComponent("Image"))
	else
		UGUIUtil.SetText(self.maxLv, "/" .. self.heroData:GetCurMaxLv())
		UGUIUtil.SetText(self.RoleNameText, CfgHeroTable[self.heroData.cid].Name)
		AssetUtil.LoadImage(self, WarlockApi:GetElementIconPath(CfgHeroTable[self.heroData.cid].Elements), self.RoleElementImg:GetComponent("Image"))
		AssetUtil.LoadImage(self, WarlockApi:GetProfessionIconPath(CfgHeroTable[self.heroData.cid].Profession), self.RoleProfessionImg:GetComponent("Image"))
	end
end

function m:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.MainUIController:GetCurrentTarget()

		for i = 1, #self.TabList do
			if self.TabList[i] == currentTarget then
				self:ShowTab(i)

				return
			end
		end
	end
end

function m:ShowTab(index)
	self.curSelectTabIndex = index

	for i = 1, #self.ViewList do
		if i == index then
			self.ViewList[i]:Show()
			self.ViewList[i]:SetData(self.heroData)
		else
			self.ViewList[i]:Hide()
		end
	end
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:OnClickTrainBtn()
	UIModule.Open(Constant.UIControllerName.RoleDevelopmentPanel, Constant.UILayer.UI, {
		hideHomeButton = true,
		roleCid = self.heroData.cid
	})
end

function m:RefreshHeroTerrainInfo(boxIndex)
	if boxIndex == nil then
		self.TerrainImg:SetActive(false)

		return
	end

	if self.stageMap.MapType[boxIndex] ~= 0 then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(CfgTerrainTable[self.stageMap.MapType[boxIndex]].BigTerrainImg), self.TerrainImg:GetComponent("Image"))
		self.TerrainImg:SetActive(true)
	else
		self.TerrainImg:SetActive(false)
	end
end

function m:OnHeroAttrChangeEvent()
	if self.heroData == nil then
		return
	end

	if not self.heroData.isHelpHeroData and not self.heroData.isTempHeroData then
		self.heroData = WarlockModule.WarlockDataDic[self.heroData.cid]

		self:RefreshHeroInfo()
		self:ShowTab(self.curSelectTabIndex)
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	self.FormationDiySkillView:Dispose()
	self.FormationBaseSkillView:Dispose()
	self.FormationAttributeView:Dispose()
	self.commonRoleStar:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
