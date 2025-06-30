-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\RoleUpgradeView.lua

local HeroAttrItemView = {}
local previewAttrType = {
	1,
	2,
	3
}

function HeroAttrItemView.New(view, index)
	local obj = Clone(HeroAttrItemView)

	obj:Init(view, index)

	return obj
end

function HeroAttrItemView:Init(view, index)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.EffectRoot.gameObject:SetActive(false)

	local effectPath = RoleDevelopmentApi:GetRoleUpgradeViewPreviewAttrEffect(index)

	AssetUtil.LoadAsset(self, effectPath, function(_, assetUrl, asset, duration, userData)
		self.effectObj = GameObject.Instantiate(asset)

		self.effectObj.transform:SetParent(self.EffectRoot.transform)

		self.effectObj.transform.localScale = Vector3.one
		self.effectObj.transform.localPosition = Vector3.zero

		self.effectObj.gameObject:SetActive(true)
	end)
end

function HeroAttrItemView:SetData(attrTable)
	local isUp = attrTable.curAttrValue ~= attrTable.previewAttrValue

	LuaUtility.SetGameObjectShow(self.UpArrow, isUp)
	UGUIUtil.SetText(self.CurAttrNumText, attrTable.curAttrValue)

	if isUp then
		UGUIUtil.SetText(self.NextAttrNumText, string.format(ColorCfg.RoleUpdate.AttrOrange, attrTable.previewAttrValue))
	else
		UGUIUtil.SetText(self.NextAttrNumText, string.format(ColorCfg.RoleUpdate.AttrWhite, attrTable.previewAttrValue))
	end

	UGUIUtil.SetText(self.AttrName, CfgAttributeTable[attrTable.attType].Name)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgAttributeTable[attrTable.attType].ImageUrl), self.AttrImg:GetComponent("Image"))
end

function HeroAttrItemView:ShowEffect()
	self:__HideEffect()
	self.EffectRoot.gameObject:SetActive(true)

	self.__effectTimer = Timer.New(function()
		self:__HideEffect()
	end, 3)

	self.__effectTimer:Start()
end

function HeroAttrItemView:__HideEffect()
	self.EffectRoot.gameObject:SetActive(false)

	if self.__effectTimer == nil then
		return
	end

	self.__effectTimer:Stop()

	self.__effectTimer = nil
end

function HeroAttrItemView:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function HeroAttrItemView:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function HeroAttrItemView:Dispose()
	GameObject.Destroy(self.effectObj)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local UpgradedMaterialItem = require("IQIGame.UI.RoleDevelopment.UpgradedMaterialItem")
local m = {
	isQuickAdd = false,
	isAddLinstener = false,
	MaterialItems = {},
	UpgradeItems = {},
	heroAttrList = {}
}

m.heroAttrItemView = HeroAttrItemView

function m.New(view, fatherView)
	local obj = Clone(m)

	obj:Init(view, fatherView)

	return obj
end

function m:Init(view, fatherView)
	self.View = view
	self.fatherView = fatherView

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateSelectMaterial(data)
		self:SelectMaterialCallback(data)
	end

	function self.DelegateOnClickUpgradeBtn()
		self:OnClickUpgradeBtn()
	end

	function self.DelegateOnClickBreachBtn()
		self:OnClickBreachBtn(true)
	end

	function self.DelegateOnRoleUpgradeSuccess(cri)
		self:OnRoleUpgradeSuccess(cri)
	end

	function self.DelegateOnRoleBreachSuccess()
		self:OnRoleBreachSuccess()
	end

	function self.DelegateOnClickClearSelectBtn()
		self:OnClickClearSelectBtn()
	end

	function self.DelegateOnClickQuickAddBtn()
		self:OnClickQuickAddBtn()
	end

	function self.DelegateOnClickCloseBtn()
		return
	end

	function self.DelegateOnRoleUpgradePreviewSuccessEvent(heroPod)
		self:OnRoleUpgradePreviewSuccessEvent(heroPod)
	end

	self.CurExpSliderCom = self.CurExpImg:GetComponent("Image")
	self.CurExpSliderCom1 = self.CurExpImg1:GetComponent("Image")
	self.PreviewExpSliderCom = self.PreviewExpImg:GetComponent("Image")
	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)

	self.consumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)

	for i = 1, self.ItemGrid.transform.childCount do
		table.insert(self.MaterialItems, UpgradedMaterialItem.New(self.ItemGrid.transform:GetChild(i - 1).gameObject))
	end

	self.UpgradeBtnCom = self.UpgradeBtn:GetComponent("Button")
	self.UpgradeBtnGrayCom = self.UpgradeBtn:GetComponent("GrayComponent")
	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)

	self.moneyCell:RefreshItem(Constant.TopMoneyType.RoleUpgradeUI)
	self:AddListeners()
