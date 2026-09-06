-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/effect/UIEffectManager.lua

module("logiccommon.common.UIEffectManager", package.seeall)

local UIEffectManager = class("UIEffectManager", ResObjectCache)

UIEffectManager.screenEffectLayer = nil

function UIEffectManager:ctor()
	local effResObjectCache = UnityEngine.GameObject.New("EffResObjectCache")

	UIEffectManager.super.ctor(self, effResObjectCache)

	self._effCaches = nil
	self._visible = true
	self._uiLayer = LayerMask.NameToLayer("UI")

	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewDestroy, self._onViewDestroy, self)
end

function UIEffectManager:newObject(resPath, loadedHandler, handlerTarget, resHandler)
	local unRet = true

	UIEffectManager.super.newObject(self, resPath, function(tgt, handerId, go)
		if not unRet then
			self:_onEffectResLoadedFinish(handerId, go)
		else
			self._loadedEffects = self._loadedEffects or {}
			self._loadedEffects[handerId] = go
		end
	end, self, resHandler)

	unRet = nil
end

function UIEffectManager:playEffect(view, effName, widget, ofsX, ofsY, loop, donotModifySortingLayer, finishHandler, loadedHandler, handlerTarget)
	local path = self:getEffectPath(effName)
	local eff = UIEffect.New()

	eff.effPath = path
	eff.finishHandler = finishHandler
	eff.finishHandlerTarget = handlerTarget
	eff.modifySortingOrder = not donotModifySortingLayer
	eff.loop = loop
	eff.view = view
	eff.widget = widget
	eff.parent = self._objectParent.transform

	if widget then
		eff.scrollRect = UGUIToolHelper.FindScrollRect(widget.transform)
	end

	eff.ofsX = ofsX
	eff.ofsY = ofsY
	eff.loadedHandler = loadedHandler

	if view and view.mainGO then
		eff.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(view.mainGO)
	end

	self._effCaches = self._effCaches or {}
	self._effCaches[eff.handleId] = eff

	self.newObject(self, path, self._onEffectResLoadedFinish, self, eff)

	return eff
end

function UIEffectManager:playEffectBrief(view, effName, widget, loop, loadedHandler, handlerTarget)
	local path = self:getEffectPath(effName)
	local eff = UIEffect.New()

	eff.effPath = path
	eff.finishHandler = finishHandler
	eff.finishHandlerTarget = handlerTarget
	eff.loop = loop
	eff.view = view
	eff.widget = widget
	eff.parent = self._objectParent.transform

	if widget then
		eff.scrollRect = UGUIToolHelper.FindScrollRect(widget.transform)
	end

	eff.loadedHandler = loadedHandler

	if view and view.mainGO then
		eff.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(view.mainGO)
	end

	self._effCaches = self._effCaches or {}
	self._effCaches[eff.handleId] = eff

	self.newObject(self, path, self._onEffectResLoadedFinish, self, eff)

	return eff
end

function UIEffectManager:playScreenEffect(effName, screenPos, loop, specifyTime, finishHandler, loadedHandler, handlerTarget)
	local path = self:getEffectPath(effName)
	local eff = UIScreenEffect.New()

	eff.effPath = path
	eff.sortingOrder = 3000
	eff.finishHandler = finishHandler
	eff.finishHandlerTarget = handlerTarget
	eff.loop = loop
	eff.specifyTime = specifyTime
	eff.loadedHandler = loadedHandler

	local cam = GlobalModel.instance.uiCamera
	local pos = cam:ScreenToWorldPoint(screenPos)

	eff.posX = pos.x
	eff.posY = pos.y
	eff.posZ = cam.nearClipPlane + 0.2
	eff.parent = self._objectParent.transform

	if UIEffectManager.screenEffectLayer then
		eff:setLayer(UIEffectManager.screenEffectLayer)
	end

	self._effCaches = self._effCaches or {}
	self._effCaches[eff.handleId] = eff

	self.newObject(self, path, self._onEffectResLoadedFinish, self, eff)

	return eff
