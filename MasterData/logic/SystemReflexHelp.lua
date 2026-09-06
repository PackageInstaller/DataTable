-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/comp/SystemReflexHelp.lua

module("logic.extensions.spineinterface.comp.SystemReflexHelp", package.seeall)

local SystemReflexHelp = {}
local typeCache = {}
local fieldCache = {}
local propertyCache = {}
local methodCache = {}

function SystemReflexHelp.getType(typeName)
	local _type = typeCache[typeName]

	if _type == nil then
		_type = System.Type.GetType(typeName)
		typeCache[typeName] = _type
	end

	if _type == nil then
		printError(string.format("无法找到对应类型( typeName = %s )", typeName))
	end

	return _type
end

function SystemReflexHelp.getField(typeName, fieldName)
	local key = typeName .. "." .. fieldName

	if not fieldCache[key] then
		local type = SystemReflexHelp.getType(typeName)

		if type then
			fieldCache[key] = tolua.getfield(type, fieldName)
		end
	end

	if fieldCache[key] == nil then
		printError(string.format("无法获取字段( fieldName = %s )", fieldName))
	end

	return fieldCache[key]
end

function SystemReflexHelp.getFieldValue(typeName, fieldName, target)
	local field = SystemReflexHelp.getField(typeName, fieldName)

	if field then
		return field:Get(target)
	end
end

function SystemReflexHelp.getFieldValueWithFlags(typeName, fieldName, target, bindingFlags)
	local field = SystemReflexHelp.getFieldWithFlags(typeName, fieldName, bindingFlags)

	if field then
		return field:Get(target)
	end
end

function SystemReflexHelp.getFieldWithFlags(typeName, fieldName, bindingFlags)
	local key = typeName .. "." .. fieldName .. "." .. tostring(bindingFlags)

	if not fieldCache[key] then
		local type = SystemReflexHelp.getType(typeName)

		if type then
			fieldCache[key] = tolua.getfield(type, fieldName, bindingFlags)
		end
	end

	if fieldCache[key] == nil then
		printError(string.format("无法获取字段( fieldName = %s )", fieldName))
	end

	return fieldCache[key]
end

function SystemReflexHelp.setFieldValue(typeName, fieldName, target, value)
	local field = SystemReflexHelp.getField(typeName, fieldName)

	if field then
		field:Set(target, value)
	end
end

function SystemReflexHelp.getFieldValueWithFlags(typeName, fieldName, target, bindingFlags)
	local field = SystemReflexHelp.getFieldWithFlags(typeName, fieldName, bindingFlags)

	if field then
		return field:Get(target)
	end
end

function SystemReflexHelp.getFieldWithFlags(typeName, fieldName, bindingFlags)
	local key = typeName .. "." .. fieldName .. "." .. tostring(bindingFlags)

	if not fieldCache[key] then
		local type = SystemReflexHelp.getType(typeName)

		if type then
			fieldCache[key] = tolua.getfield(type, fieldName, bindingFlags)
		end
	end

	if fieldCache[key] == nil then
		printError(string.format("无法获取字段( fieldName = %s )", fieldName))
	end

	return fieldCache[key]
end

function SystemReflexHelp.getProperty(typeName, propertyName)
	local key = typeName .. "." .. propertyName

	if not propertyCache[key] then
		local type = SystemReflexHelp.getType(typeName)

		if type then
			propertyCache[key] = tolua.getproperty(type, propertyName)
		end
	end

	if propertyCache[key] == nil then
		printError(string.format("无法获取属性( propertyName = %s )", propertyName))
	end

	return propertyCache[key]
end

function SystemReflexHelp.getPropertyValue(typeName, propertyName, target)
	local property = SystemReflexHelp.getProperty(typeName, propertyName)

	if property then
		return property:Get(target, nil)
	end
end

function SystemReflexHelp.setPropertyValue(typeName, propertyName, target, value)
	local property = SystemReflexHelp.getProperty(typeName, propertyName)

	if property then
		property:Set(target, value, nil)
	end
end

function SystemReflexHelp.getMethod(typeName, methodName, ...)
	local args = {
		...
	}
	local argTypes = {}

	for i = 1, #args do
		argTypes[i] = SystemReflexHelp.getType(args[i])
	end

	local key = typeName .. "." .. methodName .. table.concat(args)

	methodCache[key] = methodCache[key] or tolua.getmethod(SystemReflexHelp.getType(typeName), methodName, unpack(argTypes))

	return methodCache[key]
