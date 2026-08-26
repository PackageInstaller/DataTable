-- chunkname: @modules/logic/player/model/PlayerClothListViewModel.lua

module("modules.logic.player.model.PlayerClothListViewModel", package.seeall)

local PlayerClothListViewModel = class("PlayerClothListViewModel", ListScrollModel)

function PlayerClothListViewModel:setGroupModel(model)
	self._groupModel = model
end

function PlayerClothListViewModel:getGroupModel()
	return self._groupModel
end

function PlayerClothListViewModel:update()
	local list = PlayerClothModel.instance:getList()
	local newList = {}
	local sp_episode_cloth_id = PlayerClothModel.instance:getSpEpisodeClothID()

	if sp_episode_cloth_id then
		table.insert(newList, PlayerClothModel.instance:getById(sp_episode_cloth_id))
	else
		for _, mo in ipairs(list) do
			if PlayerClothModel.instance:hasCloth(mo.id) then
				table.insert(newList, mo)
			end
		end
	end

	self:setList(newList)
end

PlayerClothListViewModel.instance = PlayerClothListViewModel.New()

return PlayerClothListViewModel
