-- chunkname: @modules/logic/fight/system/work/FightWorkLoadAssetByComp.lua

module("modules.logic.fight.system.work.FightWorkLoadAssetByComp", package.seeall)

local FightWorkLoadAssetByComp = class("FightWorkLoadAssetByComp", FightWorkItem)

function FightWorkLoadAssetByComp:onConstructor(url, loaderComp, callback, handle, ...)
	self.url = url
	self.loaderComp = loaderComp
	self.callback = callback
	self.handle = handle
	self.param = {
		...
	}
	self.paramCount = select("#", ...)
end

function FightWorkLoadAssetByComp:onStart()
	self.loaderComp:loadAsset(self.url, self.onLoaded, self)
	self:cancelFightWorkSafeTimer()
end

function FightWorkLoadAssetByComp:onLoaded(success, loader)
	if self.callback then
		self.callback(self.handle, success, loader, unpack(self.param, 1, self.paramCount))
	end

	self:onDone(true)
end

return FightWorkLoadAssetByComp
