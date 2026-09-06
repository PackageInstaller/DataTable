-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmFieldCell.lua

module("logic.extensions.eternalfarm.view.EternalFarmFieldCell", package.seeall)

local EternalFarmFieldCell = class("EternalFarmFieldCell")

function EternalFarmFieldCell:ctor(luaComponentContainer)
	self._go = luaComponentContainer.gameObject
	self._crop = goutil.findChild(self._go, "crop")
	self._add = goutil.findChild(self._go, "add")
	self._time = goutil.findChild(self._go, "time")
	self._gain = goutil.findChild(self._go, "gain")
	self._effect = goutil.findChild(self._go, "effect")
	self._itemNum = goutil.findChild(self._go, "itemNum")
	self._itemIcon = goutil.findChild(self._go, "itemNum/icon")
	self._txtItemNum = goutil.findChildTextComponent(self._go, "itemNum/txtNum")
	self._txtTime = goutil.findChildTextComponent(self._go, "time/txt")
	self._cropChange = self._crop:GetComponent("UIImageSpriteChange")
end

function EternalFarmFieldCell:init(info)
	GameUtil.addClickHandler(self._go, self.clickCell, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EternalFarm)
	self._cfg = EternalFarmConfig.instance:getCropCfgById(self._activityId, zoneId)
	self._info = info
	self._filedState = EternalFarmModel.FieldState.Empty
	self._farmState = EternalFarmModel.FarmState.Empty

	EternalFarmController.instance:addField(self, self._info.zoneId)
	self:setFarmState(EternalFarmModel.FarmState.Empty)

	if not self._info.farming then
		self:setCropState(EternalFarmModel.FieldState.Empty)

		return
	elseif ServerTime.nowMs() >= checknumber(self._info.endTimeMillis) then
		self:setCropState(EternalFarmModel.FieldState.Mature)

		return
	elseif self._info.farming then
		self:setCropState(EternalFarmModel.FieldState.Farming)
	end
end

function EternalFarmFieldCell:fieldGrowpState()
	return self._filedState
end

function EternalFarmFieldCell:isMature()
	return self._filedState == EternalFarmModel.FieldState.Mature
end

function EternalFarmFieldCell:isFarming()
	return self._filedState == EternalFarmModel.FieldState.Farming
end

function EternalFarmFieldCell:growpUpCrop()
	if self._filedState == EternalFarmModel.FieldState.Empty then
		self:setFarmState(EternalFarmModel.FarmState.PickSeed)
		self:setCropState(EternalFarmModel.FieldState.Farming)
	elseif self._filedState == EternalFarmModel.FieldState.Farming then
		self:setFarmState(EternalFarmModel.FarmState.Accelerate)
		self:setCropState(EternalFarmModel.FieldState.Mature)
	else
		self:setCropState(EternalFarmModel.FieldState.Empty)
	end

	self:cancelFarming()
end

function EternalFarmFieldCell:setCropState(state)
	GameUtil.SetActive(self._crop, state ~= EternalFarmModel.FieldState.Empty)
	GameUtil.SetActive(self._time, state == EternalFarmModel.FieldState.Farming)
	GameUtil.SetActive(self._gain, state == EternalFarmModel.FieldState.Mature)
	GameUtil.SetActive(self._add, state == EternalFarmModel.FieldState.Empty)

	if state == EternalFarmModel.FieldState.Farming then
		self._cropChange:SetState(0)

		self._filedState = EternalFarmModel.FieldState.Farming

		if checknumber(self._info.endTimeMillis) > ServerTime.nowMs() then
			settimer(1, self.countdown, self, true)
		end
	elseif state == EternalFarmModel.FieldState.Mature then
		removetimer(self.countdown, self)
		self._cropChange:SetState(1)

		self._filedState = EternalFarmModel.FieldState.Mature

		GlobalDispatcher:dispatch(GlobalNotify.EternalFarmHarvest)
	else
		self._filedState = EternalFarmModel.FieldState.Empty
	end
end

function EternalFarmFieldCell:countdown()
	local time = checknumber(self._info.endTimeMillis) - ServerTime.nowMs()

	self._txtTime.text = GameUtil.FormatTimeSymbol(time / 1000)

	if time <= 0 then
		GameUtil.SetActive(self._time, false)
		self:setCropState(EternalFarmModel.FieldState.Mature)
		removetimer(self.countdown, self)
	end
end

function EternalFarmFieldCell:destroy()
	removetimer(self.countdown, self)
	MaterialMgr.clearIcon(self._itemIcon)
	GameUtil.rmClickHandler(self._go)
end

function EternalFarmFieldCell:setFarmState(state)
	GameUtil.SetActive(self._itemNum, state ~= EternalFarmModel.FarmState.Empty)

	if state == EternalFarmModel.FarmState.PickSeed then
		self._farmState = EternalFarmModel.FarmState.PickSeed

		local cfg = EternalFarmConfig.instance:getCropCfgById(self._activityId, self._info.zoneId)
		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.seed)

		self._txtItemNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)

		MaterialMgr.setIcon(self._itemIcon, matType, matId)
	elseif state == EternalFarmModel.FarmState.Accelerate then
		self._farmState = EternalFarmModel.FarmState.Accelerate

		local cfg = EternalFarmConfig.instance:getCropCfgById(self._activityId, self._info.zoneId)
		local matType, matId = MaterialMgr.getMatParams(cfg.fertilizer)

		self._txtItemNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)

		MaterialMgr.setIcon(self._itemIcon, matType, matId)
	else
		self._farmState = EternalFarmModel.FarmState.Empty

		GameUtil.SetActive(self._itemNum, false)
	end
end

function EternalFarmFieldCell:clickCell()
	if self._filedState == EternalFarmModel.FieldState.Mature then
		GlobalDispatcher:dispatch(GlobalNotify.EternalFarmOneKey)

		return
	end

	if self._filedState == EternalFarmModel.FieldState.Empty then
		self:setFarmState(EternalFarmModel.FarmState.PickSeed)
	elseif self._filedState == EternalFarmModel.FieldState.Farming then
		self:setFarmState(EternalFarmModel.FarmState.Accelerate)
	end

	EternalFarmModel.instance:setSelectId(self._info.zoneId, self._info.indexId)
	GlobalDispatcher:dispatch(GlobalNotify.EternalFarmFarming, self._farmState, self._info)
end

function EternalFarmFieldCell:cancelFarming()
	self:setFarmState(EternalFarmModel.FarmState.Empty)
end

function EternalFarmFieldCell:getEffectGo()
	return self._effect
end

function EternalFarmFieldCell:getZoneId()
	return self._info.zoneId
end

function EternalFarmFieldCell:getIndexId()
	return self._info.indexId
end

return EternalFarmFieldCell
