-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/facade/BattleScenePickerViewFacade.lua

module("logic.extensions.battle.facade.BattleScenePickerViewFacade", package.seeall)

local BattleScenePickerViewFacade = class("BattleScenePickerViewFacade", BaseFacade)

function BattleScenePickerViewFacade:setEnable(enable, key)
	enable = BattleViewStateModel.instance:setUIElementVisible(BattleUIElement.ScenePicker, enable, key)

	return ScenePickerViewFacade.instance:setEnable(enable)
end

function BattleScenePickerViewFacade:testHitScreenPoint(screenX, screenY)
	return ScenePickerViewFacade.instance:testHitScreenPoint(screenX, screenY)
end

function BattleScenePickerViewFacade:simulatePickCoordinates(coordinatesx, coordinatesz, isDoubleClick)
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(coordinatesx, coordinatesz)

	BattleDispatcher:dispatchEvent(BattleEventType.ON_SIMULATE_PICK_UNION_INDEX, unionIndex, isDoubleClick)
end

function BattleScenePickerViewFacade:getHitCount()
	return ScenePickerViewFacade.instance:getHitCount()
end

function BattleScenePickerViewFacade:getHitPointXYZ(index)
	return ScenePickerViewFacade.instance:getHitPointXYZ(index)
end

BattleScenePickerViewFacade.instance = BattleScenePickerViewFacade.New()

return BattleScenePickerViewFacade
