-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingScheduleTimeItemView.lua

module("logic.extensions.livingfacilities.view.LivingScheduleTimeItemView", package.seeall)

local M = class("LivingScheduleTimeItemView")
local kMaxNode = 24
local curFrameColor = parsecolor("#FFFA00")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()

	self._minuteTimer = SchedulerCtrl.New(self._refreshPerMinute, self)
	self._showTimeIdx = false
	self._showCurShedule = false
	self._scheduleFrameData = {}
end

function M:_buildUI()
	self._nodeGo = self._registry:findUIElement("schedule_time_item_1058812629")
	self._nodeList = {}
	self._pointerEventHandlerList = {}
	self._arrayTimeIdxTxt = {}

	for i = 1, kMaxNode do
		local node = goutil.findChild(self._nodeGo, string.format("node%d", i))
		local pointerEventHandler = PointerEventHandler.Get(node)

		pointerEventHandler:AddHandler(function(e, eventType, localX, localY)
			self:_onPointerEvent(eventType, localX, localY, i)
		end, self)
		table.insert(self._nodeList, node)
		table.insert(self._pointerEventHandlerList, pointerEventHandler)

		local timeTxt = goutil.findChildTextComponent(self._mainGo, string.format("timeList/txtTime%s", i))

		table.insert(self._arrayTimeIdxTxt, timeTxt)
	end

	local nodeGO = self._nodeList[1]

	self._nodeWidth = RectTransformUtils.GetWidth(nodeGO.transform)
	self._headPathWayItem = self._registry:findUIElement("schedule_time_item_-972420688")
	self._btnAdjust = Astral.ButtonAdapter.Get(self._registry:findUIElement("schedule_time_item_1226094445"))
	self._headRootGo = self._registry:findUIElement("schedule_time_item_1179016233")
	self._typeList = {}
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	return
end

function M:onEnter()
	self:_bindEvents()
	self:_setEvent(true)
	self._minuteTimer:restart(60, true)
	self:_refreshTimeIdx()
end

function M:onExit()
	self:_setEvent(false)
	self:_unbindEvents()

	self._modifyCallback = nil
	self._modifyTarget = nil

	self._minuteTimer:stop()
end

function M:OnDestroy()
	for i, pointerEventHandler in ipairs(self._pointerEventHandlerList or {}) do
		pointerEventHandler:RemoveHandler()
	end

	self._btnAdjust:RemoveClickListener()
	self:_destroyUI()

	self._modifyCallback = nil
	self._modifyTarget = nil

	self._minuteTimer:clear()

	self._minuteTimer = nil
	self._scheduleFrameData = nil
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:setCanEdit(status)
	self._canEdit = status
end

function M:setScheduleModifyCallback(callback, target)
	self._modifyCallback = callback
	self._modifyTarget = target
end

function M:_onPointerEvent(eventType, localX, localY, index)
	if not self._canEdit then
		return
	end

	if eventType == PointerEventType.ENTER then
		if self._beginDrag then
			self:_triggerScheduleByIndex(self._beginIndex, index)
		end
	elseif eventType == PointerEventType.DOWN then
		self._beginDrag = true
		self._beginIndex = index

		self:_triggerScheduleByIndex(index)
	elseif eventType == PointerEventType.UP then
		self._beginDrag = false
	end
end

function M:_triggerScheduleByIndex(beginIndex, index)
	if beginIndex and index then
		if beginIndex <= index then
			for i = beginIndex, index do
				self:_modifyScheduleType(i, self._scheduleType)
			end
		else
			for i = beginIndex, index, -1 do
				self:_modifyScheduleType(i, self._scheduleType)
			end
		end
	elseif beginIndex then
		self:_modifyScheduleType(beginIndex, self._scheduleType)
	end

	self:_refreshScheduleView()
end

function M:_modifyScheduleType(index, newType)
	local oldType = self._scheduleList[index]

	if table.indexof(self._typeList, oldType) then
		return false
	end

	self._scheduleList[index] = newType

	if self._modifyCallback then
		self._modifyCallback(self._modifyTarget, self._scheduleList)
	end

	return true
end

function M:setScheduleType(type)
	self._scheduleType = type
end

function M:setUnClickTypeList(typeList)
	self._typeList = typeList
end

function M:_getIsUnclickType(type)
	if table.indexof(self._typeList, type) then
		return true
	end

	return false
end

