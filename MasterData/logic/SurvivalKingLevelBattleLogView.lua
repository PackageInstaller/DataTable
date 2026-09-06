-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingLevelBattleLogView.lua

module("logic.extensions.survivalking.view.SurvivalKingLevelBattleLogView", package.seeall)

local SurvivalKingLevelBattleLogView = class("SurvivalKingLevelBattleLogView", SurvivalKingBattleLogView)

function SurvivalKingLevelBattleLogView:_getBuffCfg(data, side)
	local buffId = side == "my" and checknumber(data.myEffectLevelBuffId) or checknumber(data.opEffectLevelBuffId)

	if buffId > 0 then
		local level = SurvivalKingModel.instance:getLevelBuffLevel(self._activityId)

		return SurvivalKingConfig.instance:getLevelBuffCfg(self._activityId, buffId, level)
	end

	return nil
end

return SurvivalKingLevelBattleLogView
