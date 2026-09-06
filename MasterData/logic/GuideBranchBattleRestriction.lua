-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchBattleRestriction.lua

module("logic.extensions.guide.model.branch.GuideBranchBattleRestriction", package.seeall)

local GuideBranchBattleRestriction = class("GuideBranchBattleRestriction", GuideBranchBase)

function GuideBranchBattleRestriction:startGuide()
	GuideBranchBattleRestriction.super.startGuide(self)

	if self:isGuiding() then
		self.isPause = true

		BattleController.instance:setBattlePause(true)
		ViewMgr.instance:open(ViewName.BattleRestriction, self.guideTargetsData)
	end
end

function GuideBranchBattleRestriction:shouldTrigger()
	if not BattleController.instance:isBattling() or not self._currGuide then
		return false
	end

	local params = self._currGuide:getJsonParams()

	if BattleModel.instance.pveId ~= checknumber(params.pveId) then
		-- block empty
	end

	if not self.guideTargetsData then
		return
	end

	if self.guideTargetsData[1] and checknumber(params.raceId) ~= checknumber(self.guideTargetsData[1].raceId) then
		return false
	end

	return GuideBranchBattleRestriction.super.shouldTrigger(self)
end

function GuideBranchBattleRestriction:finishGuide()
	self.guideTargetsData = nil

	if self.isPause then
		self.isPause = false

		BattleController.instance:setBattlePause(false)
		ViewMgr.instance:close(ViewName.BattleRestriction)
	end

	GuideBranchBattleRestriction.super.finishGuide(self)
end

function GuideBranchBattleRestriction:forceToInScene(sceneId, sceneType)
	if sceneId == SceneConfig.BattleSceneId and self._currGuide then
		local guideId = self._currGuide:getGuideId()

		if guideId ~= 1 then
			return 1
		end
	end
end

return GuideBranchBattleRestriction
