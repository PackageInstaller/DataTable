-- chunkname: @modules/logic/gm/view/GMSubViewFightPlayback.lua

module("modules.logic.gm.view.GMSubViewFightPlayback", package.seeall)

local GMSubViewFightPlayback = class("GMSubViewFightPlayback", GMSubViewBase)

function GMSubViewFightPlayback:ctor()
	self.tabName = "战斗录制"
end

local Width = 1400
local Height = 800

function GMSubViewFightPlayback:initViewContent()
	if self._isInit then
		return
	end

	self.goPlaybackItem = gohelper.findChild(self._goSubViews, "PlaybackItem")

	self.addButton(self, "L0", "保存当前战斗信息", self.saveCurFight, self)
	self:addLabel("L0", "文件名格式：时间_章节id_关卡id_战斗id")

	self.scrollViewGo = self:addScrollViewLimit("L1", "回放列表", Width, Height)
	self.goContent = gohelper.findChild(self.scrollViewGo, "Viewport/Content")

	self:refreshPlaybackList()

	self._isInit = true
end

function GMSubViewFightPlayback:refreshPlaybackList()
	self.playbackItemList = self.playbackItemList or self:getUserDataTb_()
	self.playBackList = FightPlayBackController.instance:getPlaybackList()

	for index, file in ipairs(self.playBackList) do
		local goItem = self.playbackItemList[index]

		if not goItem then
			goItem = gohelper.clone(self.goPlaybackItem, self.goContent)

			local deleteBtn = gohelper.findChildButton(goItem, "delete_btn")
			local sendBtn = gohelper.findChildButton(goItem, "send_btn")
			local playBtn = gohelper.findChildButton(goItem, "play_btn")

			self.addClickCb(self, deleteBtn, self.onClickPlaybackDeleteBtn, self, index)
			self.addClickCb(self, sendBtn, self.onClickPlaybackSendBtn, self, index)
			self.addClickCb(self, playBtn, self.onClickPlaybackPlayBtn, self, index)
			recthelper.setWidth(goItem.transform, Width)
			table.insert(self.playbackItemList, goItem)
		end

		local fileName = gohelper.findChildText(goItem, "filename")

		fileName.text = file

		gohelper.setActive(goItem, true)
	end

	for i = #self.playBackList + 1, #self.playbackItemList do
		gohelper.setActive(self.playbackItemList[i], false)
	end
end

function GMSubViewFightPlayback:onClickPlaybackDeleteBtn(index)
	local filename = self.playBackList[index]

	if filename then
		FightPlayBackController.instance:deletePlaybackFile(filename)
		self:refreshPlaybackList()
	end
end

function GMSubViewFightPlayback:onClickPlaybackSendBtn(index)
	local filename = self.playBackList[index]

	if filename then
		FightPlayBackController.instance:sendPlaybackFile(filename)
	end
end

function GMSubViewFightPlayback:onClickPlaybackPlayBtn(index)
	local filename = self.playBackList[index]

	if filename then
		FightPlayBackController.instance:playPlayback(filename)
	end
end

function GMSubViewFightPlayback:saveCurFight()
	local filePath = FightPlayBackController.instance:writeToFile()

	logNormal("保存成功, 文件路径：" .. filePath)
	self:refreshPlaybackList()
end

function GMSubViewFightPlayback:onDestroyView()
	return
end

return GMSubViewFightPlayback