end

function UIEffectManager:playEffectInWorldPos(effName, x, y, loop, specifyTime, finishHandler, loadedHandler, handlerTarget)
	local path = self:getEffectPath(effName)
	local eff = UIScreenEffect.New()

	eff.effPath = path
	eff.sortingOrder = 3000
	eff.finishHandler = finishHandler
	eff.finishHandlerTarget = handlerTarget
	eff.loop = loop
	eff.specifyTime = specifyTime
	eff.loadedHandler = loadedHandler

	local cam = GlobalModel.instance.uiCamera

	eff.posX = x
	eff.posY = y
	eff.posZ = cam.nearClipPlane + 0.2
	eff.parent = self._objectParent.transform
	self._effCaches = self._effCaches or {}
	self._effCaches[eff.handleId] = eff

	self.newObject(self, path, self._onEffectResLoadedFinish, self, eff)

	return eff
end

function UIEffectManager:playEffectInCenters(effName, loop, specifyTime, finishHandler, loadedHandler, handlerTarget)
	local path = self:getEffectPath(effName)
	local eff = UIScreenEffect.New()

	eff.effPath = path
	eff.sortingOrder = 3000
	eff.finishHandler = finishHandler
	eff.finishHandlerTarget = handlerTarget
	eff.loop = loop
	eff.specifyTime = specifyTime
	eff.loadedHandler = loadedHandler

	local cam = GlobalModel.instance.uiCamera
	local x, y, _ = Framework.TransformUtil.GetPos(GlobalModel.instance.uiRoot.transform, nil, nil, nil)

	eff.posX = x
	eff.posY = y
	eff.posZ = cam.nearClipPlane + 0.2
	eff.parent = self._objectParent.transform
	self._effCaches = self._effCaches or {}
	self._effCaches[eff.handleId] = eff

	self.newObject(self, path, self._onEffectResLoadedFinish, self, eff)

	return eff
end

function UIEffectManager:playHUDEffect(effName, hud, loop, specifyTime, finishHandler, loadedHandler, handlerTarget, keepScale)
	local path = self:getEffectPath(effName)
	local eff = UIHudEffect.New()

	eff.effPath = path
	eff.sortingOrder = -75
	eff.widget = hud
	eff.finishHandler = finishHandler
	eff.finishHandlerTarget = handlerTarget
	eff.loop = loop
	eff.specifyTime = specifyTime
	eff.loadedHandler = loadedHandler
	eff.parent = hud.transform
	eff.keepScale = keepScale
	self._effCaches = self._effCaches or {}
	self._effCaches[eff.handleId] = eff

	self.newObject(self, path, self._onEffectResLoadedFinish, self, eff)

	return eff
end

function UIEffectManager:stopEffect(handler)
	if self._effCaches and handler then
		local eff = self._effCaches[handler.handleId]

		if eff then
			eff:onEffectDestroy()

			local effGo = eff.effGo

			if not effGo and self._loadedEffects then
				effGo = self._loadedEffects[handler.handleId]
			end

			if self._loadedEffects then
				self._loadedEffects[handler.handleId] = nil
			end

			self:recycleObject(eff.effPath, effGo, eff)

			self._effCaches[handler.handleId] = nil

			self:releaseUnuseResourceByPath(eff.effPath)

			if not self:isPermanent(eff.effPath) then
				-- block empty
			end
		elseif self._loadedEffects then
			self._loadedEffects[handler.handleId] = nil
		end
	end
end

function UIEffectManager:setPermanent(resPath, permanent)
	resPath = self:getEffectPath(resPath)

	UIEffectManager.super.setPermanent(self, resPath, permanent)
end

function UIEffectManager:isPermanent(resPath)
	if self._permanentAll then
		return true
	end

	if self._permanentRes then
		return self._permanentRes[resPath]
	end
end

function UIEffectManager:setPermanentAll(permanent)
	self._permanentAll = permanent
