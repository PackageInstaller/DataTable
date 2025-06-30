-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\DiySkillInfoView\\DiySkillInfoView.lua

local DiySkillContrastView = require("IQIGame.UI.RoleDevelopment.RoleTraining.DiySkillInfoView.DiySkillContrastView")
local DiySkillSlotElement = require("IQIGame.UI.RoleDevelopment.RoleTraining.DiySkillInfoView.DiySkillSlotElement")
local DiySkillInfoElement = require("IQIGame.UI.RoleDevelopment.RoleTraining.DiySkillInfoView.DiySkillInfoElement")
local DiySkillInfoBagElement = require("IQIGame.UI.RoleDevelopment.RoleTraining.DiySkillInfoView.DiySkillInfoBagElement")
local DiySkillInfoView = {}

function DiySkillInfoView.New(view)
	local obj = Clone(DiySkillInfoView)

	obj:__Init(view)

	return obj
end

function DiySkillInfoView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitComponent()

	self.diySkillContrastView = DiySkillContrastView.New(self.DIYSkillContrastParent)
	self.skillInfoElement = DiySkillInfoElement.New(self.DIYSkillInfoParent, function(_skillData)
		self:__OnShowContrast(_skillData)
	end, function()
		self:__OnHideContrast()
	end)
	self.bagElement = DiySkillInfoBagElement.New(self.DIYBagParent, function(_item, isLimit)
		self:__OnBagItemSelectEventHandler(_item, isLimit)
	end, function(skillType)
		self:OnSelectSkillBarItem(skillType)
	end)

	self:__PrepareEventProxy()
	self:__AddListeners()
end

function DiySkillInfoView:InitComponent()
	self.startsComponent = self.presentBreachStars:GetComponent("StartsHelperComponent")
	self.comonSkillImgView = CommonSkillImageView.New(self.Com_SkillImgView)
end

function DiySkillInfoView:__PrepareEventProxy()
	function self.__onEquipButtonClickEventProxy()
		self.bagElement:Show(self.heroCid, self.curSkillPos)
	end

	function self.__onWearSkillSucessEventProxy()
		self:__Refresh(true)
	end

	function self.__onRemoveSkillSucessEventProxy()
		self:__Refresh(true)
	end

	function self.__onLockSkillSuccessEventProxy()
		self:__Refresh(false)
	end

	function self.__onRoleSkillUpgradeSucessEventProxy()
		self:__Refresh(true)
	end

	function self.__onRoleSkillBreachSucessEventProxy()
		self:__Refresh(true)
	end

	function self.__onRoleSkillPurifySucessEventProxy()
		self:__Refresh(true)
	end

	function self.onBagShowEvent(skillPos, heroCid)
		self.bagElement:Show(heroCid, skillPos)
	end
end

function DiySkillInfoView:__AddListeners()
	self.equipBtn:GetComponent("Button").onClick:AddListener(self.__onEquipButtonClickEventProxy)
	EventDispatcher.AddEventListener(EventID.WearSkillSucess, self.__onWearSkillSucessEventProxy)
	EventDispatcher.AddEventListener(EventID.RemoveSkillSucess, self.__onRemoveSkillSucessEventProxy)
	EventDispatcher.AddEventListener(EventID.LockSkillSucess, self.__onLockSkillSuccessEventProxy)
	EventDispatcher.AddEventListener(EventID.RoleSkillUpgradeSucess, self.__onRoleSkillUpgradeSucessEventProxy)
	EventDispatcher.AddEventListener(EventID.RoleSkillBreachSucess, self.__onRoleSkillBreachSucessEventProxy)
	EventDispatcher.AddEventListener(EventID.RoleSkillPurifySucess, self.__onRoleSkillPurifySucessEventProxy)
	EventDispatcher.AddEventListener(EventID.ShowDiyBagEvent, self.onBagShowEvent)
end

function DiySkillInfoView:__RemoveListeners()
	self.equipBtn:GetComponent("Button").onClick:RemoveListener(self.__onEquipButtonClickEventProxy)
	EventDispatcher.RemoveEventListener(EventID.WearSkillSucess, self.__onWearSkillSucessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.RemoveSkillSucess, self.__onRemoveSkillSucessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.LockSkillSucess, self.__onLockSkillSuccessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.__onRoleSkillUpgradeSucessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillBreachSucess, self.__onRoleSkillBreachSucessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillPurifySucess, self.__onRoleSkillPurifySucessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.ShowDiyBagEvent, self.onBagShowEvent)
end

function DiySkillInfoView:Dispose()
	self:__RemoveListeners()
	self.skillInfoElement:Dispose()
	self.bagElement:Dispose()
	self.comonSkillImgView:Dispose()
	self:StopEffect()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillInfoView:Show(heroCid, skillType)
	LuaUtility.SetGameObjectShow(self.gameObject, true)

	self.heroCid = heroCid
	self.skillType = skillType
	self.lastSelectItemData = nil

	LuaUtility.PlayAnimation(self.gameObject, "DiySkillInfoPanel_Show")
	self:OnRefreshSkillBag()
end

function DiySkillInfoView:Hide()
	self:StopEffect()
	LuaUtility.PlayAnimation(self.gameObject, "DiySkillInfoPanel_Hide", nil, function()
		self.bagElement:Hide()
		LuaUtility.SetGameObjectShow(self.gameObject, false)
	end)
end

function DiySkillInfoView:__OnSkillSelectChange(skillPos)
	self.lastSelectItemData = nil
	self.curSkillPos = skillPos

	self:__Refresh(false)