end

function SystemReflexHelp.setSkeletonGraphicPmaVertexColors(graphic, value)
	local boolValue = value == true
	local settingsObj = SystemReflexHelp.getFieldValue("Spine.Unity.MeshGenerator", "settings", graphic.MeshGenerator)

	SystemReflexHelp.setFieldValue("Spine.Unity.MeshGenerator+Settings", "pmaVertexColors", settingsObj, boolValue)
	SystemReflexHelp.setFieldValue("Spine.Unity.MeshGenerator", "settings", graphic.MeshGenerator, settingsObj)
end

function SystemReflexHelp.getDataOfSpineSlotSlot(slot)
	return SystemReflexHelp.getPropertyValue("Spine.Slot", "Data", slot)
end

function SystemReflexHelp.getIndexOfSpineSlotSlotData(slotData)
	return SystemReflexHelp.getPropertyValue("Spine.SlotData", "Index", slotData)
end

function SystemReflexHelp.getAttachmentOfSpineSlot(slot)
	return SystemReflexHelp.getPropertyValue("Spine.Slot", "Attachment", slot)
end

function SystemReflexHelp.getNameOfSpineSlotAttachment(attachment)
	return SystemReflexHelp.getPropertyValue("Spine.Attachment", "Name", attachment)
end

function SystemReflexHelp.getWorldVerticesLengthOfSpineBoundingBoxAttachment(boundingBoxAttachment)
	return SystemReflexHelp.getPropertyValue("Spine.BoundingBoxAttachment", "WorldVerticesLength", boundingBoxAttachment)
end

function SystemReflexHelp.getNameOfEventData(eventData)
	return SystemReflexHelp.getPropertyValue("Spine.EventData", "Name", eventData)
end

function SystemReflexHelp.getEventsOfSpineEventTimeline(target)
	return SystemReflexHelp.getPropertyValue("Spine.EventTimeline", "Events", target)
end

function SystemReflexHelp.getNameOfSkin(skin)
	return SystemReflexHelp.getPropertyValue("Spine.Skin", "Name", skin)
end

function SystemReflexHelp.getBoneOfSpineSlot(slot)
	return SystemReflexHelp.getPropertyValue("Spine.Slot", "Bone", slot)
end

function SystemReflexHelp.getBoneNameOfSpineBone(bone)
	local boneData = SystemReflexHelp.getPropertyValue("Spine.Bone", "Data", bone)

	if boneData then
		return SystemReflexHelp.getPropertyValue("Spine.BoneData", "Name", boneData)
	end

	return nil
end

function SystemReflexHelp.getSpineBoneWorldTransform(bone)
	local bA = SystemReflexHelp.getPropertyValue("Spine.Bone", "A", bone)
	local bB = SystemReflexHelp.getPropertyValue("Spine.Bone", "B", bone)
	local bC = SystemReflexHelp.getPropertyValue("Spine.Bone", "C", bone)
	local bD = SystemReflexHelp.getPropertyValue("Spine.Bone", "D", bone)
	local bWorldX = SystemReflexHelp.getPropertyValue("Spine.Bone", "WorldX", bone)
	local bWorldY = SystemReflexHelp.getPropertyValue("Spine.Bone", "WorldY", bone)

	return bA, bB, bC, bD, bWorldX, bWorldY
end

function SystemReflexHelp.getWorldRotationXOfSpineBone(bone)
	return SystemReflexHelp.getPropertyValue("Spine.Bone", "WorldRotationX", bone)
end

function SystemReflexHelp.getSpineRegionAttachmentOffset(attachment)
	local x = SystemReflexHelp.getPropertyValue("Spine.RegionAttachment", "X", attachment)
	local y = SystemReflexHelp.getPropertyValue("Spine.RegionAttachment", "Y", attachment)
	local rotation = SystemReflexHelp.getPropertyValue("Spine.RegionAttachment", "Rotation", attachment)

	return x or 0, y or 0, rotation or 0
end

local _Spine_BoundingBoxAttachment_ComputeWorldVertices_Method

function SystemReflexHelp.callComputeWorldVerticesOfSpineBoundingBoxAttachment(boxAtt, slot, worldVertices)
	if _Spine_BoundingBoxAttachment_ComputeWorldVertices_Method == nil then
		_Spine_BoundingBoxAttachment_ComputeWorldVertices_Method = SystemReflexHelp.getMethod("Spine.BoundingBoxAttachment", "ComputeWorldVertices", "Spine.Slot", "System.Single[]")
	end

	_Spine_BoundingBoxAttachment_ComputeWorldVertices_Method:Call(boxAtt, slot, worldVertices)
