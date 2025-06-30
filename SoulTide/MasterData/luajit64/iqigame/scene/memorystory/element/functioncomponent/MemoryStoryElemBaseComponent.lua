-- chunkname: @IQIGame\\Scene\\MemoryStory\\Element\\FunctionComponent\\MemoryStoryElemBaseComponent.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
end

function m:HideElement()
	self.__ActiveEx(self.view, false)
end

function m:ShowElement()
	self.__ActiveEx(self.view, true)
end

function m:OnDestroy()
	self:__BaseDestroy()
end

function m:__BaseDestroy()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

function m.__ActiveEx(trans, active)
	if trans == nil then
		return
	end

	trans.gameObject:SetActive(active)
end

return m
