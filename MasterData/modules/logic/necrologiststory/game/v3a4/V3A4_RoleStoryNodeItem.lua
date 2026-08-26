-- chunkname: @modules/logic/necrologiststory/game/v3a4/V3A4_RoleStoryNodeItem.lua

module("modules.logic.necrologiststory.game.v3a4.V3A4_RoleStoryNodeItem", package.seeall)

local V3A4_RoleStoryNodeItem = class("V3A4_RoleStoryNodeItem", LuaCompBase)

function V3A4_RoleStoryNodeItem:init(go)
	self.go = go
	self.transform = go.transform

	recthelper.setAnchor(self.transform, 0, 0)

	self.txtName = gohelper.findChildTextMesh(self.go, "name")
	self.pointList = {}
	self.itemList = {}
	self.goPoint = gohelper.findChild(self.go, "points/goPoint")

	gohelper.setActive(self.goPoint, false)

	self.goItem = gohelper.findChild(self.go, "items/goItem")

	gohelper.setActive(self.goItem, false)

	self.btnClick = gohelper.findButtonWithAudio(self.go)
	self.btnPlay = gohelper.findChildButtonWithAudio(self.go, "btnPlay")
	self.goSelect = gohelper.findChild(self.go, "bg/go_select")
	self.goPlaying = gohelper.findChild(self.go, "bg/go_playing")
	self.goCanplay = gohelper.findChild(self.go, "bg/go_canplay")
end

function V3A4_RoleStoryNodeItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClickBtn, self)
	self.addClickCb(self, self.btnPlay, self.onClickPlay, self)
end

function V3A4_RoleStoryNodeItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
	self:removeClickCb(self.btnPlay)
end

function V3A4_RoleStoryNodeItem:onClickPlay()
	self:playAudio()
end

function V3A4_RoleStoryNodeItem:playAudio()
	self:stopAudio()
	TaskDispatcher.cancelTask(self.onAudioEnd, self)

	if self.config.audioId > 0 then
		self.playingId = AudioMgr.instance:trigger(self.config.audioId)
		self.isPlayingAudio = true

		self:refreshPlayBg()
		TaskDispatcher.runDelay(self.onAudioEnd, self, self.config.audioTime * 0.001)
	end
end

function V3A4_RoleStoryNodeItem:onAudioEnd()
	self.isPlayingAudio = false

	self:refreshPlayBg()
end

function V3A4_RoleStoryNodeItem:stopAudio()
	if self.playingId then
		AudioMgr.instance:stopPlayingID(self.playingId)

		self.playingId = nil
	end
end

function V3A4_RoleStoryNodeItem:onClickBtn()
	local itemPointCount = self.gameMo:getItemPointCount(self.config.gameId, self.config.nodeId)

	if not self.config.nodePoint then
		local pointCount = 0
		local isFinish = itemPointCount == pointCount

		if isFinish then
			return
		end

		if pointCount == 0 then
			return
		end

		self:clearItemList()
	end
end

function V3A4_RoleStoryNodeItem:setData(config, gameMo)
	self.config = config
	self.gameMo = gameMo

	self:refreshView()
end

function V3A4_RoleStoryNodeItem:refreshView()
	gohelper.setActive(self.go, self.config ~= nil)

	if not self.config then
		return
	end

	self.txtName.text = self.config.nodeName

	self:refreshItems()
	self:refreshPoints()
	self:refreshPlayBg()
end

function V3A4_RoleStoryNodeItem:refreshPlayBg()
	local isFinish = self.lastFinish
	local isPlaying = self.isPlayingAudio

	gohelper.setActive(self.goSelect, self.isSelect)
	gohelper.setActive(self.goPlaying, isFinish and isPlaying)
	gohelper.setActive(self.goCanplay, isFinish and not isPlaying)
end

