-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaGameView.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameView", package.seeall)

local NuoDiKaGameView = class("NuoDiKaGameView", BaseView)

function NuoDiKaGameView:onInitView()
	self._simageBG = gohelper.findChildSingleImage(self.viewGO, "#simage_BG")
	self._btnbgclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_bgclick")
	self._gotarget = gohelper.findChild(self.viewGO, "#go_target")
	self._txttarget = gohelper.findChildText(self.viewGO, "#go_target/TargetList/targetbg/#txt_target")
	self._gotargeticon = gohelper.findChild(self.viewGO, "#go_target/TargetList/targetbg/#txt_target/#img_Icon")
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._gomaptop = gohelper.findChild(self.viewGO, "#go_maptop")
	self._gomainrole = gohelper.findChild(self.viewGO, "#go_mainrole")
	self._gomainhead = gohelper.findChild(self.viewGO, "#go_mainrole/Head")
	self._headAnim = self._gomainhead:GetComponent(typeof(UnityEngine.Animator))
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#go_mainrole/Head/#simage_Icon")
	self._goHP = gohelper.findChild(self.viewGO, "#go_mainrole/#go_HP")
	self._txtHPNum = gohelper.findChildText(self.viewGO, "#go_mainrole/#go_HP/#txt_HPNum")
	self._goAttack = gohelper.findChild(self.viewGO, "#go_mainrole/#go_Attack")
	self._txtAttckNum = gohelper.findChildText(self.viewGO, "#go_mainrole/#go_Attack/#txt_AttckNum")
	self._goBuffList = gohelper.findChild(self.viewGO, "#go_mainrole/#go_BuffList")
	self._golist = gohelper.findChild(self.viewGO, "#go_mainrole/#go_BuffList/#go_list")
	self._goBuffIcon = gohelper.findChild(self.viewGO, "#go_mainrole/#go_BuffList/#go_list/#go_BuffIcon")
	self._goTips = gohelper.findChild(self.viewGO, "#go_mainrole/#go_Tips")
	self._goItem = gohelper.findChild(self.viewGO, "#go_mainrole/#go_Tips/#go_Item")
	self._imageBuffIcon = gohelper.findChildImage(self.viewGO, "#go_mainrole/#go_Tips/#go_Item/#image_BuffIcon")
	self._gohealeff = gohelper.findChild(self.viewGO, "#go_mainrole/vx_heal")
	self._gohpeff = gohelper.findChild(self.viewGO, "#go_mainrole/#go_hpeff")
	self._gohurt = gohelper.findChild(self.viewGO, "#go_mainrole/#go_hpeff/#go_hurt")
	self._txthurt = gohelper.findChildText(self.viewGO, "#go_mainrole/#go_hpeff/#go_hurt/#txt_hurt")
	self._goheal = gohelper.findChild(self.viewGO, "#go_mainrole/#go_hpeff/#go_heal")
	self._txtheal = gohelper.findChildText(self.viewGO, "#go_mainrole/#go_hpeff/#go_heal/#txt_heal")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NuoDiKaGameView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btnbgclick:AddClickListener(self._btnbgclickOnClick, self)
end

function NuoDiKaGameView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btnskip:RemoveClickListener()
	self._btnbgclick:RemoveClickListener()
end

function NuoDiKaGameView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.MoLiDeErResetGameTip, MsgBoxEnum.BoxType.Yes_No, self._onChooseReset, nil, nil, self)
end

function NuoDiKaGameView:_onChooseReset()
	NuoDiKaMapModel.instance:resetMap(self._mapId)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapResetClicked)
	self:_onMapReset()
end

function NuoDiKaGameView:_btnskipOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.MoLiDeErSkipGameTip, MsgBoxEnum.BoxType.Yes_No, self._onChooseSkip, nil, nil, self)
end

function NuoDiKaGameView:_onChooseSkip()
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(self.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "Skip",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - self._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = self._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = self._hp
	})
	self:_onCloseClick()
end

