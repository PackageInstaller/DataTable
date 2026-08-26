-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicBeatNoteView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatNoteView", package.seeall)

local VersionActivity2_4MusicBeatNoteView = class("VersionActivity2_4MusicBeatNoteView", BaseView)

function VersionActivity2_4MusicBeatNoteView:onInitView()
	self._gocombo = gohelper.findChild(self.viewGO, "root/#go_combo")
	self._gostate1 = gohelper.findChild(self.viewGO, "root/#go_combo/#go_state1")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "root/#go_combo/#go_state1/#txt_num1")
	self._gostate2 = gohelper.findChild(self.viewGO, "root/#go_combo/#go_state2")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "root/#go_combo/#go_state2/#txt_num2")
	self._gostate3 = gohelper.findChild(self.viewGO, "root/#go_combo/#go_state3")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "root/#go_combo/#go_state3/#txt_num3")
	self._gobeatitem = gohelper.findChild(self.viewGO, "root/#go_beatgrid/#go_beatitem")
	self._gomissclick = gohelper.findChild(self.viewGO, "root/#go_missclick")
	self._txtscore = gohelper.findChildText(self.viewGO, "root/scoregroup/#txt_score")
	self._gobeatgrid = gohelper.findChild(self.viewGO, "root/#go_beatgrid")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicBeatNoteView:addEvents()
	return
end

function VersionActivity2_4MusicBeatNoteView:removeEvents()
	return
end

function VersionActivity2_4MusicBeatNoteView:_editableInitView()
	self._gradeValues = {}

	self:_initStats()

	self._uiclick = SLFramework.UGUI.UIClickListener.Get(self._gomissclick)

	self._uiclick:AddClickDownListener(self._onClickDown, self)
	self._uiclick:AddClickUpListener(self._onClickUp, self)

	local go = gohelper.findChild(self.viewGO, "root/scoregroup")

	self._addAnimator = go:GetComponent("Animator")

	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.BeatModeEnd, self._onBeatModeEnd, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.Skip, self._onSkip, self)
end

function VersionActivity2_4MusicBeatNoteView:_onBeatModeEnd(isPause)
	if not isPause then
		return
	end

	VersionActivity2_4MusicController.instance:trackBeatView(VersionActivity2_4MusicEnum.BeatResult.Restart, self._totalScore, self:_getGradeStat())
end

function VersionActivity2_4MusicBeatNoteView:_initStats()
	gohelper.setActive(self._gostate1, false)
	gohelper.setActive(self._gostate2, false)
	gohelper.setActive(self._gostate3, false)
end

function VersionActivity2_4MusicBeatNoteView:_onClickDown()
	self._clickScreenPos = GamepadController.instance:getMousePosition()
end

function VersionActivity2_4MusicBeatNoteView:_onClickUp()
	return
end

function VersionActivity2_4MusicBeatNoteView:onClose()
	self._uiclick:RemoveClickDownListener()
	self._uiclick:RemoveClickUpListener()

	if not self._isSkipClose then
		VersionActivity2_4MusicController.instance:trackBeatView(VersionActivity2_4MusicEnum.BeatResult.Abort, self._totalScore, self:_getGradeStat())
	end
end

function VersionActivity2_4MusicBeatNoteView:_onSkip()
	self._isSkipClose = true

	VersionActivity2_4MusicController.instance:trackBeatView(VersionActivity2_4MusicEnum.BeatResult.Abort, self._totalScore, self:_getGradeStat())
end

function VersionActivity2_4MusicBeatNoteView:onOpen()
	self._episodeId = self.viewParam
	self._episodeConfig = Activity179Config.instance:getEpisodeConfig(self._episodeId)
	self._beatId = self._episodeConfig.beatId
	self._beatConfig = Activity179Config.instance:getBeatConfig(self._beatId)
	self._noteGroupId = self._beatConfig.noteGroupId
	self._noteGroupList = lua_activity179_note.configDict[self._noteGroupId]
	self._noteIndex = 0
	self._noteHideIndex = 0
	self._cacheNoteList = self:getUserDataTb_()
	self._comboList = Activity179Config.instance:getComboList(self._beatId)
	self._totalScore = 0

	self:_initPosList()
end

