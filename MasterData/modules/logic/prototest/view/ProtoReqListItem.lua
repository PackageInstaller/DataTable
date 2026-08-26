-- chunkname: @modules/logic/prototest/view/ProtoReqListItem.lua

module("modules.logic.prototest.view.ProtoReqListItem", package.seeall)

local ProtoReqListItem = class("ProtoReqListItem", ListScrollCell)

function ProtoReqListItem:init(go)
	self._imgGO1 = gohelper.findChild(go, "img1")
	self._imgGO2 = gohelper.findChild(go, "img2")
	self._txtModule = gohelper.findChildText(go, "txtModule")
	self._txtCmd = gohelper.findChildText(go, "txtCmd")
	self._txtReq = gohelper.findChildText(go, "txtReq")
	self._click = gohelper.findChildClick(go, "")
end

function ProtoReqListItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function ProtoReqListItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function ProtoReqListItem:onUpdateMO(mo)
	self._mo = mo
	self._txtModule.text = mo.module
	self._txtCmd.text = mo.cmd
	self._txtReq.text = mo.req

	gohelper.setActive(self._imgGO1, self._index % 2 == 0)
	gohelper.setActive(self._imgGO2, self._index % 2 == 1)
end

function ProtoReqListItem:_onClickThis()
	ProtoTestMgr.instance:dispatchEvent(ProtoEnum.OnClickReqListItem, self._mo)
end

return ProtoReqListItem
