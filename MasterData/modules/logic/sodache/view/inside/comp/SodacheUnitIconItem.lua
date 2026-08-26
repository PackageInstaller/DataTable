-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheUnitIconItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheUnitIconItem", package.seeall)

local SodacheUnitIconItem = class("SodacheUnitIconItem", LuaCompBase)

function SodacheUnitIconItem:init(go)
	self._root = gohelper.findChild(go, "root")
	self._goarrowright = gohelper.findChild(go, "root/arrow/right")
	self._goarrowtop = gohelper.findChild(go, "root/arrow/top")
	self._goarrowleft = gohelper.findChild(go, "root/arrow/left")
	self._goarrowbottom = gohelper.findChild(go, "root/arrow/bottom")
	self._gohero = gohelper.findChild(go, "root/hero")
	self._gounitIcon = gohelper.findChild(go, "root/bubble")
	self._icon = gohelper.findChildImage(go, "root/bubble/#image_icon")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "root/#btn_click")
	self.go = go
end

function SodacheUnitIconItem:addEventListeners()
	self._btnclick:AddClickListener(self._onClickIcon, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnUnitMoveStepEnd, self._refreshIconShow, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnAddUnits, self._refreshIconShow, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnRemoveUnits, self._refreshIconShow, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnScenePropUpdate, self._refreshIconShow, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnMapSceneSizeChange, self._refreshPos, self)
end

function SodacheUnitIconItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnUnitMoveStepEnd, self._refreshIconShow, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnAddUnits, self._refreshIconShow, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnRemoveUnits, self._refreshIconShow, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnScenePropUpdate, self._refreshIconShow, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnMapSceneSizeChange, self._refreshPos, self)
end

function SodacheUnitIconItem:setNodeInfo(nodeId, nodeGo)
	self._insideMo = SodacheModel.instance:getInsideMo()
	self._hasUnit = false
	self._isNoModel = false
	self._nodeId = nodeId
	self._nodeTrans = nodeGo.transform

	self:initFollow()
	self:_refreshIconShow()
end

function SodacheUnitIconItem:_onClickIcon()
	if not self._nodeId then
		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.TweenCameraToNode, self._nodeId)
end

function SodacheUnitIconItem:_refreshIconShow()
	local unitIcon
	local isNoModel = false

	if self._insideMo.prop.status == SodacheEnum.InsideSceneStatus.Normal then
		for _, v in pairs(self._insideMo:getUnitsByNodeId(self._nodeId)) do
			local icon = v:getShowIcon()

			if not string.nilorempty(icon) then
				unitIcon = icon
				isNoModel = true

				break
			end
		end
	end

	self._hasUnit = not not unitIcon
	self._isNoModel = isNoModel

	if self._insideMo.player.locationId == self._nodeId then
		self._hasUnit = true
		self._isNoModel = false

		gohelper.setActive(self._gohero, true)
		gohelper.setActive(self._gounitIcon, false)
	elseif unitIcon then
		gohelper.setActive(self._gohero, false)
		gohelper.setActive(self._gounitIcon, true)
		UISpriteSetMgr.instance:setSodache2Sprite(self._icon, unitIcon)
	end

	gohelper.setActive(self._root, self:isShowRoot())
end

function SodacheUnitIconItem:isShowRoot()
	return (not self._isArrowShow or nil) and self._isNoModel and self._hasUnit
end

function SodacheUnitIconItem:_refreshPos()
	if self._uiFollower and self:isShowRoot() then
		self._uiFollower:ForceUpdate()
	end
end

function SodacheUnitIconItem:initFollow()
	if self._uiFollower then
		return
	end

	self._uiFollower = gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollowerInRange))

	self._uiFollower:SetBoundArrow(self._goarrowleft, self._goarrowright, self._goarrowtop, self._goarrowbottom)
	self:_onScreenResize()
	self._uiFollower:SetEnable(true)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, self._nodeTrans, 0, 0, 0, 0, 0)
end

function SodacheUnitIconItem:_onScreenResize()
	if not self._uiFollower then
		return
	end

	local root = ViewMgr.instance:getUIRoot().transform
	local screenRightX = recthelper.getWidth(root)
	local screenTopY = recthelper.getHeight(root)

	screenTopY = screenRightX / screenTopY < 1.7777777777777777 and 1080 or screenTopY

	local halfScreenWidth = screenRightX / 2
	local halfScreenHeight = screenTopY / 2

	self._uiFollower:SetRange(-halfScreenWidth + 60, halfScreenWidth - 60, -halfScreenHeight + 110, halfScreenHeight - 110)
end

function SodacheUnitIconItem:onUpdate()
	if tolua.isnull(self._nodeTrans) or not self._hasUnit then
		return
	end

	local mainCamera = CameraMgr.instance:getMainCamera()
	local screenPos = mainCamera:WorldToScreenPoint(self._nodeTrans.position)
	local isInScreen = screenPos.x > 20 and screenPos.x < UnityEngine.Screen.width - 20 and screenPos.y > 0 and screenPos.y < UnityEngine.Screen.height - 50

	if self._isArrowShow == nil or self._isArrowShow == isInScreen then
		self._isArrowShow = not isInScreen

		gohelper.setActive(self._root, self:isShowRoot())
		gohelper.setActive(self._btnclick, self._isArrowShow)
	end
end

return SodacheUnitIconItem
