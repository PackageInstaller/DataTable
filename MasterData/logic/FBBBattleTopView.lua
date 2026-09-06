-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FBBBattleTopView.lua

module("logic.extensions.fbbchallenge.view.FBBBattleTopView", package.seeall)

local FBBBattleTopView = class("FBBBattleTopView", TLCBattleTopView)

function FBBBattleTopView:onEnter()
	local info = FbbchallengeModel.instance:getCurChallengeCacheInfo()

	self._challengeId = FbbchallengeConfig.instance:getDefineValue("CHALLENGE_ID", true)
	self._maxDamage = checknumber(info.maxProgress)
	self._initDamage = checknumber(info.totalDamage)
end

function FBBBattleTopView:updateValue(cur, total, isForce)
	if self._maxDamage == 0 then
		self._maxDamage = total
	end

	local singleDamage = total - cur - self._initDamage
	local leftHp = self._maxDamage - singleDamage - self._initDamage

	if leftHp < 0 then
		leftHp = 0
	end

	self._bloodBar:setTextProgress(leftHp .. "/" .. self._maxDamage)

	if self._maxDamage ~= 0 then
		if not (leftHp / self._maxDamage) then
			local targetValue = 0

			self._txtTotalDamage.text = string.format("本次累计总伤害 <color=#EB4642FF>%s</color>", singleDamage)

			self._bloodBar:setProgress(targetValue, isForce)
		end
	end
end

return FBBBattleTopView
