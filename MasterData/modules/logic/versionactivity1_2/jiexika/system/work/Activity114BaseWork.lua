-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114BaseWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114BaseWork", package.seeall)

local Activity114BaseWork = class("Activity114BaseWork", BaseWork)

function Activity114BaseWork:forceEndStory()
	if self._flow then
		local curWork = self._flow._workList[self._flow._curIndex]

		if not curWork then
			return
		end

		curWork:forceEndStory()
	end
end

function Activity114BaseWork:getFlow()
	self._flow = self._flow or FlowSequence.New()

	return self._flow
end

function Activity114BaseWork:startFlow()
	if self._flow then
		self._flow:registerDoneListener(self.onDone, self)
		self._flow:start(self.context)
	else
		self:onDone(true)
	end
end

function Activity114BaseWork:clearWork()
	if self._flow then
		self._flow:onDestroy()

		self._flow = nil
	end
end

return Activity114BaseWork
