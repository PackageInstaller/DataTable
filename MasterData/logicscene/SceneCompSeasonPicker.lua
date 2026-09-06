-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonPicker.lua

module("logicscene.scene.component.season.SceneCompSeasonPicker", package.seeall)

local SceneCompSeasonPicker = class("SceneCompSeasonPicker", ScenePickerEx)

function SceneCompSeasonPicker:onQueryFindWay(x, y)
	if SeasonTeamsModel.instance:getCurrTeamId() == 0 then
		return
	end

	if not self._enabled or not self._mainPlayer or self._mainPlayer.transmitPoint then
		return
	end

	x, y = self:_restrictByGrid(x, y)

	local gridX, gridY = SeasonPathFindingDataModel.instance:pos2Grid(x, y)

	GlobalDispatcher:dispatch(GlobalNotify.SeasonSelectGrid, gridX, gridY)
end

function SceneCompSeasonPicker:realOnQueryFindWay(gridX, gridY)
	if SeasonTeamsModel.instance:getCurrTeamId() == 0 then
		return
	end

	if not self._enabled or not self._mainPlayer or self._mainPlayer.transmitPoint then
		return
	end

	SceneCompSeasonPicker.super.onQueryFindWay(self, gridX, gridY)
end

function SceneCompSeasonPicker:onQueryObject(go)
	if SeasonTeamsModel.instance:getCurrTeamId() == 0 then
		return
	end

	if not self._enabled then
		return
	end

	local posx, posy, posz = Framework.TransformUtil.GetPos(go.transform, nil, nil, nil)

	if go.layer == SceneLayer.Unit_Value or go.layer == SceneLayer.InteractiveObject_Value then
		local name = go.name
		local idx = string.find(name, "SceneElement_")

		if idx and not string.find(name, UnitTag.TilingSceneElem) then
			local eleId = tonumber(string.sub(name, 14))
			local gridX, gridY = SeasonPathFindingDataModel.instance:getCellRowAndColIndexByElementId(eleId)

			GlobalDispatcher:dispatch(GlobalNotify.SeasonSelectGrid, gridX, gridY)

			return
		end
	end

	self:onQueryFindWay(posx, posy)

	do return end

	SceneCompSeasonPicker.super.onQueryObject(self, go)
end

function SceneCompSeasonPicker:_restrictByGrid(x, y)
	return x, y
end

return SceneCompSeasonPicker
