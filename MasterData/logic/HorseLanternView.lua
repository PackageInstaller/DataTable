-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/horselantern/view/HorseLanternView.lua

module("logic.extensions.horselantern.view.HorseLanternView", package.seeall)

local HorseLanternView = class("HorseLanternView", ViewComponent)
local json = require("cjson")
local EnumShow = {
	Trigger = 3,
	BackStage = 1,
	CfgType = 2
}

function HorseLanternView:ctor()
	HorseLanternView.super.ctor(self)

	self.EnumState = {
		PauseIdle = 2,
		PauseMove = 3,
		Idle = 0,
		Move = 1
	}
	self._curState = self.EnumState.Idle
	self._width = 712
	self._height = 22
	self._initPosX = self._width / 2
	self._speed = 80
	self._moveDistance = 0
	self._curEndPosX = 0
	self._curPosX = 0
	self._startTime = 0
	self._totalTime = 0
	self._pauseStartTime = 0
	self._pauseTotalTime = 0
	self._waitShowArray = Array.New()
	self._cfgWaitShowArray = Array.New()
	self._triggerWaitShowArray = Array.New()
	self._curQueue = {}
	self._mulMsgList = {}
	self._timeStamp = 0
	self._num = 0
	self._recordTime = 0
	self._targetDuration = 300
	self._remainCount = 30
	self._maxCount = 1000
end

function HorseLanternView:bindEvents()
	GlobalDispatcher:addListener(GlobalNotify.RecLanternMsg, self._onRecLanternMsg, self)
	GlobalDispatcher:addListener(GlobalNotify.DelLanternMsg, self._onDelLanternMsg, self)
	GlobalDispatcher:addListener(GlobalNotify.LanternTriggerInfo, self._onLanternTriggerInfoRes, self)
	self._btn:AddClickListener(self._onClick, self)
end

function HorseLanternView:unbindEvents()
	GlobalDispatcher:removeListener(GlobalNotify.RecLanternMsg, self._onRecLanternMsg, self)
	GlobalDispatcher:removeListener(GlobalNotify.DelLanternMsg, self._onDelLanternMsg, self)
	GlobalDispatcher:removeListener(GlobalNotify.LanternTriggerInfo, self._onLanternTriggerInfoRes, self)
	self._btn:RemoveClickListener()
end

function HorseLanternView:buildUI()
	self._root = self:getGo("root")
	self._showRect = self:getGo("root/showRect"):GetComponent(goutil.Type_RectTransform)
	self._txtContentTrans = self:getGo("root/showRect/txtContent"):GetComponent(goutil.Type_RectTransform)
	self._txtContent = self:getGo("root/showRect/txtContent"):GetComponent(goutil.Type_UIText)
	self._btnRect = self:getGo("root/btn"):GetComponent(goutil.Type_RectTransform)
	self._btn = self:getBtn("root/btn")
end

function HorseLanternView:destroyUI()
	return
end

function HorseLanternView:_onClick()
	if self._curQueue then
		printInfo("按钮点击了！！！！！！,超链接类型是： ", self._curQueue.linkType)
	end
end

function HorseLanternView:_onRecLanternMsg(msgList)
	printWarn("收到走马灯消息！！！")
	self:_handleMsgList(msgList)
end

function HorseLanternView:_onDelLanternMsg(msgIds)
	for k1, v1 in pairs(msgIds) do
		for k2, v2 in pairs(self._mulMsgList) do
			if v1 == v2.id then
				printInfo("1删除走马灯id = ", v2.id)

				self._mulMsgList[k2] = nil
			end
		end

		self:_delWaitShowQueueMsg(v1)
		self:_clearNilElement()
	end
end

function HorseLanternView:_onLanternTriggerInfoRes(msgList)
	if msgList and self._triggerWaitShowArray:GetSize() < self._maxCount then
		for i, v in ipairs(msgList) do
			if v.msgType == GameEnum.ChatType.Lantern then
				local t = json.decode(v.content)
				local id = checknumber(t.tpId)
				local cfg = ChatConfig.instance:getSystemMsgT(id)
				local content = ""

				if cfg then
					content = StringUtil.parseJsonParams(cfg.template, t.params)

					local sortParam = {}

					sortParam.zoneId = t.params.zoneId
					sortParam.roomName = t.params.roomName

					self:_addToQueue(v.msgId, content, nil, EnumShow.Trigger, sortParam)
					FestiveFlowerController.instance:tryToPlayMainAnim(t.params)
				end
			end
		end
	end
end

function HorseLanternView:_handleMsgList(msgList)
	for k, v in pairs(msgList) do
		if v.readConfig then
			self:_onReadCfg(v)
		else
			self:_onBackStage(v)
		end
	end
end

