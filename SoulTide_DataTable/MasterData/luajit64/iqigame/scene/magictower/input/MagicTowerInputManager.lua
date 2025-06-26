-- chunkname: @IQIGame\\Scene\\MagicTower\\Input\\MagicTowerInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:OnTap(mouseX, mouseY)
	if MagicTowerModule.MagicTowerScene.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(MagicTowerModule.MagicTowerScene.MainCamera) then
		return
	end

	local hits = LuaCodeInterface.RaycastAll(MagicTowerModule.MagicTowerScene.MainCamera:ScreenToWorldPoint(Vector3(mouseX, mouseY, 0)), Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit.collider ~= nil then
			local node = MagicTowerModule.MagicTowerScene:GetNodeByInstanceID(hit.collider.gameObject:GetInstanceID())

			if node ~= nil then
				MagicTowerModule.MagicTowerScene:OnTapNode(node)
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
	local position = MagicTowerModule.MagicTowerScene.MainCamera.transform.position

	position.x = position.x + dx
	position.y = position.y + dy

	MagicTowerModule.MagicTowerScene:MoveCamera(position)
end

return m
