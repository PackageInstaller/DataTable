-- chunkname: @IQIGame\\UI\\RoleDevelopment\\UpgradeCoreView.lua

local DiySkillItem = {}

function DiySkillItem.New(view, clickItemHandler)
	local obj = Clone(DiySkillItem)

	obj:Init(view, clickItemHandler)

	return obj
end

function DiySkillItem:Init(view, clickItemHandler)
	self.View = view
	self.clickItemHandler = clickItemHandler

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickSkillItem()
		self:OnClickSkillItem()
	end

	self:AddListeners()
end

function DiySkillItem:AddListeners()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickSkillItem)
end

function DiySkillItem:RemoveListeners()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickSkillItem)
end

function DiySkillItem:SetData(skillData, skillType, roleCid)
	self.isEquip = skillData ~= nil
	self.skillData = skillData
	self.skillType = skillType

	local index = RoleDevelopmentModule.GetIndexByDiySkillType(skillType)
	local needLV = CfgHeroTable[roleCid].DiyField[index]

	self.isUnLock = needLV <= WarlockModule.WarlockDataDic[roleCid].lv

	LuaUtility.SetGameObjectShow(self.lockedParent, not self.isUnLock)
	LuaUtility.SetGameObjectShow(self.emptyParent, not self.isEquip and self.isUnLock)
	LuaUtility.SetGameObjectShow(self.fullParent, self.isEquip)

	if self.isEquip then
		UGUIUtil.SetText(self.levelText, self.skillData.lv)
		UGUIUtil.SetText(self.refineText, self.skillData.purifyLv)
		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.skillData:GetCfg().Icon), self.skillIcon:GetComponent("Image"))
		LuaUtility.LoadImage(self, CommonSlotUIApi:GetSkillFrame(self.skillData:GetCfg().Quality), self.qualityImg:GetComponent("Image"))
	end

	if not self.isUnLock then
		UGUIUtil.SetText(self.conditionText, RoleDevelopmentApi:GetSkillOpenConditionText(needLV))
	end
end

function DiySkillItem:OnClickSkillItem()
	if not self.isUnLock then
		NoticeModule.ShowNotice(51011)

		return
	end

	if self.clickItemHandler ~= nil then
		self.clickItemHandler(self.skillType)
	end
end

function DiySkillItem:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = {
	AttrsTable = {},
	heroData = {},
	diySkillItemCellList = {}
}
local UITabList = require("IQIGame.UI.Common.UITabList")
local commonRoleStar = require("IQIGame.UI.Common.RoleStar.CommonRoleStar")

function m.New(view, fatherView)
	local obj = Clone(m)

	obj:Init(view, fatherView)

	return obj
end

function m:Init(view, fatherView)
	self.View = view
	self.fatherView = fatherView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.LevelMask = self.LevelMask:GetComponent("Image")
	self.ElementImg = self.ElementImg:GetComponent("Image")

	function self.DelegateBreachPreviewBtn()
		self:BrecachBtnClick()
	end

	function self.DelegateUpgradeBtn()
		self:OnUpgradeBtnClick()
	end

	function self.DelegateFavorBtn()
		self:OnFavorBtnClick()
	end

	function self.DelegatePersonalityBtn()
		self:OnPersonalityBtnClick()
	end

	function self.DelegateRoleUpdateData(heros)
		self:RefreshData()
	end

	function self.DelegateRoleBreakThroughEvent(heros)
		self:RefreshData()
	end

	function self.DelegateShowAttrPanel()
		self:OpenAttrPanel()
	end

	function self.DelegateClothesBtnClick()
		self:OnClothesBtnClick()
	end

	function self.DelegateDetailsBtnClick()
		self:OnDetailsBtnClick()
	end

	function self.DelegateOnClickBreachBtn()
		self:OnClickBreachBtn()
	end

	function self.DelegateOnClickStrengthBtn()
		self:OnClickStrengthBtn()
	end

	function self.DelegateSkillUpSucessEvent()
		self:OnSkillUpgradeSucess()
	end

	function self.delegateOnClickButtonMessage()
		self:OnClickButtonMessage()
	end

	local attrs = {}

	for k, v in pairsCfg(CfgAttributeTable) do
		if v.Show == true and v.Type == 1 then
			table.insert(attrs, v)
		end
	end

	table.sort(attrs, function(a, b)
		return a.Sort < b.Sort
	end)

	for i = 1, #attrs do
		local attrItem

		attrItem = UnityEngine.Object.Instantiate(self.AttributeItem)
		self.AttrsTable[attrs[i].Id] = attrItem
		attrItem.transform:Find("PropertyText"):GetComponent("Text").text = attrs[i].Name

		local img = attrItem.transform:Find("Image"):GetComponent("Image")

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attrs[i].ImageUrl), img)
		attrItem.transform:SetParent(self.AttributeGrid.transform, false)
	end

	self.commonRoleStar = commonRoleStar.New(self.CommonRoleStar)

	self:InitTabList()
	ForTransformChild(self.diySkillParent.transform, function(_trans, _index)
		self.diySkillItemCellList[Constant.DIYSkillPosMapping[_index + 1]] = DiySkillItem.New(_trans.gameObject, function(skillType)
			self:DiySkillItemClick(skillType)
		end)
	end)
	self:AddListeners()
