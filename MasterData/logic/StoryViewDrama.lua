-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewDrama.lua

module("logic.extensions.story.view.story.StoryViewDrama", package.seeall)

local StoryViewDrama = class("StoryViewDrama", StoryViewComponent)

function StoryViewDrama:ctor(view, mainGO, uicamera)
	self._uiCamera = uicamera
	self._isShowDrama = false
	self._curWriteSpeed = 1
	self._speedBase = 0.03
	self._speedCfg = {
		1,
		1.5,
		2
	}

	StoryViewDrama.super.ctor(self, view, mainGO)

	self._forceComTypeWriter = nil
end

function StoryViewDrama:_buildUI()
	StoryViewDrama.super._buildUI(self)

	self._shakeNode = goutil.findChild(self.mainGO, "story/shakeNode"):GetComponent(UnityTweensType.UITweenShake)

	self:_initDramaModels()
	self:_initDramaTypes()
	self:_initRightTop()
	self:_initHistory()

	self._clickMask = goutil.findChild(self.mainGO, "story/Panel")

	if self._clickMask then
		Framework.UIClickTrigger.Get(self._clickMask):AddClickListener(self._onClickMask, self, nil)
	end

	self:updateWriterSpeed()
	self:updateDrama()
end

function StoryViewDrama:_initRightTop()
	self._rightTop = goutil.findChild(self.mainGO, "rightTop")

	if not self._rightTop then
		return
	end

	self._jumpBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "rightTop/Drama/PassNode")
	self._autoPlayBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "rightTop/Drama/AutoPlay")
	self._stopAutoPlayBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "rightTop/Drama/StopAutoPlay")
	self._hideHudBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "rightTop/Drama/HideHud")
	self._historyStoryBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "rightTop/Drama/HistoryStory")
	self._autoPlayingText = goutil.findChild(self.mainGO, "rightTop/Drama/StopAutoPlay/Text"):GetComponent("Text")
	self._currAutoPlayIndex = 0
	self._rightTopCanvas = self._rightTop:GetComponent("CanvasGroup")
	self._hideJumpAndContinue = self._rightTopCanvas.alpha < 0.5
	self._drama = goutil.findChild(self.mainGO, "rightTop/Drama")
	self._btnHideDrama = goutil.findChild(self.mainGO, "rightTop/btnHideDrama")
	self._btnShowDrama = goutil.findChild(self.mainGO, "rightTop/btnShowDrama")
	self._btnSpeed = goutil.findChild(self.mainGO, "rightTop/Drama/btnSpeed")
	self._txtSpeed = goutil.findChildTextComponent(self.mainGO, "rightTop/Drama/btnSpeed/txtSpeed")
end

function StoryViewDrama:_initHistory()
	local history = goutil.findChild(self.mainGO, "history")

	if not history then
		return
	end

	self._historyTableView = goutil.findChildComponent(self.mainGO, "history/sv_info", "UITableview")
	self._historyCell = goutil.findChild(self.mainGO, "history/sv_cell")

	if self._historyTableView ~= nil then
		self._historyTableView:RegisterCallback(self._historyNumInView, self._historyCellSize, self._historyCellAtIndex, self)
		self._historyTableView:RegisterUpdateCellCallback(self._updateHistoryCell)
		self._historyTableView:RegisterReloadFinishCallback(self._onHistoryReloadFinish)
	end
end

function StoryViewDrama:_initDramaModels()
	self._viewModels = {}

	local leftCharactor = goutil.findChild(self.mainGO, "story/Spines/left")
	local rightCharactor = goutil.findChild(self.mainGO, "story/Spines/right")
	local middleCharactor = goutil.findChild(self.mainGO, "story/Spines/middle")
	local bigImgLeft = goutil.findChild(self.mainGO, "story/Images/left")
	local bigImgRight = goutil.findChild(self.mainGO, "story/Images/right")
	local bigImgMiddle = goutil.findChild(self.mainGO, "story/Images/middle")
	local camera = goutil.findChild(self.mainGO, "story/Spines/Camera"):GetComponent("Camera")
	local leftNpcIcon = goutil.findChild(self.mainGO, "story/npcIcons/left")
	local rightNpcIcon = goutil.findChild(self.mainGO, "story/npcIcons/right")

	self._viewModels[StoryConst.DirLeft] = StotyModelCtrl.New(StoryConst.DirLeft, leftCharactor, bigImgLeft, camera, self._uiCamera)
	self._viewModels[StoryConst.DirRight] = StotyModelCtrl.New(StoryConst.DirRight, rightCharactor, bigImgRight, camera, self._uiCamera)
	self._viewModels[StoryConst.DirMiddle] = StotyModelCtrl.New(StoryConst.DirMiddle, middleCharactor, bigImgMiddle, camera, self._uiCamera)
	self._npcIcons = {}
	self._npcIcons[StoryConst.DirLeft] = StoryNpcIconView.New(StoryConst.DirLeft, leftNpcIcon)
	self._npcIcons[StoryConst.DirRight] = StoryNpcIconView.New(StoryConst.DirRight, rightNpcIcon)
	self._npcIcons[StoryConst.DirMiddle] = StoryNpcIconView.New(StoryConst.DirMiddle)
