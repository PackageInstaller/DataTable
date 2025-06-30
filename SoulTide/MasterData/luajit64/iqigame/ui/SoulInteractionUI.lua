-- chunkname: @IQIGame\\UI\\SoulInteractionUI.lua

local SoulInteractionUI = {}

SoulInteractionUI = Base:Extend("SoulInteractionUI", "IQIGame.Onigao.UI.SoulInteractionUI", SoulInteractionUI)

local SoulInteractionChooseView = require("IQIGame.UI.Girl.SoulInteraction.SoulInteractionChooseView")

function SoulInteractionUI:OnInit()
	self.live2DView = GirlL2DView.New(self.goLive2D)
	self.soulChooseView = SoulInteractionChooseView.New(self.ChooseSoulPanel)

	function self.soulChooseView.selectCallBack(soulCid)
		self:ChooseSoul(soulCid)
	end

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateDressWearSuccess(dressCid)
		self:OnDressWearSuccess(dressCid)
	end
end

function SoulInteractionUI:GetPreloadAssetPaths()
	return nil
end

function SoulInteractionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulInteractionUI:IsManualShowOnOpen(userData)
	return false
end

function SoulInteractionUI:GetBGM(userData)
	return nil
end

function SoulInteractionUI:OnOpen(userData)
	self.soulCid = userData

	self:UpDateView()
	EventDispatcher.Dispatch(EventID.L2DPause)
end

function SoulInteractionUI:OnClose(userData)
	self.live2DView:Dispose()
	EventDispatcher.Dispatch(EventID.L2DResume)
end

function SoulInteractionUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.DressWearSuccess, self.DelegateDressWearSuccess)
end

function SoulInteractionUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.DressWearSuccess, self.DelegateDressWearSuccess)
end

function SoulInteractionUI:OnPause()
	return
end

function SoulInteractionUI:OnResume()
	return
end

function SoulInteractionUI:OnCover()
	return
end

function SoulInteractionUI:OnReveal()
	return
end

function SoulInteractionUI:OnRefocus(userData)
	return
end

function SoulInteractionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	local index = UnityEngine.Screen.orientation:GetHashCode()

	if UnityEngine.Screen.width > UnityEngine.Screen.height or index == 3 or index == 4 then
		self.Background.transform.localEulerAngles = Vector3.New(0, 0, 0)
		self.Root.transform.localEulerAngles = Vector3.New(0, 0, 90)
		self.Outer.transform.localEulerAngles = Vector3.New(0, 0, 0)
		self.Root.transform.localScale = Vector3.New(1, 1, 1)
		self.Outer.transform.localScale = Vector3.New(1, 1, 1)
	elseif UnityEngine.Screen.width < UnityEngine.Screen.height or index == 1 or index == 2 then
		self.Background.transform.localEulerAngles = Vector3.New(0, 0, 90)
		self.Root.transform.localEulerAngles = Vector3.New(0, 0, 0)
		self.Outer.transform.localEulerAngles = Vector3.New(0, 0, -90)

		local scale = UnityEngine.Screen.height / UnityEngine.Screen.width

		self.Root.transform.localScale = Vector3.New(scale * 1.3, scale * 1.3, scale * 1.3)
		self.Outer.transform.localScale = Vector3.New(scale, scale, scale)
	end
end

function SoulInteractionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulInteractionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulInteractionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulInteractionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.soulChooseView:Dispose()
	self.live2DView:OnDestroy()
end

function SoulInteractionUI:OnDressWearSuccess(dressCid)
	self:RefreshL2D()
end

function SoulInteractionUI:ChooseSoul(soulCid)
	if self.soulCid ~= soulCid then
		self.soulCid = soulCid

		self:UpDateView()
	end
end

function SoulInteractionUI:UpDateView()
	local girlPOD = GirlModule.GetSoulGirlData(self.soulCid)

	if girlPOD then
		local soulData = SoulModule.GetSoulData(self.soulCid)

		UGUIUtil.SetText(self.TextName, soulData:GetCfgSoul().Name)
		self.live2DView:Refresh(soulData)
		self.soulChooseView:UpdateView(soulData)
	end
end

function SoulInteractionUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function SoulInteractionUI:SetOrientationLandscape()
	return
end

return SoulInteractionUI
