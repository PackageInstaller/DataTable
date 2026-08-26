-- chunkname: @modules/logic/effect/view/EffectStatItem.lua

module("modules.logic.effect.view.EffectStatItem", package.seeall)

local EffectStatItem = class("EffectStatItem", ListScrollCell)

function EffectStatItem:init(go)
	self._txtName = gohelper.findChildText(go, "title/txtName")
	self._txtSystem = gohelper.findChildText(go, "title/txtSystem")
	self._txtParticle = gohelper.findChildText(go, "title/txtParticle")
	self._txtMaterial = gohelper.findChildText(go, "title/txtMaterial")
	self._txtTexture = gohelper.findChildText(go, "title/txtTexture")
	self._clickName = SLFramework.UGUI.UIClickListener.Get(self._txtName.gameObject)
	self._btnClear = gohelper.findChildButtonWithAudio(go, "title/btnClear")
	self._slider = gohelper.findChildSlider(go, "title/slider")
	self._imgViewBg = go.transform.parent.parent.parent.parent:GetComponent(gohelper.Type_Image)

	self._slider:SetValue(self._imgViewBg.color.a)
end

function EffectStatItem:addEventListeners()
	self._clickName:AddClickListener(self._onClickName, self)
	self._btnClear:AddClickListener(self._onClickClear, self)
	self._slider:AddOnValueChanged(self._onValueChanged, self)
end

function EffectStatItem:removeEventListeners()
	self._clickName:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._slider:RemoveOnValueChanged()
end

function EffectStatItem:onUpdateMO(mo)
	self._mo = mo
	self._txtName.text = mo.name
	self._txtSystem.text = mo.particleSystem
	self._txtParticle.text = mo.particleCount
	self._txtMaterial.text = mo.materialCount
	self._txtTexture.text = mo.textureCount

	gohelper.setActive(self._btnClear.gameObject, self._index == 1)
	gohelper.setActive(self._slider.gameObject, self._index == 2)
end

function EffectStatItem:_onClickName()
	if not gohelper.isNil(self._mo.go) then
		ZProj.GameHelper.SetSelection(self._mo.go)
	end
end

function EffectStatItem:_onClickClear()
	EffectStatModel.instance:clearStat()
end

function EffectStatItem:_onValueChanged(param, value)
	local color = self._imgViewBg.color

	color.a = value
	self._imgViewBg.color = color
end

return EffectStatItem
