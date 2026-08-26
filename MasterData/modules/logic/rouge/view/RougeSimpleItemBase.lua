-- chunkname: @modules/logic/rouge/view/RougeSimpleItemBase.lua

module("modules.logic.rouge.view.RougeSimpleItemBase", package.seeall)

local RougeSimpleItemBase = class("RougeSimpleItemBase", ListScrollCellExtend)
local table_insert = table.insert
local UGUIHelper = ZProj.UGUIHelper
local CSRectTrHelper = SLFramework.UGUI.RectTrHelper

function RougeSimpleItemBase:ctor(ctorParam)
	RougeSimpleItemBase.super.ctor(self, ctorParam)

	self._staticData = {}

	if ctorParam then
		self._staticData.baseViewContainer = ctorParam.baseViewContainer
		self._staticData.parent = ctorParam.parent
	end
end

function RougeSimpleItemBase:init(...)
	RougeSimpleItemBase.super.init(self, ...)
	self:addEventListeners()
end

function RougeSimpleItemBase:onInitView()
	self:_editableInitView()
end

function RougeSimpleItemBase:onUpdateMO(mo)
	self:setData(mo)
end

function RougeSimpleItemBase:parent()
	return self._staticData.parent
end

function RougeSimpleItemBase:baseViewContainer()
	return self._staticData.baseViewContainer
end

function RougeSimpleItemBase:_assetGetViewContainer()
	return assert(self:baseViewContainer(), "please assign baseViewContainer by ctorParam on ctor")
end

function RougeSimpleItemBase:_assetGetParent()
	return assert(self:parent(), "please assign parent by ctorParam on ctor")
end

function RougeSimpleItemBase:regEvent(evtId, cb, cbObj)
	if not self._parent then
		logWarn("regEvent")

		return
	end

	local c = self:_assetGetViewContainer()

	c:registerCallback(evtId, cb, cbObj)
end

function RougeSimpleItemBase:unregEvent(evtId, cb, cbObj)
	if not self._parent then
		logWarn("unregEvent")

		return
	end

	local c = self:_assetGetViewContainer()

	c:unregisterCallback(evtId, cb, cbObj)
end

function RougeSimpleItemBase:dispatchEvent(evtName, ...)
	local c = self:baseViewContainer()

	if not c then
		return
	end

	c:dispatchEvent(evtName, ...)
end

function RougeSimpleItemBase:isSelected()
	return self._staticData.isSelected
end

function RougeSimpleItemBase:setSelected(isSelect)
	if self:isSelected() == isSelect then
		return
	end

	self:onSelect(isSelect)
end

function RougeSimpleItemBase:setIndex(index)
	self._index = index
end

function RougeSimpleItemBase:index()
	return self._index
end

function RougeSimpleItemBase:setName(name)
	self.viewGO.name = name
end

function RougeSimpleItemBase:name()
	return self.viewGO.name
end

function RougeSimpleItemBase:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

function RougeSimpleItemBase:setActive01(isActive, targetTransform)
	GameUtil.setActive01(targetTransform or self._trans, isActive)
end

function RougeSimpleItemBase:posX()
	return recthelper.getAnchorX(self._trans)
end

function RougeSimpleItemBase:posY()
	return recthelper.getAnchorY(self._trans)
end

function RougeSimpleItemBase:posXY()
	return recthelper.getAnchor(self._trans)
end

function RougeSimpleItemBase:WPos()
	return self._trans.position
end

function RougeSimpleItemBase:setWPos(newWPos)
	self._trans.position = newWPos
end

function RougeSimpleItemBase:setAPos(newAPosX, newAPosY, targetTransform)
	recthelper.setAnchor(targetTransform or self._trans, newAPosX, newAPosY)
end

function RougeSimpleItemBase:zeroPos()
	self:setLocalPosXY(0, 0)
end

function RougeSimpleItemBase:uiPosToScreenPos2(targetTransform)
	return recthelper.uiPosToScreenPos2(targetTransform or self._trans)
end

function RougeSimpleItemBase:screenPosToLocal(screenPosX, screenPosY, targetTransform)
	targetTransform = targetTransform or self._trans

	return (CSRectTrHelper.ScreenPosToAnchorPos(Vector2.New(screenPosX, screenPosY), targetTransform.parent, CameraMgr.instance:getUICamera()))
end

function RougeSimpleItemBase:setPosByScreenPos(screenPosX, screenPosY, targetTransform)
	local localPosV2 = self:screenPosToLocal(screenPosX, screenPosY, targetTransform)

	self:setLocalPosXY(localPosV2.x, localPosV2.y, targetTransform)
end

function RougeSimpleItemBase:setDock(targetRectTrans, eDock, curRectTrans, ...)
	UIDockingHelper.setDock(eDock, curRectTrans or self._trans, targetRectTrans, ...)
