-- chunkname: @modules/logic/gm/view/GMVideoListContainer.lua

module("modules.logic.gm.view.GMVideoListContainer", package.seeall)

local GMVideoListContainer = class("GMVideoListContainer", BaseViewContainer)

GMVideoListContainer.listModel = ListScrollModel.New()

function GMVideoListContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "rightviewport"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "rightviewport/item"
	scrollParam.cellClass = GMVideoListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 2
	scrollParam.cellWidth = 500
	scrollParam.cellHeight = 90
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local views = {}

	table.insert(views, LuaListScrollView.New(GMVideoListContainer.listModel, scrollParam))

	return views
end

function GMVideoListContainer:onContainerInit()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")

	self._btnClose:AddClickListener(self.closeThis, self)
	GMVideoListContainer.listModel:clear()

	local list = {}

	if SLFramework.FrameworkSettings.IsEditor then
		local videosPath = SLFramework.FrameworkSettings.AssetRootDir .. "/videos/"
		local allVideoPaths = SLFramework.FileHelper.GetDirFilePaths(videosPath)
		local count = allVideoPaths.Length

		for i = 0, count - 1 do
			local videoPath = allVideoPaths[i]

			if string.sub(videoPath, -4) == ".mp4" then
				local videoName = SLFramework.FileHelper.GetFileName(videoPath, false)

				if not string.find(videoPath, "Android") then
					table.insert(list, {
						video = videoName
					})
				end
			end
		end
	else
		local videosPath = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/"
		local allVideoPaths = SLFramework.FileHelper.GetDirFilePaths(videosPath)

		if allVideoPaths then
			for i = 0, allVideoPaths.Length - 1 do
				local videoPath = allVideoPaths[i]

				if string.sub(videoPath, -4) == ".mp4" then
					local videoName = SLFramework.FileHelper.GetFileName(videoPath, false)

					table.insert(list, {
						video = videoName
					})
				end
			end
		end
	end

	table.sort(list, function(mo1, mo2)
		return mo1.video < mo2.video
	end)
	GMVideoListContainer.listModel:addList(list)
end

function GMVideoListContainer:onContainerDestroy()
	self._btnClose:RemoveClickListener()
end

function GMVideoListContainer:onContainerClickModalMask()
	self:closeThis()
end

return GMVideoListContainer
