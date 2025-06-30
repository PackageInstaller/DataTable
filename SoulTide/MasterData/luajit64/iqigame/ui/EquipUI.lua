-- chunkname: @IQIGame\\UI\\EquipUI.lua

local EquipUI = {
	toggles = {},
	SubViews = {}
}

EquipUI = Base:Extend("EquipUI", "IQIGame.Onigao.UI.EquipUI", EquipUI)

local BuildView = require("IQIGame.UI.Equip.BuildView.BuildView")
local BreakView = require("IQIGame.UI.Equip.BreakView.BreakView")
local EquipInfoView = require("IQIGame.UI.Equip.EquipInfoView")
local RecastView = require("IQIGame.UI.Equip.Recast.RecastView")
local EquipUISkinView = require("IQIGame.UI.Equip.Skin.EquipUISkinView")

function EquipUI:OnInit()
	self:Initialize()
end

function EquipUI:GetPreloadAssetPaths()
	return nil
end

function EquipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipUI:OnOpen(userData)
	self:Refresh(userData)
end

function EquipUI:OnClose(userData)
	self:OnHide()
end

function EquipUI:OnPause()
	return
end

function EquipUI:OnResume()
	return
end

function EquipUI:OnCover()
	return
end

function EquipUI:OnReveal()
	return
end

function EquipUI:OnRefocus(userData)
	return
end

function EquipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.buildView ~= nil then
		self.buildView:OnUpdate(elapseSeconds, realElapseSeconds)
	end
end

function EquipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipUI:Initialize()
	self.equipCell = EquipCell.New(self.goCard.transform:GetChild(0).gameObject, true)
	self.SubViews[1] = EquipInfoView.New(self.goInfoView)
	self.infoView = self.SubViews[1]
	self.SubViews[2] = BuildView.New(self.goBuildView)
	self.buildView = self.SubViews[2]
	self.SubViews[3] = BreakView.New(self.goBreakView)
	self.breakView = self.SubViews[3]
	self.SubViews[4] = RecastView.New(self.goRecastView)
	self.recastView = self.SubViews[4]
	self.SubViews[5] = EquipUISkinView.New(self.goSkinView)
	self.imgShow = self.goImgShow:GetComponent("Image")
	self.tfToggleLock = self.goToggleLock.transform:Find("Text"):GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnCloseOnShow = self.goBtnCloseOnShow:GetComponent("Button")
	self.toggleLock = self.goToggleLock:GetComponent("Toggle")
	self.btnTakeOff = self.goBtnTakeOff:GetComponent("Button")
	self.btnLeft = self.goBtnLeft:GetComponent("Button")
	self.btnRight = self.goBtnRight:GetComponent("Button")
	self.twScale = self.goImgShow:GetComponent("TweenScale")
	self.twRotation = self.goImgShow:GetComponent("TweenRotation")

	local toggleCount = self.goToggleParent.transform.childCount

	for i = 1, toggleCount do
		self.toggles[i] = self.goToggleParent.transform:Find("Toggle_" .. i):GetComponent("Toggle")
		self.toggles[i].transform:Find("goUp/Text_Name_01"):GetComponent("Text").text = EquipUIApi:GetString("goToggleName", i)
		self.toggles[i].transform:Find("goDown/Text_Name_01"):GetComponent("Text").text = EquipUIApi:GetString("goToggleName", i)
		self.toggles[i].transform:Find("goUp/Text_Name_02"):GetComponent("Text").text = EquipUIApi:GetString("goToggleEnglishName", i)
		self.toggles[i].transform:Find("goDown/Text_Name_02"):GetComponent("Text").text = EquipUIApi:GetString("goToggleEnglishName", i)
		self.toggles[i].isOn = false
	end

	function self.onClickBtnLeftDelegate()
		self:OnClickBtnLeft()
	end

	function self.onClickBtnRightDelegate()
		self:OnClickBtnRight()
	end

	function self.onClickToggleLockDelegate(isOn)
		self:OnClickToggleLock(isOn)
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnCloseOnShowDelegate()
		self:OnClickBtnCloseOnShow()
	end

	function self.onClickToggleDelegate(isOn)
		self:OnClickToggle(isOn)
	end

	function self.onEquipUpSuccessDelegate(id)
		self:OnEquipUpSuccess(id)
	end

	function self.onEquipBreakSuccessDelegate(id)
		self:OnEquipBreakSuccess(id)
	end

	function self.onDecomposeSuccessDelegate()
		self:OnDecomposeSuccess()
	end

	function self.onClickBtnTakeOffDelegate()
		self:OnClickBtnTakeOff()
	end

	function self.onEquipLockOverDelegate(id, lock)
		self:OnEquipLockOver(id, lock)
	end

	function self.onEquipTakeOffSuccessDelegate(id)
		self:OnEquipTakeOffSuccess(id)
	end

	function self.onRefreshEquipUIEquipDatumDelegate(datum)
		self:OnRefreshEquipUIEquipDatum(datum)
	end

	function self.equipCell.onClickDelegate(cell)
		self:OnClickEquipCell(cell)
	end

	function self.DelegateOnEquipSkinChanged(skinCid)
		self:OnEquipSkinChanged(skinCid)
	end

	self.goViewTitle:GetComponent("Text").text = EquipUIApi:GetString("goViewTitle")
	self.goBtnTakeOff.transform:Find("Text"):GetComponent("Text").text = EquipUIApi:GetString("goBtnTakeOffTxt")

	self:CloseShowView()
