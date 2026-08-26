-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadDoneWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadDoneWork", package.seeall)

local FightPreloadDoneWork = class("FightPreloadDoneWork", BaseWork)

function FightPreloadDoneWork:onStart(context)
	local scene = GameSceneMgr.instance:getScene(SceneType.Fight)

	scene.preloader:dispatchEvent(FightSceneEvent.OnPreloadFinish)
	self:onDone(true)
end

return FightPreloadDoneWork
