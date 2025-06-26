-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Input\\HorizontalRPGInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:OnTap(mouseX, mouseY)
	if HorizontalRPGModule.horizontalRPGScene.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(HorizontalRPGModule.horizontalRPGScene.MainCamera) then
		return
	end

	local hits = LuaCodeInterface.RaycastAll(HorizontalRPGModule.horizontalRPGScene.MainCamera:ScreenToWorldPoint(Vector3(mouseX, mouseY, 0)), Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit.collider ~= nil then
			local hitObj = hit.collider.gameObject

			if hitObj ~= nil then
				HorizontalRPGModule.horizontalRPGScene:OnTapObject(hitObj)

				break
			end
		end
	end
end

return m
