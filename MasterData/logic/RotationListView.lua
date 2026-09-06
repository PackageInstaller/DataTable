-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rotationlist/RotationListView.lua

module("logic.extensions.rotationlist.RotationListView", package.seeall)

local RotationListView = class("RotationListView", ViewComponent)
local BgPaths = {}

BgPaths[1] = "ui/bigbg/holidaygift/board_jierilibao_01"
BgPaths[2] = "ui/bigbg/holidaygift/board_jierilibao_02"
BgPaths[3] = "ui/bigbg/holidaygift/board_jierilibao_03"
BgPaths[4] = "ui/bigbg/holidaygift/board_jierilibao_04"
BgPaths[5] = "ui/bigbg/holidaygift/board_jierilibao_05"
BgPaths[6] = "ui/bigbg/holidaygift/board_jierilibao_06"
BgPaths[7] = "ui/bigbg/holidaygift/board_jierilibao_07"
BgPaths[8] = "ui/bigbg/holidaygift/board_jierilibao_08"

function RotationListView:buildUI()
	RotationListView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._rtView = goutil.findChild(self.mainGO, "rtView")
	self._objCol = goutil.findChild(self.mainGO, "objCol")
	self._objCenter = goutil.findChild(self.mainGO, "objCol/center")
	self._objView = goutil.findChild(self.mainGO, "objCol/objView")
	self._objCell = goutil.findChild(self.mainGO, "objCol/objCell")
	self._dragPlane = goutil.findChild(self.mainGO, "objCol/dragPlane")

	GameUtil.SetActive(self._objCell, false)
end

function RotationListView:bindEvents()
	RotationListView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	local triggerGo = self._dragPlane

	self._beginDragHandler = BeginDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragHandler(_go, eventData)
	end)
	self._endDragHandler = EndDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onEndDragHandler(_go, eventData)
	end)
	self._dragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onDragHandler(_go, eventData)
	end)
	self._pointerDownHandler = PointerDownHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onPointerDownHandler(_go, eventData)
	end)
	self._pointerUpHandler = PointerUpHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onPointerUpHandler(_go, eventData)
	end)
end

function RotationListView:unbindEvents()
	RotationListView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	local triggerGo = self._dragPlane

	BeginDragHandler.Get(triggerGo):RemoveLuaHandler(self._beginDragHandler)
	EndDragHandler.Get(triggerGo):RemoveLuaHandler(self._endDragHandler)
	DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
	PointerDownHandler.Get(triggerGo):RemoveLuaHandler(self._pointerDownHandler)
	PointerUpHandler.Get(triggerGo):RemoveLuaHandler(self._pointerUpHandler)
end

function RotationListView:onEnter()
	RotationListView.super.onEnter(self)

	local parentTran = self._objView.transform
	local childGo = self._objCell
	local children = GameUtil.getChildren(parentTran)

	for idx = #BgPaths, #children do
		local mainGo = children[idx]

		if mainGo then
			GameUtil.SetActive(mainGo, false)
		end
	end

	for idx, bgPath in ipairs(BgPaths) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
		end

		GameUtil.SetActive(mainGo, true)
		self:_updateObjCell(mainGo, bgPath)
	end

	local objList = GameUtil.getChildren(parentTran)

	self._rotationListComp = self._rotationListComp or RotationListComp.New()
	self._pathMo = self._pathMo or RotEllipticPathMo.New()

	self._pathMo:onLoad(300, 400, 3)
	self._rotationListComp:onEnter(self._objCol, self._objCenter, self._rtView)

	local objCount = #objList
	local stepCount = self._pathMo:getPointCount()
	local stepList = {}

	for i = 1, objCount do
		stepList[i] = checkint(stepCount / objCount * (i - 1))
	end

	local stepDelta = 1

	self._rotationListComp:onLoad(objList, self._pathMo, stepList, stepDelta)
end

function RotationListView:onExit()
	RotationListView.super.onExit(self)
	self._rotationListComp:onExit()

	local parentTran = self._objView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in ipairs(children) do
		self:_clearObjCell(mainGo)
	end
end

function RotationListView:_updateObjCell(mainGo, bgPath)
	local imgBg = goutil.findChild(mainGo, "imgBg")

	self:_loadBigBg(imgBg, bgPath, true)
end

function RotationListView:_clearObjCell(mainGo)
	local imgBg = goutil.findChild(mainGo, "imgBg")

	self:_unLoadBigBg(imgBg)
end

function RotationListView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function RotationListView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function RotationListView:_onBeginDragHandler(go, eventData)
	printError("xxxxxx")

	self._anchorStepValue = 0
	self._totalAnchorStepValue = 0
	self._startPosition = eventData.position
	self._lastPosition = eventData.position
	self._beginDragTime = Time.unscaledTime
end

function RotationListView:_onEndDragHandler(go, eventData)
	printError("xxxxxx")

	self._endDragTime = Time.unscaledTime
	self._endPosition = eventData.position

	local time = self._endDragTime - self._beginDragTime
	local distance = Vector2.Distance(self._startPosition, self._endPosition)
	local speed = distance / time

	if self._endPosition.x < self._startPosition.x then
		speed = -speed
	end

	self._rotationListComp:setCurStepDelta(self._totalAnchorStepValue * speed / 10000)
end

function RotationListView:_onDragHandler(go, eventData)
	printError("xxxxxx")

	self._anchorStepValue = 0.5 * (eventData.position - self._lastPosition).x
	self._totalAnchorStepValue = self._totalAnchorStepValue + self._anchorStepValue
	self._lastPosition = eventData.position

	self._rotationListComp:setAnchorStep(self._anchorStepValue)
end

function RotationListView:_onPointerDownHandler(go, eventData)
	printError("xxxxxx")
	self._rotationListComp:setContinueRotation(false)
end

function RotationListView:_onPointerUpHandler(go, eventData)
	printError("xxxxxx")
	self._rotationListComp:setContinueRotation(true)
end

return RotationListView
