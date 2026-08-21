-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseScheduleItem.lua

module("logic.extensions.houseworker.view.HouseScheduleItem", package.seeall)

local M = class("HouseScheduleItem")
local kMaxNode = 24

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()

	self._timeIdxTimer = SchedulerCtrl.New(self._refreshTimeIdx, self)
	self._showTimeIdx = false
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

	local imgWorkType = goutil.findChildImageComponent(self._headPathWayItem, "imgWorkType")

	imgWorkType.color = Astral.ColorUtil.ParseColor("#FFFFFF")

	local imgWorkNode = goutil.findChildImageComponent(self._headPathWayItem, "imgNode")

	imgWorkNode.color = Astral.ColorUtil.ParseColor("#FFFFFF")
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
	self._timeIdxTimer:restart(60, true)
	self:_refreshTimeIdx()
end

function M:onExit()
	self:_setEvent(false)
	self:_unbindEvents()
	self._timeIdxTimer:stop()
end

function M:OnDestroy()
	if not self._pointerEventHandlerList then
		return
	end

	for i, pointerEventHandler in ipairs(self._pointerEventHandlerList) do
		pointerEventHandler:RemoveHandler()
	end

	self._btnAdjust:RemoveClickListener()
	self:_destroyUI()
	self._timeIdxTimer:clear()

	self._timeIdxTimer = nil
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:setCanEdit(status)
	self._canEdit = status
end

function M:_onPointerEvent(eventType, localX, localY, index)
	if not self._canEdit then
		return
	end

	if eventType == PointerEventType.DRAG and self._beginDrag then
		self._isClick = false
	end

	if eventType == PointerEventType.ENTER then
		if self._beginDrag and not self._isDelete then
			self:_triggerScheduleByIndex(self._beginIndex, index)
		end
	elseif eventType == PointerEventType.DOWN then
		self._isClick = true
		self._beginDrag = true
		self._beginIndex = index
	elseif eventType == PointerEventType.UP then
		if self._isClick then
			if self._scheduleType == self._scheduleList[index] then
				self._isDelete = true

				self:_triggerScheduleByIndex(index)
			else
				self:_triggerScheduleByIndex(index)
			end
		end

		self._beginDrag = false
		self._isDelete = false
		self._isClick = false
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
		if self._isDelete then
			self:_modifyScheduleType(beginIndex, 0)
		else
			self:_modifyScheduleType(beginIndex, self._scheduleType)
		end
	end

	self:_refreshScheduleView()
end

function M:_modifyScheduleType(index, newType)
	local oldType = self._scheduleList[index]

	if table.indexof(self._typeList, oldType) then
		return false
	end

	local tempSchedule = {}

	for i, v in ipairs(self._scheduleList) do
		tempSchedule[i] = v
	end

	tempSchedule[index] = newType

	local workTimeCountList = {
		0,
		0,
		0
	}

	for i, v in ipairs(tempSchedule) do
		if v > 0 then
			workTimeCountList[v] = workTimeCountList[v] + 1
		end
	end

	for i, v in ipairs(workTimeCountList) do
		if v > HouseConfig.instance:getHouseConst("WorkMaxTime").numValue then
			local heroId = self._heroList[i]

			if heroId > 0 then
				local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

				FloatWordMgr.instance:show(langF("tip_schedule_max_time", heroMO:getName()))
			else
				FloatWordMgr.instance:show(i .. lang("tip_site_out_max_time"))
			end

			return false
		end
	end

	if self._scheduleChangeCallBackFunc then
		self._scheduleChangeCallBackFunc(self._scheduleChangeCallBackHandle, workTimeCountList)
	end

	self._scheduleList[index] = newType

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
	goutil.clearChildren(self._headRootGo)

	local count = 0
	local firstType = false
	local itemGo = false

	for i = 1, kMaxNode do
		local type = self._scheduleList[i]

		if count == 0 and type ~= 0 then
			firstType = type
			count = count + 1
			itemGo = goutil.clone(self._headPathWayItem)

			goutil.addChildToParent(itemGo, self._headRootGo)

			local imgType = goutil.findChildImageComponent(itemGo, "imgWorkType")

			self:_setHeadIcon(imgType, type)
			goutil.setActive(itemGo, true)

			local posX, posY, posZ = Astral.TransformUtil.GetLocalPos(self._nodeList[i].transform, 0, 0, 0)

			Astral.TransformUtil.SetLocalPos(itemGo.transform, posX, posY, posZ)
		elseif type ~= 0 then
			if type == firstType and i ~= 13 then
				count = count + 1
			else
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
				end

				count = 0
				firstType = type
				count = count + 1
				itemGo = goutil.clone(self._headPathWayItem)

				goutil.addChildToParent(itemGo, self._headRootGo)

				local imgType = goutil.findChildImageComponent(itemGo, "imgWorkType")

				self:_setHeadIcon(imgType, type)
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
				end

				count = 0
			end
		elseif count ~= 0 then
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
			end

			count = 0
		end
	end
end

function M:_setHeadIcon(headIcon, index)
	local heroId = self._heroList[index]

	if heroId > 0 then
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
		local characterCO = heroMO:getCharacterCo()
		local modelCO = heroMO:getModelCo()

		IconLoader.setSprite(headIcon, IconType.HeadIcon, modelCO.headIconName)
	elseif index == 1 then
		IconLoader.setSprite(headIcon, IconType.DynSpriteAtlas_Room, "worktype_one")
	elseif index == 2 then
		IconLoader.setSprite(headIcon, IconType.DynSpriteAtlas_Room, "worktype_two")
	elseif index == 3 then
		IconLoader.setSprite(headIcon, IconType.DynSpriteAtlas_Room, "worktype_three")
	end
end

function M:getSchedule()
	return self._scheduleList
end

function M:setScheduleChangeCallBack(func, handler)
	self._scheduleChangeCallBackFunc = func
	self._scheduleChangeCallBackHandle = handler
end

function M:setScheduleList(scheduleList, heroList)
	self._heroList = heroList

	self:updateScheduleList(scheduleList)
end

function M:updateScheduleList(scheduleList)
	self._scheduleList = scheduleList or {}

	self:_refreshScheduleView()

	local workTimeCountList = {
		0,
		0,
		0
	}

	for i, v in ipairs(self._scheduleList) do
		if v > 0 then
			workTimeCountList[v] = workTimeCountList[v] + 1
		end
	end

	if self._scheduleChangeCallBackFunc then
		self._scheduleChangeCallBackFunc(self._scheduleChangeCallBackHandle, workTimeCountList)
	end
end

function M:needShowTimeIdx(show)
	self._showTimeIdx = show
end

function M:_refreshTimeIdx()
	local hour = ServerTime.nowDateServerLook().hour

	for idx, txt in ipairs(self._arrayTimeIdxTxt) do
		local colorStr = self._showTimeIdx and hour + 1 == idx and "#FFFA00" or "#C2C2C2"

		txt.color = parsecolor(colorStr)
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
