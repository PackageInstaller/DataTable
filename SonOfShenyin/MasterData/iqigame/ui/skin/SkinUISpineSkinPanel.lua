-- chunkname: @IQIGame\\UI\\Skin\\SkinUISpineSkinPanel.lua

local SkinUISpineSkinPanel = {}
local SkinItemCell = require("IQIGame.UI.Skin.SkinItemCell")
local SkinUIFunctionButtonsPanel = require("IQIGame.UI.Skin.SkinUIFunctionButtonsPanel")
local enhanceScrollRect_BaseX, enhanceScrollRect_BaseY

function SkinUISpineSkinPanel.New(view, skinUIController)
	local obj = Clone(SkinUISpineSkinPanel)

	obj:Init(view, skinUIController)

	return obj
end

function SkinUISpineSkinPanel:Init(view, skinUIController)
	self.gameObject = view
	self.skinUIController = skinUIController

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitProperties()
	self:AddListeners()
end

function SkinUISpineSkinPanel:InitProperties()
	self.skinItemList = {}
	self.skinGroupsForScrollView = {}
	self.LeftButton = self.LeftButtonObj:GetComponent("Button")
	self.RightButton = self.RightButtonObj:GetComponent("Button")
	self.enhanceScrollView = self.EnhanceScrollViewObj:GetComponent("EnhanceScrollView")

	self:InitEnhanceScrollviewProperties()

	self.skinUIFunctionButtonsPanel = SkinUIFunctionButtonsPanel.New(self.FunctionPanelObj)

	function self.DelegateOnSelectSkinItemCell(cellIndex)
		self:OnSelectSkinItemCell(cellIndex)
	end

	function self.DelegateOnLeftArrowsBtnClick()
		self:OnArrowsButtonClick(true)
	end

	function self.DelegateOnRightArrowsBtnClick()
		self:OnArrowsButtonClick(false)
	end

	function self.DelegateOnLoadSpineAssetSuccessCallback(owner, assetName, asset, duration, userData)
		self:LoadSpineAssetSuccessCallBack(asset)
	end

	function self.DelegateOnSkinChange()
		self:OnSkinChange()
	end
end

function SkinUISpineSkinPanel:DisposeProperties()
	for key, _ in pairs(self.skinItemList) do
		self.skinItemList[key]:Dispose()

		self.skinItemList[key] = nil
	end

	self.skinItemList = nil
	self.LeftButton = nil
	self.RightButton = nil
	self.enhanceScrollView = nil
	self.skeletonAnimation = nil

	self.skinUIFunctionButtonsPanel:Dispose()

	self.DelegateOnSelectSkinItemCell = nil
	self.DelegateOnLeftArrowsBtnClick = nil
	self.DelegateOnRightArrowsBtnClick = nil
	self.DelegateOnSkinChange = nil
end

function SkinUISpineSkinPanel:AddListeners()
	self.LeftButton.onClick:AddListener(self.DelegateOnLeftArrowsBtnClick)
	self.RightButton.onClick:AddListener(self.DelegateOnRightArrowsBtnClick)
	EventDispatcher.AddEventListener(EventID.ChangeSkinResult, self.DelegateOnSkinChange)
end

function SkinUISpineSkinPanel:RemoveListeners()
	self.LeftButton.onClick:RemoveListener(self.DelegateOnLeftArrowsBtnClick)
	self.RightButton.onClick:RemoveListener(self.DelegateOnRightArrowsBtnClick)
	EventDispatcher.RemoveEventListener(EventID.ChangeSkinResult, self.DelegateOnSkinChange)
end

function SkinUISpineSkinPanel:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	self:DestroySpines()
	self:DisposeProperties()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SkinUISpineSkinPanel:SetVisible(isVisible)
	LuaUtility.SetGameObjectShow(self.gameObject, isVisible)
end

function SkinUISpineSkinPanel:Refresh(heroCid)
	if self.heroCid ~= heroCid then
		self.lastSelectCellIndex = nil
		self.lastShowSkinCid = nil
	end

	self.heroCid = heroCid

	self:InitSkinInfo()
	self:RefreshEnhanceScrollView()
end

function SkinUISpineSkinPanel:OnClose()
	self:DestroySpines()
end

