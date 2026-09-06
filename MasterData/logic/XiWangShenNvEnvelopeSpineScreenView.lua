-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/view/xiwangshennv/XiWangShenNvEnvelopeSpineScreenView.lua

module("logic.extensions.spineinterface.view.XiWangShenNvEnvelopeSpineScreenView", package.seeall)

local XiWangShenNvEnvelopeSpineScreenView = class("XiWangShenNvEnvelopeSpineScreenView", ViewComponent)

function XiWangShenNvEnvelopeSpineScreenView:buildUI()
	XiWangShenNvEnvelopeSpineScreenView.super.buildUI(self)

	self._maobiView = self:getGo("maobiView")
	self._maobiViewTran = self._maobiView:GetComponent(goutil.Type_RectTransform)
	self._effRoot = self:getGo("maobiView/effRoot")
	self._triggerPlane = self:getGo("maobiView/triggerPlane")
	self._pencilGo = self:getGo("maobiView/pencilGo")
	self._boardBound = self:getGo("maobiView/boardBound")
	self._ranshaoEffRoot = self:getGo("maobiView/ranshaoEffRoot")
	self._yanwuEffRoot = self:getGo("maobiView/yanwuEffRoot")
	self._xinfengRoot = self:getGo("maobiView/xinfengRoot")

	local boundTran = self._boardBound:GetComponent(goutil.Type_RectTransform)

	self._boundTran = boundTran

	local boundPos = GameUtil.getLocalPos(self._maobiViewTran)
	local widthDiff, heightDiff = GameUtil.getWidth(self._boardBound) / 2, GameUtil.getHeight(self._boardBound) / 2

	self._boundPolygonPoints = {
		Vector2.New(boundTran.rect.xMin, boundTran.rect.yMin),
		Vector2.New(boundTran.rect.xMax, boundTran.rect.yMin),
		Vector2.New(boundTran.rect.xMax, boundTran.rect.yMax),
		Vector2.New(boundTran.rect.xMin, boundTran.rect.yMax)
	}
	self._pencilPoint = Vector2.New(0, 0)
	self._btnClose = self:getGo("interface/btnClose")
	self._interfaceRoot = self:getGo("interface/interfaceRoot")
	self._spineInterface = self:getGo("interface/spineInterface")
	self._interface = self:getGo("interface")
end

function XiWangShenNvEnvelopeSpineScreenView:bindEvents()
	XiWangShenNvEnvelopeSpineScreenView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self._onClikClose, self))

	local triggerGo = self._triggerPlane

	self._pointerDownHandler = PointerDownHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onPointerDownHandler(_go, eventData)
	end)
	self._pointerUpHandler = PointerUpHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onPointerUpHandler(_go, eventData)
	end)
	self._beginDragHandler = BeginDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragHandler(_go, eventData)
	end)
	self._endDragHandler = EndDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onEndDragHandler(_go, eventData)
	end)
	self._dragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onDragHandler(_go, eventData)
	end)
end

function XiWangShenNvEnvelopeSpineScreenView:unbindEvents()
	XiWangShenNvEnvelopeSpineScreenView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	local triggerGo = self._triggerPlane

	self._pointerDownHandler = PointerDownHandler.Get(triggerGo):RemoveLuaHandler(self._pointerDownHandler)
	self._pointerUpHandler = PointerUpHandler.Get(triggerGo):RemoveLuaHandler(self._pointerUpHandler)
	self._beginDragHandler = BeginDragHandler.Get(triggerGo):RemoveLuaHandler(self._beginDragHandler)
	self._endDragHandler = EndDragHandler.Get(triggerGo):RemoveLuaHandler(self._endDragHandler)
	self._dragHandler = DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
end

function XiWangShenNvEnvelopeSpineScreenView:onEnter()
	XiWangShenNvEnvelopeSpineScreenView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._spineInterfaceComp = params[1]
	self._screenSkinId = checknumber(params[2])
	self._faceSkinId = self._spineInterfaceComp:getSkinId()

	self.addGEvent(self, "commonpopspinescreenclose", self._commoPopSpineScreenClose, self)
	GameUtil.SetActive(self._interface, false)
	GameUtil.SetActive(self._maobiView, true)

	local effPath = "20250926/lihui_shenyaoxiwang03/fx_zhi.prefab"

	self:playViewEffectUniGo(effPath, self._xinfengRoot, nil, true)
	settimer(0.4, self._startTouch, self, false)
end

function XiWangShenNvEnvelopeSpineScreenView:onExit()
	XiWangShenNvEnvelopeSpineScreenView.super.onExit(self)
	removetimer(self._startTouch, self)
	removetimer(self._startSpineScreen, self)
	self:_unloadSpine()
	self._spineInterfaceComp:setHostSuspended(false)
end

function XiWangShenNvEnvelopeSpineScreenView:destroyUI()
	XiWangShenNvEnvelopeSpineScreenView.super.destroyUI(self)
end

function XiWangShenNvEnvelopeSpineScreenView:_commoPopSpineScreenClose()
	self:_onClikClose()
end

function XiWangShenNvEnvelopeSpineScreenView:_startTouch()
	self._isTouching = true

	GameUtil.SetActive(self._triggerPlane, true)
end

function XiWangShenNvEnvelopeSpineScreenView:_finishTouch()
	self._isTouching = false

	GameUtil.SetActive(self._triggerPlane, false)

	if self._isOutBound then
		self:_playerFail()
	else
		self:_playerSuccess()
	end
