-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorGameView.lua

module("modules.logic.versionactivity3_3.igor.view.IgorGameView", package.seeall)

local IgorGameView = class("IgorGameView", BaseView)

function IgorGameView:onInitView()
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.cardArea = gohelper.findChild(self.viewGO, "root/info/cardArea")
	self.cardRoot = gohelper.findChild(self.viewGO, "root/info/cardList")
	self.goCardItem = gohelper.findChild(self.viewGO, "root/info/cardList/cardItem")

	gohelper.setActive(self.goCardItem, false)

	self.goCost = gohelper.findChild(self.viewGO, "root/info/cost")
	self.animCost = self.goCost:GetComponent(typeof(UnityEngine.Animator))
	self.txtCost = gohelper.findChildTextMesh(self.viewGO, "root/info/cost/txtcost")
	self.txtCostChange = gohelper.findChildTextMesh(self.viewGO, "root/info/cost/txt_change")
	self.skillRoot = gohelper.findChild(self.viewGO, "root/info/skill")
	self.btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "root/info/btnreset")
	self.goDestroy = gohelper.findChild(self.viewGO, "Destroy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function IgorGameView:addEvents()
	self.addEventCb(self, IgorController.instance, IgorEvent.OnGameInited, self.onGameInited, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnGameCostChange, self.onGameCostChange, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnEntityLevChange, self.onEntityLevChange, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnGuidePause, self.onGuidePause, self)
	self.addClickCb(self, self.btnReset, self.onClickReset, self)
end

function IgorGameView:removeEvents()
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnGameInited, self.onGameInited, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnGameCostChange, self.onGameCostChange, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnEntityLevChange, self.onEntityLevChange, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnGuidePause, self.onGuidePause, self)
	self:removeClickCb(self.btnReset)
end

function IgorGameView:onGuidePause(pause)
	if pause then
		IgorModel.instance:setPause(true)
	else
		IgorModel.instance:setPause(false)
	end
end

function IgorGameView:onGameInited()
	self:refreshCost()
	self:initCardList()
	self:initSkill()
end

function IgorGameView:onGameCostChange()
	self:refreshCost()
end

function IgorGameView:onEntityLevChange(mo)
	if mo.type == IgorEnum.SoldierType.Base and mo.campType == IgorEnum.CampType.Ourside then
		if self.skillComp1 then
			self.skillComp1:refreshTimes()
		end

		if self.skillComp2 then
			self.skillComp2:refreshTimes()
		end

		if self.cardItemList then
			for _, cardItem in ipairs(self.cardItemList) do
				cardItem:onGameLevChange()
			end
		end
	end
end

function IgorGameView:onClickReset()
	IgorModel.instance:setPause(true)
	GameFacade.showMessageBox(MessageBoxIdDefine.IgorGameResetConfirm, MsgBoxEnum.BoxType.Yes_No, self.resetGame, self.cancelResetGame, nil, self, self)
end

function IgorGameView:resetGame()
	IgorController.instance:statOperation(IgorEnum.StatOperationType.Reset)
	IgorController.instance:resetGame()
end

function IgorGameView:cancelResetGame()
	IgorModel.instance:setPause(false)
end

function IgorGameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_yuanzheng_igor_start)
	IgorController.instance:resetGame()
	IgorModel.instance:setPause(true)
	gohelper.setActive(self.goRoot, false)
	gohelper.setActive(self.goDestroy, true)
end

function IgorGameView:onOpenFinish()
	self.isOpenFinish = true

	gohelper.setActive(self.goRoot, true)
	IgorModel.instance:setPause(false)
	gohelper.setActive(self.goDestroy, false)
	self:playCardIn()

	self.noiseAudioPlayingId = AudioMgr.instance:trigger(AudioEnum3_3.bgm.play_ui_checkpoint_noise_wurenqu_common_loop)
end

