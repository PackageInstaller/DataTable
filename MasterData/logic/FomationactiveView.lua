-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/FomationactiveView.lua

module("logic.extensions.nineplace.view.FomationactiveView", package.seeall)

local FomationactiveView = class("FomationactiveView", ViewComponent)

function FomationactiveView:ctor()
	FomationactiveView.super.ctor(self)
end

function FomationactiveView:buildUI()
	FomationactiveView.super.buildUI(self)

	self._btnClose = self:getBtn("close")
	self._icon = self:getGo("icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtName = self:getTxt("txtName")
	self._txtLv = self:getTxt("txtLv")
	self._attrs = {}

	for i = 1, 2 do
		local attr = {}
		local go = self:getGo("attr" .. i)

		attr.go = go
		attr.name = self:getTxt("attr" .. i)
		attr.value = goutil.findChildTextComponent(go, "txtValue")
		self._attrs[i] = attr
	end
end

function FomationactiveView:bindEvents()
	FomationactiveView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function FomationactiveView:unbindEvents()
	FomationactiveView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FomationactiveView:destroyUI()
	FomationactiveView.super.destroyUI(self)
end

function FomationactiveView:onEnter()
	FomationactiveView.super.onEnter(self)

	local info = self:getFirstParam() or {}
	local cfg = BattleConfig.instance:getFormStrengthLvCfg(info.formStrengthId, info.formStrengthLv)

	if cfg == nil then
		self:close()
	end

	self._txtName.text = cfg.name

	self._icon:SetState(info.formStrengthId - 1)

	self._txtLv.text = info.formStrengthLv .. "级"

	local attrList = FightingPowerFormula.instance:parseAttrValues(cfg.properties)
	local attrData = {}

	for k, v in pairs(attrList) do
		local attr = {}

		attr.key = k
		attr.value = v

		table.insert(attrData, attr)
	end

	for i = 1, 2 do
		goutil.setActive(self._attrs[i].go, attrData[i])

		if attrData[i] then
			local name, value = GameUtil.getPropertyInfo(attrData[i].key, attrData[i].value)

			self._attrs[i].name.text = name
			self._attrs[i].value.text = value
		end
	end

	settimer(1.15, self.close, self, false)
end

function FomationactiveView:onEnterFinished()
	FomationactiveView.super.onEnterFinished(self)
end

function FomationactiveView:onExit()
	FomationactiveView.super.onExit(self)
	removetimer(self.close, self)
end

function FomationactiveView:onExitFinished()
	FomationactiveView.super.onExitFinished(self)
end

return FomationactiveView
