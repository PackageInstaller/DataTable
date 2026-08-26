-- chunkname: @modules/logic/versionactivity3_2/dungeon/controller/VersionActivity3_2DungeonLogicController.lua

module("modules.logic.versionactivity3_2.dungeon.controller.VersionActivity3_2DungeonLogicController", package.seeall)

local VersionActivity3_2DungeonLogicController = class("VersionActivity3_2DungeonLogicController", BaseController)

function VersionActivity3_2DungeonLogicController:onInit()
	return
end

function VersionActivity3_2DungeonLogicController:reInit()
	return
end

function VersionActivity3_2DungeonLogicController:setDragFrameBegin()
	self._isDragging = true
end

function VersionActivity3_2DungeonLogicController:setDragFrameEnd()
	self._dragFrameCount = Time.frameCount
	self._isDragging = false
end

function VersionActivity3_2DungeonLogicController:setDragFrameFlag()
	self._dragFrameCount = Time.frameCount
end

function VersionActivity3_2DungeonLogicController:isInDragFrame()
	return self._isDragging or self._dragFrameCount and Time.frameCount - self._dragFrameCount < 2
end

VersionActivity3_2DungeonLogicController.instance = VersionActivity3_2DungeonLogicController.New()

return VersionActivity3_2DungeonLogicController
