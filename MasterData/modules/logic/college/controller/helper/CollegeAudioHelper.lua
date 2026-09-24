-- chunkname: @modules/logic/college/controller/helper/CollegeAudioHelper.lua

module("modules.logic.college.controller.helper.CollegeAudioHelper", package.seeall)

local CollegeAudioHelper = class("CollegeAudioHelper")

function CollegeAudioHelper:playAudio(audioId)
	if not audioId or audioId <= 0 then
		return
	end

	AudioMgr.instance:trigger(audioId)
end

function CollegeAudioHelper:clear()
	AudioMgr.instance:trigger(CollegeAudioEnum.ChessMoveStop)
	AudioMgr.instance:trigger(CollegeAudioEnum.SlideMilestoneViewStop)
end

CollegeAudioHelper.instance = CollegeAudioHelper.New()

return CollegeAudioHelper
