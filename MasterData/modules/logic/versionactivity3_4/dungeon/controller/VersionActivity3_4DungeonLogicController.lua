-- chunkname: @modules/logic/versionactivity3_4/dungeon/controller/VersionActivity3_4DungeonLogicController.lua

module("modules.logic.versionactivity3_4.dungeon.controller.VersionActivity3_4DungeonLogicController", package.seeall)

local VersionActivity3_4DungeonLogicController = class("VersionActivity3_4DungeonLogicController", BaseController)

function VersionActivity3_4DungeonLogicController:onInit()
	return
end

function VersionActivity3_4DungeonLogicController:reInit()
	return
end

function VersionActivity3_4DungeonLogicController:setDragFrameBegin()
	self._isDragging = true
end

function VersionActivity3_4DungeonLogicController:setDragFrameEnd()
	self._dragFrameCount = Time.frameCount
	self._isDragging = false
end

function VersionActivity3_4DungeonLogicController:setDragFrameFlag()
	self._dragFrameCount = Time.frameCount
end

function VersionActivity3_4DungeonLogicController:isInDragFrame()
	return self._isDragging or self._dragFrameCount and Time.frameCount - self._dragFrameCount < 2
end

VersionActivity3_4DungeonLogicController.instance = VersionActivity3_4DungeonLogicController.New()

return VersionActivity3_4DungeonLogicController
