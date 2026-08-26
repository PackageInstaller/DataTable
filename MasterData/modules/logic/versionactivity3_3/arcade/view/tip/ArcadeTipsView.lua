-- chunkname: @modules/logic/versionactivity3_3/arcade/view/tip/ArcadeTipsView.lua

module("modules.logic.versionactivity3_3.arcade.view.tip.ArcadeTipsView", package.seeall)

local ArcadeTipsView = class("ArcadeTipsView", BaseView)

function ArcadeTipsView:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._goroot = gohelper.findChild(self.viewGO, "#go_container/root")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeTipsView:_btncloseOnClick()
	self:_closeView()
end

function ArcadeTipsView:_onCloseView(viewName)
	if viewName == self.viewParam.orignViewName then
		self:closeView()
	end
end

function ArcadeTipsView:_closeView()
	if self._tipChildView then
		self._tipChildView:playCloseAnim(self.closeView, self)
	else
		self:closeView()
	end
end

function ArcadeTipsView:closeView()
	self:_resetParentRoot()
	self:closeThis()
end

function ArcadeTipsView:_editableInitView()
	self._childViewList = {}
end

function ArcadeTipsView:onUpdateParam()
	self:_openTipView()
end

function ArcadeTipsView:onOpen()
	return
end

function ArcadeTipsView:onOpenFinish()
	self:refreshChildView()
	self:setParentRoot()
end

function ArcadeTipsView:_openTipView()
	self:refreshView()
end

function ArcadeTipsView:refreshView()
	self:setParentRoot()
	self:refreshChildView()
end

function ArcadeTipsView:refreshChildView()
	local tipType = self.viewParam.tipType

	self._tipChildView = self._childViewList[tipType]

	if not self._tipChildView then
		local param = ArcadeEnum.TipParams[tipType]
		local path = param and param.ViewRes

		if not string.nilorempty(path) then
			local childGO = self:getResInst(path, self._goroot)

			self._tipChildView = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, param.View)
			self._childViewList[tipType] = self._tipChildView
		end
	end

	for type, view in pairs(self._childViewList) do
		view:showView(type == tipType)
	end

	if self._tipChildView then
		local anchorX, anchorY = 0, 0

		if self.viewParam.AnchorPos then
			anchorY = self.viewParam.AnchorPos.y
			anchorX = self.viewParam.AnchorPos.x
		end

		self._tipChildView:setAnchor(self.viewParam, anchorX, anchorY)
		self._tipChildView:onUpdateMO(self.viewParam, self)
	end
end

function ArcadeTipsView:setParentRoot()
	if self.viewParam.hideCloseBtn then
		gohelper.setActive(self._btnclose, false)
	else
		gohelper.setActive(self._btnclose, true)
	end

	if not self.viewGO then
		return
	end

	if not self.viewParam.root then
		self:_resetParentRoot()

		return
	end

	gohelper.addChildPosStay(self.viewParam.root, self.viewGO)
	recthelper.setAnchor(self.viewGO.transform, 0, 0)
end

function ArcadeTipsView:_resetParentRoot()
	local go = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_TOP")

	gohelper.addChildPosStay(go, self.viewGO)
	recthelper.setAnchor(self.viewGO.transform, 0, 0)
end

function ArcadeTipsView:onClose()
	return
end

function ArcadeTipsView:onDestroyView()
	return
end

return ArcadeTipsView
