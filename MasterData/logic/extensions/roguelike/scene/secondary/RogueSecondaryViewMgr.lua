-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/secondary/RogueSecondaryViewMgr.lua

module("logic.extensions.roguelike.scene.secondary.RogueSecondaryViewMgr", package.seeall)

local M = class("RogueSecondaryViewMgr", ISceneFlowComp)

function M:onEnter()
	self:_setEvent(true)
	ViewMgr.instance:close(ViewName.RogueMap)
end

function M:onEnterDone()
	local mapMgr = RogueMgr.instance:getMapMgr()

	if mapMgr then
		mapMgr:switchToSecondScene(true)
	end

	local data = {}

	ViewMgr.instance:open(ViewName.RogueSecondaryMap, data)
	RoguelikeController.instance:showEnterSecondarySceneAni()
end

function M:onExit()
	self:_setEvent(false)

	local mapMgr = RogueMgr.instance:getMapMgr()

	if mapMgr then
		mapMgr:switchToSecondScene(false)
	end

	ViewMgr.instance:close(ViewName.RogueSecondaryMap)
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

return M
