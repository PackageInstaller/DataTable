-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/MaterialBattleFlow.lua

module("logic.extensions.dungeon.battleflow.MaterialBattleFlow", package.seeall)

local MaterialBattleFlow = class("MaterialBattleFlow", DungeonBattleFlowBase)

function MaterialBattleFlow:fillExtensionViewClassList(extensionViewClassList)
	local dungeonMO = DungeonModel.instance:getDungeonMoById(self:getPassId())
	local materialDungeonCode = dungeonMO:getMaterialDungeonCode()
	local materialDungeonCO = DungeonConfig.instance:getMaterialDungeonCfgByMaterialDungoenId(materialDungeonCode)

	if materialDungeonCO.goldA > 0 or materialDungeonCO.goldB > 0 then
		table.insert(extensionViewClassList, MaterialBattleGoldExtensionView)
	elseif materialDungeonCO.expSegements then
		table.insert(extensionViewClassList, MaterialBattleExpExtensionView)
	end
end

function MaterialBattleFlow:fillForbiddenCareerList(forbiddenCareerList)
	local dungeonMO = DungeonModel.instance:getDungeonMoById(self:getPassId())
	local materialDungeonCode = dungeonMO:getMaterialDungeonCode()
	local materialDungeonCO = DungeonConfig.instance:getMaterialDungeonCfgByMaterialDungoenId(materialDungeonCode)

	if materialDungeonCO.forbiddenCareers then
		table.insertto(forbiddenCareerList, materialDungeonCO.forbiddenCareers)
	end
end

return MaterialBattleFlow
