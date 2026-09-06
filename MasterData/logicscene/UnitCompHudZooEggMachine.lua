-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/petzoo/UnitCompHudZooEggMachine.lua

module("logicscene.scene.unit.component.hud.petzoo.UnitCompHudZooEggMachine", package.seeall)

local UnitCompHudZooEggMachine = class("UnitCompHudZooEggMachine", UnitCompHudBase)

function UnitCompHudZooEggMachine:update(deltaTime)
	self:_updateHatchBubble()
end

function UnitCompHudZooEggMachine:_getResPath()
	return "ui/views/zoo/zoohatchbubble.prefab"
end

function UnitCompHudZooEggMachine:_updateHudInfo(hudGo)
	self._bubble = {}

	for i = 1, 3 do
		self._bubble[i] = goutil.findChild(hudGo, "bubble_" .. i)
	end

	self._stolenMax = goutil.findChild(hudGo, "stolenMax")
	self._stolenMaxItem = goutil.findChild(hudGo, "stolenMax/item")
	self._canAbsorbed = Framework.ButtonAdapter.Get(goutil.findChild(hudGo, "canAbsorb"))

	self._canAbsorbed.gameObject:SetActive(false)
	self:_setFullScreenNodeParent()
	self:_updateHatchBubble()
	self._canAbsorbed:AddClickListener(self._onClickAbsorb, self)
end

function UnitCompHudZooEggMachine:_recycleHud()
	UnitCompHudZooEggMachine.super._recycleHud(self)

	self._bubble = nil
	self._itemProxy = nil
	self._stolenMax = nil

	if self._stolenMaxItem then
		MaterialMgr.resetAll(self._stolenMaxItem)

		self._stolenMaxItem = nil
	end

	if self._canAbsorbed then
		self._canAbsorbed:RemoveClickListener()

		self._canAbsorbed = nil
	end
end

function UnitCompHudZooEggMachine:_updateHatchBubble()
	if not self._hudGameObject then
		return
	end

	local buildingMO = self._unit:getBuildingMO()

	if not buildingMO then
		self._canAbsorbed.gameObject:SetActive(false)
		goutil.setActive(self._bubble[i], false)

		return
	end

	local hatchInfos = buildingMO:getHatchInfos()

	for i = 1, 3 do
		local hatchInfo = hatchInfos[i]

		if hatchInfo.animalRace > 0 then
			local surplusTime = hatchInfo:getHatchSurplusTime()

			goutil.setActive(self._bubble[i], surplusTime <= 0)
		else
			goutil.setActive(self._bubble[i], false)
		end
	end

	local myZoo = ZooModel.instance:getMyZoo()
	local status = myZoo:getAbsorbDeviceStatus(buildingMO.zooMo:getZooUserId())

	if status == ZooMO.absorbDeviceState_Ok then
		self._canAbsorbed.gameObject:SetActive(not buildingMO.zooMo:isMyZoo())
		self._stolenMax:SetActive(false)
	else
		self._canAbsorbed.gameObject:SetActive(false)

		if status == ZooMO.absorbDeviceState_AbaorbMax then
			self._stolenMax:SetActive(true)

			self._itemProxy = self._itemProxy or MaterialMgr.setCellByCfg(ZooConfig.instance:getAbsorbDevicePrize(), self._stolenMaxItem)
		else
			self._stolenMax:SetActive(false)
		end
	end
end

function UnitCompHudZooEggMachine:_onClickAbsorb()
	local buildingMO = self._unit:getBuildingMO()

	TipsFacade.instance:openPopupWindowWithTog(lang("tip"), lang("petzoo_absorb_put_tips"), function()
		ZooController.instance:sendPM_ZooSetAbsorbDeviceReq(buildingMO.zooMo:getZooUserId())
	end)
end

return UnitCompHudZooEggMachine