end

function XiWangShenNvEnvelopeSpineScreenView:_playerSuccess()
	local effPath = "20250926/lihui_shenyaoxiwang03/fx_yanwu.prefab"

	local function finishHandle(handlerTarget, eff)
		self._spineInterfaceComp:notifyInteraction(MsEnum.Interaction_XiWangShenNvEnvelope_Success)
		self._spineInterfaceComp:setHostSuspended(true)
		GameUtil.SetActive(self._maobiView, false)
	end

	self:playViewEffectUniGo(effPath, self._yanwuEffRoot, nil, false, finishHandle)
	settimer(1.5, self._startSpineScreen, self, false)
end

function XiWangShenNvEnvelopeSpineScreenView:_startSpineScreen()
	self:stopViewEffectUniGo(self._xinfengRoot)
	self:_loadSpine()
	GameUtil.SetActive(self._interface, true)
end

function XiWangShenNvEnvelopeSpineScreenView:_playerFail()
	local effPath = "20250926/lihui_shenyaoxiwang03/fx_shaohui.prefab"

	local function finishHandle(handlerTarget, eff)
		self:_onClikClose()
		self._spineInterfaceComp:notifyInteraction(MsEnum.Interaction_XiWangShenNvEnvelope_Fail)
	end

	local function loadedHandler(handlerTarget, eff)
		self:stopViewEffectUniGo(self._xinfengRoot)
	end

	self:playViewEffectUniGo(effPath, self._ranshaoEffRoot, nil, false, finishHandle, loadedHandler)
end

function XiWangShenNvEnvelopeSpineScreenView:_onPointerDownHandler(go, eventData)
	if not self._isTouching then
		return
	end

	local localPos = goutil.screenToLocalPos(eventData.position, self._maobiViewTran)

	GameUtil.setLocalPos(self._pencilGo, localPos.x, localPos.y, 0)

	local function loadedHandler(handlerTarget, eff)
		local trs = eff.effGo:GetComponentsInChildren(typeof(UnityEngine.TrailRenderer))

		for i = 0, trs.Length - 1 do
			trs[i]:Clear()
		end

		GameUtil.SetActive(self._pencilGo, true)
	end

	self._pencilEff = self:playViewEffectUniGo("20250926/lihui_shenyaoxiwang03/fx_maobi.prefab", self._pencilGo, nil, true, nil, loadedHandler)
end

function XiWangShenNvEnvelopeSpineScreenView:_onPointerUpHandler(go, eventData)
	if not self._isTouching then
		return
	end

	GameUtil.SetActive(self._pencilGo, false)
	self:stopViewEffectUniGo(self._pencilGo)
	self:_finishTouch()
end

function XiWangShenNvEnvelopeSpineScreenView:_onBeginDragHandler(go, eventData)
	if not self._isTouching then
		return
	end

	self._isOutBound = false

	local localPos = goutil.screenToLocalPos(eventData.position, self._maobiViewTran)

	GameUtil.setLocalPos(self._pencilGo, localPos.x, localPos.y, 0)
end

function XiWangShenNvEnvelopeSpineScreenView:_onEndDragHandler(go, eventData)
	return
end

function XiWangShenNvEnvelopeSpineScreenView:_onDragHandler(go, eventData)
	if not self._isTouching then
		return
	end

	local localPos = goutil.screenToLocalPos(eventData.position, self._maobiViewTran)

	GameUtil.setLocalPos(self._pencilGo, localPos.x, localPos.y, 0)

	if not self._isOutBound then
		local localPos = goutil.screenToLocalPos(eventData.position, self._boundTran)

		self._pencilPoint:Set(localPos.x, localPos.y)

		self._isOutBound = not MmUtil.isPointInPolygon(self._boundPolygonPoints, self._pencilPoint)
	end
end

function XiWangShenNvEnvelopeSpineScreenView:_loadSpine()
	local spineRoot = self._interfaceRoot
	local view = self
	local urlPath = SpineInterfaceConfig.instance:getSpineUrl(self._screenSkinId)

	self._graphicSpineLoadHelp = self._graphicSpineLoadHelp or GraphicSpineLoadHelp.New()
	self._spineCtrl = self._graphicSpineLoadHelp:loadSpine(urlPath, spineRoot, view)

	self._graphicSpineLoadHelp:regCallBackOfSpineLoaded(function()
		self:_addSpineInterface(self._screenSkinId, self._spineCtrl:getSpineGo())
	end)
end

function XiWangShenNvEnvelopeSpineScreenView:_unloadSpine()
	self:_rmSpineInterface()

	if self._graphicSpineLoadHelp then
		self._spineCtrl = nil

		self._graphicSpineLoadHelp:unloadSpine()
	end
end

function XiWangShenNvEnvelopeSpineScreenView:_addSpineInterface(skinId, spineGo)
	local spineGoRect = spineGo:GetComponent(goutil.Type_RectTransform)

	self._spineComp = SpineInterfaceComp.reloadSpineGo(self._spineComp, self._spineInterface, skinId, spineGo, spineGoRect)
end

function XiWangShenNvEnvelopeSpineScreenView:_rmSpineInterface()
	if self._spineComp then
		self._spineComp:unload()
	end
end

function XiWangShenNvEnvelopeSpineScreenView:_onClikClose()
	self:close()
end

return XiWangShenNvEnvelopeSpineScreenView
