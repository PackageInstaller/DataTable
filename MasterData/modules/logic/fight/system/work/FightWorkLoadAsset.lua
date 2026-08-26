-- chunkname: @modules/logic/fight/system/work/FightWorkLoadAsset.lua

module("modules.logic.fight.system.work.FightWorkLoadAsset", package.seeall)

local FightWorkLoadAsset = class("FightWorkLoadAsset", FightWorkItem)

function FightWorkLoadAsset:onConstructor(url, callback, handle, ...)
	self.url = url
	self.callback = callback
	self.handle = handle
	self.param = {
		...
	}
	self.paramCount = select("#", ...)
end

function FightWorkLoadAsset:onStart()
	local comp = self.handle:getComponent(FightLoaderComponent)

	comp:loadAsset(self.url, self.onLoaded, self)
	self:cancelFightWorkSafeTimer()
end

function FightWorkLoadAsset:onLoaded(success, loader)
	if self.callback then
		self.callback(self.handle, success, loader, unpack(self.param, 1, self.paramCount))
	end

	self:onDone(true)
end

return FightWorkLoadAsset
