-- chunkname: @IQIGame\\UI\\Dreamland\\DreamlandUIComboController.lua

local ImageNumber = require("IQIGame.UI.Common.ImageNumber")
local m = {
	Showing = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.NormalComboNumCom = ImageNumber.New(self.NormalComboNumNode, 2, function(num)
		return DreamlandMainUIApi:GetString("ComboNumImagePath", 1, num)
	end)
	self.SpeComboNumCom = ImageNumber.New(self.SpeComboNumNode, 2, function(num)
		return DreamlandMainUIApi:GetString("ComboNumImagePath", 2, num)
	end)

	self.NormalComboView:SetActive(false)
	self.SpeComboView:SetActive(false)

	self.NormalComboAnim = self.NormalComboView:GetComponent(typeof(UnityEngine.Animation))
	self.SpeComboAnim = self.SpeComboView:GetComponent(typeof(UnityEngine.Animation))
end

function m:ShowCombo(combo)
	if combo <= 1 then
		return
	end

	self.Showing = true

	local isSpe = combo % 4 == 0

	self.NormalComboView:SetActive(not isSpe)
	self.SpeComboView:SetActive(isSpe)
	self.NormalComboAnim:Stop()
	self.SpeComboAnim:Stop()

	if not isSpe then
		self.NormalComboNumCom:SetNum(combo)

		self.CurrentAnimCom = self.NormalComboAnim

		GameEntry.Sound:PlaySound(10522, Constant.SoundGroup.UI)
	else
		self.SpeComboNumCom:SetNum(combo)

		self.CurrentAnimCom = self.SpeComboAnim

		GameEntry.Sound:PlaySound(10523, Constant.SoundGroup.UI)
	end

	self:PlayAnimation(self.CurrentAnimCom, "Dreamland_COMBO_In")

	if self.AutoHideTimer ~= nil then
		self.AutoHideTimer:Stop()
	end

	self.AutoHideTimer = Timer.New(function()
		self.AutoHideTimer = nil

		self:Hide()
	end, 2)

	self.AutoHideTimer:Start()
end

function m:Hide()
	self:PlayAnimation(self.CurrentAnimCom, "Dreamland_COMBO_Out")

	self.CurrentAnimCom = nil
	self.Showing = false
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.Showing then
		return
	end

	if self.NormalComboAnim ~= nil and not self.NormalComboAnim.isPlaying then
		self.NormalComboView:SetActive(false)
	end

	if self.SpeComboAnim ~= nil and not self.SpeComboAnim.isPlaying then
		self.SpeComboView:SetActive(false)
	end
end

function m:PlayAnimation(animation, animationName)
	if animation == nil then
		return
	end

	animation:Play(animationName)
end

function m:Dispose()
	if self.AutoHideTimer ~= nil then
		self.AutoHideTimer:Stop()

		self.AutoHideTimer = nil
	end

	self.NormalComboNumCom:Dispose()
	self.SpeComboNumCom:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CurrentAnimCom = nil
	self.NormalComboAnim = nil
	self.SpeComboAnim = nil
end

return m
