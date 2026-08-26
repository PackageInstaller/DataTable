-- chunkname: @modules/logic/versionactivity3_3/arcade/view/currency/ArcadeCurrencyView.lua

module("modules.logic.versionactivity3_3.arcade.view.currency.ArcadeCurrencyView", package.seeall)

local ArcadeCurrencyView = class("ArcadeCurrencyView", BaseView)

function ArcadeCurrencyView:ctor(currencyList, isInGame)
	self._currencyList = currencyList or {}
	self._currencyDict = {}

	for _, currencyId in ipairs(self._currencyList) do
		self._currencyDict[currencyId] = true
	end

	self._isInGame = isInGame
end

function ArcadeCurrencyView:onInitView()
	self._gotipview = gohelper.findChild(self.viewGO, "tipview")
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._image = gohelper.findChildImage(self.viewGO, "#go_item/#image")
	self._txt = gohelper.findChildText(self.viewGO, "#go_item/content/#txt")
	self._golight = gohelper.findChild(self.viewGO, "#Light")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeCurrencyView:addEvents()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnReceiveArcadeAttrChangePush, self._onOutsideArcadeAttrChangePush, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnCharacterResourceCountUpdate, self._onInSideCharacterResourceUpdate, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillResourceChange, self._onInSideSkillChangeRes, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnResetArcadeGame, self._onResetArcadeGame, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function ArcadeCurrencyView:removeEvents()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnReceiveArcadeAttrChangePush, self._onOutsideArcadeAttrChangePush, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnCharacterResourceCountUpdate, self._onInSideCharacterResourceUpdate, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillResourceChange, self._onInSideSkillChangeRes, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnResetArcadeGame, self._onResetArcadeGame, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function ArcadeCurrencyView:_onOutsideArcadeAttrChangePush()
	if self._isInGame then
		return
	end

	self:refreshView()
end

function ArcadeCurrencyView:_onInSideCharacterResourceUpdate(resId)
	if not self._isInGame then
		return
	end

	if self._currencyDict and self._currencyDict[resId] then
		self:refreshView()
	end
end

function ArcadeCurrencyView:_onInSideSkillChangeRes(entityType, uid, resId, val)
	if entityType == ArcadeGameEnum.EntityType.Character then
		self:_onInSideCharacterResourceUpdate(resId)
	end
end

function ArcadeCurrencyView:_onResetArcadeGame()
	if not self._isInGame then
		return
	end

	self:refreshView()
end

function ArcadeCurrencyView:_onCloseViewFinish(viewName)
	if viewName == ViewName.ArcadeRefundTipView then
		gohelper.setActive(self._golight, false)
		gohelper.setActive(self._golight, true)
	end
end

function ArcadeCurrencyView:_editableInitView()
	gohelper.setActive(self._goitem, false)
end

function ArcadeCurrencyView:onUpdateParam()
	return
end

function ArcadeCurrencyView:onOpen()
	self:refreshView()
end

function ArcadeCurrencyView:setCurrencyList(currencyList)
	self._currencyList = currencyList

	self:refreshView()
end

function ArcadeCurrencyView:refreshView()
	if not self._currencyList then
		return
	end

	gohelper.CreateObjList(self, self._createItemCB, self._currencyList, self._goroot, self._goitem, ArcadeCurrencyItem)
end

function ArcadeCurrencyView:_createItemCB(obj, data, index)
	obj:onUpdateMO(data, self._isInGame, self)
end

function ArcadeCurrencyView:onClose()
	return
end

function ArcadeCurrencyView:onDestroyView()
	return
end

return ArcadeCurrencyView