function NuoDiKaGameView:_editableInitView()
	gohelper.setActive(self._btnskip.gameObject, false)

	self._showTipList = {}

	self:_addEvents()
end

function NuoDiKaGameView:_btnbgclickOnClick()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeClicked, 0)
end

function NuoDiKaGameView:_onCloseClick()
	if self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end

	TaskDispatcher.runDelay(self.closeThis, self, 0.5)
end

function NuoDiKaGameView:_addEvents()
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.GameSuccess, self._onGameSuccess, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.GameItemUnlockSuccess, self._showItemGameSuccess, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.ItemStartSkill, self._onItemUseSkill, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.AttackMainRole, self._onAttackMainRole, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.StartInteract, self._onMapInteract, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.EnemyDead, self._onEnemyDead, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.CheckShowEnemyDetail, self._onCheckShowEnemyDetails, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.CheckShowItemDetail, self._onCheckShowItemDetails, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.OnActiveClose, self._onActiveClose, self)
end

function NuoDiKaGameView:_removeEvents()
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.GameSuccess, self._onGameSuccess, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.GameItemUnlockSuccess, self._showItemGameSuccess, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.ItemStartSkill, self._onItemUseSkill, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.AttackMainRole, self._onAttackMainRole, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.StartInteract, self._onMapInteract, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.EnemyDead, self._onEnemyDead, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.CheckShowEnemyDetail, self._onCheckShowEnemyDetails, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.CheckShowItemDetail, self._onCheckShowItemDetails, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.OnActiveClose, self._onActiveClose, self)
end

function NuoDiKaGameView:_onActiveClose()
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(self.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "ActiveClose",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - self._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = self._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = self._hp
	})
end

function NuoDiKaGameView:_onCheckShowEnemyDetails(enemyId)
	if ViewMgr.instance:isOpen(ViewName.NuoDiKaGameResultView) then
		return
	end

	local isEpisodePass = NuoDiKaModel.instance:isEpisodePass(self.viewParam.episodeId)

	if isEpisodePass then
		return
	end

	local status = NuoDiKaModel.instance:getEpisodeStatus(self.viewParam.episodeId)

	if status ~= NuoDiKaEnum.EpisodeStatus.MapGame then
		return
	end

	for _, unitId in pairs(self._showTipList) do
		if unitId == enemyId then
			return
		end
	end

	local data = {}

	data.unitId = enemyId
	data.unitType = NuoDiKaEnum.EventType.Enemy

	PopupController.instance:addPopupView(PopupEnum.PriorityType.NuoDiKaUnitTip, ViewName.NuoDiKaGameUnitDetailView, data)
	table.insert(self._showTipList, enemyId)
end

function NuoDiKaGameView:_onCheckShowItemDetails(itemId)
	if ViewMgr.instance:isOpen(ViewName.NuoDiKaGameResultView) then
		return
	end

	local isEpisodePass = NuoDiKaModel.instance:isEpisodePass(self.viewParam.episodeId)

	if isEpisodePass then
		return
	end

	local status = NuoDiKaModel.instance:getEpisodeStatus(self.viewParam.episodeId)

	if status ~= NuoDiKaEnum.EpisodeStatus.MapGame then
		return
	end

	for _, unitId in pairs(self._showTipList) do
		if unitId == itemId then
			return
		end
	end

	local data = {}

	data.unitId = itemId
	data.unitType = NuoDiKaEnum.EventType.Item

	PopupController.instance:addPopupView(PopupEnum.PriorityType.NuoDiKaUnitTip, ViewName.NuoDiKaGameUnitDetailView, data)
	table.insert(self._showTipList, itemId)
end

function NuoDiKaGameView:_onGameSuccess()
	if self._gameSuccess then
		return
	end

	self:_endBlock()

	self._gameSuccess = true

	local data = {}

	data.isSuccess = true
	data.callback = self._onSuccessTiped
	data.callbackObj = self

	NuoDiKaController.instance:enterGameResultView(data)
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(self.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "Success",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - self._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = self._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = self._hp
	})
end

