-- chunkname: @modules/logic/season/view3_0/Season3_0EquipTagSelect.lua

module("modules.logic.season.view3_0.Season3_0EquipTagSelect", package.seeall)

local Season3_0EquipTagSelect = class("Season3_0EquipTagSelect", BaseView)

function Season3_0EquipTagSelect:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0EquipTagSelect:addEvents()
	return
end

function Season3_0EquipTagSelect:removeEvents()
	return
end

function Season3_0EquipTagSelect:init(ctrl, dropListPath, defaultColor)
	self._controller = ctrl
	self._dropListPath = dropListPath
	self._defaultColor = defaultColor or "#cac8c5"
end

function Season3_0EquipTagSelect:_editableInitView()
	self._dropdowntag = gohelper.findChildDropdown(self.viewGO, self._dropListPath)
	self._txtlabel = gohelper.findChildText(self._dropdowntag.gameObject, "Label")
	self._imagearrow = gohelper.findChildImage(self._dropdowntag.gameObject, "arrow")

	self._dropdowntag:AddOnValueChanged(self.handleDropValueChanged, self)

	self._clicktag = gohelper.getClick(self._dropdowntag.gameObject)

	self._clicktag:AddClickListener(self.handleClickTag, self)
end

function Season3_0EquipTagSelect:onDestroyView()
	if self._dropdowntag then
		self._dropdowntag:RemoveOnValueChanged()

		self._dropdowntag = nil
	end

	if self._clicktag then
		self._clicktag:RemoveClickListener()

		self._clicktag = nil
	end
end

function Season3_0EquipTagSelect:onOpen()
	if self._controller.getFilterModel then
		self._model = self._controller:getFilterModel()
	end

	if not self._model then
		return
	end

	self._dropdowntag:ClearOptions()
	self._dropdowntag:AddOptions(self._model:getOptions())
	self._dropdowntag:SetValue(0)
	self:refreshSelected()
end

function Season3_0EquipTagSelect:onClose()
	return
end

function Season3_0EquipTagSelect:handleClickTag()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function Season3_0EquipTagSelect:handleDropValueChanged(index)
	local selectIndex = index

	if self._controller.setSelectTag and self._model then
		self._controller:setSelectTag(selectIndex)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		self:refreshSelected()
	else
		logError("controller setSelectTag not implement!")
	end
end

function Season3_0EquipTagSelect:refreshSelected()
	local tagId = self._model:getCurTagId()
	local colorSelect = tagId == Activity104EquipTagModel.NoTagId and self._defaultColor or "#c66030"

	self._txtlabel.color = GameUtil.parseColor(colorSelect)

	SLFramework.UGUI.GuiHelper.SetColor(self._imagearrow, colorSelect)
end

return Season3_0EquipTagSelect
