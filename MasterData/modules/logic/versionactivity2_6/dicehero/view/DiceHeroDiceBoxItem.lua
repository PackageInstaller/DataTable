-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroDiceBoxItem.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroDiceBoxItem", package.seeall)

local DiceHeroDiceBoxItem = class("DiceHeroDiceBoxItem", LuaCompBase)

function DiceHeroDiceBoxItem:ctor(parentView)
	self._parentView = parentView
end

function DiceHeroDiceBoxItem:init(go)
	self._goreroll = gohelper.findChild(go, "#go_reroll")
	self._goend = gohelper.findChild(go, "#go_end")
	self._godices = gohelper.findChild(go, "dices")
	self._btnreroll = gohelper.findChildButtonWithAudio(go, "#go_reroll/#btn_reroll")
	self._btnconfirm = gohelper.findChildButtonWithAudio(go, "#go_reroll/#btn_confirm")
	self._goconfirmeffect = gohelper.findChild(go, "#go_reroll/#btn_confirm/#hint")
	self._btnskip = gohelper.findChildButtonWithAudio(go, "#go_reroll/#btn_skip")
	self._btnend = gohelper.findChildButtonWithAudio(go, "#go_end/#btn_endround")
	self._goendeffect = gohelper.findChild(go, "#go_end/#btn_endround/#hint")
	self._btnusecard = gohelper.findChildButtonWithAudio(go, "#go_end/#btn_usecard")
	self._txtrollnum = gohelper.findChildTextMesh(go, "#go_reroll/#btn_reroll/#txt_rollnum")
	self._selectDict = {}
	self._dices = {}

	local diceitemPath = self._parentView.viewContainer._viewSetting.otherRes.diceitem

	for i = 1, 12 do
		local diceGo = gohelper.findChild(self._godices, tostring(i))
		local btn = gohelper.findChildButton(diceGo, "")
		local instGo = self._parentView:getResInst(diceitemPath, diceGo)

		self._dices[i] = MonoHelper.addNoUpdateLuaComOnceToGo(instGo, DiceHeroDiceItem, {
			index = i
		})

		self.addClickCb(self, btn, self._onDiceClick, self, i)
	end

	local lastEnterLevelId = DiceHeroModel.instance.lastEnterLevelId
	local co = lua_dice_level.configDict[lastEnterLevelId]

	if co then
		local gameInfo = DiceHeroModel.instance:getGameInfo(co.chapter)

		if gameInfo.currLevel ~= lastEnterLevelId or gameInfo.allPass then
			gohelper.setActive(self._btnskip, true)
		else
			gohelper.setActive(self._btnskip, false)
		end
	else
		gohelper.setActive(self._btnskip, false)
	end

	self:onProgressUpdate()
	self:updateRollNum()
end

function DiceHeroDiceBoxItem:addEventListeners()
	self._btnreroll:AddClickListener(self._onClickReroll, self)
	self._btnconfirm:AddClickListener(self._onClickConfirm, self)
	self._btnend:AddClickListener(self._onClickEnd, self)
	self._btnskip:AddClickListener(self._onClickSkip, self)
	self._btnusecard:AddClickListener(self._onClickUseCard, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.ConfirmDice, self.onProgressUpdate, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.StepEnd, self.onStepEnd, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, self.onSkillCardSelectChange, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardDiceChange, self.updateUseCardStatu, self)
end

function DiceHeroDiceBoxItem:removeEventListeners()
	self._btnreroll:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnend:RemoveClickListener()
	self._btnskip:RemoveClickListener()
	self._btnusecard:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.ConfirmDice, self.onProgressUpdate, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.StepEnd, self.onStepEnd, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, self.onSkillCardSelectChange, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardDiceChange, self.updateUseCardStatu, self)
end

