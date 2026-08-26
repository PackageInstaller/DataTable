-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroHeroItem.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroHeroItem", package.seeall)

local DiceHeroHeroItem = class("DiceHeroHeroItem", LuaCompBase)

function DiceHeroHeroItem:init(go)
	self._emptyRelicItem = gohelper.findChild(go, "root/zaowu/#go_nulllayout/#go_item")
	self._relicItem = gohelper.findChild(go, "root/zaowu/#go_iconlayout/#simage_iconitem")
	self._buffItem = gohelper.findChild(go, "root/#go_statelist/#simage_icon")
	self._powerItem = gohelper.findChild(go, "root/headbg/energylayout/#go_item")
	self._txtname = gohelper.findChildTextMesh(go, "root/#txt_name")
	self._hpSlider = gohelper.findChildImage(go, "root/#simage_hpbg/#simage_hp")
	self._shieldSlider = gohelper.findChildImage(go, "root/#simage_shieldbg/#simage_shield")
	self._hpNum = gohelper.findChildTextMesh(go, "root/#simage_hpbg/#txt_hpnum")
	self._shieldNum = gohelper.findChildTextMesh(go, "root/#simage_shieldbg/#txt_shieldnum")
	self._click = gohelper.findChildButtonWithAudio(go, "root/#btn_clickhead")
	self._headicon = gohelper.findChildSingleImage(go, "root/headbg/headicon")
	self._headbgAnim = gohelper.findChildAnim(go, "root/headbg")
	self._headbgTrans = self._headbgAnim.transform
	self._btnClickHead = gohelper.findChildButtonWithAudio(go, "root/#btn_clickhead")
	self._btnClickRelic = gohelper.findChildButtonWithAudio(go, "root/#btn_clickrelic")
	self._btnClickBuff = gohelper.findChildButtonWithAudio(go, "root/#btn_clickbuff")
	self._goskilltips = gohelper.findChild(go, "tips/#go_skilltip")
	self._gozaowutip = gohelper.findChild(go, "tips/#go_zaowutip")
	self._gobufftip = gohelper.findChild(go, "tips/#go_fightbufftips")
	self._goskillitem = gohelper.findChild(go, "tips/#go_skilltip/viewport/content/item")
	self._gozaowuitem = gohelper.findChild(go, "tips/#go_zaowutip/viewport/content/item")
	self._gobuffitem = gohelper.findChild(go, "tips/#go_fightbufftips/viewport/content/item")
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self._click.gameObject)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	self._txtname.text = ""

	gohelper.setActive(gohelper.findChild(go, "root/dice"), false)

	self._gobuffeffect = gohelper.findChild(go, "root/#go_buff")
	self._godebuffeffect = gohelper.findChild(go, "root/#go_debuff")
	self._goshieldeffect = gohelper.findChild(go, "root/#go_shield")
	self._godamageeffect = gohelper.findChild(go, "root/#go_damage")
	self._godeadeffect = gohelper.findChild(go, "root/#go_died")
	self._shieldEffectAnim = gohelper.findChildAnim(go, "root/#simage_shieldbg")
	self._gobigskilleffect = gohelper.findChild(go, "root/headbg/#go_bigskilltip")
	self._gopassiveeffect = gohelper.findChild(go, "root/headbg/#go_passivetip")

	recthelper.setHeight(self._gobufftip.transform, 275)
	recthelper.setHeight(self._goskilltips.transform, 300)
	recthelper.setHeight(self._gozaowutip.transform, 300)
	self:refreshRelic()
	self:refreshAll()
	self._headicon:LoadImage(ResUrl.getHeadIconSmall(self:getHeroMo().co.icon))
	DiceHeroHelper.instance:registerEntity(self:getHeroMo().uid, self)
end

function DiceHeroHeroItem:addEventListeners()
	self._btnLongPress:AddLongPressListener(self._onLongClickHero, self)
	self._btnClickHead:AddClickListener(self._onClickHero, self)
	self._btnClickRelic:AddClickListener(self._showRelic, self)
	self._btnClickBuff:AddClickListener(self._showBuff, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self.onTouchScreen, self)
end

