-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazyPartnerMainView.lua

module("logic.extensions.crazypartner.view.CrazyPartnerMainView", package.seeall)

local CrazyPartnerMainView = class("CrazyPartnerMainView", ViewComponent)
local StoryKey = "20220429.CrazyPartnerMainView"
local SliderAnimKey = "20220429.CrazyPartnerMainView.SliderAnim"
local MainEffectPath = "20220513/baozouhuoban/fx_ui_baozouhuoban_jiemian2.prefab"

function CrazyPartnerMainView:ctor()
	CrazyPartnerMainView.super.ctor(self)
end

function CrazyPartnerMainView:unbindEvents()
	CrazyPartnerMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnStart)
end

function CrazyPartnerMainView:bindEvents()
	CrazyPartnerMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function CrazyPartnerMainView:buildUI()
	CrazyPartnerMainView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTask = self:getBtn("bottomleft/btnTask")
	self._btnRank = self:getBtn("bottomleft/btnRank")
	self._btnStart = self:getBtn("bottomright/btnStart")
	self._rewardScrollerRect = self:getScrollRect("bottom/reward/tableview")
	self._rewardScrollerRectTrans = self._rewardScrollerRect.gameObject:GetComponent(goutil.Type_RectTransform)
	self._rewardCell = self:getGo("bottom/reward/rewardcell")
	self._rewardContent = self:getGo("bottom/reward/tableview/viewport/content")
	self._rewardContentRectTrans = self._rewardContent:GetComponent(goutil.Type_RectTransform)
	self._sliderMask = self:getGo("bottom/reward/playerslidermask")
	self._rewardSilder = self:getSlider("bottom/reward/tableview/viewport/content/progressSlider")
	self._rewardSilderRectTrans = self._rewardSilder.gameObject:GetComponent(goutil.Type_RectTransform)
	self._txtScore = self:getTxt("bottom/txt/txtNumber")
	self._imgTaskRedPoint = self:getGo("bottomleft/btnTask/imgRedPoint")
	self._mainEffectGo = self:getGo("effect")
	self._cellBtns = {}
	self._cells = {}
	self._cellEffects = {}

	local px, py = Framework.TransformUtil.GetAnchoredPos(self._rewardSilderRectTrans, 0, 0)

	self._playerSliderStartOffset = py
	self._playerSliderEndOffset = 50
	self._playerWidthSpace = 150
	self._rewardScrollerRectWidth = self._rewardScrollerRectTrans.rect.width

	self._rewardCell:SetActive(false)
end

function CrazyPartnerMainView:onExit()
	CrazyPartnerMainView.super.onExit(self)
	self:_removeTween()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStageStoryEnded, self)

	local controller = CrazyPartnerController.instance

	controller:unregisterLocalNotify(CrazyPartnerController.AfterGetInfoResponse, self._updatePrizes, self)
	controller:unregisterLocalNotify(CrazyPartnerController.AfterGainPrizeResponse, self._updatePrizes, self)

	if self._cells then
		for _, cell in ipairs(self._cells) do
			goutil.destroy(cell)
		end

		self._cells = {}
	end

	if self._cellEffects then
		for container, effect in pairs(self._cellEffects) do
			self:_clearEffect(container)
		end

		self._cellEffects = {}
	end

	self:_removeMainEffect()
	RedPointController.instance:unregRedPoint(self._imgTaskRedPoint)
end

function CrazyPartnerMainView:onEnter()
	CrazyPartnerMainView.super.onEnter(self)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_CRAZY_PARTNER)

	self._nFirstEnter = 0

	local controller = CrazyPartnerController.instance

	controller:registerLocalNotify(CrazyPartnerController.AfterGetInfoResponse, self._updatePrizes, self)
	controller:registerLocalNotify(CrazyPartnerController.AfterGainPrizeResponse, self._updatePrizes, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onStageStoryEnded, self)

	self._activityId = CrazyPartnerModel.instance:getActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end

	self:_initPrizes()
	CrazyPartnerAgent.instance:sendPM_CrazyPartnerInfoReq()

	local isPlayed = GameUtil.getUserData(SliderAnimKey)

	self._isNeedPlaySliderAnim = not isPlayed

	self._sliderMask:SetActive(self._isNeedPlaySliderAnim)
	self:_setActivityTime()
	self:_tryPlayStory()
	self:_addMainEffect()
	RedPointController.instance:regRedPoint(self._imgTaskRedPoint, RedPointModel.ID_CRAZY_PARTNER_TASK)
end

function CrazyPartnerMainView:_setPlayerContentLength(rewardCount)
	local sliderLength = rewardCount * self._playerWidthSpace

	self._contentTotalLength = self._playerSliderStartOffset + sliderLength + self._playerSliderEndOffset

	goutil.setWidth(self._rewardContentRectTrans, self._contentTotalLength)
	goutil.setWidth(self._rewardSilderRectTrans, sliderLength)
end

function CrazyPartnerMainView:_initPrizes()
	table.clear(self._cells)

	local posX = self._playerSliderStartOffset
	local configs = CrazyPartnerConfig.instance:getPrizeConfs(self._activityId)
	local count = table.nums(configs)

	self:_setPlayerContentLength(count)

	self._pgValueSteps = {
		0
	}
	self._pbPercentSteps = {
		0
	}

	local percentStep = 1 / count

	for i = 1, count do
		local conf = configs[i]

		posX = posX + self._playerWidthSpace

		local go = self:_getPrizeGo(conf)

		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, 0)
		table.insert(self._cells, go)
		table.insert(self._pgValueSteps, conf.score)

		if i == count then
			table.insert(self._pbPercentSteps, 1)
		else
			table.insert(self._pbPercentSteps, percentStep * i)
		end
	end
end