function NuoDiKaGameView:_onSuccessTiped()
	self:_onCloseClick()
end

function NuoDiKaGameView:_onGameFailed()
	UIBlockMgr.instance:endBlock("gamefail")

	if self._mapMo.passType == NuoDiKaEnum.MapPassType.ClearEnemy then
		if NuoDiKaMapModel.instance:isAllEnemyDead(self._mapId) then
			return
		end
	elseif self._mapMo.passType == NuoDiKaEnum.MapPassType.UnlockItem and NuoDiKaMapModel.instance:isSpEventUnlock(self._mapId) then
		return
	end

	self:_endBlock()

	self._gameSuccess = false

	local data = {}

	data.isSuccess = false
	data.callback = self._onFailedTiped
	data.callbackObj = self

	NuoDiKaController.instance:enterGameResultView(data)
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(self.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "Fail",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - self._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = self._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = self._hp
	})
end

function NuoDiKaGameView:_onFailedTiped(tipType)
	if tipType == NuoDiKaEnum.ResultTipType.Restart then
		self:_onGameRestart()
	elseif tipType == NuoDiKaEnum.ResultTipType.Quit then
		self:closeThis()
	end
end

function NuoDiKaGameView:_onGameRestart()
	NuoDiKaMapModel.instance:resetMap(self._mapId)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.GameRestart)
	self:_resetData()
	self:_refreshUI()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function NuoDiKaGameView:_onMapReset()
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(self.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "Reset",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - self._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = self._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = self._hp
	})
	self:_resetData()
	self:_refreshUI()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function NuoDiKaGameView:_onAttackMainRole(hurtValue)
	self:_attackMainRole(hurtValue)
	self:_checkHaloEnemyEffect()
end

function NuoDiKaGameView:_attackMainRole(hurtValue)
	self._hp = self._hp - hurtValue

	if hurtValue > 0 then
		self._viewAnim:Play("damage", 0, 0)
	end

	if self._hp <= 0 then
		UIBlockMgr.instance:startBlock("gamefail")
		TaskDispatcher.runDelay(self._onGameFailed, self, 1.5)

		return
	end

	if self._gohurt.gameObject.activeSelf then
		local totalHurt = hurtValue - tonumber(self._txthurt.text)

		self._txthurt.text = "-" .. totalHurt
	else
		gohelper.setActive(self._gohurt.gameObject, true)

		self._txthurt.text = "-" .. hurtValue
	end

	UIBlockMgr.instance:startBlock("mainrolehurt")
	gohelper.setActive(self._gohurt, true)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_mainrole_hurt)
	self._headAnim:Play("hurt", 0, 0)
	TaskDispatcher.runDelay(self._mainRoleHurt, self, 1)
	self:_refreshUI()
end

function NuoDiKaGameView:_mainRoleHurt()
	UIBlockMgr.instance:endBlock("mainrolehurt")
	gohelper.setActive(self._gohurt, false)
end

function NuoDiKaGameView:_onItemUseSkill(nodeMo, fromNodeMo)
	local eventCo = fromNodeMo:getEvent()

	if not eventCo then
		return
	end

	local skillId = NuoDiKaConfig.instance:getItemCo(eventCo.eventParam).skillID

	self._eventId = eventCo.eventId

	self:_startSkill(skillId, nodeMo, fromNodeMo)
	self:_refreshUI()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function NuoDiKaGameView:_startSkill(skillId, targetNodeMo, fromNodeMo)
	local skillCo = NuoDiKaConfig.instance:getSkillCo(skillId)

	if tonumber(skillCo.trigger) == NuoDiKaEnum.TriggerTimingType.Interact then
		if skillCo.effect == NuoDiKaEnum.SkillType.RestoreLife then
			self:_restoreLife(skillCo, targetNodeMo, fromNodeMo)
		elseif skillCo.effect == NuoDiKaEnum.SkillType.AttackSelected then
			self:_attackSelectedEnemy(skillCo, targetNodeMo, fromNodeMo)
		elseif skillCo.effect == NuoDiKaEnum.SkillType.AttackRandom then
			self:_attackRandomEnemy(skillCo, targetNodeMo, fromNodeMo)
		elseif skillCo.effect == NuoDiKaEnum.SkillType.AttackAll then
			self:_attackAllEnemy(skillCo, targetNodeMo, fromNodeMo)
		elseif skillCo.effect == NuoDiKaEnum.SkillType.WarnEnemyNodes then
			self:_warnEnemyNodes(skillCo, targetNodeMo, fromNodeMo)
		end
	end
