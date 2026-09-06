-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/model/SlackOffGameStudentMo.lua

module("logic.extensions.slackoffgame.model.SlackOffGameStudentMo", package.seeall)

local SlackOffGameStudentMo = class("SlackOffGameStudentMo", BaseLuaOnce)

function SlackOffGameStudentMo:buildUI()
	self._imgChange = self:getGo("img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._roleImg = self:getGo("img"):GetComponent(goutil.Type_UIImage)
	self._btn = self:getGo("btn")
	self._bubble = self:getGo("bubble")
	self._emoji = self:getGo("bubble/emoji"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtTag = self:getGo("tag/txt"):GetComponent(typeof(UnityEngine.UI.Text))
	self._txtProg = self:getGo("progress/txt"):GetComponent(typeof(UnityEngine.UI.Text))
	self._txtBtn = self:getGo("btn/txt"):GetComponent(typeof(UnityEngine.UI.Text))
end

function SlackOffGameStudentMo:bindEvents()
	GameUtil.addClickHandler(self._btn, self._changeState, self)
end

function SlackOffGameStudentMo:unbindEvents()
	GameUtil.rmClickHandler(self._btn)
end

function SlackOffGameStudentMo:onExit()
	SlackOffGameStudentMo.super.onExit(self)
	self:endClass()
end

function SlackOffGameStudentMo:onEnter(cfg, targets)
	self.addGEvent(self, GlobalNotify.SlackOffGameTeacherComeIn, function()
		self:setTeacherState(true)
	end, self)
	self.addGEvent(self, GlobalNotify.SlackOffGameTeacherLeave, function()
		self:setTeacherState(false)
	end, self)
	self:_initData()
	self:_initMo(cfg, targets)
end

function SlackOffGameStudentMo:_initData()
	self._studyState = true
	self._moodScore = 0
	self._studyScore = 0
	self._comboCount = 0
	self._isShowBubble = false
	self._addMood = 0
	self._addStudy = 0

	self:setTeacherState(false)
	self:setComboState(false)
	self:setFinishedState(false)
	goutil.setActive(self._bubble, false)
end

function SlackOffGameStudentMo:_initMo(cfg, targets)
	self._cfg = cfg or self._cfg

	if not self._cfg then
		return
	end

	local targetPair = string.split(targets, "#")

	self._moodTarget = tonumber(targetPair[1])
	self._studyTarget = tonumber(targetPair[2])
	self._txtTag.text = self._cfg.type
	self._txtProg.text = "心情：0\n知识吸收：0"

	self:_refreshState()
end

function SlackOffGameStudentMo:setComboState(isCombo)
	self._comboState = isCombo
	self._isShowBubble = self._comboState or self._isShowBubble
end

function SlackOffGameStudentMo:setFinishedState(isPass)
	self._isPass = isPass
	self._isShowBubble = self._isPass or self._isShowBubble
end

function SlackOffGameStudentMo:endClass()
	self:_initData()
end

function SlackOffGameStudentMo:setTeacherState(withTeacher)
	self._withTeacher = withTeacher
end

function SlackOffGameStudentMo:update()
	local planCfg = self:_getValueChangePlan()
	local moodRange = planCfg and planCfg.moodRange
	local studyRange = planCfg and planCfg.studyRange

	self._addMood = math.random(moodRange[1], moodRange[2])
	self._addStudy = math.random(studyRange[1], studyRange[2])

	self:_refreshValueShow()

	if self._studyState and self._addStudy > 0 then
		self._comboCount = self._comboCount + 1
	end

	if not self._studyState and self._addMood > 0 then
		self._comboCount = self._comboCount + 1
	end

	self._moodScore = self._moodScore + self._addMood
	self._studyScore = self._studyScore + self._addStudy
	self._moodScore = Mathf.Clamp(self._moodScore, 0, 100)
	self._studyScore = Mathf.Clamp(self._studyScore, 0, 100)

	local isCombo = self._comboCount >= self._cfg.comboNeed
	local isFinish = self._moodScore >= self._moodTarget and self._studyScore >= self._studyTarget

	if isCombo ~= self._comboState or isFinish ~= self._isPass then
		self:setComboState(isCombo)
		self:setFinishedState(isFinish)
		self:_refreshEmoji()
	end
end

function SlackOffGameStudentMo:_getValueChangePlan()
	local planId = 1

	if self._withTeacher and self._studyState then
		planId = self._cfg.inspectAndStudyPlanId
	elseif self._withTeacher and not self._studyState then
		planId = self._cfg.InspectButRestPlanId
	elseif not self._withTeacher and self._studyState then
		planId = self._cfg.studyPlanId
	elseif not self._withTeacher and not self._studyState then
		planId = self._cfg.restPlanId
	end

	return SlackOffGameConfig.instance:getValuePlanCfgByPlanId(planId)
end

function SlackOffGameStudentMo:_changeState()
	self._studyState = not self._studyState
	self._comboCount = 0

	self:_refreshState()
	self:_refreshValueShow()
end

function SlackOffGameStudentMo:_refreshValueShow()
	local moodstr = "心情：" .. Mathf.Clamp(self._moodScore, 0, 100)
	local studystr = "知识吸收：" .. Mathf.Clamp(self._studyScore, 0, 100)
	local addMoodstr = ""
	local addStudystr = ""

	addMoodstr = self._addMood >= 0 and string.format("<color=#FF0000FF>+%d</color>", self._addMood) or string.format("<color=#00FF00FF>%d</color>", self._addMood)
	addStudystr = self._addStudy >= 0 and string.format("<color=#FF0000FF>+%d</color>", self._addStudy) or string.format("<color=#00FF00FF>%d</color>", self._addStudy)

	local state = self._studyState and "学习中" or "摸鱼中"

	self._txtProg.text = string.format("%s%s\n%s%s\n%s", moodstr, addMoodstr, studystr, addStudystr, state)
end

function SlackOffGameStudentMo:_refreshState()
	local imgName = ""

	if self._cfg then
		imgName = self._studyState and self._cfg.studyImg or self._cfg.restImg
	end

	print("[YuTestPrint] =====>\t type = ", self._cfg.type, "self._studyState = ", self._studyState)
	self._imgChange:SetState(self._studyState and 1 or 0)
	self._roleImg:SetNativeSize()

	self._txtBtn.text = self._studyState and "摸鱼" or "学习"
end

function SlackOffGameStudentMo:_refreshEmoji()
	goutil.setActive(self._bubble, self._isShowBubble)

	if self._cfg then
		if self._isPass then
			local emojiName = self._cfg.finishedEmoji

			self._emoji:ChangeSprite(emojiName)

			return
		end

		if self._comboState then
			if self._studyState then
				if not self._cfg.studyEmoji then
					local emojiName = self._cfg.moodEmoji

					self._emoji:ChangeSprite(emojiName)

					return
				end
			end
		end

		print("[YuTestPrint] =====>\t type = ", self._cfg.type, "isPass = ", self._isPass, " comboState = ", self._comboState)
	end
end

function SlackOffGameStudentMo:getInfo()
	local info = {}

	info.studentId = self._cfg.studentId
	info.studentName = self._cfg.studentName
	info.type = self._cfg.type
	info.maxProg = self._cfg.progress
	info.isPass = self._isPass

	return info
end

return SlackOffGameStudentMo
