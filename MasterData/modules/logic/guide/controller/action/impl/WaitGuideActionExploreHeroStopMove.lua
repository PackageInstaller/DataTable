-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionExploreHeroStopMove.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreHeroStopMove", package.seeall)

local WaitGuideActionExploreHeroStopMove = class("WaitGuideActionExploreHeroStopMove", BaseGuideAction)

function WaitGuideActionExploreHeroStopMove:onStart(context)
	local map = ExploreController.instance:getMap()

	if not map then
		self:onDone(true)

		return
	end

	local hero = map:getHero()

	if not hero:isMoving() then
		self:onDone(true)

		return
	end

	GuideBlockMgr.instance:startBlock(99999999)
	ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, self.onMoveEnd, self)
end

function WaitGuideActionExploreHeroStopMove:onMoveEnd()
	self:onDone(true)
end

function WaitGuideActionExploreHeroStopMove:clearWork()
	GuideBlockMgr.instance:removeBlock()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, self.onMoveEnd, self)
end

return WaitGuideActionExploreHeroStopMove
