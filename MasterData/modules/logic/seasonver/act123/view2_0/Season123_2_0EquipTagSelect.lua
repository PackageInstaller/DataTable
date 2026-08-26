-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0EquipTagSelect.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0EquipTagSelect", package.seeall)

local Season123_2_0EquipTagSelect = class("Season123_2_0EquipTagSelect", BaseView)

function Season123_2_0EquipTagSelect:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0EquipTagSelect:addEvents()
	return
end

function Season123_2_0EquipTagSelect:removeEvents()
	return
end

function Season123_2_0EquipTagSelect:init(ctrl, dropListPath, defaultColor)
	self._controller = ctrl
	self._dropListPath = dropListPath
	self._defaultColor = defaultColor or "#cac8c5"
end

function Season123_2_0EquipTagSelect:_editableInitView()
	self._dropdowntag = gohelper.findChildDropdown(self.viewGO, self._dropListPath)
	self._txtlabel = gohelper.findChildText(self._dropdowntag.gameObject, "Label")
	self._imagearrow = gohelper.findChildImage(self._dropdowntag.gameObject, "arrow")

	self._dropdowntag:AddOnValueChanged(self.handleDropValueChanged, self)

	self._clicktag = gohelper.getClick(self._dropdowntag.gameObject)

	self._clicktag:AddClickListener(self.handleClickTag, self)
end

function Season123_2_0EquipTagSelect:onDestroyView()
	if self._dropdowntag then
		self._dropdowntag:RemoveOnValueChanged()

		self._dropdowntag = nil
	end

	if self._clicktag then
		self._clicktag:RemoveClickListener()

		self._clicktag = nil
	end
end

function Season123_2_0EquipTagSelect:onOpen()
	self.equipTagModel = self._controller.getFilterModel and self._controller:getFilterModel() or Season123EquipBookModel.instance.tagModel

	if not self.equipTagModel then
		return
	end

	self._dropdowntag:ClearOptions()
	self._dropdowntag:AddOptions(self.equipTagModel:getOptions())
	self._dropdowntag:SetValue(0)
	self:refreshSelected()
end

function Season123_2_0EquipTagSelect:onClose()
	return
end

function Season123_2_0EquipTagSelect:handleClickTag()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function Season123_2_0EquipTagSelect:handleDropValueChanged(index)
	local selectIndex = index

	if self._controller.setSelectTag and self.equipTagModel then
		self._controller:setSelectTag(selectIndex)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		self:refreshSelected()
	else
		logError("controller setSelectTag not implement!")
	end
end

function Season123_2_0EquipTagSelect:refreshSelected()
	local tagId = self.equipTagModel:getCurTagId()
	local colorSelect = tagId == Season123EquipTagModel.NoTagId and self._defaultColor or "#c66030"

	self._txtlabel.color = GameUtil.parseColor(colorSelect)

	SLFramework.UGUI.GuiHelper.SetColor(self._imagearrow, colorSelect)
end

return Season123_2_0EquipTagSelect