end

function m:AddListeners()
	self.UpgradeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUpgradeBtn)
	self.BreachBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBreachBtn)
	self.ClearSelectBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClearSelectBtn)
	self.QuickAddBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickQuickAddBtn)
	EventDispatcher.AddEventListener(EventID.SelectRoleUpgradMaterial, self.DelegateSelectMaterial)
	EventDispatcher.AddEventListener(EventID.RoleUpgradeSuccess, self.DelegateOnRoleUpgradeSuccess)
	EventDispatcher.AddEventListener(EventID.RoleUpgradePreviewSuccessEvent, self.DelegateOnRoleUpgradePreviewSuccessEvent)
end

function m:RemoveListeners()
	self.UpgradeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUpgradeBtn)
	self.BreachBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBreachBtn)
	self.ClearSelectBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClearSelectBtn)
	self.QuickAddBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickQuickAddBtn)
	EventDispatcher.RemoveEventListener(EventID.SelectRoleUpgradMaterial, self.DelegateSelectMaterial)
	EventDispatcher.RemoveEventListener(EventID.RoleUpgradeSuccess, self.DelegateOnRoleUpgradeSuccess)
	EventDispatcher.RemoveEventListener(EventID.RoleUpgradePreviewSuccessEvent, self.DelegateOnRoleUpgradePreviewSuccessEvent)
end

function m:SetData(heroCid)
	self.CurSelectMaterialItems = {}
	self.SelectUpgradeItems = {}
	self.UpgradeNeedMoney = 0
	RoleDevelopmentModule.CurPreviewEXP = 0
	self.curSelectAllExp = 0
	self.HeroData = WarlockModule.WarlockDataDic[heroCid]
	self.CurMaxLv = self.HeroData:GetCurMaxLv()

	local isMaxLv = self.HeroData.lv >= self.HeroData.BaseData.MaxLv
	local isCurBreachMaxLv = self.HeroData.lv >= self.CurMaxLv

	LuaUtility.SetGameObjectShow(self.UpgradeBtn, not isCurBreachMaxLv and not isMaxLv)
	self:RefreshMaxLevelShow(isMaxLv)

	if isCurBreachMaxLv and not self.HeroData:IsMaxBreachLv() then
		self.timer = Timer.New(function()
			local breakCfg = self.HeroData:GetCurHeroBreachCfg(self.HeroData.breakLv)

			if PlayerModule.PlayerInfo.baseInfo.pLv >= breakCfg.PlayerLv then
				self:OnClickBreachBtn(false)
			end

			self.timer:Stop()

			self.timer = nil
		end, 2, 1)

		self.timer:Start()
	end

	self.NeedExp = self.HeroData:GetCfgHeroLvDataByLv().UpgradeNeedExp
	self.MaxExp = RoleDevelopmentModule.GetMaxExp(self.HeroData.lv)
	self.limitLv = math.min(self.HeroData:GetMaxLvByPlayerLv(), self.CurMaxLv)
	RoleDevelopmentModule.CurMaxExp = RoleDevelopmentModule.GetMaxExp(self.limitLv)

	UGUIUtil.SetText(self.CurExpText, RoleDevelopmentApi:GetCurExpText(self.HeroData.exp, self.NeedExp))
	UGUIUtil.SetText(self.CurLevelText, self.HeroData.lv)
	UGUIUtil.SetText(self.NextLevelText, "/" .. self.CurMaxLv)

	local fillAmount = self.HeroData.exp / RoleDevelopmentModule.LvTable[self.HeroData.lv].UpgradeNeedExp

	self.CurExpSliderCom.fillAmount = fillAmount
	self.CurExpSliderCom1.fillAmount = fillAmount

	self:RefreshMaterialItems()
	self:RefreshExpSlider(0)
	self:SetRoleHistoryAttr()
	self:RefreshUpgradeBtnInteractable()
	self.consumeGoldCell:SetData(self.UpgradeNeedMoney)
	LuaUtility.SetGameObjectShow(self.ClearSelectBtn, false)
	LuaUtility.SetGameObjectShow(self.QuickAddBtn, true)