function VersionActivity2_4MusicBeatNoteView:onOpenFinish()
	self._showTime = VersionActivity2_4MusicBeatModel.instance:getShowTime()
end

function VersionActivity2_4MusicBeatNoteView:_initPosList()
	self._posGoList = self:getUserDataTb_()

	table.insert(self._posGoList, self._gobeatitem)

	for i = 1, 29 do
		local go = gohelper.cloneInPlace(self._gobeatitem)

		table.insert(self._posGoList, go)
	end
end

function VersionActivity2_4MusicBeatNoteView:openResult(isForceSuccess)
	self._isForceSuccess = isForceSuccess

	local isSuccess = isForceSuccess or self._totalScore >= self._beatConfig.targetId

	VersionActivity2_4MusicController.instance:trackBeatView((isSuccess or nil) and (VersionActivity2_4MusicEnum.BeatResult.Success or VersionActivity2_4MusicEnum.BeatResult.Fail), self._totalScore, self:_getGradeStat())

	if isSuccess then
		Activity179Rpc.instance:sendSet179ScoreRequest(Activity179Model.instance:getActivityId(), self._episodeId, self._beatConfig.targetId)

		if VersionActivity2_4MusicBeatModel.instance:getSuccessCount() == 0 then
			VersionActivity2_4MusicBeatModel.instance:setSuccessCount(1)
			StoryController.instance:playStory(self._episodeConfig.storyAfter, nil, function()
				VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatResultView({
					isForceSuccess = self._isForceSuccess
				})
			end)

			return
		end
	end

	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatResultView({
		isForceSuccess = self._isForceSuccess
	})
end

function VersionActivity2_4MusicBeatNoteView:startGame()
	self._noteIndex = 0
	self._noteHideIndex = 0
	self._gradeList = {}

	VersionActivity2_4MusicBeatModel.instance:updateGradleList(self._gradeList)

	self._txtscore.text = "0"
	self._playNoteList = self:getUserDataTb_()
end

function VersionActivity2_4MusicBeatNoteView:endGame()
	for i = #self._playNoteList, 1, -1 do
		local item = self._playNoteList[i]

		item:hide()
		table.remove(self._playNoteList, i)
		table.insert(self._cacheNoteList, item)
	end

	self._totalScore = 0
	self._gradeValues = {}
end

function VersionActivity2_4MusicBeatNoteView:initNoneStatus()
	self:_initStats()

	self._txtscore.text = "0"
end

function VersionActivity2_4MusicBeatNoteView:_addGrad(grade)
	table.insert(self._gradeList, grade)
	VersionActivity2_4MusicBeatModel.instance:updateGradleList(self._gradeList)

	local hitCount = 0

	for i = #self._gradeList, 1, -1 do
		if self._gradeList[i] == VersionActivity2_4MusicEnum.BeatGrade.Miss then
			break
		end

		hitCount = hitCount + 1
	end

	local comboIndex = 0

	if hitCount > 1 then
		local _, index = self:_getComboConfig(hitCount)

		comboIndex = index
	end

	gohelper.setActive(self._gostate1, comboIndex == 1)
	gohelper.setActive(self._gostate2, comboIndex == 2)
	gohelper.setActive(self._gostate3, comboIndex == 3)

	if comboIndex ~= 0 then
		self["_txtnum" .. comboIndex].text = VersionActivity2_4MusicEnum.times_sign .. hitCount
	end

	local oldScore = self._totalScore

	self:_parseGradeList()

	if oldScore < self._totalScore then
		self._addAnimator:Play("add", 0, 0)
	end
end

function VersionActivity2_4MusicBeatNoteView:_getComboConfig(num)
	local length = #self._comboList

	for i = length, 1, -1 do
		local config = self._comboList[i]

		if num >= config.combo or i == 1 then
			return config, i
		end
	end
end

