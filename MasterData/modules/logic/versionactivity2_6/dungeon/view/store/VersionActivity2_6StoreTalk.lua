-- chunkname: @modules/logic/versionactivity2_6/dungeon/view/store/VersionActivity2_6StoreTalk.lua

module("modules.logic.versionactivity2_6.dungeon.view.store.VersionActivity2_6StoreTalk", package.seeall)

local VersionActivity2_6StoreTalk = class("VersionActivity2_6StoreTalk", BaseView)

function VersionActivity2_6StoreTalk:onInitView()
	self._gostagearea = gohelper.findChild(self.viewGO, "#go_stagearea")
	self._imagechess = gohelper.findChildImage(self.viewGO, "Right/#chess/#image_chess")
	self._gochess = gohelper.findChild(self.viewGO, "Right/#chess")
	self._godot = gohelper.findChild(self.viewGO, "Right/vx_pot")
	self._goTalk = gohelper.findChild(self.viewGO, "Right/#go_talk")
	self._goArrowTip = gohelper.findChild(self.viewGO, "Right/#go_talk/#go_ArrowTips")
	self._scrollTalk = gohelper.findChildScrollRect(self.viewGO, "Right/#go_talk/Scroll View")
	self._txttalk = gohelper.findChildText(self.viewGO, "Right/#go_talk/Scroll View/Viewport/Content/#txt_talk")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_6StoreTalk:addEvents()
	return
end

function VersionActivity2_6StoreTalk:removeEvents()
	return
end

VersionActivity2_6StoreTalk.TalkMinTriggerDuration = 2
VersionActivity2_6StoreTalk.TalkStepShowDuration = 2
VersionActivity2_6StoreTalk.TalkTxtShowDuration = 6
VersionActivity2_6StoreTalk.TextSpawnInterval = 0.06
VersionActivity2_6StoreTalk.ChessJumpAnimDuration = 1.167
VersionActivity2_6StoreTalk.ChessOpenAnimDuration = 1.5
VersionActivity2_6StoreTalk.ScrollTalkMargin = 60
VersionActivity2_6StoreTalk.TextMaxHeight = 99999
VersionActivity2_6StoreTalk.TipHeight = 10
VersionActivity2_6StoreTalk.SplitChar = "|"

function VersionActivity2_6StoreTalk:onClickStage()
	AudioMgr.instance:trigger(AudioEnum2_6.VersionActivity2_6Store.play_ui_jinye_click_stage)
	self:triggerTalkByType(ActivityStoreConfig.BubbleTalkTriggerType.ClickStageArea)
end

function VersionActivity2_6StoreTalk:onClickText()
	if self.waitFinishTalk then
		return
	end

	if self.waitPlayNextStep then
		TaskDispatcher.cancelTask(self.playNextStep, self)
		self:playNextStep()

		return
	end

	if self.start then
		self.currentCharIndex = self.contentLen

		self:_tickContent()
	end
end

function VersionActivity2_6StoreTalk:_editableInitView()
	self._hasOpen = false
	self._scrollTalk.verticalNormalizedPosition = 1
	self.lastTriggerTime = -VersionActivity2_6StoreTalk.TalkMinTriggerDuration
	self.canTriggerList = {}
	self.tempTypeList = {}
	self.triggerStepList = {}
	self.actId = VersionActivity2_6Enum.ActivityId.DungeonStore
	self.stageClick = gohelper.getClickWithDefaultAudio(self._gostagearea)

	self.stageClick:AddClickListener(self.onClickStage, self)

	self.talkTextClick = gohelper.getClickWithDefaultAudio(self._goTalk)

	self.talkTextClick:AddClickListener(self.onClickText, self)

	self.rectTrTalk = self._goTalk:GetComponent(gohelper.Type_RectTransform)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "Right/#go_talk/Scroll View/Viewport/Content", gohelper.Type_RectTransform)
	self.chessAnim = self._gochess:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._godot, false)
	gohelper.setActive(self._goTalk, false)
	gohelper.setActive(self._goArrowTip, false)
	self:initUpdateBeat()
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self, LuaEventSystem.Low)
end

function VersionActivity2_6StoreTalk:initUpdateBeat()
	self.updateHandle = UpdateBeat:CreateListener(self._onFrame, self)

	UpdateBeat:AddListener(self.updateHandle)

	self.lateUpdateHandle = LateUpdateBeat:CreateListener(self._onFrameLateUpdate, self)

	LateUpdateBeat:AddListener(self.lateUpdateHandle)
