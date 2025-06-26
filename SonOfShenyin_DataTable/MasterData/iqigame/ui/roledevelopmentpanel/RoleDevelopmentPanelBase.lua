-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\RoleDevelopmentPanelBase.lua

local RoleDevelopmentPanelBase = {
	showAnimLength = 30,
	hideAnimLength = 30
}

function RoleDevelopmentPanelBase.New(view, controller)
	local obj = Clone(controller)

	obj:__Init(view)

	return obj
end

function RoleDevelopmentPanelBase:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.panelAnimCom = self.gameObject.gameObject:GetComponent("Animation")

	self:__OnInit()

	if self.panelAnimCom ~= nil then
		if LuaUtility.StrIsNullOrEmpty(self.showAnimName) then
			self.showAnimName = self.gameObject.transform.parent.name .. "_" .. self.gameObject.transform.name .. "_Show"
		end

		if LuaUtility.StrIsNullOrEmpty(self.hideAnimName) then
			self.hideAnimName = self.gameObject.transform.parent.name .. "_" .. self.gameObject.transform.name .. "_Hide"
		end
	end

	self.gameObject:SetActive(false)
end

function RoleDevelopmentPanelBase:Show(roleCid)
	self.roleCid = roleCid

	self:__OnAddListeners()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:__OnShow()
	self:__PlayAnim(self.showAnimName, 0, nil)
end

function RoleDevelopmentPanelBase:Refresh(roleCid)
	self.roleCid = roleCid

	self:__PlayAnim(self.hideAnimName, self.hideAnimLength, function()
		self:__OnRefresh()
		self:__PlayAnim(self.showAnimName, 0, nil)
	end)
end

function RoleDevelopmentPanelBase:Hide()
	if not self.gameObject.activeSelf then
		return
	end

	self:__OnRemoveListeners()
	self:__OnHide()
	self:__PlayAnim(self.hideAnimName, self.hideAnimLength, function()
		LuaUtility.SetGameObjectShow(self.gameObject, false)
	end)
end

function RoleDevelopmentPanelBase:Dispose()
	self:__OnRemoveListeners()
	AssetUtil.UnloadAsset(self)
	self:__OnDispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function RoleDevelopmentPanelBase:OnCover()
	self:__OnCover()
end

function RoleDevelopmentPanelBase:OnReveal()
	self:__OnReveal()
end

function RoleDevelopmentPanelBase:__OnInit()
	return
end

function RoleDevelopmentPanelBase:__OnAddListeners()
	return
end

function RoleDevelopmentPanelBase:__OnRemoveListeners()
	return
end

function RoleDevelopmentPanelBase:__OnCover()
	return
end

function RoleDevelopmentPanelBase:__OnReveal()
	return
end

function RoleDevelopmentPanelBase:__OnShow()
	return
end

function RoleDevelopmentPanelBase:__OnRefresh()
	return
end

function RoleDevelopmentPanelBase:__OnHide()
	return
end

function RoleDevelopmentPanelBase:__OnDispose()
	return
end

function RoleDevelopmentPanelBase:__ChangeComReturnVisible(isVisible)
	return
end

function RoleDevelopmentPanelBase:__PlayAnim(animName, callbackDelay, callback)
	if self.panelAnimCom == nil then
		if callback ~= nil then
			callback()
		end

		return
	end

	if LuaUtility.StrIsNullOrEmpty(animName) then
		if callback ~= nil then
			callback()
		end

		return
	end

	if self.panelAnimCom.isPlaying then
		self.panelAnimCom:Stop()
	end

	self.panelAnimCom:Play(animName)

	if callbackDelay <= 0 then
		if callback ~= nil then
			callback()
		end

		return
	end

	self.updateFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.RoleDevelopmentPanel, function()
		self.updateFrameTimer:Stop()

		if callback ~= nil then
			callback()
		end
	end, callbackDelay)

	self.updateFrameTimer:Start()
end

function RoleDevelopmentPanelBase:ActiveSelf()
	return self.gameObject.activeSelf
end

function RoleDevelopmentPanelBase:SetActive(active)
	LuaUtility.SetGameObjectShow(self.gameObject, active)
end

return RoleDevelopmentPanelBase
