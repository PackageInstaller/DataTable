-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartLayerPage.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerPage", package.seeall)

local WeekWalk_2HeartLayerPage = class("WeekWalk_2HeartLayerPage", ListScrollCellExtend)

function WeekWalk_2HeartLayerPage:onInitView()
	self._simagebgimg = gohelper.findChildSingleImage(self.viewGO, "#simage_bgimg")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content")
	self._gopos = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_pos")
	self._gopos1 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos1")
	self._gopos2 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos2")
	self._gopos3 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos3")
	self._gopos4 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos4")
	self._goline = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_line")
	self._golight1 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_line/line1/#go_light1")
	self._golight2 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_line/line2/#go_light2")
	self._golight3 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_line/line3/#go_light3")
	self._gotopblock = gohelper.findChild(self.viewGO, "#go_topblock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2HeartLayerPage:addEvents()
	return
end

function WeekWalk_2HeartLayerPage:removeEvents()
	return
end

function WeekWalk_2HeartLayerPage:ctor(view)
	self._layerView = view
end

function WeekWalk_2HeartLayerPage:_editableInitView()
	self._lineCtrl = self._goline:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self._lineValueVec4 = Vector4.New(1, 1, 1, 0)

	self:_initItems()
end

function WeekWalk_2HeartLayerPage:_initItems()
	local unlockPageItem

	self._itemList = self:getUserDataTb_()

	for i = 1, WeekWalk_2Enum.MaxLayer do
		local pos = self["_gopos" .. i]
		local go = self._layerView:getResInst(self._layerView.viewContainer._viewSetting.otherRes[2], pos)
		local pageItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, WeekWalk_2HeartLayerPageItem)

		table.insert(self._itemList, pageItem)
		pageItem:onUpdateMO({
			index = i,
			layerView = self._layerView
		})

		local layerInfo = WeekWalk_2Model.instance:getLayerInfoByLayerIndex(i)

		if layerInfo and layerInfo.unlock then
			unlockPageItem = pageItem

			self:_setLineValue(WeekWalk_2Enum.LineValue[i])
		end
	end

	self:_checkUnlockAnim(unlockPageItem)
end

function WeekWalk_2HeartLayerPage:_setLineValue(value)
	self._lineValueVec4.z = value
	self._lineCtrl.vector_01 = self._lineValueVec4

	self._lineCtrl:SetProps()
end

function WeekWalk_2HeartLayerPage:_checkUnlockAnim(item)
	if not item then
		return
	end

	local layerId = item:getLayerId()

	if not layerId then
		return
	end

	if WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.UnlockEpisode, layerId) then
		return
	end

	WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.UnlockEpisode, layerId)

	self._unlockPageItem = item

	local index = item:getIndex()

	self._startValue = WeekWalk_2Enum.LineValue[index - 1]
	self._endValue = WeekWalk_2Enum.LineValue[index]

	if not self._startValue or not self._endValue then
		return
	end

	self._unlockPageItem:setFakeUnlock(false)
	self:_setLineValue(self._startValue)
	TaskDispatcher.cancelTask(self._delayStartUnlockAnim, self)
	TaskDispatcher.runDelay(self._delayStartUnlockAnim, self, 0.6)
end

function WeekWalk_2HeartLayerPage:_delayStartUnlockAnim()
	self:_startUnlockAnim()
end

function WeekWalk_2HeartLayerPage:_startUnlockAnim()
	local time = 0.3

	self._dotweenId = ZProj.TweenHelper.DOTweenFloat(self._startValue, self._endValue, time, self._everyFrame, self._animFinish, self)
end

function WeekWalk_2HeartLayerPage:_everyFrame(value)
	self:_setLineValue(value)
end

function WeekWalk_2HeartLayerPage:_animFinish()
	self:_setLineValue(self._endValue)
	self._unlockPageItem:setFakeUnlock(true)
	self._unlockPageItem:playUnlockAnim()
end

function WeekWalk_2HeartLayerPage:_editableAddEvents()
	return
end

function WeekWalk_2HeartLayerPage:_editableRemoveEvents()
	return
end

function WeekWalk_2HeartLayerPage:onUpdateMO(mo)
	return
end

function WeekWalk_2HeartLayerPage:onSelect(isSelect)
	return
end

function WeekWalk_2HeartLayerPage:onDestroyView()
	TaskDispatcher.cancelTask(self._delayStartUnlockAnim, self)

	if self._dotweenId then
		ZProj.TweenHelper.KillById(self._dotweenId)

		self._dotweenId = nil
	end
end

return WeekWalk_2HeartLayerPage
