-- chunkname: @modules/logic/fight/view/FightViewBossHpBloodReward.lua

module("modules.logic.fight.view.FightViewBossHpBloodReward", package.seeall)

local FightViewBossHpBloodReward = class("FightViewBossHpBloodReward", FightBaseView)

function FightViewBossHpBloodReward:onInitView()
	self.hpImg = gohelper.findChildImage(self.viewGO, "Root/bossHp/Alpha/bossHp/mask/container/imgHp")
	self.signRoot = gohelper.findChild(self.viewGO, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer")
	self.signItem = gohelper.findChild(self.viewGO, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer/imgSignHpItem")
	self.hpEffect = gohelper.findChild(self.viewGO, "Root/bossHp/Alpha/bossHp/#hpeffect")

	gohelper.setActive(self.hpEffect, false)
end

function FightViewBossHpBloodReward:addEvents()
	self:com_registFightEvent(FightEvent.UpdateFightParam, self.onUpdateFightParam)
	self:com_registFightEvent(FightEvent.PlayTimelineHit, self.onPlayTimelineHit)
	self:com_registFightEvent(FightEvent.AfterCorrectData, self.onAfterCorrectData)

	self.tweenComp = self:addComponent(FightTweenComponent)
end

function FightViewBossHpBloodReward:onConstructor(data)
	self.data = data
end

function FightViewBossHpBloodReward:onOpen()
	self.invokedEffect = {}
	self.bgWidth = recthelper.getWidth(self.signRoot.transform)
	self.halfWidth = self.bgWidth / 2
	self.itemDataList = GameUtil.splitString2(self.data.bloodReward, true)

	self:refreshItems()
	self:refreshHp()
end

function FightViewBossHpBloodReward:onAfterCorrectData()
	self:refreshItems()

	local curRate = (FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_CUR_HP_RATE] or 0) / 1000

	self.tweenComp:DOFillAmount(self.hpImg, curRate, 0.2)
end

function FightViewBossHpBloodReward:onPlayTimelineHit(fightStepData, defenderMO)
	if defenderMO.side ~= FightEnum.EntitySide.EnemySide then
		return
	end

	gohelper.setActive(self.hpEffect, false)
	gohelper.setActive(self.hpEffect, true)
	self:com_registSingleTimer(self.hideEffect, 0.5)

	local offset = 0

	for i, actEffectData in ipairs(fightStepData.actEffect) do
		if not actEffectData:isDone() and not self.invokedEffect[actEffectData.clientId] and actEffectData.effectType == FightEnum.EffectType.FIGHTPARAMCHANGE then
			local arr = GameUtil.splitString2(actEffectData.reserveStr, true)

			for _, v in ipairs(arr) do
				local id = v[1]

				if id == FightParamData.ParamKey.ACT191_CUR_HP_RATE then
					offset = offset + v[2]
					self.invokedEffect[actEffectData.clientId] = true
				end
			end
		end
	end

	if offset ~= 0 then
		self:refreshHp(self.hpImg.fillAmount + offset / 1000)
	end
end

function FightViewBossHpBloodReward:hideEffect()
	gohelper.setActive(self.hpEffect, false)
end

function FightViewBossHpBloodReward:refreshHp(rate)
	rate = rate or (FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_CUR_HP_RATE] or 0) / 1000

	self.tweenComp:DOFillAmount(self.hpImg, rate, 0.2)
end

function FightViewBossHpBloodReward:onUpdateFightParam(id, oldValue, currentValue, offset, actEffectData)
	if id == FightParamData.ParamKey.ACT191_MIN_HP_RATE then
		self:refreshItems()
	elseif id == FightParamData.ParamKey.ACT191_CUR_HP_RATE and not self.invokedEffect[actEffectData.clientId] then
		self:refreshHp()
	end
end

function FightViewBossHpBloodReward:refreshItems()
	gohelper.CreateObjList(self, self.onItemShow, self.itemDataList, self.signRoot, self.signItem)
end

function FightViewBossHpBloodReward:onItemShow(obj, data, index)
	local unfinish = gohelper.findChild(obj, "unfinish")
	local finish = gohelper.findChild(obj, "finished")
	local hp = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_MIN_HP_RATE]
	local signHp = data[1]

	if hp <= signHp then
		gohelper.setActive(unfinish, false)
		gohelper.setActive(finish, true)
	else
		gohelper.setActive(unfinish, true)
		gohelper.setActive(finish, false)
	end

	local posX = signHp / 1000 * self.bgWidth - self.halfWidth

	recthelper.setAnchorX(obj.transform, posX)
end

return FightViewBossHpBloodReward
