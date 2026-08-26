-- chunkname: @modules/logic/gm/view/GMCommandView.lua

module("modules.logic.gm.view.GMCommandView", package.seeall)
require("modules/logic/gm/view/GMToolCommands")

local GMCommandView = class("GMCommandView", BaseView)

GMCommandView.OpenCommand = 1910
GMCommandView.ClickItem = 1911
GMCommandView.ClickItemAgain = 1912

function GMCommandView:onInitView()
	self._maskGO = gohelper.findChild(self.viewGO, "gmcommand")
	self._inpCommand = gohelper.findChildInputField(self.viewGO, "viewport/content/item1/inpText")
	self._txtCommandStr = gohelper.findChildText(self.viewGO, "gmcommand/txtCommandStr")
	self._txtCommandName = gohelper.findChildText(self.viewGO, "gmcommand/txtCommandName")
	self._txtCommandDesc = gohelper.findChildText(self.viewGO, "gmcommand/txtCommandDesc")

	self:_hideScroll()
end

function GMCommandView:addEvents()
	SLFramework.UGUI.UIClickListener.Get(self._maskGO):AddClickListener(self._onClickMask, self, nil)
end

function GMCommandView:removeEvents()
	SLFramework.UGUI.UIClickListener.Get(self._maskGO):RemoveClickListener()
end

function GMCommandView:onOpen()
	GMController.instance:registerCallback(GMCommandView.OpenCommand, self._showScroll, self)
	GMController.instance:registerCallback(GMCommandView.ClickItem, self._onClickItem, self)
	GMController.instance:registerCallback(GMCommandView.ClickItemAgain, self._hideScroll, self)
end

function GMCommandView:onClose()
	GMController.instance:unregisterCallback(GMCommandView.OpenCommand, self._showScroll, self)
	GMController.instance:unregisterCallback(GMCommandView.ClickItem, self._onClickItem, self)
	GMController.instance:unregisterCallback(GMCommandView.ClickItemAgain, self._hideScroll, self)
end

function GMCommandView:_onClickMask()
	self:_hideScroll()
end

function GMCommandView:_onClickItem(mo)
	self._txtCommandStr.text = mo.command
	self._txtCommandName.text = mo.name
	self._txtCommandDesc.text = mo.desc

	self._inpCommand:SetText(mo.command)
end

function GMCommandView:_showScroll()
	gohelper.setActive(self._maskGO, true)
	GMCommandModel.instance:checkInitList()
end

function GMCommandView:_hideScroll()
	gohelper.setActive(self._maskGO, false)
end

return GMCommandView
