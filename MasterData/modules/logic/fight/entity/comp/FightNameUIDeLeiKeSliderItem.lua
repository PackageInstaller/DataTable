-- chunkname: @modules/logic/fight/entity/comp/FightNameUIDeLeiKeSliderItem.lua

module("modules.logic.fight.entity.comp.FightNameUIDeLeiKeSliderItem", package.seeall)

local FightNameUIDeLeiKeSliderItem = class("FightNameUIDeLeiKeSliderItem", FightBaseClass)

function FightNameUIDeLeiKeSliderItem:onConstructor(viewGO, entityData, buffData)
	self.buffData = buffData
	self.viewGO = viewGO
	self.line1 = gohelper.findChild(viewGO, "#bar_fg/#line1")
	self.line2 = gohelper.findChild(viewGO, "#bar_fg/#line2")
	self.line3 = gohelper.findChild(viewGO, "#bar_fg/#line3")
	self.animator = gohelper.onceAddComponent(viewGO, gohelper.Type_Animator)
	self.sliderImg = gohelper.findChildImage(viewGO, "#bar_fg")
	self.entityData = entityData
	self.entity = FightGameMgr.entityMgr:getById(entityData.id)
	self.curValue = 0
	self.oldValue = 0
	self.maxValue = 100000

	local effectConfig = lua_fight_de_lei_ke_slider_up.configDict[self.entityData.skin]

	effectConfig = effectConfig or lua_fight_de_lei_ke_slider_up.configDict[0]
	self.effectUrl = effectConfig.effect
	self.hangPoint = effectConfig.effectHang
	self.audio = effectConfig.audioId
	self.destroyTime = effectConfig.destroyTime

	self:checkWhenInit()
	self:com_registMsg(FightMsgId.AddDeLeiKeSlider1171, self.onAddDeLeiKeSlider1171)
	self:com_registMsg(FightMsgId.UpdateDeLeiKeSlider1171, self.onUpdateDeLeiKeSlider1171)
	self:com_registMsg(FightMsgId.RemoveDeLeiKeSlider1171, self.onRemoveDeLeiKeSlider1171)
	self:com_registMsg(FightMsgId.AddDeLeiKeSlider1172, self.showValue)
	self:com_registMsg(FightMsgId.UpdateDeLeiKeSlider1172, self.showValue)
	self:com_registMsg(FightMsgId.RemoveDeLeiKeSlider1172, self.showValue)
	self:com_registMsg(FightMsgId.UpdateEntityBuffActInfo, self.onUpdateEntityBuffActInfo)
	self:showValue()
end

function FightNameUIDeLeiKeSliderItem:onUpdateEntityBuffActInfo(entityId, buffUid, actInfo)
	if entityId ~= self.entityData.id then
		return
	end

	if actInfo.actId ~= 1171 then
		return
	end

	self.curValue = actInfo.param[1] or 0

	self:showValue()
end

function FightNameUIDeLeiKeSliderItem:onRemoveDeLeiKeSlider1171(buffData, actInfo)
	if buffData.entityId ~= self.entityData.id then
		return
	end

	self.curValue = 0

	self:com_registTimer(self.showValue, 0.5)
end

function FightNameUIDeLeiKeSliderItem:onAddDeLeiKeSlider1171(buffData, actInfo)
	if buffData.entityId ~= self.entityData.id then
		return
	end

	self.curValue = actInfo.param[1] or 0

	self:showValue()
end

function FightNameUIDeLeiKeSliderItem:onUpdateDeLeiKeSlider1171(buffData, actInfo)
	if buffData.entityId ~= self.entityData.id then
		return
	end

	self.curValue = actInfo.param[1] or 0

	self:showValue()
end

function FightNameUIDeLeiKeSliderItem:showValue()
	if self.curValue > self.oldValue and self.entity then
		local effectWrap = self.entity.effect:addHangEffect(self.effectUrl, self.hangPoint, nil, self.destroyTime)

		AudioMgr.instance:trigger(self.audio)
		effectWrap:setLocalPos(0, 0, 0)
	end

	local hasBurst = self.entityData:hasBuffActId(1172)

	if hasBurst then
		self.sliderImg.fillAmount = 1

		self.animator:Play("max", 0, 0)
		gohelper.setActive(self.line1, false)
		gohelper.setActive(self.line2, false)
		gohelper.setActive(self.line3, false)
		AudioMgr.instance:trigger(400007)
	else
		local rate = self.curValue / self.maxValue

		self.sliderImg.fillAmount = rate

		if self.curValue == 0 then
			self.animator:Play("nonactivated", 0, 0)
		elseif self.curValue == self.maxValue then
			self.animator:Play("active_full", 0, 0)
		else
			self.animator:Play("active_unfull", 0, 0)
		end

		gohelper.setActive(self.line1, rate >= 0.25)
		gohelper.setActive(self.line2, rate >= 0.5)
		gohelper.setActive(self.line3, rate >= 0.75)
	end

	self.oldValue = self.curValue
end

function FightNameUIDeLeiKeSliderItem:checkWhenInit()
	local hasAct, buffData = self.entityData:hasBuffActId(1171)

	if hasAct then
		local actInfo = buffData.actInfo

		for i, v in ipairs(actInfo) do
			if v.actId == 1171 then
				self.curValue = v.param[1] or 0

				break
			end
		end
	end
end

return FightNameUIDeLeiKeSliderItem
