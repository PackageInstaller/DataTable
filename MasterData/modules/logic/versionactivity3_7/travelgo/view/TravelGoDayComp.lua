-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/TravelGoDayComp.lua

module("modules.logic.versionactivity3_7.travelgo.view.TravelGoDayComp", package.seeall)

local TravelGoDayComp = class("TravelGoDayComp", LuaCompBase)

function TravelGoDayComp:ctor(goView)
	self.goView = goView
end

function TravelGoDayComp:init(viewGO)
	self.viewGO = viewGO
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._txtDays = gohelper.findChildTextMesh(self.viewGO, "Day/#txt_Days")
	self._godayrefresh = gohelper.findChild(self.viewGO, "Day/refresh")
	self._godetail = gohelper.findChild(self.viewGO, "Detail")
	self._detailAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._godetail)
	self.ScrollView = gohelper.findChild(self.viewGO, "Detail/Scroll View")
	self.Content = gohelper.findChild(self.viewGO, "Detail/Scroll View/Viewport/Content")
	self.TravelGoDescItem = gohelper.findChild(self.Content, "TravelGoDescItem")
	self.TravelGoSkillRewardItem = gohelper.findChild(self.Content, "TravelGoSkillRewardItem")

	gohelper.setActive(self.TravelGoDescItem, false)
	gohelper.setActive(self.TravelGoSkillRewardItem, false)

	self._goNext = gohelper.findChild(self.viewGO, "Detail/#btn_Next")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "Detail/#btn_Next/#btn_Next_1")
	self._nextAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._goNext)
	self.StoryEvent = gohelper.findChild(self.viewGO, "Detail/StoryEvent")
	self._storyEventAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.StoryEvent)

	local goStory1 = gohelper.findChild(self.StoryEvent, "1")
	local goStory2 = gohelper.findChild(self.StoryEvent, "2")

	self._storyEventBtnAnimatorPlayer1 = ZProj.ProjAnimatorPlayer.Get(goStory1)
	self._storyEventBtnAnimatorPlayer2 = ZProj.ProjAnimatorPlayer.Get(goStory2)
	self.btnChoice1 = gohelper.findChildButtonWithAudio(self.StoryEvent, "1/#btn_click")
	self.btnChoice2 = gohelper.findChildButtonWithAudio(self.StoryEvent, "2/#btn_click")
	self.textChoice1 = gohelper.findChildTextMesh(self.StoryEvent, "1/#txt_Active")
	self.textChoice2 = gohelper.findChildTextMesh(self.StoryEvent, "2/#txt_Active")
	self.nodeChoice1 = gohelper.findChild(self.StoryEvent, "1/Image_NumBG")
	self.nodeChoice2 = gohelper.findChild(self.StoryEvent, "2/Image_NumBG")
	self.textReward1 = gohelper.findChildTextMesh(self.StoryEvent, "1/Image_NumBG/#txt_Num")
	self.textReward2 = gohelper.findChildTextMesh(self.StoryEvent, "2/Image_NumBG/#txt_Num")
	self.BattleEvent = gohelper.findChild(self.viewGO, "Detail/BattleEvent")
	self._battleEventAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.BattleEvent)
	self._btnFight = gohelper.findChildButtonWithAudio(self.BattleEvent, "#btn_Fight")
	self.scroll = gohelper.findChildScrollRect(self.viewGO, "Detail/Scroll View")
	self.LuckEvent = gohelper.findChild(self.viewGO, "Detail/LuckEvent")
	self.LuckEvent1 = gohelper.findChild(self.LuckEvent, "1")

	local txtLuckEvent1 = gohelper.findChild(self.LuckEvent, "1/#simage_txt")

	self._luckEvent1AnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(txtLuckEvent1)
	self.LuckEvent2 = gohelper.findChild(self.LuckEvent, "2")

	local txtLuckEvent2 = gohelper.findChild(self.LuckEvent, "2/#simage_txt")

	self._luckEvent2AnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(txtLuckEvent2)
	self.LuckEvent3 = gohelper.findChild(self.LuckEvent, "3")

	local txtLuckEvent3 = gohelper.findChild(self.LuckEvent, "3/#simage_txt")

	self._luckEvent3AnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(txtLuckEvent3)
	self.Attr = gohelper.findChild(self.viewGO, "Attr")
	self.travelGoAttrComp = GameFacade.createLuaCompByGo(self.Attr, TravelGoAttrComp, nil, self.viewContainer)
	self.btnSkill = gohelper.findChildButtonWithAudio(self.viewGO, "btnSkill")
	self.goSkillEff = gohelper.findChild(self.viewGO, "btnSkill/btnSkill_bg/vx_effect")
	self._gobtnSkill = self.btnSkill.gameObject
	self._btnSkillAnimator = self.btnSkill:GetComponent(gohelper.Type_Animator)
	self.goSkill = gohelper.findChild(self.viewGO, "Skill")
	self._skillAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goSkill)
	self.btnCloseSkill = gohelper.findChildButtonWithAudio(self.viewGO, "Skill/btnCloseSkill")
	self.goSkillList = gohelper.findChild(self.viewGO, "Skill/Node/skillList")

	gohelper.setActive(self._goNext, false)

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = TravelGoSkillItem
	self.skillList = GameFacade.createSimpleListComp(self.goSkillList, scrollParam, nil, self.viewContainer)
	self.controller = TravelGoController.instance
	self.model = TravelGoModel.instance
	self.items = {}
	self.skillItems = {}
	self.defaultH = recthelper.getHeight(self.ScrollView.transform)