function HorseLanternView:onEnter()
	self._showRect.sizeDelta = Vector2.New(self._width, self._height)

	local offset = 20

	self._btnRect.sizeDelta = Vector2.New(self._width + offset, self._btnRect.sizeDelta.y)

	self:_setTxtPos(self._initPosX)

	self._timeStamp = ServerTime.now()

	local msgList = HorseLanternAgent.instance:getMsgList()

	if msgList then
		self:_handleMsgList(msgList)
	end

	settimer(0, self._update, self, true)
end

function HorseLanternView:onExit()
	removetimer(self._update, self)
end

function HorseLanternView:_update()
	if self._timeStamp ~= ServerTime.now() then
		self._timeStamp = ServerTime.now()

		self:_addContentToWaitShowArray()

		self._recordTime = self._recordTime + 1

		if self._recordTime > self._targetDuration then
			self._recordTime = 0

			self:_shrinkTriggerArray()
		end
	end

	self:_moveLanternContent()
end

function HorseLanternView:_addToQueue(id, content, linkType, enumType, sortParam)
	linkType = linkType or -1

	local item = {
		id = id,
		linkType = linkType,
		content = content
	}

	if enumType == EnumShow.BackStage then
		self._waitShowArray:PushBack(item)
	elseif enumType == EnumShow.CfgType then
		self._cfgWaitShowArray:PushBack(item)
	else
		self:_addTriggerWaitShowArray(item, sortParam)
	end
end

function HorseLanternView:_addTriggerWaitShowArray(item, sortParam)
	local isSameZone = sortParam.zoneId == RoleModel.instance:getZoneId()
	local isSameScene = SceneFacade.instance:isInThisSceneByName(sortParam.roomName)

	item.sortIndex = isSameZone and isSameScene and 1 or isSameZone and not isSameScene and 2 or 3

	self._triggerWaitShowArray:PushBack(item)
end

function HorseLanternView:_shrinkTriggerArray()
	if self._triggerWaitShowArray:GetSize() > self._remainCount then
		local tempList = {}

		for i = 1, self._remainCount do
			table.insert(tempList, self._triggerWaitShowArray:PopBack())
		end

		self._triggerWaitShowArray:Clear()

		for i, v in ipairs(tempList) do
			self._triggerWaitShowArray:PushFront(v)
		end
	end

	self._triggerWaitShowArray:LowerSort("sortIndex")
end

function HorseLanternView:_addContentToWaitShowArray()
	for k, v in pairs(self._mulMsgList) do
		if self:_isShowOnce(v.duration) then
			self:_handleOnceMsg(k, v)
		else
			self:_handleMulMsg(k, v)
		end
	end

	self:_clearNilElement()
end

function HorseLanternView:_handleOnceMsg(k, v)
	if self._timeStamp >= v.startTime then
		self:_addToQueue(v.id, v.content, v.linkType, v.enumType)

		self._mulMsgList[k] = nil
	end
end

function HorseLanternView:_handleMulMsg(k, v)
	if self._timeStamp >= v.startTime and self._timeStamp <= v.endTime then
		if v.lastTime == v.startTime and v.isFirst then
			v.isFirst = false
			v.lastTime = self._timeStamp

			self:_addToQueue(v.id, v.content, v.linkType, v.enumType)
		else
			local curInternal = self._timeStamp - v.lastTime

			if curInternal >= v.internal then
				self:_addToQueue(v.id, v.content, v.linkType, v.enumType)

				v.lastTime = self._timeStamp
			end
		end
	elseif self._timeStamp > v.endTime then
		self:_delWaitShowQueueMsg(v.id, v.enumType)

		self._mulMsgList[k] = nil
	end
end

function HorseLanternView:_delWaitShowQueueMsg(msgId, enumType)
	local curArray = self._waitShowArray

	curArray = enumType == EnumShow.BackStage and self._waitShowArray or enumType == EnumShow.CfgType and self._cfgWaitShowArray or self._triggerWaitShowArray

	if curArray then
		local removeIndexs = {}

		curArray:ForEach(function(item, index)
			if msgId == item.id then
				table.insert(removeIndexs, index)
			end
		end)

		for i = 1, #removeIndexs do
			curArray:Erase(removeIndexs[i] - 1)
		end
	end
end

function HorseLanternView:_clearNilElement()
	local count = #self._mulMsgList

	if count == 0 then
		return
	end

	local m = 0

	for i = count, 1 do
		if self._mulMsgList[i] == nil then
			table.remove(self._mulMsgList, i)

			m = m + 1
		end
	end
end

function HorseLanternView:_isHideHorseLantern()
	return GlobalModel.instance:isUIShowing() and not ViewMgr.instance:isOpen(ViewName.PetDisplay) and not ViewMgr.instance:isOpen(ViewName.ItemGet) and ViewMgr.instance:isOpen(ViewName.MainUI) or true
end

