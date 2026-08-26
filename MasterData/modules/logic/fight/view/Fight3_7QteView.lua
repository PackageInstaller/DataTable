-- chunkname: @modules/logic/fight/view/Fight3_7QteView.lua

module("modules.logic.fight.view.Fight3_7QteView", package.seeall)

local Fight3_7QteView = class("Fight3_7QteView", FightBaseView)

function Fight3_7QteView:onInitView()
	self.black = gohelper.findChild(self.viewGO, "#black")

	gohelper.setActive(self.black, true)

	self.videoGO = gohelper.findChild(self.viewGO, "videoplayer")
	self.count = 3
	self.lineRoot = gohelper.findChild(self.viewGO, "bossHpRoot/Line")

	gohelper.setActive(self.lineRoot, true)

	self.line3 = gohelper.findChild(self.viewGO, "bossHpRoot/Line/#line3")
	self.line2 = gohelper.findChild(self.viewGO, "bossHpRoot/Line/#line2")
	self.line1 = gohelper.findChild(self.viewGO, "bossHpRoot/Line/#line1")

	gohelper.setActive(self.line3, false)
	gohelper.setActive(self.line2, false)
	gohelper.setActive(self.line1, false)

	self.guide3 = gohelper.findChild(self.viewGO, "bossHpRoot/Line/#line3/#gui")
	self.guide2 = gohelper.findChild(self.viewGO, "bossHpRoot/Line/#line2/#gui")
	self.guide1 = gohelper.findChild(self.viewGO, "bossHpRoot/Line/#line1/#gui")
	self.line3Animator = gohelper.onceAddComponent(self.line3, gohelper.Type_Animator)
	self.line2Animator = gohelper.onceAddComponent(self.line2, gohelper.Type_Animator)
	self.line1Animator = gohelper.onceAddComponent(self.line1, gohelper.Type_Animator)
	self.lineClick3 = gohelper.findChildClickWithDefaultAudio(self.line3, "#gui/click")
	self.lineClick2 = gohelper.findChildClickWithDefaultAudio(self.line2, "#gui/click")
	self.lineClick1 = gohelper.findChildClickWithDefaultAudio(self.line1, "#gui/click")
	self.txt_tips = gohelper.findChildText(self.viewGO, "txtTips")
	self.txt_tips.fontSize = 56

	gohelper.setActive(self.txt_tips.gameObject, false)

	self.animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self.hpAnimator = gohelper.findChildComponent(self.viewGO, "bossHpRoot/BossHP", gohelper.Type_Animator)
	self.clickPart = gohelper.findChild(self.viewGO, "bottomLeft")

	gohelper.setActive(self.clickPart, false)

	self.clickTeamHit = gohelper.findChildClickWithDefaultAudio(self.viewGO, "bottomLeft/btn_teamHit")

	gohelper.setActive(self.clickTeamHit.gameObject, false)

	self.dialogueView = gohelper.findChild(self.viewGO, "#go_dialogcontainer")
	self.text = gohelper.findChildText(self.dialogueView, "#go_dialog/container/go_normalcontent/txt_contentcn")
	self.simageicon = gohelper.findChildSingleImage(self.dialogueView, "#go_dialog/container/headframe/headicon")
	self.simageBg = gohelper.findChildSingleImage(self.dialogueView, "#go_dialog/container/simagebg")

	self.simageBg:LoadImage(ResUrl.getFightBattleDialogBg("duihuak_002"))

	self.dialogClickRoot = gohelper.findChild(self.viewGO, "dialogClick")
	self.dialogClick = gohelper.findChildClick(self.viewGO, "dialogClick")

	self.animator:Play("qte0", 0, 0)
end

function Fight3_7QteView:addEvents()
	self:com_registClick(self.lineClick3, self.onClickLine3)
	self:com_registClick(self.lineClick2, self.onClickLine2)
	self:com_registClick(self.lineClick1, self.onClickLine1)
	self:com_registClick(self.clickTeamHit, self.onClickTeamHit)
end