end

function m:RefreshMaxLevelShow(isMaxLv)
	LuaUtility.SetGameObjectShow(self.MaxLevelParent, isMaxLv)
	LuaUtility.SetGameObjectShow(self.BottomParent, not isMaxLv)
	LuaUtility.SetGameObjectShow(self.PreviewExpText, not isMaxLv)
end

function m:RefreshUpgradeBtnInteractable()
	local isGray = table.len(self.SelectUpgradeItems) <= 0

	self.UpgradeBtnGrayCom:SetGray(isGray)

	self.UpgradeBtnCom.enabled = not isGray
end

function m:RefreshMaterialItems()
	self.UpgradeItems = RoleDevelopmentModule.GetItemByActionType(Constant.ActionType.AddHeroExpAction)

	table.sort(self.UpgradeItems, function(tab1, tab2)
		return tab1.Quality < tab2.Quality
	end)

	for i = 1, #self.UpgradeItems do
		self.MaterialItems[i]:SetData(self.UpgradeItems[i].Id)
	end

	local havingMaterial = RoleDevelopmentModule.GetHavingUpgradeMaterial(self.UpgradeItems)

	self.QuickAddBtn:GetComponent("GrayComponent"):SetGray(not havingMaterial)
end

function m:RefreshExpSlider(exp)
	local previewlv = RoleDevelopmentModule.GetPreviewLv(self.MaxExp + exp + self.HeroData.exp)
	local allExp = self.MaxExp + exp + self.HeroData.exp
	local previewexp = allExp - RoleDevelopmentModule.GetMaxExp(previewlv)

	self.curSelectAllExp = exp
	RoleDevelopmentModule.CurPreviewEXP = allExp
	self.PreviewExpSliderCom.fillAmount = previewlv > self.HeroData.lv and 1 or previewexp / RoleDevelopmentModule.LvTable[previewlv].UpgradeNeedExp
	self.UpgradeToLv = previewlv

	UGUIUtil.SetText(self.PreviewExpText, "+" .. self.curSelectAllExp)

	RoleDevelopmentModule.IsCanUpgradeHero = previewlv >= self.limitLv

	if previewlv <= self.HeroData.lv then
		LuaUtility.SetGameObjectShow(self.UpgradeImgParent, false)
		LuaUtility.SetGameObjectShow(self.upgradeText, false)
	else
		LuaUtility.SetGameObjectShow(self.UpgradeImgParent, true)
		LuaUtility.SetGameObjectShow(self.upgradeText, true)
	end

	local canUpMaxLv = self.CurMaxLv - self.HeroData.lv
	local tempUpLv = previewlv - self.HeroData.lv

	UGUIUtil.SetText(self.upgradeText, canUpMaxLv < tempUpLv and canUpMaxLv or tempUpLv)
	LuaUtility.SetGameObjectShow(self.UpgradeMaxImgParent, previewlv >= self.CurMaxLv)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.LevelParent.transform)

	if self.HeroData.lv == self.HeroData:GetCurMaxLv() then
		self:OnRoleUpgradePreviewSuccessEvent(self.tempPreviewHeroPod)
	else
		RoleDevelopmentModule.RoleUpgrade(self.HeroData.cid, self.SelectUpgradeItems, true)
	end
end