function HorseLanternView:_moveLanternContent()
	if self:_isHideHorseLantern() and self._root.gameObject.activeSelf then
		self._root.gameObject:SetActive(false)
	end

	if self._curState == self.EnumState.PauseIdle then
		self._curState = self.EnumState.Idle
	elseif self._curState == self.EnumState.PauseMove then
		if not self._root.gameObject.activeSelf then
			self._root.gameObject:SetActive(true)
		end

		self._curState = self.EnumState.Move
		self._pauseTotalTime = self._pauseTotalTime + (Time.time - self._pauseStartTime)
	end

	if self._curState == self.EnumState.Idle then
		if not self:_isHaveAnyContent() then
			if self._root.gameObject.activeSelf then
				self._root.gameObject:SetActive(false)
			end

			return
		end

		if not self._root.gameObject.activeSelf and not self:_isHideHorseLantern() then
			self._root.gameObject:SetActive(true)
		end

		self._curQueue = self:_getOneContent()
		self._txtContent.text = self._curQueue.content

		self:_setTxtPos(self._initPosX)

		self._moveDistance = self._width + self._txtContent.preferredWidth
		self._curEndPosX = self._initPosX - self._moveDistance
		self._curPosX = self._initPosX
		self._curState = self.EnumState.Move
		self._startTime = Time.time
		self._totalTime = self._moveDistance / self._speed
		self._pauseStartTime = 0
		self._pauseTotalTime = 0
	elseif self._curState == self.EnumState.Move then
		if self._totalTime <= 0 then
			printError("总时间竟然小于等于0")
		end

		self._curPosX = Mathf.Lerp(self._initPosX, self._curEndPosX, (Time.time - self._startTime - self._pauseTotalTime) / self._totalTime)

		if self._curPosX <= self._curEndPosX then
			self._curState = self.EnumState.Idle
		else
			self:_setTxtPos(self._curPosX)
		end

		if not self._root.gameObject.activeSelf and not self:_isHideHorseLantern() then
			self._root.gameObject:SetActive(true)
		end
	end
end

function HorseLanternView:_isHaveAnyContent()
	return self._waitShowArray:GetSize() > 0 or self._cfgWaitShowArray:GetSize() > 0 or self._triggerWaitShowArray:GetSize() > 0
end

function HorseLanternView:_getOneContent()
	if self._waitShowArray:GetSize() > 0 then
		return self._waitShowArray:PopFront()
	elseif self._cfgWaitShowArray:GetSize() > 0 then
		return self._cfgWaitShowArray:PopFront()
	elseif self._triggerWaitShowArray:GetSize() > 0 then
		return self._triggerWaitShowArray:PopFront()
	end

	return {
		content = "！！！"
	}
end

function HorseLanternView:_setTxtPos(posX)
	Framework.TransformUtil.SetAnchoredPos(self._txtContentTrans, posX, 0)
end

function HorseLanternView:_isExistId(id)
	for k, v in pairs(self._mulMsgList) do
		if v and v.id == id then
			return true
		end
	end

	return false
end

function HorseLanternView:_onReadCfg(msg)
	if self:_isExistId(msg.msgId) then
		return
	end

	local id = msg.templateId
	local cfg = HorseLanternConfig.instance:getCfgById(id)

	if cfg then
		local sec = msg.startTime / 1000

		self:_addToMulMsgList(EnumShow.CfgType, msg.msgId, sec, sec + cfg.duration, cfg.frequency, cfg.duration, cfg.content, cfg.linkType)
	else
		printError("配置不存在", id)
	end
end

function HorseLanternView:_onBackStage(msg)
	if msg.extParam then
		if self:_isExistId(msg.msgId) then
			return
		end

		local sec = msg.startTime / 1000

		self:_addToMulMsgList(EnumShow.BackStage, msg.msgId, sec, sec + msg.extParam.duration, msg.extParam.frequency, msg.extParam.duration, msg.extParam.content)
	end
end

function HorseLanternView:_isShowOnce(duration)
	return duration == 0
end

function HorseLanternView:_addToMulMsgList(enumType, id, startTime, endTime, frequency, duration, content, linkType)
	local num = checknumber(endTime)

	if num < self._timeStamp and duration > 0 then
		return
	end

	if self._timeStamp > num + 10 and duration == 0 then
		return
	end

	if self:_isExistId(id) then
		return
	end

	local param = {}

	param.id = id
	param.startTime = checknumber(startTime)
	param.endTime = checknumber(endTime)
	param.internal = frequency
	param.duration = duration
	param.content = content
	param.lastTime = param.startTime
	param.isFirst = true
	param.linkType = linkType or -1
	param.enumType = enumType

	table.insert(self._mulMsgList, param)
end

function HorseLanternView:_addToCfgList()
	return
end

return HorseLanternView
