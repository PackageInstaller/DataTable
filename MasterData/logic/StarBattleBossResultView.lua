-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleBossResultView.lua

module("logic.extensions.starbattle.view.StarBattleBossResultView", package.seeall)

local StarBattleBossResultView = class("StarBattleBossResultView", ViewComponent)

function StarBattleBossResultView:ctor()
	StarBattleBossResultView.super.ctor(self)
end

function StarBattleBossResultView:unbindEvents()
	StarBattleBossResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function StarBattleBossResultView:bindEvents()
	StarBattleBossResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function StarBattleBossResultView:buildUI()
	StarBattleBossResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtDamage = self:getTxt("txtDamage")
	self._txtDouble = self:getTxt("txtDouble")
	self._txtScore = self:getTxt("txtScore")
end

function StarBattleBossResultView:onExit()
	StarBattleBossResultView.super.onExit(self)
end

function StarBattleBossResultView:onEnter()
	StarBattleBossResultView.super.onEnter(self)

	local info = self:getFirstParam()
	local score = 0
	local damage = 0
	local isDouble = false
	local subDamage = 0
	local firstName = ""
	local subName = ""

	if info then
		score = info.score
		damage = checknumber(info.damage)

		local firstDoubleBossDamage = 0
		local secondDoubleBossDamage = 0
		local activityId = info.activityId
		local periodId = info.periodId
		local baseInfo = StarBattleModel.instance:getBaseInfo(activityId, periodId)

		if baseInfo then
			firstDoubleBossDamage = baseInfo.firstDoubleBossDamage or 0
			secondDoubleBossDamage = baseInfo.secondDoubleBossDamage or 0
		end

		local bossId = info.bossId
		local periodCfg = StarBattleConfig.instance:getPeriodCfg(activityId, periodId)
		local bossCfgs = StarBattleConfig.instance:getBossCfgs(periodCfg.bossPlanId) or {}

		isDouble = #bossCfgs > 1

		local firstBossCfg = bossCfgs and bossCfgs[1]
		local subBossCfg = bossCfgs and bossCfgs[2]

		if firstBossCfg then
			if not firstBossCfg.bossLihui then
				local firstRaceId = 0

				if subBossCfg then
					if not subBossCfg.bossLihui then
						local subRaceId = 0
						local firstPetSkinCfg = PetSkinConfig.instance:getPetSkinCfg(firstRaceId)
						local subPetSkinCfg = PetSkinConfig.instance:getPetSkinCfg(subRaceId)

						firstName = firstPetSkinCfg and firstPetSkinCfg.name or ""
						subName = subPetSkinCfg and subPetSkinCfg.name or ""

						if isDouble then
							if bossId == 1 then
								subDamage = checknumber(secondDoubleBossDamage)
							elseif bossId == 2 then
								damage = checknumber(firstDoubleBossDamage)
								subDamage = checknumber(info.damage)
							end
						end
					end
				end
			end
		end
	end

	if isDouble then
		self._txtDamage.text = ""
		self._txtDouble.text = string.format("%s:%s\n%s:%s", firstName, self:_formatNum(damage), subName, self:_formatNum(subDamage))
	else
		self._txtDouble.text = ""
		self._txtDamage.text = self:_formatNum(damage)
	end

	self._txtScore.text = score
end

function StarBattleBossResultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

function StarBattleBossResultView:_formatNum(num)
	local num = checknumber(num)

	num = Mathf.Max(num, 0)

	if num >= 100000000 then
		return string.format("%.2f亿", num / 100000000)
	elseif num >= 10000 then
		return string.format("%.2f万", num / 10000)
	else
		return tostring(num)
	end
end

return StarBattleBossResultView