end

function RougeSimpleItemBase:logicParentTrans()
	local p = self:parent()

	return p:transform()
end

function RougeSimpleItemBase:transform()
	return self._trans
end

function RougeSimpleItemBase:pivot()
	return self._trans.pivot
end

function RougeSimpleItemBase:setPivot(newPivot)
	self._trans.pivot = newPivot
end

function RougeSimpleItemBase:rect()
	return self._trans.rect
end

function RougeSimpleItemBase:setAsLastSibling()
	self._trans:SetAsLastSibling()
end

function RougeSimpleItemBase:setAsFirstSibling()
	self._trans:SetAsFirstSibling()
end

function RougeSimpleItemBase:setSiblingIndex(index)
	self._trans:SetSiblingIndex(index)
end

function RougeSimpleItemBase:setParent(newParentTrans, worldPositionStays)
	self._trans:SetParent(newParentTrans, worldPositionStays and true or false)
end

function RougeSimpleItemBase:setParentAndResetPosZero(newParentTrans)
	self:setParent(newParentTrans)
	self:zeroPos()
end

function RougeSimpleItemBase:localRotateZ(zDegree, targetTransform)
	transformhelper.setLocalRotation(targetTransform or self._trans, 0, 0, zDegree)
end

function RougeSimpleItemBase:setLocalPosXY(x, y, targetTransform)
	transformhelper.setLocalPosXY(targetTransform or self._trans, x, y)
end

function RougeSimpleItemBase:GetComponent(csType)
	return self.viewGO:GetComponent(csType)
end

function RougeSimpleItemBase:setWH(newWidth, newHeight, targetTransform)
	recthelper.setSize(targetTransform or self._trans, newWidth, newHeight)
end

function RougeSimpleItemBase:setScale(newScaleValue, targetTransform)
	self:setScaleXYZ(newScaleValue, newScaleValue, newScaleValue, targetTransform)
end

function RougeSimpleItemBase:setScaleXYZ(newScaleX, newScaleY, newScaleZ, targetTransform)
	transformhelper.setLocalScale(targetTransform or self._trans, newScaleX or 1, newScaleY or 1, newScaleZ or 1)
end

function RougeSimpleItemBase:XYWH(targetTransform)
	local w = recthelper.getWidth(targetTransform or self._trans)
	local h = recthelper.getHeight(targetTransform or self._trans)
	local x, y = self:posXY()

	return x, y, w, h
end

function RougeSimpleItemBase:isOverlaps(lhsRectTr, rhsRectTr)
	rhsRectTr = rhsRectTr or self._trans

	if not lhsRectTr or not rhsRectTr then
		return false
	end

	return UGUIHelper.Overlaps(lhsRectTr, rhsRectTr, CameraMgr.instance:getUICamera())
end

function RougeSimpleItemBase:_onSetScrollParentGameObject(limitScrollRectCmp)
	if gohelper.isNil(limitScrollRectCmp) then
		return
	end

	local c = self:baseViewContainer()

	if not c then
		return
	end

	local go = c:getScrollViewGo()

	if gohelper.isNil(go) then
		return
	end

	limitScrollRectCmp.parentGameObject = go
end

function RougeSimpleItemBase:_fillUserDataTb(prefixStr, outGoList, outCmpList)
	local i = 1
	local cmp = self[prefixStr .. i]

	while not gohelper.isNil(cmp) do
		if outGoList then
			table_insert(outGoList, cmp.gameObject)
		end

		if outCmpList then
			table_insert(outCmpList, cmp)
		end

		i = i + 1
		cmp = self[prefixStr .. i]
	end
end

function RougeSimpleItemBase:_getRef_ctorParam()
	self.__child_ctorParam = self.__child_ctorParam or {
		parent = self,
		baseViewContainer = self:baseViewContainer()
	}

	return self.__child_ctorParam
end

function RougeSimpleItemBase:newObject(luaClass)
	if isDebugBuild then
		assert(isTypeOf(luaClass, RougeSimpleItemBase), debug.traceback())
	end

	return luaClass.New(self:_getRef_ctorParam())
end

function RougeSimpleItemBase:childCount()
	return (self._trans or nil) and (self._trans.childCount or 0)
end

function RougeSimpleItemBase:_editableInitView()
	self._trans = self.viewGO.transform
end

function RougeSimpleItemBase:setData(mo)
	self._mo = mo
end

function RougeSimpleItemBase:refresh()
	self:onUpdateMO(self._mo)
end

function RougeSimpleItemBase:onDestroyView()
	self:removeEventListeners()
	RougeSimpleItemBase.super.onDestroyView(self)
end

function RougeSimpleItemBase:setGrayscale(go, isGray)
	UGUIHelper.SetGrayscale(go, isGray)
end

return RougeSimpleItemBase