function V3A4_RoleStoryNodeItem:refreshItems()
	if not self.config.nodeSlot then
		local slotCount = 0
		local putItemList, fixCount = self.gameMo:getGameNodeItemList(self.config.gameId, self.config.nodeId)

		self.isSelect = false

		for i = 1, math.max(slotCount, #self.itemList) do
			local item = self.itemList[i]

			if not item then
				item = self:getUserDataTb_()
				item.go = gohelper.cloneInPlace(self.goItem)
				item.goLight = gohelper.findChild(item.go, "light")
				item.goEmpty = gohelper.findChild(item.go, "empty")
				item.simageLight = gohelper.findChildSingleImage(item.go, "light")
				item.goSelect = gohelper.findChild(item.go, "go_select")
				item.goFixed = gohelper.findChild(item.go, "go_selected")

				table.insert(self.itemList, item)
			end

			gohelper.setActive(item.go, i <= slotCount)

			if i <= slotCount then
				local itemId = putItemList[i]
				local isPut = itemId and itemId ~= 0

				gohelper.setActive(item.goLight, isPut)
				gohelper.setActive(item.goEmpty, not isPut)
				gohelper.setActive(item.goFixed, i <= fixCount)

				if isPut then
					local config = NecrologistStoryV3A4Config.instance:getItemConfig(itemId)

					item.simageLight:LoadImage(config.resource)
					gohelper.setActive(item.goSelect, false)
				else
					local isCurrent = self.gameMo:isCurrentGameNodeIndex(self.config.gameId, self.config.nodeId, i)

					gohelper.setActive(item.goSelect, isCurrent)

					if isCurrent then
						self.isSelect = true
					end
				end
			end
		end

		self.isFullSlot = slotCount <= #putItemList
	end
end

function V3A4_RoleStoryNodeItem:refreshPoints()
	local itemPointCount = self.gameMo:getItemPointCount(self.config.gameId, self.config.nodeId)

	if not self.config.nodePoint then
		local pointCount = 0
		local isFinish = itemPointCount == pointCount

		self:setPlayBtnVisible(isFinish)

		local isError = true
		local isError

		if pointCount >= itemPointCount then
			isError = self.isFullSlot and not isFinish
		end

		for i = 1, math.max(pointCount, #self.pointList) do
			local point = self.pointList[i]

			if not point then
				point = self:getUserDataTb_()
				point.go = gohelper.cloneInPlace(self.goPoint)
				point.anim = point.go:GetComponent(typeof(UnityEngine.Animator))
				point.goLight = gohelper.findChild(point.go, "light")
				point.goEmpty = gohelper.findChild(point.go, "empty")
				point.goRed = gohelper.findChild(point.go, "red")

				table.insert(self.pointList, point)
			end

			gohelper.setActive(point.go, i <= pointCount)

			if i <= pointCount then
				local isLight = i <= itemPointCount

				gohelper.setActive(point.goLight, isLight)
				gohelper.setActive(point.goEmpty, not isLight)
				gohelper.setActive(point.goRed, false)

				if isLight then
					point.anim:Play("light")
				else
					point.anim:Play("empty")
				end
			end
		end

		if isError then
			self.isSelect = true

			self:playError()
		end
	end
end

function V3A4_RoleStoryNodeItem:setPlayBtnVisible(isFinish)
	if self.lastFinish == false and isFinish == true then
		self:playAudio()
	end

	self.lastFinish = isFinish

	gohelper.setActive(self.btnPlay, isFinish)
end

function V3A4_RoleStoryNodeItem:tryPutItem(itemConfig)
	local ret, index = self.gameMo:putGameNodeItem(self.config.gameId, self.config.nodeId, itemConfig.itemId)

	if ret then
		local item = self.itemList[index]

		return true, item
	end

	return false
end

function V3A4_RoleStoryNodeItem:playError()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_error)
	GameUtil.setActiveUIBlock(ViewName.V3A4_RoleStoryGameView, true, false)

	for _, point in ipairs(self.pointList) do
		gohelper.setActive(point.goRed, true)
		gohelper.setActive(point.goLight, false)
		gohelper.setActive(point.goEmpty, false)
		point.anim:Play("red", 0, 0)
	end

	TaskDispatcher.runDelay(self.clearItemList, self, 0.84)
end

function V3A4_RoleStoryNodeItem:clearItemList()
	GameUtil.setActiveUIBlock(ViewName.V3A4_RoleStoryGameView, false, false)
	self.gameMo:clearGameNodeItemList(self.config.gameId, self.config.nodeId)
end

function V3A4_RoleStoryNodeItem:onDestroy()
	self:stopAudio()
	TaskDispatcher.cancelTask(self.clearItemList, self)

	for _, item in ipairs(self.itemList) do
		item.simageLight:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self.onAudioEnd, self)
end

return V3A4_RoleStoryNodeItem
