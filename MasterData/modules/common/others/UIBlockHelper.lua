-- chunkname: @modules/common/others/UIBlockHelper.lua

module("modules.common.others.UIBlockHelper", package.seeall)

local UIBlockHelper = class("UIBlockHelper")

function UIBlockHelper:_init()
	if not self._inited then
		self._inited = true
		self._blockTimeDict = {}
		self._blockViewDict = {}
		self._blockViewCount = {}
		self._nextRemoveBlockTime = 0

		setmetatable(self._blockViewCount, {
			__index = function()
				return 0
			end
		})
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	end
end

function UIBlockHelper:startBlock(key, time, bindViewName)
	self:_init()

	if self._blockTimeDict[key] and self._blockViewDict[key] ~= bindViewName then
		logError("不支持改变绑定的界面")

		return
	end

	time = time or 0.1

	UIBlockMgr.instance:startBlock(key)

	if bindViewName and not self._blockTimeDict[key] then
		self._blockViewDict[key] = bindViewName
		self._blockViewCount[bindViewName] = self._blockViewCount[bindViewName] + 1
	end

	self._blockTimeDict[key] = UnityEngine.Time.time + time

	self:_checkNextRemoveBlock()
end

function UIBlockHelper:endBlock(key)
	if not self._blockTimeDict or not self._blockTimeDict[key] then
		return
	end

	self:_endBlock(key)
	self:_checkNextRemoveBlock()
end

function UIBlockHelper:_checkNextRemoveBlock()
	local nowTime = UnityEngine.Time.time
	local nextTime = math.huge

	for key, time in pairs(self._blockTimeDict) do
		if time < nowTime then
			self:endBlock(key)
		elseif time < nextTime then
			nextTime = time
		end
	end

	if nextTime ~= math.huge then
		if nextTime ~= self._nextRemoveBlockTime then
			self._nextRemoveBlockTime = nextTime

			TaskDispatcher.cancelTask(self._checkNextRemoveBlock, self)
			TaskDispatcher.runDelay(self._checkNextRemoveBlock, self, nextTime - nowTime)
		end
	elseif self._nextRemoveBlockTime ~= 0 then
		self._nextRemoveBlockTime = 0

		TaskDispatcher.cancelTask(self._checkNextRemoveBlock, self)
	end
end

function UIBlockHelper:_endBlock(key)
	UIBlockMgr.instance:endBlock(key)

	self._blockTimeDict[key] = nil

	if self._blockViewDict[key] then
		local bindViewName = self._blockViewDict[key]

		self._blockViewCount[bindViewName] = self._blockViewCount[bindViewName] - 1

		if self._blockViewCount[bindViewName] == 0 then
			self._blockViewCount[bindViewName] = nil
		end
	end
end

function UIBlockHelper:_onCloseView(closeViewName)
	if self._blockViewCount[closeViewName] > 0 then
		for key, viewName in pairs(self._blockViewDict) do
			if viewName == closeViewName then
				self:endBlock(key)
			end
		end

		self:_checkNextRemoveBlock()
	end
end

function UIBlockHelper:clearAll()
	if not self._blockTimeDict then
		return
	end

	for key in pairs(self._blockTimeDict) do
		self:_endBlock(key)
	end

	self._nextRemoveBlockTime = 0

	TaskDispatcher.cancelTask(self._checkNextRemoveBlock, self)
end

UIBlockHelper.instance = UIBlockHelper.New()

return UIBlockHelper