function Fight3_7QteView:removeEvents()
	return
end

function Fight3_7QteView:setDialogueText(textKey)
	self.text.text = luaLang(textKey)
end

function Fight3_7QteView:onClickDialog3()
	if not self.dialogWorkTimer3.WORK_IS_FINISHED then
		self.dialogWorkTimer3:onDone(true)
	end
end

function Fight3_7QteView:onClickLine3()
	AudioMgr.instance:trigger(461041672)
	self.animator:Play("qte1", 0, 0)

	self.count = self.count - 1

	gohelper.setActive(self.lineClick3.gameObject, false)

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkFunction, gohelper.setActive, self.guide3, false)
	flow:registWork(FightWorkPlayAnimator, self.line3Animator.gameObject, "untie")
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogClickRoot, true)

	self.txt_tips.text = "<color=#fef2dc>" .. luaLang("fight_3_7_boss_qte_dialogue1") .. "</color>"

	flow:registWork(FightWorkFunction, gohelper.setActive, self.txt_tips.gameObject, true)
	flow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, 923700104)

	self.dialogWorkTimer3 = flow:registWork(FightWorkDelayTimer, 2)

	self:com_registClick(self.dialogClick, self.onClickDialog3)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.txt_tips.gameObject, false)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogClickRoot, false)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.guide2, true)
	flow:start()
end

function Fight3_7QteView:setHeadIcon(icon)
	self.simageicon:LoadImage(icon)
end

function Fight3_7QteView:onClickDialog2()
	if self.dialogWorkTimer2.STARTED and not self.dialogWorkTimer2.WORK_IS_FINISHED then
		self.dialogWorkTimer2:onDone(true)

		return
	end

	if self.dialogWorkTimer2_2.STARTED and not self.dialogWorkTimer2_2.WORK_IS_FINISHED then
		self.dialogWorkTimer2_2:onDone(true)

		return
	end
end

function Fight3_7QteView:onClickLine2()
	AudioMgr.instance:trigger(461041673)
	self.animator:Play("qte2", 0, 0)

	self.count = self.count - 1

	gohelper.setActive(self.lineClick2.gameObject, false)

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkFunction, gohelper.setActive, self.guide2, false)
	flow:registWork(FightWorkPlayAnimator, self.line2Animator.gameObject, "untie")
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogueView, true)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogClickRoot, true)

	local icon = ResUrl.getHeadIconSmall("302512")

	flow:registWork(FightWorkFunction, self.setHeadIcon, self, icon)
	flow:registWork(FightWorkFunction, self.setDialogueText, self, "fight_3_7_boss_qte_dialogue2")
	flow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, 923700108)

	self.dialogWorkTimer2 = flow:registWork(FightWorkDelayTimer, 2)
	icon = ResUrl.getHeadIconSmall("300301")

	flow:registWork(FightWorkFunction, self.setHeadIcon, self, icon)
	flow:registWork(FightWorkFunction, self.setDialogueText, self, "fight_3_7_boss_qte_dialogue3")
	flow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, 923700109)

	self.dialogWorkTimer2_2 = flow:registWork(FightWorkDelayTimer, 2)

	self:com_registClick(self.dialogClick, self.onClickDialog2)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogueView, false)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogClickRoot, false)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.guide1, true)
	flow:start()
end

function Fight3_7QteView:onClickDialog1()
	if self.dialogWorkTimer1.STARTED and not self.dialogWorkTimer1.WORK_IS_FINISHED then
		self.dialogWorkTimer1:onDone(true)

		return
	end

	if self.dialogWorkTimer1_2.STARTED and not self.dialogWorkTimer1_2.WORK_IS_FINISHED then
		self.dialogWorkTimer1_2:onDone(true)

		return
	end
end

