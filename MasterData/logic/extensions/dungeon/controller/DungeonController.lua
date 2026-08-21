-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/controller/DungeonController.lua

module("logic.extensions.dungeon.controller.DungeonController", package.seeall)

local M = class("DungeonController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._dungeonType2Flow = {
		[CommEnum.DungeonType.Tacit] = TacitFlow
	}
end

function M:onReset()
	if self._curDungeonBattleWorkFlow then
		self._curDungeonBattleWorkFlow:exit()

		self._curDungeonBattleWorkFlow = nil
	end
end

function M:_getBattleFlow(dungeonType, dungeonId)
	if dungeonType == CommEnum.DungeonType.Materia then
		return MaterialBattleFlow
	elseif dungeonType == CommEnum.DungeonType.Gold then
		return MaterialBattleFlow
	elseif dungeonType == CommEnum.DungeonType.Exp then
		return MaterialBattleFlow
	elseif dungeonType == CommEnum.DungeonType.EquipExplore then
		return EquipExploreBattleFlow
	elseif dungeonType == CommEnum.DungeonType.LightTower then
		return ClimbingTowerBrightSideBattleFlow
	elseif dungeonType == CommEnum.DungeonType.DarkTower then
		return ClimbingTowerDarkSideBattleFlow
	elseif dungeonType == CommEnum.DungeonType.Tacit then
		return TacitBattleFlow
	elseif dungeonType == CommEnum.DungeonType.ControlAction or dungeonType == CommEnum.DungeonType.ControlActionTeaching then
		if ControlActionUtil.isDoomForecastDungeon(dungeonId) then
			return DoomBattleFlow
		end
	elseif dungeonType == CommEnum.DungeonType.HeroEarlyAccess then
		return RoleExperienceBattleFlow
	end

	return DungeonBattleFlowBase
end

function M:startDungeonBattle(info)
	if self._curDungeonBattleWorkFlow == nil then
		local dungeonType = DungeonModel.instance:getDungeonTypeByCfg(info.dungeonCode)
		local flow = self._dungeonType2Flow[dungeonType] or DungeonBattleFlow

		self._curDungeonBattleWorkFlow = flow.New()

		self._curDungeonBattleWorkFlow:enter(info)
	end
end

function M:getBattleFlowClass()
	local flow = self:getDungeonBattleFlow()
	local dungeonType = flow.model:getDungeonType()
	local dungeonId = flow.model:getDungeonCode()

	return self:_getBattleFlow(dungeonType, dungeonId)
end

function M:getBattleFlowClassByCode(code)
	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(code)
	local dungeonType = dungeonCO.type

	return self:_getBattleFlow(dungeonType, code)
end

function M:clearDungeonBattleFlow()
	self._curDungeonBattleWorkFlow = nil
end

function M:getDungeonBattleFlow()
	return self._curDungeonBattleWorkFlow
end

function M:getIsInDungeonBattleFlow()
	return self._curDungeonBattleWorkFlow ~= nil
end

function M:checkEnterDungeon()
	local count = HeroDepotModel.instance:getHeroDepotData():getHeroCount()

	if count <= 0 then
		Dialog.showMessage(lang("tip_title"), lang("tip_no_have_role"))

		return false
	end

	return true
end

function M:tryOpenDangerTips(scoreCO, info)
	local todayTS = TimeUtil.instance:getTodaySpTimeStamp()
	local ts = Astral.LocalStorage.Instance:GetInt("BattleDangerTips", 0)

	if ts < todayTS then
		if scoreCO.index == 2 or scoreCO.index == 3 then
			ViewMgr.instance:open(ViewName.BattleDangerTips, scoreCO, info)

			return true
		end

		return false
	end
end

M.instance = M.New()

return M
