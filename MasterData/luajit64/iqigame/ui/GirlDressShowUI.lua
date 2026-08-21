-- chunkname: @IQIGame\\UI\\GirlDressShowUI.lua

local GirlDressShowUI = Base:Extend("GirlDressShowUI", "IQIGame.Onigao.UI.GirlDressShowUI", {})
local SoulSpineCell = require("IQIGame.UI.Common.SoulSpineCell")

function GirlDressShowUI:OnInit()
	self:Initialize()
end

function GirlDressShowUI:GetPreloadAssetPaths()
	return nil
end

function GirlDressShowUI:GetOpenPreloadAssetPaths(userData)
	self.cfgDressData = userData
	self.soulData = SoulModule.GetSoulData(self.cfgDressData.SoulID)
	self.spineBgPath = nil

	if DressModule.CheckExistConfigSpineDress(self.cfgDressData.Id) then
		self.spineBgPath = DressModule.GetDressSpineBgPath(self.cfgDressData.Id)

		return {
			self.spineBgPath
		}
	end

	return nil
end

function GirlDressShowUI:IsManualShowOnOpen(userData)
	return false
end

function GirlDressShowUI:GetBGM(userData)
	return nil
end

function GirlDressShowUI:OnOpen(userData)
	self:Refresh(userData)
end

function GirlDressShowUI:OnClose(userData)
	self:OnHide()
end

function GirlDressShowUI:OnPause()
	return
end

function GirlDressShowUI:OnResume()
	return
end

function GirlDressShowUI:OnCover()
	return
end

function GirlDressShowUI:OnReveal()
	return
end

function GirlDressShowUI:OnRefocus(userData)
	return
end

function GirlDressShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.spineCell ~= nil then
		self.spineCell:OnUpdate()
	end
end

function GirlDressShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GirlDressShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GirlDressShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GirlDressShowUI:Initialize()
	self.imgDress = self.goDress:GetComponent("Image")
	self.spineCell = SoulSpineCell.New(self.goSpineCell)
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goDescClick:GetComponent("Text").text = GirlUIApi:GetString("dressShowView")

	function self.onScaleGestureDelegate(gesture)
		self:OnScaleGesture(gesture)
	end

	function self.onTapGestureDelegate(gesture)
		self:OnTapGesture(gesture)
	end
end

function GirlDressShowUI:Refresh(userData)
	self.existSpine = DressModule.CheckExistConfigSpineDress(self.cfgDressData.Id)

	self.goDress:SetActive(not self.existSpine)
	self.goBg:SetActive(not self.existSpine)
	self.goSpineBgRoot:SetActive(self.existSpine)

	if self.existSpine then
		self.spineCell:ShowPreview(self.cfgDressData.Id, nil, self.soulData.soulCid)
		self:ShowSpineBg()

		self.goSpineCell.transform.localScale = Vector3.New(1, 1, 1)
	else
		self.spineCell:Close()
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgDressData.Image), self.imgDress)

		self.imgDress.transform.sizeDelta = Vector2.New(self.cfgDressData.ImgeSize[1], self.cfgDressData.ImgeSize[2])
		self.imgDress.transform.localScale = Vector2.New(1, 1)
	end

	LuaCodeInterface.SetEventSystemEnabled("GirlDressShow_" .. self.UIController.UIForm.SerialId, false)
end

function GirlDressShowUI:OnHide()
	self:DestroySpineBg()
	self.spineCell:OnHide()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.SetEventSystemEnabled("GirlDressShow_" .. self.UIController.UIForm.SerialId, true)
end

function GirlDressShowUI:OnDestroy()
	self.spineBgPath = nil

	self.spineCell:OnDestroy()
end

function GirlDressShowUI:ShowSpineBg()
	self:DestroySpineBg()
	AssetUtil.LoadAsset(self, self.spineBgPath, self.OnLoadBgSuccess)
end

function GirlDressShowUI:DestroySpineBg()
	self.goSpineCell.transform:SetParent(self.goSpineRoot.transform, false)

	if self.goSpineBg then
		UnityEngine.GameObject.DestroyImmediate(self.goSpineBg)

		self.goSpineBg = nil
	end
end

function GirlDressShowUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)

	GameEntry.Input.ScaleGesture.StateUpdated = GameEntry.Input.ScaleGesture.StateUpdated + self.onScaleGestureDelegate
	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated + self.onTapGestureDelegate
end

function GirlDressShowUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)

	GameEntry.Input.ScaleGesture.StateUpdated = GameEntry.Input.ScaleGesture.StateUpdated - self.onScaleGestureDelegate
	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated - self.onTapGestureDelegate
end

function GirlDressShowUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GirlDressShowUI:OnScaleGesture(gesture)
	if gesture.State == DigitalRubyShared.GestureRecognizerState.Executing then
		local target = self.goBg.transform.parent.gameObject
		local scale = math.min(target.transform.localScale.x * gesture.ScaleMultiplier, 1.5)

		scale = math.max(scale, 0.5)
		target.transform.localScale = Vector3.New(scale, scale, 1)
	end
end

function GirlDressShowUI:OnTapGesture(gesture)
	if gesture.State == DigitalRubyShared.GestureRecognizerState.Ended then
		self:OnClickBtnClose()
	end
end

function GirlDressShowUI:OnLoadBgSuccess(assetName, asset, duration, userData)
	if self.spineBgPath == nil then
		return
	end

	self.goSpineBg = UnityEngine.Object.Instantiate(asset)

	self.goSpineBg.transform:SetParent(self.goSpineBgRoot.transform, false)
	self.goSpineCell.transform:SetParent(self.goSpineBg.transform:Find("Point_Root"), false)

	local SpineScale = self.goSpineBg.transform:Find("Point_Root/Spine_Scale")

	if SpineScale then
		self.spineCell.goSpineRoot.transform.localScale = SpineScale.transform.localScale
	end

	local sortComponents = self.goSpineBg:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))
	local canvas = self.UIController:GetComponent("Canvas")

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = canvas
	end
end

return GirlDressShowUI
