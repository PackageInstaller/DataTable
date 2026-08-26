-- chunkname: @modules/logic/story/view/StormTimer/StoryFullScreenStormView.lua

module("modules.logic.story.view.StormTimer.StoryFullScreenStormView", package.seeall)

local StoryFullScreenStormView = class("StoryFullScreenStormView", BaseView)

function StoryFullScreenStormView:onInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.goBg1 = gohelper.findChild(self.viewGO, "#normal_bg")
	self.goBg2 = gohelper.findChild(self.viewGO, "#urgent_bg")
	self.goNumRoot = gohelper.findChild(self.viewGO, "#num")
	self.numAnim = self.goNumRoot:GetComponent(gohelper.Type_Animator)
	self.numList = {}
	self.goSlot1 = gohelper.findChild(self.viewGO, "#normal_bg/#slot")
	self.goSlot2 = gohelper.findChild(self.viewGO, "#urgent_bg/#slot")

	for i = 1, 4 do
		table.insert(self.numList, self:createNumItem(i))
	end

	self.timeDelay = 0.33

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryFullScreenStormView:addEvents()
	return
end

function StoryFullScreenStormView:removeEvents()
	return
end

function StoryFullScreenStormView:_editableInitView()
	return
end

function StoryFullScreenStormView:onUpdateParam()
	self.data = self.viewParam.data

	self:onUpdateView()
end

function StoryFullScreenStormView:onOpen()
	self.data = self.viewParam.data

	self:onUpdateView()
end

function StoryFullScreenStormView:onClose()
	return
end

function StoryFullScreenStormView:onUpdateView()
	local chapterCo = self.data
	local param = string.splitToNumber(chapterCo.navigateChapterEn, "#")
	local bgType = param[1]
	local animType = param[2]

	if not param[3] then
		local delayTime = 0

		self.bgType = bgType

		gohelper.setActive(self.goBg1, bgType == StoryEnum.FullScreenCountdownBgType.Normal)
		gohelper.setActive(self.goBg2, bgType == StoryEnum.FullScreenCountdownBgType.Emergency)

		self.playParam = {
			animType,
			TimeUtil.getFormatTimeTable(chapterCo.navigateLogo)
		}

		TaskDispatcher.cancelTask(self._playAnim, self)

		if animType == StoryEnum.FullScreenCountdownAnimType.Direct then
			self.anim:Play("open", 0, 0)
		else
			self.anim:Play("open", 0, 1)
		end

		if delayTime > 0 then
			gohelper.setActive(self.goNumRoot, false)
			gohelper.setActive(self.goSlot1, false)
			gohelper.setActive(self.goSlot2, false)
			TaskDispatcher.runDelay(self._playAnim, self, delayTime * 0.001)
		else
			self:_playAnim()
		end
	end
end

function StoryFullScreenStormView:_playAnim()
	local animType, numTable = self.playParam[1], self.playParam[2]

	self:playAnim(animType, numTable)
end

function StoryFullScreenStormView:playAnim(animType, numTable)
	TaskDispatcher.cancelTask(self.playTask, self)
	gohelper.setActive(self.goNumRoot, true)
	gohelper.setActive(self.goSlot1, self.bgType == StoryEnum.FullScreenCountdownBgType.Normal)
	gohelper.setActive(self.goSlot2, self.bgType == StoryEnum.FullScreenCountdownBgType.Emergency)
	self:playAudio()

	if animType == StoryEnum.FullScreenCountdownAnimType.Direct then
		for i, v in ipairs(self.numList) do
			v:clearCurNum()
			v:setData(animType, numTable[i])
		end
	else
		self.playList = {}

		for i, v in ipairs(self.numList) do
			if numTable[i] ~= v:getCurNum() then
				table.insert(self.playList, {
					i,
					animType,
					numTable[i]
				})
			end
		end

		self.playIndex = 0

		TaskDispatcher.runRepeat(self.playTask, self, self.timeDelay, #self.playList)
	end
end

function StoryFullScreenStormView:playTask()
	self.playIndex = self.playIndex + 1

	local index = self.playIndex
	local data = self.playList[index]

	if not data then
		return
	end

	local item = self.numList[data[1]]

	if not item then
		return
	end

	item:setData(data[2], data[3])
end

function StoryFullScreenStormView:createNumItem(index)
	local itemGO = gohelper.findChild(self.goNumRoot, string.format("num_%s", index))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, StoryStormTimerItem)

	item:setNumChangeAudio(AudioEnum.Story.play_chap13_jishiqi_shuzi, 100)

	return item
end

function StoryFullScreenStormView:playCloseAnim()
	self.numAnim:Play("close")
end

function StoryFullScreenStormView:playAudio()
	if self.bgType == self.curBgType then
		return
	end

	if self.curBgType then
		self:closeBgAudio()
		self:closeTimerAudio()
		self:closeWarnAudio()
	end

	self.curBgType = self.bgType

	self:playBgAudio()
	self:playTimerAudio()
	self:playWarnAudio()
end

function StoryFullScreenStormView:playBgAudio()
	local audioId = self.curBgType == StoryEnum.FullScreenCountdownBgType.Normal and AudioEnum.Story.play_chap13_jishiqi_kaiqi_lp or AudioEnum.Story.play_chap13_jishiqi_kaiqi2_lp
	local param = AudioParam.New()

	param.volume = 60
	param.fadeInTime = 1.8

	AudioEffectMgr.instance:playAudio(audioId, param)
end

function StoryFullScreenStormView:closeBgAudio()
	local audioId

	AudioEffectMgr.instance:stopAudio(self.curBgType == StoryEnum.FullScreenCountdownBgType.Normal and AudioEnum.Story.play_chap13_jishiqi_kaiqi_lp or AudioEnum.Story.play_chap13_jishiqi_kaiqi2_lp, 1)
end

function StoryFullScreenStormView:playTimerAudio()
	if self.curBgType == StoryEnum.FullScreenCountdownBgType.Normal then
		AudioMgr.instance:trigger(AudioEnum.Story.play_chap13_jishiqi_second_lp)
	else
		AudioMgr.instance:trigger(AudioEnum.Story.play_chap13_jishiqi_second2_lp)
	end
end

function StoryFullScreenStormView:closeTimerAudio()
	if self.curBgType == StoryEnum.FullScreenCountdownBgType.Normal then
		AudioMgr.instance:trigger(AudioEnum.Story.stop_chap13_jishiqi_second_lp)
	else
		AudioMgr.instance:trigger(AudioEnum.Story.stop_chap13_jishiqi_second2_lp)
	end
end

function StoryFullScreenStormView:playWarnAudio()
	if self.curBgType == StoryEnum.FullScreenCountdownBgType.Emergency then
		local param = AudioParam.New()

		param.volume = 30
		param.fadeInTime = 1.8

		AudioEffectMgr.instance:playAudio(AudioEnum.Story.play_chap13_jishiqi_jingbao_lp, param)
	end
end

function StoryFullScreenStormView:closeWarnAudio()
	if self.curBgType == StoryEnum.FullScreenCountdownBgType.Emergency then
		AudioEffectMgr.instance:stopAudio(AudioEnum.Story.play_chap13_jishiqi_jingbao_lp, 1)
	end
end

function StoryFullScreenStormView:onDestroyView()
	self:closeBgAudio()
	self:closeTimerAudio()
	self:closeWarnAudio()
	TaskDispatcher.cancelTask(self._playAnim, self)
	TaskDispatcher.cancelTask(self.playTask, self)
end

return StoryFullScreenStormView
