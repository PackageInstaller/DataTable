-- chunkname: @modules/logic/commandstation/view/CommandStationMapVersionView.lua

module("modules.logic.commandstation.view.CommandStationMapVersionView", package.seeall)

local CommandStationMapVersionView = class("CommandStationMapVersionView", BaseView)

function CommandStationMapVersionView:onInitView()
	self._goversionname = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname")
	self._gonameViewport = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport")
	self._gonameContent = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport/#go_nameContent")
	self._gonameItem = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport/#go_nameContent/#go_nameItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapVersionView.getVersionConfigList()
	local list = {}

	for i, v in ipairs(lua_copost_version.configList) do
		local timeline = CommandStationMapModel.instance:getVersionTimeline(v.versionId)

		if timeline and #timeline > 0 then
			table.insert(list, v)
		end
	end

	return list
end

function CommandStationMapVersionView:_editableInitView()
	gohelper.setActive(self._gonameItem, false)

	self._itemList = self:getUserDataTb_()
	self._recycleList = self:getUserDataTb_()
	self._versionConfigList = CommandStationMapVersionView.getVersionConfigList()
	self._versionConfigLen = #self._versionConfigList
	self._itemHeight = 136
	self._itemSpace = -45
	self._itemHeightWithSpace = self._itemHeight + self._itemSpace
	self._halfItemHeight = self._itemHeight / 2
	self._startIndex = -1
	self._endIndex = 5
	self._noScaleOffsetIndex = 3

	self:_initDrag()
end

function CommandStationMapVersionView:_initDrag()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gonameViewport)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
end

function CommandStationMapVersionView:_onDragBegin(param, pointerEventData)
	self._beginDragPosY = pointerEventData.position.y
	self._beginPosY = recthelper.getAnchorY(self._gonameContent.transform)
end

function CommandStationMapVersionView:_onDragEnd(param, pointerEventData)
	if not self._beginPosY then
		return
	end

	if self._beginPosY == self._dragResultY then
		return
	end

	local isUp = self._beginPosY < self._dragResultY
	local nextFocusIndex = isUp and math.ceil(self._dragResultY / self._itemHeightWithSpace) or math.floor(self._dragResultY / self._itemHeightWithSpace)
	local nextFocusPosY = nextFocusIndex * self._itemHeightWithSpace

	self:_startTween(nextFocusPosY)
end

function CommandStationMapVersionView:_startTween(nextFocusPosY)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	local contentY = recthelper.getAnchorY(self._gonameContent.transform)

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(contentY, nextFocusPosY, 0.5, self._tweenFrame, self._tweenFinish, self)
end

function CommandStationMapVersionView:_tweenFrame(value)
	self:_setContentPosY(value)
end

function CommandStationMapVersionView:_onDrag(param, pointerEventData)
	if not self._beginPosY then
		return
	end

	local contentY = self._beginPosY

	self._dragResultY = contentY + (pointerEventData.position.y - self._beginDragPosY)

	self:_setContentPosY(self._dragResultY)
end

function CommandStationMapVersionView:_setContentPosY(posY)
	recthelper.setAnchorY(self._gonameContent.transform, posY)

	local noScaleIndex, noScaleRatio = self:_checkBoundry()

	self._curCenterIndex = noScaleIndex

	if self._leftVersionView then
		self._leftVersionView:setContentPosY(noScaleIndex - self._initFocusIndex, noScaleRatio)
	end
end

function CommandStationMapVersionView:_checkBoundry()
	local contentY = recthelper.getAnchorY(self._gonameContent.transform)
	local offsetIndex = Mathf.Round(contentY / self._itemHeightWithSpace)
	local minIndex = self._startIndex + offsetIndex
	local maxIndex = self._endIndex + offsetIndex
	local noScaleIndex = minIndex + self._noScaleOffsetIndex
	local noScaleRatio = 0
	local noScalePosY = -182
	local thirdOffsetY = 20
	local secondOffsetScaleByDeltaY = 0.1

	for k, v in pairs(self._itemList) do
		if minIndex > v.index or maxIndex < v.index then
			gohelper.setActive(v.go, false)

			self._itemList[k] = nil

			table.insert(self._recycleList, v)
		end
	end

	for i = minIndex, maxIndex do
		local item = self._itemList[i]

		if not item then
			item = self:_getItem(i)
			self._itemList[i] = item
		end

		local item = self._itemList[i]
		local posY = item.posY + contentY + self._halfItemHeight
		local deltaY = posY - noScalePosY
		local deltaIndex = math.abs(i - noScaleIndex)
		local scaleOffset = deltaIndex <= 1 and 1 or 1.5
		local alphaScaleOffset = deltaIndex <= 0 and 1 or 2
		local offsetScaleByDeltaY = math.abs(deltaY) * 0.1 / self._itemHeightWithSpace
		local offsetScale = offsetScaleByDeltaY * scaleOffset
		local offsetAlpha = offsetScaleByDeltaY * alphaScaleOffset

		if i == noScaleIndex then
			noScaleRatio = deltaY / self._itemHeightWithSpace
		end

		local scale = 1 - offsetScale

		transformhelper.setLocalScale(item.transform, scale, scale, 1)

		item.color.a = 1 - offsetAlpha
		item.txt.color = item.color

		if secondOffsetScaleByDeltaY <= offsetScaleByDeltaY then
			local dir = noScaleIndex <= i and 1 or -1

			recthelper.setAnchorY(item.transform, item.posY + (offsetScaleByDeltaY - secondOffsetScaleByDeltaY) * 10 * thirdOffsetY * dir)
		else
			recthelper.setAnchorY(item.transform, item.posY)
		end
	end

	return noScaleIndex, noScaleRatio
