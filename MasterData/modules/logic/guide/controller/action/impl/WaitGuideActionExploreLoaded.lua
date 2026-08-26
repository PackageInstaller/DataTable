-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionExploreLoaded.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreLoaded", package.seeall)

local WaitGuideActionExploreLoaded = class("WaitGuideActionExploreLoaded", BaseGuideAction)

function WaitGuideActionExploreLoaded:onStart(context)
	if ExploreModel.instance.isRoleInitDone and not self:_checkIsNoDone() then
		return
	end

	ExploreController.instance:registerCallback(ExploreEvent.HeroResInitDone, self.onHeroInitDone, self)
end

function WaitGuideActionExploreLoaded:onHeroInitDone()
	if not self:_checkIsNoDone() then
		return
	end

	ExploreController.instance:unregisterCallback(ExploreEvent.HeroResInitDone, self.onHeroInitDone, self)
end

function WaitGuideActionExploreLoaded:_checkIsNoDone()
	local mapId = ExploreModel.instance:getMapId()

	if not string.nilorempty(self.actionParam) and mapId ~= tonumber(self.actionParam) then
		return true
	end

	self:onDone(true)
end

function WaitGuideActionExploreLoaded:clearWork()
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroResInitDone, self.onHeroInitDone, self)
end

return WaitGuideActionExploreLoaded
