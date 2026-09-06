-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/petzoo/UnitCompHudZooPool.lua

module("logicscene.scene.unit.component.hud.petzoo.UnitCompHudZooPool", package.seeall)

local UnitCompHudZooPool = class("UnitCompHudZooPool", UnitCompHudBase)

function UnitCompHudZooPool:update(deltaTime)
	if not self._hudGameObject then
		return
	end

	self:_updateAbsorbDevice()
end

function UnitCompHudZooPool:_getResPath()
	return "ui/views/zoo/zooabsorbdevice.prefab"
end

function UnitCompHudZooPool:_updateHudInfo(hudGo)
	self._tip = goutil.findChildTextComponent(hudGo, "tip")
end

function UnitCompHudZooPool:_recycleHud()
	UnitCompHudZooPool.super._recycleHud(self)

	self._absorbAnimState = 0
end

function UnitCompHudZooPool:_updateAbsorbDevice()
	local isMyZoo = ZooModel.instance:isMyZoo()

	goutil.setActive(self._hudGameObject, isMyZoo)

	if not isMyZoo then
		self:_setAbsorbAnimState(1)

		return
	end

	local buildingMo = self._unit:getBuildingMO()

	if not buildingMo then
		return
	end

	local zooInfo = buildingMo.zooMo
	local absorbDevice = zooInfo:getAbsorbDevice()
	local now = ServerTime.now()

	if checknumber(absorbDevice.absorbBuddyId) > 0 then
		local time = now - absorbDevice.absorbStartTime + absorbDevice.absorbAccumulateTime
		local maxTime = ZooConfig.instance:getMaxAbsorbTime()

		self._tip.text = maxTime <= time and lang("petzoo_pool_absorb_max") or string.format(lang("petzoo_pool_absorb_timer"), GameUtil.FormatTimeSymbol(time))

		self:_setAbsorbAnimState(1)
	elseif now < absorbDevice.absorbCdEndTime then
		self:_setAbsorbAnimState(2)

		self._tip.text = string.format(lang("petzoo_pool_absorb_cd"), GameUtil.FormatTimeSymbol(absorbDevice.absorbCdEndTime - now))
	else
		self:_setAbsorbAnimState(1)

		self._tip.text = lang("petzoo_pool_absorb_empty")
	end
end

function UnitCompHudZooPool:_setAbsorbAnimState(state)
	local go = self._unit:getGameObject()

	if go and self._absorbAnimState ~= state then
		self._absorbAnimState = state

		if state > 0 then
			GoUtil.PlaySpineAnim(go, tostring(self._absorbAnimState), true, true)
		end
	end
end

return UnitCompHudZooPool
