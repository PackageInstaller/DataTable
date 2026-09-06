-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/SimpleFSM.lua

module("logiccommon.common.util.SimpleFSM", package.seeall)

local SimpleFSM = class("SimpleFSM")

function SimpleFSM:ctor()
	self._isRunning = false

	self:clear()
end

function SimpleFSM:addState(stateName, firstEnterFunc, exitFunc, updateFunc, everEnterFunc)
	local obj = {}

	obj.firstEnterFunc = firstEnterFunc
	obj.everEnterFunc = everEnterFunc
	obj.updateFunc = updateFunc
	obj.exitFunc = exitFunc
	self._stateDataMap = self._stateDataMap or {}
	self._stateDataMap[stateName] = obj
end

function SimpleFSM:addStateCls(stateName, clsObj)
	self._stateDataMap = self._stateDataMap or {}
	self._stateDataMap[stateName] = clsObj
end

function SimpleFSM:setAllStateData(obj)
	self._stateDataMap = obj
end

function SimpleFSM:addLinkByList(linkArr, stateArr)
	for i, arr in ipairs(linkArr) do
		local from = stateArr[i]

		for j, v in ipairs(arr) do
			if v == 1 then
				local to = stateArr[j]

				self:addLink(from, to)
			end
		end
	end
end

function SimpleFSM:addLinkByLinkedList(linkArr)
	for i, arr in pairs(linkArr) do
		local from = i

		for j, v in ipairs(arr) do
			local to = v

			self:addLink(from, to)
		end
	end
end

function SimpleFSM:addLink(from, to)
	self._linkDataObj = self._linkDataObj or {}

	local arr = self._linkDataObj[to]

	if arr == nil then
		arr = {}
	end

	if table.indexof(arr, from) == false then
		table.insert(arr, from)
	end

	self._linkDataObj[to] = arr
end

function SimpleFSM:checkCanGoToState(stateName)
	if self._stateDataMap == nil then
		printError(">>>>>>>> SimpleFSM _stateDataMap is nil")

		return
	end

	local obj

	if self._linkDataObj == nil then
		obj = self._stateDataMap[stateName]
	else
		local all = self._linkDataObj["*"]
		local linkArr = self._linkDataObj[stateName]

		if self.currStateName == nil or linkArr and (table.indexof(linkArr, self.currStateName) ~= false or table.indexof(linkArr, "*") ~= false) or all and (table.indexof(all, self.currStateName) ~= false or table.indexof(all, "*") ~= false) then
			obj = self._stateDataMap[stateName]
		end
	end

	return obj
end

function SimpleFSM:gotoState(stateName)
	if self._isRunning then
		error(">>>>你不能在跳转状态期间跳转到别的状态！！")
	else
		self._isRunning = true

		local obj = self:checkCanGoToState(stateName)

		if obj then
			if self.currStateName ~= stateName then
				if self._currStateObj ~= nil then
					GameUtil.callBack(self._currStateObj.exitFunc, self._currStateObj, self)
				end

				self.lastStateName = self.currStateName or stateName
				self.currStateName = stateName
				self._currStateObj = obj

				if not self._currStateObj.everEnterFunc then
					self._isRunning = false
				end

				GameUtil.callBack(self._currStateObj.firstEnterFunc, self._currStateObj, self)
			end

			self._isRunning = false

			if self._currStateObj then
				GameUtil.callBack(self._currStateObj.everEnterFunc, self._currStateObj, self)
			end
		else
			self._isRunning = false
		end
	end
end

function SimpleFSM:clear()
	self:stopTimer()

	if self._stateDataMap then
		for k, v in pairs(self._stateDataMap) do
			GameUtil.callBack(v.disposeFunc, v)
		end
	end

	self._stateDataMap = nil
	self._linkDataObj = nil
	self._currStateObj = nil
	self.currStateName = nil
	self.lastStateName = nil

	if self._isRunning then
		printError("为什么还在跑就关闭界面了？？？？")
	end
end

function SimpleFSM:startTimer(time)
	time = checknumber(time)

	settimer(time, self._onFrame, self)
end

function SimpleFSM:stopTimer()
	removetimer(self._onFrame, self)

	self.lastStateName = nil
	self.currStateName = nil
	self._currStateObj = nil
end

function SimpleFSM:_onFrame()
	if self._currStateObj then
		local updateFun = self._currStateObj.updateFunc

		GameUtil.callBack(updateFun, self._currStateObj, self)
	end
end

return SimpleFSM
