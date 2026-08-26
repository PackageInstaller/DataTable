-- chunkname: @modules/logic/fight/view/FightFocusCameraAdjustView.lua

module("modules.logic.fight.view.FightFocusCameraAdjustView", package.seeall)

local FightFocusCameraAdjustView = class("FightFocusCameraAdjustView", BaseView)

function FightFocusCameraAdjustView:onInitView()
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_block")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._gooffset = gohelper.findChild(self.viewGO, "#go_container/component/#go_offset")
	self._gooffset1 = gohelper.findChild(self.viewGO, "#go_container/component/#go_offset/offsets/#go_offset1")
	self._gooffset2 = gohelper.findChild(self.viewGO, "#go_container/component/#go_offset/offsets/#go_offset2")
	self._gooffset3 = gohelper.findChild(self.viewGO, "#go_container/component/#go_offset/offsets/#go_offset3")
	self._btnsaveOffset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/component/#go_offset/#btn_saveOffset")
	self._btnresetOffset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/component/#go_offset/#btn_resetOffset")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/component/#go_offset/#btn_close")
	self._txtskinId = gohelper.findChildText(self.viewGO, "#go_container/component/label/#txt_skinId")
	self._txtoffset = gohelper.findChildText(self.viewGO, "#go_container/component/label/#txt_offset")
	self._gomiddlecontainer = gohelper.findChild(self.viewGO, "#go_middlecontainer")
	self._gomiddle = gohelper.findChild(self.viewGO, "#go_middlecontainer/#go_middle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightFocusCameraAdjustView:addEvents()
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self._btnsaveOffset:AddClickListener(self._btnsaveOffsetOnClick, self)
	self._btnresetOffset:AddClickListener(self._btnresetOffsetOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function FightFocusCameraAdjustView:removeEvents()
	self._btnblock:RemoveClickListener()
	self._btnsaveOffset:RemoveClickListener()
	self._btnresetOffset:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

FightFocusCameraAdjustView.SliderMaxValue = 50
FightFocusCameraAdjustView.SliderMinValue = -50
FightFocusCameraAdjustView.OffsetKey = {
	Z = "z",
	X = "x",
	Y = "y"
}

function FightFocusCameraAdjustView:_btnblockOnClick()
	return
end

function FightFocusCameraAdjustView:_btnsaveOffsetOnClick()
	return
end

function FightFocusCameraAdjustView:_btnresetOffsetOnClick()
	for _, item in pairs(self.sliderDict) do
		item.slider:SetValue(0)
	end
end

function FightFocusCameraAdjustView:_btncloseOnClick()
	self:closeThis()
end

function FightFocusCameraAdjustView:_onSliderValueChanged()
	if not self.initDone then
		return
	end

	local x = self.sliderDict[FightFocusCameraAdjustView.OffsetKey.X].slider:GetValue()
	local y = self.sliderDict[FightFocusCameraAdjustView.OffsetKey.Y].slider:GetValue()
	local z = self.sliderDict[FightFocusCameraAdjustView.OffsetKey.Z].slider:GetValue()

	self.sliderDict[FightFocusCameraAdjustView.OffsetKey.X].text.text = x
	self.sliderDict[FightFocusCameraAdjustView.OffsetKey.Y].text.text = y
	self.sliderDict[FightFocusCameraAdjustView.OffsetKey.Z].text.text = z

	FightWorkFocusMonster.changeCameraPosition(x, y, z, self.updateEntityMiddlePosition, self)
	self:refreshOffsetLabel(x, y, z)
end

function FightFocusCameraAdjustView:addBtnClick(item)
	local currentOffset = item.slider:GetValue()

	currentOffset = currentOffset + tonumber(item.intervalField:GetText())

	item.slider:SetValue(currentOffset)
end

function FightFocusCameraAdjustView:reduceBtnClick(item)
	local currentOffset = item.slider:GetValue()

	currentOffset = currentOffset - tonumber(item.intervalField:GetText())

	item.slider:SetValue(currentOffset)
end

function FightFocusCameraAdjustView:_initSlider(goOffset, key)
	local slider = gohelper.findChildSlider(goOffset, "slider_offset")

	slider.slider.maxValue = FightFocusCameraAdjustView.SliderMaxValue
	slider.slider.minValue = FightFocusCameraAdjustView.SliderMinValue

	slider:AddOnValueChanged(self._onSliderValueChanged, self)
	slider:SetValue(0)

	local text = gohelper.findChildText(goOffset, "txt_offset")
	local addBtn = gohelper.findChildButtonWithAudio(goOffset, "AddBtn")
	local reduceBtn = gohelper.findChildButtonWithAudio(goOffset, "ReduceBtn")
	local intervalField = gohelper.findChildTextMeshInputField(goOffset, "IntervalField")
	local item = self:getUserDataTb_()

	item.slider = slider
	item.text = text
	item.addBtn = addBtn
	item.reduceBtn = reduceBtn
	item.intervalField = intervalField

	addBtn:AddClickListener(self.addBtnClick, self, item)
	reduceBtn:AddClickListener(self.reduceBtnClick, self, item)
	intervalField:SetText(1)

	text.text = 0
	self.sliderDict[key] = item
end

function FightFocusCameraAdjustView:_editableInitView()
	self.initDone = false
	self.sliderDict = self:getUserDataTb_()

	self:_initSlider(self._gooffset1, FightFocusCameraAdjustView.OffsetKey.X)
	self:_initSlider(self._gooffset2, FightFocusCameraAdjustView.OffsetKey.Y)
	self:_initSlider(self._gooffset3, FightFocusCameraAdjustView.OffsetKey.Z)

	self.unitCamera = CameraMgr.instance:getUnitCamera()
	self.initDone = true
end

function FightFocusCameraAdjustView:onUpdateParam()
	return
end

function FightFocusCameraAdjustView:onOpen()
	self:initEntity()

	self._txtskinId.text = "皮肤ID : " .. self:getFocusSkinId()

	self:refreshOffsetLabel(0, 0, 0)
	FightWorkFocusMonster.changeCameraPosition(0, 0, 0, self.updateEntityMiddlePosition, self)
end

function FightFocusCameraAdjustView:getFocusSkinId()
	return self.entity and self.entity:getMO().skin or ""
end

function FightFocusCameraAdjustView:initEntity()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.FightSkillSelectView)

	if not viewContainer then
		self.entity = nil

		return
	end

	local entityId = viewContainer._views[1]:getCurrentFocusEntityId()

	if not entityId then
		self.entity = nil

		return
	end

	local entity = FightHelper.getEntity(entityId)

	if not entity then
		self.entity = nil

		return
	end

	self.entity = entity
	self.mountMiddleGo = self.entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
end

function FightFocusCameraAdjustView:refreshOffsetLabel(x, y, z)
	self._txtoffset.text = string.format("X : <color=red>%.4f</color>;    Y : <color=red>%.4f</color>;    Z : <color=red>%.4f</color>", x, y, z)
end

function FightFocusCameraAdjustView:updateEntityMiddlePosition()
	if not self.mountMiddleGo then
		return
	end

	local anchor = recthelper.worldPosToAnchorPos(self.mountMiddleGo.transform.position, self._gomiddlecontainer.transform, nil, self.unitCamera)

	recthelper.setAnchor(self._gomiddle.transform, anchor.x, anchor.y)
end

function FightFocusCameraAdjustView:onClose()
	for _, item in pairs(self.sliderDict) do
		item.slider:RemoveOnValueChanged()
		item.addBtn:RemoveClickListener()
		item.reduceBtn:RemoveClickListener()
	end
end

function FightFocusCameraAdjustView:onDestroyView()
	return
end

return FightFocusCameraAdjustView
