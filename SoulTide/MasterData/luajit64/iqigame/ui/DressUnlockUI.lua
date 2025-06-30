-- chunkname: @IQIGame\\UI\\DressUnlockUI.lua

local DressUnlockUI = {}

DressUnlockUI = Base:Extend("DressUnlockUI", "IQIGame.Onigao.UI.DressUnlockUI", DressUnlockUI)

function DressUnlockUI:OnInit()
	self:Initialize()
end

function DressUnlockUI:GetPreloadAssetPaths()
	return nil
end

function DressUnlockUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DressUnlockUI:IsManualShowOnOpen(userData)
	return false
end

function DressUnlockUI:GetBGM(userData)
	return nil
end

function DressUnlockUI:OnOpen(userData)
	self:Refresh(userData)
end

function DressUnlockUI:OnClose(userData)
	self:OnHide()
end

function DressUnlockUI:OnPause()
	return
end

function DressUnlockUI:OnResume()
	return
end

function DressUnlockUI:OnCover()
	return
end

function DressUnlockUI:OnReveal()
	return
end

function DressUnlockUI:OnRefocus(userData)
	return
end

function DressUnlockUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DressUnlockUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DressUnlockUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DressUnlockUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DressUnlockUI:Initialize()
	self.tfSoulName = self.goSoulName:GetComponent("Text")
	self.tfSoulTitle = self.goSoulTitle:GetComponent("Text")
	self.tfCvName = self.goCvName:GetComponent("Text")
	self.tfSoulEnName = self.goEnName:GetComponent("Text")
	self.tfCvContent = self.goCVContent:GetComponent("Text")
	self.tfDressName = self.goDressName:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end
end

function DressUnlockUI:Refresh(userData)
	self.cfgDressData = CfgDressTable[userData]
	self.soulData = SoulModule.GetSoulData(self.cfgDressData.SoulID)

	self:RefreshMisc()
	self:ShowDress()
end

function DressUnlockUI:OnHide()
	self.isLoadFinished = true

	self:StopCV()
end

function DressUnlockUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	self.isDestroy = true
end

function DressUnlockUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function DressUnlockUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function DressUnlockUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function DressUnlockUI:OnLoadSpineSuccess(assetName, asset, duration, userData)
	return
end

function DressUnlockUI:OnLoadDressSuccess(assetName, asset, duration, userData)
	if self.isDestroy then
		return
	end

	local dressCid = userData

	if self.isLoadFinished or self.cfgDressData.Id ~= dressCid then
		return
	end

	local go = UnityEngine.Object.Instantiate(asset)

	go.transform:SetParent(self.dressRoot.transform, false)
	self:TryToPlayAnim(go, "idle")

	self.isLoadFinished = true

	self:RefreshHarmoniousMask()
end

function DressUnlockUI:RefreshMisc()
	local cfgSoulData = self.soulData:GetCfgSoul()
	local cfgCVData = CfgCVTable[self.cfgDressData.UnlockCV]

	self.tfSoulName.text = DressUnlockUIApi:GetString("goSoulName", cfgSoulData.Name)
	self.tfSoulEnName.text = DressUnlockUIApi:GetString("goEnName", cfgSoulData.EnglishName)
	self.tfSoulTitle.text = DressUnlockUIApi:GetString("goSoulTitle", cfgSoulData.SoulDescribe)
	self.tfCvName.text = DressUnlockUIApi:GetString("goCvName", cfgSoulData.CVName)
	self.tfCvContent.text = DressUnlockUIApi:GetString("cvContent", cfgCVData.Text)
	self.tfDressName.text = DressUnlockUIApi:GetString("dressName", self.cfgDressData.Name)
end

function DressUnlockUI:ShowDress()
	self.existSpine = DressModule.CheckExistConfigSpineDress(self.cfgDressData.Id)

	if self.dressRoot.transform.childCount > 0 then
		UnityEngine.GameObject.DestroyImmediate(self.dressRoot.transform:GetChild(0).gameObject)
	end

	self.isLoadFinished = false

	AssetUtil.LoadAsset(self, UIGlobalApi.GetHarmoniousPrefabRoot(self.cfgDressData.DressUnlockShow), DressUnlockUI.OnLoadDressSuccess, nil, self.cfgDressData.Id)
	self:PlayCV()
end

function DressUnlockUI:PlayCV()
	local soundID = CfgCVTable[self.cfgDressData.UnlockCV].SoundID

	if soundID ~= nil and soundID ~= 0 then
		self:StopCV()

		self.lastSound = GameEntry.Sound:PlaySound(soundID, Constant.SoundGroup.CHARACTER)
	end
end

function DressUnlockUI:StopCV()
	if self.lastSound ~= nil then
		GameEntry.Sound:StopSound(self.lastSound)

		self.lastSound = nil
	end
end

function DressUnlockUI:TryToPlayAnim(go, animName)
	local comps = go:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

	if comps == nil or comps.Length == 0 then
		return
	end

	local compList = {}

	for i = 0, comps.Length - 1 do
		compList[#compList + 1] = comps[i]
	end

	for i, v in ipairs(compList) do
		if v.AnimationState ~= nil then
			local animData = v.AnimationState.Data.SkeletonData:FindAnimation(animName)

			if animData ~= nil then
				v.AnimationState:SetAnimation(0, animName, true)
			end
		end
	end
end

function DressUnlockUI:RefreshHarmoniousMask()
	local spine = self.dressRoot.transform:GetChild(0)

	if spine then
		local harmoniousMask = spine:Find("HarmoniousMask")

		if harmoniousMask then
			local isShow = SettingModule.harmoniousResources == 0

			harmoniousMask.gameObject:SetActive(isShow)
		end
	end
end

return DressUnlockUI
