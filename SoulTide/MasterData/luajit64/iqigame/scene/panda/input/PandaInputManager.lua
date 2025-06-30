-- chunkname: @IQIGame\\Scene\\Panda\\Input\\PandaInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:OnTap(mouseX, mouseY)
	if ActivePandaModule.pandaScene.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(ActivePandaModule.pandaScene.MainCamera) then
		return
	end

	local hits = LuaCodeInterface.RaycastAll(ActivePandaModule.pandaScene.MainCamera:ScreenToWorldPoint(Vector3(mouseX, mouseY, 0)), Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit.collider ~= nil then
			local hitObj = hit.collider.gameObject

			if hitObj ~= nil then
				ActivePandaModule.pandaScene:OnTapObject(hitObj)

				break
			end
		end
	end
end

return m
