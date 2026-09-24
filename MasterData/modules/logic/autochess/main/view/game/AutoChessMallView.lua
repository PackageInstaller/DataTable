-- chunkname: @modules/logic/autochess/main/view/game/AutoChessMallView.lua

module("modules.logic.autochess.main.view.game.AutoChessMallView", package.seeall)

local AutoChessMallView = class("AutoChessMallView", BaseView)

function AutoChessMallView:onInitView()
	self._goViewSelf = gohelper.findChild(self.viewGO, "#go_ViewSelf")
	self._goFrame = gohelper.findChild(self.viewGO, "#go_ViewSelf/#go_Frame")
	self._goMallItem = gohelper.findChild(self.viewGO, "#go_ViewSelf/#go_MallItem")
	self._txtCoin = gohelper.findChildText(self.viewGO, "#go_ViewSelf/Coin/#txt_Coin")
	self._goRound = gohelper.findChild(self.viewGO, "#go_ViewSelf/#go_Round")
	self._txtRound = gohelper.findChildText(self.viewGO, "#go_ViewSelf/#go_Round/#txt_Round")
	self._btnStartFight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/#btn_StartFight")
	self._imageStartBg = gohelper.findChildImage(self.viewGO, "#go_ViewSelf/#btn_StartFight/#image_StartBg")
	self._imageStartIcon = gohelper.findChildImage(self.viewGO, "#go_ViewSelf/#btn_StartFight/#image_StartIcon")
	self._goStartLight = gohelper.findChild(self.viewGO, "#go_ViewSelf/#btn_StartFight/#go_StartLight")
	self._btnCheckEnemy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/#btn_CheckEnemy")
	self._goCheckCost = gohelper.findChild(self.viewGO, "#go_ViewSelf/#btn_CheckEnemy/#go_CheckCost")
	self._txtCheckCost = gohelper.findChildText(self.viewGO, "#go_ViewSelf/#btn_CheckEnemy/#go_CheckCost/#txt_CheckCost")
	self._btnLederSkill = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/#btn_LederSkill")
	self._simageSkill = gohelper.findChildSingleImage(self.viewGO, "#go_ViewSelf/#btn_LederSkill/#simage_Skill")
	self._txtSkillCost = gohelper.findChildText(self.viewGO, "#go_ViewSelf/#btn_LederSkill/#txt_SkillCost")
	self._imageSkillCost = gohelper.findChildImage(self.viewGO, "#go_ViewSelf/#btn_LederSkill/#txt_SkillCost/#image_SkillCost")
	self._goSkillLock = gohelper.findChild(self.viewGO, "#go_ViewSelf/#btn_LederSkill/#go_SkillLock")
	self._goSkillLight = gohelper.findChild(self.viewGO, "#go_ViewSelf/#btn_LederSkill/#go_SkillLight")
	self._btnCancelUse = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/#btn_CancelUse")
	self._btnPlayerBuff = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/#btn_PlayerBuff")
	self._txtEnergyP = gohelper.findChildText(self.viewGO, "#go_ViewSelf/#btn_PlayerBuff/#txt_EnergyP")
	self._txtFireP = gohelper.findChildText(self.viewGO, "#go_ViewSelf/#btn_PlayerBuff/#txt_FireP")
	self._txtDebrisP = gohelper.findChildText(self.viewGO, "#go_ViewSelf/#btn_PlayerBuff/#txt_DebrisP")
	self._goChargeRoot = gohelper.findChild(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot")
	self._imageLevel = gohelper.findChildImage(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#image_Level")
	self._txtMallLvl = gohelper.findChildText(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#image_Level/#txt_MallLvl")
	self._goChargeFrame = gohelper.findChild(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeFrame")
	self._goFreeFrame = gohelper.findChild(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeFrame/#go_FreeFrame")
	self._goShopBtns = gohelper.findChild(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ShopBtns")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ShopBtns/#btn_Lock")
	self._btnUnlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ShopBtns/#btn_Unlock")
	self._btnFresh = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ShopBtns/#btn_Fresh")
	self._txtFreshCost = gohelper.findChildText(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ShopBtns/#btn_Fresh/#txt_FreshCost")
	self._goChargeContent = gohelper.findChild(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeContent")
	self._goSelectChessTip = gohelper.findChild(self.viewGO, "#go_ViewSelf/#go_SelectChessTip")
	self._goCheckSell = gohelper.findChild(self.viewGO, "#go_ViewSelf/#go_CheckSell")
	self._txtSellPrice = gohelper.findChildText(self.viewGO, "#go_ViewSelf/#go_CheckSell/cost/#txt_SellPrice")
	self._goChessAvatar = gohelper.findChild(self.viewGO, "#go_ViewSelf/#go_ChessAvatar")
	self._btnMutationP = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/TopRight/#btn_MutationP")
	self._simageMutationP = gohelper.findChildSingleImage(self.viewGO, "#go_ViewSelf/TopRight/#btn_MutationP/#simage_MutationP")
	self._btnLoseStreakP = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/TopRight/#btn_LoseStreakP")
	self._goViewEnemy = gohelper.findChild(self.viewGO, "#go_ViewEnemy")
	self._btnBack = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewEnemy/#btn_Back")
	self._goEnemyBuff = gohelper.findChild(self.viewGO, "#go_ViewEnemy/#go_EnemyBuff")
	self._txtEnergyE = gohelper.findChildText(self.viewGO, "#go_ViewEnemy/#go_EnemyBuff/#txt_EnergyE")
	self._txtFireE = gohelper.findChildText(self.viewGO, "#go_ViewEnemy/#go_EnemyBuff/#txt_FireE")
	self._txtDebrisE = gohelper.findChildText(self.viewGO, "#go_ViewEnemy/#go_EnemyBuff/#txt_DebrisE")
	self._btnMutationE = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewEnemy/#btn_MutationE")
	self._simageMutationE = gohelper.findChildSingleImage(self.viewGO, "#go_ViewEnemy/#btn_MutationE/#simage_MutationE")
	self._goCollection = gohelper.findChild(self.viewGO, "#go_Collection")
	self._btnCollection = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Collection/Viewport/#btn_Collection")
	self._goCollectionItem = gohelper.findChild(self.viewGO, "#go_Collection/Viewport/#btn_Collection/#go_CollectionItem")
	self._goPickView = gohelper.findChild(self.viewGO, "#go_PickView")
	self._btnBackPick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_PickView/#btn_BackPick")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessMallView:addEvents()
	self._btnStartFight:AddClickListener(self._btnStartFightOnClick, self)
	self._btnCheckEnemy:AddClickListener(self._btnCheckEnemyOnClick, self)
	self._btnLederSkill:AddClickListener(self._btnLederSkillOnClick, self)
	self._btnCancelUse:AddClickListener(self._btnCancelUseOnClick, self)
	self._btnPlayerBuff:AddClickListener(self._btnPlayerBuffOnClick, self)
	self._btnLock:AddClickListener(self._btnLockOnClick, self)
	self._btnUnlock:AddClickListener(self._btnUnlockOnClick, self)
	self._btnFresh:AddClickListener(self._btnFreshOnClick, self)
	self._btnMutationP:AddClickListener(self._btnMutationPOnClick, self)
	self._btnLoseStreakP:AddClickListener(self._btnLoseStreakPOnClick, self)
	self._btnBack:AddClickListener(self._btnBackOnClick, self)
	self._btnMutationE:AddClickListener(self._btnMutationEOnClick, self)
	self._btnCollection:AddClickListener(self._btnCollectionOnClick, self)
	self._btnBackPick:AddClickListener(self._btnBackPickOnClick, self)
end

function AutoChessMallView:removeEvents()
	self._btnStartFight:RemoveClickListener()
	self._btnCheckEnemy:RemoveClickListener()
	self._btnLederSkill:RemoveClickListener()
	self._btnCancelUse:RemoveClickListener()
	self._btnPlayerBuff:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	self._btnUnlock:RemoveClickListener()
	self._btnFresh:RemoveClickListener()
	self._btnMutationP:RemoveClickListener()
	self._btnLoseStreakP:RemoveClickListener()
	self._btnBack:RemoveClickListener()
	self._btnMutationE:RemoveClickListener()
	self._btnCollection:RemoveClickListener()
	self._btnBackPick:RemoveClickListener()
end

function AutoChessMallView:_btnMutationPOnClick()
	AutoChessController.instance:openAdventureView()
end

function AutoChessMallView:_btnLoseStreakPOnClick()
	AutoChessController.instance:openAdventureView(false, true)
end

function AutoChessMallView:_btnMutationEOnClick()
	AutoChessController.instance:openAdventureView(true)
end

function AutoChessMallView:_btnCollectionOnClick()
	local collectionIds

	ViewMgr.instance:openView(ViewName.AutoChessCollectionView, self.checkingEnemy and self.sceneMo.fight.enemyMaster.collectionIds or self.sceneMo.fight.mySideMaster.collectionIds)
end

function AutoChessMallView:_btnPlayerBuffOnClick()
	local usingLeaderSkill = AutoChessGameModel.instance.usingLeaderSkill

	if usingLeaderSkill then
		AutoChessGameModel.instance:setUsingLeaderSkill(false)

		return
	end

	local fight = self.sceneMo.fight
	local buffs = fight.mySideMaster.buffContainer.buffs
	local energy = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.EnergyBuffIds)
	local fire = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.FireBuffIds)
	local debris = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.DebrisIds)

	if energy ~= 0 or fire ~= 0 or debris ~= 0 then
		local uiRoot = ViewMgr.instance:getUIRoot()
		local position = self._btnPlayerBuff.gameObject.transform.position
		local targetPos = recthelper.rectToRelativeAnchorPos(position, uiRoot.transform)

		ViewMgr.instance:openView(ViewName.AutoChessLeaderBuffView, {
			position = targetPos
		})
	end
end

function AutoChessMallView:_btnCancelUseOnClick()
	AutoChessGameModel.instance:setUsingLeaderSkill(false)
end

function AutoChessMallView:_btnBackPickOnClick()
	gohelper.setActive(self._btnLederSkill, true)
	gohelper.setActive(self._btnPlayerBuff, true)
	gohelper.setActive(self._btnCheckEnemy, true)
	gohelper.setActive(self._btnStartFight, true)
	gohelper.setActive(self._goRound, not self.bossRound)
	gohelper.setActive(self._goShopBtns, true)
	gohelper.setActive(self._goPickView, false)
	gohelper.setActive(self._goCollection, self.collectionCnt ~= 0)
	ViewMgr.instance:openView(ViewName.AutoChessForcePickView, self.freeMall)
end

function AutoChessMallView:_btnCheckEnemyOnClick()
	if self.sceneMo.baseInfo.preview then
		self:previewCallback(0, 0)
	elseif self.previewCostEnough then
		AutoChessRpc.instance:sendAutoChessPreviewFightRequest(self.moduleId, self.previewCallback, self)
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function AutoChessMallView:_btnLederSkillOnClick()
	local canUse, toastId = self:checkCanUseLeaderSkill()

	if canUse then
		if self.masterSkillCo.needTarget then
			if AutoChessGameModel.instance.usingLeaderSkill then
				self:_btnCancelUseOnClick()
			else
				local types = string.split(self.masterSkillCo.targetType, "#")

				AutoChessGameModel.instance:setUsingLeaderSkill(true, types)
			end

			return
		end

		self.animBtnSkill:Play("click", 0, 0)

		local master = self.sceneMo.fight.mySideMaster

		AutoChessRpc.instance:sendAutoChessUseMasterSkillRequest(self.moduleId, master.skill.id)
	else
		GameFacade.showToast(toastId)
	end
end

function AutoChessMallView:_btnBackOnClick()
	self.checkingEnemy = false

	self.animSwitch:Play("story", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
	TaskDispatcher.runDelay(self.delaySwitch, self, 0.35)
end

function AutoChessMallView:previewCallback(_, resultCode)
	if resultCode == 0 then
		self.checkingEnemy = true

		self.animSwitch:Play("hard", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
		TaskDispatcher.runDelay(self.delaySwitch, self, 0.35)
	end
end

function AutoChessMallView:delaySwitch()
	if self.checkingEnemy then
		gohelper.setActive(self._goCheckCost, false)
		gohelper.setActive(self._goViewSelf, false)
		gohelper.setActive(self._goViewEnemy, true)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.CheckEnemyTeam, true)
	else
		gohelper.setActive(self._goViewSelf, true)
		gohelper.setActive(self._goViewEnemy, false)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.CheckEnemyTeam, false)
	end

	self:refreshCollection()
end

function AutoChessMallView:_btnFreshOnClick()
	if self.lockFreshMall then
		return
	end

	if tonumber(self.sceneMo.mall.coin) >= self.freshCost then
		AutoChessHelper.lockScreen("AutoChessMallViewFreshStore", true)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_mln_details_open)
		AutoChessRpc.instance:sendAutoChessRefreshMallRequest(self.moduleId, self._freshMallReply, self)
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function AutoChessMallView:_freshMallReply(_, resultCode)
	if resultCode ~= 0 then
		AutoChessHelper.lockScreen("AutoChessMallViewFreshStore", false)

		return
	end

	self.animBtnFresh:Play("click", 0, 0)
	gohelper.addChildPosStay(self._goChargeRoot, self.freeItem.go)

	local burnTime = 0

	if self.master:getMutationId() == AutoChessEnum.MutationId.Fire then
		for _, item in ipairs(self.chargeItemList) do
			local isLava, duration = item:checkLavaChess()

			if isLava and burnTime == 0 then
				burnTime = duration
			end
		end
	end

	if burnTime > 0 then
		TaskDispatcher.runDelay(self.delayRefreshStore, self, burnTime)
	else
		self:delayRefreshStore()
	end
end

function AutoChessMallView:delayRefreshStore()
	self.animBottom:Play("flushed", 0, 0)
	TaskDispatcher.runDelay(self.refreshUI, self, 0.16)
	TaskDispatcher.runDelay(self.delaySetFreeItem, self, 0.4)
end

function AutoChessMallView:delaySetFreeItem()
	gohelper.addChildPosStay(self._goChargeContent, self.freeItem.go)
	AutoChessHelper.lockScreen("AutoChessMallViewFreshStore", false)
end

function AutoChessMallView:_btnLockOnClick()
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_lock)
	AutoChessRpc.instance:sendAutoChessFreezeItemRequest(self.moduleId, self.chargeMall.mallId, 0, AutoChessEnum.FreeZeType.Freeze, self.freezeReply, self)
end

function AutoChessMallView:_btnUnlockOnClick()
	AutoChessRpc.instance:sendAutoChessFreezeItemRequest(self.moduleId, self.chargeMall.mallId, 0, AutoChessEnum.FreeZeType.UnFreeze, self.freezeReply, self)
end

function AutoChessMallView:_btnStartFightOnClick()
	local freeMallRegion = self.sceneMo.mall:getFreeRegion()

	if #freeMallRegion.items ~= 0 then
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessFreeChessClean, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self._fightYesCallback, nil, nil, self)
	else
		self:_fightYesCallback()
	end
end

function AutoChessMallView:_fightYesCallback()
	AutoChessRpc.instance:sendAutoChessEnterFightRequest(self.moduleId)
end

function AutoChessMallView:_overrideClose()
	if self._btnBack.gameObject.activeInHierarchy then
		self:_btnBackOnClick()

		return
	end

	AutoChessController.instance:exitGame()
end

function AutoChessMallView:_editableInitView()
	local goFreeFrame = gohelper.findChild(self.viewGO, "#go_ViewSelf/Bottom/Left/FreeFrame")

	self.animFreeFrame = goFreeFrame:GetComponent(gohelper.Type_Animator)
	self.goBottom = gohelper.findChild(self.viewGO, "#go_ViewSelf/Bottom")
	self.animBottom = self.goBottom:GetComponent(gohelper.Type_Animator)
	self.animBtnFresh = self._btnFresh.gameObject:GetComponent(gohelper.Type_Animator)
	self.animSwitch = self._goexcessive:GetComponent(gohelper.Type_Animator)
	self.animCoin = self._txtCoin.gameObject:GetComponent(gohelper.Type_Animator)
	self.animBtnSkill = self._btnLederSkill.gameObject:GetComponent(gohelper.Type_Animator)

	self:initMallItemList()

	self.actMo = Activity182Model.instance:getActMo()
	self.actId = AutoChessModel.instance.actId
	self.moduleId = AutoChessModel.instance.moduleId
	self.sceneMo = AutoChessModel.instance:getSceneMo()
	self.roundType = self.sceneMo.fight.roundType

	if self.roundType == AutoChessEnum.RoundType.BOSS then
		self.bossRound = true

		gohelper.setActive(self._goRound, false)
		gohelper.setActive(self._goEnemyBuff, false)
	end

	self.collectionTbl = {}
	self.animLoseStreak = gohelper.findComponentAnim(self._btnLoseStreakP.gameObject)
	self.animLoseStreak.keepAnimatorStateOnDisable = true

	local invalidlvl = AutoChessConfig.instance:getLoseStreakInvalidLvl()

	if invalidlvl > self.actMo.rank then
		self.showLoseStreak = true
	end

	gohelper.setActive(self._btnLoseStreakP, self.showLoseStreak)

	self.lockFreshMall = self.sceneMo.fight.mySideMaster:isLockFreshMall()

	gohelper.setActive(self._btnFresh, not self.lockFreshMall)
end

function AutoChessMallView:onOpen()
	AutoChessGameModel.instance:setChessAvatar(self._goChessAvatar)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_shopping_enter)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragChessEntity, self.onDragChess, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragChessEntityEnd, self.onDragChessEnd, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.MallCoinChange, self.onCoinChange, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.ForcePickViewBoard, self.onViewBoard, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.ForcePickReply, self.onForcePickReply, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UpdateMallRegion, self.onMallRegionChange, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UpdateMasterSkill, self.refreshLeaderSkillRelative, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UpdateLeaderBuff, self.refreshLeaderBuff, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragMallItem, self.onDragMallItem, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragMallItemEnd, self.onDragMallItemEnd, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.BuyChessReply, self.onBuyReply, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.BuildReply, self.onBuildReply, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UsingLeaderSkill, self.onUsingLeaderSkill, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.FinishStepList, self.onStepListFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)

	local bossId = self.actMo:getGameMo(self.actId, self.moduleId).bossId
	local icon, bg = AutoChessHelper.getFightBtnIcon(self.roundType, bossId)

	UISpriteSetMgr.instance:setAutoChessSprite(self._imageStartIcon, icon)
	UISpriteSetMgr.instance:setAutoChessSprite(self._imageStartBg, bg)
	self:refreshUI()
	self:checkPopUp()
	self:refreshCollection()
	self:refreshLeaderMutation()
