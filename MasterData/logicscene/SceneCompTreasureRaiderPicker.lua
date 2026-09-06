-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/treasureraider/SceneCompTreasureRaiderPicker.lua

module("logicscene.scene.component.treasureraider.SceneCompTreasureRaiderPicker", package.seeall)

local SceneCompTreasureRaiderPicker = class("SceneCompTreasureRaiderPicker", ScenePickerEx)

function SceneCompTreasureRaiderPicker:onQueryNoneObject(screePos)
	if UGUIToolHelper.IsOverUI() then
		return
	end

	local pos = screePos

	pos.z = 100

	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()

	pos = mainCamera:ScreenToWorldPoint(pos)

	local parentTransform = self._scene:getContainer().gameObject.transform
	local localPos = parentTransform:InverseTransformPoint(pos)

	self:onQueryFindWay(localPos.x, localPos.y)
end

function SceneCompTreasureRaiderPicker:_findProduce(mousePos)
	local cameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local isProduce = false
	local gridX, gridY, x, y

	if cameraTarget then
		local ray = cameraTarget:getCamera():ScreenPointToRay(mousePos)
		local isHit, hitResult = UnityEngine.Physics.Raycast(ray, nil)

		if hitResult then
			local parent = hitResult.collider.gameObject.transform.parent

			if isHit and not goutil.isNil(parent) then
				local name = parent.name

				if string.find(name, "produce_") then
					isProduce = true

					local instanceId = checknumber(string.split(name, "_")[2])
					local unit = self._scene.unitFactory:getUnit(UnitTag.TilingSceneElem, instanceId)

					if unit then
						gridY = unit.col
						gridX = unit.row
						x, y = self._scene:getTool():grid2Pos(unit.row, unit.col)
					end

					return true, gridX, gridY, x, y
				end
			end
		end
	end
end

function SceneCompTreasureRaiderPicker:onQueryFindWay(x, y)
	if not self._enabled or not self._mainPlayer or self._mainPlayer.transmitPoint then
		return
	end

	x, y = self:_restrictByGrid(x, y)

	local gridX, gridY = self._scene:getTool():pos2Grid(x, y)
	local screePos = UGUIToolHelper.GetTouchPosition()
	local isProduce, gridXT, gridYT, xT, yT = self:_findProduce(screePos)

	if isProduce then
		y = yT
		x = xT
		gridY = gridYT
		gridX = gridXT

		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderClickProduce, xT, yT, gridXT, gridYT)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderSelectPos, x, y, gridX, gridY)
	end
end

function SceneCompTreasureRaiderPicker:realOnQueryFindWay(x, y)
	if not self._enabled or not self._mainPlayer or self._mainPlayer.transmitPoint then
		return
	end

	x, y = self:_restrictByGrid(x, y)

	SceneCompTreasureRaiderPicker.super.onQueryFindWay(self, x, y)
end

function SceneCompTreasureRaiderPicker:onQueryObject(go)
	if not self._enabled then
		return
	end

	local posx, posy, _ = Framework.TransformUtil.GetPos(go.transform, nil, nil, nil)

	self:onQueryFindWay(posx, posy)
end

function SceneCompTreasureRaiderPicker:_restrictByGrid(x, y)
	return x, y
end

return SceneCompTreasureRaiderPicker