end

function NuoDiKaGameView:_restoreLife(skillCo, targetNodeMo, fromNodeMo)
	self._hp = self._hp + tonumber(skillCo.param)

	gohelper.setActive(self._gohealeff, true)
	gohelper.setActive(self._goheal, true)

	self._txtheal.text = "+" .. skillCo.param

	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_mainrole_recover)
	UIBlockMgr.instance:startBlock("mainroleheal")
	TaskDispatcher.runDelay(self._showHealFinished, self, 1)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ClearNodeItem, fromNodeMo)
end

function NuoDiKaGameView:_showHealFinished()
	UIBlockMgr.instance:endBlock("mainroleheal")
	gohelper.setActive(self._gohealeff, false)
	gohelper.setActive(self._goheal, false)
end

function NuoDiKaGameView:_attackSelectedEnemy(skillCo, targetNodeMo, fromNodeMo)
	if not targetNodeMo:isNodeHasEnemy() then
		return
	end

	local enemyId = targetNodeMo:getEvent().eventParam

	if enemyId and enemyId > 0 then
		self:_attackEnemy(targetNodeMo, tonumber(skillCo.param))
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ClearNodeItem, fromNodeMo)
end

function NuoDiKaGameView:_attackRandomEnemy(skillCo, targetNodeMo, fromNodeMo)
	local params = string.splitToNumber(skillCo.param, "#")

	self._randomAttackParams = params
	self._randomTargetNodeMo = targetNodeMo
	self._randomFromNodeMo = fromNodeMo
	self._repeatCount = 0

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ClearNodeItem, self._randomFromNodeMo)

	self._randomBeforeNodeMos = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if not self._randomBeforeNodeMos or #self._randomBeforeNodeMos < 1 then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("randomAttack")

	self._randomAttackDelayTimes = 1.2 * params[2]

	self:_attackOnceEnemy()
	TaskDispatcher.runRepeat(self._attackOnceEnemy, self, 1.2, params[2] - 1)
end

