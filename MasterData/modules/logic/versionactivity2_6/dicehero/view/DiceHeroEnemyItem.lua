-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroEnemyItem.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroEnemyItem", package.seeall)

local DiceHeroEnemyItem = class("DiceHeroEnemyItem", LuaCompBase)

function DiceHeroEnemyItem:init(go)
	self._buffItem = gohelper.findChild(go, "root/#go_statelist/#go_list/#go_item")
	self._hpSlider = gohelper.findChildImage(go, "root/#simage_hpbg/#simage_hp")
	self._shieldSlider = gohelper.findChildImage(go, "root/#simage_shieldbg/#simage_shield")
	self._hpNum = gohelper.findChildTextMesh(go, "root/#simage_hpbg/#txt_hpnum")
	self._shieldNum = gohelper.findChildTextMesh(go, "root/#simage_shieldbg/#txt_shieldnum")
	self._goselect = gohelper.findChild(go, "root/#go_select")
	self._gobuffmore = gohelper.findChild(go, "root/#go_statelist/#go_more")
	self._gobehaviormask = gohelper.findChild(go, "root/mask")
	self._iconbehavior = gohelper.findChildImage(go, "root/#icon_begavior")
	self._txtbehavior = gohelper.findChildTextMesh(go, "root/#icon_begavior/#txt_num")
	self._behaviortitle = gohelper.findChildTextMesh(go, "tips/#go_fighttip/title/#txt_title")
	self._behavioricon = gohelper.findChildImage(go, "tips/#go_fighttip/title/#simage_icon")
	self._behaviordesc = gohelper.findChildTextMesh(go, "tips/#go_fighttip/#txt_desc")
	self._headicon = gohelper.findChildSingleImage(go, "root/headbg/headicon")
	self._headbgAnim = gohelper.findChildAnim(go, "root/headbg")
	self._headbgTrans = self._headbgAnim.transform
	self._btnClickSelect = gohelper.findChildButtonWithAudio(go, "root/#btn_select")
	self._btnClickBuff = gohelper.findChildButtonWithAudio(go, "root/#btn_buff")
	self._btnClickBehavior = gohelper.findChildButtonWithAudio(go, "root/#btn_behavior")
	self._gofighttips = gohelper.findChild(go, "tips/#go_fighttip")
	self._gozaowutip = gohelper.findChild(go, "tips/#go_fightbufftips")
	self._gozaowuitem = gohelper.findChild(go, "tips/#go_fightbufftips/viewport/content/item")
	self._gobuffeffect = gohelper.findChild(go, "root/#go_buff")
	self._godebuffeffect = gohelper.findChild(go, "root/#go_debuff")
	self._goshieldeffect = gohelper.findChild(go, "root/#go_shield")
	self._godamageeffect = gohelper.findChild(go, "root/#go_damage")
	self._godeadeffect = gohelper.findChild(go, "root/#go_died")
	self._gobehaviorbuff = gohelper.findChild(go, "tips/#go_fighttip/#go_buff")
	self._behaviorbufftitle = gohelper.findChildTextMesh(self._gobehaviorbuff, "name/#txt_name")
	self._behaviorbuffimage = gohelper.findChildImage(self._gobehaviorbuff, "name/#simage_icon")
	self._behaviorbuffdesc = gohelper.findChildTextMesh(self._gobehaviorbuff, "#txt_desc")
	self._behaviorbufftag = gohelper.findChild(self._gobehaviorbuff, "name/#txt_name/#go_tag")
	self._behaviorbufftagName = gohelper.findChildTextMesh(self._gobehaviorbuff, "name/#txt_name/#go_tag/#txt_name")

	gohelper.setActive(self._goselect, false)
end

function DiceHeroEnemyItem:addEventListeners()
	self._btnClickSelect:AddClickListener(self._onClickEnemy, self)
	self._btnClickBehavior:AddClickListener(self.showBehavior, self)
	self._btnClickBuff:AddClickListener(self._showBuff, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self.onTouchScreen, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, self._onSkillCardSelectChange, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.EnemySelectChange, self._onSkillCardSelectChange, self)

	local hyperLinkClick = gohelper.onceAddComponent(self._behaviordesc.gameObject, typeof(ZProj.TMPHyperLinkClick))

	hyperLinkClick:SetClickListener(self._onLinkClick, self)
