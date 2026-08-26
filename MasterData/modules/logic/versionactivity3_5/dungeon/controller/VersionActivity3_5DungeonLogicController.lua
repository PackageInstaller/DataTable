-- chunkname: @modules/logic/versionactivity3_5/dungeon/controller/VersionActivity3_5DungeonLogicController.lua

module("modules.logic.versionactivity3_5.dungeon.controller.VersionActivity3_5DungeonLogicController", package.seeall)

local VersionActivity3_5DungeonLogicController = class("VersionActivity3_5DungeonLogicController", BaseController)

function VersionActivity3_5DungeonLogicController:onInit()
	return
end

function VersionActivity3_5DungeonLogicController:reInit()
	return
end

function VersionActivity3_5DungeonLogicController:setDragFrameBegin()
	self._isDragging = true
end

function VersionActivity3_5DungeonLogicController:setDragFrameEnd()
	self._dragFrameCount = Time.frameCount
	self._isDragging = false
end

function VersionActivity3_5DungeonLogicController:setDragFrameFlag()
	self._dragFrameCount = Time.frameCount
end

function VersionActivity3_5DungeonLogicController:isInDragFrame()
	return self._isDragging or self._dragFrameCount and Time.frameCount - self._dragFrameCount < 2
end

VersionActivity3_5DungeonLogicController.instance = VersionActivity3_5DungeonLogicController.New()

return VersionActivity3_5DungeonLogicController
