-- chunkname: @modules/logic/story/view/StormTimer/StoryStormTimer.lua

module("modules.logic.story.view.StormTimer.StoryStormTimer", package.seeall)

local StoryStormTimer = class("StoryStormTimer", StoryActivityChapterBase)

function StoryStormTimer:onCtor()
	self.assetPath = "ui/viewres/story/stormcountdownsmallview.prefab"
end

function StoryStormTimer:onInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.goRoot = gohelper.findChild(self.viewGO, "Left")
	self.goNumRoot = self.goRoot
	self.goBg1 = gohelper.findChild(self.goRoot, "#normal_bg")
	self.goBg2 = gohelper.findChild(self.goRoot, "#urgent_bg")
	self.numList = {}

	for i = 1, 4 do
		table.insert(self.numList, self:createNumItem(i))
	end

	self.timeDelay = 0.33
end

function StoryStormTimer:onUpdateView()
	local chapterCo = self.data
	local param = string.splitToNumber(chapterCo.navigateChapterEn, "#")
	local bgType = param[1]
	local animType = param[2]

	self.bgType = bgType

	gohelper.setActive(self.goBg1, bgType == StoryEnum.FullScreenCountdownBgType.Normal)
	gohelper.setActive(self.goBg2, bgType == StoryEnum.FullScreenCountdownBgType.Emergency)
	self:playAnim(animType, TimeUtil.getFormatTimeTable(chapterCo.navigateLogo))
end

function StoryStormTimer:playAnim(animType, numTable)
	TaskDispatcher.cancelTask(self.playTask, self)

	if animType == StoryEnum.FullScreenCountdownAnimType.Direct then
		self.anim:Play("open", 0, 0)

		for i, v in ipairs(self.numList) do
			v:clearCurNum()
			v:setData(animType, numTable[i])
		end

		self:playTimerAudio()
	else
		self.anim:Play("open", 0, 1)

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

function StoryStormTimer:playTask()
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

function StoryStormTimer:createNumItem(index)
	local itemGO = gohelper.findChild(self.goNumRoot, string.format("num_%s", index))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, StoryStormTimerItem)

	item:setNumChangeAudio(AudioEnum.Story.play_chap13_jishiqi_di)

	return item
end

function StoryStormTimer:playClose()
	self.anim:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.hide, self, 0.17)
end

function StoryStormTimer:onHide()
	self:closeTimerAudio()
end

function StoryStormTimer:playOpenAudio()
	if self.bgType == StoryEnum.FullScreenCountdownBgType.Normal then
		AudioMgr.instance:trigger(AudioEnum.Story.play_chap13_jishiqi_xiao)
	else
		AudioMgr.instance:trigger(AudioEnum.Story.play_chap13_jishiqi_xiao2)
	end
end

function StoryStormTimer:playTimerAudio()
	local param = AudioParam.New()

	param.volume = 10
	param.fadeInTime = 1.8

	local audioId = self.bgType == StoryEnum.FullScreenCountdownBgType.Normal and AudioEnum.Story.play_chap13_jishiqi_second_lp or AudioEnum.Story.play_chap13_jishiqi_second2_lp

	if audioId then
		self.audioId = audioId

		AudioEffectMgr.instance:playAudio(audioId, param)
	end
end

function StoryStormTimer:closeTimerAudio()
	if not self.audioId then
		return
	end

	AudioEffectMgr.instance:stopAudio(self.audioId)

	self.audioId = nil
end

function StoryStormTimer:onDestory()
	self:closeTimerAudio()
	TaskDispatcher.cancelTask(self.hide, self)
	TaskDispatcher.cancelTask(self.playTask, self)
	StoryStormTimer.super.onDestory(self)
end

return StoryStormTimer