function DiceHeroHeroItem:removeEventListeners()
	self._btnLongPress:RemoveLongPressListener()
	self._btnClickHead:RemoveClickListener()
	self._btnClickRelic:RemoveClickListener()
	self._btnClickBuff:RemoveClickListener()
end

function DiceHeroHeroItem:setActiveTips(tipGo)
	gohelper.setActive(self._gozaowutip, tipGo == self._gozaowutip)
	gohelper.setActive(self._gobufftip, tipGo == self._gobufftip)
	gohelper.setActive(self._goskilltips, tipGo == self._goskilltips)
end

function DiceHeroHeroItem:_onClickHero()
	local heroMo = self:getHeroMo()

	if not heroMo:canUseHeroSkill() then
		if self._goskilltips.activeSelf then
			gohelper.setActive(self._goskilltips, false)

			return
		end

		local gameInfo = DiceHeroFightModel.instance:getGameData()
		local skillCards = gameInfo.heroSkillCards

		if not skillCards[1] then
			return
		end

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
		self:setActiveTips(self._goskilltips)
		gohelper.CreateObjList(self, self._createSkillItem, skillCards, nil, self._goskillitem)
	else
		gohelper.setActive(self._goskilltips, false)

		local gameInfo = DiceHeroFightModel.instance:getGameData()

		if not gameInfo.confirmed then
			return
		end

		if DiceHeroHelper.instance:isInFlow() then
			return
		end

		DiceHeroRpc.instance:sendDiceHeroUseSkill(DiceHeroEnum.SkillType.Hero, 0, "", {}, 0)
	end
end