end

function m:InitTabList()
	self.TableList = UITabList.Create()

	self.TableList:AddTableItem(self.attrTabItem, function()
		return self.attrParent
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, nil)
	self.TableList:AddTableItem(self.skillTabItem, function()
		return self.skillParent
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, nil)
end

function m:AddListeners()
	self.UpgradedBtn:GetComponent("Button").onClick:AddListener(self.DelegateUpgradeBtn)
	self.BreachBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBreachBtn)
	self.FavorBtn:GetComponent("Button").onClick:AddListener(self.DelegateFavorBtn)
	self.ClothesBtn:GetComponent("Button").onClick:AddListener(self.DelegateClothesBtnClick)
	self.BreachImgBtn:GetComponent("Button").onClick:AddListener(self.DelegateBreachPreviewBtn)
	self.RoleDetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateDetailsBtnClick)
	self.AttributeDetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateShowAttrPanel)
	self.buttonMessage:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMessage)
	EventDispatcher.AddEventListener(EventID.RoleAttrChange, self.DelegateRoleUpdateData)
	EventDispatcher.AddEventListener(EventID.RoleBreakThroughSucess, self.DelegateRoleBreakThroughEvent)
	EventDispatcher.AddEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	EventUtil.AddEventListener(self, EventID.UnlockFunction)
end

function m:RemoveListeners()
	self.UpgradedBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateUpgradeBtn)
	self.BreachBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBreachBtn)
	self.FavorBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateFavorBtn)
	self.BreachImgBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBreachPreviewBtn)
	self.RoleDetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateDetailsBtnClick)
	self.ClothesBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateClothesBtnClick)
	self.AttributeDetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateShowAttrPanel)
	self.buttonMessage:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonMessage)
	EventDispatcher.RemoveEventListener(EventID.RoleAttrChange, self.DelegateRoleUpdateData)
	EventDispatcher.RemoveEventListener(EventID.RoleBreakThroughSucess, self.DelegateRoleBreakThroughEvent)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	EventUtil.ClearEventListener(self)
end

function m:__OnUnlockFunctionHandler()
	return
end

function m:OnClickButtonMessage()
	CVModule.StopCV()
	UIModule.Open(Constant.UIControllerName.RoleInfoDetailsUI, Constant.UILayer.UI, {
		heroCid = self.heroData.cid
	})
end

function m:SetData(heroCid)
	self.heroData = WarlockModule.WarlockDataDic[heroCid]
	WarlockModule.curWarlockData = self.heroData

	self:RefreshData()
	self.TableList:ChangeSelectIndex(1)
end

function m:RefreshData()
	self:__OnUnlockFunctionHandler()

	local heroMaxExp = self.heroData:GetCfgHeroLvDataByLv().UpgradeNeedExp
	local MaxLv = self.heroData:GetCurMaxLv()

	self.StarLevel = self.heroData.BaseData.Quality

	LuaUtility.SetText(self.textFavorLv, self.heroData.favorabilityLevel)
	UGUIUtil.SetText(self.RoleCNName, CfgHeroTable[self.heroData.cid].Name)
	UGUIUtil.SetText(self.EnglishText, CfgHeroTable[self.heroData.cid].EnglishName)
	UGUIUtil.SetText(self.MaxLevel, "/" .. MaxLv)
	UGUIUtil.SetText(self.CurLevelText, self.heroData.lv)
	UGUIUtil.SetText(self.CurLevelMaskText, self.heroData.lv)
	UGUIUtil.SetText(self.FavorLv, self.heroData.favorabilityLevel)

	self.LevelMask.fillAmount = self.heroData.exp / heroMaxExp

	local path = WarlockApi:GetElementIconPath(CfgHeroTable[self.heroData.cid].Elements)

	self:LoadImage(path, self.ElementImg)

	path = WarlockApi:GetProfessionIconPath(CfgHeroTable[self.heroData.cid].Profession)

	self:LoadImage(path, self.ProfessionImg:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.ForceImg, CfgHeroTable[self.heroData.cid].Forces > 0)

	if CfgHeroTable[self.heroData.cid].Forces > 0 then
		path = WarlockApi:GetForceImgPath(CfgHeroTable[self.heroData.cid].Forces)

		self:LoadImage(path, self.ForceImg:GetComponent("Image"))
	end

	self:SetRoleAttr()
	self:LoadImage(RoleDevelopmentApi:GetBreachStateImg(self.heroData.breakLv), self.BreachImgBtn:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetBreachFontImg(self.heroData.breakLv), self.BreachFontImg:GetComponent("Image"))

	if MaxLv <= self.heroData.lv and self.heroData.breakLv < self.heroData.BaseData.MaxBreakLv then
		self.UpgradedBtn:SetActive(false)
		self.BreachBtn:SetActive(true)
	elseif MaxLv <= self.heroData.lv and self.heroData.breakLv >= self.heroData.BaseData.MaxBreakLv then
		self.UpgradedBtn:SetActive(false)
		self.BreachBtn:SetActive(false)
	else
		self.UpgradedBtn:SetActive(true)
		self.BreachBtn:SetActive(false)
	end

	self:UpdateHeroDiySkill()
	self.commonRoleStar:RefreshStar(self.heroData)
	self:RefreshRedDot()
