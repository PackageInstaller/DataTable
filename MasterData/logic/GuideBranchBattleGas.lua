-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchBattleGas.lua

module("logic.extensions.guide.model.branch.GuideBranchBattleGas", package.seeall)

local GuideBranchBattleGas = class("GuideBranchBattleGas", GuideBranchBase)

function GuideBranchBattleGas:startGuide()
	GuideBranchBattleGas.super.startGuide(self)
	BattleController.instance:setBattlePause(true)
end

function GuideBranchBattleGas:shouldTrigger()
	if self._branchParam == nil or not BattleController.instance:isBattling() or WushenViewController.IS_NEED_SHOW_GAS == false then
		return false
	end

	if self._branchParam then
		local params = self._currGuide:getJsonParams()

		if checknumber(params.raceId) ~= checknumber(self._branchParam.raceId) then
			return false
		end
	end

	return GuideBranchBattleGas.super.shouldTrigger(self)
end

function GuideBranchBattleGas:finishGuide()
	GuideBranchBattleGas.super.finishGuide(self)
	BattleController.instance:setBattlePause(false)
end

return GuideBranchBattleGas
