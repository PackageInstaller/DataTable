-- chunkname: @modules/logic/necrologiststory/game/v3a2/V3A2_RoleStoryEventView.lua

module("modules.logic.necrologiststory.game.v3a2.V3A2_RoleStoryEventView", package.seeall)

local V3A2_RoleStoryEventView = class("V3A2_RoleStoryEventView", BaseView)

function V3A2_RoleStoryEventView:addEvents()
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnSectionEnd, self._onSectionEnd, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.High)
end

function V3A2_RoleStoryEventView:removeEvents()
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnSectionEnd, self._onSectionEnd, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A2_RoleStoryEventView:_onCloseViewFinish()
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	self:checkShowItemGetView()
end

function V3A2_RoleStoryEventView:_onSectionEnd(sectionId)
	local storyMo = NecrologistStoryModel.instance:getCurStoryMO()
	local storyGroupId = storyMo.id
	local dataList = self.sectionFinishDict[storyGroupId]

	if not dataList then
		return
	end

	for _, data in ipairs(dataList) do
		local isUnlock = self.gameBaseMO:isItemUnlock(data.itemId)

		if not isUnlock and data.sectionId == sectionId then
			self:showItemGetView(data.itemId)

			break
		end
	end
end

function V3A2_RoleStoryEventView:initListenData()
	self.episodeFinishDict = {}
	self.sectionFinishDict = {}

	local list = NecrologistStoryV3A2Config.instance:getItemList()

	for _, config in ipairs(list) do
		local unlockParam = string.splitToNumber(config.unlock, "#")

		if unlockParam[1] == 1 then
			self.episodeFinishDict[unlockParam[2]] = config.id
		elseif unlockParam[1] == 2 then
			local data = {}

			data.sectionId = unlockParam[3]
			data.itemId = config.id
			self.sectionFinishDict[unlockParam[2]] = self.sectionFinishDict[unlockParam[2]] or {}

			table.insert(self.sectionFinishDict[unlockParam[2]], data)
		end
	end
end

function V3A2_RoleStoryEventView:checkShowItemGetView()
	for episodeId, itemId in pairs(self.episodeFinishDict) do
		local isUnlock = self.gameBaseMO:isItemUnlock(itemId)

		if not isUnlock then
			local isFinished = self.gameBaseMO:isBaseFinished(episodeId)

			if isFinished then
				self:showItemGetView(itemId)

				break
			end
		end
	end
end

function V3A2_RoleStoryEventView:showItemGetView(itemId)
	local isUnlock = self.gameBaseMO:isItemUnlock(itemId)

	if isUnlock then
		return
	end

	self.gameBaseMO:setItemUnlock(itemId)

	local viewParam = {}

	viewParam.itemId = itemId

	ViewMgr.instance:openView(ViewName.V3A2_RoleStoryItemGetView, viewParam)
end

function V3A2_RoleStoryEventView:onOpen()
	self:refreshParam()
	self:initListenData()
	self:checkShowItemGetView()
end

function V3A2_RoleStoryEventView:onUpdateParam()
	self:refreshParam()
end

function V3A2_RoleStoryEventView:refreshParam()
	local storyId = self.viewParam.roleStoryId

	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
end

return V3A2_RoleStoryEventView