function DiceHeroDiceBoxItem:onStepEnd(isFirst)
	for i = 1, 12 do
		self._dices[i]:onStepEnd(isFirst)
	end

	self:onProgressUpdate()
	self:updateRollNum()
	self:checkEndEffect()

	local gameData = DiceHeroFightModel.instance:getGameData()

	if gameData.diceBox.resetTimes <= 0 and not gameData.confirmed and DiceHeroFightModel.instance.finishResult == DiceHeroEnum.GameStatu.None then
		self:_onClickConfirm()
	end
end

function DiceHeroDiceBoxItem:startRoll()
	self._selectDict = {}

	for i = 1, 12 do
		self._dices[i]:startRoll()
	end
end

function DiceHeroDiceBoxItem:updateRollNum()
	local diceBox = DiceHeroFightModel.instance:getGameData().diceBox

	self._txtrollnum.text = diceBox.resetTimes > 0 and diceBox.resetTimes .. "/" .. diceBox.maxResetTimes or "<color=#cd5353>" .. diceBox.resetTimes .. "</color>/" .. diceBox.maxResetTimes

	gohelper.setActive(self._goconfirmeffect, diceBox.resetTimes <= 0)
end

function DiceHeroDiceBoxItem:onProgressUpdate()
	local gameData = DiceHeroFightModel.instance:getGameData()

	gohelper.setActive(self._goreroll, not gameData.confirmed)
	gohelper.setActive(self._goend, gameData.confirmed)

	if gameData.confirmed then
		self:checkEndEffect()
	end
end

function DiceHeroDiceBoxItem:checkEndEffect()
	local isAllCardCantUse = true
	local gameData = DiceHeroFightModel.instance:getGameData()

	for k, cardMo in pairs(gameData.skillCards) do
		if cardMo:canSelect() then
			isAllCardCantUse = false

			break
		end
	end

	gohelper.setActive(self._goendeffect, isAllCardCantUse)
end

function DiceHeroDiceBoxItem:_onDiceClick(index)
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	local diceMo = self._dices[index].diceMo

	if not diceMo or diceMo.deleted then
		return
	end

	local gameInfo = DiceHeroFightModel.instance:getGameData()
	local curCardMo = gameInfo.curSelectCardMo

	if not gameInfo.confirmed then
		if diceMo.status ~= DiceHeroEnum.DiceStatu.Normal then
			return
		end

		if self._selectDict[index] then
			self._selectDict[index] = nil

			self._dices[index]:setSelect(false)
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardunready)
		else
			self._selectDict[index] = true

			self._dices[index]:setSelect(true)
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardready)
		end
	else
		if not curCardMo then
			return
		end

		if diceMo.status == DiceHeroEnum.DiceStatu.HardLock then
			return
		end

		if self._selectDict[index] then
			curCardMo:removeDice(diceMo.uid)
		elseif not curCardMo:addDice(diceMo.uid) then
			return
		end

		if self._selectDict[index] then
			self._selectDict[index] = nil

			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardunready)
		else
			self._selectDict[index] = true

			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardready)
		end

		local canUseDict = curCardMo:getCanUseDiceUidDict()

		for i = 1, 12 do
			if self._dices[i].diceMo and not self._dices[i].diceMo.deleted then
				if self._selectDict[i] then
					self._dices[i]:setSelect(true)
				else
					self._dices[i]:setSelect(false, canUseDict[self._dices[i].diceMo.uid] and true or false)
				end
			end
		end
	end
end

function DiceHeroDiceBoxItem:_onClickUseCard()
	local gameInfo = DiceHeroFightModel.instance:getGameData()
	local curSelectSkillCard = gameInfo.curSelectCardMo

	if not curSelectSkillCard then
		return
	end

	local pattern, diceUids = curSelectSkillCard:canUse()

	if not pattern then
		return
	end

	if gameInfo.curSelectEnemyMo then
		if not gameInfo.curSelectEnemyMo.uid then
			local toId = ""

			DiceHeroRpc.instance:sendDiceHeroUseSkill(DiceHeroEnum.SkillType.Normal, curSelectSkillCard.skillId, toId, diceUids, (pattern > 0 or nil) and (pattern - 1 or pattern))
		end
	end
end

