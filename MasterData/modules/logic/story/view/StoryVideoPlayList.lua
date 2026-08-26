-- chunkname: @modules/logic/story/view/StoryVideoPlayList.lua

module("modules.logic.story.view.StoryVideoPlayList", package.seeall)

local StoryVideoPlayList = class("StoryVideoPlayList", UserDataDispose)

StoryVideoPlayList.MaxIndexCount = 7
StoryVideoPlayList.PlayPos = {
	CommonPlay = 0,
	CommonPlay2 = 6,
	CommonLoop = 1
}
StoryVideoPlayList.Empty = ""

function StoryVideoPlayList:init(go, parent)
	self:__onInit()

	self._isPlaying = false
	self.parentGO = parent
	self.viewGO = go

	local isOverseas = SettingsModel.instance:isOverseas()
	local isVideoEnabled = SettingsModel.instance:getVideoEnabled()
	local unableVideo = not isVideoEnabled and isOverseas

	if unableVideo then
		self._uguiPlayList = AvProUGUIListPlayer_adjust.New()
		self._mediaPlayList = PlaylistMediaPlayer_adjust.New()
	else
		self._uguiPlayList = self.viewGO:GetComponent(typeof(ZProj.AvProUGUIListPlayer))
		self._mediaPlayList = self.viewGO:GetComponent(typeof(RenderHeads.Media.AVProVideo.PlaylistMediaPlayer))
		self._displayUGUI = self.viewGO:GetComponent(typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	end

	self._uguiPlayList:SetEventListener(self._onVideoEvent, self)
	recthelper.setSize(self.viewGO.transform, 2592, 1080)
	gohelper.setActive(self.viewGO, false)

	self._path2StartCallback = {}
	self._path2StartCallbackObj = {}
	self._path2StartVideoItem = {}
	self._currentPlayNameMap = {}

	for pos = 0, StoryVideoPlayList.MaxIndexCount - 1 do
		self._currentPlayNameMap[pos] = StoryVideoPlayList.Empty
	end
end

function StoryVideoPlayList:buildAndStart(videoName, loop, startCall, startCallObj, videoItem)
	StoryController.instance:dispatchEvent(StoryEvent.VideoStart, videoName, loop)

	local targetIndex = loop and StoryVideoPlayList.PlayPos.CommonLoop or self:getNextNormalPlayIndex()
	local targetPlayName = self._currentPlayNameMap[targetIndex]

	logNormal(string.format("StoryVideoPlayList play set path : [%s] \nto index [%s], loop = %s", tostring(videoName), tostring(targetIndex), tostring(loop)))

	self._path2StartCallback[videoName] = startCall
	self._path2StartCallbackObj[videoName] = startCallObj
	self._path2StartVideoItem[videoName] = videoItem

	gohelper.setActive(self.viewGO, true)
	self:setPathAtIndex(videoName, targetIndex)
	self._mediaPlayList:JumpToItem(targetIndex)

	if not self._isPlaying then
		self._mediaPlayList:Play()
		self._mediaPlayList:JumpToItem(targetIndex)

		self._isPlaying = true
	end

	if not string.nilorempty(targetPlayName) then
		logNormal(string.format("video still playing : [%s], loop mode = [%s] will stop!", tostring(targetPlayName), tostring(loop)))
		self:stop(targetPlayName)
	end

	self:_startIOSDetectPause()
end

function StoryVideoPlayList:setPauseState(videoName, pauseOrPlay)
	local curPlayIndex = self._mediaPlayList.PlaylistIndex
	local playName = self._currentPlayNameMap[curPlayIndex]

	if videoName == playName and self._mediaPlayList then
		if pauseOrPlay then
			self._mediaPlayList:Play()
			self:_startIOSDetectPause()
		else
			self._mediaPlayList:Pause()
			self:_stopIOSDetectPause()
		end
	end
end

function StoryVideoPlayList:stop(targetName)
	if not self._mediaPlayList then
		return
	end

	local curPlayIndex = self._mediaPlayList.PlaylistIndex

	for index, name in pairs(self._currentPlayNameMap) do
		if name == targetName then
			self._currentPlayNameMap[index] = nil
			self._currentPlayNameMap[curPlayIndex] = targetName
		end
	end

	local playName = self._currentPlayNameMap[curPlayIndex]
	local isVideoEnabled = SettingsModel.instance:getVideoEnabled()

	if playName == targetName or not isVideoEnabled then
		logNormal("targetName = " .. tostring(targetName) .. " stop!")
		self:_stopIOSDetectPause()

		if self._mediaPlayList then
			self._mediaPlayList:Stop()
		end

		self:setParent(self.parentGO)
		gohelper.setActive(self.viewGO, false)
	end

	for pos, path in pairs(self._currentPlayNameMap) do
		if path == targetName then
			self:setPathAtIndex(StoryVideoPlayList.Empty, pos)
		end
	end

	self._path2StartCallback[targetName] = nil
	self._path2StartCallbackObj[targetName] = nil
	self._path2StartVideoItem[targetName] = nil

	self:checkAllStop()
end

function StoryVideoPlayList:checkAllStop()
	if not self._currentPlayNameMap then
		logNormal("null playlist, now stop play.")

		self._isPlaying = false
	else
		for pos, name in pairs(self._currentPlayNameMap) do
			if name ~= StoryVideoPlayList.Empty then
				return
			end
		end

		logNormal("empty playlist, now stop play.")

		self._isPlaying = false
	end
end

function StoryVideoPlayList:clearOtherIndex(curPlayIndex)
	for index, name in pairs(self._currentPlayNameMap) do
		if index ~= curPlayIndex then
			local videoName = self._currentPlayNameMap[index]

			self._currentPlayNameMap[index] = nil
			self._path2StartCallback[videoName] = nil
			self._path2StartCallbackObj[videoName] = nil
			self._path2StartVideoItem[videoName] = nil
		end
	end
end

function StoryVideoPlayList:fixNeedPlayVideo(eventVideoName)
	local videoName, curPos

	for pos, name in pairs(self._currentPlayNameMap) do
		if name ~= StoryVideoPlayList.Empty then
			videoName = name
			curPos = pos

			break
		end
	end

	logNormal(string.format("check need fix video curName [%s] evt [%s] curPos [%s] list [%s]", tostring(videoName), tostring(eventVideoName), tostring(curPos), tostring(self._mediaPlayList.PlaylistIndex)))

	if videoName ~= eventVideoName and not gohelper.isNil(self._mediaPlayList) and self._mediaPlayList.PlaylistIndex == curPos then
		self._mediaPlayList:JumpToItem(curPos)
		self._mediaPlayList:Play()
		self._mediaPlayList:JumpToItem(curPos)
		logNormal("try fix play index : " .. tostring(curPos) .. " name : " .. tostring(videoName))
	end
end

function StoryVideoPlayList:setPathAtIndex(videoName, index)
	if string.nilorempty(videoName) then
		self._uguiPlayList:SetMediaPath(StoryVideoPlayList.Empty, index)

		self._currentPlayNameMap[index] = StoryVideoPlayList.Empty
	else
		self:clearOtherIndex(index)
		self._uguiPlayList:SetMediaPath(videoName, index)

		self._currentPlayNameMap[index] = videoName
	end
end

function StoryVideoPlayList:setParent(parentGO)
	gohelper.addChildPosStay(parentGO, self.viewGO)
end

function StoryVideoPlayList:_onVideoEvent(path, status, errorCode)
	local pathSplits = string.split(path, "/")
	local videoName = pathSplits[#pathSplits]

	pathSplits = string.split(videoName, ".")
	videoName = pathSplits[1] or videoName

	logNormal(string.format("StoryVideoPlayList:_onVideoEvent, path = %s \nstatus = %s errorCode = %s\ntime = %s", tostring(path), tostring(VideoEnum.getPlayerStatusEnumName(status)), VideoEnum.getErrorCodeEnumName(errorCode), tostring(Time.time)))

	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		self:fixNeedPlayVideo(videoName)
		self:_stopIOSDetectPause()
	elseif status == VideoEnum.PlayerStatus.FirstFrameReady and BootNativeUtil.isIOS() and self._path2StartCallback[videoName] then
		self._path2StartCallback[videoName](self._path2StartCallbackObj[videoName], self._path2StartVideoItem[videoName])
	end

	if errorCode ~= VideoEnum.ErrorCode.None then
		self:stop(videoName)
		self:_stopIOSDetectPause()
	end
end

function StoryVideoPlayList:_detectPause()
	if self._mediaPlayList and self._mediaPlayList:IsPaused() then
		self._mediaPlayList:Play()
	end
end

function StoryVideoPlayList:_startIOSDetectPause()
	if BootNativeUtil.isIOS() then
		TaskDispatcher.runRepeat(self._detectPause, self, 0.05)
	end
end

function StoryVideoPlayList:_stopIOSDetectPause()
	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(self._detectPause, self)
	end
end

function StoryVideoPlayList:getNextNormalPlayIndex()
	self._lastNormalIndex = (self._lastNormalIndex == nil or self._lastNormalIndex == StoryVideoPlayList.PlayPos.CommonPlay2) and StoryVideoPlayList.PlayPos.CommonPlay or StoryVideoPlayList.PlayPos.CommonPlay2

	return self._lastNormalIndex
end

function StoryVideoPlayList:dispose()
	if self._uguiPlayList then
		self._uguiPlayList:Clear()
	end

	self:_stopIOSDetectPause()
	self:__onDispose()
end

return StoryVideoPlayList