function Fight3_7QteView:onClickLine1()
	AudioMgr.instance:trigger(461041674)
	self.animator:Play("qte3", 0, 0)
	gohelper.setActive(self.clickTeamHit.gameObject, true)

	self.count = self.count - 1

	self.line1Animator:Play("untie", 0, 0)
	gohelper.setActive(self.guide1, false)
	gohelper.setActive(self.lineClick1.gameObject, false)

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkDelayTimer, 0.67)

	self.txt_tips.text = "<color=#fef2dc>" .. luaLang("fight_3_7_boss_qte_dialogue4") .. "</color>"

	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogClickRoot, true)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.txt_tips.gameObject, true)
	flow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, 923700106)

	self.dialogWorkTimer1 = flow:registWork(FightWorkDelayTimer, 2)

	flow:registWork(FightWorkFunction, gohelper.setActive, self.txt_tips.gameObject, false)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogClickRoot, false)

	local parallel = flow:registWork(FightWorkFlowParallel)

	parallel:registWork(FightWorkSendEvent, FightEvent.SetIsShowUI, false)
	parallel:registWork(FightWorkFunction, self.setCapture, self, false)
	parallel:registWork(FightWorkFunction, self.setEntityActEnabled, self, true)

	local timelineFlow = parallel:registWork(FightWorkFlowSequence)

	timelineFlow:registWork(FightWorkDelayTimer, 0.3)
	timelineFlow:addWork(self.entity.skill:registTimelineWork("610416_guodu2", self.timelineData))
	timelineFlow:registWork(FightWorkSendEvent, FightEvent.SetIsShowUI, false)
	parallel:registWork(FightWorkPlayAnimator, self.hpAnimator.gameObject, "close")
	parallel:registWork(FightWorkPlayAnimator, self.line3, "close")
	parallel:registWork(FightWorkPlayAnimator, self.line2, "close")
	parallel:registWork(FightWorkPlayAnimator, self.line1, "close")
	parallel:registWork(FightWorkPlayAnimator, self.viewGO, "close")

	local qteAudio = parallel:registWork(FightWorkFlowSequence)

	qteAudio:registWork(FightWorkDelayTimer, 0.3)
	qteAudio:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, 461041675)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogueView, true)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogClickRoot, true)

	local icon = ResUrl.getHeadIconSmall("312713")

	flow:registWork(FightWorkFunction, self.setHeadIcon, self, icon)
	flow:registWork(FightWorkFunction, self.setDialogueText, self, "fight_3_7_boss_qte_dialogue5")
	flow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, 923700110)

	self.dialogWorkTimer1_2 = flow:registWork(FightWorkDelayTimer, 2)

	self:com_registClick(self.dialogClick, self.onClickDialog1)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogueView, false)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.dialogClickRoot, false)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.clickPart, true)
	flow:start()
end

function Fight3_7QteView:setCapture(state)
	local captureView = PostProcessingMgr.instance:getCaptureView()

	gohelper.setActive(captureView, state)
end

function Fight3_7QteView:onClickTeamHit()
	if self.qteclicked then
		return
	end

	self.qteclicked = true
	FightDataHelper.tempMgr.is3_7BossQtePre = true

	local flow = FightGameMgr.playMgr:com_registFlowSequence()

	flow:registWork(FightWorkFunction, FightRpc.instance.sendUseClothSkillRequest, FightRpc.instance, self.actInfo.param[1], "0", "0", FightEnum.ClothSkillType.BattleSelection)
	flow:registWork(FightWorkFunction, self.onFlowFinish, self)
	tabletool.clear(FightDataHelper.operationDataMgr.operationList)

	local operation = FightDataHelper.operationDataMgr:newOperation()

	operation.operType = 2
	operation.param1 = #FightDataHelper.handCardMgr.handCard + 1
	operation.toId = "0"

	flow:registWork(FightWorkFunction, FightRpc.instance.sendBeginRoundRequest, FightRpc.instance, FightDataHelper.operationDataMgr:getOpList())
	flow:start()
end

function Fight3_7QteView:onFlowFinish()
	self:closeThis()
end

function Fight3_7QteView:onBtnEsc()
	return
end

function Fight3_7QteView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.Started then
		self:logicStart()
	end
end

