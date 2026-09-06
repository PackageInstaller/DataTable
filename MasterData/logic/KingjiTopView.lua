-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/topview/KingjiTopView.lua

module("logic.extensions.battle.view.topview.KingjiTopView", package.seeall)

local KingjiTopView = class("KingjiTopView")

function KingjiTopView:ctor(go, view, bloodBar)
	self.mainGO = go
	self._view = view
	self._bloodBar = bloodBar
end

function KingjiTopView:buildUI()
	self._txtTotalDamage = goutil.findChildTextComponent(self.mainGO, "totalHurtNum/txthurtNum")
end

function KingjiTopView:onEnter()
	self._lastDamageInfo = KingjichallengeController.instance:getCourierLastDamageInfo()
	self._currDamageInfo = KingjichallengeController.instance:getCourierCurrDamageInfo() or self._lastDamageInfo
	self._currMaxDamage = self._currDamageInfo.damage - self._lastDamageInfo.damage
	self._currDamage = 0
	self._txtTotalDamage.text = string.format("本次累计总伤害 <color=#EB4642FF>%s</color>", 0)
end

function KingjiTopView:onExit()
	return
end

function KingjiTopView:updateValue(cur, total, isForce)
	self._initDamage = self._initDamage or cur

	local singleDamage = self._initDamage - cur

	if singleDamage < 0 then
		singleDamage = 0
		self._initDamage = cur
	elseif singleDamage > self._currMaxDamage then
		singleDamage = self._currMaxDamage
	end

	if singleDamage > self._currDamage then
		self._currDamage = singleDamage
	end

	local leftHp = cur

	if leftHp < 0 then
		leftHp = 0
	end

	self._bloodBar:setTextProgress(leftHp .. "/" .. total)

	local targetValue = 0

	if total > 0 then
		targetValue = leftHp / total
	end

	self._txtTotalDamage.text = string.format("本次累计总伤害 <color=#EB4642FF>%s</color>", self._currDamage)

	self._bloodBar:setProgress(targetValue, isForce)
end

return KingjiTopView
