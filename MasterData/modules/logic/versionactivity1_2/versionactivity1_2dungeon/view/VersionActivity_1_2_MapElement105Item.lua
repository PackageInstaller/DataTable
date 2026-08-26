-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_MapElement105Item.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_MapElement105Item", package.seeall)

local VersionActivity_1_2_MapElement105Item = class("VersionActivity_1_2_MapElement105Item", BaseViewExtended)

function VersionActivity_1_2_MapElement105Item:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_MapElement105Item:addEvents()
	return
end

function VersionActivity_1_2_MapElement105Item:removeEvents()
	return
end

function VersionActivity_1_2_MapElement105Item:_onClick()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, self._elementId)
end

function VersionActivity_1_2_MapElement105Item:onRefreshViewParam(elementId)
	self._elementId = elementId
	self._elementConfig = lua_chapter_map_element.configDict[elementId]

	local episodeId = tonumber(self._elementConfig.param)

	self._episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	self.leftChallenge = 10
end

function VersionActivity_1_2_MapElement105Item:onOpen()
	return
end

function VersionActivity_1_2_MapElement105Item:onClose()
	return
end

function VersionActivity_1_2_MapElement105Item:onDestroyView()
	return
end

return VersionActivity_1_2_MapElement105Item
