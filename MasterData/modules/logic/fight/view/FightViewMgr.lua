-- chunkname: @modules/logic/fight/view/FightViewMgr.lua

module("modules.logic.fight.view.FightViewMgr", package.seeall)

local FightViewMgr = class("FightViewMgr", FightBaseView)

function FightViewMgr:onInitView()
	self._topLeft = gohelper.findChild(self.viewGO, "root/topLeftContent")
	self._topRightBtnRoot = gohelper.findChild(self.viewGO, "root/btns")
	self._fightSeasonChangeHero = gohelper.findChild(self.viewGO, "root/fightSeasonChangeHero")
	self._progressRoot = gohelper.findChild(self._topLeft, "#go_commonalityslider")
	self._goRoot = gohelper.findChild(self.viewGO, "root")
	self._taskRoot = gohelper.findChild(self.viewGO, "root/topLeftContent/#go_task")

	gohelper.setActive(self._fightSeasonChangeHero, false)
	gohelper.setActive(self._progressRoot, false)
	gohelper.setActive(self._taskRoot, false)
end

function FightViewMgr:addEvents()
	self:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, self._onBeforeEnterStepBehaviour)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.BloodPool_OnCreate, self.onBloodPoolCreate)
	self:com_registFightEvent(FightEvent.HeatScale_OnCreate, self.onHeatScaleCreate)
	self:com_registFightEvent(FightEvent.DoomsdayClock_OnValueChange, self.onCreateDoomsdayClock)
	self:com_registFightEvent(FightEvent.DoomsdayClock_OnAreaChange, self.onCreateDoomsdayClock)
	self:com_registMsg(FightMsgId.FightProgressValueChange, self._showFightProgress)
	self:com_registMsg(FightMsgId.FightMaxProgressValueChange, self._showFightProgress)
	self:com_registMsg(FightMsgId.ShowDouQuQuXianHouShou, self._onShowDouQuQuXianHouShou)
	self:com_registMsg(FightMsgId.RefreshPlayerFinisherSkill, self._showPlayerFinisherSkill)
	self:com_registMsg(FightMsgId.RefreshSimplePolarizationLevel, self._onRefreshSimplePolarizationLevel)
	self:com_registMsg(FightMsgId.GetFightViewGameObject, self._onGetFightViewGameObject)
end

function FightViewMgr:removeEvents()
	return
end

function FightViewMgr:_onGetFightViewGameObject()
	FightMsgMgr.replyMsg(FightMsgId.GetFightViewGameObject, self.viewGO)
end

function FightViewMgr:onCreateDoomsdayClock()
	self:createDoomsdayClock()
end

function FightViewMgr:onBloodPoolCreate(teamType)
	if teamType ~= FightEnum.TeamType.MySide then
		return
	end

	self:_createBloodPool(teamType)
end

function FightViewMgr:onHeatScaleCreate(teamType)
	if teamType ~= FightEnum.TeamType.MySide then
		return
	end

	self:_createHeatScale(teamType)
end

function FightViewMgr:_showSimplePolarizationLevel()
	local vertin = FightDataHelper.entityMgr:getMyVertin()

	if vertin then
		local buffList = vertin:getBuffList()

		for i, v in ipairs(buffList) do
			if v.buffId == 6240501 then
				self:_onRefreshSimplePolarizationLevel()

				return
			end
		end
	end
end

function FightViewMgr:_onBuffUpdate(entityId, effectType, buffId, buffUid)
	if buffId == 6240501 and entityId == FightEntityScene.MySideId then
		self:_onRefreshSimplePolarizationLevel()
	end
end

function FightViewMgr:_onRefreshSimplePolarizationLevel()
	if self._simplePolarizationLevel then
		return
	end

	local goMelodyLevel = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.MelodyLevel)

	self._simplePolarizationLevel = self:com_openSubView(FightSimplePolarizationLevelView, "ui/viewres/fight/fightsimplepolarizationlevelview.prefab", goMelodyLevel)

	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.MelodyLevel)
end

function FightViewMgr:_onRefreshPlayerFinisherSkill()
	if self._playerFinisherSkill then
		return
	end

	local goMelodySkill = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.MelodySkill)

	self._playerFinisherSkill = self:com_openSubView(FightPlayerFinisherSkillView, "ui/viewres/fight/fightplayerfinisherskillview.prefab", goMelodySkill)

	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.MelodySkill)
end

