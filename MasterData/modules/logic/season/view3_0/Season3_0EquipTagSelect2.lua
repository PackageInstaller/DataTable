-- chunkname: @modules/logic/season/view3_0/Season3_0EquipTagSelect2.lua

module("modules.logic.season.view3_0.Season3_0EquipTagSelect2", package.seeall)

local Season3_0EquipTagSelect2 = class("Season3_0EquipTagSelect2", BaseView)

function Season3_0EquipTagSelect2:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0EquipTagSelect2:addEvents()
	return
end

function Season3_0EquipTagSelect2:removeEvents()
	return
end

function Season3_0EquipTagSelect2:init(ctrl, dropListPath, dropListPath2, defaultColor)
	self._controller = ctrl
	self._dropListPath = dropListPath
	self._dropListPath2 = dropListPath2
	self._defaultColor = defaultColor or "#cac8c5"
end

function Season3_0EquipTagSelect2:_editableInitView()
	self._dropdowntag = gohelper.findChildDropdown(self.viewGO, self._dropListPath)
	self._txtlabel = gohelper.findChildText(self._dropdowntag.gameObject, "Label")
	self._imagearrow = gohelper.findChildImage(self._dropdowntag.gameObject, "arrow")

	self._dropdowntag:AddOnValueChanged(self.handleDropValueChanged, self)

	self._clicktag = gohelper.getClick(self._dropdowntag.gameObject)

	self._clicktag:AddClickListener(self.handleClickTag, self)

	self._dropdowntag2 = gohelper.findChildDropdown(self.viewGO, self._dropListPath2)
	self._txtlabel2 = gohelper.findChildText(self._dropdowntag2.gameObject, "Label")
	self._imagearrow2 = gohelper.findChildImage(self._dropdowntag2.gameObject, "Arrow")

	self._dropdowntag2:AddOnValueChanged(self.handleDropValueChanged2, self)

	self._clicktag2 = gohelper.getClick(self._dropdowntag2.gameObject)

	self._clicktag2:AddClickListener(self.handleClickTag, self)
end

function Season3_0EquipTagSelect2:onDestroyView()
	if self._dropdowntag then
		self._dropdowntag:RemoveOnValueChanged()

		self._dropdowntag = nil
	end

	if self._clicktag then
		self._clicktag:RemoveClickListener()

		self._clicktag = nil
	end

	if self._dropdowntag2 then
		self._dropdowntag2:RemoveOnValueChanged()

		self._dropdowntag2 = nil
	end

	if self._clicktag2 then
		self._clicktag2:RemoveClickListener()

		self._clicktag2 = nil
	end
end

function Season3_0EquipTagSelect2:onOpen()
	if self._controller.getFilterModel then
		self._model = self._controller:getFilterModel()
	end

	if self._model then
		self._dropdowntag:ClearOptions()
		self._dropdowntag:AddOptions(self._model:getOptions())
		self._dropdowntag:SetValue(0)
		self:refreshSelected()
	end

	if self._controller.getFilterModel2 then
		self._model2 = self._controller:getFilterModel2()
	end

	if self._model2 then
		self._dropdowntag2:ClearOptions()
		self._dropdowntag2:AddOptions(self._model2:getOptions())
		self._dropdowntag2:SetValue(4)
		self:refreshSelected2()
	end
end

function Season3_0EquipTagSelect2:onClose()
	return
end

function Season3_0EquipTagSelect2:handleClickTag()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function Season3_0EquipTagSelect2:handleDropValueChanged(index)
	local selectIndex = index

	if self._controller.setSelectTag and self._model then
		self._controller:setSelectTag(selectIndex)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		self:refreshSelected()
	else
		logError("controller setSelectTag not implement!")
	end
end

function Season3_0EquipTagSelect2:handleDropValueChanged2(index)
	local selectIndex = index

	if self._controller.setSelectFilterId and self._model then
		self._controller:setSelectFilterId(selectIndex)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		self:refreshSelected2()
	else
		logError("controller setSelectFilterId not implement!")
	end
end

function Season3_0EquipTagSelect2:refreshSelected()
	local tagId = self._model:getCurTagId()
	local colorSelect = tagId == Activity104EquipTagModel.NoTagId and self._defaultColor or "#c66030"

	self._txtlabel.color = GameUtil.parseColor(colorSelect)

	SLFramework.UGUI.GuiHelper.SetColor(self._imagearrow, colorSelect)
end

function Season3_0EquipTagSelect2:refreshSelected2()
	local filterId = self._model2:getCurId()
	local colorSelect

	self._txtlabel2.text = self._model2:getOptionTxt(filterId, filterId == Activity104EquipCountModel.DefaultId and self._defaultColor or "#c66030")
end

return Season3_0EquipTagSelect2