end

function EquipUI:Refresh(userData)
	self.itemDataList = userData.data
	self.defaultIndex = userData.tab
	self.forShow = userData.forShow
	self.defaultItemData = userData.defaultItemData

	self:RefreshDatum()
	self:DoRefresh(self.itemDataList[self.cardIndex])
end

function EquipUI:RefreshDatum()
	for i, v in ipairs(self.itemDataList) do
		if v.classType ~= "ItemData" then
			self.itemDataList[i] = ItemData.CreateByCIDAndNumber(v.Id, 1)
		end
	end

	if self.forShow == nil then
		self.forShow = false
	end

	if self.defaultIndex == nil then
		self.defaultIndex = 1
	end

	if self.defaultItemData == nil then
		self.cardIndex = 1
	else
		for i, v in ipairs(self.itemDataList) do
			if v.id == self.defaultItemData.id then
				self.cardIndex = i

				break
			end
		end
	end

	if self.cardIndex > #self.itemDataList then
		self.cardIndex = #self.itemDataList
	end
end

function EquipUI:DoRefresh(itemData)
	self.itemData = itemData
	self.cfgItemData = self.itemData:GetCfg()

	local isTabIndexValid = true

	if self:CheckCanEditEquip() then
		if self.defaultIndex == 4 then
			if not self:CheckCanRecast() then
				isTabIndexValid = false
			end
		elseif self.defaultIndex == 5 then
			local skinList = EquipModule.GetEquipSkins(self.cfgItemData.Id)

			if #skinList == 0 then
				isTabIndexValid = false
			end
		end
	else
		isTabIndexValid = false
	end

	if not isTabIndexValid then
		self.defaultIndex = 1
	end

	self:RefreshDefaultTab()
	self:RefreshMisc()
	self:RefreshLock()
	self:RefreshRedPoint()
end

function EquipUI:OnHide()
	for i = 1, #self.SubViews do
		self.SubViews[i]:OnHide()
	end
end