function VersionActivity2_4MusicBeatNoteView:_parseGradeList()
	self._totalScore = 0
	self._gradeValues = {}

	local tempCount = 0
	local maxCount = 0

	for i, v in ipairs(self._gradeList) do
		if not self._gradeValues[v] then
			self._gradeValues[v] = self._gradeValues[v] + 1

			if v == VersionActivity2_4MusicEnum.BeatGrade.Miss then
				tempCount = 0
			else
				tempCount = tempCount + 1
				maxCount = math.max(maxCount, tempCount)
			end
		end
	end

	local comboConfig, _ = self:_getComboConfig(maxCount)
	local count = maxCount >= comboConfig.combo and 1 or 0
	local score = comboConfig.score * count

	self._totalScore = self._totalScore + score

	for i = VersionActivity2_4MusicEnum.BeatGrade.Perfect, VersionActivity2_4MusicEnum.BeatGrade.Cool do
		if not self._gradeValues[i] then
			local gradeScore = VersionActivity2_4MusicBeatModel.instance:getGradeScore(i)

			self._totalScore = self._totalScore + gradeScore * self._gradeValues[i]
		end
	end

	self._txtscore.text = self._totalScore
end

function VersionActivity2_4MusicBeatNoteView:_getGradeStat()
	self._gradeStat = self._gradeStat or {}

	for i = VersionActivity2_4MusicEnum.BeatGrade.Perfect, VersionActivity2_4MusicEnum.BeatGrade.Miss do
		if not self._gradeValues[i] then
			self._gradeStat[VersionActivity2_4MusicEnum.BeatGradeStatName[i]] = self._gradeValues[i]
		end
	end

	return self._gradeStat
end

function VersionActivity2_4MusicBeatNoteView:refreshNoteGroupStatus(isPause)
	for i = #self._playNoteList, 1, -1 do
		local item = self._playNoteList[i]

		if isPause then
			item:pause()
		else
			item:resume()
		end
	end
end

function VersionActivity2_4MusicBeatNoteView:updateNoteGroup(progressTime)
	local nearItem

	if self._clickScreenPos then
		local anchorPos = recthelper.screenPosToAnchorPos(self._clickScreenPos, self._gobeatgrid.transform)

		self._clickScreenPos = nil

		for i = #self._playNoteList, 1, -1 do
			local item = self._playNoteList[i]

			if not item:getGrade() then
				local distance = Vector2.Distance(anchorPos, item.viewGO.transform.parent.anchoredPosition)

				if not nearItem then
					nearItem = item
					nearItem._distance = distance
				elseif distance < nearItem._distance then
					nearItem = item
					nearItem._distance = distance
				end
			end
		end
	end

	for i = #self._playNoteList, 1, -1 do
		local item = self._playNoteList[i]

		item:updateFrame(progressTime)

		if item:timeout(progressTime) then
			item:setTimeoutMiss()
		end

		if item:disappear(progressTime) then
			item:hide()
			table.remove(self._playNoteList, i)
			table.insert(self._cacheNoteList, item)
		end

		if item == nearItem then
			item:setMiss()
		end

		local grade = item:getGrade()

		if grade and not item:isSubmitted() then
			item:setSubmit()
			self:_addGrad(grade)
		end
	end

	self._isClickDown = false

	local calibrationTime = Activity179Model.instance:getCalibration()
	local startIndex = self._noteIndex + 1

	for i = startIndex, #self._noteGroupList do
		local config = self._noteGroupList[i]

		if progressTime >= config.time - calibrationTime + self._showTime then
			self._noteIndex = i

			if config.buttonId > 0 then
				self:_addNote(config, progressTime)
			end
		end
	end

	local hideStartIndex = self._noteHideIndex + 1

	for i = hideStartIndex, #self._noteGroupList do
		local config = self._noteGroupList[i]

		if progressTime >= config.time then
			self._noteHideIndex = i

			AudioMgr.instance:trigger(config.eventName)
		else
			break
		end
	end
end

function VersionActivity2_4MusicBeatNoteView:_addNote(config, progressTime)
	local item = self:_getNoteItem()

	item:onUpdateMO(config, self._posGoList[config.buttonId], progressTime)
	table.insert(self._playNoteList, item)
end

function VersionActivity2_4MusicBeatNoteView:_getNoteItem()
	local item = table.remove(self._cacheNoteList)

	if item then
		return item
	end

	local path = self.viewContainer:getSetting().otherRes[1]
	local go = self:getResInst(path)

	item = MonoHelper.addNoUpdateLuaComOnceToGo(go, VersionActivity2_4MusicBeatItem)

	return item
end

return VersionActivity2_4MusicBeatNoteView
