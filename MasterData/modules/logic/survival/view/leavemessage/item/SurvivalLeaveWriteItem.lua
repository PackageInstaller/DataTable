-- chunkname: @modules/logic/survival/view/leavemessage/item/SurvivalLeaveWriteItem.lua

module("modules.logic.survival.view.leavemessage.item.SurvivalLeaveWriteItem", package.seeall)

local SurvivalLeaveWriteItem = class("SurvivalLeaveWriteItem", SimpleListItem)

function SurvivalLeaveWriteItem:onInit()
	self._btnClickItem = gohelper.findChildButton(self.viewGO, "btn_ClickItem")
	self.textType = gohelper.findChildTextMesh(self.viewGO, "txt_Type")
	self.textSelect = gohelper.findChildTextMesh(self.viewGO, "#txt_Select")
	self.imgArrow = gohelper.findChild(self.viewGO, "img_Arrow")
	self._dropfilter = gohelper.findChildDropdown(self.viewGO, "dropfilter")
	self.filterDropExtend = DropDownExtend.Get(self._dropfilter.gameObject)

	self.filterDropExtend:init(self.onFilterDropShow, self.onFilterDropHide, self)
	transformhelper.setLocalRotation(self.imgArrow.gameObject.transform, 0, 0, 180)
end

function SurvivalLeaveWriteItem:onAddListeners()
	self._dropfilter:AddOnValueChanged(self._onDropFilterValueChanged, self)
end

function SurvivalLeaveWriteItem:onRemoveListeners()
	self._dropfilter:RemoveOnValueChanged()
end

function SurvivalLeaveWriteItem:onItemShow(data)
	self.leaveMsgType = data.leaveMsgType
	self.selectId = data.selectId
	self.isSelectWriteItem = data.selectWriteItem
	self.selectIndex = data.selectIndex
	self.onClickSelectItem = data.onClickSelectItem
	self.context = data.context
	self.textType.text = luaLang("SurvivalLeaveMsgType_" .. self.leaveMsgType)

	local ids = SurvivalConfig.instance:getLeaveMsgByType(self.leaveMsgType)

	if not self.isInit then
		local data = {
			"/"
		}

		for i, cfg in ipairs(ids) do
			local str = cfg.desc

			table.insert(data, str)
		end

		self._dropfilter:AddOptions(data)

		self.isInit = true
	end

	local selectIndex = 0

	for i, cfg in ipairs(ids) do
		if cfg.id == self.selectId then
			selectIndex = i
		end
	end

	self._dropfilter:SetValue(selectIndex)
end

function SurvivalLeaveWriteItem:onFilterDropShow()
	self:_onClickItem()
	transformhelper.setLocalRotation(self.imgArrow.gameObject.transform, 0, 0, 0)
end

function SurvivalLeaveWriteItem:onFilterDropHide()
	transformhelper.setLocalRotation(self.imgArrow.gameObject.transform, 0, 0, 180)
end

function SurvivalLeaveWriteItem:_onDropFilterValueChanged(index)
	if self.onClickSelectItem then
		self.onClickSelectItem(self.context, self, index)
	end
end

return SurvivalLeaveWriteItem