function FightViewMgr:_onShowDouQuQuXianHouShou(actEffectData)
	self:com_openSubView(FightAct174StartFirstView, "ui/viewres/fight/fight_act174startfirstview.prefab", self.viewGO, actEffectData)
end

function FightViewMgr:_onBeforeEnterStepBehaviour()
	if FightModel.instance:isSeason2() then
		gohelper.setActive(self._fightSeasonChangeHero, true)
		self:com_openSubView(FightSeasonChangeHeroView, self._fightSeasonChangeHero)
	end

	self:_showTopLeft()
end

function FightViewMgr:_showTopLeft()
	self:_showFightProgress()
end

function FightViewMgr:_showFightProgress()
	local progressMax = FightDataHelper.fieldMgr.progressMax

	if progressMax > 0 then
		if self._progressView then
			return
		end

		gohelper.setActive(self._progressRoot, true)

		local progressId = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId]
		local path = "ui/viewres/fight/commonalityslider.prefab"
		local class = FightCommonalitySlider

		if progressId == 1 then
			path = "ui/viewres/fight/commonalityslider1.prefab"
		elseif progressId == 2 then
			path = "ui/viewres/fight/commonalityslider2.prefab"
			class = FightCommonalitySlider2
		elseif progressId == 3 then
			path = "ui/viewres/fight/fightcoldview.prefab"
			class = FightCommonalitySlider3
		elseif progressId == 4 then
			path = "ui/viewres/fight/fightcoldview.prefab"
			class = FightCommonalitySlider4
		end

		self._progressView = self:com_openSubView(class, path, self._progressRoot, self._goRoot)
	end
end

function FightViewMgr:showFightNewProgress()
	self:com_openSubView(FightNewProgressView, self.viewGO)
end

function FightViewMgr:onOpen()
	self.top = self:com_openSubView(FightTopView, self.viewGO)
	self.topLeft = self:com_openSubView(FightTopLeftView, self.viewGO)
	self.topRight = self:com_openSubView(FightTopRightView, self.viewGO)
	self.center = self:com_openSubView(FightCenterView, self.viewGO)
	self.left = self:com_openSubView(FightLeftView, self.viewGO)
	self.right = self:com_openSubView(FightRightView, self.viewGO)
	self.bottom = self:com_openSubView(FightBottomView, self.viewGO)
	self.bottomLeft = self:com_openSubView(FightBottomLeftView, self.viewGO)
	self.bottomRight = self:com_openSubView(FightBottomRightView, self.viewGO)

	self:_showCardDeckBtn()
	self:_showSeasonTalentBtn()
	self:_showPlayerFinisherSkill()
	self:_showSimplePolarizationLevel()
	self:_showTaskPart()
	self:_showBloodPool()
	self:_showHeatScale()
	self:_showDoomsdayClock()
	self:showDouQuQuHunting()
	self:showFightNewProgress()
	self:showItemSkillInfos()
	self:showBattleId_9290103_Task()
	self:showDouQuQuBoss()
	self:showSurvivalTalent2()
	self:showZongMaoScore()
	self:showRouge2MusicInfo()
	self:showRouge2CoinAndRevivalCoin()
	self:showRouge2TreasureView()
	self:showRouge2Task()
	self:showRouge2Slapstick()
	self:openLorentzCardView()
	self:showMeileiierExRound()
end

function FightViewMgr:openLorentzCardView()
	if self.lorentzCardView then
		return
	end

	local viewGo = gohelper.findChild(self.viewGO, "root/#go_lorentz_cards")

	self.lorentzCardView = self:com_openSubView(FightLorentzCardView, viewGo)
end

function FightViewMgr:showRouge2Slapstick()
	if not FightDataHelper.fieldMgr:isRouge2() then
		return
	end

	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if not assistBoss then
		return
	end

	if not FightDataHelper.paTaMgr:checkIsRouge3_3() then
		return
	end

	if self.rouge2SlapstickView then
		return
	end

	local url = "ui/viewres/fight/fight_rouge2/fight_rouge2_yuebianshouview.prefab"
	local enum = FightRightElementEnum.Elements.Rouge2Slapstick
	local root = self.viewContainer.rightElementLayoutView:getElementContainer(enum)

	self.rouge2SlapstickView = self:com_openSubView(FightRouge2SlapstickView, url, root)

	self.viewContainer.rightElementLayoutView:showElement(enum)
end

