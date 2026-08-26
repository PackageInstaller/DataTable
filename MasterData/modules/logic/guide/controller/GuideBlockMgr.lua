-- chunkname: @modules/logic/guide/controller/GuideBlockMgr.lua

module("modules.logic.guide.controller.GuideBlockMgr", package.seeall)

local GuideBlockMgr = class("GuideBlockMgr")

GuideBlockMgr.BlockTime = 0.5

function GuideBlockMgr:ctor()
	self._eventSystemGO = nil
	self._startBlockTime = nil
	self._blockTime = nil
	self._isBlock = false
end

function GuideBlockMgr:startBlock(blockTime)
	if not self._eventSystemGO then
		self._eventSystemGO = gohelper.find("EventSystem")

		if not self._eventSystemGO then
			logError("can't find EventSystem GO")
		end

		TaskDispatcher.runRepeat(self._onTick, self, 0.2)
	end

	if not self._startBlockTime then
		self._isBlock = true

		gohelper.setActive(self._eventSystemGO, false)

		ZProj.TouchEventMgr.Fobidden = true
	end

	self._startBlockTime = Time.time
	self._blockTime = blockTime or GuideBlockMgr.BlockTime
end

function GuideBlockMgr:removeBlock()
	self:_removeBlock()
end

function GuideBlockMgr:_removeBlock()
	self._startBlockTime = nil
	self._isBlock = false

	gohelper.setActive(self._eventSystemGO, true)

	ZProj.TouchEventMgr.Fobidden = false
end

function GuideBlockMgr:isBlock()
	return self._isBlock
end

function GuideBlockMgr:_onTick()
	if self._startBlockTime and Time.time - self._startBlockTime >= self._blockTime then
		self:_removeBlock()
	end
end

GuideBlockMgr.instance = GuideBlockMgr.New()

return GuideBlockMgr