end

function TravelGoDayComp:addEvents()
	self.addClickCb(self, self.btnChoice1, self.onClickBtnChoice1, self)
	self.addClickCb(self, self.btnChoice2, self.onClickBtnChoice2, self)
	self.addClickCb(self, self._btnNext, self.onClickBtnNext, self)
	self.addClickCb(self, self._btnFight, self.onClickBtnFight, self)
	self.addClickCb(self, self.btnSkill, self.onClickBtnSkill, self)
	self.addClickCb(self, self.btnCloseSkill, self.onClickBtnCloseSkill, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnDayChange, self.onDayChange, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnCreateDescItem, self.createDescItem, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnCreateSkillRewardItem, self.createSkillRewardItem, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnDayFinish, self.onDayFinish, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnStartStoryEvent, self.onStartStoryEvent, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnStartBattleEvent, self.onStartBattleEvent, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnBattleStart, self.onBattleStart, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnStartLuckEvent, self.onStartLuckEvent, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnLuckEventFinish, self.onLuckEventFinish, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnSkillChange, self.onSkillChange, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnGainReward, self.onGainReward, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnPlayerBornComplete, self.onPlayerBornComplete, self)
end

function TravelGoDayComp:onDestroy()
	self:killTween()

	if self.scrollTween then
		ZProj.TweenHelper.KillById(self.scrollTween)

		self.scrollTween = nil
	end
end

function TravelGoDayComp:onOpen()
	self:refreshSkill()

	for i, v in ipairs(self.items) do
		gohelper.destroy(v.viewGO)
	end

	self.items = {}

	for i, v in ipairs(self.skillItems) do
		gohelper.destroy(v.viewGO)
	end

	self.skillItems = {}
	self.isShowSkill = false

	gohelper.setActive(self.goSkill, false)
	gohelper.setActive(self.StoryEvent, false)
	gohelper.setActive(self.BattleEvent, false)
	gohelper.setActive(self.LuckEvent, false)
	self:setDetailShow(false)
	self.travelGoAttrComp:onOpen()
end

function TravelGoDayComp:onPlayerBornComplete()
	self:setDetailShow(true, true)
end

function TravelGoDayComp:onDayChange()
	gohelper.setActive(self._goNext, false)

	self._txtDays.text = GameUtil.getSubPlaceholderLuaLang(luaLang("TravelGoView_1"), {
		self.model.maxDay,
		self.model.day,
		self.model.maxDay
	})
	self.isFirstDescItem = true

	gohelper.setActive(self._godayrefresh, false)
	gohelper.setActive(self._godayrefresh, true)
end

function TravelGoDayComp:onDayFinish()
	if not self.controller.isSettle then
		gohelper.setActive(self._goNext, true)
		gohelper.setActive(self._btnNext, true)
		self._nextAnimatorPlayer:Play(UIAnimationName.Open)
	end
