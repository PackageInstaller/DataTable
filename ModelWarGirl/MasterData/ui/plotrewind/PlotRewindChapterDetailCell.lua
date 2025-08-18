-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\PlotRewindChapterDetailCell.lua

local strClassName = "PlotRewindDetailCell"
local SubpackageHelper = require("Helper/SubpackageHelper")
local ResAchieve = require("ClientData/ResAchieve")
local PlotRewindDetailCell = Class(strClassName, UIControls.Child)

function PlotRewindDetailCell:ctor()
	self.titleText = UIControls.Label(self, "TitleText")
	self.descText = UIControls.Label(self, "TipsText")
	self.lockNode = UIControls.Panel(self, "LockNode")
	self.lockText = UIControls.Label(self, "LockNode/LockConditions")
	self.videoBtn = UIControls.Button(self, "MovieBtn")

	self.videoBtn:addEventClick(self.onBtnMovie)

	self.playBtn = UIControls.Button(self, "PlayBtn")

	self.playBtn:addEventClick(self.onBtnPlay)
end

function PlotRewindDetailCell:onBtnMovie()
	if self.isLocked then
		MsgManager.notice(Lang.get(45495))

		return
	end

	local files = self.detailInfo.video_path
	local videoIDs = self.detailInfo.video_id
	local loaded, subJob = self:checkVideoDownload(files)

	if loaded then
		self:_realPlayVideo(files, videoIDs)
	else
		SubpackageHelper.tryDownloadJob(subJob, Functor(self._realPlayVideo, self, files), nil)
	end
end

function PlotRewindDetailCell:onBtnPlay()
	if self.isLocked then
		MsgManager.notice(Lang.get(45495))

		return
	end

	local sections = self.detailInfo.section

	if sections then
		self.curAVGSections = {}

		for k, v in pairs(sections) do
			self.curAVGSections[k] = sections[k].id
		end

		if #self.curAVGSections >= 1 then
			local section = self.curAVGSections[1]

			table.remove(self.curAVGSections, 1)
			UIManager.playAVG(section, nil, Slot(self.playAVGCB, self))
		end
	end
end

function PlotRewindDetailCell:playAVGCB()
	if #self.curAVGSections >= 1 then
		local section = self.curAVGSections[1]

		table.remove(self.curAVGSections, 1)
		UIManager.playAVG(section, nil, Slot(self.playAVGCB, self))
	end
end

function PlotRewindDetailCell:checkVideoDownload(files)
	if not files then
		return true, nil
	end

	local jobName = table.concat(files, ",")
	local allLoaded, subJob = SubpackageHelper.checkDownloadFileByMultiPath(jobName, files)

	if allLoaded then
		return true, nil
	else
		return false, subJob
	end
end

function PlotRewindDetailCell:_realPlayVideo(files, videoIDs)
	if files then
		self.curVideoPaths = {}

		for k, v in pairs(files) do
			self.curVideoPaths[k] = {
				path = files[k]
			}

			if videoIDs and videoIDs[k] and videoIDs[k] ~= 0 then
				self.curVideoPaths[k].id = videoIDs[k]
			end
		end

		if #self.curVideoPaths >= 1 then
			local video = self.curVideoPaths[1].path
			local id = self.curVideoPaths[1].id

			table.remove(self.curVideoPaths, 1)
			UIManager.playAVGVideo(video, id, Slot(self._realPlayVideoCB, self))
		end
	end
end

function PlotRewindDetailCell:_realPlayVideoCB()
	if #self.curVideoPaths >= 1 then
		local video = self.curVideoPaths[1].path
		local id = self.curVideoPaths[1].id

		table.remove(self.curVideoPaths, 1)
		UIManager.playAVGVideo(video, id, Slot(self._realPlayVideoCB, self))
	end
end

function PlotRewindDetailCell:setData(detailInfo)
	self.detailInfo = detailInfo

	self:setVisible(true)
	self.titleText:setText(detailInfo.title)
	self.descText:setText(detailInfo.desc)
	self.videoBtn:setVisible(detailInfo.video_path ~= nil)
end

function PlotRewindDetailCell:setLocked(locked, desc)
	self.isLocked = locked

	self.lockNode:setVisible(locked)

	if desc and locked then
		self.lockText:setText(desc)
		self.lockText:setVisible(true)
	else
		self.lockText:setVisible(false)
	end
end

return PlotRewindDetailCell