end

function UIEffectManager:getEffectPath(effName)
	if effName ~= nil and type(effName) == "table" and #effName > 0 then
		return effName[1]
	end

	return "effect/prefabs/ui/" .. effName
end

function UIEffectManager:updateEffectPosition(eff)
	if eff.effGo then
		local scaleX, scaleY, scaleZ

		if not goutil.isNil(eff.widget) then
			scaleX, scaleY, scaleZ = Framework.TransformUtil.GetLocalScale(eff.widget.transform, nil, nil, nil)
		else
			scaleZ = 1
		end

		local x, y, z = self:getEffectPosition(eff, eff.widget, (eff.ofsX or 0) * 1, (eff.ofsY or 0) * 1)

		Framework.TransformUtil.SetPos(eff.effGo.transform, x, y, z)
	end
end

function UIEffectManager:updateEffectPositionByWidget(eff, widget)
	eff.widget = widget

	self:updateEffectPosition(eff)
end

function UIEffectManager:updateEffectScale(eff, scaleX, scaleY, scaleZ)
	local _scaleX = scaleX or 1
	local _scaleY = scaleY or 1
	local _scaleZ = scaleZ or 1

	if eff.effGo then
		local sx, sy, sz = Framework.TransformUtil.GetLocalScale(eff.widget.transform, nil, nil, nil)

		GameUtil.setLocalScale(eff.effGo.transform, sx * _scaleX, sy * _scaleY, sz * _scaleZ)
	end
end

function UIEffectManager:getEffectPosition(eff, widget, ofsX, ofsY)
	local cam = GlobalModel.instance.uiCamera

	if not goutil.isNil(widget) then
		local x, y, z = UGUIToolHelper.UGUIToUnityPositionInCenter(cam, widget:GetComponent("RectTransform"), nil, ofsX or 0, ofsY or 0, nil, nil, nil)

		return x, y, cam.nearClipPlane + 0.2
	else
		return 0, 0, cam.nearClipPlane + 0.2
	end
end

function UIEffectManager:_onEffectResLoadedFinish(handerId, go)
	local eff

	if self._effCaches then
		eff = self._effCaches[handerId]
	end

	if eff then
		eff:setEffectGo(go)

		if not eff.layer then
			eff:setLayer(self._uiLayer)
		end

		if not eff.parent then
			local parent = self._objectParent.transform

			go.transform:SetParent(parent)

			if eff.posX and eff.posY and eff.posZ then
				Framework.TransformUtil.SetPos(go.transform, eff.posX, eff.posY, eff.posZ)
			end

			if not eff.isScreenEff then
				eff:setVisible(self._visible)
			end

			go:SetActive(eff.active)
			eff:onEffectStart()

			if eff.loadedHandler then
				eff.loadedHandler(eff.finishHandlerTarget, eff)
			end
		end
	elseif go then
		UnityEngine.GameObject.Destroy(go)
	end
end

function UIEffectManager:update(deltaTime)
	if self._effCaches then
		self._tempCaches = self._tempCaches or {}

		table.clear(self._tempCaches)
		table.merge(self._tempCaches, self._effCaches)

		for k, v in pairs(self._tempCaches) do
			v:update(deltaTime)
		end
	end
end

function UIEffectManager:lateUpdate()
	if self._loadedEffects then
		self._clearEffKeys = self._clearEffKeys or {}

		for k, v in pairs(self._loadedEffects) do
			self._clearEffKeys[k] = v
		end

		table.clear(self._loadedEffects)

		for k, v in pairs(self._clearEffKeys) do
			if k and v then
				self:_onEffectResLoadedFinish(k, v)
			end
		end

		table.clear(self._clearEffKeys)
	end
end

function UIEffectManager:setVisible(visible)
	if self._visible == visible then
		return
	end

	self._visible = visible

	if self._effCaches then
		for k, v in pairs(self._effCaches) do
			v:setVisible(self._visible)
		end
	end
end