end

function StoryViewDrama:_initDramaTypes()
	self._types = {}

	local types = goutil.findChild(self.mainGO, "story/shakeNode/types")
	local tf = types.transform
	local cnt = tf.childCount

	for i = 1, cnt do
		local go = tf:GetChild(i - 1).gameObject

		self._types[i] = {}
		self._types[i].go = go
		self._types[i].name = goutil.findChildTextComponent(go, "Name")
		self._types[i].nameBg = goutil.findChildTextComponent(go, "NameBg")
		self._types[i].text = goutil.findChildTextComponent(go, "Text")
		self._types[i].typeWriter = self._types[i].text.gameObject:GetComponent("TypewriterNew")
	end
end

function StoryViewDrama:onEnter()
	StoryViewDrama.super.onEnter(self)
	self.mainGO:SetActive(false)
	self:_enableTypewritersListener(true)

	if self._rightTopCanvas then
		self._rightTopCanvas.alpha = 1
	end

	for k, v in pairs(self._viewModels) do
		v:onEnter()
	end

	for k, v in pairs(self._npcIcons) do
		v:onEnter()
	end

	if self._jumpBtn then
		self._jumpBtn:AddClickListener(self._onClickJumpButton, self)
	end

	if self._autoPlayBtn then
		self._autoPlayBtn:AddClickListener(self._onClickAutoPlay, self)
	end

	if self._stopAutoPlayBtn then
		self._stopAutoPlayBtn:AddClickListener(self._onClickStopAutoPlay, self)
	end

	if self._hideHudBtn then
		self._hideHudBtn:AddClickListener(self._onClickHideHud, self)
	end

	if self._historyStoryBtn then
		self._historyStoryBtn:AddClickListener(self._onClickHistory, self)
	end

	GameUtil.addClickHandler(self._btnHideDrama, self._onClickHideDrama, self)
	GameUtil.addClickHandler(self._btnShowDrama, self._onClickShowDrama, self)
	GameUtil.addClickHandler(self._btnSpeed, self._onClickSpeed, self)

	self._historyStory = {}
end

function StoryViewDrama:prepareStory(currStory, finishCallback, finishCallbackTarget)
	self._currStory = currStory
	self._prepareCallback = finishCallback
	self._prepareCallbackTarget = finishCallbackTarget

	local currStoryConfig = StoryConst.getStoryModelConfig(self._currStory)

	self._storyCfgs = {}
	self._modelsCfg = {}

	table.insert(self._storyCfgs, self._currStory)
	table.insert(self._modelsCfg, currStoryConfig)

	if self._currStory.extModels and self._currStory.extModels ~= "" then
		local extModels = self._currStory.extModels

		for i = 1, #extModels do
			local storyConfig = StoryConst.getStoryModelConfig(extModels[i])

			table.insert(self._storyCfgs, extModels[i])
			table.insert(self._modelsCfg, storyConfig)
		end
	end

	if not string.nilorempty(self._currStory.npcIcon) then
		if self._npcIconRes and self._npcIconRes[self._currStory.npcIcon] then
			self:_onStoryResourcesLoaded()
		else
			self._npcIconPath = self._currStory.npcIcon

			if not string.find(self._npcIconPath, ".png") then
				self._npcIconPath = self._npcIconPath .. ".png"
			end

			self._loadingNpcIcon = true

			getres(StoryConst.StoryPath_NpcIconImgBg .. self._npcIconPath, self._onNpcIconLoaded, self)
		end
	else
		self:_onStoryResourcesLoaded()
	end
