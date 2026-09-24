-- chunkname: @modules/logic/tips/view/QteEnterEffectView.lua

module("modules.logic.tips.view.QteEnterEffectView", package.seeall)

local QteEnterEffectView = class("QteEnterEffectView", BaseView)

function QteEnterEffectView.blockEsc()
	return
end

function QteEnterEffectView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function QteEnterEffectView:addEvents()
	return
end

function QteEnterEffectView:removeEvents()
	return
end

function QteEnterEffectView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
end

function QteEnterEffectView:onUpdateParam()
	return
end

function QteEnterEffectView:onOpen()
	return
end

function QteEnterEffectView:onClose()
	return
end

function QteEnterEffectView:onDestroyView()
	return
end

return QteEnterEffectView
