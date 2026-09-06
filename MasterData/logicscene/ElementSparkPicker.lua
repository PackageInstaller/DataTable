-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/picker/ElementSparkPicker.lua

module("logicscene.scene.component.picker.ElementSparkPicker", package.seeall)

local ElementSparkPicker = class("ElementSparkPicker", ScenePickerEx)

function ElementSparkPicker:onQueryFindWay(x, y)
	return
end

function ElementSparkPicker:onQueryObject(go)
	if not self._enabled then
		return
	end

	if go.layer == SceneLayer.InteractiveObject_Value then
		local name = go.name
		local idx = string.find(name, UnitTag.TilingSceneElem)

		if idx then
			local eleInsId = tonumber(string.sub(name, string.len(UnitTag.TilingSceneElem) + 2))

			ElementSparkSceneController.instance:onSelectUnitId(eleInsId)

			return
		end
	end
end

return ElementSparkPicker