end

function AutoChessMallView:onClose()
	AutoChessGameModel.instance.avatar = nil
end

function AutoChessMallView:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self.delaySetFreeItem, self)
	TaskDispatcher.cancelTask(self.checkForcePick, self)
	TaskDispatcher.cancelTask(self.recordItemPos, self)
	TaskDispatcher.cancelTask(self.delaySwitch, self)
	TaskDispatcher.cancelTask(self.delayRefreshStore, self)
	TaskDispatcher.cancelTask(self.refreshUI, self)
end

function AutoChessMallView:initMallItemList()
	self.chargeFrameList = self:getUserDataTb_()
	self.chargeItemList = {}

	for i = 1, 7 do
		if i == 1 then
			local go = gohelper.clone(self._goMallItem, self._goChargeContent, "freeItem" .. i)

			self.freeItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessMallItem, self)
		end

		local frame = gohelper.clone(self._goFrame, self._goChargeFrame, "chargeFrame" .. i)

		self.chargeFrameList[i] = frame.transform

		local go = gohelper.clone(self._goMallItem, self._goChargeContent, "chargeItem" .. i)

		self.chargeItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessMallItem, self)
	end

	gohelper.setActive(self._goFrame, false)
	gohelper.setActive(self._goMallItem, false)
	TaskDispatcher.runDelay(self.recordItemPos, self, 0.01)