function m:SelectMaterialCallback(data)
	for k, v in pairs(data) do
		if v[1] <= 0 then
			self.CurSelectMaterialItems[k] = nil
			self.SelectUpgradeItems[k] = nil
		else
			self.CurSelectMaterialItems[k] = v
			self.SelectUpgradeItems[k] = v[1]
		end
	end

	self:RefreshUpgradeBtnInteractable()
	self:RefreshSelectAllExp()
end

function m:RefreshSelectAllExp()
	local allExp = 0
	local calculateExp = 0

	for k, v in pairs(self.CurSelectMaterialItems) do
		calculateExp = calculateExp + v[2]
		allExp = allExp + UserInfoModule.GetTalentAttr(Constant.TalentAttrType.PLAYER_UPGRADE_EXP_ADDITION, v[2], true)
	end

	self.UpgradeNeedMoney = math.floor(UserInfoModule.GetTalentAttr(Constant.TalentAttrType.HERO_UPGRADE_GOLD_COST, calculateExp * CfgDiscreteDataTable[1].Data[1] / 100, true))

	self.consumeGoldCell:SetData(self.UpgradeNeedMoney)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Com_ConsumeGold.transform)
	self:RefreshExpSlider(allExp)

	if allExp == 0 then
		LuaUtility.SetGameObjectShow(self.QuickAddBtn, true)
		LuaUtility.SetGameObjectShow(self.ClearSelectBtn, false)
	end
end

function m:OnClickUpgradeBtn()
	if table.len(self.SelectUpgradeItems) <= 0 then
		NoticeModule.ShowNotice(45012)

		return
	end

	if self.UpgradeNeedMoney > WarehouseModule.GetPlayerGoldNum() then
		NoticeModule.ShowCurrencyNotEnoughTips(Constant.ItemCid.GOLD)

		return
	end

	RoleDevelopmentModule.RoleUpgrade(self.HeroData.cid, self.SelectUpgradeItems, false)
end

function m:OnClickBreachBtn(playBreachAnim)
	local needPlayerLv = self.HeroData:GetCurHeroBreachCfg(self.HeroData.breakLv).PlayerLv

	if needPlayerLv > PlayerModule.PlayerInfo.baseInfo.pLv then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, RoleDevelopmentApi:GetLvNotReached(needPlayerLv))

		return
	end

	self.isPreview = true
	RoleDevelopmentModule.ShowBreachAnim = playBreachAnim

	RoleDevelopmentModule.RoleBreachForPreview(self.HeroData.cid)
end

function m:SetRoleHistoryAttr()
	local Attrs = RoleDevelopmentModule.GetRoleAttrs(self.HeroData.cid, 1)

	self.HistoryAttr = Attrs
	self.HistoryLv = self.HeroData.lv
end

function m:OnShowUpgradeTips()
	self.HeroData = WarlockModule.WarlockDataDic[self.HeroData.cid]

	if self.HistoryLv == self.HeroData.lv then
		return
	end

	for i = 1, #self.heroAttrList do
		self.heroAttrList[i]:ShowEffect()
	end

	self:HideEffect()

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(10081, 50000, 0, self.mountPoint, 0)
end

function m:HideEffect()
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)

		self.effectID = nil
	end
end

function m:OnOpenCritParent(crit)
	self.CritParent:SetActive(true)
	UGUIUtil.SetText(self.CritText, RoleDevelopmentApi:GetCritText(crit))

	self.critTimer = Timer.New(function()
		self.CritParent:SetActive(false)

		if self.critTimer ~= nil then
			self.critTimer:Stop()

			self.critTimer = nil
		end
	end, 1.5):Start()
end

function m:OnRoleUpgradeSuccess(cri)
	if tonumber(cri) > 1 then
		self:OnOpenCritParent(cri)
	end

	self:OnShowUpgradeTips()
	self:SetData(self.HeroData.cid)
end

function m:OnRoleBreachSuccess()
	self.fatherView:OpenUpgradeView()
end

function m:OnClickClearSelectBtn()
	for i = 1, #self.MaterialItems do
		self.MaterialItems[i]:ClearSelect()
	end

	LuaUtility.SetGameObjectShow(self.QuickAddBtn, true)
	LuaUtility.SetGameObjectShow(self.ClearSelectBtn, false)
