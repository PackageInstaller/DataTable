-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicBeatItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatItem", package.seeall)

local VersionActivity2_4MusicBeatItem = class("VersionActivity2_4MusicBeatItem", ListScrollCellExtend)

function VersionActivity2_4MusicBeatItem:onInitView()
	self._godynamics = gohelper.findChild(self.viewGO, "root/#go_dynamics")
	self._gostate1 = gohelper.findChild(self.viewGO, "root/stateroot/#go_state1")
	self._gostate2 = gohelper.findChild(self.viewGO, "root/stateroot/#go_state2")
	self._gostate3 = gohelper.findChild(self.viewGO, "root/stateroot/#go_state3")
	self._gostate4 = gohelper.findChild(self.viewGO, "root/stateroot/#go_state4")
	self._goclick = gohelper.findChild(self.viewGO, "root/#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicBeatItem:addEvents()
	return
end

function VersionActivity2_4MusicBeatItem:removeEvents()
	return
end

function VersionActivity2_4MusicBeatItem:_editableInitView()
	self._hideTime = VersionActivity2_4MusicBeatModel.instance:getHideTime()
	self._scoreTimeList = VersionActivity2_4MusicBeatModel.instance:getScoreTimeList()
	self._showTime = VersionActivity2_4MusicBeatModel.instance:getShowTime()
	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._touchComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goclick, VersionActivity2_4MusicTouchComp, {
		callback = self._onClickDown,
		callbackTarget = self
	})
end

function VersionActivity2_4MusicBeatItem:_onClickDown()
	self._clickDown = true
end

function VersionActivity2_4MusicBeatItem:_editableAddEvents()
	return
end

function VersionActivity2_4MusicBeatItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicBeatItem:onUpdateMO(mo, parentGo, progressTime)
	gohelper.setActive(self.viewGO, true)
	gohelper.setActive(self._gostate1, false)
	gohelper.setActive(self._gostate2, false)
	gohelper.setActive(self._gostate3, false)
	gohelper.setActive(self._gostate4, false)
	transformhelper.setLocalScale(self._godynamics.transform, 1, 1, 1)

	self._config = mo
	self._progressTime = progressTime
	self.viewGO.name = tostring(self._config.musicId)
	self._clickDown = false
	self._grade = nil
	self._submitted = false

	local calibrationTime = Activity179Model.instance:getCalibration()

	self._calibrationTime = self._config.time - calibrationTime
	self._endTime = self._calibrationTime + self._hideTime
	self._isTimeoutMiss = false
	self._isPlayAudio = false
	self._rootAnimator.speed = 1

	self._touchComp:setTouchEnabled(true)

	if parentGo then
		gohelper.addChild(parentGo, self.viewGO)
	else
		logError("VersionActivity2_4MusicBeatItem parentGo is nil musicId:", tostring(self._config.musicId))
	end
end

function VersionActivity2_4MusicBeatItem:pause()
	self._rootAnimator.speed = 0
end

function VersionActivity2_4MusicBeatItem:resume()
	self._rootAnimator.speed = 1
end

function VersionActivity2_4MusicBeatItem:disappear(progressTime)
	if progressTime >= self._endTime then
		return true
	end
end

function VersionActivity2_4MusicBeatItem:timeout(progressTime)
	if progressTime >= self._endTime then
		return true
	end
end

function VersionActivity2_4MusicBeatItem:setTimeoutMiss()
	if self._grade then
		return
	end

	self:_setGrade(VersionActivity2_4MusicEnum.BeatGrade.Miss)

	self._endTime = self._endTime + 0.5
	self._isTimeoutMiss = true
end

function VersionActivity2_4MusicBeatItem:setMiss()
	if self._grade then
		return
	end

	self:_setGrade(VersionActivity2_4MusicEnum.BeatGrade.Miss)
end

function VersionActivity2_4MusicBeatItem:updateFrame(progressTime)
	self:_checkGrade(progressTime)
	self:_playAnim(progressTime)
end

function VersionActivity2_4MusicBeatItem:_playAnim(progressTime)
	if self._isTimeoutMiss then
		local scale = 0

		transformhelper.setLocalScale(self._godynamics.transform, scale, scale, 1)

		return
	end

	if self._isPlayAudio == false and progressTime >= self._calibrationTime then
		self._isPlayAudio = true
	end

	local perfectTime = self._calibrationTime
	local showTime = self._calibrationTime + self._showTime
	local hideTime = self._endTime
	local beforePerfectTime = progressTime <= perfectTime
	local startTime = beforePerfectTime and showTime or perfectTime
	local endTime = beforePerfectTime and perfectTime or hideTime
	local deltaTime = progressTime - startTime
	local duration = endTime - startTime
	local percent = deltaTime / duration
	local startScale = beforePerfectTime and 1 or 0.35
	local endScale = beforePerfectTime and 0.35 or 0
	local deltaScale = startScale - endScale
	local scale = startScale - deltaScale * percent

	transformhelper.setLocalScale(self._godynamics.transform, scale, scale, 1)
end

function VersionActivity2_4MusicBeatItem:_checkGrade(progressTime)
	if not self._clickDown then
		return
	end

	self._clickDown = false

	if not self._grade then
		self:_setGrade(self:_getGrade(progressTime))

		if self._grade then
			AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_perfect)
		end
	end
end

function VersionActivity2_4MusicBeatItem:_setGrade(grade)
	if self._submitted then
		return
	end

	self._grade = grade

	gohelper.setActive(self["_gostate" .. self._grade], true)
	self._touchComp:setTouchEnabled(false)
end

function VersionActivity2_4MusicBeatItem:setSubmit()
	self._submitted = true
end

function VersionActivity2_4MusicBeatItem:isSubmitted()
	return self._submitted
end

function VersionActivity2_4MusicBeatItem:getGrade()
	return self._grade
end

function VersionActivity2_4MusicBeatItem:_getGrade(progressTime)
	for i, v in ipairs(self._scoreTimeList) do
		local startTime = self._calibrationTime + v[1]
		local endTime = self._calibrationTime + v[2]

		if startTime <= progressTime and progressTime <= endTime then
			return i
		end
	end

	return VersionActivity2_4MusicEnum.BeatGrade.Cool
end

function VersionActivity2_4MusicBeatItem:hide()
	gohelper.setActive(self.viewGO, false)
end

function VersionActivity2_4MusicBeatItem:onDestroyView()
	return
end

return VersionActivity2_4MusicBeatItem