end

function TravelGoDayComp:onGainReward(rewardList)
	local item = self.items[#self.items]

	item:addRewardList(rewardList)
	ZProj.UGUIHelper.RebuildLayout(item.viewGO.transform)
	ZProj.UGUIHelper.RebuildLayout(self.Content.transform)
	self:moveScroll()
end

function TravelGoDayComp:onSkillChange(entity)
	local playerEntity = TravelGoController.instance.travelGoEntityMgr.playerEntity

	if entity.uid ~= playerEntity.uid then
		return
	end

	self:refreshSkill()
	gohelper.setActive(self.goSkillEff, false)
	gohelper.setActive(self.goSkillEff, true)
end

function TravelGoDayComp:onClickBtnSkill()
	local newIsShow = not self.isShowSkill

	if newIsShow and not self.skillList:haveData() then
		GameFacade.showToastString(luaLang("TravelGoDayComp_1"))

		return
	end

	gohelper.setActive(self.goSkill, newIsShow)

	if newIsShow then
		self.isShowSkill = true

		gohelper.setActive(self.btnCloseSkill, true)
		self._skillAnimatorPlayer:Play(UIAnimationName.Open)
	else
		self:onClickBtnCloseSkill()
	end
end

function TravelGoDayComp:onClickBtnCloseSkill()
	self.isShowSkill = false

	gohelper.setActive(self.btnCloseSkill, false)
	self._skillAnimatorPlayer:Play(UIAnimationName.Close, self._onCloseSkillPlayCloseFinished, self)
end

function TravelGoDayComp:_onCloseSkillPlayCloseFinished()
	gohelper.setActive(self.goSkill, false)
end

function TravelGoDayComp:refreshSkill()
	local oldHaveData = self.skillList:haveData()
	local playerEntity = TravelGoController.instance.travelGoEntityMgr.playerEntity
	local skills = playerEntity.skill.skills
	local data = {}

	for i, v in ipairs(skills) do
		if v.cfgId ~= TravelGoConst.UltimateSkillId and v.cfgId ~= TravelGoConst.FrozenSkillId then
			table.insert(data, v)
		end
	end

	self.skillList:setData(data)

	local newHaveData = self.skillList:haveData()

	gohelper.setActive(self._gobtnSkill, newHaveData)

	if not oldHaveData and newHaveData then
		self._btnSkillAnimator:Play(UIAnimationName.Open, 0, 0)
	end
end

function TravelGoDayComp:setDetailShow(isShow, isPlay)
	if isShow then
		gohelper.setActive(self._godetail, true)

		if isPlay then
			self._detailAnimatorPlayer:Play(UIAnimationName.Open)
		else
			self._detailAnimatorPlayer:Play(UIAnimationName.Idle)
		end
	elseif isPlay then
		self._detailAnimatorPlayer:Play(UIAnimationName.Close, self._onAfterPlayDetailColse, self)
	else
		self:_onAfterPlayDetailColse()
	end
end

function TravelGoDayComp:_onAfterPlayDetailColse()
	gohelper.setActive(self._godetail, false)
end

function TravelGoDayComp:createDescItem(data)
	local go = gohelper.clone(self.TravelGoDescItem, self.Content)

	gohelper.setActive(go, true)

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, TravelGoDescItem)

	if self.isFirstDescItem then
		data.day = TravelGoModel.instance.day
		self.isFirstDescItem = nil
	end

	item:setData(data)
	table.insert(self.items, item)
	ZProj.UGUIHelper.RebuildLayout(go.transform)
	ZProj.UGUIHelper.RebuildLayout(self.Content.transform)
	self:moveScroll()
end

function TravelGoDayComp:createSkillRewardItem(data)
	local go = gohelper.clone(self.TravelGoSkillRewardItem, self.Content)

	gohelper.setActive(go, true)

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, TravelGoSkillRewardItem)

	item:setData(data, self.onClickSkillRewardItem, self)
	table.insert(self.skillItems, item)
	ZProj.UGUIHelper.RebuildLayout(go.transform)
	ZProj.UGUIHelper.RebuildLayout(self.Content.transform)
	self:moveScroll()
