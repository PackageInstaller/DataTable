-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapTaskItem.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapTaskItem", package.seeall)

local VersionActivity1_5DungeonMapTaskItem = class("VersionActivity1_5DungeonMapTaskItem", DungeonMapTaskItem)

function VersionActivity1_5DungeonMapTaskItem:setParam(param)
	if self._anim and (not self.viewGO.activeInHierarchy or self._elementId ~= param[2]) then
		self._anim:Play("taskitem_in", 0, 0)
	end

	self._index = param[1]
	self._elementId = param[2]

	local elementConfig = lua_chapter_map_element.configDict[self._elementId]

	if not elementConfig then
		logError("元件表找不到元件id:" .. self._elementId)
	end

	local subHeroTaskCo = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(self._elementId)

	self._txtinfo.text = subHeroTaskCo and subHeroTaskCo.title or elementConfig.title

	DungeonMapTaskInfoItem.setIcon(self._icon, self._elementId, "zhuxianditu_renwuicon_")
	self:refreshStatus()
end

return VersionActivity1_5DungeonMapTaskItem