end

function m:OnClickQuickAddBtn()
	local havingMaterial = RoleDevelopmentModule.GetHavingUpgradeMaterial(self.UpgradeItems)

	if not havingMaterial then
		NoticeModule.ShowNotice(20003)

		return
	end

	if RoleDevelopmentModule.IsCanUpgradeHero then
		NoticeModule.ShowNotice(20005)

		return
	end

	local curExp = 0
	local limitLv = math.min(self.HeroData:GetMaxLvByPlayerLv(), self.HeroData:GetCurMaxLv())
	local curMaxExp = RoleDevelopmentModule.GetMaxExp(limitLv)
	local curLvExp = RoleDevelopmentModule.GetMaxExp(self.HeroData.lv)
	local maxExp = curMaxExp - self.HeroData.exp - curLvExp
	local hasMoneyCount = WarehouseModule.GetPlayerGoldNum()

	for i = #self.MaterialItems, 1, -1 do
		self.MaterialItems[i]:InitSelect()

		self.CurSelectMaterialItems[self.MaterialItems[i].itemCid] = nil
		self.SelectUpgradeItems[self.MaterialItems[i].itemCid] = nil

		while not self.MaterialItems[i]:IsMaxSelect() and not RoleDevelopmentModule.IsCanUpgradeHero do
			if maxExp <= curExp then
				RoleDevelopmentModule.IsCanUpgradeHero = true

				break
			end

			local itemExp = UserInfoModule.GetTalentAttr(Constant.TalentAttrType.PLAYER_UPGRADE_EXP_ADDITION, self.MaterialItems[i].ItemExp, true)

			if hasMoneyCount < (curExp + itemExp) * (CfgDiscreteDataTable[1].Data[1] / 100) then
				break
			end

			self.MaterialItems[i]:MaxSingleAddClick()

			curExp = curExp + itemExp
		end
	end

	LuaUtility.SetGameObjectShow(self.ClearSelectBtn, true)
	LuaUtility.SetGameObjectShow(self.QuickAddBtn, false)
	EventDispatcher.Dispatch(EventID.OnQuickAddEndEvenet)
end

function m:OnRoleUpgradePreviewSuccessEvent(heroPOD)
	self.tempPreviewHeroPod = heroPOD

	local previewAttr = RoleDevelopmentModule.GetRoleAttrsByHeroPod(heroPOD, 1)
	local curAttr = RoleDevelopmentModule.GetRoleAttrs(self.HeroData.cid, 1)
	local AttrsList = {}

	for k, v in pairs(previewAttr) do
		if table.indexOf(previewAttrType, k) ~= -1 then
			table.insert(AttrsList, {
				attType = k,
				curAttrValue = curAttr[k].value,
				previewAttrValue = v.value
			})
		end
	end

	self:LoadHeroAttrItem(AttrsList)
end

function m:LoadHeroAttrItem(AttrsList)
	local attrsListLength = #AttrsList

	for i = 1, #self.heroAttrList do
		if attrsListLength < i then
			self.heroAttrList[i]:Hide()
		end
	end

	for i = 1, #AttrsList do
		local attrItemView = self:CreateAttrItem(i)

		attrItemView:Show()
		attrItemView:SetData(AttrsList[i])
	end
end

function m:CreateAttrItem(index)
	local attrItem = self.heroAttrList[index]

	if attrItem == nil then
		local obj = GameObject.Instantiate(self.AttrItem)

		obj.transform:SetParent(self.AttrGrid.transform, false)

		attrItem = m.heroAttrItemView.New(obj, index)
		self.heroAttrList[index] = attrItem
	end

	return attrItem
end

function m:LoadImage(path, imgobj)
	AssetUtil.LoadImage(self, path, imgobj, self.LoadImageSucess, nil, imgobj)
end

function m:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	self:HideEffect()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self.moneyCell:Dispose()

	self.UpgradeBtnGrayCom = nil
	self.UpgradeBtnCom = nil

	self.consumeGoldCell:Dispose()
	self:HideEffect()
	self:RemoveListeners()

	for k, v in pairs(self.MaterialItems) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
