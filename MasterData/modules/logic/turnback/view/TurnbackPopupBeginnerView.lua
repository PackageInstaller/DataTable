-- chunkname: @modules/logic/turnback/view/TurnbackPopupBeginnerView.lua

module("modules.logic.turnback.view.TurnbackPopupBeginnerView", package.seeall)

local TurnbackPopupBeginnerView = class("TurnbackPopupBeginnerView", BaseViewExtended)

function TurnbackPopupBeginnerView:onInitView()
	self._gosubview = gohelper.findChild(self.viewGO, "#go_subview")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackPopupBeginnerView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	NavigateMgr.instance:addEscape(ViewName.TurnbackPopupBeginnerView, self._btncloseOnClick, self)
end

function TurnbackPopupBeginnerView:removeEvents()
	self._btnclose:RemoveClickListener()
	NavigateMgr.instance:removeEscape(ViewName.TurnbackPopupBeginnerView, self._btncloseOnClick, self)
end

local subViewDict = {
	TurnbackPopupRewardView
}

function TurnbackPopupBeginnerView:_btncloseOnClick()
	self.viewIndex = self.viewIndex + 1

	if subViewDict[self.viewIndex] then
		self:openSubPopupView(self.viewIndex)
	else
		self:closeThis()
	end
end

function TurnbackPopupBeginnerView:_editableInitView()
	return
end

function TurnbackPopupBeginnerView:openSubPopupView(viewIndex)
	local path = self.viewContainer:getSetting().otherRes[self.viewIndex]

	if self.viewObjDict[path] then
		gohelper.setActive(self.viewObjDict[path], true)
	end

	local param = {}

	param.callbackObject = self
	param.closeCallback = self._btncloseOnClick

	self:openExclusiveView(nil, viewIndex, subViewDict[viewIndex], self.viewObjDict[path] or path, self._gosubview, param)
end

function TurnbackPopupBeginnerView:onUpdateParam()
	return
end

function TurnbackPopupBeginnerView:onOpen()
	self.viewObjDict = self:getUserDataTb_()

	self:com_loadListAsset(self.viewContainer:getSetting().otherRes, self._assetLoaded, self.onLoadFinish)
end

function TurnbackPopupBeginnerView:_assetLoaded(assetItem)
	local tarPrefab = assetItem:GetResource()
	local cloneObj = gohelper.clone(tarPrefab, self.viewGO)

	gohelper.setActive(cloneObj, false)

	self.viewObjDict[assetItem.ResPath] = cloneObj
end

function TurnbackPopupBeginnerView:onLoadFinish()
	self.viewIndex = 1

	self:openSubPopupView(self.viewIndex)
end

function TurnbackPopupBeginnerView:onClose()
	return
end

function TurnbackPopupBeginnerView:onDestroyView()
	return
end

return TurnbackPopupBeginnerView