end

function DiceHeroEnemyItem:removeEventListeners()
	self._btnClickSelect:RemoveClickListener()
	self._btnClickBehavior:RemoveClickListener()
	self._btnClickBuff:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, self._onSkillCardSelectChange, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.EnemySelectChange, self._onSkillCardSelectChange, self)
end

function DiceHeroEnemyItem:initData(data)
	gohelper.setActive(self._godeadeffect, data.hp <= 0)

	self.data = data

	DiceHeroHelper.instance:registerEntity(data.uid, self)
	self._headicon:LoadImage(ResUrl.monsterHeadIcon(self:getHeroMo().co.icon))
	self:refreshAll()
end

function DiceHeroEnemyItem:refreshAll()
	self:refreshBuff()
	self:refreshInfo()
	self:updateBehavior()
end

function DiceHeroEnemyItem:updateBehavior()
	local behavior = self:getHeroMo().behaviors

	gohelper.setActive(self._iconbehavior, true)
	gohelper.setActive(self._gobehaviormask, true)

	if behavior.type == 1 then
		if not behavior.value[1] then
			local val = 0
			local len = #behavior.value

			self._txtbehavior.text = val * len
			self._behaviortitle.text = luaLang("dicehero_behavior_atk_title")

			if not behavior.exList then
				self._behaviordesc.text = self:getBehaviorText(behavior)
			else
				local strArr = {
					self:getBehaviorText(behavior)
				}

				for _, other in ipairs(behavior.exList) do
					table.insert(strArr, self:getBehaviorText(other))
				end

				self._behaviordesc.text = table.concat(strArr, "\n")
			end

			UISpriteSetMgr.instance:setFightSprite(self._iconbehavior, "jnk_gj1")
			UISpriteSetMgr.instance:setFightSprite(self._behavioricon, "jnk_gj1")
		end
	elseif behavior.type == 2 then
		self._txtbehavior.text = ""

		if behavior.isToAll then
			self._behaviortitle.text = luaLang("dicehero_behavior_buff_title")

			UISpriteSetMgr.instance:setFightSprite(self._iconbehavior, "jnk_gj4")
			UISpriteSetMgr.instance:setFightSprite(self._behavioricon, "jnk_gj4")
		elseif behavior.isToFriend then
			self._behaviortitle.text = luaLang("dicehero_behavior_buff_title")

			UISpriteSetMgr.instance:setFightSprite(self._iconbehavior, "jnk_gj4")
			UISpriteSetMgr.instance:setFightSprite(self._behavioricon, "jnk_gj4")
		else
			UISpriteSetMgr.instance:setFightSprite(self._iconbehavior, "jnk_gj5")
			UISpriteSetMgr.instance:setFightSprite(self._behavioricon, "jnk_gj5")

			self._behaviortitle.text = luaLang("dicehero_behavior_def_title")
		end

		if not behavior.exList then
			self._behaviordesc.text = self:getBehaviorText(behavior)
		else
			local strArr = {
				self:getBehaviorText(behavior)
			}

			for _, other in ipairs(behavior.exList) do
				table.insert(strArr, self:getBehaviorText(other))
			end

			self._behaviordesc.text = table.concat(strArr, "\n")
		end
	elseif behavior.type == 3 then
		self._txtbehavior.text = ""

		if not behavior.exList then
			self._behaviordesc.text = self:getBehaviorText(behavior)
		else
			local strArr = {
				self:getBehaviorText(behavior)
			}

			for _, other in ipairs(behavior.exList) do
				table.insert(strArr, self:getBehaviorText(other))
			end

			self._behaviordesc.text = table.concat(strArr, "\n")
		end

		if behavior.isToSelf or behavior.isToAll then
			self._behaviortitle.text = luaLang("dicehero_behavior_buff_title")

			UISpriteSetMgr.instance:setFightSprite(self._iconbehavior, "jnk_gj4")
			UISpriteSetMgr.instance:setFightSprite(self._behavioricon, "jnk_gj4")
		else
			self._behaviortitle.text = luaLang("dicehero_behavior_debuff_title")

			UISpriteSetMgr.instance:setFightSprite(self._iconbehavior, "jnk_gj3")
			UISpriteSetMgr.instance:setFightSprite(self._behavioricon, "jnk_gj3")
		end
	else
		gohelper.setActive(self._iconbehavior, false)
		gohelper.setActive(self._gobehaviormask, false)
	end
