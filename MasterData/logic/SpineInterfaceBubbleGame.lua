-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/SpineInterfaceBubbleGame.lua

module("logic.extensions.bag.view.SpineInterfaceBubbleGame", package.seeall)

local SpineInterfaceBubbleGame = class("SpineInterfaceBubbleGame", ViewComponent)
local MotionAnimParamList = {
	{
		animName = "7",
		isFadeOut = false,
		isLastFrameHold = true,
		trackIndex = 1
	},
	{
		animName = "8",
		isFadeOut = false,
		isLastFrameHold = true,
		trackIndex = 1
	},
	{
		animName = "9",
		isFadeOut = false,
		isLastFrameHold = false,
		trackIndex = 1
	}
}
local IdleAnimParamList = {
	{
		animName = "7_1",
		isLoop = false,
		isFadeIn = true,
		trackIndex = 1,
		isLastFrameHold = true
	},
	{
		animName = "8_1",
		isLoop = false,
		isFadeIn = true,
		trackIndex = 1,
		isLastFrameHold = true
	},
	{
		animName = "idle",
		isLoop = true,
		isFadeIn = true,
		trackIndex = 0,
		isLastFrameHold = true
	}
}

function SpineInterfaceBubbleGame:buildUI()
	SpineInterfaceBubbleGame.super.buildUI(self)

	self._bubbleView = self:getGo("bubbleView")
	self._bubbleCell = self:getGo("bubbleCell")
	self._grayMask = self:getGo("grayMask")
	self._effView = self:getGo("effView")
	self._con = self:getGo("fullScreenAnimRoot/con")
	self._fullScreenAnimRoot = self:getGo("fullScreenAnimRoot")
	self._closeMask = self:getGo("fullScreenAnimRoot/closeMask")
	self._blackMask = self:getGo("fullScreenAnimRoot/blackMask")

	local rt = self._bubbleView:GetComponent("RectTransform")

	self._width = rt.rect.width
	self._height = rt.rect.height
	self._hw = self._width * 0.5
	self._hh = self._height * 0.5
	self._rigidBodyRt = self:getGo("bubbleCell/rigidBody"):GetComponent("RectTransform")

	local rWidth = self._rigidBodyRt.rect.width
	local rHeight = self._rigidBodyRt.rect.height

	self._diagonalLength = math.sqrt(rWidth * rWidth + rHeight * rHeight)
	self._radius = self._diagonalLength / 2
	self._rr = 4 * self._radius * self._radius
	self._speed = 2.5

	GameUtil.SetActive(self._bubbleCell, false)
end

function SpineInterfaceBubbleGame:bindEvents()
	SpineInterfaceBubbleGame.super.bindEvents(self)
	GameUtil.addClickHandler(self._grayMask, GameUtil.handler(self._onClikGrayMask, self))
	GameUtil.addClickHandler(self._closeMask, GameUtil.handler(self._onClikCloseMask, self))
end

function SpineInterfaceBubbleGame:unbindEvents()
	SpineInterfaceBubbleGame.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._grayMask)
	GameUtil.rmClickHandler(self._closeMask)
end

function SpineInterfaceBubbleGame:onEnter()
	SpineInterfaceBubbleGame.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._spineInterfaceComp = params[1]
	self._faceSkinId = self._spineInterfaceComp:getSkinId()

	if self._spineInterfaceComp == nil or self._faceSkinId <= 0 then
		printError("交互错误，请检查")
		self:close()

		return
	end

	self._bubbleCount = 4
	self._bubbleCellList = {}
	self._shootQueue = {}
	self._isRuningGame = false

	GameUtil.SetActive(self._grayMask, false)
	GameUtil.SetActive(self._fullScreenAnimRoot, false)

	for idx = 1, self._bubbleView.transform.childCount do
		local mainGo = self._bubbleView.transform:GetChild(idx - 1).gameObject

		GameUtil.SetActive(mainGo, false)
	end

	local childCount = self._bubbleView.transform.childCount

	for idx = 1, self._bubbleCount do
		local mainGo

		table.insert(self._bubbleCellList, idx <= childCount and self._bubbleView.transform:GetChild(idx - 1).gameObject or goutil.cloneAndSetParent(self._bubbleCell, self._bubbleView.transform, self._bubbleCell.name .. idx))
	end

	self.addGEvent(self, MsEnum.Notify_BubblegamePlayStart, self._playGame, self)
	self:_startAnim()
end

function SpineInterfaceBubbleGame:onExit()
	SpineInterfaceBubbleGame.super.onExit(self)
	removetimer(self._setActiveBlackMaskFalse, self)
	self:_endAnim()
	self._spineInterfaceComp:setHostSuspended(false)

	for idx = 1, self._bubbleView.transform.childCount do
		local mainGo = self._bubbleView.transform:GetChild(idx - 1).gameObject
		local iconGo = goutil.findChild(mainGo, "icon")

		GameUtil.rmClickHandler(iconGo)
	end