end

function AutoChessMallView:recordItemPos()
	for i = 1, 7 do
		if i == 1 then
			local x, y = recthelper.getAnchor(self._goFreeFrame.transform)

			self.freeItem:setPos(x, y)
		end

		local x, y = recthelper.getAnchor(self.chargeFrameList[i])

		self.chargeItemList[i]:setPos(x, y)
	end
end

function AutoChessMallView:refreshUI()
	self:refreshMall()
	self:refreshLeaderSkillRelative()
	self:refreshLeaderBuff()
	self:refreshCoinRelative()
	self:refreshRoundRelative()
	self:refreshMallLock()
end

function AutoChessMallView:refreshMall()
	local mallMo = self.sceneMo.mall

	self:refreshMallItem(mallMo)

	local regionMo = mallMo:getNormalRegion()

	if regionMo then
		if not regionMo.config.showLevel then
			local mallLvl = 1

			UISpriteSetMgr.instance:setAutoChessSprite(self._imageLevel, "v2a5_autochess_quality3_" .. mallLvl)

			self._txtMallLvl.text = "Lv." .. mallLvl

			gohelper.setActive(self._goCheckCost, not self.sceneMo.baseInfo.preview)
		end
	end
end

function AutoChessMallView:refreshRoundRelative()
	local curRound = self.sceneMo.baseInfo.sceneRound

	self.freshCost = self.sceneMo.mall.refreshCost
	self._txtFreshCost.text = self.freshCost

	if not self.bossRound then
		local episodeId = AutoChessModel.instance.episodeId
		local maxRound = self.actMo:getMaxRound(episodeId)

		self._txtRound.text = string.format("%d/%d", curRound, maxRound)
	end