end

function DiceHeroEnemyItem:getBehaviorText(behavior)
	if behavior.type == 1 then
		if not behavior.value[1] then
			local val = 0
			local len = #behavior.value

			if len > 1 then
				local mul = luaLang("multiple")

				val = string.format("%s%s%s", len, mul, val)
			end

			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_atk"), val)
		end
	elseif behavior.type == 2 then
		if not behavior.value[1] then
			local val = 0

			if behavior.isToAll then
				return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_def_all"), val)
			elseif behavior.isToFriend then
				return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_def_friend"), val)
			else
				return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_def"), val)
			end
		end
	elseif behavior.type == 3 then
		local val = tonumber(behavior.value[1]) or 0
		local buffCo = lua_dice_buff.configDict[val]

		if buffCo then
			val = string.format("<u><color=#4e6698><link=\"%s\">%s</link></color></u>", val, buffCo.name)
		end

		if behavior.isToSelf then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_buff"), val)
		elseif behavior.isToAll then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_buff_all"), val)
		else
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_debuff"), val)
		end
	end
end

function DiceHeroEnemyItem:_onLinkClick(buffId)
	local buffCo = lua_dice_buff.configDict[tonumber(buffId)]

	if not buffCo then
		return
	end

	gohelper.setActive(self._gobehaviorbuff, true)
	UISpriteSetMgr.instance:setBuffSprite(self._behaviorbuffimage, buffCo.icon)

	self._behaviorbufftitle.text = buffCo.name
	self._behaviorbuffdesc.text = buffCo.desc

	if buffCo.tag == 1 then
		gohelper.setActive(self._behaviorbufftag, true)

		self._behaviorbufftagName.text = luaLang("dicehero_buff")
	elseif buffCo.tag == 2 then
		gohelper.setActive(self._behaviorbufftag, true)

		self._behaviorbufftagName.text = luaLang("dicehero_debuff")
	else
		gohelper.setActive(self._behaviorbufftag, false)
	end
end

function DiceHeroEnemyItem:refreshBuff()
	local buffs = self:getHeroMo().buffs

	if #buffs > 7 then
		gohelper.setActive(self._gobuffmore, true)

		buffs = {
			unpack(buffs, 1, 7)
		}
	else
		gohelper.setActive(self._gobuffmore, false)
	end

	gohelper.CreateObjList(self, self._createBuff, buffs, nil, self._buffItem)

	if self._gozaowutip.activeSelf then
		if #buffs > 0 then
			gohelper.CreateObjList(self, self._createSkillItem, buffs, nil, self._gozaowuitem)
		else
			gohelper.setActive(self._gozaowutip, false)
		end
	end
end

function DiceHeroEnemyItem:_createBuff(obj, data, index)
	local image = gohelper.findChildImage(obj, "")

	UISpriteSetMgr.instance:setBuffSprite(image, data.co.icon)
end

function DiceHeroEnemyItem:getHeroMo()
	return self.data
end

function DiceHeroEnemyItem:addHp(num)
	local heroMo = self:getHeroMo()

	heroMo:setHp(heroMo.hp + num)
	self:refreshInfo()
	gohelper.setActive(self._godeadeffect, heroMo.hp <= 0)

	if heroMo.hp <= 0 then
		gohelper.setActive(self._iconbehavior, false)
		gohelper.setActive(self._gobehaviormask, false)
		self:refreshBuff()
	end
end

function DiceHeroEnemyItem:addShield(num)
	local heroMo = self:getHeroMo()

	heroMo.shield = heroMo.shield + num

	self:refreshInfo()
end

function DiceHeroEnemyItem:addOrUpdateBuff(buffMo)
	local heroMo = self:getHeroMo()

	heroMo:addOrUpdateBuff(buffMo)
	self:refreshBuff()
end

function DiceHeroEnemyItem:removeBuff(buffUid)
	local heroMo = self:getHeroMo()

	heroMo:removeBuff(buffUid)
	self:refreshBuff()
end

function DiceHeroEnemyItem:refreshInfo()
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

