-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologySelectView.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologySelectView", package.seeall)

local VersionActivity1_3AstrologySelectView = class("VersionActivity1_3AstrologySelectView", BaseView)

function VersionActivity1_3AstrologySelectView:onInitView()
	self._simageDec1 = gohelper.findChildSingleImage(self.viewGO, "SelectStar/#simage_Dec1")
	self._simageDec2 = gohelper.findChildSingleImage(self.viewGO, "SelectStar/#simage_Dec2")
	self._scrollPlanetList = gohelper.findChildScrollRect(self.viewGO, "SelectStar/#scroll_PlanetList")
	self._gocontent = gohelper.findChild(self.viewGO, "SelectStar/#scroll_PlanetList/Viewport/#go_content")
	self._txtStarName = gohelper.findChildText(self.viewGO, "SelectStar/#txt_StarName")
	self._txtAdjustTimes = gohelper.findChildText(self.viewGO, "SelectStar/AdjustTimes/image_AdjustTimesBG/#txt_AdjustTimes")
	self._txtCurrentAngle = gohelper.findChildText(self.viewGO, "CurrentAngle/image_CurrentAngleBG/#txt_CurrentAngle")
	self._goBtns = gohelper.findChild(self.viewGO, "#go_Btns")
	self._goToGet = gohelper.findChild(self.viewGO, "#go_Btns/#go_ToGet")
	self._btnToGet = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Btns/#go_ToGet/#btn_ToGet")
	self._txtToGetTips = gohelper.findChildText(self.viewGO, "#go_Btns/#go_ToGet/#txt_ToGetTips")
	self._goConfirm = gohelper.findChild(self.viewGO, "#go_Btns/#go_Confirm")
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Btns/#go_Confirm/#btn_Confirm")
	self._txtConfirmTips = gohelper.findChildText(self.viewGO, "#go_Btns/#go_Confirm/#txt_ConfirmTips")
	self._goTips = gohelper.findChild(self.viewGO, "#go_Btns/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_Btns/#go_Tips/#txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3AstrologySelectView:addEvents()
	self._btnToGet:AddClickListener(self._btnToGetOnClick, self)
	self._btnConfirm:AddClickListener(self._btnConfirmOnClick, self)
end

function VersionActivity1_3AstrologySelectView:removeEvents()
	self._btnToGet:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function VersionActivity1_3AstrologySelectView:_btnToGetOnClick()
	JumpController.instance:jump(VersionActivity1_3DungeonEnum.JumpDaily)
end

function VersionActivity1_3AstrologySelectView:_btnConfirmOnClick()
	self.viewContainer:sendUpdateProgressRequest()
end

function VersionActivity1_3AstrologySelectView:_editableInitView()
	self._viewPortTrans = self._gocontent.transform.parent

	self:_addItems()
	self.addEventCb(self, VersionActivity1_3AstrologyController.instance, VersionActivity1_3AstrologyEvent.adjustPreviewAngle, self._adjustPreviewAngle, self)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onUpdateProgressReply, self._onUpdateProgressReply, self)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onGetHoroscopeReply, self._onGetHoroscopeReply, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._viewPortTrans.gameObject)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)
	self._drag:AddDragListener(self._onDrag, self)
end

function VersionActivity1_3AstrologySelectView:_onDragBeginHandler(param, pointerEventData)
	self._startDragPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._viewPortTrans)
	self._selectedIndex = tabletool.indexOf(self._planetMoList, self._selectedItem:getPlanetMo())
end

function VersionActivity1_3AstrologySelectView:_onDragEndHandler(param, pointerEventData)
	return
end

function VersionActivity1_3AstrologySelectView:_onDrag(param, pointerEventData)
	if not self._startDragPos then
		return
	end

	local endPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._viewPortTrans)
	local deltaPos = endPos - self._startDragPos
	local deltaIndex = math.floor(math.abs(deltaPos.x) / 120)

	if deltaPos.x > 0 then
		local targetIndex = self._selectedIndex + (-deltaIndex or deltaIndex)
		local targetMo = self._planetMoList[targetIndex]

		if targetMo then
			local planetItem = self._itemList[targetMo.id]

			self:setSelected(planetItem)
		end
	end
end

function VersionActivity1_3AstrologySelectView:_onGetHoroscopeReply()
	return
end

function VersionActivity1_3AstrologySelectView:_onUpdateProgressReply(param)
	if param and param.fromReset then
		self:_sortAndSelectFirst()
		self:_refresh()
	else
		local list = VersionActivity1_3AstrologyModel.instance:getStarReward()

		if not list then
			self:_refresh()

			return
		end

		TaskDispatcher.cancelTask(self._refresh, self)
		TaskDispatcher.runDelay(self._refresh, self, 2.5)
	end
end

function VersionActivity1_3AstrologySelectView:_refresh()
	self:updateItemNum()
	self:_updatePlanetItemInfo()
end

function VersionActivity1_3AstrologySelectView:_adjustPreviewAngle()
	self:_updatePlanetItemInfo()
end

function VersionActivity1_3AstrologySelectView:onOpen()
	return
end

function VersionActivity1_3AstrologySelectView:_sortItems()
	table.sort(self._planetMoList, VersionActivity1_3AstrologySelectView._sort)

	for i, v in ipairs(self._planetMoList) do
		local planetItem = self._itemList[v.id]

		gohelper.setAsLastSibling(planetItem.viewGO)
	end