function EquipUI:OnDestroy()
	for i = 1, #self.SubViews do
		self.SubViews[i]:OnDestroy()
	end

	self.equipCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function EquipUI:OnAddListeners()
	for i, v in pairs(self.toggles) do
		v.onValueChanged:AddListener(self.onClickToggleDelegate)
	end

	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnCloseOnShow.onClick:AddListener(self.onClickBtnCloseOnShowDelegate)
	self.btnTakeOff.onClick:AddListener(self.onClickBtnTakeOffDelegate)
	self.toggleLock.onValueChanged:AddListener(self.onClickToggleLockDelegate)
	self.btnLeft.onClick:AddListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:AddListener(self.onClickBtnRightDelegate)
	EventDispatcher.AddEventListener(EventID.EquipUpSuccess, self.onEquipUpSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EquipBreakSuccess, self.onEquipBreakSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EquipDecomposeSuccess, self.onDecomposeSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
	EventDispatcher.AddEventListener(EventID.EquipTakeOffSuccess, self.onEquipTakeOffSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.RefreshEquipUIEquipDatum, self.onRefreshEquipUIEquipDatumDelegate)
	EventDispatcher.AddEventListener(EventID.EquipSkinChanged, self.DelegateOnEquipSkinChanged)
end

function EquipUI:OnRemoveListeners()
	for i, v in pairs(self.toggles) do
		v.onValueChanged:RemoveListener(self.onClickToggleDelegate)
	end

	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnCloseOnShow.onClick:RemoveListener(self.onClickBtnCloseOnShowDelegate)
	self.btnTakeOff.onClick:RemoveListener(self.onClickBtnTakeOffDelegate)
	self.toggleLock.onValueChanged:RemoveListener(self.onClickToggleLockDelegate)
	self.btnLeft.onClick:RemoveListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:RemoveListener(self.onClickBtnRightDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipUpSuccess, self.onEquipUpSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipBreakSuccess, self.onEquipBreakSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipDecomposeSuccess, self.onDecomposeSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipTakeOffSuccess, self.onEquipTakeOffSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.RefreshEquipUIEquipDatum, self.onRefreshEquipUIEquipDatumDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipSkinChanged, self.DelegateOnEquipSkinChanged)
end

function EquipUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.EquipUI)
end

function EquipUI:OnClickBtnCloseOnShow()
	self:CloseShowView()
end

function EquipUI:OnClickToggle(isOn)
	if not isOn then
		return
	end

	for i, v in ipairs(self.toggles) do
		if v.isOn then
			self:ShowTab(i)

			break
		end
	end
end

function EquipUI:OnEquipUpSuccess(id)
	self:RefreshMisc()
	self.buildView:OnEquipUpSuccess()
	self:RefreshRedPoint()
end

function EquipUI:OnEquipBreakSuccess(id)
	UIModule.Open(Constant.UIControllerName.EquipAdvancedShowUI, Constant.UILayer.UI, self.itemData)
	self:RefreshMisc()
	self.breakView:Refresh(self.itemData)
	self:RefreshRedPoint()
end

function EquipUI:OnDecomposeSuccess()
	self:OnClickBtnClose()
end

function EquipUI:OnClickBtnTakeOff()
	NoticeModule.ShowNotice(21053013, self.OnClickBtnSure, nil, self)
end

function EquipUI:OnClickBtnSure()
	local prefabDataList = SoulPrefabModule.GetPrefabByEquipId(self.itemData.id)
	local prefabIds = {}

	for i = 1, #prefabDataList do
		prefabIds[i] = prefabDataList[i].id
	end

	EquipModule.ReqTakeOff(prefabIds, self.itemData.id)
end

function EquipUI:OnEquipTakeOffSuccess(id)
	self:RefreshMisc()
end

function EquipUI:OnClickToggleLock(isOn)
	if isOn then
		if not self.itemData.equipData.lock then
			EquipModule.ReqLock(self.itemData.id)
		end
	elseif self.itemData.equipData.lock then
		EquipModule.ReqLock(self.itemData.id)
	end
end

function EquipUI:OnEquipLockOver(id, lock)
	if self.itemData.id == id then
		if self.toggleLock.isOn then
			if not self.itemData.equipData.lock then
				self.toggleLock.isOn = false
			end
		elseif self.itemData.equipData.lock then
			self.toggleLock.isOn = true
		end

		self:RefreshLock()
	end
end

