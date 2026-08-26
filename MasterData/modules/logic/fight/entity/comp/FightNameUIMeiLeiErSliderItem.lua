-- chunkname: @modules/logic/fight/entity/comp/FightNameUIMeiLeiErSliderItem.lua

module("modules.logic.fight.entity.comp.FightNameUIMeiLeiErSliderItem", package.seeall)

local FightNameUIMeiLeiErSliderItem = class("FightNameUIMeiLeiErSliderItem", FightBaseClass)

function FightNameUIMeiLeiErSliderItem:onConstructor(viewGO, entityData, buffData, actInfo)
	self.viewGO = viewGO
	self.animator = gohelper.onceAddComponent(viewGO, gohelper.Type_Animator)

	gohelper.setActive(viewGO.transform.parent.gameObject, true)

	self.entityData = entityData
	self.buffData = buffData
	self.actInfo = actInfo
	self.trigger = 100
	self.limit = 100

	local featuresSplit = entityData:getFeaturesSplitInfoByBuffId(buffData.buffId)

	if featuresSplit then
		for _, oneFeature in ipairs(featuresSplit) do
			if oneFeature[1] == 1139 then
				self.trigger = oneFeature[2]
				self.limit = oneFeature[3]
			end
		end
	end

	self.slider1 = gohelper.findChildImage(viewGO, "#image_progress1")
	self.slider2 = gohelper.findChildImage(viewGO, "#image_progress2")
	self.go_start = gohelper.findChild(viewGO, "go_start")

	gohelper.setActive(self.go_start, false)

	self.line = gohelper.findChild(viewGO, "#image_progress2/line")

	gohelper.setActive(self.line, false)
	self:com_registMsg(FightMsgId.OnRemoveMeiLeiErCharge, self.onRemoveMeiLeiErCharge)
	self:com_registMsg(FightMsgId.OnUpdateMeiLeiErCharge, self.onUpdateMeiLeiErCharge)
	self:com_registMsg(FightMsgId.UpdateEntityBuffActInfo, self.onUpdateEntityBuffActInfo)
	self:com_registMsg(FightMsgId.StartMeiLeiErExRound, self.onStartMeiLeiErExRound)
	self:com_registFightEvent(FightEvent.UpdateFightParam, self.onUpdateFightParam)
	self:refreshUI()

	if not FightDataHelper.fieldMgr.param[FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG] then
		if FightDataHelper.fieldMgr.param[FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG] == 1 then
			self.animator:Play("start", 0, 0)
		end
	end
end

function FightNameUIMeiLeiErSliderItem:onUpdateFightParam(paramKey, oldValue, currentValue)
	if paramKey ~= FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG then
		return
	end

	self:refreshUI()

	if currentValue == 2 then
		self.animator:Play("idle", 0, 0)
	end
end

function FightNameUIMeiLeiErSliderItem:refreshUI()
	if not FightDataHelper.fieldMgr.param then
		return
	end

	if not self.curFillAmount then
		local oldFillAmount = 0

		self.curFillAmount = (self.actInfo.param[1] or 0) / self.trigger

		if oldFillAmount < 1 and self.curFillAmount >= 1 then
			self.animator:Play("max", 0, 0)
			AudioMgr.instance:trigger(370100)
		end

		self.slider1.fillAmount = self.curFillAmount
		self.slider2.fillAmount = ((self.actInfo.param[1] or 0) - self.trigger) / (self.limit - self.trigger)

		if not FightDataHelper.fieldMgr.param[FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG] then
			local isExtraRound = 0

			gohelper.setActive(self.go_start, isExtraRound == 1)
			gohelper.setActive(self.line, (self.actInfo.param[1] or 0) >= self.trigger)
		end
	end
end

function FightNameUIMeiLeiErSliderItem:onStartMeiLeiErExRound()
	self.animator:Play("start", 0, 0)
end

function FightNameUIMeiLeiErSliderItem:onUpdateMeiLeiErCharge(buffData)
	if self.buffData.uid ~= buffData.uid then
		return
	end

	self:refreshUI()
end

function FightNameUIMeiLeiErSliderItem:onUpdateEntityBuffActInfo(entityId, buffUid, actInfo)
	if buffUid ~= self.buffData.uid then
		return
	end

	self:refreshUI()
end

function FightNameUIMeiLeiErSliderItem:onRemoveMeiLeiErCharge(buffData)
	if self.buffData.uid ~= buffData.uid then
		return
	end

	self:disposeSelf()
end

function FightNameUIMeiLeiErSliderItem:onDestructor()
	gohelper.destroy(self.viewGO)
end

return FightNameUIMeiLeiErSliderItem
