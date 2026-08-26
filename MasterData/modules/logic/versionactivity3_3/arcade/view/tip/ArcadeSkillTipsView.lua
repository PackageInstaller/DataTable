-- chunkname: @modules/logic/versionactivity3_3/arcade/view/tip/ArcadeSkillTipsView.lua

module("modules.logic.versionactivity3_3.arcade.view.tip.ArcadeSkillTipsView", package.seeall)

local ArcadeSkillTipsView = class("ArcadeSkillTipsView", ArcadeTipsChildViewBase)

function ArcadeSkillTipsView:init(go)
	self.viewGO = go
	self._goboom = gohelper.findChild(self.viewGO, "Top/boom")
	self._goskill = gohelper.findChild(self.viewGO, "Top/skill")
	self._goweapon = gohelper.findChild(self.viewGO, "Top/weapon")
	self._simagecontentbg = gohelper.findChildSingleImage(self.viewGO, "contentbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "Top/boom/#txt_num")
	self._imageboomicon = gohelper.findChildImage(self.viewGO, "Top/boom/image_icon")
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "Top/skill/#image_icon")
	self._simageweaponicon = gohelper.findChildSingleImage(self.viewGO, "Top/weapon/has/#image_icon")
	self._scrolltips = gohelper.findChildScrollRect(self.viewGO, "#scroll_tips")
	self._txtname = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#txt_name")
	self._imageline = gohelper.findChildImage(self.viewGO, "#scroll_tips/Viewport/Content/#txt_name/line1")
	self._txtdec = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSkillTipsView:addEventListeners()
	return
end

function ArcadeSkillTipsView:removeEventListeners()
	return
end

function ArcadeSkillTipsView:onUpdateMO(mo, tipview)
	self._isInSide = mo.isInSide
	self._showNewSkill = false

	if self._isInSide then
		if not self._skillTipType or self._skillTipType ~= mo.skillTipType then
			self._showNewSkill = true
		end

		self._skillTipType = mo.skillTipType
		self._tipId = mo.tipId
		self._durability = mo.durability
	else
		if not self._skillMo or mo.SkillMo and self._skillMo.type ~= mo.SkillMo.type then
			self._showNewSkill = true
		end

		self._skillMo = mo.SkillMo
	end

	ArcadeSkillTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeSkillTipsView:isPlayOpenAnim()
	return self._showNewSkill or self._isChange
end

function ArcadeSkillTipsView:refreshView()
	local type, name, desc, icon
	local bombCount = 0

	if self._isInSide then
		type = self._skillTipType

		local id = self._tipId

		if type == ArcadeEnum.EffectType.Bomb then
			name = ArcadeConfig.instance:getBombName(id)

			local cfgDesc = ArcadeConfig.instance:getBombDesc(id)

			desc = ArcadeGameHelper.phraseDesc(cfgDesc, true)
			icon = ArcadeConfig.instance:getBombIcon(id)

			local characterMO = ArcadeGameModel.instance:getCharacterMO()
			local boomResMO = characterMO and characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.Bomb)

			bombCount = boomResMO and boomResMO:getCount() or 0
		elseif type == ArcadeEnum.EffectType.Skill then
			name = ArcadeConfig.instance:getActiveSkillName(id)

			local cfgDesc = ArcadeConfig.instance:getActiveSkillDesc(id)

			desc = ArcadeGameHelper.phraseDesc(cfgDesc, true)
			icon = ArcadeConfig.instance:getActiveSkillIcon(id)
		elseif type == ArcadeEnum.EffectType.Weapon then
			name = ArcadeConfig.instance:getCollectionName(id)
			desc = ArcadeConfig.instance:getCollectionDesc(id)

			if string.find(desc, "▩1%%s") then
				desc = string.gsub(desc, "▩1%%s", self._durability or 0)
			end

			icon = ArcadeConfig.instance:getCollectionIcon(id)
		end
	else
		if not self._skillMo then
			return
		end

		type = self._skillMo.type
		name = self._skillMo:getName()
		desc = self._skillMo:getDesc()
		icon = self._skillMo:getIcon()

		if self._skillMo.type == ArcadeEnum.EffectType.Bomb then
			bombCount = self._skillMo:getCount()
		end
	end

	gohelper.setActive(self._goboom, type == ArcadeEnum.EffectType.Bomb)
	gohelper.setActive(self._goskill, type == ArcadeEnum.EffectType.Skill)
	gohelper.setActive(self._goweapon, type == ArcadeEnum.EffectType.Weapon)

	self._txtname.text = name
	self._txtdec.text = desc

	local param = ArcadeEnum.EffectParam[type]

	if not string.nilorempty(icon) then
		local res = ResUrl.getEliminateIcon(icon)

		if type == ArcadeEnum.EffectType.Bomb then
			UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageboomicon, icon)

			self._txtnum.text = bombCount
		elseif type == ArcadeEnum.EffectType.Skill then
			UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageskillicon, icon)
		elseif type == ArcadeEnum.EffectType.Weapon then
			self._simageweaponicon:LoadImage(res)
		end
	end

	if not string.nilorempty(param.tipBg) then
		local tipBgRes = string.format("game/%s", param.tipBg)

		self._simagecontentbg:LoadImage(ResUrl.getEliminateIcon(tipBgRes))
	end

	if not string.nilorempty(param.tipNameColor) then
		self._txtname.color = GameUtil.parseColor(param.tipNameColor)
	end

	if not string.nilorempty(param.tipLineColor) then
		self._imageline.color = GameUtil.parseColor(param.tipLineColor)
	end
end

function ArcadeSkillTipsView:onDestroy()
	self._simageweaponicon:UnLoadImage()
	self._simagecontentbg:UnLoadImage()
end

return ArcadeSkillTipsView
