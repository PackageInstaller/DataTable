-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/topview/TLCBattleTopView.lua

module("logic.extensions.battle.view.TLCBattleTopView", package.seeall)

local TLCBattleTopView = class("TLCBattleTopView")

function TLCBattleTopView:ctor(go, view, bloodBar)
	self.mainGO = go
	self._view = view
	self._bloodBar = bloodBar
end

function TLCBattleTopView:buildUI()
	self._txtTotalDamage = goutil.findChildTextComponent(self.mainGO, "totalHurtNum/txthurtNum")
end

function TLCBattleTopView:onEnter()
	local info = TLChallengeController.instance:getCurChallengeCacheInfo()

	self._challengeId = info.challengeId
	self._maxDamage = checknumber(info.maxProgress)
	self._initDamage = checknumber(info.totalDamage)
	self._lastDamage = checknumber(info.lastDamage)
end

function TLCBattleTopView:onExit()
	return
end

function TLCBattleTopView:updateValue(cur, total, isForce)
	if self._maxDamage == 0 then
		self._maxDamage = total
	end

	local singleDamage = total - cur
	local leftHp = self._maxDamage - singleDamage - self._initDamage

	if leftHp < 0 then
		leftHp = 0
	end

	self._bloodBar:setTextProgress(leftHp .. "/" .. self._maxDamage)

	if self._maxDamage ~= 0 then
		if not (leftHp / self._maxDamage) then
			local targetValue = 0

			self._txtTotalDamage.text = TimeLimitedConfig.instance:isCircleChallenge(self._challengeId) and string.format("本轮累计总伤害 <color=#EB4642FF>%s</color>", singleDamage - self._lastDamage) or string.format("本次累计总伤害 <color=#EB4642FF>%s</color>", singleDamage - self._lastDamage)

			self._bloodBar:setProgress(targetValue, isForce)
		end
	end
end

return TLCBattleTopView
