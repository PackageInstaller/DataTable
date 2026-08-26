-- chunkname: @modules/logic/teaching/controller/TeachingController.lua

module("modules.logic.teaching.controller.TeachingController", package.seeall)

local TeachingController = class("TeachingController", BaseController)

function TeachingController:onInit()
	return
end

function TeachingController:onInitFinish()
	return
end

function TeachingController:addConstEvents()
	return
end

function TeachingController:reInit()
	return
end

function TeachingController:openTeachingMainView(cb, cbTarget)
	TeachingRpc.instance:sendGetTeachingInfo(function()
		ViewMgr.instance:openView(ViewName.TeachingEnterView)

		if cb then
			callWithCatch(cb, cbTarget)
		end
	end, self)
end

function TeachingController:enterEpisodeId(teachingId)
	TeachingModel.instance:setNeedOpenView(ViewName.TeachingMainView)

	local episodeId = TeachingConfig.instance:getFirstEpisodeIdByTeachId(teachingId)

	if episodeId == nil then
		return
	end

	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCo == nil then
		return
	end

	local chapterId = episodeCo.chapterId

	DungeonFightController.instance:enterFight(chapterId, episodeId)
end

function TeachingController:heroInfoUpdate(heroInfo)
	if heroInfo == nil then
		return
	end

	for _, heroMo in ipairs(heroInfo) do
		if heroMo.isNew then
			local heroConfig = HeroConfig.instance:getHeroCO(heroMo.heroId)
			local allBattleTag = HeroConfig.instance:getHeroBattleTagList(heroConfig.id)

			if allBattleTag then
				for i = 1, tabletool.len(allBattleTag) do
					local tag = allBattleTag[i]
					local teachingConfig = TeachingConfig.instance:getTeachingConfigByBattleTag(tag)

					if teachingConfig then
						TeachingModel.instance:updateTeachingPopData(heroConfig.id, teachingConfig.id)
					end
				end
			end
		end
	end
end

function TeachingController:checkTeachingPopView()
	local popData = TeachingModel.instance:getTeachingPopData()

	if popData == nil then
		return
	end

	ViewMgr.instance:openView(ViewName.TeachingPopView, popData)
	TeachingModel.instance:clearTeachingPopData()
end

function TeachingController:openCacheTeachingView()
	local needOpenView = TeachingModel.instance:getNeedOpenView()

	if needOpenView == nil then
		return
	end

	MainController.instance:openMainThumbnailView()
	self:openTeachingMainView(function()
		if needOpenView == ViewName.TeachNoteView then
			TeachNoteController.instance:enterTeachNoteView(nil, false)

			return
		end

		if needOpenView then
			local teachingId = TeachingModel.instance:getSelectTeachingId()

			ViewMgr.instance:openView(needOpenView, {
				TeachingId = teachingId
			})
		end
	end, nil)
	TeachingModel.instance:setNeedOpenView(nil)
end

TeachingController.instance = TeachingController.New()

return TeachingController