end

function CommandStationMapVersionView:_getItem(index)
	local item = table.remove(self._recycleList)

	if not item then
		local go = gohelper.cloneInPlace(self._gonameItem)
		local txt = gohelper.findChildText(go, "Text")
		local color = txt.color

		item = {
			transform = go.transform,
			go = go,
			txt = txt,
			color = color
		}

		local clickListener = SLFramework.UGUI.UIClickListener.Get(go)

		clickListener:AddClickListener(self._onVersionClick, self, item)

		item.clickListener = clickListener
	end

	item.index = index

	local dataIndex = math.abs(index % self._versionConfigLen)
	local data = self._versionConfigList[dataIndex + 1]

	item.txt.text = data.timeId
	item.versionId = data.versionId

	local posY = -index * self._itemHeightWithSpace - self._halfItemHeight

	recthelper.setAnchorY(item.transform, posY)

	item.posY = posY

	gohelper.setActive(item.go, true)

	item.go.name = index

	return item
end

function CommandStationMapVersionView:_onVersionClick(item)
	CommandStationMapModel.instance:setVersionId(item.versionId)
	CommandStationMapModel.instance:initTimeId()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.ChangeVersionId, item.versionId)
	self:_focusByItemIndex(item.index, true)
end

function CommandStationMapVersionView:_focusByItemIndex(index, tween)
	if index == self._curFocusIndex and index == self._curCenterIndex then
		return
	end

	self._curFocusIndex = index

	local posY = self._focusVersionPosY + (index - self._initFocusIndex) * self._itemHeightWithSpace

	if tween then
		self:_startTween(posY)
	else
		self:_setContentPosY(posY)
	end
end

function CommandStationMapVersionView:onOpen()
	self._leftVersionView = self.viewContainer:getLeftVersionView()

	local index = self._startIndex + self._noScaleOffsetIndex
	local dataIndex = math.abs(index % self._versionConfigLen)
	local data = self._versionConfigList[dataIndex + 1]
	local versionId = data.versionId
	local targetVersionId = CommandStationMapModel.instance:getVersionId()

	if targetVersionId ~= versionId then
		local targetIndex = CommandStationConfig.instance:getVersionIndex(targetVersionId, self._versionConfigList) - 1

		self._focusVersionPosY = (targetIndex - dataIndex) * self._itemHeightWithSpace

		recthelper.setAnchorY(self._gonameContent.transform, self._focusVersionPosY)
	else
		self._focusVersionPosY = 0

		recthelper.setAnchorY(self._gonameContent.transform, self._focusVersionPosY)
	end

	self._initFocusIndex = self:_checkBoundry()
	self._curFocusIndex = self._initFocusIndex

	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.HideVersionSelectView, self._onHideVersionSelectView, self)
end

function CommandStationMapVersionView:_onHideVersionSelectView()
	if not self._curCenterIndex then
		return
	end

	if self._curFocusIndex ~= self._curCenterIndex then
		local curFocusDataIndex = math.abs(self._curFocusIndex % self._versionConfigLen)
		local curCenterDataIndex = math.abs(self._curCenterIndex % self._versionConfigLen)

		if curFocusDataIndex == curCenterDataIndex then
			return
		end

		local index = self:_getNearSameIndex()

		if index then
			self:_focusByItemIndex(index, true)
		else
			self:_focusByItemIndex(self._curFocusIndex)
		end
	end
end

function CommandStationMapVersionView:_getNearSameIndex()
	local curFocusDataIndex = math.abs(self._curFocusIndex % self._versionConfigLen)

	if self._curFocusIndex < self._curCenterIndex then
		for i = 1, self._versionConfigLen do
			local index = self._curCenterIndex - i
			local findDataIndex = math.abs(index % self._versionConfigLen)

			if curFocusDataIndex == findDataIndex then
				return index
			end
		end
	else
		for i = 1, self._versionConfigLen do
			local index = self._curCenterIndex + i
			local findDataIndex = math.abs(index % self._versionConfigLen)

			if curFocusDataIndex == findDataIndex then
				return index
			end
		end
	end
end

function CommandStationMapVersionView:onClose()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	for i, v in pairs(self._itemList) do
		v.clickListener:RemoveClickListener()
	end

	for i, v in pairs(self._recycleList) do
		v.clickListener:RemoveClickListener()
	end
end

return CommandStationMapVersionView