function NuoDiKaGameView:_attackOnceEnemy()
	self._repeatCount = self._repeatCount + 1

	local allNodes = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if #allNodes < 1 then
		if #self._randomBeforeNodeMos > 0 then
			self:_produceNewItem()
		end

		UIBlockMgr.instance:endBlock("randomAttack")
		TaskDispatcher.cancelTask(self._attackOnceEnemy, self)

		return
	end

	local nodeMo = allNodes[math.random(1, #allNodes)]
	local randomDelayTime = self._randomAttackDelayTimes - 1.2 * (self._repeatCount - 1)

	self:_attackEnemy(nodeMo, self._randomAttackParams[1], false, randomDelayTime)

	if self._repeatCount == self._randomAttackParams[2] then
		UIBlockMgr.instance:endBlock("randomAttack")
		TaskDispatcher.cancelTask(self._attackOnceEnemy, self)
		self:_checkProduceNewItem()
	end
end

function NuoDiKaGameView:_checkProduceNewItem()
	local afterNodeMos = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	for _, bNodeMo in pairs(self._randomBeforeNodeMos) do
		local exist = false

		for _, aNodeMo in pairs(afterNodeMos) do
			if aNodeMo.id == bNodeMo.id then
				exist = true
			end
		end

		if not exist then
			self:_produceNewItem()

			break
		end
	end
end

function NuoDiKaGameView:_produceNewItem()
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unlock_unit)
	self._randomTargetNodeMo:setNodeEvent(self._eventId)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function NuoDiKaGameView:_attackAllEnemy(skillCo, targetNodeMo, fromNodeMo)
	local beforeNodeMos = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if #beforeNodeMos < 1 then
		return
	end

	local scales = string.splitToNumber(skillCo.scale, "#")
	local rangeType = scales[1]

	if rangeType == NuoDiKaEnum.TriggerRangeType.TargetNode then
		self:_attackEnemy(targetNodeMo, tonumber(skillCo.param))
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.RhombusLength then
		if not scales[2] then
			local scale = 0

			for _, curNodeMo in pairs(beforeNodeMos) do
				if scale >= math.abs(targetNodeMo.y - curNodeMo.y) + math.abs(targetNodeMo.x - curNodeMo.x) then
					self:_attackEnemy(targetNodeMo, tonumber(skillCo.param))
				end
			end
		end
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.SquareLength then
		if not scales[2] then
			local scale = 0

			for _, curNodeMo in pairs(beforeNodeMos) do
				if scale >= math.abs(targetNodeMo.y - curNodeMo.y) or scale >= math.abs(targetNodeMo.x - curNodeMo.x) then
					self:_attackEnemy(targetNodeMo, tonumber(skillCo.param))
				end
			end
		end
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.All then
		for _, nodeMo in pairs(beforeNodeMos) do
			self:_attackEnemy(nodeMo, tonumber(skillCo.param))
		end
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ClearNodeItem, fromNodeMo)

	local afterNodeMos = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if #beforeNodeMos ~= #afterNodeMos then
		return
	end

	local allEmptyNodeMos = NuoDiKaMapModel.instance:getAllEmptyNodes()

	if #allEmptyNodeMos > 0 then
		allEmptyNodeMos[math.random(1, #allEmptyNodeMos)]:setNodeEvent(self._eventId)
	end
end

function NuoDiKaGameView:_attackEnemy(nodeMo, hurtCount, ignoreReplace, randomAttackDelayTime)
	local allEnemyNodes = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if not ignoreReplace then
		for _, enemyNodeMo in pairs(allEnemyNodes) do
			local enemyCo = NuoDiKaConfig.instance:getEnemyCo(enemyNodeMo:getEvent().eventParam)
			local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)

			if skillCo.effect == NuoDiKaEnum.SkillType.ReplaceHurt then
				NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.AttackEnemy, enemyNodeMo, hurtCount, true)
				self:_checkHaloEnemyEffect()

				return
			end
		end
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.AttackEnemy, nodeMo, hurtCount, true)
	self:_checkHaloEnemyEffect()

	local afterNodeMos = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if #allEnemyNodes ~= #afterNodeMos then
		for _, bNodeMo in pairs(allEnemyNodes) do
			local exist = false

			for _, aNodeMo in pairs(afterNodeMos) do
				if aNodeMo.id == bNodeMo.id then
					exist = true
				end
			end

			if not exist then
				self:_onEnemyDead(bNodeMo, randomAttackDelayTime)

				local enemyId = bNodeMo:getInitEvent().eventParam
				local enemyCo = NuoDiKaConfig.instance:getEnemyCo(enemyId)
				local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)

				if skillCo.effect == NuoDiKaEnum.SkillType.Halo and self._gainHaloAtks[bNodeMo.id] then
					self._gainHaloAtks[bNodeMo.id]:reduceAtk(enemyCo.atk)
				end
			end
		end
	end
end

