-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_MapElementItem.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_MapElementItem", package.seeall)

local VersionActivity_1_2_MapElementItem = class("VersionActivity_1_2_MapElementItem", BaseViewExtended)

function VersionActivity_1_2_MapElementItem:onInitView()
	self._icon1 = gohelper.findChild(self.viewGO, "ani/icon1/anim")
	self._icon2 = gohelper.findChild(self.viewGO, "ani/icon2/anim")
	self._icon3 = gohelper.findChild(self.viewGO, "ani/icon3/anim")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_MapElementItem:addEvents()
	return
end

function VersionActivity_1_2_MapElementItem:removeEvents()
	return
end

function VersionActivity_1_2_MapElementItem:_onClick()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, self._elementId)
end

function VersionActivity_1_2_MapElementItem:onRefreshViewParam(elementId)
	self._elementId = elementId
	self._elementConfig = lua_chapter_map_element.configDict[elementId]

	local episodeId = tonumber(self._elementConfig.param)

	self._episodeConfig = VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(self._elementId) or DungeonConfig.instance:getEpisodeCO(episodeId)
end

function VersionActivity_1_2_MapElementItem:onOpen()
	gohelper.setActive(self._icon2, true)

	local txt = gohelper.findChild(self._icon2, "num"):GetComponent(typeof(TMPro.TextMeshPro))

	txt.text = ""
end

function VersionActivity_1_2_MapElementItem:onClose()
	return
end

function VersionActivity_1_2_MapElementItem:onDestroyView()
	return
end

return VersionActivity_1_2_MapElementItem