function FightViewMgr:showRouge2Task()
	local customData = FightDataHelper.fieldMgr.customData
	local rouge2Data = customData and customData[FightCustomData.CustomDataType.Rouge2]
	local eventType = rouge2Data and rouge2Data.eventType

	if eventType ~= Rouge2_MapEnum.EventType.NormalFight then
		return
	end

	if self.rouge2TaskView then
		return
	end

	local url = "ui/viewres/fight/fight_rouge2/fight_rouge2_level.prefab"
	local enum = FightRightElementEnum.Elements.Rouge2Task
	local root = self.viewContainer.rightElementLayoutView:getElementContainer(enum)

	self.rouge2TaskView = self:com_openSubView(FightRouge2TaskView, url, root)

	self.viewContainer.rightElementLayoutView:showElement(enum)
end

function FightViewMgr:showRouge2CoinAndRevivalCoin()
	if not FightDataHelper.fieldMgr:isRouge2() then
		return
	end

	if self.rougeCoinMgr then
		return
	end

	self.rougeCoinMgr = FightRouge2CoinMgr.New(self.viewContainer)

	self.rougeCoinMgr:start()
end

function FightViewMgr:showRouge2TreasureView()
	if not FightDataHelper.fieldMgr:isRouge2() then
		return
	end

	local career = FightHelper.getRouge2Career()

	if career ~= FightEnum.Rouge2Career.Strings then
		return
	end

	if self.rouge2TreasureView then
		return
	end

	local url = "ui/viewres/fight/fight_rouge2/fight_rouge2_treasureitem.prefab"
	local enum = FightRightElementEnum.Elements.Rouge2Treasure
	local root = self.viewContainer.rightElementLayoutView:getElementContainer(enum)

	self.rouge2TreasureView = self:com_openSubView(FightRouge2TreasureView, url, root)
end

function FightViewMgr:showRouge2MusicInfo()
	if self.rouge2MusicInfoView then
		return
	end

	if not FightDataHelper.hasMusicInfo() then
		return
	end

	local url = "ui/viewres/fight/fight_rouge2/fight_rouge2_yinfuview.prefab"
	local root = gohelper.findChild(self._goRoot, "rouge2music")

	self.rouge2MusicInfoView = self:com_openSubView(FightRouge2MusicView, url, root)
end

function FightViewMgr:showSurvivalTalent2()
	if self.survivalTalent2View then
		return
	end

	local vorpalithMo = FightDataHelper.entityMgr:getVorpalith()
	local power = vorpalithMo and vorpalithMo:getPowerInfo(FightEnum.PowerType.SurvivalDot)

	if power then
		local url = "ui/viewres/fight/fightsurvivaltalentview2.prefab"
		local parentRoot = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.SurvivalTalent2)

		self.survivalTalent2View = self:com_openSubView(FightSurvivalTalent2View, url, parentRoot)

		self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.SurvivalTalent2)
	end
end

function FightViewMgr:showItemSkillInfos()
	local itemSkillInfos = FightDataHelper.teamDataMgr.myData.itemSkillInfos

	if itemSkillInfos and #itemSkillInfos > 0 then
		local url = "ui/viewres/fight/fightassassinwheelbtnview.prefab"
		local parentRoot = gohelper.findChild(self.viewGO, "root")

		self:com_openSubView(FightItemSkillInfosBtnView, url, parentRoot)
	end
end

function FightViewMgr:showDouQuQuHunting()
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	if not customData then
		return
	end

	if customData.minNeedHuntValue == -1 then
		return
	end

	local enum = FightRightElementEnum.Elements.DouQuQuHunting
	local parentRoot = self.viewContainer.rightElementLayoutView:getElementContainer(enum)

	self:com_openSubView(FightDouQuQuHuntingView, "ui/viewres/fight/fight_act191huntview.prefab", parentRoot)
	self.viewContainer.rightElementLayoutView:showElement(enum)
end

function FightViewMgr:showDouQuQuCoin()
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	if not customData then
		return
	end

	local enum = FightRightElementEnum.Elements.DouQuQuCoin
	local parentRoot = self.viewContainer.rightElementLayoutView:getElementContainer(enum)

	self:com_openSubView(FightDouQuQuCoinView, "ui/viewres/fight/fight_act191coinview.prefab", parentRoot)
	self.viewContainer.rightElementLayoutView:showElement(enum)
end

