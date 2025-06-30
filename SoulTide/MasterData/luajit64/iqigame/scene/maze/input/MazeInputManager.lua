-- chunkname: @IQIGame\\Scene\\Maze\\Input\\MazeInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:OnTap(mouseX, mouseY)
	if MazeModule.MazeScene.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(MazeModule.MazeScene.MainCamera) then
		return
	end

	local hits = LuaCodeInterface.RaycastAll(MazeModule.MazeScene.MainCamera:ScreenToWorldPoint(Vector3(mouseX, mouseY, 0)), Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit.collider ~= nil then
			local controller = MazeModule.MazeScene:GetControllerByGOInsID(hit.collider.gameObject:GetInstanceID())

			if controller ~= nil and MazeModule.MazeScene:IsNode(controller) then
				MazeModule.MazeScene:OnTapNode(controller)
			end
		end
	end
end

function m:OnDrag(state, deltaX, deltaY)
	if MazeModule.GetCanDragCamera() then
		if state == DigitalRubyShared.GestureRecognizerState.Began then
			MazeModule.MazeScene:RecordBgRollingDragDelta()
		end

		if state == DigitalRubyShared.GestureRecognizerState.Executing then
			self:MoveCamera(-deltaX * 0.01, -deltaY * 0.01)
		end
	end
end

function m:MoveCamera(dx, dy)
	local position = MazeModule.MazeScene.MainCamera.transform.position

	position.x = position.x + dx
	position.y = position.y + dy

	MazeModule.MazeScene:MoveCamera(position, true, true)
end

return m