end

function VersionActivity1_3AstrologySelectView._sort(a, b)
	local num1 = a.num > 0
	local num2 = b.num > 0

	if num1 and num2 then
		return a.id < b.id
	elseif num1 then
		return true
	elseif num2 then
		return false
	end

	return a.id < b.id
end

function VersionActivity1_3AstrologySelectView:_addItems()
	self._itemList = self:getUserDataTb_()
	self._planetMoList = {}

	local path = self.viewContainer:getSetting().otherRes[1]

	for id = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local itemGO = self:getResInst(path, self._gocontent)
		local planetItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, VersionActivity1_3AstrologyPlanetItem, {
			id,
			self
		})

		self._itemList[id] = planetItem

		table.insert(self._planetMoList, planetItem:getPlanetMo())
	end

	self:_sortAndSelectFirst()
end

function VersionActivity1_3AstrologySelectView:_sortAndSelectFirst()
	self:_sortItems()
	self:setSelected(self._itemList[self._planetMoList[1].id])
end

function VersionActivity1_3AstrologySelectView:setSelected(item)
	if self._selectedItem == item then
		return
	end

	self._selectedItem = item
	self._planetMo = self._selectedItem:getPlanetMo()
	self._txtStarName.text = self._planetMo:getItemName()

	for k, v in pairs(self._itemList) do
		v:setSelected(v == item)
	end

	ZProj.UGUIHelper.RebuildLayout(self._gocontent.transform)
	TaskDispatcher.cancelTask(self._focusItem, self)
	TaskDispatcher.runDelay(self._focusItem, self, 0)
	VersionActivity1_3AstrologyController.instance:dispatchEvent(VersionActivity1_3AstrologyEvent.selectPlanetItem, item)
	self:_updatePlanetItemInfo()
end

function VersionActivity1_3AstrologySelectView:_focusItem()
	local x = recthelper.getAnchorX(self._selectedItem.viewGO.transform) - 470
	local targetX = -x - 42

	self:_clearTween()

	self._contentTweenId = ZProj.TweenHelper.DOAnchorPosX(self._gocontent.transform, targetX, 0.2)
end

function VersionActivity1_3AstrologySelectView:_clearTween()
	if self._contentTweenId then
		ZProj.TweenHelper.KillById(self._contentTweenId)

		self._contentTweenId = nil
	end
end

function VersionActivity1_3AstrologySelectView:updateItemNum()
	for k, v in pairs(self._itemList) do
		v:updateNum()
	end
end

function VersionActivity1_3AstrologySelectView:_updatePlanetItemInfo()
	local totalNum = self._planetMo.num
	local remainNum = self._planetMo:getRemainNum()

	self:_updateNum(totalNum, remainNum)
	self:_updateAngle(self._planetMo.previewAngle)

	local num = Activity126Model.instance:getStarNum()
	local canAstrology = num >= 10
	local hasAdjust = VersionActivity1_3AstrologyModel.instance:hasAdjust()
	local needToGet = totalNum <= 0

	gohelper.setActive(self._goConfirm, false)
	gohelper.setActive(self._goTips, false)
	gohelper.setActive(self._goToGet, false)

	if canAstrology then
		if hasAdjust then
			gohelper.setActive(self._goConfirm, true)

			self._txtConfirmTips.text = luaLang("astrology_tip6")

			return
		end

		if needToGet then
			gohelper.setActive(self._goToGet, true)

			self._txtToGetTips.text = luaLang("astrology_tip4")

			return
		end

		gohelper.setActive(self._goTips, true)

		self._txtTips.text = luaLang("astrology_tip5")
	else
		if hasAdjust then
			gohelper.setActive(self._goConfirm, true)

			self._txtConfirmTips.text = luaLang("astrology_tip3")

			return
		end

		if needToGet then
			gohelper.setActive(self._goToGet, true)

			self._txtToGetTips.text = luaLang("astrology_tip1")

			return
		end

		gohelper.setActive(self._goTips, true)

		self._txtTips.text = luaLang("astrology_tip2")
	end
end

function VersionActivity1_3AstrologySelectView:_updateNum(totalNum, remainNum)
	self._txtAdjustTimes.text = totalNum > 0 and (totalNum ~= remainNum and string.format("%s%s<color=#b73850>-%s</color>", luaLang("adjustNum"), totalNum, totalNum - remainNum) or string.format("%s%s", luaLang("adjustNum"), totalNum)) or string.format("%s<color=#b73850>%s</color>", luaLang("adjustNum"), 0)
end

function VersionActivity1_3AstrologySelectView:_updateAngle(value)
	self._txtCurrentAngle.text = string.format("%s°", value % 360)
end

function VersionActivity1_3AstrologySelectView:getSelectedPlanetId()
	for id, v in pairs(self._itemList) do
		if v:isSelected() then
			return id
		end
	end
end

function VersionActivity1_3AstrologySelectView:onClose()
	return
end

function VersionActivity1_3AstrologySelectView:onDestroyView()
	TaskDispatcher.cancelTask(self._focusItem, self)
	self:_clearTween()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	TaskDispatcher.cancelTask(self._refresh, self)
end

return VersionActivity1_3AstrologySelectView
