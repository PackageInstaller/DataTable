-- chunkname: @modules/logic/character/view/CharacterSkillDescripteNew.lua

module("modules.logic.character.view.CharacterSkillDescripteNew", package.seeall)

local CharacterSkillDescripteNew = class("CharacterSkillDescripteNew", CharacterSkillDescripte)

function CharacterSkillDescripteNew:onInitView()
	self._txtlv = gohelper.findChildText(self.viewGO, "#txt_skillevel")
	self._goCurlevel = gohelper.findChild(self.viewGO, "#go_curlevel")
	self._txtskillDesc = gohelper.findChildText(self.viewGO, "#txt_descripte")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkillDescripteNew:addEvents()
	return
end

function CharacterSkillDescripteNew:removeEvents()
	return
end

function CharacterSkillDescripteNew:_editableInitView()
	self.canvasGroup = gohelper.onceAddComponent(self._txtskillDesc.gameObject, gohelper.Type_CanvasGroup)
	self.txtlvcanvasGroup = gohelper.onceAddComponent(self._txtlv.gameObject, gohelper.Type_CanvasGroup)
	self.govx = gohelper.findChild(self.viewGO, "vx")

	gohelper.setActive(self.govx, false)

	self.vxAni = self.govx:GetComponent(typeof(UnityEngine.Animation))
	self.aniLength = self.vxAni.clip.length
end

function CharacterSkillDescripteNew:updateInfo(parentView, heroId, exSkillLevel, nowLevel, fromHeroDetailView, isReshape)
	self.parentView = parentView

	local exCo = SkillConfig.instance:getherolevelexskillCO(heroId, exSkillLevel)

	self._txtlv.text = exSkillLevel

	gohelper.setActive(self._goCurlevel, not fromHeroDetailView and nowLevel + 1 == exSkillLevel)

	if not exCo then
		return 0
	end

	self._normalDesc = exCo.desc
	self.canvasGroup.alpha = nowLevel < exSkillLevel and 0.5 or 1
	self.txtlvcanvasGroup.alpha = nowLevel < exSkillLevel and 0.5 or 1

	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if heroMo and heroMo.destinyStoneMo then
		local co = heroMo.destinyStoneMo:getExpExchangeSkillCo(exSkillLevel)

		if co then
			self._reshapeDesc = co.desc
		end
	end

	self._heroId = heroId

	return (self:_showReshape(isReshape))
end

function CharacterSkillDescripteNew:_showReshape(show)
	if show then
		if not self._reshapeDesc then
			local desc = self._normalDesc

			return (self:_refeshDesc(desc))
		end
	end
end

function CharacterSkillDescripteNew:_refeshDesc(desc)
	local height = GameUtil.getTextHeightByLine(self._txtskillDesc, desc, 28, -3)

	height = height + 54

	recthelper.setHeight(self.viewGO.transform, height)

	self._skillDesc = self._skillDesc or MonoHelper.addNoUpdateLuaComOnceToGo(self._txtskillDesc.gameObject, SkillDescComp)

	self._skillDesc:updateInfo(self._txtskillDesc, desc, self._heroId)

	return height
end

return CharacterSkillDescripteNew
