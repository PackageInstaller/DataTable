-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchBattle.lua

module("logic.extensions.guide.model.branch.GuideBranchBattle", package.seeall)

local GuideBranchBattle = class("GuideBranchBattle", GuideBranchBase)

function GuideBranchBattle:startGuide()
	GuideBranchBattle.super.startGuide(self)

	if self:isGuiding() then
		BattleController.instance:setBattlePause(true)
	end
end

function GuideBranchBattle:finishGuide()
	if self:isGuiding() then
		BattleController.instance:setBattlePause(false)
	end

	GuideBranchBattle.super.finishGuide(self)
end

return GuideBranchBattle
