-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/FaceId.lua

module("logic.extensions.common.FaceId", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local FaceId = class("FaceId")

function FaceId.AddOnce(go)
	local component = FaceId.Get(go)

	component = component or LuaComponentContainer.Add(go, FaceId)

	return component
end

function FaceId.Remove(go)
	LuaComponentContainer.Remove(go, FaceId)
end

function FaceId.Get(go)
	return (LuaComponentContainer.Get(go, FaceId))
end

function FaceId:ctor(target)
	self._faceId = nil
end

function FaceId:SetData(faceId)
	self._faceId = faceId
end

function FaceId:GetData()
	return self._faceId
end

return FaceId