function NuoDiKaGameView:_checkHaloEnemyEffect()
	local allEnemyNodes = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()
	local maxHpEnemyNode = NuoDiKaMapModel.instance:getMaxHpNode()

	if maxHpEnemyNode then
		for _, enemyNodeMo in pairs(allEnemyNodes) do
			if maxHpEnemyNode.id ~= enemyNodeMo.id then
				local enemyCo = NuoDiKaConfig.instance:getEnemyCo(enemyNodeMo:getEvent().eventParam)
				local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)

				if skillCo.effect == NuoDiKaEnum.SkillType.Halo then
					local hasGain = false

					if self._gainHaloAtks[enemyNodeMo.id] then
						if self._gainHaloAtks[enemyNodeMo.id].id == maxHpEnemyNode.id then
							hasGain = true
						else
							self._gainHaloAtks[enemyNodeMo.id]:reduceAtk(enemyNodeMo.atk)
						end
					end

					if not hasGain then
						maxHpEnemyNode:gainAtk(enemyNodeMo.atk)

						self._gainHaloAtks[enemyNodeMo.id] = maxHpEnemyNode
					end
				end
			end
		end
	end
end

function NuoDiKaGameView:_onMapInteract()
	self._interactTimes = self._interactTimes + 1

	local allEnemyNodes = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	self:_checkHaloEnemyEffect()

	for _, enemyNodeMo in pairs(allEnemyNodes) do
		enemyNodeMo:reduceInteract(1)

		local enemyCo = NuoDiKaConfig.instance:getEnemyCo(enemyNodeMo:getEvent().eventParam)
		local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)
		local triggers = string.splitToNumber(skillCo.trigger, "#")

		if triggers[1] == NuoDiKaEnum.TriggerTimingType.InteractTimes and enemyNodeMo.interactTimes % triggers[2] == 0 then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ShowInteractAttackWarn, enemyNodeMo)
			self:_attackMainRole(enemyNodeMo.atk)
		end
	end
end

function NuoDiKaGameView:_onEnemyDead(deadNodeMo, randomAttackDelayTime)
	if not deadNodeMo:getInitEvent() then
		return
	end

	local enemyId = deadNodeMo:getInitEvent().eventParam
	local enemyCo = NuoDiKaConfig.instance:getEnemyCo(enemyId)

	if not enemyCo then
		return
	end

	if enemyCo.eventID and enemyCo.eventID > 0 then
		self:_showItemGameSuccess(deadNodeMo)

		return
	end

	local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)

	if skillCo.effect == NuoDiKaEnum.SkillType.UnlockAllNodes then
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.UnlockAllNodesEnemyDead, deadNodeMo.id)
		self:_unlockNodes(skillCo, deadNodeMo, randomAttackDelayTime)
	end
end

function NuoDiKaGameView:_showItemGameSuccess(nodeMo)
	if self._itemSuccessShowed then
		return
	end

	self._itemSuccessShowed = true

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.UnlockSuccessItem, nodeMo.id)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("successItemUnlock")
	TaskDispatcher.runDelay(self._showSuccessItemFinished, self, 2)
	TaskDispatcher.runDelay(self._playFallAudio, self, 0.67)
end

function NuoDiKaGameView:_playFallAudio()
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_item_fall_game_pass)
end

function NuoDiKaGameView:_showSuccessItemFinished()
	UIBlockMgr.instance:endBlock("successItemUnlock")
	self:_onGameSuccess()
end

