-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompSpineMoverNone.lua

module("logicscene.scene.unit.component.UnitCompSpineMoverNone", package.seeall)

local UnitCompSpineMoverNone = class("UnitCompSpineMoverNone", UnitComponentBase)

function UnitCompSpineMoverNone:playDefaultIdleAnim()
	return
end

function UnitCompSpineMoverNone:joystickOn(isOn)
	return
end

function UnitCompSpineMoverNone:setAnimState(idleAnim, walkAnim)
	return
end

function UnitCompSpineMoverNone:getIdleAnimState()
	return nil
end

function UnitCompSpineMoverNone:playBornEffect()
	return
end

function UnitCompSpineMoverNone:unactiveBornEffect()
	return
end

function UnitCompSpineMoverNone:playWalkAnim(dirX, dirY)
	local go = self._unit:getGameObject()

	if not go then
		return
	end

	local icon = goutil.findChild(go, "icon")

	if not icon then
		return
	end

	if dirX > 0 then
		GameUtil.setLocalScale(icon, 1.2, 1.2, 1.2)
	elseif dirX < 0 then
		GameUtil.setLocalScale(icon, -1.2, 1.2, 1.2)
	end
end

function UnitCompSpineMoverNone:playIdleAnim()
	return
end

return UnitCompSpineMoverNone
