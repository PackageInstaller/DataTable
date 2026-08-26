-- chunkname: @modules/logic/fight/system/work/FightWork2Work.lua

module("modules.logic.fight.system.work.FightWork2Work", package.seeall)

local FightWork2Work = class("FightWork2Work", BaseWork)

function FightWork2Work:ctor(class, ...)
	self._param = {
		...
	}
	self._paramCount = select("#", ...)
	self._class = class
end

function FightWork2Work:onStart()
	self._work = self._class.New(unpack(self._param, 1, self._paramCount))

	self._work:registFinishCallback(self.onWorkItemDone, self)

	return self._work:start()
end

function FightWork2Work:onWorkItemDone()
	return self:onDone(true)
end

function FightWork2Work:clearWork()
	if self._work then
		self._work:disposeSelf()

		self._work = nil
	end
end

return FightWork2Work