end

function VersionActivity2_6StoreTalk:_onFrameLateUpdate()
	if self.closed then
		return
	end

	if not self.start then
		return
	end

	if self.needSetVerticalNormalized then
		self._scrollTalk.verticalNormalizedPosition = 0
		self.needSetVerticalNormalized = false
	end

	if not self.isDirty then
		return
	end

	self.isDirty = false
	self.needSetVerticalNormalized = true

	local preferHeight = self._txttalk.preferredHeight
	local margin = VersionActivity2_6StoreTalk.ScrollTalkMargin
	local talkHeight = preferHeight > VersionActivity2_6StoreTalk.TextMaxHeight and VersionActivity2_6StoreTalk.TextMaxHeight + margin or preferHeight + margin

	if self.waitPlayNextStep then
		talkHeight = talkHeight + VersionActivity2_6StoreTalk.TipHeight
	end

	recthelper.setHeight(self.rectTrTalk, talkHeight)
end

function VersionActivity2_6StoreTalk:_onFrame()
	if self.closed then
		return
	end

	if not self.start then
		return
	end

	if self.waitPlayNextStep or self.waitFinishTalk then
		return
	end

	local currentTime = Time.time

	if currentTime - self.lastSpawnTime < VersionActivity2_6StoreTalk.TextSpawnInterval then
		return
	end

	self:_tickContent()
end

function VersionActivity2_6StoreTalk:_tickContent()
	if self.closed then
		return
	end

	self.lastSpawnTime = Time.time
	self.currentCharIndex = self.currentCharIndex + 1

	local curChar = utf8.sub(self.content, self.currentCharIndex - 1, self.currentCharIndex)

	if curChar == "<" then
		local checkRichText = utf8.sub(self.content, self.currentCharIndex - 1, self.currentCharIndex + 2)

		if checkRichText == "<i>" then
			self.currentCharIndex = self.currentCharIndex + 3
		end

		local checkRichText2 = utf8.sub(self.content, self.currentCharIndex - 1, self.currentCharIndex + 3)

		if checkRichText2 == "</i>" then
			self.currentCharIndex = self.currentCharIndex + 4
		end
	end

	self._txttalk.text = utf8.sub(self.content, 1, self.currentCharIndex)
	self.isDirty = true

	if self.currentCharIndex == self.contentLen + 1 then
		local nextStepCo = self.triggerStepList[self.currentStepIndex + 1]

		if nextStepCo then
			self:startWaitPlayNextStep()
			TaskDispatcher.runDelay(self.playNextStep, self, VersionActivity2_6StoreTalk.TalkStepShowDuration)
		else
			self:startWaitFinishTalk()
			TaskDispatcher.runDelay(self.onFinishTalk, self, VersionActivity2_6StoreTalk.TalkTxtShowDuration)
		end
	end
end

function VersionActivity2_6StoreTalk:startWaitFinishTalk()
	self.waitFinishTalk = true
end

function VersionActivity2_6StoreTalk:startWaitPlayNextStep()
	self.waitPlayNextStep = true

	gohelper.setActive(self._goArrowTip, true)
end

function VersionActivity2_6StoreTalk:onFinishTalk()
	if self._scrollTalk then
		self._scrollTalk.verticalNormalizedPosition = 0
	end

	self.lastSpawnTime = nil
	self.currentCharIndex = nil
	self.currentStepIndex = nil
	self.content = nil
	self.start = false
	self.waitFinishTalk = false

	gohelper.setActive(self._goTalk, false)
end

function VersionActivity2_6StoreTalk:playNextStep()
	self:playStep(self.currentStepIndex + 1)

	self.waitPlayNextStep = false

	gohelper.setActive(self._goArrowTip, false)
end

function VersionActivity2_6StoreTalk:onCloseViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	if not self.buyGoodsId then
		return
	end

	tabletool.clear(self.tempTypeList)
	table.insert(self.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.BuyGoodsByRare)
	table.insert(self.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.BuyGoodsById)

	local goodsCo = lua_activity107.configDict[self.actId][self.buyGoodsId]

	if goodsCo.maxBuyCount ~= 0 then
		local remainBuyCount = goodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(self.actId, goodsCo.id)

		if remainBuyCount < 1 then
			table.insert(self.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.SellOutGoodsByRare)
			table.insert(self.tempTypeList, ActivityStoreConfig.BubbleTalkTriggerType.SellOutGoodsById)
		end
	end

	self:triggerTalkByTypeList(self.tempTypeList, self.buyGoodsId)

	self.buyGoodsId = nil
