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
	self._btnFresh = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#btn_Fresh")
	self._txtFreshCost = gohelper.findChildText(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#btn_Fresh/#txt_FreshCost")
	self._goLockBtns = gohelper.findChild(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_LockBtns")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_LockBtns/#btn_Lock")
	self._btnUnlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_LockBtns/#btn_Unlock")
	self._goChargeContent = gohelper.findChild(self.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeContent")
	self._goSelectChessTip = gohelper.findChild(self.viewGO, "#go_ViewSelf/#go_SelectChessTip")
	self._goCheckSell = gohelper.findChild(self.viewGO, "#go_ViewSelf/#go_CheckSell")
	self._txtSellPrice = gohelper.findChildText(self.viewGO, "#go_ViewSelf/#go_CheckSell/cost/#txt_SellPrice")
	self._goChessAvatar = gohelper.findChild(self.viewGO, "#go_ViewSelf/#go_ChessAvatar")
	self._goViewEnemy = gohelper.findChild(self.viewGO, "#go_ViewEnemy")
	self._btnBack = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ViewEnemy/#btn_Back")
	self._goEnemyBuff = gohelper.findChild(self.viewGO, "#go_ViewEnemy/#go_EnemyBuff")
	self._txtEnergyE = gohelper.findChildText(self.viewGO, "#go_ViewEnemy/#go_EnemyBuff/#txt_EnergyE")
	self._txtFireE = gohelper.findChildText(self.viewGO, "#go_ViewEnemy/#go_EnemyBuff/#txt_FireE")
	self._txtDebrisE = gohelper.findChildText(self.viewGO, "#go_ViewEnemy/#go_EnemyBuff/#txt_DebrisE")
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
	self._btnFresh:AddClickListener(self._btnFreshOnClick, self)
	self._btnLock:AddClickListener(self._btnLockOnClick, self)
	self._btnUnlock:AddClickListener(self._btnUnlockOnClick, self)
	self._btnBack:AddClickListener(self._btnBackOnClick, self)
	self._btnCollection:AddClickListener(self._btnCollectionOnClick, self)
	self._btnBackPick:AddClickListener(self._btnBackPickOnClick, self)
end

function AutoChessMallView:removeEvents()
	self._btnStartFight:RemoveClickListener()
	self._btnCheckEnemy:RemoveClickListener()
	self._btnLederSkill:RemoveClickListener()
	self._btnCancelUse:RemoveClickListener()
	self._btnPlayerBuff:RemoveClickListener()
	self._btnFresh:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	self._btnUnlock:RemoveClickListener()
	self._btnBack:RemoveClickListener()
	self._btnCollection:RemoveClickListener()
	self._btnBackPick:RemoveClickListener()
end

function AutoChessMallView:_btnCollectionOnClick()
	local collectionIds

	ViewMgr.instance:openView(ViewName.AutoChessCollectionView, self.checkingEnemy and self.chessMo.svrFight.enemyMaster.collectionIds or self.chessMo.svrFight.mySideMaster.collectionIds)
end

function AutoChessMallView:_btnPlayerBuffOnClick()
	local usingLeaderSkill = AutoChessGameModel.instance.usingLeaderSkill

	if usingLeaderSkill then
		AutoChessGameModel.instance:setUsingLeaderSkill(false)

		return
	end

	local svrFight = self.chessMo.svrFight
	local buffs = svrFight.mySideMaster.buffContainer.buffs
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
	gohelper.setActive(self._btnFresh, true)
	gohelper.setActive(self._goLockBtns, true)
	gohelper.setActive(self._goPickView, false)
	gohelper.setActive(self._goCollection, self.collectionCnt ~= 0)
	ViewMgr.instance:openView(ViewName.AutoChessForcePickView, self.freeMall)
end

function AutoChessMallView:_btnCheckEnemyOnClick()
	if self.chessMo.preview then
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

		local master = self.chessMo.svrFight.mySideMaster

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
	if tonumber(self.chessMo.svrMall.coin) >= self.freshCost then
		AutoChessHelper.lockScreen("AutoChessMallViewFreshStore", true)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_mln_details_open)
		gohelper.addChildPosStay(self._goChargeRoot, self.freeItem.go)
		self.animBtnFresh:Play("click", 0, 0)
		self.animBottom:Play("flushed", 0, 0)
		TaskDispatcher.runDelay(self.delayRefreshStore, self, 0.16)
		TaskDispatcher.runDelay(self.delaySetFreeItem, self, 0.4)
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function AutoChessMallView:delayRefreshStore()
	AutoChessRpc.instance:sendAutoChessRefreshMallRequest(self.moduleId)
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
	local freeMallRegion = AutoChessHelper.getMallRegionByType(self.chessMo.svrMall.regions, AutoChessEnum.MallType.Free)

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
	self.chessMo = AutoChessModel.instance:getChessMo()
	self.roundType = self.chessMo.svrFight.roundType

	if self.roundType == AutoChessEnum.RoundType.BOSS then
		self.bossRound = true

		gohelper.setActive(self._goRound, false)
		gohelper.setActive(self._goEnemyBuff, false)
	end

	self.collectionTbl = {}
end

function AutoChessMallView:onOpen()
	AutoChessGameModel.instance:setChessAvatar(self._goChessAvatar)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_shopping_enter)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.StartFight, self.closeThis, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UpdateMallData, self.refreshUI, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragChessEntity, self.onDragChess, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragChessEntityEnd, self.onDragChessEnd, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.MallCoinChange, self.onCoinChange, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.ForcePickViewBoard, self.onViewBoard, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.ForcePickReply, self.onForcePickReply, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UpdateMallRegion, self.onMallRegionChange, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UpdateMasterSkill, self.refreshLeaderSkillRelative, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UpdateLeaderBuff, self.refreshLeaderBuff, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DrageMallItem, self.onDragMallItem, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DrageMallItemEnd, self.onDragMallItemEnd, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.BuyChessReply, self.onBuyReply, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.BuildReply, self.onBuildReply, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.StartBuyStepFinih, self.onStartBuyFinish, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UsingLeaderSkill, self.onUsingLeaderSkill, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)

	local bossId = self.actMo:getGameMo(self.actId, self.moduleId).bossId
	local icon, bg = AutoChessHelper.getFightBtnIcon(self.roundType, bossId)

	UISpriteSetMgr.instance:setAutoChessSprite(self._imageStartIcon, icon)
	UISpriteSetMgr.instance:setAutoChessSprite(self._imageStartBg, bg)
	self:refreshUI()

	if self.viewParam then
		self.startBuyEnd = true
	end

	self:checkPopUp()
	self:refreshCollection()
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
	local sellKey = AutoChessEnum.ConstKey.ChessSellPrice

	self._txtSellPrice.text = lua_auto_chess_const.configDict[sellKey].value

	self:refreshMall()
	self:refreshLeaderSkillRelative()
	self:refreshLeaderBuff()
	self:refreshCoinRelative()
	self:refreshRoundRelative()
	self:refreshMallLock()
