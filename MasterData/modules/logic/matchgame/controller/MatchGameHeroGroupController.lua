-- chunkname: @modules/logic/matchgame/controller/MatchGameHeroGroupController.lua

module("modules.logic.matchgame.controller.MatchGameHeroGroupController", package.seeall)

local MatchGameHeroGroupController = class("MatchGameHeroGroupController", BaseController)

function MatchGameHeroGroupController:replaceSlot(posIndex, characterId)
	local teamId = MatchGameHeroGroupModel.instance:getCurTeamId()
	local teamHeroes = MatchGameHeroGroupModel.instance:getCurTeamHeroes()

	if not teamHeroes then
		return
	end

	local characterIds = {}

	for i = 1, MatchGameEnum.HeroGroupMaxHeroCount do
		if i == posIndex then
			characterIds[i] = characterId
		else
			local singleMo = teamHeroes[i]

			if singleMo then
				if not singleMo.id then
					local heroId = 0

					characterIds[i] = heroId ~= characterId and heroId or 0
				end
			end
		end
	end

	self:saveToServer(teamId, characterIds)
end

function MatchGameHeroGroupController:swapSlots(teamId, posA, posB)
	local characterIds = {}
	local teamHeroes = MatchGameHeroGroupModel.instance:getCurTeamHeroes()

	for i = 1, MatchGameEnum.HeroGroupMaxHeroCount do
		local singleMo = teamHeroes[i]

		if singleMo then
			characterIds[i] = singleMo.id or 0
		end
	end

	characterIds[posA], characterIds[posB] = characterIds[posB], characterIds[posA]

	self:saveToServer(teamId, characterIds)
end

function MatchGameHeroGroupController:switchTeam(teamId)
	local maxSnapshotCount = MatchGameModel.instance:getMaxHeroGroupSnapshotCount()

	if teamId < 1 or maxSnapshotCount < teamId then
		return
	end

	local curTeamId = MatchGameModel.instance:getCurTeamIndex()

	if curTeamId == teamId then
		return
	end

	local actId = MatchGameModel.instance:getCurActId()

	MatchGameRpc.instance:sendAct244ModifyTeamIndexRequest(actId, teamId)
end

function MatchGameHeroGroupController:saveToServer(teamId, characterIds)
	local actId = MatchGameModel.instance:getCurActId()

	MatchGameRpc.instance:sendAct244ModifyTeamRequest(actId, teamId, characterIds)
end

function MatchGameHeroGroupController:enterBattle(episodeId)
	local isOpen = MatchGameModel.instance:checkEpisodeOpen(episodeId, true)

	if not isOpen then
		return
	end

	local characterCount = MatchGameHeroGroupModel.instance:getCurTeamCharacterCount()

	if characterCount <= 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return
	end

	local actId = MatchGameModel.instance:getCurActId()

	MatchGameRpc.instance:sendAct244StartEpisodeRequest(actId, episodeId)
end

function MatchGameHeroGroupController:openEditView(posIndex)
	ViewMgr.instance:openView(ViewName.MatchGameHeroGroupEditView, {
		posIndex = posIndex
	})
end

function MatchGameHeroGroupController:confirmEdit(posIndex)
	local heroListModel = MatchGameHeroGroupEditListModel.instance
	local groupModel = MatchGameHeroGroupModel.instance

	if groupModel:getCurTeamId() <= 0 then
		return
	end

	local modify = self:checkHeroGroupModify(posIndex)

	if not modify then
		return
	end

	if heroListModel:isQuickEditMode() then
		local batchHeroList = heroListModel:getBatchSelectedList() or {}
		local characterIds = tabletool.copy(batchHeroList)
		local teamId = groupModel:getCurTeamId()

		self:saveToServer(teamId, characterIds)
	else
		local selectedId = heroListModel:getSelectedCharacterId()

		self:replaceSlot(posIndex, selectedId)
	end

	return true
end

function MatchGameHeroGroupController:checkHeroGroupModify(posIndex)
	if not posIndex or posIndex > MatchGameEnum.HeroGroupMaxHeroCount then
		return
	end

	local teamHeroMap = MatchGameHeroGroupModel.instance:getCurTeamHeroes()
	local heroListModel = MatchGameHeroGroupEditListModel.instance

	if heroListModel:isQuickEditMode() then
		local batchHeroList = heroListModel:getBatchSelectedList() or {}

		for i, heroId in ipairs(batchHeroList) do
			local curHeroMo = teamHeroMap and teamHeroMap[i]

			if curHeroMo then
				if not curHeroMo.id then
					local curHeroId = 0

					if curHeroId ~= heroId then
						return true
					end
				end
			end
		end
	else
		local selectedId = heroListModel:getSelectedCharacterId()
		local curHeroMo = teamHeroMap and teamHeroMap[posIndex]

		if curHeroMo then
			if not curHeroMo.id then
				local curHeroId = 0

				if curHeroId ~= selectedId then
					return true
				end
			end
		end
	end
end

MatchGameHeroGroupController.instance = MatchGameHeroGroupController.New()

return MatchGameHeroGroupController
