-- chunkname: @modules/logic/fight/view/FightDouQuQuHuntingView.lua

module("modules.logic.fight.view.FightDouQuQuHuntingView", package.seeall)

local FightDouQuQuHuntingView = class("FightDouQuQuHuntingView", FightBaseView)

function FightDouQuQuHuntingView:onInitView()
	self.huntingText = gohelper.findChildText(self.viewGO, "root/#txt_num")
	self.addEffect = gohelper.findChild(self.viewGO, "root/#add")
end

function FightDouQuQuHuntingView:addEvents()
	self:com_registFightEvent(FightEvent.UpdateFightParam, self.onUpdateFightParam)

	self.tweenComp = self:addComponent(FightTweenComponent)
end

function FightDouQuQuHuntingView:onUpdateFightParam(keyId, oldValue, currValue, offset)
	if keyId ~= FightParamData.ParamKey.ACT191_HUNTING then
		return
	end

	self:com_killTween(self.tweenId)
	self.tweenComp:DOTweenFloat(oldValue, currValue, 0.5, self.onFrame, nil, self)

	if offset > 0 then
		gohelper.setActive(self.addEffect, false)
		gohelper.setActive(self.addEffect, true)
		self:com_registSingleTimer(self.hideEffect, 1)
	end
end

function FightDouQuQuHuntingView:onFrame(value)
	value = math.ceil(value)

	self:refreshData(value)
end

function FightDouQuQuHuntingView:hideEffect()
	gohelper.setActive(self.addEffect, false)
end

function FightDouQuQuHuntingView:refreshData(hunting)
	local leftColor = hunting < self.maxValue and "#D97373" or "#65B96F"

	self.huntingText.text = string.format("<%s>%s</color>/%s", leftColor, hunting, self.maxValue)
end

function FightDouQuQuHuntingView:onOpen()
	transformhelper.setLocalScale(self.viewGO.transform, 0.8, 0.8, 0.8)
	recthelper.setAnchorX(self.viewGO.transform, 15)

	local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	self.maxValue = customData.minNeedHuntValue

	local hunting = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_HUNTING]

	self:refreshData(hunting)
end

return FightDouQuQuHuntingView