function UIEffectManager:isVisible()
	return self._visible
end

function UIEffectManager:_setViewEffectVisible(view, visible)
	return
end

function UIEffectManager:_onViewOpened(view)
	self:_adjustOnViewChange()
	self:_setViewEffectVisible(view, self._visible)
end

function UIEffectManager:_onViewClosed(view)
	self:_clearEffectOnViewClose(view)
	self:_adjustOnViewChange()
end

function UIEffectManager:_onViewDestroy(name)
	self:_clearEffectOnViewDestroy(name)
end

function UIEffectManager:_adjustOnViewChange()
	if self._effCaches then
		local topView = GlobalModel.instance:getTopView()

		if not topView then
			return
		end

		if (topView.viewName == ViewName.Story or topView.viewName == ViewName.UnlockView) and topView.fadingOut then
			return
		end

		local topNode

		if topView and topView.parentPresentor then
			topView = topView.parentPresentor
		end

		if topView then
			topNode = topView:attachToWhichRoot()
		end

		for k, v in pairs(self._effCaches) do
			if not goutil.isNil(v.effGo) and v.loop and v.view then
				local view = v.view._viewPresentor

				if view and view.parentPresentor then
					view = view.parentPresentor
				end

				if view == topView then
					v:setTop(true)
				else
					local hit
					local topGO = topView.mainGO
					local viewGO = view.mainGO

					if not goutil.isNil(viewGO) and not goutil.isNil(topGO) and (viewGO.transform:IsChildOf(topGO.transform) or topGO.transform:IsChildOf(viewGO.transform)) then
						v:setTop(true)

						hit = true
					end

					if not hit then
						local viewNode = view:attachToWhichRoot()

						if viewNode and topNode and viewNode == topNode then
							if not goutil.isNil(viewGO) and not goutil.isNil(topGO) then
								local firstIdx = viewGO.transform:GetSiblingIndex()
								local secondIdx = topGO.transform:GetSiblingIndex()

								if firstIdx < secondIdx then
									v:setTop()
								end

								if secondIdx < firstIdx then
									v:setTop(true)
								end
							else
								v:setTop(GlobalModel.isUppon(view, topView))
							end
						elseif v.hideEffWhileNotOnTop then
							if CommonTipsMgr.instance:checkShouldCloseNotTopTips(view.viewName) then
								v:setTop(false)
							else
								v:setTop(GlobalModel.isUppon(view, topView))
							end
						end
					end
				end
			end
		end
	end
end

function UIEffectManager:_clearEffectOnViewClose(view)
	if self._effCaches then
		for k, v in pairs(self._effCaches) do
			local viewPresentor

			if v.autoStopOnViewClose and ((v.view or nil) and v.view._viewPresentor) == view and not self:isPermanent(v.effPath) then
				self:stopEffect(v)
			end
		end
	end
end

function UIEffectManager:_clearEffectOnViewDestroy(name)
	if self._effCaches then
		local presentor = ViewMgr.instance:getViewPresentor(name)

		for k, v in pairs(self._effCaches) do
			local viewPresentorName

			if ((v.view and v.view._viewPresentor or nil) and v.view._viewPresentor.viewName) == name then
				self:stopEffect(v)
			elseif presentor and not goutil.isNil(presentor.mainGO) then
				local parent = v.parent

				if parent and (goutil.isNil(parent) or parent.transform:IsChildOf(presentor.mainGO.transform)) then
					self:stopEffect(v)
				end
			end
		end
	end
end

function UIEffectManager:playHudEffects(effPaths, mainGO)
	local effs = {}

	for _, effPath in ipairs(effPaths) do
		local parent = string.nilorempty(effPath.goPath) and mainGO or goutil.findChild(mainGO, effPath.goPath)
		local eff = self:playHUDEffect(effPath.path, parent, effPath.loop, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		end, nil, false)

		table.insert(effs, eff)
	end

	return effs
end

UIEffectManager.instance = UIEffectManager.New()

return UIEffectManager