function DiceHeroHeroItem:_onLongClickHero()
	local heroMo = self:getHeroMo()

	if not heroMo:canUseHeroSkill() then
		return
	end

	local gameInfo = DiceHeroFightModel.instance:getGameData()
	local skillCards = gameInfo.heroSkillCards

	if not skillCards[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	self:setActiveTips(self._goskilltips)
	gohelper.CreateObjList(self, self._createSkillItem, skillCards, nil, self._goskillitem)
end

function DiceHeroHeroItem:_createSkillItem(obj, data, index)
	local title = gohelper.findChildTextMesh(obj, "#txt_title/#txt_title")
	local desc = gohelper.findChildTextMesh(obj, "#txt_desc")

	title.text = data.co.name
	desc.text = data.co.desc
end

function DiceHeroHeroItem:_showBuff()
	if self._gobufftip.activeSelf then
		gohelper.setActive(self._gobufftip, false)

		return
	end

	local gameInfo = DiceHeroFightModel.instance:getGameData()
	local buffs = gameInfo.allyHero.buffs

	if not buffs[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	self:setActiveTips(self._gobufftip)
	gohelper.CreateObjList(self, self._createBuffItem, buffs, nil, self._gobuffitem)
end

function DiceHeroHeroItem:_createBuffItem(obj, data, index)
	local title = gohelper.findChildTextMesh(obj, "name/#txt_name")
	local layer = gohelper.findChildTextMesh(obj, "name/#txt_layer")
	local desc = gohelper.findChildTextMesh(obj, "#txt_desc")
	local image = gohelper.findChildImage(obj, "name/#simage_icon")
	local tag = gohelper.findChild(obj, "name/#txt_name/#go_tag")
	local tagName = gohelper.findChildTextMesh(obj, "name/#txt_name/#go_tag/#txt_name")

	if data.co.tag == 1 then
		gohelper.setActive(tag, true)

		tagName.text = luaLang("dicehero_buff")
	elseif data.co.tag == 2 then
		gohelper.setActive(tag, true)

		tagName.text = luaLang("dicehero_debuff")
	else
		gohelper.setActive(tag, false)
	end

	UISpriteSetMgr.instance:setBuffSprite(image, data.co.icon)

	title.text = data.co.name
	desc.text = data.co.desc
	layer.text = data.co.damp >= 0 and data.co.damp <= 4 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_buff_" .. data.co.damp), data.layer) or ""
end

function DiceHeroHeroItem:_showRelic()
	if self._gozaowutip.activeSelf then
		gohelper.setActive(self._gozaowutip, false)

		return
	end

	local gameInfo = DiceHeroFightModel.instance:getGameData()
	local relicIds = gameInfo.allyHero.relicIds
	local relicCos = {}

	for _, id in ipairs(relicIds) do
		table.insert(relicCos, lua_dice_relic.configDict[id])
	end

	if #relicCos <= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	self:setActiveTips(self._gozaowutip)
	gohelper.CreateObjList(self, self._createZaowuItem, relicCos, nil, self._gozaowuitem)
end

function DiceHeroHeroItem:_createZaowuItem(obj, data, index)
	local title = gohelper.findChildTextMesh(obj, "name/#txt_name")
	local desc = gohelper.findChildTextMesh(obj, "#txt_desc")
	local image = gohelper.findChildSingleImage(obj, "name/#simage_icon")

	image:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. data.icon .. ".png")

	title.text = data.name
	desc.text = data.desc
end

function DiceHeroHeroItem:onTouchScreen()
	if self._goskilltips.activeSelf then
		if gohelper.isMouseOverGo(self._goskilltips) and gohelper.isMouseOverGo(self._goskillitem.transform.parent) or gohelper.isMouseOverGo(self._btnClickHead) then
			return
		end

		gohelper.setActive(self._goskilltips, false)
	elseif self._gozaowutip.activeSelf then
		if gohelper.isMouseOverGo(self._gozaowutip) and gohelper.isMouseOverGo(self._gozaowuitem.transform.parent) or gohelper.isMouseOverGo(self._btnClickRelic) then
			return
		end

		gohelper.setActive(self._gozaowutip, false)
	elseif self._gobufftip.activeSelf then
		if gohelper.isMouseOverGo(self._gobufftip) and gohelper.isMouseOverGo(self._gobuffitem.transform.parent) or gohelper.isMouseOverGo(self._btnClickBuff) then
			return
		end

		gohelper.setActive(self._gobufftip, false)
	end
end

function DiceHeroHeroItem:refreshAll()
	gohelper.setActive(self._godeadeffect, false)
	self:refreshBuff()
	self:refreshPower()
	self:refreshInfo()
end

function DiceHeroHeroItem:refreshRelic()
	local heroMo = self:getHeroMo()
	local relicData = {}
	local emptyData = {}

	for i = 1, 5 do
		if heroMo.relicIds[i] then
			table.insert(relicData, heroMo.relicIds[i])
		else
			table.insert(emptyData, 1)
		end
	end

	gohelper.CreateObjList(self, self._createRelicItem, relicData, nil, self._relicItem)
	gohelper.CreateObjList(nil, nil, emptyData, nil, self._emptyRelicItem)
end

function DiceHeroHeroItem:_createRelicItem(obj, data, index)
	local image = gohelper.findChildSingleImage(obj, "")
	local co = lua_dice_relic.configDict[data]

	if co then
		image:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. co.icon .. ".png")
	end
end

function DiceHeroHeroItem:refreshBuff()
	local buffs = self:getHeroMo().buffs

	gohelper.CreateObjList(self, self._createBuff, buffs, nil, self._buffItem)
	self:refreshCanUseHeroSkill()

	if self._gobufftip.activeSelf then
		if #buffs > 0 then
			gohelper.CreateObjList(self, self._createBuffItem, buffs, nil, self._gobuffitem)
		else
			gohelper.setActive(self._gobufftip, false)
		end
	end
end

function DiceHeroHeroItem:_createBuff(obj, data, index)
	local image = gohelper.findChildImage(obj, "")

	UISpriteSetMgr.instance:setBuffSprite(image, data.co.icon)
end

function DiceHeroHeroItem:refreshPower()
	local power = self:getHeroMo().power
	local maxPower = self:getHeroMo().maxPower
	local data = {}

	for i = 1, maxPower do
		data[i] = i <= power and 1 or 0
	end

	self._powerItemAnims = self._powerItemAnims or self:getUserDataTb_()

	gohelper.CreateObjList(self, self._createPower, data, nil, self._powerItem)
	self:refreshCanUseHeroSkill()
end

function DiceHeroHeroItem:_createPower(obj, data, index)
	local light = gohelper.findChild(obj, "light")

	self._powerItemAnims[index] = gohelper.findChildAnim(obj, "")

	self._powerItemAnims[index]:Play("idle", 0, 0)
	gohelper.setActive(light, data == 1)