end

function SpineInterfaceBubbleGame:_startAnim()
	self._spineInterfaceComp:notifyInteraction(MsEnum.Interaction_BubbleGame_Enter)
end

function SpineInterfaceBubbleGame:_playGame()
	self:_endAnim()

	self._curTime = 0
	self._totalTime = 60

	local shootDuration = 1.3

	self._isRuningGame = true

	for idx, mainGo in ipairs(self._bubbleCellList) do
		local info = {}

		info._mainGo = mainGo
		info._shootTime = shootDuration * (idx - 1)
		info._iconGo = goutil.findChild(mainGo, "icon")
		info._effRoot = goutil.findChild(mainGo, "icon/effRoot")
		info.x = math.random(0, self._width)
		info.y = math.random(0, self._height)
		info.vx = (math.random() * 2 - 1) * self._speed
		info.vy = (math.random() * 2 - 1) * self._speed
		info.isActive = true

		table.insert(self._shootQueue, info)

		local effPath = "20250725/paopao/fx_ui_paopao.prefab"

		self:playViewEffectUniGo(effPath, info._effRoot, nil, true, nil, nil)
		GameUtil.addClickHandler(info._iconGo, GameUtil.handler(self._onClikBubbleExt, self, info))
	end

	GameUtil.SetActive(self._grayMask, true)
	GameUtil.SetActive(self._fullScreenAnimRoot, false)
	removetimer(self._onTicking, self)
	settimer(0, self._onTicking, self, true)
end

function SpineInterfaceBubbleGame:_endAnim()
	self._isRuningGame = false

	removetimer(self._onTicking, self)
	table.clear(self._shootQueue)

	for _, mainGo in ipairs(self._bubbleCellList) do
		GameUtil.SetActive(mainGo, false)
	end

	GameUtil.SetActive(self._grayMask, false)
	self:_unloadSpine()
end

function SpineInterfaceBubbleGame:checkCollision(circleA, circleB)
	local dx = circleA.x - circleB.x
	local dy = circleA.y - circleB.y
	local distanceQ = dx * dx + dy * dy

	return distanceQ < self._rr, distanceQ
end

function SpineInterfaceBubbleGame:resolveCollision(circleA, circleB, distanceQ)
	local dx = circleA.x - circleB.x
	local dy = circleA.y - circleB.y
	local distance = math.sqrt(distanceQ)

	if distance == 0 then
		distance = 1
	end

	local nx = dx / distance
	local ny = dy / distance
	local dvx = circleA.vx - circleB.vx
	local dvy = circleA.vy - circleB.vy
	local dotProduct = dvx * nx + dvy * ny

	if dotProduct > 0 then
		return
	end

	circleA.vx = circleA.vx - dotProduct * nx
	circleA.vy = circleA.vy - dotProduct * ny
	circleB.vx = circleB.vx + dotProduct * nx
	circleB.vy = circleB.vy + dotProduct * ny

	local overlap = self._diagonalLength - distance

	circleA.x = circleA.x + nx * overlap * 0.5
	circleA.y = circleA.y + ny * overlap * 0.5
	circleB.x = circleB.x - nx * overlap * 0.5
	circleB.y = circleB.y - ny * overlap * 0.5

	GameUtil.setAnchoredPos(circleA._mainGo, circleA.x - self._hw, circleA.y - self._hh)
	GameUtil.setAnchoredPos(circleB._mainGo, circleB.x - self._hw, circleB.y - self._hh)
end

function SpineInterfaceBubbleGame:_onTicking()
	if self._curTime >= self._totalTime then
		self:_playFail()

		return
	end

	for _, circle in ipairs(self._shootQueue) do
		circle.x = circle.x + circle.vx
		circle.y = circle.y + circle.vy

		if circle.x - self._radius < 0 or circle.x + self._radius > self._width then
			circle.vx = -circle.vx
			circle.x = math.max(self._radius, math.min(circle.x, self._width - self._radius))
		end

		if circle.y - self._radius < 0 or circle.y + self._radius > self._height then
			circle.vy = -circle.vy
			circle.y = math.max(self._radius, math.min(circle.y, self._height - self._radius))
		end

		GameUtil.setAnchoredPos(circle._mainGo, circle.x - self._hw, circle.y - self._hh)

		if self._curTime >= circle._shootTime and circle.isActive then
			GameUtil.SetActive(circle._mainGo, true)
		end
	end

	for i = 1, #self._shootQueue do
		local circleA = self._shootQueue[i]

		for j = i + 1, #self._shootQueue do
			local circleB = self._shootQueue[j]
			local boo, dQ = self:checkCollision(circleA, circleB)

			if boo then
				self:resolveCollision(circleA, circleB, dQ)
			end
		end
	end

	self._curTime = self._curTime + UnityEngine.Time.deltaTime
