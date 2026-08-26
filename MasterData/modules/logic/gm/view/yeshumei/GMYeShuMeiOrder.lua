-- chunkname: @modules/logic/gm/view/yeshumei/GMYeShuMeiOrder.lua

module("modules.logic.gm.view.yeshumei.GMYeShuMeiOrder", package.seeall)

local GMYeShuMeiOrder = class("GMYeShuMeiOrder", LuaCompBase)

function GMYeShuMeiOrder:init(go)
	self.go = go
	self._txtorder = gohelper.findChildText(go, "#txt_order")
	self._btndelete = gohelper.findChildButton(go, "#btn_delete")
	self._btnswitch = gohelper.findChildButton(go, "#btn_switch")
	self._gobg = gohelper.findChild(go, "image")

	gohelper.setActive(self.go, true)
end

function GMYeShuMeiOrder:addEventListeners()
	self._btndelete:AddClickListener(self._onClickBtnDelete, self)
	self._btnswitch:AddClickListener(self._onClickBtnSwitch, self)
end

function GMYeShuMeiOrder:removeEventListeners()
	self._btndelete:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
end

function GMYeShuMeiOrder:initOrder(order)
	self.order = order
	self._txtorder.text = "连线顺序：" .. order
end

function GMYeShuMeiOrder:getOrder()
	return self.order
end

function GMYeShuMeiOrder:updateOrder()
	gohelper.setActive(self._gobg, self.order == GMYeShuMeiModel.instance:getCurLevelOrder())
end

function GMYeShuMeiOrder:_onClickBtnDelete()
	self._deleteCb(self._deleteObj, self.order)
end

function GMYeShuMeiOrder:_onClickBtnSwitch()
	self._switchCb(self._switchObj, self.order)
end

function GMYeShuMeiOrder:addDeleteCb(cb, obj)
	self._deleteCb = cb
	self._deleteObj = obj
end

function GMYeShuMeiOrder:addSwitchCb(cb, obj)
	self._switchCb = cb
	self._switchObj = obj
end

function GMYeShuMeiOrder:onDestroy()
	gohelper.destroy(self.go)
end

return GMYeShuMeiOrder
