-- chunkname: @modules/logic/versionactivity2_4/music/controller/VersionActivity2_4MusicController.lua

module("modules.logic.versionactivity2_4.music.controller.VersionActivity2_4MusicController", package.seeall)

local VersionActivity2_4MusicController = class("VersionActivity2_4MusicController", BaseController)

function VersionActivity2_4MusicController:onInit()
	return
end

function VersionActivity2_4MusicController:onInitFinish()
	return
end

function VersionActivity2_4MusicController:addConstEvents()
	return
end

function VersionActivity2_4MusicController:reInit()
	return
end

function VersionActivity2_4MusicController:onEnterBeatView(episodeId)
	self._episodeId = episodeId
	self._enterBeatViewTime = Time.time
end

function VersionActivity2_4MusicController:trackBeatView(result, activity_points, creation_result)
	local properties = {}

	properties[StatEnum.EventProperties.Bakaluoer_useTime] = math.floor(Time.time - self._enterBeatViewTime)
	properties[StatEnum.EventProperties.Bakaluoer_episodeId] = tostring(self._episodeId)
	properties[StatEnum.EventProperties.Bakaluoer_result] = VersionActivity2_4MusicEnum.BeatResultStatName[result]
	properties[StatEnum.EventProperties.Bakaluoer_activity_points] = activity_points
	properties[StatEnum.EventProperties.Bakaluoer_creation_result] = creation_result

	StatController.instance:track(StatEnum.EventName.Exit_Barcarola_activity, properties)

	self._enterBeatViewTime = Time.time
end

function VersionActivity2_4MusicController:trackFreeView(time)
	local properties = {}

	properties[StatEnum.EventProperties.Bakaluoer_audio_duration] = time

	StatController.instance:track(StatEnum.EventName.Barcarola_record, properties)
end

function VersionActivity2_4MusicController:openVersionActivity2_4MusicChapterView(param, isImmediate)
	Activity179Rpc.instance:sendGet179InfosRequest(Activity179Model.instance:getActivityId(), function(cmd, resultCode, msg)
		if resultCode ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicChapterView, param, isImmediate)
	end)
end

function VersionActivity2_4MusicController:openVersionActivity2_4MusicTaskView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicTaskView, param, isImmediate)
end

function VersionActivity2_4MusicController:openVersionActivity2_4MusicFreeView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeView, param, isImmediate)
end

function VersionActivity2_4MusicController:openVersionActivity2_4MusicBeatView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicBeatView, param, isImmediate)
end

function VersionActivity2_4MusicController:openVersionActivity2_4MusicFreeInstrumentSetView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeInstrumentSetView, param, isImmediate)
end

function VersionActivity2_4MusicController:openVersionActivity2_4MusicFreeAccompanyView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeAccompanyView, param, isImmediate)
end

function VersionActivity2_4MusicController:openVersionActivity2_4MusicFreeCalibrationView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeCalibrationView, param, isImmediate)
end

function VersionActivity2_4MusicController:openVersionActivity2_4MusicFreeImmerseView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeImmerseView, param, isImmediate)
end

function VersionActivity2_4MusicController:openVersionActivity2_4MusicBeatResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicBeatResultView, param, isImmediate)
end

function VersionActivity2_4MusicController:initBgm()
	self._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Stop
end

function VersionActivity2_4MusicController:bgmIsPlay()
	return self._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Play
end

function VersionActivity2_4MusicController:bgmIsStop()
	return self._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Stop
end

function VersionActivity2_4MusicController:playBgm(id)
	if self._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Play then
		logError("VersionActivity2_4MusicController Bgm is playing")

		return
	end

	if self._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Stop then
		logError("VersionActivity2_4MusicController playBgm() Bgm is not stop")
	end

	self._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Play

	AudioMgr.instance:trigger(id)
end

function VersionActivity2_4MusicController:pauseBgm()
	if self._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Pause then
		return
	end

	if self._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Play and self._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Resume then
		logError("VersionActivity2_4MusicController pauseBgm() Bgm is not playing")
	end

	self._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Pause

	AudioMgr.instance:trigger(VersionActivity2_4MusicEnum.BgmPause)
end

function VersionActivity2_4MusicController:resumeBgm()
	if self._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Resume then
		logError("VersionActivity2_4MusicController Bgm is Resume playing")

		return
	end

	if self._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Pause then
		logError("VersionActivity2_4MusicController resumeBgm() Bgm is not Pause")
	end

	self._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Resume

	AudioMgr.instance:trigger(VersionActivity2_4MusicEnum.BgmResume)
end

function VersionActivity2_4MusicController:stopBgm()
	self._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Stop

	AudioMgr.instance:trigger(VersionActivity2_4MusicEnum.BgmStop)
end

VersionActivity2_4MusicController.instance = VersionActivity2_4MusicController.New()

return VersionActivity2_4MusicController