end

function SpineInterfaceBubbleGame:_playFail()
	self:_endAnim()
	self._spineInterfaceComp:notifyInteraction(MsEnum.Interaction_BubbleGame_Fail)
end

function SpineInterfaceBubbleGame:_playSuccess()
	self:_endAnim()

	self._isPlayingSuccessAnim = true

	GameUtil.SetActive(self._blackMask, true)

	local function callBack()
		self:_loadSpine()
	end

	self._spineInterfaceComp:playSpineAnim("7", callBack, false, true, false, true, 2, true, nil)
end

function SpineInterfaceBubbleGame:_loadSpine()
	local spineRoot = self._con
	local view = self
	local urlPath = "haibao_spine/48021_feixisi03_beibao_lihui/48021_feixisi03_beibao_lihui-ui_p.prefab"

	self._curAnimIndex = 0
	self._graphicSpineLoadHelp = self._graphicSpineLoadHelp or GraphicSpineLoadHelp.New()
	self._spineCtrl = self._graphicSpineLoadHelp:loadSpine(urlPath, spineRoot, view)

	self._graphicSpineLoadHelp:regCallBackOfSpineLoaded(function()
		GameUtil.SetActive(self._fullScreenAnimRoot, true)

		local params = {}

		params.animName = "rc"
		params.trackIndex = 1
		params.isFadeOut = false

		function params.endCallBack(isFinial, trackEntry)
			if isFinial then
				self._spineInterfaceComp:notifyInteraction(MsEnum.Interaction_BubbleGame_Success)
				self._spineInterfaceComp:setHostSuspended(true)
			end
		end

		self._spineCtrl:playAnimation(params)

		local p = {}

		p.animName = "idle"
		p.trackIndex = 0
		p.isLoop = true

		self._spineCtrl:playAnimation(p)
		settimer(0.1, self._setActiveBlackMaskFalse, self)
	end)
end

function SpineInterfaceBubbleGame:_setActiveBlackMaskFalse()
	GameUtil.SetActive(self._blackMask, false)
end

function SpineInterfaceBubbleGame:_unloadSpine()
	if self._graphicSpineLoadHelp then
		self._spineCtrl = nil

		self._graphicSpineLoadHelp:unloadSpine()
	end
end

function SpineInterfaceBubbleGame:_playNextAnim()
	self._curAnimIndex = self._curAnimIndex + 1

	local motionParam = MotionAnimParamList[self._curAnimIndex]

	if motionParam then
		local params = {}

		MmUtil.coverDictionary(params, motionParam)

		local idleParam = IdleAnimParamList[self._curAnimIndex]

		if idleParam then
			local p = {}

			MmUtil.coverDictionary(p, idleParam)

			function params.completeCallBack(isFinial, trackEntry)
				if isFinial then
					self._spineCtrl:playAnimation(p)
				end
			end
		end

		self._spineCtrl:playAnimation(params)
	else
		self._isPlayingSuccessAnim = false

		self._spineInterfaceComp:setHostSuspended(false)

		local params = {}

		params.animName = "tc"
		params.trackIndex = 1
		params.isFadeOut = false

		function params.completeCallBack(isFinial, trackEntry)
			if isFinial then
				GameUtil.SetActive(self._fullScreenAnimRoot, false)
				self:_unloadSpine()
			end
		end

		self._spineCtrl:playAnimation(params)
	end
end

function SpineInterfaceBubbleGame:_onClikBubbleExt(circle)
	if not self._isRuningGame then
		return
	end

	if circle.isActive then
		circle.isActive = false

		GameUtil.SetActive(circle._mainGo, false)
		self:stopViewEffectUniGo(circle._effRoot)

		local effPath = "20250725/paopao/fx_ui_paopao_po.prefab"

		local function loadedHandler(handlerTarget, eff)
			local x, y, z = Framework.TransformUtil.GetPos(circle._mainGo.transform, 0, 0, 0)

			GameUtil.setPos(eff.effGo, x, y, z)
		end

		self:playViewEffectUniGo(effPath, self._effView, nil, false, nil, loadedHandler)
	end

	local isAllNotLight = true

	for _, info in pairs(self._shootQueue) do
		if info.isActive then
			isAllNotLight = false

			break
		end
	end

	if isAllNotLight then
		self:_playSuccess()
	end
end

function SpineInterfaceBubbleGame:_onClikGrayMask()
	if self._isRuningGame then
		self:_playFail()
	end
end

function SpineInterfaceBubbleGame:_onClikCloseMask()
	if not self._isPlayingSuccessAnim then
		return
	end

	self:_playNextAnim()
end

return SpineInterfaceBubbleGame
