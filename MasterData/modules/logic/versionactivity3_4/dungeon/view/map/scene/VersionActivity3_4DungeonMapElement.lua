-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/map/scene/VersionActivity3_4DungeonMapElement.lua

module("modules.logic.versionactivity3_4.dungeon.view.map.scene.VersionActivity3_4DungeonMapElement", package.seeall)

local VersionActivity3_4DungeonMapElement = class("VersionActivity3_4DungeonMapElement", VersionActivityFixedDungeonMapElement)

function VersionActivity3_4DungeonMapElement:onClick()
	if VersionActivity3_4DungeonLogicController.instance:isInDragFrame() then
		return
	end

	VersionActivity3_4DungeonMapElement.super.onClick(self)
	VersionActivity3_4DungeonLogicController.instance:setDragFrameFlag()
end

function VersionActivity3_4DungeonMapElement:setScale(value)
	transformhelper.setLocalScale(self._transform, value, value, 1)
end

return VersionActivity3_4DungeonMapElement
