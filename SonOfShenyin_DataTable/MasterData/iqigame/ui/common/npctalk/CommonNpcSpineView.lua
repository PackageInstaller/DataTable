-- chunkname: @IQIGame\\UI\\Common\\NpcTalk\\CommonNpcSpineView.lua

local UISpineView = require("IQIGame/UI/Common/UISpine/UISpineView")
local m = Clone(UISpineView)

m.IdleAnimName = "idle"

function m.New(entityCid, parentTrans, callback)
	local obj = Clone(m)

	obj:Init(entityCid, parentTrans, callback)

	return obj
end

function m:Init(entityCid, parentTrans, callback)
	self.__CommonNpcSpineView_completeCallback = callback

	self:_OnCreate(entityCid, parentTrans, nil, function()
		self:OnSpineReady()
	end)
end

function m:OnSpineReady()
	self:PlayIdleAnim()

	if self.__CommonNpcSpineView_completeCallback then
		self.__CommonNpcSpineView_completeCallback()
	end
end

function m:PlayAnim(animation)
	self:_PlayAnim(animation, false, function()
		self:PlayIdleAnim()
	end)
end

function m:PlayIdleAnim()
	self:_PlayAnim(self.IdleAnimName, true)
end

function m:Hide()
	self:_Hide()
end

function m:Dispose()
	self:_Dispose()
end

return m
