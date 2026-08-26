-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaRecordView.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordView", package.seeall)

local AiZiLaRecordView = class("AiZiLaRecordView", BaseView)

function AiZiLaRecordView:onInitView()
	self._goLeftTabContent = gohelper.findChild(self.viewGO, "scroll_Left/Viewport/#go_LeftTabContent")
	self._goLeftTabItem = gohelper.findChild(self.viewGO, "#go_LeftTabItem")
	self._goRecordItem = gohelper.findChild(self.viewGO, "#go_RecordItem")
	self._scrollRight = gohelper.findChildScrollRect(self.viewGO, "#scroll_Right")
	self._goRightItemContent = gohelper.findChild(self.viewGO, "#scroll_Right/Viewport/#go_RightItemContent")
	self._goArrow = gohelper.findChild(self.viewGO, "#go_Arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaRecordView:addEvents()
	return
end

function AiZiLaRecordView:removeEvents()
	return
end

function AiZiLaRecordView:_editableInitView()
	gohelper.setActive(self._goLeftTabItem, false)
	gohelper.setActive(self._goRecordItem, false)
	self._scrollRight:AddOnValueChanged(self._onScrollValueChanged, self)
end

function AiZiLaRecordView:onUpdateParam()
	return
end

function AiZiLaRecordView:onOpen()
	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.UISelectRecordTabItem, self._onSelectRecordTabItem, self)

	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self.closeThis, self)
	end

	self._recordMOList = {}

	tabletool.addValues(self._recordMOList, AiZiLaModel.instance:getRecordMOList())

	self._selectRecordMO = self._recordMOList[1]

	for i, recordMO in ipairs(self._recordMOList) do
		if recordMO:isUnLock() then
			self._selectRecordMO = recordMO

			break
		end
	end

	self._initSelectRecordMO = self._selectRecordMO

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper4)
end

function AiZiLaRecordView:onClose()
	self:_finishRed(self._initSelectRecordMO)
end

function AiZiLaRecordView:onDestroyView()
	self._scrollRight:RemoveOnValueChanged()
end

function AiZiLaRecordView:_getSelectGroupMOList()
	return self._selectRecordMO and self._selectRecordMO:getRroupMOList()
end

function AiZiLaRecordView:_onSelectRecordTabItem(recordMOId)
	if not recordMOId or self._selectRecordMO and self._selectRecordMO.id == recordMOId then
		return
	end

	for i, recordMO in ipairs(self._recordMOList) do
		if recordMO.id == recordMOId then
			self._selectRecordMO = recordMO

			self:refreshUI()
			self:_finishRed(recordMO)

			return
		end
	end
end

function AiZiLaRecordView:_onScrollValueChanged(value)
	local isShow = gohelper.getRemindFourNumberFloat(self._scrollRight.verticalNormalizedPosition) > 0

	gohelper.setActive(self._goArrow, isShow)

	if not isShow then
		self:_finishRed(self._selectRecordMO)
	end
end

function AiZiLaRecordView:refreshUI()
	gohelper.CreateObjList(self, self._onRecordTabItem, self._recordMOList, self._goLeftTabContent, self._goLeftTabItem, AiZiLaRecordTabItem)
	self:_refreshRecordUI()
end

function AiZiLaRecordView:_refreshRecordUI()
	local dataList = {}

	tabletool.addValues(dataList, self:_getSelectGroupMOList())
	gohelper.CreateObjList(self, self._onRecordItem, dataList, self._goRightItemContent, self._goRecordItem, AiZiLaRecordItem)
end

function AiZiLaRecordView:_onRecordTabItem(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:onSelect(self._selectRecordMO and data and self._selectRecordMO.id == data.id)
end

function AiZiLaRecordView:_onRecordItem(cell_component, data, index)
	cell_component:onUpdateMO(data)
end

function AiZiLaRecordView:_finishRed(recordMO)
	if recordMO and recordMO:isHasRed() then
		recordMO:finishRed()
		AiZiLaModel.instance:checkRecordRed()
	end
end

return AiZiLaRecordView
