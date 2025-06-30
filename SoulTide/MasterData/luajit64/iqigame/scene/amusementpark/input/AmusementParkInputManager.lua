-- chunkname: @IQIGame\\Scene\\AmusementPark\\Input\\AmusementParkInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:OnTap(mouseX, mouseY)
	if AmusementParkModule.AmusementParkScene.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(AmusementParkModule.AmusementParkScene.MainCamera) then
		return
	end

	local hits = LuaCodeInterface.RaycastAll(AmusementParkModule.AmusementParkScene.MainCamera:ScreenToWorldPoint(Vector3(mouseX, mouseY, 0)), Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit.collider ~= nil then
			local hitObj = hit.collider.gameObject

			if hitObj ~= nil then
				AmusementParkModule.AmusementParkScene:OnTapObject(hitObj)

				break
			end
		end
	end
end

function m:OnDrag(state, deltaX, deltaY)
	if state == DigitalRubyShared.GestureRecognizerState.Ended then
		AmusementParkModule.AmusementParkScene:OnDragEnd(state, deltaX, deltaY)
	elseif state == DigitalRubyShared.GestureRecognizerState.Began then
		AmusementParkModule.AmusementParkScene:OnBeganDrag(state, deltaX, deltaY)
	elseif state == DigitalRubyShared.GestureRecognizerState.Executing then
		AmusementParkModule.AmusementParkScene:OnDrag(state, deltaX, deltaY)
	end
end

return m