end

function StoryViewDrama:_onNpcIconLoaded(res)
	self._npcIconRes = self._npcIconRes or {}
	self._npcIconRes[self._currStory.npcIcon] = res

	res:Retain()
	self:_onStoryResourcesLoaded()
end

function StoryViewDrama:_onStoryResourcesLoaded()
	self._loadingNpcIcon = nil
	self._npcIconPath = nil

	if self._prepareCallback then
		if self._prepareCallbackTarget then
			self._prepareCallback(self._prepareCallbackTarget)
		else
			self._prepareCallback()
		end
	end
end

function StoryViewDrama:startStory(currStory)
	self:enabledClickMask(true)

	self._currTypeId = self._currStory.bg + 1
	self._isFinished = nil

	self:_showStory()
end

function StoryViewDrama:isCurStoryUnpassable()
	local time = 0

	if self._currStory then
		time = StoryController.instance:getTimeFinishStory(self._currStory.id)
	end

	return self._currStory and self._currStory.unpassable and time <= 0
end

function StoryViewDrama:_updateLeftTopIconPos()
	if self:isCurStoryUnpassable() then
		if self._jumpBtn then
			self._jumpBtn.gameObject:SetActive(false)
		end

		local btnSpeedOffset = 0

		if self._btnSpeed then
			Framework.TransformUtil.SetLocalPos(self._btnSpeed.transform, -100, -48, 0)

			btnSpeedOffset = -85
		end

		if self._autoPlayBtn then
			Framework.TransformUtil.SetLocalPos(self._autoPlayBtn.transform, -100 + btnSpeedOffset, -48, 0)
		end

		if self._stopAutoPlayBtn then
			Framework.TransformUtil.SetLocalPos(self._stopAutoPlayBtn.transform, -157 + btnSpeedOffset, -48, 0)
		end

		local offset = 0

		if self._stopAutoPlayBtn and self._stopAutoPlayBtn.gameObject.activeSelf then
			offset = -100
		end

		if self._hideHudBtn then
			Framework.TransformUtil.SetLocalPos(self._hideHudBtn.transform, -185 + offset + btnSpeedOffset, -48, 0)
		end

		if self._historyStoryBtn then
			Framework.TransformUtil.SetLocalPos(self._historyStoryBtn.transform, -270 + offset + btnSpeedOffset, -48, 0)
		end
	else
		if self._jumpBtn then
			self._jumpBtn.gameObject:SetActive(true)
		end

		local btnSpeedOffset = 0

		if self._btnSpeed then
			Framework.TransformUtil.SetLocalPos(self._btnSpeed.transform, -185, -48, 0)

			btnSpeedOffset = -85
		end

		if self._autoPlayBtn then
			Framework.TransformUtil.SetLocalPos(self._autoPlayBtn.transform, -185 + btnSpeedOffset, -48, 0)
		end

		if self._stopAutoPlayBtn then
			Framework.TransformUtil.SetLocalPos(self._stopAutoPlayBtn.transform, -242 + btnSpeedOffset, -48, 0)
		end

		local offset = 0

		if self._stopAutoPlayBtn and self._stopAutoPlayBtn.gameObject.activeSelf then
			offset = -100
		end

		if self._hideHudBtn then
			Framework.TransformUtil.SetLocalPos(self._hideHudBtn.transform, -270 + offset + btnSpeedOffset, -48, 0)
		end

		if self._historyStoryBtn then
			Framework.TransformUtil.SetLocalPos(self._historyStoryBtn.transform, -355 + offset + btnSpeedOffset, -48, 0)
		end
	end
end

function StoryViewDrama:_finishCurrStory()
	self._storyCfgs = nil
	self._modelsCfg = nil
	self._currStory = nil
	self._currTypeId = nil
	self._prepareCallback = nil
	self._prepareCallbackTarget = nil

	removetimer(self._onTimerCallback, self)

	self._isPause = nil
	self._isFinished = true

	self:enabledClickMask(false)
end

function StoryViewDrama:startFadeIn()
	StoryViewDrama.super.startFadeIn(self)

	if self._autoPlaying then
		self:startAutoPlay()
	else
		self:stopAutoPlay()
	end
end