function EquipUI:OnClickBtnLeft()
	if self.cardIndex == 1 then
		return
	end

	self.cardIndex = self.cardIndex - 1

	self:DoRefresh(self.itemDataList[self.cardIndex])
end

function EquipUI:OnClickBtnRight()
	if self.cardIndex == #self.itemDataList then
		return
	end

	self.cardIndex = self.cardIndex + 1

	self:DoRefresh(self.itemDataList[self.cardIndex])
end

function EquipUI:OnClickEquipCell(cell)
	self:OpenShowView()
end

function EquipUI:OnRefreshEquipUIEquipDatum(datum)
	self.itemDataList = datum

	self:RefreshDatum()
end

function EquipUI:RefreshMisc()
	self.goMask:SetActive(false)
	self.equipCell:Refresh(self.itemData)

	self.toggleLock.isOn = self.itemData.equipData.lock

	local canEdit = self:CheckCanEditEquip()

	self.goToggleLock:SetActive(canEdit)
	self.toggles[2].gameObject:SetActive(canEdit)
	self.toggles[3].gameObject:SetActive(canEdit)
	self.toggles[4].gameObject:SetActive(canEdit and self:CheckCanRecast())

	local skinList = EquipModule.GetEquipSkins(self.cfgItemData.Id)

	self.toggles[5].gameObject:SetActive(canEdit and #skinList > 0)

	local prefabList = SoulPrefabModule.GetPrefabByEquipId(self.itemData.id)

	self.goBtnTakeOff:SetActive(#prefabList > 0)
	self.goBtnLeft:SetActive(self.cardIndex ~= 1)
	self.goBtnRight:SetActive(self.cardIndex ~= #self.itemDataList)
end

function EquipUI:RefreshLock()
	self.tfToggleLock.text = EquipUIApi:GetString("goToggleLockTxt", self.itemData.equipData.lock)
end

function EquipUI:RefreshDefaultTab()
	for i = 1, #self.toggles do
		if self.defaultIndex == i then
			self.toggles[i].isOn = true
		end
	end

	self:ShowTab(self.defaultIndex)
end

function EquipUI:RefreshRedPoint()
	for i, v in pairs(self.toggles) do
		if i == 3 then
			local isShow = false

			v.transform:GetChild(0):GetChild(3).gameObject:SetActive(isShow)
			v.transform:GetChild(1):GetChild(3).gameObject:SetActive(isShow)
		else
			v.transform:GetChild(0):GetChild(3).gameObject:SetActive(false)
			v.transform:GetChild(1):GetChild(3).gameObject:SetActive(false)
		end
	end
end

function EquipUI:ShowTab(index)
	self.curTabIndex = index
	self.defaultIndex = index

	for i = 1, #self.SubViews do
		local controller = self.SubViews[i]

		if i == index then
			controller:SetActive(true)
			controller:Refresh(self.itemData, self)
		else
			controller:SetActive(false)
		end
	end
end

function EquipUI:CheckCanEditEquip()
	return not PlayerModule.InMaze and self.forShow == false
end

function EquipUI:CheckCanRecast()
	local canRecast = true

	if self.itemData.equipData.lv == 1 and self.itemData.equipData.star == 1 then
		canRecast = false
	end

	if self.itemData.equipData.isWore then
		canRecast = false
	end

	if self.itemData.equipData.lock then
		canRecast = false
	end

	return canRecast
end

function EquipUI:OpenShowView()
	self.goShowView:SetActive(true)

	local path = UIGlobalApi.GetImagePath(self.cfgItemData.Drawing)

	AssetUtil.LoadImage(self, path, self.imgShow)
	self.twRotation:ResetToBeginning()
	self.twScale:ResetToBeginning()
	self.twScale:PlayForward()
	self.twRotation:PlayForward()
end

function EquipUI:CloseShowView()
	self.goShowView:SetActive(false)
end

function EquipUI:OnEquipSkinChanged(skinCid)
	self.equipCell:Refresh(self.itemData)
end

return EquipUI
