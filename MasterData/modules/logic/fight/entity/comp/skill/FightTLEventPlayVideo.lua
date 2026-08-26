-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventPlayVideo.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventPlayVideo", package.seeall)

local FightTLEventPlayVideo = class("FightTLEventPlayVideo", FightTimelineTrackItem)

function FightTLEventPlayVideo:onTrackStart(fightStepData, duration, paramsArr)
	self._resName = paramsArr[1]

	if not string.nilorempty(self._resName) then
		if paramsArr[2] ~= "1" and FightVideoMgr.instance:isSameVideo(self._resName) and FightVideoMgr.instance:isPause() then
			FightVideoMgr.instance:continue(self._resName)

			return
		end

		FightVideoMgr.instance:play(self._resName)

		if paramsArr[2] == "1" then
			FightVideoMgr.instance:pause()
		end
	end
end

function FightTLEventPlayVideo:onTrackEnd()
	self:_clear()
end

function FightTLEventPlayVideo:onDestructor()
	self:_clear()
end

function FightTLEventPlayVideo:_clear()
	FightVideoMgr.instance:stop()
end

return FightTLEventPlayVideo
