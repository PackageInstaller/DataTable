-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/NoahFormationLeftView.lua

module("logic.extensions.noahchallenge.view.NoahFormationLeftView", package.seeall)

local NoahFormationLeftView = class("NoahFormationLeftView", FormationLeftView)

function NoahFormationLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local isUsed = self:_isUsedPet(petId)

	return not isUsed
end

function NoahFormationLeftView:_isUsedPet(petId)
	local param = self:getOpenParam()

	if param then
		local challengeId = param[1]
		local cfgChallenge = NoahChallengeConfig.instance:getChallengeCfg(challengeId)

		if cfgChallenge and cfgChallenge.lockPetSwitch then
			return NoahChallengeModel.instance:isPetUsed(challengeId, petId)
		end
	end

	return false
end

return NoahFormationLeftView
