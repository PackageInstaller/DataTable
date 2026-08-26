-- chunkname: @modules/logic/story/view/StormTimer/StoryStormTimerItem.lua

module("modules.logic.story.view.StormTimer.StoryStormTimerItem", package.seeall)

local StoryStormTimerItem = class("StoryStormTimerItem", LuaCompBase)

function StoryStormTimerItem:init(go)
	self.go = go
	self.txtNew = gohelper.findChildText(self.go, "num_new")
	self.txtOld = gohelper.findChildText(self.go, "num_old")
	self.anim = self.go:GetComponent(gohelper.Type_Animator)
	self.animEvent = self.go:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animEvent:AddEventListener("showIdle", self.setNumIdle, self)
end

function StoryStormTimerItem:addEventListeners()
	return
end

function StoryStormTimerItem:removeEventListeners()
	return
end

function StoryStormTimerItem:onDestroy()
	self.animEvent:RemoveAllEventListener()

	if self.audioId then
		AudioEffectMgr.instance:stopAudio(self.audioId)

		self.audioId = nil
	end
end

function StoryStormTimerItem:setNumChangeAudio(audioId, volume)
	self.audioId = audioId
	self.volume = volume
end

function StoryStormTimerItem:setData(animType, num)
	if animType == StoryEnum.FullScreenCountdownAnimType.Up then
		self.anim:Play("up", 0, 0)
		self:setNum(num)
	elseif animType == StoryEnum.FullScreenCountdownAnimType.Down then
		self.anim:Play("down", 0, 0)
		self:setNum(num)
	else
		self.anim:Play("idle", 0, 0)

		self.curNum = num

		self:setNumIdle()
	end
end

function StoryStormTimerItem:setNumPre(num)
	self.txtNew.text = self:getCurNum() or 0
	self.txtOld.text = num or 0
	self.curNum = num
end

function StoryStormTimerItem:setNum(num)
	self.txtNew.text = num or 0
	self.txtOld.text = self:getCurNum() or 0
	self.curNum = num

	self:playAudio()
end

function StoryStormTimerItem:setNumIdle()
	self.txtNew.text = ""
	self.txtOld.text = self:getCurNum() or 0
end

function StoryStormTimerItem:getCurNum()
	return self.curNum
end

function StoryStormTimerItem:clearCurNum()
	self.curNum = nil
end

function StoryStormTimerItem:playAudio()
	local param = AudioParam.New()

	param.volume = self.volume or 10

	if self.audioId then
		AudioEffectMgr.instance:playAudio(self.audioId, param)
	end
end

return StoryStormTimerItem