function DiceHeroDiceBoxItem:onSkillCardSelectChange()
	local gameInfo = DiceHeroFightModel.instance:getGameData()

	if not gameInfo.confirmed then
		return
	end

	self._selectDict = {}

	local curCardMo = gameInfo.curSelectCardMo

	if curCardMo then
		local isMatch, minMatchList = curCardMo:isMatchMin(true)

		if isMatch then
			for _, uid in ipairs(minMatchList) do
				for i = 1, 12 do
					if self._dices[i].diceMo and self._dices[i].diceMo.uid == uid and curCardMo:addDice(uid) then
						self._selectDict[i] = true

						break
					end
				end
			end
		end
	end

	local canUseDict = curCardMo and curCardMo:getCanUseDiceUidDict()

	for i = 1, 12 do
		if self._dices[i].diceMo and not self._dices[i].diceMo.deleted then
			local isCanUse

			if canUseDict then
				isCanUse = not not canUseDict[self._dices[i].diceMo.uid]
			end

			if self._selectDict[i] then
				self._dices[i]:setSelect(true)
			else
				self._dices[i]:setSelect(false, isCanUse)
			end
		end
	end

	self:updateUseCardStatu()
end

function DiceHeroDiceBoxItem:updateUseCardStatu()
	gohelper.setActive(self._btnusecard, false)

	do return end

	local curSelectSkillCard = DiceHeroFightModel.instance:getGameData().curSelectCardMo

	if not curSelectSkillCard then
		gohelper.setActive(self._btnusecard, false)

		return
	end

	gohelper.setActive(self._btnusecard, true)

	local canUse = not not curSelectSkillCard:canUse()

	ZProj.UGUIHelper.SetGrayscale(self._btnusecard.gameObject, not canUse)
end

function DiceHeroDiceBoxItem:_onClickReroll()
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	local diceBox = DiceHeroFightModel.instance:getGameData().diceBox

	if diceBox.resetTimes <= 0 then
		GameFacade.showToast(ToastEnum.DiceHeroDiceNoResetCount)

		return
	end

	local uids = {}

	for index in pairs(self._selectDict) do
		local diceMo = DiceHeroFightModel.instance:getGameData().diceBox.dices[index]

		table.insert(uids, diceMo.uid)
	end

	if not uids[1] then
		GameFacade.showToast(ToastEnum.DiceHeroNoSelectDice)

		return
	end

	DiceHeroRpc.instance:sendDiceHeroResetDice(uids, self._onReroll, self)
end

function DiceHeroDiceBoxItem:_onClickConfirm()
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	DiceHeroRpc.instance:sendDiceHeroConfirmDice(self._onConfirmEnd, self)
end

function DiceHeroDiceBoxItem:_onConfirmEnd(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:onSkillCardSelectChange()
end

function DiceHeroDiceBoxItem:_onClickEnd()
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	DiceHeroRpc.instance:sendDiceHeroEndRound()
	gohelper.setActive(self._goend, false)
end

function DiceHeroDiceBoxItem:_onClickSkip()
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroSkipFight, MsgBoxEnum.BoxType.Yes_No, self._closeGameView, nil, nil, self)
end

function DiceHeroDiceBoxItem:_closeGameView()
	ViewMgr.instance:closeView(ViewName.DiceHeroGameView)
end

function DiceHeroDiceBoxItem:_onReroll(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	DiceHeroFightModel.instance:getGameData().diceBox:init(msg.diceBox)
	DiceHeroFightModel.instance:getGameData():onStepEnd()
	self:updateRollNum()
	UIBlockHelper.instance:startBlock("DiceHeroDiceBoxItem_reroll", 0.6)

	for i = 1, 12 do
		self._dices[i]:setSelect(false)

		if self._selectDict[i] then
			local diceMo = DiceHeroFightModel.instance:getGameData().diceBox.dices[i]

			self._dices[i]:playRefresh(diceMo)
		end
	end

	self._selectDict = {}

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.RerollDice)
end

function DiceHeroDiceBoxItem:onDestroy()
	return
end

return DiceHeroDiceBoxItem