end

function DiySkillInfoView:__RefreshCost(isPreview)
	local allCost, curCost = RoleDevelopmentModule.GetHeroAndSkillCost(self.heroCid)

	if isPreview then
		local curSkillData = RoleDevelopmentModule.GetCurHeroSkill(self.heroCid)[self.curSkillPos]
		local curSkillDataCost = 0

		if curSkillData ~= nil then
			curSkillDataCost = curSkillData.Cost
		end

		curCost = curCost - curSkillDataCost + self.lastSelectItemData.skillData.Cost
	end

	self:__RefreshCostInfoText(curCost, allCost)
end

function DiySkillInfoView:__RefreshCostInfoText(curCost, allCost)
	UGUIUtil.SetText(self.costPresentNumText, RoleDevelopmentApi:GetSkillCostIsOverflow(allCost < curCost, curCost))
	UGUIUtil.SetText(self.costLimitNumText, allCost)
end

function DiySkillInfoView:__Refresh()
	if not self.gameObject.activeSelf then
		return
	end

	self.diySkillContrastView:Hide()

	local skillData = RoleDevelopmentModule.GetCurHeroSkill(self.heroCid)[self.curSkillPos]

	if skillData == nil then
		self:__ShowEmpty()
	end

	if self.lastSelectItemData ~= nil then
		skillData = self.lastSelectItemData.skillData

		self:__RefreshCost(true)
	else
		self:__RefreshCost(false)

		if skillData == nil then
			self:__ShowEmpty(false)
			self:__SetState(false)
			self:StopEffect()
			self.skillInfoElement:ShowEmpty()

			return
		end

		skillData = WarehouseModule.FindItem(skillData.id).skillData
	end

	self:__SetState(true)
	self:__LoadSkillInfoImg(skillData)

	local isLimit = not DiySkillModule.GetDiySkillIsLimit(skillData, self.heroCid)

	self.skillInfoElement:Show(self.heroCid, self.curSkillPos, skillData, true, isLimit)
end

function DiySkillInfoView:__ShowEmpty()
	self.diySkillContrastView:Hide()
	LuaUtility.SetGameObjectShow(self.presentBreachStars, false)
	LuaUtility.SetGameObjectShow(self.textStory, false)
end

function DiySkillInfoView:__SetState(state)
	self.NoneState:SetActive(not state)
	self.EquipedState:SetActive(state)
	self.diySkillTypeImg:SetActive(state)
end

function DiySkillInfoView:__OnBagItemSelectEventHandler(itemData, isLimit)
	self:__SetState(true)

	self.lastSelectItemData = itemData

	self.skillInfoElement:Show(self.heroCid, self.curSkillPos, itemData.skillData, true, isLimit)
	self:__LoadSkillInfoImg(self.lastSelectItemData.skillData)
	self:__RefreshCost(true)
end

function DiySkillInfoView:__LoadSkillInfoImg(skillData)
	local cfgSkill = skillData:GetCfg()
	local itemCfg = DiySkillModule.GetItemCfgWithDiySkill(skillData)

	self.comonSkillImgView:SetData(skillData.skillCid)
	LuaUtility.SetText(self.textStory, itemCfg.ItemStory)
	LuaUtility.SetGameObjectShow(self.textStory, true)

	local maxStrengthenLv = DiySkillModule.GetSkillMaxStrengthenLevel(cfgSkill.Id)

	self.startsComponent:Refresh(itemCfg.Quality, itemCfg.Quality)
	LuaUtility.SetGameObjectShow(self.presentBreachStars, true)

	local path = RoleDevelopmentApi:GetSkillQualityAndTypeImgPath(itemCfg.Quality, skillData:GetCfg().ReleaseType)

	AssetUtil.LoadImage(self, path, self.diySkillTypeImg:GetComponent("Image"))
	self:PlayQualityAnim(CfgItemTable[skillData.itemCid].Quality)
end

function DiySkillInfoView:StopEffect()
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	if self.constantEffectId ~= nil then
		GameEntry.Effect:StopEffect(self.constantEffectId)
	end
end

function DiySkillInfoView:PlayQualityAnim(quality)
	self:StopEffect()

	local effectId = EquipApi:GetShowEffect(quality)

	if effectId == nil then
		logError("技能品质不正确:" .. quality .. " 无法找到该品质的特效!")

		return
	end

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(effectId, 50000, 0, self.topEffectRoot, 0)

	local effectCfgId = EquipApi:GetConstantDisplayEffect(quality)

	if effectCfgId ~= nil then
		self.constantEffectId = GameEntry.Effect:PlayUIMountPointEffect(effectCfgId, 50000, 0, self.bottomEffectRoot, 0)
	end
end

function DiySkillInfoView:__OnShowContrast(skillData)
	local _skillData = RoleDevelopmentModule.GetCurHeroSkill(self.heroCid)[self.curSkillPos]

	if _skillData == nil then
		return
	end

	self.diySkillContrastView:SetData(_skillData)
end

function DiySkillInfoView:__OnHideContrast()
	self.diySkillContrastView:Hide()
end

function DiySkillInfoView:CloseBagCallback()
	self.lastSelectItemData = nil

	self:__Refresh(false)
end

function DiySkillInfoView:OnSelectSkillBarItem(skillType)
	self.skillType = skillType

	self:__OnSkillSelectChange(skillType)
end

function DiySkillInfoView:OnRefreshSkillBag()
	self.bagElement:Show(self.heroCid, self.skillType)
end

return DiySkillInfoView
