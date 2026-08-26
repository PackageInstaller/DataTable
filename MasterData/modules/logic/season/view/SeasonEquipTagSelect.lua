-- chunkname: @modules/logic/season/view/SeasonEquipTagSelect.lua

module("modules.logic.season.view.SeasonEquipTagSelect", package.seeall)

local SeasonEquipTagSelect = class("SeasonEquipTagSelect", BaseView)

function SeasonEquipTagSelect:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonEquipTagSelect:addEvents()
	return
end

function SeasonEquipTagSelect:removeEvents()
	return
end

function SeasonEquipTagSelect:init(ctrl, dropListPath)
	self._controller = ctrl
	self._dropListPath = dropListPath
end

function SeasonEquipTagSelect:_editableInitView()
	self._dropdowntag = gohelper.findChildDropdown(self.viewGO, self._dropListPath)
	self._txtlabel = gohelper.findChildText(self._dropdowntag.gameObject, "Label")
	self._imagearrow = gohelper.findChildImage(self._dropdowntag.gameObject, "arrow")

	self._dropdowntag:AddOnValueChanged(self.handleDropValueChanged, self)

	self._clicktag = gohelper.getClick(self._dropdowntag.gameObject)

	self._clicktag:AddClickListener(self.handleClickTag, self)
end

function SeasonEquipTagSelect:onDestroyView()
	if self._dropdowntag then
		self._dropdowntag:RemoveOnValueChanged()

		self._dropdowntag = nil
	end

	if self._clicktag then
		self._clicktag:RemoveClickListener()

		self._clicktag = nil
	end
end

function SeasonEquipTagSelect:onOpen()
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

function SeasonEquipTagSelect:onClose()
	return
end

function SeasonEquipTagSelect:handleClickTag()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function SeasonEquipTagSelect:handleDropValueChanged(index)
	local selectIndex = index

	if self._controller.setSelectTag and self._model then
		self._controller:setSelectTag(selectIndex)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		self:refreshSelected()
	else
		logError("controller setSelectTag not implement!")
	end
end

function SeasonEquipTagSelect:refreshSelected()
	local tagId = self._model:getCurTagId()
	local colorSelect = tagId == Activity104EquipTagModel.NoTagId and "#cac8c5" or "#c66030"

	self._txtlabel.color = GameUtil.parseColor(colorSelect)

	SLFramework.UGUI.GuiHelper.SetColor(self._imagearrow, colorSelect)
end

return SeasonEquipTagSelect