end

function AutoChessMallView:refreshMallLock()
	local isLock = not not (self.chargeMall.items[1] and self.chargeMall.items[1].freeze)

	gohelper.setActive(self._btnLock, not isLock)
	gohelper.setActive(self._btnUnlock, isLock)
end

function AutoChessMallView:refreshLeaderSkillRelative()
	self.master = self.sceneMo.fight.mySideMaster
	self.masterSkillCo = self.master.skill.config

	self._simageSkill:LoadImage(ResUrl.getAutoChessIcon(self.master.config.skillIcon, "skillicon"))

	if not string.nilorempty(self.masterSkillCo.cost) then
		local costParams = string.split(self.masterSkillCo.cost, "#")
		local name = "v2a5_autochess_cost" .. costParams[1]

		UISpriteSetMgr.instance:setAutoChessSprite(self._imageSkillCost, name)

		if tonumber(costParams[2]) ~= 0 then
			self._txtSkillCost.text = costParams[2] or luaLang("autochess_mallview_nocost")
		end
	else
		self._txtSkillCost.text = luaLang("autochess_mallview_nocost")
	end

	gohelper.setActive(self._goSkillLock, not self.sceneMo.fight.mySideMaster.skill.unlock)
	self:refreshLeaderSkillStatus()
end

function AutoChessMallView:refreshLeaderSkillStatus()
	local canUse, toastId = self:checkCanUseLeaderSkill()

	gohelper.setActive(self._goSkillLight, canUse)
	ZProj.UGUIHelper.SetGrayscale(self._simageSkill.gameObject, toastId == ToastEnum.AutoChessMasterSkill2)