function SkinUISpineSkinPanel:InitSkinInfo()
	self.skinGroupsFromConfig = SkinModule.GetAllSkinGroupFromConfigTableByHeroCid(self.heroCid)
	self.skinGroupsFromPlayer = SkinModule.GetAllSkinGroupFromPlayerByHeroCid(self.heroCid)

	for skinGroupID, _ in pairs(self.skinGroupsFromConfig) do
		if self.skinGroupsFromConfig[skinGroupID][Constant.SkinType.SpineElementEntity] == nil then
			self.skinGroupsFromConfig[skinGroupID] = nil
		end
	end

	for skinGroupID, _ in pairs(self.skinGroupsFromPlayer) do
		if self.skinGroupsFromPlayer[skinGroupID][Constant.SkinType.SpineElementEntity] == nil then
			self.skinGroupsFromPlayer[skinGroupID] = nil
		end
	end

	self.skinGroupsForScrollView = {}

	for skinGroupID, _ in pairs(self.skinGroupsFromConfig) do
		local staticImageSkinPOD

		if self.skinGroupsFromPlayer[skinGroupID] ~= nil then
			staticImageSkinPOD = self.skinGroupsFromPlayer[skinGroupID][Constant.SkinType.SpineElementEntity]
		else
			staticImageSkinPOD = self.skinGroupsFromConfig[skinGroupID][Constant.SkinType.SpineElementEntity]

			local isSkinHideInSkinUI = staticImageSkinPOD ~= nil and SkinModule.GetSkinConfigBySkinCid(staticImageSkinPOD.skinCid).IsHideInSkinUI or false

			if isSkinHideInSkinUI then
				staticImageSkinPOD = nil
			end
		end

		if staticImageSkinPOD ~= nil then
			table.insert(self.skinGroupsForScrollView, staticImageSkinPOD)
		end
	end
end

function SkinUISpineSkinPanel:RefreshEnhanceScrollView()
	local skinGroupTotalCount = getTableLength(self.skinGroupsForScrollView)

	self:SetSkinEnhanceScrollviewRect(self.enhanceScrollView, skinGroupTotalCount)

	for _, skinItemCell in pairs(self.skinItemList) do
		skinItemCell:SetVisible(false)
	end

	local list = {}
	local skinItemCell

	for i = 1, #self.skinGroupsForScrollView do
		skinItemCell = self:CreatSkinItem(i)

		skinItemCell:Refresh(i, self.skinGroupsForScrollView[i])

		list[i] = skinItemCell.View
	end

	self.enhanceScrollView:InitList(list)

	self.lastShowSkinCid, self.lastSelectCellIndex = self:GetScrollViewLastInfo()
	self.enhanceScrollView.startCenterIndex = self.lastSelectCellIndex

	self.enhanceScrollView:Initialize()
end

function SkinUISpineSkinPanel:CreatSkinItem(index)
	local item = self.skinItemList[index]

	if item == nil then
		local go = UnityEngine.Object.Instantiate(self.enhanceScrollViewCellPrefabObj)

		go.transform:SetParent(self.enhanceScrollView.transform, false)

		local uGUIEnhanceItem = LuaUtility.GameObjectGetOrAddComponent(go, typeof(UGUIEnhanceItem))

		uGUIEnhanceItem:Init(self.enhanceScrollView)
		LuaUtility.SetGameObjectName(go, "ItemCell" .. index)

		item = SkinItemCell.New(go, self.DelegateOnSelectSkinItemCell)
		self.skinItemList[index] = item
	end

	item:SetVisible(true)

	return item
end

function SkinUISpineSkinPanel:OnSelectSkinItemCell(cellIndex)
	self.lastSelectCellIndex = cellIndex
	self.lastShowSkinCid = self:GetSkinCidByCellIndex(cellIndex)

	self:RefreshSkinPreview(self.lastShowSkinCid)
	self:RefreshSkinFunctionPanel(self.heroCid, self.lastShowSkinCid)
end

function SkinUISpineSkinPanel:OnArrowsButtonClick(isLeft)
	if isLeft then
		self.enhanceScrollView:OnBtnRightClick()
	else
		self.enhanceScrollView:OnBtnLeftClick()
	end
end

function SkinUISpineSkinPanel:RefreshSkinPreview(skinCid)
	if skinCid == nil or skinCid < 0 then
		return
	end

	self:ShowSpine(skinCid)
	UGUIUtil.SetText(self.skinOwnerHeroNameTextObj, CfgHeroTable[self.heroCid].Name)

	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

	if skinConfig ~= nil then
		UGUIUtil.SetText(self.skinDescTextObj, skinConfig.SkinDesc)
	end

	local totalSkinCount = getTableLength(self.skinGroupsForScrollView)
	local ownedSkinCount = getTableLength(self.skinGroupsFromPlayer)

	UGUIUtil.SetText(self.skinProgressTextObj, tostring(ownedSkinCount) .. "/" .. tostring(totalSkinCount))
end

function SkinUISpineSkinPanel:RefreshSkinFunctionPanel(heroCid, skinCid)
	local skinState = SkinModule.GetSkinStateByHeroCidAndSkinCid(heroCid, skinCid)

	self.skinUIFunctionButtonsPanel:Refresh(heroCid, skinCid, skinState)
end

function SkinUISpineSkinPanel:GetScrollViewLastInfo()
	if self.lastShowSkinCid ~= nil then
		local lastSelectCellIndex = self:GetCellIndexBySkinCid(self.lastShowSkinCid)

		if lastSelectCellIndex >= 0 then
			return self.lastShowSkinCid, lastSelectCellIndex
		end
	end

	local showingSkinPOD

	if self:IsPlayerOwnTargetHero(self.heroCid) then
		showingSkinPOD = SkinModule.GetHeroCurrentSkinGroupFromPlayerByHeroCid(self.heroCid)[Constant.SkinType.SpineElementEntity]
	else
		showingSkinPOD = SkinModule.GetHeroDefaultSkinGroupFromConfigTableByHeroCid(self.heroCid)[Constant.SkinType.SpineElementEntity]
	end

	if showingSkinPOD ~= nil then
		local lastSelectCellIndex = math.max(0, self:GetCellIndexBySkinCid(showingSkinPOD.skinCid))

		return showingSkinPOD.skinCid, lastSelectCellIndex
	else
		logError("皮肤系统 - showingSkinPOD=nil, heroCid={1}", self.heroCid)
	end

	return nil, 0