function NuoDiKaGameView:_unlockNodes(skillCo, targetNodeMo, randomAttackDelayTime)
	local allNodes = NuoDiKaMapModel.instance:getMapNodes()
	local scales = string.splitToNumber(skillCo.scale, "#")
	local rangeType = scales[1]
	local unlockNodeList = {}

	if rangeType == NuoDiKaEnum.TriggerRangeType.RhombusLength then
		if not scales[2] then
			local scale = 0

			for _, nodeMo in pairs(allNodes) do
				if not nodeMo:isNodeUnlock() and scale >= math.abs(targetNodeMo.y - nodeMo.y) + math.abs(targetNodeMo.x - nodeMo.x) then
					table.insert(unlockNodeList, nodeMo)
				end
			end
		end
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.SquareLength then
		if not scales[2] then
			local scale = 0

			for _, nodeMo in pairs(allNodes) do
				if not nodeMo:isNodeUnlock() and scale >= math.abs(targetNodeMo.y - nodeMo.y) and scale >= math.abs(targetNodeMo.x - nodeMo.x) then
					table.insert(unlockNodeList, nodeMo)
				end
			end
		end
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.All then
		for _, nodeMo in pairs(allNodes) do
			if not nodeMo:isNodeUnlock() then
				table.insert(unlockNodeList, nodeMo)
			end
		end
	end

	self:_setNodesUnlock(unlockNodeList, randomAttackDelayTime)
	self:_checkHaloEnemyEffect()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function NuoDiKaGameView:_setNodesUnlock(nodeList, randomAttackDelayTime)
	if #nodeList < 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unlock_around_node)
	table.sort(nodeList, function(a, b)
		return a.id < b.id
	end)

	self._unlockNodeList = nodeList

	local hasItemDetailShow = false

	for _, nodeMo in ipairs(self._unlockNodeList) do
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnUnlockGuideNode, tostring(nodeMo.id))
		nodeMo:setNodeUnlock(true)

		local eventCo = nodeMo:getEvent()
		local hasEnemy = eventCo and nodeMo:isNodeHasEnemy()

		if hasEnemy then
			hasItemDetailShow = true
		end

		local hasItem = eventCo and nodeMo:isNodeHasItem()

		if hasItem then
			hasItemDetailShow = true
		end
	end

	randomAttackDelayTime = randomAttackDelayTime or 0

	local status = NuoDiKaModel.instance:getEpisodeStatus(self.viewParam.episodeId)

	if not hasItemDetailShow or status ~= NuoDiKaEnum.EpisodeStatus.MapGame then
		self:_onWaitUnlockShowDetail()
	else
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("waitUnlockDetailShow")
		TaskDispatcher.runDelay(self._onWaitUnlockShowDetail, self, 1 + randomAttackDelayTime)
	end
end

function NuoDiKaGameView:_onWaitUnlockShowDetail()
	UIBlockMgr.instance:endBlock("waitUnlockDetailShow")

	for _, nodeMo in ipairs(self._unlockNodeList) do
		local eventCo = nodeMo:getEvent()
		local hasEnemy = eventCo and nodeMo:isNodeHasEnemy()

		if hasEnemy then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.CheckShowEnemyDetail, eventCo.eventParam)
		end

		local hasItem = eventCo and nodeMo:isNodeHasItem()

		if hasItem then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.CheckShowItemDetail, eventCo.eventParam)
		end
	end
end

function NuoDiKaGameView:_warnEnemyNodes(skillCo, targetNodeMo, fromNodeMo)
	local allNodes = NuoDiKaMapModel.instance:getMapNodes()
	local scales = string.splitToNumber(skillCo.scale, "#")
	local rangeType = scales[1]

	if rangeType == NuoDiKaEnum.TriggerRangeType.RhombusLength then
		if not scales[2] then
			local scale = 0

			for _, nodeMo in pairs(allNodes) do
				if scale >= math.abs(targetNodeMo.y - nodeMo.y) + math.abs(targetNodeMo.x - nodeMo.x) then
					NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.WarnEnemyNode, nodeMo)
				end
			end
		end
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.SquareLength then
		if not scales[2] then
			local scale = 0

			for _, nodeMo in pairs(allNodes) do
				if scale >= math.abs(targetNodeMo.y - nodeMo.y) and scale >= math.abs(targetNodeMo.x - nodeMo.x) then
					NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.WarnEnemyNode, nodeMo)
				end
			end
		end
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.All then
		for _, nodeMo in pairs(allNodes) do
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.WarnEnemyNode, nodeMo)
		end
	end

	fromNodeMo:clearEvent()
end