end

function AutoChessMallView:refreshLeaderBuff()
	local fight = self.sceneMo.fight
	local buffs = fight.mySideMaster.buffContainer.buffs
	local energy = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.EnergyBuffIds)

	self._txtEnergyP.text = energy

	gohelper.setActive(self._txtEnergyP, energy ~= 0)

	local fire = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.FireBuffIds)

	self._txtFireP.text = fire

	gohelper.setActive(self._txtFireP, fire ~= 0)

	local debris = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.DebrisIds)

	self._txtDebrisP.text = debris

	gohelper.setActive(self._txtDebrisP, debris ~= 0)

	if not self.bossRound then
		buffs = fight.enemyMaster.buffContainer.buffs
		energy = AutoChessHelper.getBuffCnt(fight.enemyMaster.buffContainer.buffs, AutoChessEnum.EnergyBuffIds)
		self._txtEnergyE.text = energy

		gohelper.setActive(self._txtEnergyE, energy ~= 0)

		fire = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.FireBuffIds)
		self._txtFireE.text = fire

		gohelper.setActive(self._txtFireE, fire ~= 0)

		debris = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.DebrisIds)
		self._txtDebrisE.text = debris

		gohelper.setActive(self._txtDebrisE, debris ~= 0)
	end
end

function AutoChessMallView:refreshCoinRelative()
	local svrMallData = self.sceneMo.mall

	self._txtCoin.text = svrMallData.coin

	local cost = self.sceneMo.baseInfo.previewCoin

	self.previewCostEnough = self.sceneMo:checkCostEnough(AutoChessStrEnum.CostType.Coin, cost)
	self._txtCheckCost.text = self.previewCostEnough and cost or string.format("<color=#BD2C2C>%s</color>", cost)

	gohelper.setActive(self._goStartLight, svrMallData.coin == 0)