function M:_refreshScheduleView()
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_SCHEDULE_REFRESH, self._scheduleList)
	goutil.clearChildren(self._headRootGo)
	table.clear(self._scheduleFrameData)

	local count = 0
	local firstType = false
	local itemGo = false

	for i = 1, kMaxNode do
		local type = self._scheduleList[i]

		if count == 0 and type then
			firstType = type
			count = count + 1
			itemGo = goutil.clone(self._headPathWayItem)

			goutil.addChildToParent(itemGo, self._headRootGo)

			local imgType = goutil.findChildImageComponent(itemGo, "imgWorkType")

			IconLoader.setSprite(imgType, IconType.DynSpriteAtlas_Room, HouseEnum.WorkStatus2SignRes1[type])
			goutil.setActive(itemGo, true)

			local posX, posY, posZ = Astral.TransformUtil.GetLocalPos(self._nodeList[i].transform, 0, 0, 0)

			Astral.TransformUtil.SetLocalPos(itemGo.transform, posX, posY, posZ)
		elseif type then
			if type == firstType and i ~= 13 then
				count = count + 1
			else
				local imgNode = goutil.findChild(itemGo, "imgNode")
				local kuang = goutil.findChild(itemGo, "imgKuang")

				if self:_getIsUnclickType(firstType) then
					goutil.setActive(imgNode, true)
					goutil.setActive(kuang, false)
					goutil.setWidth(imgNode.transform, count * self._nodeWidth)
				else
					goutil.setActive(imgNode, false)
					goutil.setActive(kuang, true)
					goutil.setWidth(kuang.transform, count * self._nodeWidth)
					self:_setSchedule(kuang, i, count)
				end

				count = 0
				firstType = type
				count = count + 1
				itemGo = goutil.clone(self._headPathWayItem)

				goutil.addChildToParent(itemGo, self._headRootGo)

				local imgType = goutil.findChildImageComponent(itemGo, "imgWorkType")

				IconLoader.setSprite(imgType, IconType.DynSpriteAtlas_Room, HouseEnum.WorkStatus2SignRes1[type])

				local imgColor = self:_getIsUnclickType(type) and "#0A1722" or "#E4E7EA"

				imgType.color = parsecolor(imgColor)

				goutil.setActive(itemGo, true)

				local posX, posY, posZ = Astral.TransformUtil.GetLocalPos(self._nodeList[i].transform, 0, 0, 0)

				Astral.TransformUtil.SetLocalPos(itemGo.transform, posX, posY, posZ)
			end

			if i == 24 then
				local imgNode = goutil.findChild(itemGo, "imgNode")
				local kuang = goutil.findChild(itemGo, "imgKuang")

				if self:_getIsUnclickType(type) then
					goutil.setActive(imgNode, true)
					goutil.setActive(kuang, false)
					goutil.setWidth(imgNode.transform, count * self._nodeWidth)
				else
					goutil.setActive(imgNode, false)
					goutil.setActive(kuang, true)
					goutil.setWidth(kuang.transform, count * self._nodeWidth)
					self:_setSchedule(kuang, i, count)
				end

				count = 0
			end
		elseif count ~= 0 then
			local imgNode = goutil.findChild(itemGo, "imgNode")
			local kuang = goutil.findChild(itemGo, "imgKuang")

			if self:_getIsUnclickType(firstType) then
				goutil.setActive(imgNode, true)
				goutil.setActive(kuang, false)
				goutil.setWidth(imgNode.transform, count * self._nodeWidth)
			else
				goutil.setActive(imgNode, false)
				goutil.setActive(kuang, true)
				goutil.setWidth(kuang.transform, count * self._nodeWidth)
				self:_setSchedule(kuang, i, count)
			end

			count = 0
		end
	end
end

function M:_setSchedule(frameGo, hour, count)
	if self._showCurShedule then
		self._scheduleFrameData[hour] = {
			count = count,
			frameGo = frameGo
		}

		local img = frameGo:GetComponent(goutil.Type_UIImage)
		local curHour = ServerTime.nowDateServerLook().hour + 1

		if curHour >= hour - count and curHour < hour then
			img.color = curFrameColor
		end
	end
end

function M:setScheduleList(scheduleList)
	self._scheduleList = {}

	if scheduleList then
		for _, schedule in ipairs(scheduleList) do
			table.insert(self._scheduleList, schedule)
		end
	end

	self:_refreshScheduleView()
end

function M:getScheduleList()
	return self._scheduleList or {}
end

function M:needShowTimeIdx(show)
	self._showTimeIdx = show
end

function M:showCurShedule(show)
	self._showCurShedule = show
end

function M:_refreshPerMinute()
	self:_refreshTimeIdx()
	self:_refreshShedule()
end

function M:_refreshTimeIdx()
	local hour = ServerTime.nowDateServerLook().hour

	for idx, txt in ipairs(self._arrayTimeIdxTxt) do
		local colorStr = self._showTimeIdx and hour + 1 == idx and "#FFFA00" or "#C2C2C2"

		txt.color = parsecolor(colorStr)
	end
end

function M:_refreshShedule()
	if self._showCurShedule then
		local curHour = ServerTime.nowDateServerLook().hour + 1

		for hour, frameItemData in pairs(self._scheduleFrameData) do
			local img = frameItemData.frameGo:GetComponent(goutil.Type_UIImage)

			if curHour >= hour - frameItemData.count and curHour < hour then
				img.color = curFrameColor
			else
				img.color = Color.white
			end
		end
	end
end

function M:_destroyUI()
	self._nodeGo = nil
	self._nodeList = nil
	self._pointerEventHandlerList = nil
	self._headPathWayItem = nil
	self._btnAdjust = nil
	self._canEdit = nil
	self._scheduleList = nil
	self._scheduleList = nil
end

return M