function FightViewMgr:showDouQuQuBoss()
	local spFightEntities = FightDataHelper.entityMgr:getSpFightEntities(FightEnum.TeamType.MySide)

	for k, entityData in pairs(spFightEntities) do
		if entityData.entityType == FightEnum.EntityType.Act191Boss then
			local skin = entityData.skin

			if entityData:getPowerInfo(FightEnum.PowerType.Act191Boss) then
				local parentRoot = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DouQuQuBoss)

				if skin == 6104062 then
					do
						local url = "ui/viewres/fight/fight_act191assistbossview3.prefab"
						local class = FightDouQuQuBossView6104061

						self:com_openSubView(class, url, parentRoot, entityData)
						self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.DouQuQuBoss)
					end

					break
				end

				if skin == 6104061 or skin == 610407 or skin == 413401 then
					self:com_openSubView(FightDouQuQuBossView, "ui/viewres/fight/fight_act191assistbossview.prefab", parentRoot, entityData)
					self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.DouQuQuBoss)
				end

				break
			end

			if skin == 6704041 or skin == 6704042 or skin == 6704043 then
				local url = "ui/viewres/fight/fight_act191assistbossview2.prefab"
				local class = FightDouQuQuBossViewDeer
				local parentRoot = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DouQuQuBoss)

				self:com_openSubView(class, url, parentRoot, entityData)
				self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.DouQuQuBoss)
			end
		end
	end
end

function FightViewMgr:showZongMaoScore()
	if FightDataHelper.fieldMgr:isV3_2ZongMao() or FightDataHelper.fieldMgr:isRouge2Boss() then
		local parentRoot = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.BossRush)

		self.zongMaoScoreView = self:com_openSubView(FightZongMaoScoreView, "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_ig_scoretips.prefab", parentRoot)

		self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.BossRush)
	end
end

function FightViewMgr:_showDoomsdayClock()
	local param = FightDataHelper.fieldMgr.param
	local value = param and param:getKey(FightParamData.ParamKey.DoomsdayClock_Range4)

	if value then
		self:createDoomsdayClock()
	end
end

function FightViewMgr:createDoomsdayClock()
	if self.doomsdayClockView then
		return
	end

	local parentRoot = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DoomsdayClock)

	self.doomsdayClockView = self:com_openSubView(FightDoomsdayClockView, "ui/viewres/fight/fightclockview.prefab", parentRoot)

	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.DoomsdayClock)
end

function FightViewMgr:_showBloodPool()
	local bloodPool = FightDataHelper.getBloodPool(FightEnum.TeamType.MySide)

	if bloodPool then
		self:_createBloodPool(FightEnum.TeamType.MySide)
	end
end

function FightViewMgr:_showHeatScale()
	local heatScale = FightDataHelper.getHeatScale(FightEnum.TeamType.MySide)

	if heatScale then
		self:_createHeatScale(FightEnum.TeamType.MySide)
	end
end

function FightViewMgr:showMeileiierExRound()
	self.meiLeiErMgrView = self:com_openSubView(FightMeileLeiErBtnView)
end

function FightViewMgr:_createBloodPool(teamType)
	if self.bloodPoolView then
		return
	end

	local parentRoot = self.viewContainer.rightBottomElementLayoutView:getElementContainer(FightRightBottomElementEnum.Elements.BloodPool)

	self.bloodPoolView = self:com_openSubView(FightBloodPoolView, "ui/viewres/fight/fightbloodview.prefab", parentRoot, teamType)

	self.viewContainer.rightBottomElementLayoutView:showElement(FightRightBottomElementEnum.Elements.BloodPool)
end

function FightViewMgr:_createHeatScale(teamType)
	if self.heatScaleMgrView then
		return
	end

	self.heatScaleMgrView = self:com_openSubView(FightHeatScaleMgrView, nil, nil, teamType)
end

function FightViewMgr:_createSurvivalTalent()
	if self.survivalTalentView then
		return
	end

	local parentRoot = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.SurvivalTalent)

	self.survivalTalentView = self:com_openSubView(FightSurvivalTalentView, "ui/viewres/fight/fightsurvivaltalentview.prefab", parentRoot)

	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.SurvivalTalent)
end