end

function AutoChessMallView:refreshMallItem(mallMo)
	for _, regionMo in ipairs(mallMo.regions) do
		if regionMo.config.type == AutoChessEnum.MallType.Normal then
			self.chargeMall = regionMo

			for i = 1, 7 do
				self.chargeItemList[i]:setData(regionMo.mallId, regionMo.items[i])
				gohelper.setActive(self.chargeFrameList[i].gameObject, i <= regionMo.config.capacity)
			end
		else
			self.freeMall = regionMo

			self.freeItem:setData(regionMo.mallId, regionMo.items[1], true)
		end
	end
end

function AutoChessMallView:onStartBuyFinish()
	return
end

function AutoChessMallView:onUsingLeaderSkill(using)
	local animName = using and "select" or "idle"

	self.animBtnSkill:Play(animName, 0, 0)
	gohelper.setActive(self._btnCancelUse, using)
	gohelper.setActive(self._goSelectChessTip, using)
	gohelper.setActive(self.goBottom, not using)
	gohelper.setActive(self._btnCheckEnemy, not using)
	gohelper.setActive(self._btnStartFight, not using)
	gohelper.setActive(self._goRound, not using and not self.bossRound)
	gohelper.setActive(self._goCollection, not using and self.collectionCnt ~= 0)
