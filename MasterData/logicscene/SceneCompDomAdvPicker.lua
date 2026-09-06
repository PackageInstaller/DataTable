-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/picker/SceneCompDomAdvPicker.lua

module("logicscene.scene.component.picker.SceneCompDomAdvPicker", package.seeall)

local SceneCompDomAdvPicker = class("SceneCompDomAdvPicker", SceneComponentBase)

function SceneCompDomAdvPicker:onInit()
	self._enabled = true
end

function SceneCompDomAdvPicker:onExitScene()
	self:enabled(false)
end

function SceneCompDomAdvPicker:enabled(enabled)
	self._enabled = enabled
end

function SceneCompDomAdvPicker:onQueryFindWay(posX, posY)
	if not self._enabled then
		return
	end

	if enableDebug then
		local gridX, gridY = DomAdvPathFindingDataModel.instance:pos2Grid(posX, posY)
		local gridId = DomAdvPathFindingDataModel.instance:grid2Id(gridX, gridY)

		printInfo(string.format("===??? SceneCompDomAdvPicker:onQueryFindWay -> pos:(%s, %s), grid:(%s, %s), gridId:%s", posX, posY, gridX, gridY, gridId))
		GlobalDispatcher:dispatch(GlobalNotify.DomainAdventureSceneClickGrid, gridId)
	else
		local gridId = DomAdvPathFindingDataModel.instance:pos2Id(posX, posY)

		GlobalDispatcher:dispatch(GlobalNotify.DomainAdventureSceneClickGrid, gridId)
	end
end

function SceneCompDomAdvPicker:onQueryObject(go)
	return
end

return SceneCompDomAdvPicker