end

function DiceHeroHeroItem:getHeroMo()
	return DiceHeroFightModel.instance:getGameData().allyHero
end

function DiceHeroHeroItem:addHp(num)
	local heroMo = self:getHeroMo()

	heroMo.hp = heroMo.hp + num

	self:refreshInfo()
	gohelper.setActive(self._godeadeffect, heroMo.hp <= 0)
end

function DiceHeroHeroItem:addShield(num)
	local heroMo = self:getHeroMo()

	heroMo.shield = heroMo.shield + num

	self:refreshInfo()
end

function DiceHeroHeroItem:addPower(num)
	if num ~= 0 then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_ideachange)
	end

	local heroMo = self:getHeroMo()

	heroMo.power = heroMo.power + num

	self:refreshPower()

	if heroMo.maxPower <= heroMo.power then
		for i = 1, heroMo.maxPower do
			self._powerItemAnims[i]:Play("full", 0, 0)
		end
	elseif num > 0 then
		for i = heroMo.power - num + 1, heroMo.power do
			self._powerItemAnims[i]:Play("open", 0, 0)
		end
	else
		for i = heroMo.power + 1, heroMo.power - num do
			self._powerItemAnims[i]:Play("close", 0, 0)
		end
	end
end

function DiceHeroHeroItem:addMaxPower(num)
	if num ~= 0 then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_ideachange)
	end

	local heroMo = self:getHeroMo()

	heroMo.maxPower = heroMo.maxPower + num

	self:refreshPower()

	if heroMo.maxPower <= heroMo.power then
		for i = 1, heroMo.maxPower do
			self._powerItemAnims[i]:Play("full", 0, 0)
		end
	end
end

function DiceHeroHeroItem:addOrUpdateBuff(buffMo)
	local heroMo = self:getHeroMo()

	heroMo:addOrUpdateBuff(buffMo)
	self:refreshBuff()
end

function DiceHeroHeroItem:removeBuff(buffUid)
	local heroMo = self:getHeroMo()

	heroMo:removeBuff(buffUid)
	self:refreshBuff()
end

function DiceHeroHeroItem:refreshInfo()
	local heroMo = self:getHeroMo()
	local hp = heroMo.hp
	local maxHp = heroMo.maxHp
	local shield = heroMo.shield
	local maxShield = heroMo.maxShield

	ZProj.TweenHelper.DOFillAmount(self._hpSlider, (maxHp > 0 or nil) and (hp / maxHp or 0), 0.2)
	ZProj.TweenHelper.DOFillAmount(self._shieldSlider, (maxShield > 0 or nil) and (shield / maxShield or 0), 0.2)

	self._hpNum.text = hp
	self._shieldNum.text = shield
end

function DiceHeroHeroItem:refreshCanUseHeroSkill()
	local heroMo = self:getHeroMo()

	gohelper.setActive(self._gobigskilleffect, heroMo:canUseHeroSkill())
	gohelper.setActive(self._gopassiveeffect, heroMo:canUsePassiveSkill())
end

function DiceHeroHeroItem:getPos(type)
	if type == 1 then
		return self._shieldSlider.transform.position
	elseif type == 2 then
		return self._powerItem.transform.parent.position
	end

	return self._headbgTrans.position
end

function DiceHeroHeroItem:playHitAnim()
	self._headbgAnim:Play("hit", 0, 0)
end

function DiceHeroHeroItem:showEffect(type)
	gohelper.setActive(self._gobuffeffect, false)
	gohelper.setActive(self._godebuffeffect, false)
	gohelper.setActive(self._goshieldeffect, false)
	gohelper.setActive(self._godamageeffect, false)
	gohelper.setActive(self._gobuffeffect, type == 1)
	gohelper.setActive(self._godebuffeffect, type == 2)
	gohelper.setActive(self._goshieldeffect, type == 3)
	gohelper.setActive(self._godamageeffect, type == 4)

	if type == 3 then
		self._shieldEffectAnim:Play("light", 0, 0)
	end
end

function DiceHeroHeroItem:onDestroy()
	DiceHeroHelper.instance:unregisterEntity(self:getHeroMo().uid)
end

return DiceHeroHeroItem