function Fight3_7QteView:onOpen()
	self.tweenComp = self:addComponent(FightTweenComponent)
	FightDataHelper.tempMgr.is3_7BossQteing = true

	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)
	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self.onBtnEsc, self)

	for k, entityData in pairs(FightDataHelper.entityMgr.entityDataDic) do
		local skin = entityData.skin

		if lua_fight_monster_3d.configDict[skin] then
			local entity = FightGameMgr.entityMgr:getById(entityData.id)

			if entity then
				self.entity = entity
			end

			break
		end
	end

	if not self.entity then
		self:closeThis()
		FightController.instance:sendEvent(FightEvent.RespUseClothSkillFail)

		return
	end

	for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		if entity and entity.nameUI then
			entity.nameUI:setActive(false, FightNameActiveKey.Fight3_7qteKey)
		end
	end

	FightMsgMgr.sendMsg(FightMsgId.Before3_7BossQte)

	self.videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(self.videoGO)

	self.videoPlayer:play("v3a7_boosfighrt_stoy", false, self._videoStatusUpdate, self)
end

function Fight3_7QteView:logicStart()
	AudioMgr.instance:trigger(461041671)

	self.txt_tips.text = "<color=#fef2dc>" .. luaLang("fight_3_7_boss_qte_dialogue6") .. "</color>"

	gohelper.setActive(self.black, false)
	self.animator:Play("qte0", 0, 0)

	self.actInfo = self.viewParam.actInfo

	local flow = self:com_registFlowSequence()
	local entityId = self.entity.id
	local var_18_0 = {
		actId = 0,
		actEffect = {
			{
				targetId = entityId
			}
		},
		fromId = entityId,
		toId = entityId,
		actType = FightEnum.ActType.SKILL
	}

	var_18_0.stepUid = FightTLEventEntityVisible.latestStepUid or 0
	self.timelineData = var_18_0

	flow:registWork(FightWorkFunction, self.setEntityActEnabled, self, false)

	local parallel = flow:registWork(FightWorkFlowParallel)

	parallel:registWork(FightWorkDelayTimer, 10.4)

	local tipsFlow = parallel:registWork(FightWorkFlowSequence)
	local zi_chu_xian_shi_jian = 1

	tipsFlow:registWork(FightWorkDelayTimer, zi_chu_xian_shi_jian)
	tipsFlow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, 923700103)
	tipsFlow:registWork(FightWorkFunction, gohelper.setActive, self.txt_tips.gameObject, true)

	local fadeEnterTime = 2

	tipsFlow:registWork(FightTweenWork, {
		from = 0,
		type = "DOFadeCanvasGroup",
		to = 1,
		go = self.txt_tips.gameObject,
		t = fadeEnterTime
	})
	tipsFlow:registWork(FightWorkDelayTimer, fadeEnterTime)

	local zi_de_bao_chi_shi_jian = 1.73

	tipsFlow:registWork(FightWorkDelayTimer, zi_de_bao_chi_shi_jian)

	local fadeExitTime = 1.2

	tipsFlow:registWork(FightTweenWork, {
		from = 1,
		type = "DOFadeCanvasGroup",
		to = 0,
		go = self.txt_tips.gameObject,
		t = fadeExitTime
	})
	tipsFlow:registWork(FightWorkFunction, gohelper.setActive, self.txt_tips.gameObject, false)
	flow:registWork(FightWorkFunction, self.refreshTipsAlpha, self)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.line3, true)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.line2, true)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.line1, true)
	flow:registWork(FightWorkFunction, gohelper.setActive, self.guide3, true)
	flow:start()
end

function Fight3_7QteView:refreshTipsAlpha()
	self.tweenComp:DOFadeCanvasGroup(self.txt_tips.gameObject, 0, 1, 0.1)
end

function Fight3_7QteView:setEntityActEnabled(state)
	self.entity.spine.animatorPlayer.animator.enabled = state
end

function Fight3_7QteView:onClose()
	self:setCapture(true)
end

function Fight3_7QteView:onDestroyView()
	return
end

return Fight3_7QteView