end

function AutoChessMallView:refreshMall()
	local svrMallData = self.chessMo.svrMall

	self:refreshMallItem(svrMallData)

	local normalRegion = AutoChessHelper.getMallRegionByType(svrMallData.regions, AutoChessEnum.MallType.Normal)
	local mallCo = lua_auto_chess_mall.configDict[normalRegion.mallId]

	if mallCo then
		if not mallCo.showLevel then
			local mallLvl = 0

			UISpriteSetMgr.instance:setAutoChessSprite(self._imageLevel, "v2a5_autochess_quality3_" .. mallLvl)

			self._txtMallLvl.text = "Lv." .. mallLvl

			gohelper.setActive(self._goCheckCost, not self.chessMo.preview)
		end
	end
end

function AutoChessMallView:refreshRoundRelative()
	local curRound = self.chessMo.sceneRound

	self.freshCost = self.chessMo.svrMall.refreshCost
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
	self.master = self.chessMo.svrFight.mySideMaster
	self.masterCo = lua_auto_chess_master.configDict[self.master.id]
	self.masterSkillCo = lua_auto_chess_master_skill.configDict[self.master.skill.id]

	self._simageSkill:LoadImage(ResUrl.getAutoChessIcon(self.masterCo.skillIcon, "skillicon"))

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

	gohelper.setActive(self._goSkillLock, not self.chessMo.svrFight.mySideMaster.skill.unlock)
	self:refreshLeaderSkillStatus()
end

function AutoChessMallView:refreshLeaderSkillStatus()
	local canUse, toastId = self:checkCanUseLeaderSkill()

	gohelper.setActive(self._goSkillLight, canUse)
	ZProj.UGUIHelper.SetGrayscale(self._simageSkill.gameObject, toastId == ToastEnum.AutoChessMasterSkill2)
end

function AutoChessMallView:refreshLeaderBuff()
	local svrFight = self.chessMo.svrFight
	local buffs = svrFight.mySideMaster.buffContainer.buffs
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
		buffs = svrFight.enemyMaster.buffContainer.buffs
		energy = AutoChessHelper.getBuffCnt(svrFight.enemyMaster.buffContainer.buffs, AutoChessEnum.EnergyBuffIds)
		self._txtEnergyE.text = energy

		gohelper.setActive(self._txtEnergyE, energy ~= 0)

		fire = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.FireBuffIds)
		self._txtFireE.text = fire

		gohelper.setActive(self._txtFireE, fire ~= 0)

		debris = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.DebrisIds)

		gohelper.setActive(self._txtDebrisE, debris ~= 0)
	end
end

