-- chunkname: @modules/logic/fight/view/preview/SkillEffectStatItem.lua

module("modules.logic.fight.view.preview.SkillEffectStatItem", package.seeall)

local SkillEffectStatItem = class("SkillEffectStatItem", ListScrollCell)

function SkillEffectStatItem:init(go)
	self._txtName = gohelper.findChildText(go, "title/txtName")
	self._txtSystem = gohelper.findChildText(go, "title/txtSystem")
	self._txtParticle = gohelper.findChildText(go, "title/txtParticle")
	self._txtMaterial = gohelper.findChildText(go, "title/txtMaterial")
	self._txtTexture = gohelper.findChildText(go, "title/txtTexture")
	self._clickName = SLFramework.UGUI.UIClickListener.Get(self._txtName.gameObject)
end

function SkillEffectStatItem:addEventListeners()
	self._clickName:AddClickListener(self._onClickName, self)
end

function SkillEffectStatItem:removeEventListeners()
	self._clickName:RemoveClickListener()
end

function SkillEffectStatItem:onUpdateMO(mo)
	self._mo = mo
	self._txtName.text = mo.name
	self._txtSystem.text = mo.particleSystem
	self._txtParticle.text = mo.particleCount
	self._txtMaterial.text = mo.materialCount
	self._txtTexture.text = mo.textureCount
end

function SkillEffectStatItem:_onClickName()
	if not gohelper.isNil(self._mo.go) then
		ZProj.GameHelper.SetSelection(self._mo.go)
	end
end

return SkillEffectStatItem
