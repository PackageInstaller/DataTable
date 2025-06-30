-- chunkname: @IQIGame\\UI\\FormatRoleUI.lua

local FormatRoleUI = {}

FormatRoleUI = Base:Extend("FormatRoleUI", "IQIGame.Onigao.UI.FormatRoleUI", FormatRoleUI)

function FormatRoleUI:OnInit()
	self:InitDelegates()
	self:Initialize()
end

function FormatRoleUI:Initialize()
	LuaCodeInterface.BindOutlet(self.OtherLuaOutlet, self)

	self.ChangeRoleBtnBtn = self.ChangeRoleBtn:GetComponent("Button")
	self.SettingPosBtnBtn = self.SettingPosBtn:GetComponent("Button")
	self.ChangeSkinBtnBtn = self.ChangeSkinBtn:GetComponent("Button")
	self.RoleImg = self.RoleImage:GetComponent("Image")

	UGUIUtil.SetText(self.OtherLuaOutlet1, FormatRoleUIAPI:GetTips_Type1_1())
	UGUIUtil.SetText(self.OtherLuaOutlet2, FormatRoleUIAPI:GetTips_Type1_2())
	UGUIUtil.SetText(self.OtherLuaOutlet3, FormatRoleUIAPI:GetTips_Type1_3())
	UGUIUtil.SetText(self.OtherLuaOutlet4, FormatRoleUIAPI:GetTips_Type1_4())

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function FormatRoleUI:InitDelegates()
	function self.OnClick_ChangeRole(_self, go)
		self:OnClickChangeRole(_self, go)
	end

	function self.OnClick_ChangeSkin(_self, go)
		self:OnClickChangeSkin(_self, go)
	end

	function self.OnClick_SettingPos(_self, go)
		self:OnClickSettingPos(_self, go)
	end

	function self.DelegateOnChangeShowHcidSucced()
		self:OnChangeShowHcidSucced()
	end

	function self.OnDelegation_LoadRoleAssetSuccess(RoleObj)
		self:OnLoadRoleAssetSuccess(RoleObj)
	end
end

function FormatRoleUI:OnClickChangeRole()
	local userdata = {
		[2] = Constant.UIControllerName.FormatRoleUI
	}

	UIModule.Open(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI, userdata)
end

function FormatRoleUI:OnClickChangeSkin()
	UIModule.Open(Constant.UIControllerName.SkinUI, Constant.UILayer.UI, PlayerModule.PlayerInfo.baseInfo.showHeroCid)
end

function FormatRoleUI:OnClickSettingPos()
	UIModule.Close(Constant.UIControllerName.FormatRoleUI)
	EventDispatcher.Dispatch(EventID.ChangeFormatRolePosition)
end

function FormatRoleUI:ShowRoleInfo(isPreLoadShow)
	local WarlockData = FormatRoleModule.GetFormatRole()

	UGUIUtil.SetText(self.Name, WarlockData.BaseData.Name)
	self.RoleSpine.gameObject:SetActive(false)

	local aniPrefabFullPath = WarlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.DynamicPrefab)

	if aniPrefabFullPath ~= nil and aniPrefabFullPath ~= "" then
		self.RoleImg.enabled = false

		self:ShowSpineFormatRole(WarlockData, aniPrefabFullPath)
	else
		self.RoleImg.enabled = true

		if isPreLoadShow then
			self.RoleImg.sprite = self.UIController:GetPreloadedAsset(self.RoleImgPath)
			self.RoleImg.transform.localScale = Vector3.New(1, 1, 1)

			self.RoleImg:SetNativeSize()
			LuaUtility.SetImageRectTransformPivot(self.RoleImg:GetComponent(typeof(UnityEngine.RectTransform)), self.RoleImg)
		else
			local roleImagePath = WarlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesVerticalDraw)

			AssetUtil.LoadImage(self, roleImagePath, self.RoleImg, function()
				self.RoleImg:SetNativeSize()
				LuaUtility.SetImageRectTransformPivot(self.RoleImg:GetComponent(typeof(UnityEngine.RectTransform)), self.RoleImg)
			end)
		end
	end
end

