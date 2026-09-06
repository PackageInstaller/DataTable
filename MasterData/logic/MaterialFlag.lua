-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/MaterialFlag.lua

module("logic.extensions.material.proxy.MaterialFlag", package.seeall)

local MaterialFlag = class("MaterialFlag")

function MaterialFlag:ctor()
	return
end

function MaterialFlag:setData(type, id, subType, proxy)
	self.type = type
	self.id = id
	self.subType = subType
	self.proxy = proxy
end

function MaterialFlag:toString()
	return self.type .. "_" .. self.id
end

function MaterialFlag:setProxy(proxy)
	self.proxy = proxy
end

return MaterialFlag