function StoryViewDrama:startFadeOut(handler, tgt)
	StoryViewDrama.super.startFadeOut(self, handler, tgt)

	for k, v in pairs(self._viewModels) do
		v:hideObject()
		v:clearObjects(false)
	end
end

function StoryViewDrama:endStory()
	self:_finishCurrStory()
end

function StoryViewDrama:onSceneLoadedStart()
	if not SceneMgr.instance:isTransitionFade() then
		for k, v in pairs(self._viewModels) do
			v:hideObject()
			v:clearObjects(false)
		end
	end

	self.mainGO:SetActive(true)

	self._autoPlayState = self._autoPlaying

	self:stopAutoPlay()
end

function StoryViewDrama:onSceneLoadedFinish()
	if self._autoPlayState then
		self:startAutoPlay()

		self._autoPlayState = nil
	end
end

function StoryViewDrama:enabledClickMask(enabled)
	if self._clickMask then
		self._clickMask:SetActive(enabled)
	end
end

function StoryViewDrama:hideJumpAndContinue(hide)
	if self._hideJumpAndContinue ~= hide then
		self._hideJumpAndContinue = hide

		if self._rightTop then
			UnityTweens.UITweenFadeTo.StopTween(self._rightTop)

			if hide then
				UnityTweens.UITweenFadeTo.StartTween(self._rightTop, 0, GlobalModel.UIFadeTime, UnityTweens.EaseType.easeOutSine)
			else
				UnityTweens.UITweenFadeTo.StartTween(self._rightTop, 1, GlobalModel.UIFadeTime, UnityTweens.EaseType.easeOutSine)
			end
		end
	end
end

function StoryViewDrama:pause()
	self._isPause = true

	removetimer(self._onTimerCallback, self)
end

function StoryViewDrama:resume()
	self._isPause = nil

	self:_startAutoPlay()
end

function StoryViewDrama:isLoadingRes()
	if self._loadingNpcIcon then
		return true
	end

	for k, v in pairs(self._viewModels) do
		if v:isLoadingRes() then
			return true
		end
	end

	for k, v in pairs(self._npcIcons) do
		if v:isLoadingRes() then
			return true
		end
	end
end

function StoryViewDrama:beginFadeOut(handler, tgt)
	for k, v in pairs(self._viewModels) do
		v:clearObjects()
	end

	self:startFadeOut(handler, tgt)
end

function StoryViewDrama:startAutoPlay()
	if self._autoPlaying then
		return
	end

	self._autoPlaying = true

	removetimer(self._onTimerCallback, self)
	self:_startAutoPlay()
	self:_initAutoPlayingTips()
	removetimer(self._tickAutoPlaying, self)
	settimer(0.5, self._tickAutoPlaying, self)
	self._autoPlayBtn.gameObject:SetActive(false)
	self._stopAutoPlayBtn.gameObject:SetActive(true)
	self:_updateLeftTopIconPos()
end

function StoryViewDrama:finishStory(op, opParams)
	self._isPause = nil

	self:_finishCurrStory()
	self._view:finishCurrStory(op, opParams)
end

function StoryViewDrama:setClickMask(clickMask)
	self._clickMask = clickMask

	if self._clickMask then
		Framework.UIClickTrigger.Get(self._clickMask):AddClickListener(self._onClickMask, self, nil)
	end
end

function StoryViewDrama:onExit()
	if self._npcIconPath then
		removeresl(self._npcIconPath, self._onNpcIconLoaded, self)

		self._npcIconPath = nil
	end

	if self._npcIconRes then
		for k, v in pairs(self._npcIconRes) do
			v:Release()
		end

		self._npcIconRes = nil
	end

	StoryViewDrama.super.onExit(self)
	removetimer(self._onTimerCallback, self)
	self:_enableTypewritersListener()

	self._currStory = nil
	self._forceComTypeWriter = nil
	self._currTypeId = nil
	self._isPause = nil
	self._historyStory = nil
	self._storyCfgs = nil
	self._modelsCfg = nil

	if self._rightTop then
		UnityTweens.UITweenFadeTo.StopTween(self._rightTop)
	end

	self._autoPlayingTips = nil
	self._autoPlayState = nil
	self._currAutoPlayIndex = nil

	removetimer(self._tickAutoPlaying, self)
	removetimer(self._hideHud, self)
	removetimer(self._recoveryHud, self)

	if self._jumpBtn then
		self._jumpBtn:RemoveClickListener()
	end

	if self._autoPlayBtn then
		self._autoPlayBtn:RemoveClickListener()
	end

	if self._stopAutoPlayBtn then
		self._stopAutoPlayBtn:RemoveClickListener()
	end

	if self._hideHudBtn then
		self._hideHudBtn:RemoveClickListener()
	end

	GameUtil.rmClickHandler(self._btnHideDrama)
	GameUtil.rmClickHandler(self._btnShowDrama)
	GameUtil.rmClickHandler(self._btnSpeed)
	self._shakeNode:Stop()

	for k, v in pairs(self._viewModels) do
		v:onExit()
	end

	for k, v in pairs(self._npcIcons) do
		v:onExit()
	end