function FormatRoleUI:GetPreloadAssetPaths()
	return nil
end

function FormatRoleUI:GetOpenPreloadAssetPaths(userData)
	self.RoleImgPath = FormatRoleModule.GetFormatRole():GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesVerticalDraw)

	local _t = {}

	table.insert(_t, self.RoleImgPath)

	return _t
end

function FormatRoleUI:OnChangeShowHcidSucced()
	self:ShowRoleInfo(false)
end

function FormatRoleUI:IsManualShowOnOpen(userData)
	return false
end

function FormatRoleUI:ShowSpineFormatRole(curWarlockData, aniPrefabFullPath)
	if self.curShowSpineWarlockData ~= nil and self.CurrentRoleObj ~= nil and self.curShowSpineWarlockData.cid == curWarlockData.cid then
		self:OnLoadRoleAssetSuccess(self.CurrentRoleObj)
	else
		self:HideSpineFormatRole()

		self.curShowSpineWarlockData = curWarlockData

		local rolePath = aniPrefabFullPath

		ObjectPoolManager:AsyncLoadAsset(Constant.PoolObjName.FormatRoleUIRole, self.curShowSpineWarlockData.cid, rolePath, self, self.OnDelegation_LoadRoleAssetSuccess)
	end
end

function FormatRoleUI:HideSpineFormatRole()
	if self.curShowSpineWarlockData == nil then
		return
	end

	ObjectPoolManager:UnLoadAsset(Constant.PoolObjName.FormatRoleUIRole, self.curShowSpineWarlockData.cid, self.CurrentRoleObj)

	self.curShowSpineWarlockData = nil
	self.CurrentRoleObj = nil
end

function FormatRoleUI:OnLoadRoleAssetSuccess(RoleObj)
	self.CurrentRoleObj = RoleObj

	self.CurrentRoleObj.transform:SetParent(self.RoleSpine.transform, false)

	self.CurrentRoleObj.transform.localPosition = Vector3.zero

	setGameObjectLayers(self.CurrentRoleObj.transform, "UI")

	local skeletonGraphic = self.CurrentRoleObj.transform:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	skeletonGraphic.AnimationState:SetAnimation(0, "idle", true)
	self.CurrentRoleObj:SetActive(true)
	self.RoleSpine.gameObject:SetActive(true)
end

function FormatRoleUI:GetBGM(userData)
	return nil
end

function FormatRoleUI:OnOpen(userData)
	self:ShowRoleInfo(true)
end

function FormatRoleUI:OnClose(userData)
	return
end

function FormatRoleUI:OnAddListeners()
	self.ChangeRoleBtnBtn.onClick:AddListener(self.OnClick_ChangeRole)
	self.SettingPosBtnBtn.onClick:AddListener(self.OnClick_SettingPos)
	self.ChangeSkinBtnBtn.onClick:AddListener(self.OnClick_ChangeSkin)
	EventDispatcher.AddEventListener(EventID.ChangeShowHcid, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.AddEventListener(EventID.ChangeSkinResult, self.DelegateOnChangeShowHcidSucced)
end

function FormatRoleUI:OnRemoveListeners()
	self.ChangeRoleBtnBtn.onClick:RemoveListener(self.OnClick_ChangeRole)
	self.SettingPosBtnBtn.onClick:RemoveListener(self.OnClick_SettingPos)
	self.ChangeSkinBtnBtn.onClick:RemoveListener(self.OnClick_ChangeSkin)
	EventDispatcher.RemoveEventListener(EventID.ChangeShowHcid, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.RemoveEventListener(EventID.ChangeSkinResult, self.DelegateOnChangeShowHcidSucced)
end

function FormatRoleUI:OnPause()
	return
end

function FormatRoleUI:OnResume()
	return
end

function FormatRoleUI:OnCover()
	return
end

function FormatRoleUI:OnReveal()
	return
end

function FormatRoleUI:OnRefocus(userData)
	return
end

function FormatRoleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FormatRoleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FormatRoleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FormatRoleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FormatRoleUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self:HideSpineFormatRole()
	ObjectPoolManager:UnLoadGameAsset(Constant.PoolObjName.FormatRoleUIRole)
end

return FormatRoleUI
