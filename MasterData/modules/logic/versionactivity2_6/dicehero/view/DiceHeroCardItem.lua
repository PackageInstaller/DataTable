-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroCardItem.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroCardItem", package.seeall)

local DiceHeroCardItem = class("DiceHeroCardItem", LuaCompBase)

function DiceHeroCardItem:init(go)
	self.go = go
	self.trans = go.transform
	self._anim = gohelper.findChildAnim(go, "")
	self._frame2 = gohelper.findChild(go, "#frame_level2")
	self._frame3 = gohelper.findChild(go, "#frame_level3")
	self._txtname = gohelper.findChildTextMesh(go, "layout/#txt_name")
	self._gosmallselect = gohelper.findChild(go, "#go_smallselect")
	self._gobigselect = gohelper.findChild(go, "#go_bigselect")
	self._imagelimitmask = gohelper.findChildImage(go, "#go_limitmask")
	self._goredtips = gohelper.findChild(go, "#go_redtips")
	self._txtredtips = gohelper.findChildTextMesh(go, "#go_redtips/#txt_tip")
	self._golock = gohelper.findChild(go, "#go_limitmask/icon")
	self._iconbg = gohelper.findChildImage(go, "#simage_bg")
	self._iconframe = gohelper.findChildImage(go, "#simage_frame")
	self._fighticon = gohelper.findChildImage(go, "layout/#go_fightnum/iconpos/#simage_icon")
	self._useNum = gohelper.findChildTextMesh(go, "#go_usenum/#txt_usenum")
	self._godiceitem = gohelper.findChild(go, "bottom/dicelist/#go_item")
	self._godicelist = gohelper.findChild(go, "bottom/dicelist")
	self._carddes = gohelper.findChildTextMesh(go, "layout/#scroll_skilldesc/viewport/#txt_skilldesc")
	self._txtnum = gohelper.findChildTextMesh(go, "layout/#go_fightnum/#txt_num")
	self._gonum = gohelper.findChild(go, "layout/#go_fightnum")
	self._buffeffect = gohelper.findChild(go, "#go_buffhit")
	self._click = gohelper.getClick(go)
end

function DiceHeroCardItem:addEventListeners()
	self._click:AddClickListener(self._onClickSkill, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, self._onSkillCardSelect, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardDiceChange, self._onSkillCardSelect, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.StepEnd, self.updateStatu, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.ConfirmDice, self.updateStatu, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.RerollDice, self.updateStatu, self)
end

function DiceHeroCardItem:removeEventListeners()
	self._click:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, self._onSkillCardSelect, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardDiceChange, self._onSkillCardSelect, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.StepEnd, self.updateStatu, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.ConfirmDice, self.updateStatu, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.RerollDice, self.updateStatu, self)
end

local dict = {
	[DiceHeroEnum.CardType.Atk] = "4",
	[DiceHeroEnum.CardType.Def] = "5",
	[DiceHeroEnum.CardType.Power] = "2"
}
local typeToIndex = {
	[DiceHeroEnum.CardType.Atk] = "1",
	[DiceHeroEnum.CardType.Def] = "5",
	[DiceHeroEnum.CardType.Power] = "4"
}

function DiceHeroCardItem:initData(data)
	DiceHeroHelper.instance:registerCard(data.skillId, self)

	self.data = data
	self._txtname.text = data.co.name
	self._canUse = false

	gohelper.setActive(self._gosmallselect, false)
	gohelper.setActive(self._gobigselect, false)

	self._carddes.text = data.co.desc

	gohelper.setActive(self._gonum, DiceHeroHelper.instance:isShowCarNum(data.co.effect1))
	UISpriteSetMgr.instance:setDiceHeroSprite(self._iconbg, "v2a6_dicehero_game_skillcardquality" .. (dict[data.co.type] or data.co.type))
	UISpriteSetMgr.instance:setDiceHeroSprite(self._iconframe, "v2a6_dicehero_game_skillcardbg" .. data.co.quality)
	UISpriteSetMgr.instance:setFightSprite(self._fighticon, "jnk_gj" .. (typeToIndex[data.co.type] or 0))
	gohelper.setActive(self._frame2, data.co.quality == "2")
	gohelper.setActive(self._frame3, data.co.quality == "3")
	self:updateStatu()
	gohelper.CreateObjList(self, self._createDiceItem, self.data.matchDiceRules, nil, self._godiceitem, DiceHeroCardDiceItem)

	if #self.data.matchDiceRules >= 5 then
		transformhelper.setLocalScale(self._godicelist.transform, 0.74, 0.74, 1)
	else
		transformhelper.setLocalScale(self._godicelist.transform, 1, 1, 1)
	end
end

