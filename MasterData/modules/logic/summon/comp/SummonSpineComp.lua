-- chunkname: @modules/logic/summon/comp/SummonSpineComp.lua

module("modules.logic.summon.comp.SummonSpineComp", package.seeall)

local SummonSpineComp = class("SummonSpineComp", LuaCompBase)

function SummonSpineComp.Create(gameObj)
	return (MonoHelper.addNoUpdateLuaComOnceToGo(gameObj, SummonSpineComp))
end

function SummonSpineComp:init(go)
	self._go = go
end

function SummonSpineComp:setConfig(config, hideGameObj)
	if not config or string.nilorempty(config.spinePrefab) then
		gohelper.setActive(self._go, false)

		return
	end

	gohelper.setActive(self._go, true)

	self._spine = self._spine or GuiSpine.Create(self._go, false)
	self._hideGameObj = hideGameObj

	self._spine:setResPath(config.spinePrefab, self._spineLoadFinish, self)
end

function SummonSpineComp:_spineLoadFinish()
	gohelper.setActive(self._hideGameObj, false)
end

function SummonSpineComp:onDestroy()
	if self._spine then
		self._spine:onDestroy()
	end
end

return SummonSpineComp
