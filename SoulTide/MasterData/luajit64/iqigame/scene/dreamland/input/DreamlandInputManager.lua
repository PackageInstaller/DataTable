-- chunkname: @IQIGame\\Scene\\Dreamland\\Input\\DreamlandInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:OnTap(mouseX, mouseY)
	if DreamlandModule.DreamlandScene.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(DreamlandModule.DreamlandScene.MainCamera) then
		return
	end

	local hits = LuaCodeInterface.RaycastAll(DreamlandModule.DreamlandScene.MainCamera:ScreenToWorldPoint(Vector3(mouseX, mouseY, 0)), Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit.collider ~= nil then
			local node = DreamlandModule.DreamlandScene:GetNodeByInstanceID(hit.collider.gameObject:GetInstanceID())

			if node ~= nil then
				DreamlandModule.DreamlandScene:OnTapNode(node)
			end
		end
	end
end

function m:OnDrag(state, deltaX, deltaY)
	if self:IsLock() then
		return
	end

	if state == DigitalRubyShared.GestureRecognizerState.Executing then
		self:MoveCamera(-deltaX * 0.01, -deltaY * 0.01)
	end
end

function m:MoveCamera(dx, dy)
	local position = DreamlandModule.DreamlandScene.MainCamera.transform.position

	position.x = position.x + dx
	position.y = position.y + dy

	DreamlandModule.DreamlandScene:MoveCamera(position)
end

return m
