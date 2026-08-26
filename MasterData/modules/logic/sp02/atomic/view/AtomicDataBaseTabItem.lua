-- chunkname: @modules/logic/sp02/atomic/view/AtomicDataBaseTabItem.lua

module("modules.logic.sp02.atomic.view.AtomicDataBaseTabItem", package.seeall)

local AtomicDataBaseTabItem = class("AtomicDataBaseTabItem", LuaCompBase)

function AtomicDataBaseTabItem:init(go)
	self.go = go
	self.goSelect = gohelper.findChild(go, "#go_select")
	self.txtSelectName = gohelper.findChildTextMesh(go, "#go_select/#txt_name")
	self.goUnSelect = gohelper.findChild(go, "#go_unselect")
	self.txtUnSelectName = gohelper.findChildTextMesh(go, "#go_unselect/#txt_name")
	self.goNew = gohelper.findChild(go, "#image_new")
	self.btnClick = gohelper.findButtonWithAudio(go, AudioEnum3_10.Outside.play_ui_langchao_general_click)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDataBaseTabItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._btnclickOnClick, self)
end

function AtomicDataBaseTabItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
end

function AtomicDataBaseTabItem:_btnclickOnClick()
	if not self.dataType then
		return
	end

	AtomicDataBaseController.instance:trySelectTab(self.dataType)
end

function AtomicDataBaseTabItem:_editableInitView()
	return
end

function AtomicDataBaseTabItem:updateData(data)
	self.dataType = nil

	gohelper.setActive(self.go, data ~= nil)

	if not data then
		return
	end

	self.dataType = data.dataType

	self:refreshUI()
end

function AtomicDataBaseTabItem:refreshUI()
	local isSelect = AtomicDataBaseViewModel.instance:isTabSelected(self.dataType)

	gohelper.setActive(self.goSelect, isSelect)
	gohelper.setActive(self.goUnSelect, not isSelect)

	local isNew = AtomicDataBaseViewModel.instance:isTabNew(self.dataType)

	gohelper.setActive(self.goNew, isNew)

	local tabTxt = luaLang(string.format("s02_atomic_databasetabtxt_%s", self.dataType))

	self.txtSelectName.text = tabTxt
	self.txtUnSelectName.text = tabTxt
end

function AtomicDataBaseTabItem:onDestroy()
	return
end

return AtomicDataBaseTabItem