function NuoDiKaGameView:onOpen()
	self._actId = VersionActivity2_8Enum.ActivityId.NuoDiKa
	self._mapId = NuoDiKaConfig.instance:getEpisodeCo(self._actId, self.viewParam.episodeId).mapId
	self._mapMo = NuoDiKaMapModel.instance:getMap(self._mapId)

	local odds = NuoDiKaEnum.MapOffset.NoOdd

	if self._mapMo.rowCount % 2 == 1 then
		odds = self._mapMo.lineCount % 2 == 1 and NuoDiKaEnum.MapOffset.XYOdd or NuoDiKaEnum.MapOffset.XOdd
	elseif self._mapMo.lineCount % 2 == 1 then
		odds = NuoDiKaEnum.MapOffset.YOdd
	end

	transformhelper.setLocalPos(self._gomap.transform, odds[1], odds[2], 0)
	transformhelper.setLocalPos(self._gomaptop.transform, odds[1], odds[2], 0)

	self._txttarget.text = NuoDiKaConfig.instance:getConstCo(self._mapMo.taskValue).value2

	NuoDiKaMapModel.instance:setCurMapId(self._mapId)

	self._mainHeroCo = NuoDiKaMapModel.instance:getMapMainRole(self._mapId)

	self:_resetData()
	self:_initUI()
	self:_refreshUI()
end

function NuoDiKaGameView:_resetData()
	self._hp = self._mainHeroCo.hp
	self._atk = self._mainHeroCo.atk
	self._gainHaloAtks = {}
	self._buffItems = {}
	self._beginTime = os.time()
	self._interactTimes = 0

	self:_checkHaloEnemyEffect()
end

function NuoDiKaGameView:_initUI()
	gohelper.setActive(self._goHP, true)
	gohelper.setActive(self._goAttack, true)
	gohelper.setActive(self._goBuffList, false)
	gohelper.setActive(self._goTips, false)
	gohelper.setActive(self._gohurt, false)
	gohelper.setActive(self._goheal, false)

	local status = NuoDiKaModel.instance:getEpisodeStatus(self.viewParam.episodeId)

	gohelper.setActive(self._btnskip.gameObject, status ~= NuoDiKaEnum.EpisodeStatus.MapGame)
	self._simageBG:LoadImage(ResUrl.getNuoDiKaSingleBg(self._mapMo.mapBg))

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function NuoDiKaGameView:_refreshUI()
	self._txtHPNum.text = self._hp
	self._txtAttckNum.text = self._atk

	local mainRoleCo = NuoDiKaMapModel.instance:getMapMainRole(self._mapId)
	local buffCos = NuoDiKaMapModel.instance:getMainRoleBuffCos(mainRoleCo.enemyId, self._mapId)

	gohelper.setActive(self._goBuffList, #buffCos > 0)

	for _, buff in pairs(self._buffItems) do
		gohelper.setActive(buff.go, false)
	end

	for _, buff in ipairs(buffCos) do
		if self._buffItems[buff.id] then
			self._buffItems[buff.id] = {}
			self._buffItems[buff.id].go = gohelper.cloneInPlace(self._goBuffIcon)
			self._buffItems[buff.id].image = self._buffItems[buff.id]:GetComponent(typeof(UnityEngine.UI.Image))
		end

		gohelper.setActive(self._buffItems[buff.id].go, true)
	end

	gohelper.setActive(self._gotargeticon, true)
end

function NuoDiKaGameView:onClose()
	NuoDiKaMapModel.instance:resetMap(self._mapId)
end

function NuoDiKaGameView:_endBlock()
	UIBlockMgr.instance:endBlock("randomAttack")
	UIBlockMgr.instance:endBlock("successItemUnlock")
	UIBlockMgr.instance:endBlock("waitUnlockDetailShow")
	UIBlockMgr.instance:endBlock("mainroleheal")
	UIBlockMgr.instance:endBlock("mainrolehurt")
	UIBlockMgr.instance:endBlock("gamefail")
end

function NuoDiKaGameView:onDestroyView()
	TaskDispatcher.cancelTask(self._attackOnceEnemy, self)
	TaskDispatcher.cancelTask(self._onWaitUnlockShowDetail, self)
	TaskDispatcher.cancelTask(self._showSuccessItemFinished, self)
	TaskDispatcher.cancelTask(self._showHealFinished, self)
	TaskDispatcher.cancelTask(self._mainRoleHurt, self)
	self:_endBlock()
	self:_removeEvents()
end

return NuoDiKaGameView