function FightViewMgr:_showPlayerFinisherSkill()
	local playerFinisherInfo = FightDataHelper.fieldMgr.playerFinisherInfo

	if not playerFinisherInfo then
		return
	end

	if playerFinisherInfo.type == FightPlayerFinisherInfoData.Type.SurvivalTalent then
		self:_createSurvivalTalent()

		return
	end

	if playerFinisherInfo and #playerFinisherInfo.skills > 0 then
		self:_onRefreshPlayerFinisherSkill()
	end
end

function FightViewMgr:_showCardDeckBtn()
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		self:com_loadAsset("ui/viewres/fight/fightcarddeckbtnview.prefab", self._onBtnLoaded)
	end
end

function FightViewMgr:onDeckGenerate_Anim(cardInfoList)
	if cardInfoList then
		if not #cardInfoList then
			local len = 0

			if len <= 0 then
				return
			end

			for index, go in ipairs(self.goPaiList) do
				gohelper.setActive(go, index <= len)
			end

			self:showDeckActiveGo()
			self.deckAnimatorPlayer:Play("generate", self.hideDeckActiveGo, self)
			AudioMgr.instance:trigger(20250502)
		end
	end
end

function FightViewMgr:onPlayGenerateAnimDone()
	self:hideDeckActiveGo()
	self:com_sendFightEvent(FightEvent.CardDeckGenerateDone)
end

function FightViewMgr:onDeckDelete_Anim(cardInfoList)
	if cardInfoList then
		if not #cardInfoList then
			local len = 0

			if len <= 0 then
				return self:onPlayDeleteAnimDone()
			end

			for index, go in ipairs(self.goPaiList) do
				gohelper.setActive(go, index <= len)
			end

			self:showDeckActiveGo()
			self.deckAnimatorPlayer:Play("delete", self.onPlayDeleteAnimAnchorDone, self)
			AudioMgr.instance:trigger(20250503)
		end
	end
end

function FightViewMgr:onPlayDeleteAnimAnchorDone()
	local context = {
		dissolveScale = 1,
		dissolveSkillItemGOs = {
			self.goDeckActive
		}
	}

	self:clearFlow()

	self.dissolveFlow = FlowSequence.New()

	self.dissolveFlow:addWork(FightCardDissolveEffect.New())
	self.dissolveFlow:registerDoneListener(self.onPlayDeleteAnimDone, self)
	self.dissolveFlow:start(context)
end

function FightViewMgr:clearFlow()
	if self.dissolveFlow then
		self.dissolveFlow:stop()

		self.dissolveFlow = nil
	end
end

function FightViewMgr:onPlayDeleteAnimDone()
	self:hideDeckActiveGo()
	self:com_sendFightEvent(FightEvent.CardDeckDeleteDone)
end

function FightViewMgr:hideDeckActiveGo()
	gohelper.setActive(self.goDeckActive, false)
end

function FightViewMgr:showDeckActiveGo()
	gohelper.setActive(self.goDeckActive, true)
end

FightViewMgr.MaxDeckAnimLen = 15

function FightViewMgr:_onBtnLoaded(success, loader)
	if not success then
		return
	end

	local tarPrefab = loader:GetResource()
	local btn = gohelper.clone(tarPrefab, self._topRightBtnRoot, "cardBox")

	self.goDeckBtn = btn

	self.com_registClick(self, gohelper.getClickWithDefaultAudio(btn), self._onCardBoxClick, self)
	gohelper.setAsFirstSibling(btn)

	self._deckCardAnimator = gohelper.onceAddComponent(btn, typeof(UnityEngine.Animator))
	self._deckBtnAniPlayer = SLFramework.AnimatorPlayer.Get(btn)
	self.txtNum = gohelper.findChildText(btn, "txt_Num")

	gohelper.setActive(self.txtNum.gameObject, false)

	local activeGo = gohelper.findChild(self.goDeckBtn, "#go_Active")

	gohelper.setActive(activeGo, false)

	self.deckContainer = gohelper.findChild(self.goDeckBtn, "#deckbtn")

	gohelper.setActive(self.deckContainer, true)

	self.deckAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.deckContainer)
	self.goDeckActive = gohelper.findChild(self.deckContainer, "active")

	self:hideDeckActiveGo()

	self.goPaiList = self:newUserDataTable()

	for i = 1, FightViewMgr.MaxDeckAnimLen do
		local go = gohelper.findChild(self.goDeckActive, string.format("#pai%02d", i))

		if not go then
			logError("deck view not find pai , index : " .. i)
		end

		table.insert(self.goPaiList, go)
	end

	self:com_registFightEvent(FightEvent.CardDeckGenerate, self._onCardDeckGenerate)
	self:com_registFightEvent(FightEvent.CardClear, self._onCardClear)
	self:com_registFightEvent(FightEvent.CardBoxNumChange, self.onCardBoxNumChange)
	self:com_registFightEvent(FightEvent.CardDeckGenerate, self.onDeckGenerate_Anim)
	self:com_registFightEvent(FightEvent.CardDeckDelete, self.onDeckDelete_Anim)
	self:com_registFightEvent(FightEvent.CardBoxPlayAnim, self.onPlayCardBoxAnim)
