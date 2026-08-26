-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionExploreTransferFinish.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreTransferFinish", package.seeall)

local WaitGuideActionExploreTransferFinish = class("WaitGuideActionExploreTransferFinish", BaseGuideAction)

function WaitGuideActionExploreTransferFinish:onStart(context)
	ExploreController.instance:registerCallback(ExploreEvent.HeroStatuEnd, self._onHeroStatuEnd, self)
end

function WaitGuideActionExploreTransferFinish:_onHeroStatuEnd(status)
	if status == ExploreAnimEnum.RoleAnimStatus.Entry then
		self:onDone(true)
	end
end

function WaitGuideActionExploreTransferFinish:clearWork()
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroStatuEnd, self._onHeroStatuEnd, self)
end

return WaitGuideActionExploreTransferFinish