end

function StoryViewDrama:_showStory()
	self:_showStoryConfig()
	self:_showDramaType()
	self:_showText()
	self:_checkShake()
	self:_showName()
	self:_playSound()
	self:_updateLeftTopIconPos()
	self:hideJumpAndContinue(false)
end

function StoryViewDrama:_enableTypewritersListener(enable)
	for k, v in pairs(self._types) do
		if v.typeWriter then
			if enable then
				v.typeWriter:AddEventHandler(self._onTypeWriterFinish, self)
			else
				v.typeWriter:RemoveEventHandler()
			end
		end
	end
end

function StoryViewDrama:_onTypeWriterFinish()
	self:_startAutoPlay()

	self._forceComTypeWriter = nil
end

function StoryViewDrama:_showStoryConfig()
	for k, v in pairs(self._viewModels) do
		if k == self._currStory.direction then
			v:setColor(1)
		else
			v:onNotCurrShowing()
		end
	end

	for k, v in pairs(self._npcIcons) do
		if k ~= self._currStory.direction then
			v:onNotCurrShowing()
		end
	end

	local direction = self._currStory.direction

	if not self._currStory.hideAll and direction and #direction > 0 then
		self._viewModels[direction]:setStories(self._storyCfgs, self._modelsCfg)
		self._npcIcons[direction]:setStory(self._currStory)
	else
		for k, v in pairs(self._viewModels) do
			v:clearObjects()
		end

		for k, v in pairs(self._npcIcons) do
			v:hideObject()
		end
	end
end

function StoryViewDrama:_showDramaType()
	for k, v in pairs(self._types) do
		if k == self._currTypeId then
			v.go:SetActive(true)
		else
			v.go:SetActive(false)
		end
	end
end

function StoryViewDrama:_checkShake()
	if self._currStory.shake > 0 then
		local rangeX = 5
		local rangeY = 8
		local rangeZ = 9
		local shakeTime = 0.5

		self._shakeNode:Shake(Vector3.New(rangeX, rangeY, rangeZ), 0.02, shakeTime)
	else
		self._shakeNode:Stop()
	end
end

function StoryViewDrama:_showName()
	local currDramaNode = self._types[self._currTypeId]
	local nameObj = currDramaNode.name
	local nameBg = currDramaNode.nameBg

	GameUtil.SetActive(nameBg, false)

	if self._currStory.name and #self._currStory.name > 0 then
		if nameObj then
			GameUtil.SetActive(nameBg, true)
			nameObj.gameObject:SetActive(true)

			nameObj.text = string.gsub(self._currStory.name, "#username#", RoleModel.instance:getUserName())
		end
	elseif nameObj then
		nameObj.gameObject:SetActive(false)
	end
end

function StoryViewDrama:_showText()
	local currDramaNode = self._types[self._currTypeId]
	local text = currDramaNode.text
	local typeWriter = currDramaNode.typeWriter
	local content = tostring(self._currStory.text) ~= "0" and string.gsub(self._currStory.text, "#username#", string.format("<color=#0068b7>%s</color>", RoleModel.instance:getUserName())) or ""

	text.text = content

	if typeWriter then
		typeWriter:SetText(content)
	end
end

function StoryViewDrama:_onTimerCallback()
	removetimer(self._onTimerCallback, self)

	if self._isOpeningNpcIntrod then
		return
	end

	if self._isTransitionScene then
		return
	end

	if self._isPause or not self._autoPlaying or self._isFinished or self._isFadingIn or self._isFadingOut then
		return
	end

	if self:isLoadingRes() then
		self:_startAutoPlay()

		return
	end

	if not TaskFacade.instance:isTesting() then
		local typeWriter = self._types[self._currTypeId].typeWriter

		if not typeWriter or typeWriter.IsOver then
			self:finishStory()
		end
	end