end

function m:UpdateHeroDiySkill()
	self.SkillDataList = RoleDevelopmentModule.GetCurHeroSkill(self.heroData.cid)

	for k, v in pairs(self.diySkillItemCellList) do
		v:SetData(self.SkillDataList[k], k, self.heroData.cid)
	end
end

function m:DiySkillItemClick(skillType)
	UIModule.Open(Constant.UIControllerName.DiySkillInfoUI, Constant.UILayer.UI, {
		roleCid = self.heroData.cid,
		skillType = skillType
	})
end

function m:SetRoleAttr()
	local Attrs = RoleDevelopmentModule.GetRoleAttrs(self.heroData.cid, 1)

	for k, v in pairs(Attrs) do
		self.AttrsTable[k].transform:Find("Text"):GetComponent("Text").text = v.value
	end
end

function m:BrecachBtnClick()
	self.fatherView:OpenRoleBreachPreviewView()
end

function m:SetRoleImgState(state)
	LuaUtility.SetGameObjectShow(self.RoleParent, state)
end

function m:OnClothesBtnClick()
	CVModule.StopCV()
	UIModule.Open(Constant.UIControllerName.HeroSkinUI, Constant.UILayer.UI, {
		type = Constant.SkinUIOpenType.HeroDetailsUI,
		args = {
			heroCid = self.heroData.cid
		}
	})
end

function m:OnDetailsBtnClick()
	CVModule.StopCV()
	UIModule.Open(Constant.UIControllerName.RoleInfoDetailsUI, Constant.UILayer.UI, {
		heroCid = self.heroData.cid
	})
end

function m:OpenAttrPanel()
	UIModule.Open(Constant.UIControllerName.AttributeDetailsUI, Constant.UILayer.UI, {
		heroCid = self.heroData.cid,
		type = Constant.AttributeUIType.HeroAttribute
	})
end

function m:OnClickBreachBtn()
	local needPlayerLv = self.heroData:GetCurHeroBreachCfg(self.heroData.breakLv).PlayerLv

	if needPlayerLv > PlayerModule.PlayerInfo.baseInfo.pLv then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, RoleDevelopmentApi:GetLvNotReached(needPlayerLv))

		return
	end

	RoleDevelopmentModule.ShowBreachAnim = true
	self.isPreview = true

	RoleDevelopmentModule.RoleBreachForPreview(self.heroData.cid)
end

function m:OnUpgradeBtnClick()
	self.fatherView:OpenUpgradeView()
end

function m:OnClickStrengthBtn()
	EventDispatcher.Dispatch(EventID.ClickRoleStrengthEvent)
end

function m:OnFavorBtnClick()
	UIModule.Open(Constant.UIControllerName.FavorabilityUI, Constant.UILayer.UI, self.heroData.cid)
end

function m:OnPersonalityBtnClick()
	UIModule.Open(Constant.UIControllerName.PersonalitySystemPanel, Constant.UILayer.UI)
end

function m:LoadImage(path, imgobj)
	AssetUtil.LoadImage(self, path, imgobj, self.LoadImageSucess, nil, imgobj)
end

function m:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData.rectTransform, userData)
end

function m:__OnToggleValueChange(_isOn, _view)
	LuaUtility.SetGameObjectShow(_view, _isOn)
end

function m:OnSkillUpgradeSucess()
	if not self.View.activeSelf then
		return
	end
end

function m:RefreshRedDot()
	LuaUtility.SetGameObjectShow(self.roleBreachRedDot, RedDotModule.CanShowRedDot_Warlock_BreachReward(self.heroData.cid))
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.TableList:Dispose()
	self.commonRoleStar:Dispose()

	for k, v in pairs(self.AttrsTable) do
		UnityEngine.GameObject.Destroy(v)
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	AssetUtil.UnloadAsset(self)

	self.View = nil
end

return m
