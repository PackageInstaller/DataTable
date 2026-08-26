-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultUnlockInfoGroupItem.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultUnlockInfoGroupItem", package.seeall)

local Rouge2_ResultUnlockInfoGroupItem = class("Rouge2_ResultUnlockInfoGroupItem", LuaCompBase)

function Rouge2_ResultUnlockInfoGroupItem:init(go)
	self.go = go
	self._txttitle = gohelper.findChildText(self.go, "title/#txt_title")
	self._golayout = gohelper.findChild(self.go, "#go_layout")
	self._goitem = gohelper.findChild(self.go, "#go_layout/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultUnlockInfoGroupItem:_editableInitView()
	self._itemList = {}

	gohelper.setActive(self._goitem, false)
end

function Rouge2_ResultUnlockInfoGroupItem:setInfo(mo)
	self.mo = mo

	self:refreshUI()
end

function Rouge2_ResultUnlockInfoGroupItem:refreshUI()
	self:refreshTitle()
end

function Rouge2_ResultUnlockInfoGroupItem:refreshTitle()
	local titleUrl = Rouge2_OutsideEnum.UnlockTitle[self.mo.type]

	self._txttitle.text = luaLang(titleUrl)

	self:refreshItem()
end

function Rouge2_ResultUnlockInfoGroupItem:refreshItem()
	for index, itemId in ipairs(self.mo.itemList) do
		local item = self:getItem(index)

		item:setInfo(self.mo.type, itemId)
	end
end

function Rouge2_ResultUnlockInfoGroupItem:getItem(index)
	if not self._itemList[index] then
		local go = gohelper.cloneInPlace(self._goitem)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_ResultUnlockInfoListItem)

		gohelper.setActive(go, true)
		table.insert(self._itemList, item)

		return item
	end

	return self._itemList[index]
end

function Rouge2_ResultUnlockInfoGroupItem:onDestroy()
	return
end

return Rouge2_ResultUnlockInfoGroupItem
