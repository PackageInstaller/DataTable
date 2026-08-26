-- chunkname: @modules/logic/explore/controller/steps/ExploreSuccessStep.lua

module("modules.logic.explore.controller.steps.ExploreSuccessStep", package.seeall)

local ExploreSuccessStep = class("ExploreSuccessStep", ExploreStepBase)

function ExploreSuccessStep:onStart()
	ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
	GameSceneMgr.instance:getCurScene().stat:onTriggerExit(ExploreController.instance:getMap():getUnitByType(ExploreEnum.ItemType.Exit).id)
	ExploreModel.instance:addChallengeCount()

	local map = ExploreController.instance:getMap()
	local exitUnit = map:getUnitByType(ExploreEnum.ItemType.Exit)
	local hero = map:getHero()

	hero:onCheckDir(hero.nodePos, exitUnit.nodePos)
	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Finish, true)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreSuccessStep")

	local finialPos = (exitUnit:getPos() - hero:getPos()):SetNormalize():Mul(1.3):Add(hero:getPos())

	finialPos.y = finialPos.y + 0.25

	hero:setTrOffset(nil, finialPos, 2, nil, nil, EaseType.InOutSine)
	TaskDispatcher.runDelay(self.showFinishView, self, 2.3)
end

function ExploreSuccessStep:showFinishView()
	ViewMgr.instance:openView(ViewName.ExploreFinishView, self._data)
	self:onDone()

	local mapId = ExploreModel.instance:getMapId()
	local list = DungeonConfig.instance:getExploreChapterList()
	local isFind = false

	for i = 1, #list do
		local episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(list[i].id)

		for j = 1, #episodeCoList do
			local mapCo = lua_explore_scene.configDict[list[i].id][episodeCoList[j].id]

			if isFind then
				if not ExploreSimpleModel.instance:getEpisodeIsShowUnlock(mapCo.chapterId, mapCo.episodeId) then
					ExploreSimpleModel.instance:setLastSelectMap(mapCo.chapterId, mapCo.episodeId)
				end

				return
			elseif mapCo.id == mapId then
				isFind = true
			end
		end
	end
end

function ExploreSuccessStep:onDestory()
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreSuccessStep")
end

return ExploreSuccessStep