end

function VersionActivity2_6StoreTalk:onBuyGoodsSuccess(actId, goodsId)
	if self.actId ~= actId then
		return
	end

	self.buyGoodsId = goodsId
end

function VersionActivity2_6StoreTalk:onOpen()
	self:initGroupCo()
	TaskDispatcher.runDelay(self._triggerEnterAudio, self, 0.5)
end

function VersionActivity2_6StoreTalk:_triggerEnterAudio()
	AudioMgr.instance:trigger(AudioEnum2_6.VersionActivity2_6Store.play_ui_jinye_chess_enter)
end

function VersionActivity2_6StoreTalk:onOpenFinish()
	if self.isFirstEnter then
		self:triggerTalkByType(ActivityStoreConfig.BubbleTalkTriggerType.FirstEnterActivityStore)

		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version2_6PlayedStoreGroupIdKey)
		local preValue = PlayerPrefsHelper.getString(key, "")
		local idList = string.splitToNumber(preValue, VersionActivity2_6StoreTalk.SplitChar)

		table.insert(idList, self.groupCo.groupId)
		PlayerPrefsHelper.setString(key, table.concat(idList, VersionActivity2_6StoreTalk.SplitChar))
	else
		self:triggerTalkByType(ActivityStoreConfig.BubbleTalkTriggerType.EnterActivityStore)
	end
end

function VersionActivity2_6StoreTalk:initGroupCo()
	local groupList = ActivityStoreConfig.instance:getUnlockGroupList(self.actId)
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version2_6PlayedStoreGroupIdKey)
	local groupIdList = {}

	for _, v in ipairs(string.split(PlayerPrefsHelper.getString(key, ""), VersionActivity2_6StoreTalk.SplitChar)) do
		local value = tonumber(v)

		table.insert(groupIdList, value)
	end

	local len = #groupList

	for i = len, 1, -1 do
		local groupCo = groupList[i]

		if not tabletool.indexOf(groupIdList, groupCo.groupId) then
			self.isFirstEnter = true
			self.groupCo = groupCo
			self.talkCoList = ActivityStoreConfig.instance:getGroupTalkCoList(self.groupCo.groupId)

			return
		end
	end

	self.isFirstEnter = false

	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	self.groupCo = groupList[math.random(len)]
	self.talkCoList = ActivityStoreConfig.instance:getGroupTalkCoList(self.groupCo.groupId)
end

function VersionActivity2_6StoreTalk:triggerTalkByTypeList(typeList, typeParam)
	local maxPriority = ActivityStoreConfig.BubbleTalkTriggerType.None

	tabletool.clear(self.canTriggerList)

	for _, talkCo in ipairs(self.talkCoList) do
		if tabletool.indexOf(typeList, talkCo.triggerType) and ActivityStoreConfig.instance:checkTalkCanTrigger(self.actId, talkCo, typeParam) then
			table.insert(self.canTriggerList, talkCo)

			if maxPriority < talkCo.triggerType then
				maxPriority = talkCo.triggerType
			end
		end
	end

	for i = #self.canTriggerList, 1, -1 do
		local talkCo = self.canTriggerList[i]

		if talkCo.triggerType ~= maxPriority then
			GameUtil.tabletool_fastRemoveValueByPos(self.canTriggerList, i)
		end
	end

	local count = #self.canTriggerList

	if count < 1 then
		return
	end

	self:_triggerTalk(self:getRandomTalkCo(self.canTriggerList))
end

function VersionActivity2_6StoreTalk:triggerTalkByType(type, typeParam)
	tabletool.clear(self.canTriggerList)

	for _, talkCo in ipairs(self.talkCoList) do
		if type == talkCo.triggerType and ActivityStoreConfig.instance:checkTalkCanTrigger(self.actId, talkCo, typeParam) then
			table.insert(self.canTriggerList, talkCo)
		end
	end

	local count = #self.canTriggerList

	if count < 1 then
		return
	end

	TaskDispatcher.cancelTask(self._checkTriggerTalk, self)

	if not self._hasOpen then
		self._hasOpen = true

		self.chessAnim:Play("open", 0, 0)
		TaskDispatcher.runDelay(self._checkTriggerTalk, self, VersionActivity2_6StoreTalk.ChessOpenAnimDuration)
	else
		self:_checkTriggerTalk()
	end
