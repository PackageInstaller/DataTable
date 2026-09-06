-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/petzoo/UnitCompHudZooTree.lua

module("logicscene.scene.unit.component.hud.petzoo.UnitCompHudZooTree", package.seeall)

local UnitCompHudZooTree = class("UnitCompHudZooTree", UnitCompHudBase)

function UnitCompHudZooTree:update(deltaTime)
	if not self._hudGameObject then
		return
	end

	self:_updateFruits()
end

function UnitCompHudZooTree:_getResPath()
	return "ui/views/zoo/zootreefruitnum.prefab"
end

function UnitCompHudZooTree:_updateHudInfo(hudGo)
	self:setHudOffset(-0.5, 3, 0)

	self._txtNum = goutil.findChildTextComponent(hudGo, "num")
	self._txtTime = goutil.findChildTextComponent(hudGo, "time")

	self:_updateFruits()
end

function UnitCompHudZooTree:_updateFruits()
	local treeBuildingMO = self._unit:getBuildingMO()

	if not treeBuildingMO or not treeBuildingMO.isUnlocked then
		if self._hudGameObject.activeSelf then
			self._hudGameObject:SetActive(false)
		end

		return
	end

	if not self._hudGameObject.activeSelf then
		self._hudGameObject:SetActive(true)
	end

	local num = treeBuildingMO:getCurrTreeFriutsNum()
	local maxNum = treeBuildingMO:getMaxNum()

	if num < maxNum then
		local now = ServerTime.now()
		local time = 0
		local treeRefreshTime = treeBuildingMO.treeRefreshTime

		if now < treeRefreshTime then
			time = treeRefreshTime - now
		else
			local refreshSec = treeBuildingMO:getIntervalPerNum()
			local maxTime = treeRefreshTime + (maxNum - treeBuildingMO.treeFruitNum) * refreshSec

			time = maxTime - now
		end

		self._txtTime.text = string.format(lang("petzoo_friuts_max_timer"), GameUtil.FormatTimeSymbol(time))
	else
		self._txtTime.text = lang("petzoo_friuts_nummax")
	end

	self._txtNum.text = string.format("%d/%d", num, maxNum)
end

return UnitCompHudZooTree
