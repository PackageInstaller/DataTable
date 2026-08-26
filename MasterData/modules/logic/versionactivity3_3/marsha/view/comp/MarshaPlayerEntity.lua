-- chunkname: @modules/logic/versionactivity3_3/marsha/view/comp/MarshaPlayerEntity.lua

module("modules.logic.versionactivity3_3.marsha.view.comp.MarshaPlayerEntity", package.seeall)

local MarshaPlayerEntity = class("MarshaPlayerEntity", MarshaBaseEntity)

function MarshaPlayerEntity:init(go)
	MarshaPlayerEntity.super.init(self, go)

	self.txtWeight = gohelper.findChildText(go, "txt_Weight")
	self.goBuffSlider = gohelper.findChild(go, "go_BuffSlider")
	self.imageBuffProgress = gohelper.findChildImage(go, "go_BuffSlider/image_BuffProgress")
	self.goSpeedLine = gohelper.findChild(go, "go_SpeedLine")
	self.goBubble = gohelper.findChild(go, "go_Bubble")
	self.goArrow = gohelper.findChild(go, "go_Arrow")

	gohelper.setActive(self.goBuffSlider, false)
end

function MarshaPlayerEntity:onDestroy()
	if self.adsorbDis then
		TaskDispatcher.cancelTask(self.adsorbFinish, self)
	end

	if self.despairCnt ~= 0 then
		TaskDispatcher.cancelTask(self.debuffFinish, self)
	end

	MarshaPlayerEntity.super.onDestroy(self)
end

function MarshaPlayerEntity:initData(unitCo, uid)
	self:initBase(unitCo.unitType, uid)
	self:setWeight(unitCo.weight)
	self:setPos(unitCo.posX, unitCo.posY)
	self:setSpeed(unitCo.speed)

	self.maxDespairCnt = MarshaModel.instance:getCurGameMaxDespair()

	self:setDespairCnt(0)
end

function MarshaPlayerEntity:setImage()
	if self.despairCnt == 0 then
		self:playAnim("lvback")
	else
		self:playAnim("lv" .. self.despairCnt)
	end
end

function MarshaPlayerEntity:move(input)
	local dt = Mathf.Clamp(UnityEngine.Time.deltaTime, 0.01, 0.1)
	local fixSpeed = self:getFixSpeed()
	local xDis = input.x * fixSpeed * dt * 3
	local yDis = input.y * fixSpeed * dt * 3
	local x, y = MarshaHelper.fitBounds(self, xDis, yDis)

	self:setPos(x, y)

	if self.x ~= x or self.y ~= y then
		self:setPos(x, y)
	end
end

function MarshaPlayerEntity:addDeBuff(layer, time)
	if self.despairCnt ~= 0 then
		TaskDispatcher.cancelTask(self.debuffFinish, self)
	end

	layer = self.despairCnt + layer

	if layer >= self.maxDespairCnt then
		MarshaController.instance:dispatchEvent(MarshaEvent.GameEnd, false, MarshaEnum.FailReason.Despair)
	else
		self:setDespairCnt(layer)
		TaskDispatcher.runDelay(self.debuffFinish, self, time)
	end
end

function MarshaPlayerEntity:debuffFinish()
	self:setDespairCnt(0)
end

function MarshaPlayerEntity:setDespairCnt(count)
	self.despairCnt = count

	gohelper.setActive(self.goBuffSlider, count ~= 0)

	self.imageBuffProgress.fillAmount = self.despairCnt / self.maxDespairCnt

	self:setImage()
end

function MarshaPlayerEntity:setWeight(weight)
	MarshaPlayerEntity.super.setWeight(self, weight)

	self.txtWeight.text = weight
end

function MarshaPlayerEntity:setAdsorb(time, dis, conditions)
	gohelper.setActive(self.goBubble, true)
	AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_water)

	time = time > 0.1 and time or 0.1
	self.adsorbDis = dis
	self.adsorbConditions = conditions

	TaskDispatcher.runDelay(self.adsorbFinish, self, time)
end

function MarshaPlayerEntity:adsorbFinish()
	self.adsorbDis = nil

	gohelper.setActive(self.goBubble, false)
end

function MarshaPlayerEntity:tick(dt)
	local speed = self.unControlSpeed
	local xDis = speed * math.cos(self.radian) * dt
	local yDis = speed * math.sin(self.radian) * dt
	local x, y = MarshaHelper.fitBounds(self, xDis, yDis)

	if self.x ~= x or self.y ~= y then
		self:setPos(x, y)
	end
end

function MarshaPlayerEntity:setAddSpeed(speed, time)
	if speed > 0 then
		gohelper.setActive(self.goSpeedLine, true)
		AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_jiasu)
	end

	MarshaPlayerEntity.super.setAddSpeed(self, speed, time)
end

function MarshaPlayerEntity:addSpeedFinish()
	MarshaPlayerEntity.super.addSpeedFinish(self)
	gohelper.setActive(self.goSpeedLine, false)
end

function MarshaPlayerEntity:setAngle(angle)
	if angle then
		transformhelper.setEulerAngles(self.goSpeedLine.transform, 0, 0, angle)
		transformhelper.setEulerAngles(self.goArrow.transform, 0, 0, angle + 90)
	end

	gohelper.setActive(self.goArrow, angle)
end

function MarshaPlayerEntity:setUnControl(time, pos, speed)
	MarshaPlayerEntity.super.setUnControl(self, time, pos, speed)

	local angle = self.radian / Mathf.Deg2Rad

	self:setAngle(angle)
end

return MarshaPlayerEntity
