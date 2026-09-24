-- chunkname: @modules/logic/tips/view/QteOutEffectView.lua

module("modules.logic.tips.view.QteOutEffectView", package.seeall)

local QteOutEffectView = class("QteOutEffectView", BaseView)

function QteOutEffectView.blockEsc()
	return
end

function QteOutEffectView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function QteOutEffectView:addEvents()
	return
end

function QteOutEffectView:removeEvents()
	return
end

function QteOutEffectView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
end

function QteOutEffectView:onUpdateParam()
	return
end

function QteOutEffectView:onOpen()
	return
end

function QteOutEffectView:onClose()
	return
end

function QteOutEffectView:onDestroyView()
	return
end

return QteOutEffectView