end

function TravelGoDayComp:onClickSkillRewardItem(param)
	for i, v in ipairs(self.skillItems) do
		gohelper.destroy(v.viewGO)
	end

	tabletool.clear(self.skillItems)
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnSelectSkillReward, param)
end

function TravelGoDayComp:onStartStoryEvent()
	local travelGoEventMO = TravelGoModel.instance.travelGoEventMO

	gohelper.setActive(self.StoryEvent, true)
	gohelper.setActive(self.btnChoice1, true)
	gohelper.setActive(self.btnChoice2, true)
	self._storyEventBtnAnimatorPlayer1:Play(UIAnimationName.Open)
	self._storyEventBtnAnimatorPlayer2:Play(UIAnimationName.Open)
	self._storyEventAnimatorPlayer:Play(UIAnimationName.Open)

	self.textChoice1.text = travelGoEventMO:getStoryChoicePre(1)
	self.textChoice2.text = travelGoEventMO:getStoryChoicePre(2)

	local rewardList1 = travelGoEventMO:getChoiceRewards(1)
	local rewardList2 = travelGoEventMO:getChoiceRewards(2)
	local haveReward1 = rewardList1 and #rewardList1 > 0
	local haveReward2 = rewardList2 and #rewardList2 > 0

	gohelper.setActive(self.nodeChoice1, haveReward1)
	gohelper.setActive(self.nodeChoice2, haveReward2)

	self.textReward1.text = travelGoEventMO:getChoiceDesc(1)
	self.textReward2.text = travelGoEventMO:getChoiceDesc(2)
end

function TravelGoDayComp:onClickBtnChoice1()
	gohelper.setActive(self.btnChoice1, false)
	gohelper.setActive(self.btnChoice2, false)
	self._storyEventBtnAnimatorPlayer1:Play(UIAnimationName.Click, self._onStoryEventBtnPlayClickFinished, self, 1)
	self._storyEventBtnAnimatorPlayer2:Play(UIAnimationName.Close)
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_fuleyuan_diaoluo)
end

function TravelGoDayComp:onClickBtnChoice2()
	gohelper.setActive(self.btnChoice1, false)
	gohelper.setActive(self.btnChoice2, false)
	self._storyEventBtnAnimatorPlayer1:Play(UIAnimationName.Close)
	self._storyEventBtnAnimatorPlayer2:Play(UIAnimationName.Click, self._onStoryEventBtnPlayClickFinished, self, 2)
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_fuleyuan_diaoluo)
end

function TravelGoDayComp:_onStoryEventBtnPlayClickFinished(index)
	if not index then
		return
	end

	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnStoryEventSelect, index)
	self:finishStoryEvent()
end

function TravelGoDayComp:onClickBtnNext()
	gohelper.setActive(self._btnNext, false)
	self._nextAnimatorPlayer:Play(UIAnimationName.Click, self._onNextPlayClickFinished, self)
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_fuleyuan_diaoluo)
end

function TravelGoDayComp:_onNextPlayClickFinished()
	TravelGoController.instance:startNextDay()
end

function TravelGoDayComp:finishStoryEvent()
	self._storyEventAnimatorPlayer:Play(UIAnimationName.Close, self._onStoryEventPlayCloseFinished, self)
end

function TravelGoDayComp:_onStoryEventPlayCloseFinished()
	gohelper.setActive(self.StoryEvent, false)
end

function TravelGoDayComp:onStartBattleEvent()
	gohelper.setActive(self.BattleEvent, true)
	gohelper.setActive(self._btnFight, true)
	self._battleEventAnimatorPlayer:Play(UIAnimationName.Open)
end

function TravelGoDayComp:onBattleStart()
	gohelper.setActive(self.viewGO, false)
end

function TravelGoDayComp:onAfterBattleCompCloseShowDayComp()
	gohelper.setActive(self.BattleEvent, false)
	gohelper.setActive(self.viewGO, true)
	self._animatorPlayer:Play(UIAnimationName.Open)
	self:setDetailShow(true, true)

	self.scroll.verticalNormalizedPosition = 0
end

