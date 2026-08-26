-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6BuffItem.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6BuffItem", package.seeall)

local LengZhou6BuffItem = class("LengZhou6BuffItem", ListScrollCellExtend)

function LengZhou6BuffItem:onInitView()
	self._imagebuff = gohelper.findChildImage(self.viewGO, "#image_buff")
	self._txtbuffValue = gohelper.findChildText(self.viewGO, "#image_buff/#txt_buffValue")
	self._goclick = gohelper.findChild(self.viewGO, "#image_buff/#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6BuffItem:addEvents()
	return
end

function LengZhou6BuffItem:removeEvents()
	return
end

function LengZhou6BuffItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._goclick)

	self._click:AddClickListener(self._onClick, self)
end

function LengZhou6BuffItem:_onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._buff then
		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.OnClickBuff, self._buff._configId)
	end
end

function LengZhou6BuffItem:updateBuffItem(buff)
	self._buff = buff

	if self._buff ~= nil then
		local config = self._buff.config
		local name = config.icon

		UISpriteSetMgr.instance:setBuffSprite(self._imagebuff, name)

		local value = self._buff:getLayerCount()

		self._txtbuffValue.text = value

		gohelper.setActive(self.viewGO, value > 0)
	else
		gohelper.setActive(self.viewGO, false)
	end
end

function LengZhou6BuffItem:changeParent(parent)
	self.viewGO.transform.parent = parent.transform
end

function LengZhou6BuffItem:onDestroyView()
	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end
end

return LengZhou6BuffItem
