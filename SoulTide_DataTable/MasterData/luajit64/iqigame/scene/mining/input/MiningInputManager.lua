-- chunkname: @IQIGame\\Scene\\Mining\\Input\\MiningInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:OnTap(mouseX, mouseY)
	if MiningModule.miningScene.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(MiningModule.miningScene.MainCamera) then
		return
	end

	local hits = LuaCodeInterface.RaycastAll(MiningModule.miningScene.MainCamera:ScreenToWorldPoint(Vector3(mouseX, mouseY, 0)), Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit.collider ~= nil then
			local hitObj = hit.collider.gameObject

			if hitObj ~= nil then
				MiningModule.miningScene:OnTapObject(hitObj)

				break
			end
		end
	end
end

return m
