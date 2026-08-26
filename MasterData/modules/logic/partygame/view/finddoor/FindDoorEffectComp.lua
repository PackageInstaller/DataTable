-- chunkname: @modules/logic/partygame/view/finddoor/FindDoorEffectComp.lua

module("modules.logic.partygame.view.finddoor.FindDoorEffectComp", package.seeall)

local FindDoorEffectComp = class("FindDoorEffectComp", LuaCompBase)
local LightStatus = {
	Yellow = 2,
	Green = 3,
	Opened = 999,
	Red = 1
}

function FindDoorEffectComp:init(go)
	local root = gohelper.findChild(GameSceneMgr.instance:getCurScene():getSceneContainerGO(), "game13_p(Clone)")

	self._doors = self:getUserDataTb_()
	self._lights = self:getUserDataTb_()
	self._lightStatus = {}

	if root then
		for i = 1, 4 do
			for j = 1, 16 do
				local door = gohelper.findChildAnim(root, string.format("scene/obj/door/party_game13_door_%d_%d", i, j))
				local light = gohelper.findChildAnim(root, string.format("scene/obj/light/party_game13_light_%d_%d", i, j))

				GameUtil.setTbValue(self._doors, i, j, door)
				GameUtil.setTbValue(self._lights, i, j, light)
				GameUtil.setTbValue(self._lightStatus, i, j, LightStatus.Red)
			end
		end
	end
end

function FindDoorEffectComp:setNearDoor(layer, index)
	if self._nearLayer == layer and self._nearIndex == index then
		return
	end

	if self._nearLayer and self._nearIndex then
		self:setLightStatus(self._nearLayer, self._nearIndex, LightStatus.Red)
	end

	self._nearLayer = layer
	self._nearIndex = index

	if self._nearLayer and self._nearIndex then
		self:setLightStatus(self._nearLayer, self._nearIndex, LightStatus.Yellow)
	end
end

function FindDoorEffectComp:setLightStatus(layer, index, status)
	local nowStatus = GameUtil.getTbValue(self._lightStatus, layer, index)

	if nowStatus == status or nowStatus == LightStatus.Green or nowStatus == LightStatus.Opened and status ~= LightStatus.Green then
		return
	end

	GameUtil.setTbValue(self._lightStatus, layer, index, status)

	if status == LightStatus.Opened then
		status = LightStatus.Yellow
	end

	local light = GameUtil.getTbValue(self._lights, layer, index)

	if light then
		light:Play("state" .. status)
	end
end

function FindDoorEffectComp:openDoor(layer, index)
	local door = GameUtil.getTbValue(self._doors, layer, index)

	if door then
		door:Play("open", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame.game13_door_open)
	end
end

function FindDoorEffectComp:closeDoor(layer, index)
	local door = GameUtil.getTbValue(self._doors, layer, index)

	if door then
		door:Play("close", 0, 0)
	end
end

return FindDoorEffectComp