function DiceHeroCardItem:updateStatu()
	local canSelect = false
	local noUseReason
	local gameData = DiceHeroFightModel.instance:getGameData()

	if not DiceHeroHelper.instance:isInFlow() then
		canSelect, noUseReason = self.data:canSelect()

		gohelper.setActive(self._buffeffect, self.data.co.type == DiceHeroEnum.CardType.Atk and gameData.allyHero:haveBuff2())

		if self._isGray == nil then
			self._isGray = false
			self._isBlack = false
		end

		local isGray = not canSelect
		local isBlack = canSelect and not gameData.confirmed

		if (isGray ~= self._isGray or isBlack ~= self._isBlack) and not DiceHeroHelper.instance:isInFlow() then
			if isGray and self._isBlack then
				self._anim:Play("togray", 0, 0)
			elseif isBlack and self._isGray then
				self._anim:Play("toblack", 0, 0)
			elseif isGray and not self._isGray then
				self._anim:Play("gray", 0, 0)
			elseif not isGray and self._isGray then
				self._anim:Play("ungray", 0, 0)
			elseif isBlack and not self._isBlack then
				self._anim:Play("black", 0, 0)
			elseif not isBlack and self._isBlack then
				self._anim:Play("unblack", 0, 0)
			end

			self._isGray = isGray
			self._isBlack = isBlack
		end
	end

	gohelper.setActive(self._goredtips, not canSelect)

	if not canSelect then
		self._canUse = false

		gohelper.setActive(self._gosmallselect, false)
		gohelper.setActive(self._gobigselect, false)

		if noUseReason == DiceHeroEnum.CantUseReason.NoDice then
			self._txtredtips.text = luaLang("dicehero_card_nodice")

			gohelper.setActive(self._golock, false)
		elseif noUseReason == DiceHeroEnum.CantUseReason.NoUseCount then
			self._txtredtips.text = luaLang("dicehero_card_nocount")

			gohelper.setActive(self._golock, false)
		elseif noUseReason == DiceHeroEnum.CantUseReason.BanSkill then
			self._txtredtips.text = luaLang("dicehero_card_banskill")

			gohelper.setActive(self._golock, true)
		end
	else
		gohelper.setActive(self._golock, false)
	end

	self._useNum.text = self.data.co.roundLimitCount == 0 and "∞" or self.data.co.roundLimitCount - self.data.curRoundUse

	self:updateNumShow()
end

function DiceHeroCardItem:_createDiceItem(obj, data, index)
	obj:initData(data, self.data, index)
end

function DiceHeroCardItem:_onSkillCardSelect()
	local gameInfo = DiceHeroFightModel.instance:getGameData()
	local isSelect = gameInfo.curSelectCardMo == self.data

	if isSelect then
		local canUse = self.data:canUse()

		self._canUse = self._canUse or false

		gohelper.setActive(self._gosmallselect, not canUse)
		gohelper.setActive(self._gobigselect, canUse)
	else
		gohelper.setActive(self._gosmallselect, false)
		gohelper.setActive(self._gobigselect, false)
	end

	self._isSelect = self._isSelect or false

	if self._isSelect ~= isSelect then
		self._isSelect = isSelect

		if isSelect then
			self._anim:Play("select", 0, 0)
		elseif not self._isGray and not self._isBlack then
			self._anim:Play("unselect", 0, 0)
		end
	end

	self:updateNumShow()
end

function DiceHeroCardItem:updateNumShow()
	if not DiceHeroHelper.instance:isShowCarNum(self.data.co.effect1) then
		return
	end

	if self.data.co.effect1 == DiceHeroEnum.SkillEffectType.Damage1 or self.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangeShield1 or self.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangePower1 then
		local canUseStage = self.data:canUse()
		local effects = string.split(self.data.co.params1, ",")

		for i = 1, #effects do
			effects[i] = string.format("<color=#%s>%s</color>", canUseStage ~= i and "A28D8D" or "FFFFFF", effects[i])
		end

		self._txtnum.text = table.concat(effects, "/")
	elseif self.data.co.effect1 == DiceHeroEnum.SkillEffectType.Damage2 or self.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangeShield2 then
		local totalNum = 0

		if self.data:isMatchMin() then
			local diceBox = DiceHeroFightModel.instance:getGameData().diceBox

			for k, uid in pairs(self.data.curSelectUids) do
				local diceMo = diceBox:getDiceMoByUid(uid)

				if diceMo then
					totalNum = totalNum + diceMo.num
				end
			end
		end

		self._txtnum.text = totalNum
	elseif self.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangePower2 then
		self._txtnum.text = "+" .. ((self.data:isMatchMin() or nil) and DiceHeroFightModel.instance:getGameData().allyHero.power)
	end
end

function DiceHeroCardItem:_onClickSkill()
	local gameInfo = DiceHeroFightModel.instance:getGameData()

	if not gameInfo.confirmed then
		return
	end

	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	if gameInfo.curSelectCardMo == self.data then
		local pattern, diceUids = self.data:canUse()

		if not pattern then
			GameFacade.showToast(ToastEnum.DiceHeroDiceNoEnoughDice)

			return
		end

		if gameInfo.curSelectEnemyMo then
			if not gameInfo.curSelectEnemyMo.uid then
				local toId = ""

				DiceHeroRpc.instance:sendDiceHeroUseSkill(DiceHeroEnum.SkillType.Normal, self.data.skillId, toId, diceUids, (pattern > 0 or nil) and (pattern - 1 or pattern))
			end
		end
	elseif self.data:canSelect() then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardrelease)
		gameInfo:setCurSelectCard(self.data)
	end
end

function DiceHeroCardItem:doHitAnim()
	self._anim:Play("hit", 0, 0)
end

function DiceHeroCardItem:playRefreshAnim()
	self._anim:Play("refresh", 0, 0)

	self._isGray = false
	self._isBlack = false
end

function DiceHeroCardItem:getPos()
	return self._txtname.transform.position
end

function DiceHeroCardItem:onDestroy()
	DiceHeroHelper.instance:unregisterCard(self.data.skillId)
end

return DiceHeroCardItem
