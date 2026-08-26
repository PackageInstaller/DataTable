-- chunkname: @modules/logic/commandstation/view/CommandStationMapLeftVersionView.lua

module("modules.logic.commandstation.view.CommandStationMapLeftVersionView", package.seeall)

local CommandStationMapLeftVersionView = class("CommandStationMapLeftVersionView", BaseView)

function CommandStationMapLeftVersionView:onInitView()
	self._gonameViewport = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport")
	self._gonameContent = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport/#go_leftContent")
	self._gonameItem = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport/#go_leftContent/#go_versionItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapLeftVersionView:_editableInitView()
	gohelper.setActive(self._gonameItem, false)

	self._itemList = self:getUserDataTb_()
	self._recycleList = self:getUserDataTb_()
	self._versionConfigList = CommandStationMapVersionView.getVersionConfigList()
	self._versionConfigLen = #self._versionConfigList
	self._itemHeight = 60
	self._itemSpace = 0
	self._itemHeightWithSpace = self._itemHeight + self._itemSpace
	self._halfItemHeight = self._itemHeight / 2
	self._startIndex = -1
	self._endIndex = 3
	self._noScaleOffsetIndex = 2
end

function CommandStationMapLeftVersionView:_checkBoundry()
	local contentY = recthelper.getAnchorY(self._gonameContent.transform)
	local offsetIndex = Mathf.Round(contentY / self._itemHeightWithSpace)
	local minIndex = self._startIndex + offsetIndex
	local maxIndex = self._endIndex + offsetIndex
	local noScaleIndex = minIndex + self._noScaleOffsetIndex
	local noScalePosY = -180

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
		local posY = recthelper.getAnchorY(item.transform) + contentY + self._halfItemHeight
		local deltaY = math.abs(posY - noScalePosY)
		local offsetScale = deltaY * 0.1 / self._itemHeight

		transformhelper.setLocalScale(item.transform, 1 - offsetScale, 1 - offsetScale, 1)
	end

	return noScaleIndex
end

function CommandStationMapLeftVersionView:_getItem(index)
	local item = table.remove(self._recycleList)

	if not item then
		local go = gohelper.cloneInPlace(self._gonameItem)
		local txt = gohelper.findChildText(go, "Text")

		item = {
			transform = go.transform,
			go = go,
			txt = txt
		}
	end

	item.index = index

	local dataIndex = math.abs(index % #self._versionConfigList)
	local data = self._versionConfigList[dataIndex + 1]

	item.txt.text = data.id

	recthelper.setAnchorY(item.transform, -index * self._itemHeightWithSpace - self._halfItemHeight)
	gohelper.setActive(item.go, true)

	item.go.name = index

	return item
end

function CommandStationMapLeftVersionView:onOpen()
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

	self:_checkBoundry()
end

function CommandStationMapLeftVersionView:setContentPosY(deltaIndex, deltaRatio)
	local posY = self._focusVersionPosY + (deltaIndex + deltaRatio) * self._itemHeightWithSpace

	recthelper.setAnchorY(self._gonameContent.transform, posY)

	local absValue = math.abs(deltaRatio)

	if self._lastRation and self._lastRation < 0.3 and absValue >= 0.3 then
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_common_click)
	end

	self._lastRation = absValue

	self:_checkBoundry()
end

function CommandStationMapLeftVersionView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return CommandStationMapLeftVersionView
