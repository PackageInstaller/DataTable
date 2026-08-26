-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityGameTipView.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityGameTipView", package.seeall)

local AtomicOperationActivityGameTipView = class("AtomicOperationActivityGameTipView", BaseView)

function AtomicOperationActivityGameTipView:onInitView()
	self._golefttop = gohelper.findChild(self.viewGO, "root/#go_lefttop")
	self._btnclose = gohelper.findChildButton(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityGameTipView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function AtomicOperationActivityGameTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function AtomicOperationActivityGameTipView:_editableInitView()
	return
end

function AtomicOperationActivityGameTipView:onUpdateParam()
	return
end

function AtomicOperationActivityGameTipView:onOpen()
	self:refreshUI()
end

function AtomicOperationActivityGameTipView:refreshUI()
	local targetConfigList = AtomicOperationActivityConfig.instance:getTargetConfigList()

	for _, config in ipairs(targetConfigList) do
		local scoreText = gohelper.findChildTextMesh(self.viewGO, string.format("root/Role/#go_roleitem%s/#txt_score", config.id))
		local suffix = config.firstScore > 0 and "+" or "-"

		scoreText.text = suffix .. tostring(math.abs(config.firstScore))
	end
end

function AtomicOperationActivityGameTipView:onClose()
	return
end

function AtomicOperationActivityGameTipView:onDestroyView()
	return
end

return AtomicOperationActivityGameTipView
