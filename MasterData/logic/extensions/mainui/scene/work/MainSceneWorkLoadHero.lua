-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/work/MainSceneWorkLoadHero.lua

module("logic.extensions.mainui.scene.work.MainSceneWorkLoadHero", package.seeall)

local M = class("MainSceneWorkLoadHero", WorkBase)

function M:onEnter(context)
	self:_setEvent(true)

	self._pointMap = {}

	for point, _ in pairs(MainPerformConfig.instance:getInteractPointMap() or {}) do
		self._pointMap[point] = 1
	end

	self._pointMap[MainPerformEnum.ElementPointAdjutant] = 1

	local curSceneFlow = context

	if not curSceneFlow then
		printError("could not found curSceneFlow!")
		self:_setEvent(false)
		self:onDone(WorkResult.Succeed)

		return
	end

	curSceneFlow.performMgr:loadMainSceneCharacter()
end

function M:onExit(isInterrupt)
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_SHOW_UP, self._onHeroShowUp, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_SHOW_UP, self._onHeroShowUp, self)
	end
end

function M:_onHeroShowUp(e, pointId, heroId, unit, defaultAnimState)
	if Astral.OSDef.isEditor then
		printWarn(string.format("交互点[%s]角色[%s]%s showUp", pointId, heroId, ContainmentUtil.getHeroName(heroId)))
	end

	self._pointMap[pointId] = nil

	if TableUtil.getLen(self._pointMap) == 0 then
		self:_onAllHeroShowUp()
	end
end

function M:_onAllHeroShowUp()
	self:onDone(WorkResult.Succeed)
end

return M
