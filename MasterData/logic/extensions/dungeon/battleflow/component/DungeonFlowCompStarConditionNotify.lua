-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/component/DungeonFlowCompStarConditionNotify.lua

module("logic.extensions.dungeon.battleflow.component.DungeonFlowCompStarConditionNotify", package.seeall)

local DungeonFlowCompStarConditionNotify = class("DungeonFlowCompStarConditionNotify", IBattleFlowComp, AbstractGlobalReusable)
local BlackListType = {
	1,
	2,
	4,
	5,
	7,
	8,
	9,
	11,
	12,
	13,
	14,
	15
}

function DungeonFlowCompStarConditionNotify:onInit()
	self._dungeonStarCodes = {}
end

function DungeonFlowCompStarConditionNotify:onStart()
	if not OOPUtil.isInstanceOf(self.flow, DungeonBattleFlowBase) then
		if BattleLog.enableError then
			BattleLog.error("DungeonFlowCompStarConditionNotify::the component not executed")
		end

		return
	end

	self:_buildDungeonStarCodes()

	if #self._dungeonStarCodes <= 0 then
		if BattleLog.enableLog then
			BattleLog.log("DungeonFlowCompStarConditionNotify::all star condition is finished!")
		end

		return
	end

	self:_setEvent(true)
end

function DungeonFlowCompStarConditionNotify:onClear()
	self:_setEvent(false)
	BattleTableUtil.clearTable(self._dungeonStarCodes)
end

function DungeonFlowCompStarConditionNotify:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnCollectInfoUpdate, self._onCollectInfoUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleStart, self._onCollectInfoUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnCollectInfoUpdate, self._onCollectInfoUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleStart, self._onCollectInfoUpdate, self)
	end
end

function DungeonFlowCompStarConditionNotify:_buildDungeonStarCodes()
	BattleTableUtil.clearTable(self._dungeonStarCodes)

	local dungeonMO = DungeonModel.instance:getDungeonMoById(self.flow:getPassId())
	local starStates = dungeonMO:getStar()
	local starRequires = dungeonMO:getStarRequire() or {}

	for index, dungeonStarCode in pairs(starRequires) do
		if not starStates[index] then
			table.insert(self._dungeonStarCodes, dungeonStarCode)
		end
	end

	if enableLog then
		printInfo("dungeonStarCodes", BattleTableUtil.arrayToString(self._dungeonStarCodes))
	end
end

function DungeonFlowCompStarConditionNotify:_onCollectInfoUpdate(evtId)
	local count = #self._dungeonStarCodes

	for i = count, 1, -1 do
		local dungeonStarCode = self._dungeonStarCodes[i]
		local result = DungeonStarConditionChecker.checkNotifyCondition(dungeonStarCode)

		if result == DungeonStarConditionChecker.Result.FINISHED then
			table.remove(self._dungeonStarCodes, i)

			if not self:_isInBlackList(dungeonStarCode) then
				BattleSideHintViewFacade.instance:showHint(dungeonStarCode)
			end
		end
	end
end

function DungeonFlowCompStarConditionNotify:_isInBlackList(dungeonStarCode)
	local dungeonStarCO = DungeonConfig.instance:getDungeonStarByCode(dungeonStarCode)

	for i, type in ipairs(BlackListType) do
		if type == dungeonStarCO.type then
			return true
		end
	end

	return false
end

return DungeonFlowCompStarConditionNotify
