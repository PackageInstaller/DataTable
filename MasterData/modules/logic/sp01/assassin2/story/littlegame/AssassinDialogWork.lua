-- chunkname: @modules/logic/sp01/assassin2/story/littlegame/AssassinDialogWork.lua

module("modules.logic.sp01.assassin2.story.littlegame.AssassinDialogWork", package.seeall)

local AssassinDialogWork = class("AssassinDialogWork", BaseWork)

function AssassinDialogWork:ctor(dialogId, callback, callbackObj, callbackParams)
	self._dialogId = dialogId
	self._callback = callback
	self._callbackObj = callbackObj
	self._callbackParams = callbackParams
end

function AssassinDialogWork:onStart()
	if not self._dialogId then
		self:onDone(false)

		return
	end

	VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(self._dialogId, self._onDialogDone, self)
end

function AssassinDialogWork:_onDialogDone()
	if self._callback then
		self._callback(self._callbackObj, self._callbackParams)
	end

	self:onDone(true)
end

return AssassinDialogWork