end

function VersionActivity2_6StoreTalk:_checkTriggerTalk()
	self:_triggerTalk(self:getRandomTalkCo(self.canTriggerList))
end

function VersionActivity2_6StoreTalk:getRandomTalkCo(coList)
	local count = #coList

	if count == 1 then
		return coList[1]
	end

	local totalWeight = 0

	for _, talkCo in ipairs(coList) do
		totalWeight = totalWeight + talkCo.weight
	end

	local randomWeight = math.random(totalWeight)
	local compareWeight = 0

	for _, talkCo in ipairs(coList) do
		compareWeight = compareWeight + talkCo.weight

		if randomWeight <= compareWeight then
			return talkCo
		end
	end

	return coList[count]
end

function VersionActivity2_6StoreTalk:_triggerTalk(talkCo)
	local currentTime = Time.time

	if currentTime - self.lastTriggerTime < VersionActivity2_6StoreTalk.TalkMinTriggerDuration then
		return
	end

	self:buildStepCoList(talkCo)
	TaskDispatcher.cancelTask(self.playNextStep, self)
	TaskDispatcher.cancelTask(self.onFinishTalk, self)
	gohelper.setActive(self._goTalk, true)
	gohelper.setActive(self._goArrowTip, false)

	self._txttalk.text = ""
	self.lastTriggerTime = currentTime
	self.lastSpawnTime = currentTime - VersionActivity2_6StoreTalk.TextSpawnInterval

	self:playStep(1)

	self.start = true
	self.waitFinishTalk = false
	self.waitPlayNextStep = false
end

function VersionActivity2_6StoreTalk:playStep(stepIndex)
	local stepCo = self.triggerStepList[stepIndex]

	if not stepCo then
		return
	end

	TaskDispatcher.cancelTask(self.stopChessAnim, self)
	TaskDispatcher.runRepeat(self.stopChessAnim, self, VersionActivity2_6StoreTalk.ChessJumpAnimDuration)
	self.chessAnim:Play("jump")
	gohelper.setActive(self._godot, true)

	self.currentCharIndex = 1
	self.currentStepIndex = stepIndex
	self.content = stepCo.content
	self.contentLen = utf8.len(self.content)

	AudioMgr.instance:trigger(AudioEnum2_6.VersionActivity2_6Store.play_ui_jinye_chess_talk)
end

function VersionActivity2_6StoreTalk:buildStepCoList(talkCo)
	tabletool.clear(self.triggerStepList)

	local stepDict = lua_activity107_bubble_talk_step.configDict[talkCo.id]

	for _, stepCo in pairs(stepDict) do
		table.insert(self.triggerStepList, stepCo)
	end

	if #self.triggerStepList > 1 then
		table.sort(self.triggerStepList, VersionActivity2_6StoreTalk.sortStep)
	end
end

function VersionActivity2_6StoreTalk:stopChessAnim()
	if self.waitPlayNextStep or self.waitFinishTalk then
		self.chessAnim:Play("idle")
		gohelper.setActive(self._godot, false)
		TaskDispatcher.cancelTask(self.stopChessAnim, self)
	end
end

function VersionActivity2_6StoreTalk:onClose()
	TaskDispatcher.cancelTask(self.stopChessAnim, self)
	TaskDispatcher.cancelTask(self.playNextStep, self)
	TaskDispatcher.cancelTask(self.onFinishTalk, self)
	AudioMgr.instance:trigger(AudioEnum2_6.VersionActivity2_6Store.stop_ui_jinye_chess_talk)
	TaskDispatcher.cancelTask(self._triggerEnterAudio, self)

	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end

	if self.lateUpdateHandle then
		LateUpdateBeat:RemoveListener(self.lateUpdateHandle)
	end

	self.closed = true
end

function VersionActivity2_6StoreTalk:onDestroyView()
	TaskDispatcher.cancelTask(self._checkTriggerTalk, self)
	self.stageClick:RemoveClickListener()
	self.talkTextClick:RemoveClickListener()
end

function VersionActivity2_6StoreTalk.sortStep(co1, co2)
	return co1.step < co2.step
end

return VersionActivity2_6StoreTalk