function TravelGoDayComp:onClickBtnFight()
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_fuleyuan_diaoluo)
	gohelper.setActive(self._btnFight, false)
	self._battleEventAnimatorPlayer:Play(UIAnimationName.Click, self._onBattleEventPlayClickFinished, self)
end

function TravelGoDayComp:_onBattleEventPlayClickFinished()
	self:setDetailShow(false, true)
	self._animatorPlayer:Play(UIAnimationName.Close, self._onPlayCloseFinished, self)

	if self.goView then
		self.goView:onClickBattleFight()
	end
end

function TravelGoDayComp:_onPlayCloseFinished()
	TravelGoController.instance:startBattle()
end

function TravelGoDayComp:onStartLuckEvent(luckEventType)
	gohelper.setActive(self.LuckEvent, true)

	if luckEventType == TravelGoEnum.LuckEventType.UnLuck then
		AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_yuanzheng_over)
		gohelper.setActive(self.LuckEvent1, true)
		gohelper.setActive(self.LuckEvent2, false)
		gohelper.setActive(self.LuckEvent3, false)

		self._curLuckEventAnimatorPlayer = self._luckEvent1AnimatorPlayer
	elseif luckEventType == TravelGoEnum.LuckEventType.LittleLuck then
		AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_lushang_karong_unlock)
		gohelper.setActive(self.LuckEvent1, false)
		gohelper.setActive(self.LuckEvent2, true)
		gohelper.setActive(self.LuckEvent3, false)

		self._curLuckEventAnimatorPlayer = self._luckEvent2AnimatorPlayer
	elseif luckEventType == TravelGoEnum.LuckEventType.VeryLuck then
		AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_diqiu_yure_success)
		gohelper.setActive(self.LuckEvent1, false)
		gohelper.setActive(self.LuckEvent2, false)
		gohelper.setActive(self.LuckEvent3, true)

		self._curLuckEventAnimatorPlayer = self._luckEvent3AnimatorPlayer
	end

	self._curLuckEventAnimatorPlayer:Play(UIAnimationName.Open)

	if self.scrollTween then
		ZProj.TweenHelper.KillById(self.scrollTween)

		self.scrollTween = nil
	end

	self.scrollTween = ZProj.TweenHelper.DOHeight(self.ScrollView.transform, 500, 0.15, self.setBottom, self, EaseType.Linear)
	self.scroll.verticalNormalizedPosition = 0
end

function TravelGoDayComp:onLuckEventFinish()
	if self._curLuckEventAnimatorPlayer then
		self._curLuckEventAnimatorPlayer:Play(UIAnimationName.Close, self._onLuckEventPlayCloseFinished, self)
	else
		self:_onLuckEventPlayCloseFinished()
	end

	self._curLuckEventAnimatorPlayer = nil
end

function TravelGoDayComp:_onLuckEventPlayCloseFinished()
	gohelper.setActive(self.LuckEvent, false)

	if self.scrollTween then
		ZProj.TweenHelper.KillById(self.scrollTween)

		self.scrollTween = nil
	end

	self.scrollTween = ZProj.TweenHelper.DOHeight(self.ScrollView.transform, self.defaultH, 0.15, self.setBottom, self, EaseType.Linear)
	self.scroll.verticalNormalizedPosition = 0
end

function TravelGoDayComp:setBottom()
	self.scroll.verticalNormalizedPosition = 0
end

function TravelGoDayComp:moveScroll()
	self:killTween()

	local originNormPos = self.scroll.verticalNormalizedPosition
	local newNormPos = 0

	if originNormPos ~= newNormPos then
		self.tweenMoveScroll = ZProj.TweenHelper.DOTweenFloat(originNormPos, newNormPos, 0.3, self.onTweenCategory, self.onTweenFinishCategory, self)
	end
end

function TravelGoDayComp:onTweenCategory(value)
	self.scroll.verticalNormalizedPosition = value
end

function TravelGoDayComp:onTweenFinishCategory()
	self:killTween()
end

function TravelGoDayComp:killTween()
	if self.tweenMoveScroll then
		ZProj.TweenHelper.KillById(self.tweenMoveScroll)

		self.tweenMoveScroll = nil
	end
end

return TravelGoDayComp