end

function SkinUISpineSkinPanel:OnSkinChange()
	if self.lastShowSkinCid ~= nil and self.lastShowSkinCid > 0 then
		self:RefreshSkinFunctionPanel(self.heroCid, self.lastShowSkinCid)
	end
end

function SkinUISpineSkinPanel:ShowSpine(skinCid)
	local heroSkinData = CfgHeroSkinTable[skinCid]
	local elementEntityCid = heroSkinData.BattleEntityID

	if elementEntityCid >= 0 then
		self:LoadSpineAsset(elementEntityCid)
	end
end

function SkinUISpineSkinPanel:LoadSpineAsset(elementEntityCid)
	local elementEntityConfig = CfgElementEntityTable[elementEntityCid]
	local path = BattleApi:GetSpinePrefabUrl(elementEntityConfig.PrefabName)

	AssetUtil.LoadAsset(self, path, self.DelegateOnLoadSpineAssetSuccessCallback)
end

function SkinUISpineSkinPanel:LoadSpineAssetSuccessCallBack(asset)
	if self.gameObject == nil then
		return
	end

	self:CreatSpine(asset)
end

function SkinUISpineSkinPanel:CreatSpine(spineAsset)
	self:DestroySpines()

	local obj = GameObject.Instantiate(spineAsset)

	obj.transform:SetParent(self.SpineRootObj.transform, false)
	LuaUtility.SetScaleWithTransform(obj.transform, 100, 100, 100)

	obj.transform:Find("Root/Spine").gameObject.layer = 5
	obj.transform:Find("Root/Spine"):GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = self.skinUIController:GetComponent("Canvas").sortingOrder + 1

	local spineGo = EntityUtility.GetBattleUnitEntitySpineRoot(obj)
	local roleEffect = LuaCodeInterface.GameObjectGetOrAddComponent(spineGo, typeof(RoleEffect))

	roleEffect:SetEnable(false)

	self.skeletonAnimation = obj:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true)
	self.playSpineAnimationCustomCoroutine = SkinModule.GeneratePlaySpineAnimationCoroutine(self.skeletonAnimation)

	self.playSpineAnimationCustomCoroutine:Start()
end

function SkinUISpineSkinPanel:DestroySpines()
	if self.SpineRootObj ~= nil then
		local childCount = LuaUtility.GetChildCount(self.SpineRootObj.transform)

		for childIndex = 0, childCount - 1 do
			local childTransform = self.SpineRootObj.transform:GetChild(childIndex)

			if childTransform ~= nil then
				GameObject.Destroy(childTransform.gameObject)
			end
		end
	end

	if self.playSpineAnimationCustomCoroutine ~= nil and not self.playSpineAnimationCustomCoroutine.isComplete then
		self.playSpineAnimationCustomCoroutine:Stop()
	end

	self.playSpineAnimationCustomCoroutine = nil
end

function SkinUISpineSkinPanel:InitEnhanceScrollviewProperties()
	local rect = self.enhanceScrollView:GetComponent("RectTransform")
	local anchoredPosition = rect.anchoredPosition

	enhanceScrollRect_BaseX = anchoredPosition.x
	enhanceScrollRect_BaseY = anchoredPosition.y
end

function SkinUISpineSkinPanel:SetSkinEnhanceScrollviewRect(enhanceScrollView, cellCount)
	local rect = enhanceScrollView:GetComponent("RectTransform")
	local constant_OffsetValue = 50
	local x = enhanceScrollRect_BaseX - cellCount * constant_OffsetValue

	LuaUtility.SetAnchoredPositionWithRectTransform(rect, x, enhanceScrollRect_BaseY)
end

function SkinUISpineSkinPanel:JumpToCurPage(index)
	self.enhanceScrollView:JumpPage(index)
end

function SkinUISpineSkinPanel:IsPlayerOwnTargetHero(heroCid)
	return WarlockModule.WarlockDataDic[heroCid] ~= nil
end

function SkinUISpineSkinPanel:GetCellIndexBySkinCid(skinCid)
	for index = 1, #self.skinGroupsForScrollView do
		if self.skinGroupsForScrollView[index].skinCid == skinCid then
			return index - 1
		end
	end

	return -1
end

function SkinUISpineSkinPanel:GetSkinCidByCellIndex(cellIndex)
	if self.skinGroupsForScrollView ~= nil and self.skinGroupsForScrollView[cellIndex] ~= nil then
		return self.skinGroupsForScrollView[cellIndex].skinCid
	end

	return nil
end

return SkinUISpineSkinPanel
