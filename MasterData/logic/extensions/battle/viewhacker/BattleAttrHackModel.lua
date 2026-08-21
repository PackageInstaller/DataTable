-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewhacker/BattleAttrHackModel.lua

module("logic.extensions.battle.viewhacker.BattleAttrHackModel", package.seeall)

local M = class("BattleAttrHackModel", BaseModel)

function M:ctor()
	return
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self:clearNeedRemoveSkillList()
end

function M:initBattleAttrInfo(battle)
	self._hackInfo = battle
end

function M:updateBattleAttrInfo(battle)
	self._hackInfo = battle

	local model = BattleMgr.instance:getModel()

	model:internal_setLeftUndoCount(battle.leftBackCount)
end

function M:getBattleAttrInfo()
	return self._hackInfo
end

function M:getEntityInfoList()
	return self._hackInfo.entities
end

function M:getNeedAddAndRemoveSkillList()
	return self._addSkillList, self._needRemoveSkillList
end

function M:setAddAndRemoveSkillList(addSkillList, removeSkillList)
	self._addSkillList = addSkillList
	self._needRemoveSkillList = removeSkillList
end

function M:clearNeedRemoveSkillList()
	self._addSkillList = {}
	self._needRemoveSkillList = {}
end

M.instance = M.New()

return M
