-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchTalkTween.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkTween", package.seeall)

local RoleStoryDispatchTalkTween = class("RoleStoryDispatchTalkTween", UserDataDispose)

function RoleStoryDispatchTalkTween:ctor()
	self:__onInit()
end

function RoleStoryDispatchTalkTween:playTalkTween(list)
	self:clearTween()

	self.talkList = list

	for i, v in ipairs(self.talkList) do
		v:clearText()
	end

	self.playIndex = 0

	self:playNext()

	self.playingId = AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_type)
end

function RoleStoryDispatchTalkTween:playNext()
	local nextIndex = self.playIndex + 1
	local item = self.talkList[nextIndex]

	if item then
		self.playIndex = nextIndex

		item:startTween(self.playNext, self)
	else
		self:finishTween()
	end
end

function RoleStoryDispatchTalkTween:finishTween()
	self:stopAudio()
end

function RoleStoryDispatchTalkTween:clearTween()
	if self.talkList then
		for i, v in ipairs(self.talkList) do
			v:killTween()
		end
	end

	self:stopAudio()
end

function RoleStoryDispatchTalkTween:stopAudio()
	if self.playingId and self.playingId > 0 then
		AudioMgr.instance:stopPlayingID(self.playingId)

		self.playingId = nil
	end
end

function RoleStoryDispatchTalkTween:destroy()
	self:clearTween()
	self:__onDispose()
end

return RoleStoryDispatchTalkTween