end

function StoryViewDrama:_onClickMask()
	if self._isOpeningNpcIntrod then
		return
	end

	if self._isTransitionScene or self._isFadingIn or self._isFadingOut then
		return
	end

	if self._isPause or self._isFinished then
		return
	end

	if self._view:isLoadingRes() then
		return
	end

	if self._autoPlaying then
		self:stopAutoPlay()

		return
	end

	if self:forceCompleteTypeWriter() then
		return
	end

	self._forceComTypeWriter = nil

	if self:isUIInteractiveTargetStory() then
		return
	end

	self:finishStory()
end

function StoryViewDrama:_onClickSpace()
	self:_onClickMask()
end

function StoryViewDrama:forceCompleteTypeWriter()
	if self._isFadingOut or not self._currTypeId then
		return
	end

	local typeWriter = self._types[self._currTypeId].typeWriter

	if typeWriter and not typeWriter.IsOver then
		self._forceComTypeWriter = true

		typeWriter:ForceComplete()

		return true
	end
end

function StoryViewDrama:_playSound()
	local sound = self:_getPlaySound()

	if sound and sound > 0 then
		local nextStory = self._view:_getNextStoryOnly()
		local autoResumeBgm = true

		if nextStory then
			local nextSound = self:_getPlaySound(nextStory)

			if nextSound and nextSound > 0 then
				autoResumeBgm = false
			end
		end

		AudioPlayerEx.instance:playVoice(sound, nil, nil, autoResumeBgm)
	end
end

function StoryViewDrama:_getPlaySound(currStory)
	local currStory = currStory or self._currStory
	local sound = currStory.sound
	local gender = RoleModel.instance:getGender()

	if gender == GameEnum.Gender.Female then
		sound = self._currStory.sound_f
	end

	if not sound or sound == 0 then
		sound = currStory.sound
	end

	return sound
end

function StoryViewDrama:_initAutoPlayingTips()
	if not self._autoPlayingTips then
		local text = lang("story_autoplaying")

		self._autoPlayingTips = {}
		self._autoPlayingTips[0] = text
		self._autoPlayingTips[1] = text .. "."
		self._autoPlayingTips[2] = text .. ".."
		self._autoPlayingTips[3] = text .. "..."
		self._currAutoPlayIndex = 0
		self._autoPlayingText.text = self._autoPlayingTips[self._currAutoPlayIndex]
	end
end

function StoryViewDrama:_startAutoPlay()
	removetimer(self._onTimerCallback, self)

	if self._autoPlaying and self._currStory then
		local sound = self:_getPlaySound()
		local countTime = 2

		if checknumber(sound) > 0 then
			countTime = math.max(countTime, AudioPlayerEx.instance:getAudioLength(sound) / 1000)
		end

		settimer(countTime, self._onTimerCallback, self)
	end
end

function StoryViewDrama:stopAutoPlay()
	self._autoPlaying = nil

	removetimer(self._onTimerCallback, self)
	removetimer(self._tickAutoPlaying, self)

	if self._autoPlayBtn then
		self._autoPlayBtn.gameObject:SetActive(true)
	end

	if self._stopAutoPlayBtn then
		self._stopAutoPlayBtn.gameObject:SetActive(false)
	end

	self:_updateLeftTopIconPos()
end

function StoryViewDrama:_tickAutoPlaying()
	self._currAutoPlayIndex = self._currAutoPlayIndex + 1

	if self._currAutoPlayIndex > #self._autoPlayingTips then
		self._currAutoPlayIndex = 0
	end

	self._autoPlayingText.text = self._autoPlayingTips[self._currAutoPlayIndex]
end

function StoryViewDrama:_onClickAutoPlay()
	if self._isOpeningNpcIntrod then
		return
	end

	if not self._currStory then
		return
	end

	if self._isFinished or self._isFadingIn or self._isFadingOut then
		return
	end

	if self._isTransitionScene or self._hideJumpAndContinue then
		return
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoPlayStoryButton)

	local currStory = StoryModel.instance:getCurStory()

	if currStory then
		StoryController.instance:sensorsTrackStoryPass(self._currStory, self._currStory.storyType, false)
	end

	self:startAutoPlay()