end

function AutoChessMallView:checkPopUp()
	if not self.startBuyFinish then
		return
	end

	if self.sceneMo.mallUpgrade then
		ViewMgr.instance:openView(ViewName.AutoChessMallLevelUpView)

		self.sceneMo.mallUpgrade = false
	else
		self:checkForcePick()
	end
end

function AutoChessMallView:checkForcePick()
	local itemIds = self.freeMall.selectItems

	if #itemIds > 0 then
		ViewMgr.instance:openView(ViewName.AutoChessForcePickView, self.freeMall)
	end
end

function AutoChessMallView:onDragChess(config)
	self._txtSellPrice.text = AutoChessHelper.getSellPrice(config.race)

	gohelper.setActive(self._goCheckSell, true)
	gohelper.setActive(self._goChargeRoot, false)
end

function AutoChessMallView:onDragChessEnd()
	gohelper.setActive(self._goCheckSell, false)
	gohelper.setActive(self._goChargeRoot, true)
end

function AutoChessMallView:onCloseView(viewName)
	if viewName == ViewName.AutoChessMallLevelUpView then
		self:checkForcePick()
	end
end

function AutoChessMallView:onCoinChange()
	self:refreshCoinRelative()
	self:refreshLeaderSkillStatus()
end

function AutoChessMallView:onViewBoard()
	gohelper.setActive(self._btnLederSkill, false)
	gohelper.setActive(self._btnPlayerBuff, false)
	gohelper.setActive(self._btnCheckEnemy, false)
	gohelper.setActive(self._btnStartFight, false)
	gohelper.setActive(self._goRound, false)
	gohelper.setActive(self._goShopBtns, false)
	gohelper.setActive(self._goPickView, true)
	gohelper.setActive(self._goCollection, false)
end

function AutoChessMallView:onForcePickReply(giveUp)
	if not giveUp then
		self.animFreeFrame:Play("open", 0, 0)
		self:refreshMallItem(self.sceneMo.mall)
		self:checkForcePick()
	end
end

function AutoChessMallView:onMallRegionChange()
	self:refreshUI()
	self:checkForcePick()
end

function AutoChessMallView:onDragMallItem(_, cost)
	if cost ~= 0 then
		self._txtCoin.text = string.format("%d(-%d)", self.sceneMo.mall.coin, cost)

		self.animCoin:Play("loop", 0, 0)
	end