end

local _EventSystems_RaycastAll_Method

function SystemReflexHelp.callRaycastAllOfEventSystem(eventSystem, eventData, raycastResults)
	if _EventSystems_RaycastAll_Method == nil then
		_EventSystems_RaycastAll_Method = SystemReflexHelp.getMethod("UnityEngine.EventSystems.EventSystem,UnityEngine.UI", "RaycastAll", "UnityEngine.EventSystems.PointerEventData,UnityEngine.UI", "System.Collections.Generic.List`1[[UnityEngine.EventSystems.RaycastResult,UnityEngine.UI]]")
	end

	_EventSystems_RaycastAll_Method:Call(eventSystem, eventData, raycastResults)
end

function SystemReflexHelp.getCountOfSpineExposedListSlot(slots)
	return SystemReflexHelp.getFieldValue("Spine.ExposedList`1[Spine.Slot]", "Count", slots)
end

function SystemReflexHelp.getItemsOfSpineExposedListSlot(slots)
	return SystemReflexHelp.getFieldValue("Spine.ExposedList`1[Spine.Slot]", "Items", slots)
end

function SystemReflexHelp.getItemsOfSpineExposedListTrackEntry(tracks)
	return SystemReflexHelp.getFieldValue("Spine.ExposedList`1[Spine.TrackEntry]", "Items", tracks)
end

function SystemReflexHelp.getCountOfSpineExposedListAnimation(animations)
	return SystemReflexHelp.getFieldValue("Spine.ExposedList`1[Spine.Animation]", "Count", animations)
end

function SystemReflexHelp.getItemsOfSpineExposedListAnimation(animations)
	return SystemReflexHelp.getFieldValue("Spine.ExposedList`1[Spine.Animation]", "Items", animations)
end

function SystemReflexHelp.getCountOfSpineExposedListAnimationTimeline(timelines)
	return SystemReflexHelp.getFieldValue("Spine.ExposedList`1[Spine.Timeline]", "Count", timelines)
end

function SystemReflexHelp.getItemsOfSpineExposedListAnimationTimeline(timelines)
	return SystemReflexHelp.getFieldValue("Spine.ExposedList`1[Spine.Timeline]", "Items", timelines)
end

function SystemReflexHelp.getItemsOfSpineExposedListSkins(skins)
	return SystemReflexHelp.getFieldValue("Spine.ExposedList`1[Spine.Skin]", "Items", skins)
end

function SystemReflexHelp.getForceMode2D(mode)
	return SystemReflexHelp.getFieldValue("UnityEngine.ForceMode2D,UnityEngine", mode, nil)
end

function SystemReflexHelp.setBoxCollider2DSize(target, value)
	SystemReflexHelp.setPropertyValue("UnityEngine.BoxCollider2D,UnityEngine", "size", target, value)
end

local _SceneObjectController_GetPlayerObject_Method

function SystemReflexHelp.getPlayerObject(wholeScene, playerId)
	if wholeScene == nil then
		return nil
	end

	local controller = SystemReflexHelp.getFieldValueWithFlags("WholeScene", "_objectsDynamicController", wholeScene, 36)

	if controller == nil then
		return nil
	end

	if _SceneObjectController_GetPlayerObject_Method == nil then
		local method = SystemReflexHelp.getMethod("SceneObjectController", "GetPlayerObject", "System.String")

		if method == nil then
			return nil
		end

		_SceneObjectController_GetPlayerObject_Method = method
	end

	return _SceneObjectController_GetPlayerObject_Method:Call(controller, playerId)
end

local _SceneObjectPlayer_OnVisible_Method

function SystemReflexHelp.callOnVisibleOfSceneObjectPlayer(player, parent)
	if player == nil then
		printError("SceneObjectPlayer is nil")

		return false
	end

	if _SceneObjectPlayer_OnVisible_Method == nil then
		local method = SystemReflexHelp.getMethod("SceneObjectPlayer", "OnVisible", "UnityEngine.Transform,UnityEngine")

		if method == nil then
			printError("无法获取方法(SceneObjectPlayer.OnVisible)")

			return false
		end

		_SceneObjectPlayer_OnVisible_Method = method
	end

	return _SceneObjectPlayer_OnVisible_Method:Call(player, parent)
end

return SystemReflexHelp