end

function StoryViewDrama:_onClickStopAutoPlay()
	if self._isOpeningNpcIntrod then
		return
	end

	if self._isTransitionScene or self._hideJumpAndContinue then
		return
	end

	if not self._currStory then
		return
	end

	if self._isFinished or self._isFadingIn or self._isFadingOut then
		return
	end

	self:stopAutoPlay()
end

function StoryViewDrama:_onClickHideHud()
	if self._isOpeningNpcIntrod then
		return
	end

	if not self._currStory then
		return
	end

	if self._isFinished or self._isFadingIn or self._isFadingOut then
		return
	end

	if self._isTransitionScene then
		return
	end

	self._typesImages = goutil.findChild(self.mainGO, "story/shakeNode/types"):GetComponentsInChildren(typeof(UnityEngine.UI.Image))
	self._typesTxts = goutil.findChild(self.mainGO, "story/shakeNode/types"):GetComponentsInChildren(typeof(UnityEngine.UI.Text))
	self._rightTopImages = self._rightTop:GetComponentsInChildren(typeof(UnityEngine.UI.Image))

	goutil.setActive(goutil.findChild(self.mainGO, "story/Spines"), false)

	goutil.findChildImageComponent(self.mainGO, "hideHud").raycastTarget = true

	GlobalDispatcher:dispatch(GlobalNotify.BulletScreenFade, true)
	settimer(0.02, self._hideHud, self, true)
end

function StoryViewDrama:_setHudAlpha(alpha)
	for i = 0, self._typesImages.Length - 1 do
		local color = self._typesImages[i].color

		self._typesImages[i].color = Color.New(color.r, color.g, color.b, alpha)
	end

	for i = 0, self._typesTxts.Length - 1 do
		local color = self._typesTxts[i].color

		self._typesTxts[i].color = Color.New(color.r, color.g, color.b, alpha)
	end

	for i = 0, self._rightTopImages.Length - 1 do
		local color = self._rightTopImages[i].color

		self._rightTopImages[i].color = Color.New(color.r, color.g, color.b, alpha)
	end
end

function StoryViewDrama:_hideHud()
	if self._typesImages[0].color.a > 0 then
		self:_setHudAlpha(self._typesImages[0].color.a - 0.05)
	else
		goutil.setActive(self._types[1].go.transform.parent.gameObject, false)
		goutil.setActive(self._rightTop, false)
		Framework.UIClickTrigger.Get(goutil.findChild(self.mainGO, "hideHud")):AddClickListener(self._onClickRecoveryHud, self, nil)
		removetimer(self._hideHud, self)
	end
end

function StoryViewDrama:_onClickRecoveryHud()
	if not self._currStory then
		return
	end

	if self._isFinished or self._isFadingIn or self._isFadingOut then
		return
	end

	if self._isTransitionScene then
		return
	end

	goutil.setActive(self._types[1].go.transform.parent.gameObject, true)
	goutil.setActive(self._rightTop, true)
	GlobalDispatcher:dispatch(GlobalNotify.BulletScreenFade, false)
	goutil.setActive(goutil.findChild(self.mainGO, "story/Spines"), true)
	settimer(0.02, self._recoveryHud, self, true)
end

function StoryViewDrama:_recoveryHud()
	if self._typesImages[0].color.a < 1 then
		self:_setHudAlpha(self._typesImages[0].color.a + 0.05)
	else
		Framework.UIClickTrigger.Get(goutil.findChild(self.mainGO, "hideHud")):RemoveClickListener()

		goutil.findChildImageComponent(self.mainGO, "hideHud").raycastTarget = false

		removetimer(self._recoveryHud, self)
	end
end

function StoryViewDrama:_onClickHistory()
	self:pause()
	goutil.setActive(goutil.findChild(self.mainGO, "history"), true)

	local story = StoryConfig.instance:getStories(self._currStory.id)

	for i = 1, self._currStory.story_id do
		if story[i].text ~= nil and story[i].text ~= "" then
			table.insert(self._historyStory, story[i])
		end
	end

	if self._historyTableView then
		self._historyTableView:ReloadData()
	end

	self._breakBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "history/break")

	self._breakBtn:AddClickListener(self._onClickhistoryBreak, self)
end