end

function AutoChessMallView:onDragMallItemEnd()
	self._txtCoin.text = self.sceneMo.mall.coin

	self.animCoin:Play("idle", 0, 0)
end

function AutoChessMallView:onBuyReply()
	self:refreshUI()

	if #self.freeMall.selectItems > 0 then
		TaskDispatcher.runDelay(self.checkForcePick, self, 1.5)
	else
		self:checkForcePick()
	end
end

function AutoChessMallView:onBuildReply()
	self:refreshUI()

	if #self.freeMall.selectItems > 0 then
		TaskDispatcher.runDelay(self.checkForcePick, self, 1.5)
	else
		self:checkForcePick()
	end
end

function AutoChessMallView:freezeReply(_, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local isLock = msg.type == AutoChessEnum.FreeZeType.Freeze

	gohelper.setActive(self._btnLock, not isLock)
	gohelper.setActive(self._btnUnlock, isLock)

	for _, item in ipairs(self.chargeItemList) do
		item:setLock(isLock)
	end
end

function AutoChessMallView:checkCanUseLeaderSkill()
	if self.masterSkillCo.type == AutoChessStrEnum.SkillType.Passive then
		return false, ToastEnum.AutoChessMasterSkill1
	else
		if not self.master.skill.unlock then
			return false, ToastEnum.AutoChessMasterSkill4
		end

		if not self.master.skill.canUse then
			return false, ToastEnum.AutoChessMasterSkill2
		end

		local limitCnt = self.master.config.roundTriggerCountLimit

		if limitCnt ~= 0 then
			local useCnts = self.sceneMo.fight.mySideMaster.skill.roundUseCounts
			local roundUseCnt = 0

			for _, useCnt in ipairs(useCnts) do
				if useCnt.round == self.sceneMo.baseInfo.sceneRound then
					roundUseCnt = useCnt.count

					break
				end
			end

			if limitCnt <= roundUseCnt then
				return false, ToastEnum.AutoChessMasterSkill2
			end
		end

		limitCnt = self.master.config.totalTriggerCountLimit

		if self.master.config.totalTriggerCountLimit ~= 0 then
			local useCnts = self.sceneMo.fight.mySideMaster.skill.roundUseCounts
			local allUseCnt = 0

			for _, useCnt in ipairs(useCnts) do
				allUseCnt = allUseCnt + useCnt.count
			end

			if limitCnt <= allUseCnt then
				return false, ToastEnum.AutoChessMasterSkill3
			end
		end

		local costParams = string.split(self.masterSkillCo.cost, "#")

		return self.sceneMo:checkCostEnough(costParams[1], tonumber(costParams[2]))
	end

	return true
end

function AutoChessMallView:refreshCollection()
	self.collectionCnt = 0

	gohelper.setActive(self._goCollection, self.collectionCnt ~= 0)
end

function AutoChessMallView:onStepListFinish(type)
	if type == AutoChessEnum.ActionType.StartBuy then
		self.startBuyFinish = true

		self:checkPopUp()
	elseif type == AutoChessEnum.ActionType.EndBuy then
		self:closeThis()
	end
end

function AutoChessMallView:refreshLeaderMutation()
	local masterMo = self.sceneMo.fight.mySideMaster

	if self.showLoseStreak then
		local loseLvl = AutoChessConfig.instance:getLoseStreakLvl(masterMo.loseStreak)

		if loseLvl ~= 0 then
			AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_yingmen_adventure_activate)
		end

		local animName = loseLvl == 0 and "idle" or "take"

		self.animLoseStreak:Play(animName, 0, 0)
	end

	local mutationId = masterMo:getMutationId()

	if mutationId then
		local config = AutoChessConfig.instance:getMutationCfg(mutationId)

		self._simageMutationP:LoadImage(ResUrl.getAutoChessIcon(config.icon, "adventure"))
	end

	mutationId = self.sceneMo.fight.enemyMaster:getMutationId()

	if mutationId then
		local config = AutoChessConfig.instance:getMutationCfg(mutationId)

		self._simageMutationE:LoadImage(ResUrl.getAutoChessIcon(config.icon, "adventure"))
	end
end

return AutoChessMallView
