-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rotationlist/RotationListComp.lua

module("logic.extensions.rotationlist.RotationListComp", package.seeall)

local RotationListComp = class("RotationListComp")

function RotationListComp:ctor()
	self._contentGo = nil
	self._contentGoParent = nil
	self._contentCanvas = nil
	self._centerGo = nil
	self._centerPos = nil
	self._objList = {}
	self._objHelpList = {}
	self._defStepList = {}
	self._curStepList = {}
	self._anchorStep = 0
	self._defaultStepDelta = 1
	self._curStepDelta = self._defaultStepDelta
	self._isContinueRotation = true
	self._isLoaded = false
	self._cullingLayer = PhotoCacheMgr.instance:getCullingLayer()
	self._photoRaycastComp = PhotoRaycastComp.New()
end

function RotationListComp:onEnter(contentGo, centerGo, rtView, triggerPlane)
	self._contentGo = contentGo
	self._contentCanvas = goutil.addComponentOnce(self._contentGo, ComponentType.Canvas)
	self._centerGo = centerGo

	self._photoRaycastComp:onEnter(rtView, triggerPlane)
	self._photoRaycastComp:showTarget(self._contentGo, true)

	self._contentCanvas.worldCamera = self._photoRaycastComp:getRtCamera()
end

function RotationListComp:onExit()
	self:onUnLoad()
	self._photoRaycastComp:onExit()
	self:_clearAllObjHelp()

	self._contentGo = nil
	self._contentCanvas = nil
	self._centerGo = nil
	self._centerPos = nil
end

function RotationListComp:onLoad(objList, pathMo, stepList, stepDelta)
	self:onUnLoad()
	table.insertto(self._objList, objList)

	self._pathMo = pathMo

	table.insertto(self._defStepList, stepList or {})
	table.insertto(self._curStepList, stepList or {})

	self._anchorStep = 0
	self._defaultStepDelta = stepDelta or 1
	self._curStepDelta = self._defaultStepDelta

	for _, obj in ipairs(self._objList) do
		local canvas = goutil.addComponentOnce(obj, ComponentType.Canvas)

		canvas.overrideSorting = true

		self:changeLayer(obj, self._cullingLayer)
	end

	self:setContinueRotation(true)
	self:_startTicking()

	self._isLoaded = true
end

function RotationListComp:onUnLoad()
	self._isLoaded = false

	self:_stopTicking()

	for _, obj in ipairs(self._objList) do
		self:changeLayer(obj, Framework.LayerUtil.NameToLayer(SceneLayer.UI))
	end

	self._pathMo = nil

	table.clear(self._objList)
	table.clear(self._objHelpList)
	table.clear(self._defStepList)
	table.clear(self._curStepList)
end

function RotationListComp:isLoaded()
	return self._isLoaded
end

function RotationListComp:isContinueRotation()
	return self._isContinueRotation
end

function RotationListComp:setContinueRotation(isContinue)
	self._isContinueRotation = isContinue
end

function RotationListComp:setAnchorStep(value)
	self._anchorStep = value
end

function RotationListComp:getAnchorStep()
	return self._anchorStep
end

function RotationListComp:setCurStepDelta(value)
	self._curStepDelta = value
end

function RotationListComp:getCurStepDelta()
	return self._curStepDelta
end

function RotationListComp:getDefalutStepDelta()
	return self._defaultStepDelta
end

function RotationListComp:_startTicking()
	settimer(0, self._ticking, self)
end

function RotationListComp:_stopTicking()
	removetimer(self._ticking, self)
end

function RotationListComp:_ticking()
	local curStepDelta = self._curStepDelta

	curStepDelta = self._isContinueRotation and (Mathf.Abs(self._curStepDelta - self._defaultStepDelta) <= 1 and self._defaultStepDelta or self._curStepDelta > self._defaultStepDelta and curStepDelta - 1 or curStepDelta + 1) or 0
	self._curStepDelta = curStepDelta

	local steptCount = self._pathMo:getPointCount()

	for idx = 1, #self._curStepList do
		self._curStepList[idx] = (self._curStepList[idx] + self._anchorStep + curStepDelta - 1) % steptCount + 1
	end

	self._anchorStep = 0

	for idx, obj in ipairs(self._objList) do
		local objHelp = self:_getObjHelp(idx)

		GameUtil.setLocalPos(objHelp, self._pathMo:getPointPos(self._curStepList[idx]))
		GameUtil.setPos(obj, Framework.TransformUtil.GetPos(objHelp.transform, 0, 0, 0))
	end
end

function RotationListComp:_createGo(name)
	local go = UnityEngine.GameObject.New()

	if name ~= nil then
		go.name = name
	end

	go:AddComponent(goutil.Type_RectTransform)

	go.layer = Framework.LayerUtil.NameToLayer(SceneLayer.UI3D)

	return go
end

function RotationListComp:_destroyGo(go)
	goutil.destroy(go)
end

function RotationListComp:changeLayer(mainGo, layer)
	local tran = mainGo.transform

	tran.gameObject.layer = layer

	if tran.childCount > 0 then
		for i = 0, tran.childCount - 1 do
			self:changeLayer(tran:GetChild(i), layer)
		end
	end
end

function RotationListComp:_getObjHelp(idx)
	local mainGo = self._objHelpList[idx]

	if mainGo == nil then
		local needNewCount = idx - self._centerGo.transform.childCount

		for i = 1, needNewCount do
			local go = self:_createGo(string.format("objHelp_%s", idx))

			goutil.addChildToParent(go, self._centerGo)
		end

		for i = #self._objHelpList, self._centerGo.transform.childCount - 1 do
			self._objHelpList[i + 1] = self._centerGo.transform:GetChild(i).gameObject
		end

		mainGo = self._objHelpList[idx]
	end

	return mainGo
end

function RotationListComp:_clearAllObjHelp()
	local children = GameUtil.getChildren(self._centerGo)

	for _, go in ipairs(children) do
		self:_destroyGo(go)
	end
end

function RotationListComp:addPointerClickHandler(go, handler)
	self._photoRaycastComp:addPointerClickHandler(go, handler)
end

function RotationListComp:rmPointerClickHandler(go)
	self._photoRaycastComp:rmPointerClickHandler(go)
end

return RotationListComp