function CrazyPartnerMainView:_getPrizeGo(data)
	local go = goutil.cloneAndSetParent(self._rewardCell, self._rewardContent.transform)
	local item = goutil.findChild(go, "item")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	MaterialMgr.resetAll(item)

	local proxy = MaterialMgr.setCellByCfg(data.gain, item)

	txtScore.text = data.score

	goutil.setActive(go, true)

	return go
end

function CrazyPartnerMainView:_updatePrizes()
	local configs = CrazyPartnerConfig.instance:getPrizeConfs(self._activityId)
	local count = table.nums(configs)
	local model = CrazyPartnerModel.instance

	self._canGainPrizeIndex = -1

	for i = 1, count do
		local cell = self._cells[i]
		local geted = goutil.findChild(cell, "geted")
		local canGet = goutil.findChild(cell, "canGet")
		local config = configs[i]

		self._cellBtns[i] = canGet

		self:_clearEffect(canGet)

		if model:isHasGainPrizeByIndex(i) then
			goutil.setActive(geted, true)
			goutil.setActive(canGet, false)
		elseif model:isCanGainPrizeByIndex(i) then
			goutil.setActive(canGet, true)
			GameUtil.asBtn(canGet):RemoveClickListener()
			GameUtil.asBtn(canGet):AddClickListener(function()
				CrazyPartnerController.instance:sendGainPrize(config.id)
				goutil.setActive(canGet, false)
			end, self)
			self:_playEffect(canGet)

			if self._canGainPrizeIndex == -1 then
				self._canGainPrizeIndex = i
			end
		else
			goutil.setActive(canGet, false)
		end
	end

	local curScore = model:getTotalScore() or 0

	self._txtScore.text = curScore

	GameUtil.setProgress(self._rewardSilder, curScore, self._pgValueSteps, self._pbPercentSteps)
	self:_tryJump2Prize()
end

function CrazyPartnerMainView:_playEffect(canGet)
	self:_clearEffect(canGet)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, canGet.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._rewardScrollerRectTrans) then
			eff:setClipping(self._rewardScrollerRectTrans)
		end
	end)

	uiEffect:setParent(canGet.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects[canGet] = uiEffect
end

function CrazyPartnerMainView:_clearEffect(canGet)
	if self._cellEffects[canGet] then
		UIEffectManager.instance:stopEffect(self._cellEffects[canGet])

		self._cellEffects[canGet] = nil
	end
end

function CrazyPartnerMainView:_tryPlayStory()
	local function doNext()
		self:_playSliderAnimation(GameUtil.handler(self._tryJump2Prize, self))
	end

	GameUtil.getUserData(StoryKey, function(value)
		if checknumber(value) == 0 then
			self:_playStory(doNext)
			GameUtil.saveUserData(StoryKey, 1)
		else
			doNext()
		end
	end)
end

function CrazyPartnerMainView:_playSliderAnimation(doneCallback)
	if self._isNeedPlaySliderAnim then
		local function onComplete()
			self._isNeedPlaySliderAnim = false

			self._sliderMask:SetActive(false)
			goutil.setActive(self._sliderMask, false)
			GameUtil.callBack(doneCallback)
		end

		GameUtil.saveUserData(SliderAnimKey, true)

		self._sequence = GameUtil.playSliderAnimation(self._rewardScrollerRect.scrollRect, onComplete)
	else
		GameUtil.callBack(doneCallback)
	end
end

function CrazyPartnerMainView:_removeTween()
	if self._sequence then
		self._sequence:Kill(false)

		self._sequence = nil
	end
end

function CrazyPartnerMainView:_tryJump2Prize()
	if self._nFirstEnter == 0 then
		self._nFirstEnter = 1
	elseif self._nFirstEnter == 1 then
		self._nFirstEnter = 2

		self:_jump2Prize()
	end
end

function CrazyPartnerMainView:_jump2Prize()
	if self._canGainPrizeIndex > 0 then
		local totalWidth = self._contentTotalLength - self._rewardScrollerRectWidth
		local endIndex = math.ceil(totalWidth / self._playerWidthSpace)
		local index = Mathf.Clamp(self._canGainPrizeIndex - 1, 0, endIndex)

		self._rewardScrollerRect.scrollRect.horizontalNormalizedPosition = (index + 0.5) / endIndex
	end
end

function CrazyPartnerMainView:_playStory(callback)
	local storyId = checknumber(CrazyPartnerConfig.instance:getCommonValue("STORY_ID"))

	self._storyCallback = callback
	self._storyId = storyId

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

function CrazyPartnerMainView:_onStageStoryEnded(storyId)
	if self._storyId == storyId and self._storyCallback then
		GameUtil.callBack(self._storyCallback)

		self._storyCallback = nil
	end
end

function CrazyPartnerMainView:_setActivityTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.CRAZY_PARTNER, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function CrazyPartnerMainView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function CrazyPartnerMainView:_addMainEffect()
	self:_removeMainEffect()

	local eff = UIEffectManager.instance:playEffect(self, MainEffectPath, self._mainEffectGo.transform, 0, 0, true)

	eff:setParent(self._mainEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainEffect = eff
end

function CrazyPartnerMainView:_onClickTip()
	local ruleKey = CrazyPartnerConfig.instance:getCommonValue("MAIN_RULE_KEY")

	UIStateManager.instance:push(ViewName.RulesView, ruleKey)
end

function CrazyPartnerMainView:_onClickTask()
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_CRAZY_PARTNER_TASK)
	UIStateManager.instance:push(ViewName.CrazyPartnerTaskView)
end

function CrazyPartnerMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.CrazyPartnerRankView)
end

function CrazyPartnerMainView:_onClickStart()
	UIStateManager.instance:push(ViewName.CrazyPartnerLevelView)
end

return CrazyPartnerMainView
