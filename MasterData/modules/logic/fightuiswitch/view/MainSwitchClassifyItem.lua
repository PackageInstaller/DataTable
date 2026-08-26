-- chunkname: @modules/logic/fightuiswitch/view/MainSwitchClassifyItem.lua

module("modules.logic.fightuiswitch.view.MainSwitchClassifyItem", package.seeall)

local MainSwitchClassifyItem = class("MainSwitchClassifyItem", LuaCompBase)

function MainSwitchClassifyItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._goline = gohelper.findChild(self.viewGO, "image_line")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSwitchClassifyItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function MainSwitchClassifyItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function MainSwitchClassifyItem:_btnclickOnClick()
	if self.clickCb and self.clickCbobject then
		self.clickCb(self.clickCbobject, self._index)
	end
end

function MainSwitchClassifyItem:_editableInitView()
	self._txts = self:getUserDataTb_()

	local txt1 = gohelper.findChildText(self.viewGO, "#go_normal/txt")
	local txt2 = gohelper.findChildText(self.viewGO, "#go_select/txt")

	table.insert(self._txts, txt1)
	table.insert(self._txts, txt2)

	self._goreddot = gohelper.findChild(self.viewGO, "reddot")
end

function MainSwitchClassifyItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function MainSwitchClassifyItem:onUpdateMO(mo, index)
	self._mo = mo
	self._index = index
end

function MainSwitchClassifyItem:addBtnListeners(cb, cbObj)
	self.clickCb = cb
	self.clickCbobject = cbObj
end

function MainSwitchClassifyItem:setTxt(str)
	if self._txts then
		for i, txt in ipairs(self._txts) do
			txt.text = str
		end
	end
end

function MainSwitchClassifyItem:showLine(isShow)
	gohelper.setActive(self._goline, isShow)
end

function MainSwitchClassifyItem:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

function MainSwitchClassifyItem:onSelect(isSelect)
	gohelper.setActive(self._gonormal, not isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function MainSwitchClassifyItem:onSelectByIndex(index)
	local isSelect = self._index == index

	self:onSelect(isSelect)
end

function MainSwitchClassifyItem:showReddot(isShow)
	gohelper.setActive(self._goreddot, isShow)
end

return MainSwitchClassifyItem
