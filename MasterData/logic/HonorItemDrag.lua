-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/HonorItemDrag.lua

module("logic.extensions.newfamily.view.HonorItemDrag", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local HonorItemDrag = class("HonorItemDrag")

HonorItemDrag.Events = {}
HonorItemDrag.Events.Click = "HonorItemDrag.Events.Click"
HonorItemDrag.Events.Press = "HonorItemDrag.Events.Press"

function HonorItemDrag.AddOnce(go)
	local component = HonorItemDrag.Get(go)

	component = component or LuaComponentContainer.Add(go, HonorItemDrag)

	return component
end

function HonorItemDrag.Remove(go)
	LuaComponentContainer.Remove(go, HonorItemDrag)
end

function HonorItemDrag.Get(go)
	return (LuaComponentContainer.Get(go, HonorItemDrag))
end

function HonorItemDrag:ctor(targetGo)
	NotifyDispatcher.extend(self)

	self._targetGo = targetGo
	self._isInterim = nil
	self._honorLuaData = nil
end

function HonorItemDrag:initSaveData(data)
	self._isInterim = true
	self._honorLuaData = data
end

function HonorItemDrag:initCacheData(data)
	self._isInterim = false
	self._honorLuaData = data
end

function HonorItemDrag:OnDestroy()
	self._targetGo = nil
	self._isInterim = nil
	self._honorLuaData = nil
end

function HonorItemDrag:_onClickHonorItem()
	return
end

function HonorItemDrag:getHonorLuaData()
	return self._honorLuaData
end

function HonorItemDrag:getHonorInfo()
	if self._honorLuaData then
		return self._honorLuaData.info
	end

	return nil
end

function HonorItemDrag:getHonorCfg()
	if self._honorLuaData then
		return self._honorLuaData.cfg
	end

	return nil
end

function HonorItemDrag:getHonorItemWidth()
	if self._honorLuaData and self._honorLuaData.cfg then
		return self._honorLuaData.cfg.width
	end

	return 0
end

function HonorItemDrag:getHonorItemHeight()
	if self._honorLuaData and self._honorLuaData.cfg then
		return self._honorLuaData.cfg.height
	end

	return 0
end

function HonorItemDrag:getTargetGo()
	return self._targetGo
end

return HonorItemDrag