function AutoChessMallView:refreshCoinRelative()
	local svrMallData = self.chessMo.svrMall

	self._txtCoin.text = svrMallData.coin

	local cost = self.chessMo.previewCoin

	self.previewCostEnough = self.chessMo:checkCostEnough(AutoChessStrEnum.CostType.Coin, cost)
	self._txtCheckCost.text = self.previewCostEnough and cost or string.format("<color=#BD2C2C>%s</color>", cost)

	gohelper.setActive(self._goStartLight, svrMallData.coin == 0)
end

function AutoChessMallView:refreshMallItem(svrMallData)
	for _, mallRegion in ipairs(svrMallData.regions) do
		local mallCo = lua_auto_chess_mall.configDict[mallRegion.mallId]

		if mallCo.type == AutoChessEnum.MallType.Normal then
			self.chargeMall = mallRegion

			table.sort(mallRegion.items, function(a, b)
				local itemCoA = lua_auto_chess_mall_item.configDict[a.id]
				local itemCoB = lua_auto_chess_mall_item.configDict[b.id]

				return itemCoA.order < itemCoB.order
			end)

			for i = 1, 7 do
				self.chargeItemList[i]:setData(mallRegion.mallId, mallRegion.items[i])
				gohelper.setActive(self.chargeFrameList[i].gameObject, i <= mallCo.capacity)
			end
		else
			self.freeMall = mallRegion

			self.freeItem:setData(mallRegion.mallId, mallRegion.items[1], true)
		end
	end
end

function AutoChessMallView:onStartBuyFinish()
	self.startBuyEnd = true

	self:checkPopUp()
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
	if not self.startBuyEnd then
		return
	end

	if self.chessMo.mallUpgrade then
		ViewMgr.instance:openView(ViewName.AutoChessMallLevelUpView)

		self.chessMo.mallUpgrade = false
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

function AutoChessMallView:onDragChess()
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
	gohelper.setActive(self._btnFresh, false)
	gohelper.setActive(self._goLockBtns, false)
	gohelper.setActive(self._goPickView, true)
	gohelper.setActive(self._goCollection, false)
end

function AutoChessMallView:onForcePickReply(giveUp)
	if not giveUp then
		self.animFreeFrame:Play("open", 0, 0)
		self:refreshMallItem(self.chessMo.svrMall)
		self:checkForcePick()
	end
end

function AutoChessMallView:onMallRegionChange()
	self:refreshUI()
	self:checkForcePick()
end

function AutoChessMallView:onDragMallItem(_, cost)
	if cost ~= 0 then
		self._txtCoin.text = string.format("%d(-%d)", self.chessMo.svrMall.coin, cost)

		self.animCoin:Play("loop", 0, 0)
	end
end

function AutoChessMallView:onDragMallItemEnd()
	self._txtCoin.text = self.chessMo.svrMall.coin

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

		local limitCnt = self.masterCo.roundTriggerCountLimit

		if limitCnt ~= 0 then
			local useCnts = self.chessMo.svrFight.mySideMaster.skill.roundUseCounts
			local roundUseCnt = 0

			for _, useCnt in ipairs(useCnts) do
				if useCnt.round == self.chessMo.sceneRound then
					roundUseCnt = useCnt.count

					break
				end
			end

			if limitCnt <= roundUseCnt then
				return false, ToastEnum.AutoChessMasterSkill2
			end
		end

		limitCnt = self.masterCo.totalTriggerCountLimit

		if self.masterCo.totalTriggerCountLimit ~= 0 then
			local useCnts = self.chessMo.svrFight.mySideMaster.skill.roundUseCounts
			local allUseCnt = 0

			for _, useCnt in ipairs(useCnts) do
				allUseCnt = allUseCnt + useCnt.count
			end

			if limitCnt <= allUseCnt then
				return false, ToastEnum.AutoChessMasterSkill3
			end
		end

		local costParams = string.split(self.masterSkillCo.cost, "#")

		return self.chessMo:checkCostEnough(costParams[1], tonumber(costParams[2]))
	end

	return true
end

function AutoChessMallView:refreshCollection()
	local collectionIds = self.checkingEnemy and self.chessMo.svrFight.enemyMaster.collectionIds or self.chessMo.svrFight.mySideMaster.collectionIds
	local count = #collectionIds

	if count ~= 0 then
		for k, id in ipairs(collectionIds) do
			local item = self.collectionTbl[k]

			if not item then
				item = self:getUserDataTb_()
				item.go = gohelper.cloneInPlace(self._goCollectionItem)
				item.simageIcon = gohelper.findChildSingleImage(item.go, "simage_icon")
				self.collectionTbl[k] = item
			end

			local config = AutoChessConfig.instance:getCollectionCfg(id)

			item.simageIcon:LoadImage(ResUrl.getAutoChessIcon(config.image, "collection"))
			gohelper.setActive(item.go, true)
		end

		for i = count + 1, #self.collectionTbl do
			gohelper.setActive(self.collectionTbl[i].go, false)
		end
	end

	self.collectionCnt = count

	gohelper.setActive(self._goCollection, self.collectionCnt ~= 0)
end

return AutoChessMallView