function IgorGameView:initSkill()
	if not self.skillComp1 then
		local go = gohelper.findChild(self.skillRoot, "skill1")

		self.skillComp1 = MonoHelper.addNoUpdateLuaComOnceToGo(go, IgorSkillAttackItem)
	end

	self.skillComp1:updateParam(IgorEnum.SkillType.Attack)

	if not self.skillComp2 then
		local go = gohelper.findChild(self.skillRoot, "skill2")

		self.skillComp2 = MonoHelper.addNoUpdateLuaComOnceToGo(go, IgorSkillDefenseItem)
	end

	self.skillComp2:updateParam(IgorEnum.SkillType.Defense)

	if not self.skillComp3 then
		local go = gohelper.findChild(self.skillRoot, "skill3")

		self.skillComp3 = MonoHelper.addNoUpdateLuaComOnceToGo(go, IgorSkillTransferItem)
	end

	self.skillComp3:updateParam(IgorEnum.SkillType.Transfer)

	if not self.skillComp4 then
		local go = gohelper.findChild(self.skillRoot, "skill4")

		self.skillComp4 = MonoHelper.addNoUpdateLuaComOnceToGo(go, IgorSkillLevupItem)
	end

	self.skillComp4:updateParam(IgorEnum.SkillType.Levup)
end

function IgorGameView:initCardList()
	if self.cardItemList then
		for _, comp in ipairs(self.cardItemList) do
			comp:dispose()
		end
	end

	self.cardItemList = {}

	local gameMO = IgorModel.instance:getCurGameMo()
	local cardList = string.splitToNumber(gameMO.config.soldier, "#")

	for index, id in ipairs(cardList) do
		local comp = self.cardItemList[index]

		if not comp then
			comp = self:createCardItem(index)

			comp:setCardArea(self.cardArea.transform)

			self.cardItemList[index] = comp
		end

		local config = IgorConfig.instance:getSoldierConfig(id)

		comp:updateParam(config)
	end

	self:refreshCardListPos()
	self:playCardIn()
end

function IgorGameView:refreshCardListPos()
	local startPos = -2.5
	local space = 20
	local itemWidth = 165

	for index, comp in ipairs(self.cardItemList) do
		local posX = startPos + (index - 1) * (itemWidth + space)

		comp:setInitPos(-posX, 5)
	end
end

function IgorGameView:createCardItem(index)
	local go = gohelper.cloneInPlace(self.goCardItem, tostring(index))

	gohelper.setActive(go, true)

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, IgorCardItem)

	comp._index = index

	return comp
end

function IgorGameView:refreshCost()
	local gameMO = IgorModel.instance:getCurGameMo()
	local curCost = gameMO:getGameCost()
	local maxCost = gameMO:getGameCostMax()

	self.txtCost.text = string.format("<size=48><color=#39572B>%s</color></size>/%s", curCost, maxCost)

	if self.lastCost and self.lastCost ~= curCost then
		local offset = curCost - self.lastCost

		if offset > 0 then
			self.txtCostChange.text = string.format("<color=#39572B>+%s</color>", offset)

			self.animCost:Play("up", 0, 0)
		else
			self.txtCostChange.text = string.format("<color=#B24444>%s</color>", offset)

			self.animCost:Play("down", 0, 0)
		end
	end

	self.lastCost = curCost
end

function IgorGameView:playCardIn()
	if not self.isOpenFinish then
		return
	end

	local context = self:getUserDataTb_()

	context.cardItemList = self.cardItemList
	context.startIndex = 1
	context.endIndex = #self.cardItemList

	if not self._cardDistributeFlow then
		self._cardDistributeFlow = FlowParallel.New()

		self._cardDistributeFlow:addWork(IgorCardDistributeEffect.New())
	end

	self._cardDistributeFlow:registerDoneListener(self._onDistributeCards, self)
	self._cardDistributeFlow:start(context)
end

function IgorGameView:_onDistributeCards()
	for _, comp in ipairs(self.cardItemList) do
		gohelper.onceAddComponent(comp.go, gohelper.Type_CanvasGroup).alpha = 1

		gohelper.setActive(comp.go, true)
	end

	self._cardDistributeFlow:unregisterDoneListener(self._onDistributeCards, self)
end

function IgorGameView:onClose()
	if self._cardDistributeFlow then
		self._cardDistributeFlow:stop()
	end

	IgorController.instance:exitGame()

	if self.noiseAudioPlayingId then
		AudioMgr.instance:stopPlayingID(self.noiseAudioPlayingId)

		self.noiseAudioPlayingId = nil
	end
end

return IgorGameView