function StoryViewDrama:_onClickhistoryBreak()
	if self._isPause then
		self:resume()
	end

	self._historyStory = {}

	self._breakBtn:RemoveClickListener()
	goutil.setActive(goutil.findChild(self.mainGO, "history"), false)
end

function StoryViewDrama:_historyNumInView()
	if not self._historyStory then
		return 0
	end

	return #self._historyStory
end

function StoryViewDrama:_historyCellSize()
	return 1140, 100
end

function StoryViewDrama:_historyCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	if not cell and self._historyCell then
		cell = view:AddChild(self._historyCell)

		self:_initHistoryCell(cell)
	end

	local data = self._historyStory[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateHistoryCell(view, cell, data)

	return cell
end

function StoryViewDrama:_initHistoryCell(cell)
	return
end

function StoryViewDrama:_updateHistoryCell(view, cell, data)
	local name = goutil.findChildTextComponent(cell.gameObject, "name")

	name.text = string.gsub(data.name, "#username#", RoleModel.instance:getUserName())

	local text = goutil.findChildTextComponent(cell.gameObject, "text")

	text.text = string.gsub(data.text, "#username#", string.format("<color=#0068b7>%s</color>", RoleModel.instance:getUserName()))
end

function StoryViewDrama:_onHistoryReloadFinish()
	if self._historyTableView == nil then
		return
	end

	if #self._historyStory > 3 then
		self._historyTableView:MoveCellToCebter(#self._historyStory - 1)
	end
end

function StoryViewDrama:_onClickHideDrama()
	if not self._isShowDrama then
		return
	end

	self._isShowDrama = false

	self:updateDrama()
end

function StoryViewDrama:_onClickShowDrama()
	if self._isShowDrama then
		return
	end

	self._isShowDrama = true

	self:updateDrama()
end

function StoryViewDrama:updateDrama()
	goutil.setActive(self._drama, self._isShowDrama)
	goutil.setActive(self._btnHideDrama, self._isShowDrama)
	goutil.setActive(self._btnShowDrama, not self._isShowDrama)
end

function StoryViewDrama:_onClickSpeed()
	self._curWriteSpeed = self._curWriteSpeed % #self._speedCfg + 1

	self:updateWriterSpeed()
end

function StoryViewDrama:updateWriterSpeed()
	local speedRate = self._speedCfg[self._curWriteSpeed]

	for k, v in pairs(self._types) do
		if v.typeWriter then
			v.typeWriter.speed = self._speedBase / speedRate
		end
	end

	if self._txtSpeed then
		self._txtSpeed.text = "x" .. speedRate
	end
end

function StoryViewDrama:_onClickJumpButton()
	if not self._currStory then
		return
	end

	if self:isCurStoryUnpassable() then
		FloatWordMgr.instance:show(lang("ui_story_cantpass"))

		return
	end

	if self._view:isLoadingRes() or self._hideJumpAndContinue then
		return
	end

	if self._isFinished or self._isFadingIn or self._isFadingOut then
		return
	end

	if self._isOpeningNpcIntrod then
		return
	end

	if self._isTransitionScene then
		return
	end

	local currStory = StoryModel.instance:getCurStory()

	if currStory then
		if currStory.storyType == StoryModel.StoryType.PlotCopy then
			SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickJumpOverCopyStoryButton)
		else
			SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickJumpOverStoryButton)
		end

		StoryController.instance:sensorsTrackStoryPass(self._currStory.id, currStory.storyType, true)
	end

	for k, v in pairs(self._viewModels) do
		v:hideObject()
		v:clearObjects(false)
	end

	self._view:jumpStories(currStory)
end

function StoryViewDrama:_showBrief(brief)
	local function onClickBriefNext()
		self:_onClickBriefNext()
	end

	local function onClickBriefCancel()
		self:_onClickBriefCancel()
	end

	TipsFacade.instance:openPopupWindow(lang("story_brief"), brief.text, onClickBriefNext, onClickBriefCancel, lang("story_nextstep"), lang("mail_cancel"))
	self:pause()
end

function StoryViewDrama:_onClickBriefNext()
	local currStory = StoryModel.instance:getCurStory()
	local popStories = currStory:popBrief()

	self._view:jumpDramaStories(currStory, popStories)
end

function StoryViewDrama:_onClickBriefCancel()
	self:resume()
end

return StoryViewDrama
