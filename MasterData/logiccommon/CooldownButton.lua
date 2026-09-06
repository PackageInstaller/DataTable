-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/cooldownbtn/CooldownButton.lua

module("logiccommon.common.viewlib.cooldownbtn.CooldownButton", package.seeall)

local CooldownButton = class("CooldownButton")
local UnityTime = UnityEngine.Time

function CooldownButton.Get(go)
	local component = Framework.LuaComponentContainer.Get(go, CooldownButton)

	if not component then
		component = Framework.LuaComponentContainer.Add(go, CooldownButton)

		component:init(go)
	end

	return component
end

function CooldownButton:ctor()
	self._cd = 0
	self._currCd = 0
end

function CooldownButton:setCD(cd)
	self._cd = cd
	self._currCd = cd

	self:_updateProgress()
end

function CooldownButton:addClickListener(clickListener, clickListenerObj)
	self._clickListener = clickListener
	self._clickListenerObj = clickListenerObj

	if self._btn then
		self._btn:AddClickListener(self._onClickButton, self)
	end
end

function CooldownButton:removeClickListener()
	self._clickListener = nil
	self._clickListenerObj = nil

	if self._btn then
		self._btn:RemoveClickListener()
	end
end

function CooldownButton:Update()
	if self._currCd and self._currCd > 0 then
		self._currCd = self._currCd - UnityTime.deltaTime

		self:_updateProgress()
	end
end

function CooldownButton:init(go)
	self._gameObject = go

	local btn = go:GetComponentInChildren(typeof(UnityEngine.UI.Button))
	local slider = go:GetComponentInChildren(typeof(UnityEngine.UI.Slider))
	local cdGo = GameUtil.findChildEx(go, "CD")

	if btn then
		self._btn = Framework.ButtonAdapter.Get(btn.gameObject)
		self._btnGraphic = self._btn:GetComponent(typeof(UnityEngine.UI.Graphic))
	end

	if slider then
		self._slider = Framework.SliderAdapter.Get(slider.gameObject)
	end

	if cdGo then
		self._txtCd = cdGo:GetComponent(typeof(UnityEngine.UI.Text))
	end

	self:setCD(0)
end

function CooldownButton:_getProgress()
	if not self._cd or self._cd == 0 then
		return 0
	end

	if not self._currCd or self._currCd == 0 then
		return 0
	end

	return self._currCd / self._cd
end

function CooldownButton:_updateProgress()
	local progress = self:_getProgress()

	if self._slider then
		self._slider:SetValue(progress)
	end

	if self._txtCd then
		local cd = math.max(0, (not self._currCd or nil) and 0)

		self._txtCd.text = cd > 0 and math.floor(cd) or ""
	end

	if self._btnGraphic then
		self._btnGraphic.raycastTarget = progress <= 0
	end
end

function CooldownButton:_onClickButton()
	local cd = math.max(0, (not self._currCd or nil) and 0)

	if cd <= 0 and self._clickListener then
		if self._clickListenerObj then
			self._clickListener(self._clickListenerObj)
		else
			self._clickListener()
		end
	end
end

return CooldownButton