end

function FightViewMgr:onPlayCardBoxAnim(animName)
	self._deckBtnAniPlayer:Play(animName, self.playIdleAnim, self)
end

function FightViewMgr:activeDeck()
	local fieldMgr = FightDataHelper.fieldMgr

	if fieldMgr and fieldMgr:isAct183() then
		local activeGo = gohelper.findChild(self.goDeckBtn, "#go_Active")

		gohelper.setActive(activeGo, true)
		gohelper.setActive(self.txtNum.gameObject, true)
	end
end

function FightViewMgr:clearTweenId()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

FightViewMgr.DeckNumChangeDuration = 0.5

function FightViewMgr:onCardBoxNumChange(beforeNum, afterNum)
	self:activeDeck()
	self:clearTweenId()

	local var_52_0 = tonumber(self.txtNum.text) or 0
end

function FightViewMgr:directSetDeckNum(value)
	self.txtNum.text = math.ceil(value)
end

function FightViewMgr:onNumChangeDone()
	self:directSetDeckNum(FightDataHelper.fieldMgr.deckNum)
end

function FightViewMgr:_onCardBoxClick()
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.CardBox
	})
end

function FightViewMgr:_showSeasonTalentBtn()
	local battleContext = Season166Model.instance:getBattleContext(true)

	if not battleContext then
		return
	end

	if Season166Model.instance:checkCanShowSeasonTalent() then
		self:com_loadAsset("ui/viewres/fight/fightseasontalentbtn.prefab", self._onBtnSeasonTalentLoaded)
	end
end

function FightViewMgr:_onBtnSeasonTalentLoaded(success, loader)
	if not success then
		return
	end

	local tarPrefab = loader:GetResource()
	local btn = gohelper.clone(tarPrefab, self._topRightBtnRoot, "fightseasontalentbtn")

	self.com_registClick(self, gohelper.getClickWithDefaultAudio(btn), self._onSeasonTalentClick, self)
	gohelper.setAsFirstSibling(btn)
end

function FightViewMgr:_onSeasonTalentClick()
	Season166Controller.instance:openTalentInfoView()
end

function FightViewMgr:playIdleAnim()
	self._deckCardAnimator.enabled = true

	self._deckCardAnimator:Play("idle")
end

function FightViewMgr:_onCardDeckGenerate()
	self._deckBtnAniPlayer:Play("add", self.playIdleAnim, self)
end

function FightViewMgr:_onCardClear()
	self._deckBtnAniPlayer:Play("delete", self.playIdleAnim, self)
end

function FightViewMgr:_showTaskPart()
	local episodeId = FightDataHelper.fieldMgr.episodeId
	local is183 = FightDataHelper.fieldMgr:isDungeonType(DungeonEnum.EpisodeType.Act183)

	if is183 then
		local config = lua_challenge_episode.configDict[episodeId]

		if not config then
			return
		end

		if string.nilorempty(config.condition) then
			return
		end

		gohelper.setActive(self._taskRoot, true)
		self:com_openSubView(Fight183TaskView, "ui/viewres/fight/fighttaskview.prefab", self._taskRoot, config.condition)
	end
end

function FightViewMgr:showBattleId_9290103_Task()
	local battleId = FightDataHelper.fieldMgr.battleId

	if battleId == 9290103 then
		gohelper.setActive(self._taskRoot, true)
		self:com_openSubView(FightBattleId_9290103TaskView, "ui/viewres/fight/fighttaskview.prefab", self._taskRoot)
	end
end

function FightViewMgr:onClose()
	return
end

function FightViewMgr:onDestroyView()
	if self.rougeCoinMgr then
		self.rougeCoinMgr:destroy()

		self.rougeCoinMgr = nil
	end

	self:clearFlow()
	self:clearTweenId()
end

return FightViewMgr