function DiceHeroEnemyItem:_onClickEnemy()
	local gameInfo = DiceHeroFightModel.instance:getGameData()

	gameInfo:setCurEnemy(self.data)
end

function DiceHeroEnemyItem:_onSkillCardSelectChange()
	local gameInfo = DiceHeroFightModel.instance:getGameData()

	gohelper.setActive(self._goselect, gameInfo.curSelectEnemyMo == self.data)
end

function DiceHeroEnemyItem:_showBuff()
	if self._gozaowutip.activeSelf then
		gohelper.setActive(self._gozaowutip, false)

		return
	end

	gohelper.setActive(self._gofighttips, false)

	local buffs = self:getHeroMo().buffs

	if not buffs[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(self._gozaowutip, true)
	gohelper.CreateObjList(self, self._createSkillItem, buffs, nil, self._gozaowuitem)
end

function DiceHeroEnemyItem:showBehavior()
	if self._gofighttips.activeSelf then
		gohelper.setActive(self._gofighttips, false)

		return
	end

	gohelper.setActive(self._gozaowutip, false)

	local behavior = self:getHeroMo().behaviors

	if not behavior.type then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(self._gofighttips, true)
	gohelper.setActive(self._gobehaviorbuff, false)
end

function DiceHeroEnemyItem:hideBehavior()
	gohelper.setActive(self._gozaowutip, false)
	gohelper.setActive(self._gofighttips, false)
end

function DiceHeroEnemyItem:_createSkillItem(obj, data, index)
	local title = gohelper.findChildTextMesh(obj, "name/#txt_name")
	local image = gohelper.findChildImage(obj, "name/#simage_icon")
	local desc = gohelper.findChildTextMesh(obj, "#txt_desc")
	local layer = gohelper.findChildTextMesh(obj, "name/#txt_layer")
	local tag = gohelper.findChild(obj, "name/#txt_name/#go_tag")
	local tagName = gohelper.findChildTextMesh(obj, "name/#txt_name/#go_tag/#txt_name")

	layer.text = data.co.damp >= 0 and data.co.damp <= 4 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_buff_" .. data.co.damp), data.layer) or ""

	UISpriteSetMgr.instance:setBuffSprite(image, data.co.icon)

	title.text = data.co.name
	desc.text = data.co.desc

	if data.co.tag == 1 then
		gohelper.setActive(tag, true)

		tagName.text = luaLang("dicehero_buff")
	elseif data.co.tag == 2 then
		gohelper.setActive(tag, true)

		tagName.text = luaLang("dicehero_debuff")
	else
		gohelper.setActive(tag, false)
	end
end

function DiceHeroEnemyItem:onTouchScreen()
	if self._gozaowutip.activeSelf then
		if gohelper.isMouseOverGo(self._gozaowutip) and gohelper.isMouseOverGo(self._gozaowuitem.transform.parent) or gohelper.isMouseOverGo(self._btnClickBuff) then
			return
		end

		gohelper.setActive(self._gozaowutip, false)
	elseif self._gofighttips.activeSelf then
		if gohelper.isMouseOverGo(self._gofighttips) or gohelper.isMouseOverGo(self._btnClickBehavior) then
			return
		end

		gohelper.setActive(self._gofighttips, false)
	end
end

function DiceHeroEnemyItem:getPos(type)
	if type == 1 then
		return self._shieldSlider.transform.position
	end

	return self._headbgTrans.position
end

function DiceHeroEnemyItem:playHitAnim()
	self._headbgAnim:Play("hit", 0, 0)
end

function DiceHeroEnemyItem:showEffect(type)
	gohelper.setActive(self._gobuffeffect, false)
	gohelper.setActive(self._godebuffeffect, false)
	gohelper.setActive(self._goshieldeffect, false)
	gohelper.setActive(self._godamageeffect, false)
	gohelper.setActive(self._gobuffeffect, type == 1)
	gohelper.setActive(self._godebuffeffect, type == 2)
	gohelper.setActive(self._goshieldeffect, type == 3)
	gohelper.setActive(self._godamageeffect, type == 4)
end

function DiceHeroEnemyItem:onDestroy()
	DiceHeroHelper.instance:unregisterEntity(self.data.uid)
end

return DiceHeroEnemyItem
