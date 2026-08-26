-- chunkname: @modules/logic/survival/controller/work/AnimatorWork.lua

module("modules.logic.survival.controller.work.AnimatorWork", package.seeall)

local AnimatorWork = class("AnimatorWork", BaseWork)

function AnimatorWork:ctor(param)
	self.player = SLFramework.AnimatorPlayer.Get(param.go)
	self.animName = param.animName
end

function AnimatorWork:onStart()
	self.player:Play(self.animName, self.onPlayFinish, self)
end

function AnimatorWork:onPlayFinish()
	self:onDone(true)
end

function AnimatorWork:onDestroy()
	self.player = nil
end

return AnimatorWork
