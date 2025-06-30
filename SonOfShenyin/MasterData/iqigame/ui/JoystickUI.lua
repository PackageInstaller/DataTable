-- chunkname: @IQIGame\\UI\\JoystickUI.lua

local JoystickUI = {}

JoystickUI = Base:Extend("JoystickUI", "IQIGame.Onigao.UI.JoystickUI", JoystickUI)

function JoystickUI:OnInit()
	function self.delegateOnMove(direction)
		self:OnMove(direction)
	end

	function self.delegateOnMoveEnd()
		self:OnMove(Vector2.zero)
	end
end

function JoystickUI:GetPreloadAssetPaths()
	return nil
end

function JoystickUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function JoystickUI:IsManualShowOnOpen(userData)
	return false
end

function JoystickUI:GetBGM(userData)
	return nil
end

function JoystickUI:OnOpen(userData)
	local joystick = self.MyETCJoystick:GetComponent("ETCJoystick")

	joystick.activated = true
end

function JoystickUI:OnClose(userData)
	local joystick = self.MyETCJoystick:GetComponent("ETCJoystick")

	joystick.activated = false
end

function JoystickUI:OnAddListeners()
	local joystick = self.MyETCJoystick:GetComponent("ETCJoystick")

	joystick.onMove:AddListener(self.delegateOnMove)
	joystick.onMoveEnd:AddListener(self.delegateOnMoveEnd)
end

function JoystickUI:OnRemoveListeners()
	local joystick = self.MyETCJoystick:GetComponent("ETCJoystick")

	joystick.onMove:RemoveListener(self.delegateOnMove)
	joystick.onMoveEnd:RemoveListener(self.delegateOnMoveEnd)
end

function JoystickUI:OnPause()
	return
end

function JoystickUI:OnResume()
	return
end

function JoystickUI:OnCover()
	return
end

function JoystickUI:OnReveal()
	return
end

function JoystickUI:OnRefocus(userData)
	return
end

function JoystickUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function JoystickUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function JoystickUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function JoystickUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function JoystickUI:OnDestroy()
	return
end

function JoystickUI:OnMove(direction)
	direction:Normalize()
	EventDispatcher.Dispatch(EventID.JoystickMove, direction)
end

return JoystickUI
