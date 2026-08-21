-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uipool/BattleTalentSkillIcon.lua

module("logic.battle.uipool.BattleTalentSkillIcon", package.seeall)

local M = class("BattleTalentSkillIcon", BattleSkillIcon)
local kPoolRoot = PoolRootUtil.createUIPoolRoot("BattleTalentSkillIcon")

function M:ctor()
	local resMgr = BattleMgr.instance:getResourceMgr()
	local mainGO = resMgr:getInst(BattleResourceName.UITalentSkillIcon)

	goutil.addChildToParent(mainGO, kPoolRoot)

	self.mainGO = mainGO

	self:buildUI()
end

function M:reset()
	self:resetUI()
	goutil.addChildToParent(self.mainGO, kPoolRoot)
end

return M
