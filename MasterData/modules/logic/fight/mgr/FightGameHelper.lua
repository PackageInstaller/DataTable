-- chunkname: @modules/logic/fight/mgr/FightGameHelper.lua

module("modules.logic.fight.mgr.FightGameHelper", package.seeall)

local FightGameHelper = {}
local curMgr

function FightGameHelper.initGameMgr()
	FightGameHelper.disposeGameMgr()

	curMgr = FightGameMgr.New()
end

function FightGameHelper.disposeGameMgr()
	if curMgr then
		curMgr:disposeSelf()

		curMgr = nil
	end
end

return FightGameHelper
