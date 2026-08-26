-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgPlayAnimWork.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgPlayAnimWork", package.seeall)

local ChgPlayAnimWork = class("ChgPlayAnimWork", GaoSiNiaoWorkBase)

function ChgPlayAnimWork.s_create(csAnimatorPlayer, animName, optAudioId)
	local work = ChgPlayAnimWork.New()

	work._animatorPlayer = csAnimatorPlayer
	work._animator = csAnimatorPlayer.animator
	work._animName = animName
	work._audioId = optAudioId or 0

	return work
end

function ChgPlayAnimWork:onStart()
	self:clearWork()

	if not self._animatorPlayer then
		self:onSucc()

		return
	end

	if string.nilorempty(self._animName) then
		self:onSucc()

		return
	end

	self._animator.enabled = true

	self._animatorPlayer:Play(self._animName, self._onAnimDone, self)

	if self._audioId and self._audioId > 0 then
		AudioMgr.instance:trigger(self._audioId)
	end
end

function ChgPlayAnimWork:_onAnimDone()
	self:onSucc()
end

function ChgPlayAnimWork:clearWork()
	if self._animatorPlayer then
		self._animatorPlayer:Stop()
	end
end

return ChgPlayAnimWork
