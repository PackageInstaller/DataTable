-- chunkname: @IQIGame\\UI\\MemorySceneMainUI.lua

local MemorySceneMainUI = {}

MemorySceneMainUI = Base:Extend("MemorySceneMainUI", "IQIGame.Onigao.UI.MemorySceneMainUI", MemorySceneMainUI)

function MemorySceneMainUI:OnInit()
	self:Initialize()
end

function MemorySceneMainUI:GetPreloadAssetPaths()
	return nil
end

function MemorySceneMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MemorySceneMainUI:IsManualShowOnOpen(userData)
	return false
end

function MemorySceneMainUI:GetBGM(userData)
	return nil
end

function MemorySceneMainUI:OnOpen(userData)
	self:Refresh(userData)
end

function MemorySceneMainUI:OnClose(userData)
	self:OnHide()
end

function MemorySceneMainUI:OnPause()
	return
end

function MemorySceneMainUI:OnResume()
	return
end

function MemorySceneMainUI:OnCover()
	return
end

function MemorySceneMainUI:OnReveal()
	return
end

function MemorySceneMainUI:OnRefocus(userData)
	return
end

function MemorySceneMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MemorySceneMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MemorySceneMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MemorySceneMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MemorySceneMainUI:Initialize()
	self.joystickComp = self.goJoystick:GetComponent("FingersJoystickScript")

	function self.joystickComp.JoystickExecuted(script, value)
		self:OnJoystickExecuted(script, value)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end
end

function MemorySceneMainUI:Refresh(userData)
	self.cfgSceneData = userData

	self:RefreshMisc()
end

function MemorySceneMainUI:OnHide()
	return
end

function MemorySceneMainUI:OnDestroy()
	self.joystickComp.JoystickExecuted = nil
end

function MemorySceneMainUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function MemorySceneMainUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function MemorySceneMainUI:OnClickBtnClose()
	MemorySModule.ExitScene(SceneID.MainCity)
end

function MemorySceneMainUI:OnJoystickExecuted(script, value)
	EventDispatcher.Dispatch(EventID.JoystickMove, value)
end

function MemorySceneMainUI:RefreshMisc()
	self.goTitle:GetComponent("Text").text = MemorySceneMainUIApi:GetString("title", self.cfgSceneData.Name)
end

return MemorySceneMainUI
