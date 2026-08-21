-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/map/HouseMapPoint.lua

module("logic.extensions.house.view.map.HouseMapPoint", package.seeall)

local M = class("HouseMapPoint")

M.PosScaleMain = 6.443
M.PosScale = 6.343

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGO = self._compContainer.gameObject

	self:buildUI()
	self:bindEvents()

	self._unit = false
	self._isMainPlayer = false
	self._showHead = false
	self._isSmallMap = true
end

function M:Update()
	if self._unit then
		goutil.setActive(self._mainGO, true)
		self:_updatePos()
	else
		goutil.setActive(self._mainGO, false)
	end
end

function M:OnDestroy()
	DG.Tweening.DOTween.Kill(self._mainGO)
	self:unbindEvents()

	self._unit = false
	self._isMainPlayer = false
	self._compContainer = false
	self._mainGO = false
	self._goMainPlayer = false
	self._goPlayerSmall = false
	self._goPlayerBig = false
	self._imgHead = false
	self._showHead = false
	self._isSmallMap = true
end

function M:buildUI()
	self._goMainPlayer = goutil.findChild(self._mainGO, "type_1")
	self._goPlayerSmall = goutil.findChild(self._mainGO, "type_2")
	self._goPlayerBig = goutil.findChild(self._mainGO, "type_3")
	self._imgHead = goutil.findChildImageComponent(self._goPlayerBig, "imgHead")
	self._canvasSmall = goutil.findChildComponent(self._mainGO, "type_2", ComponentType.CanvasGroup)
	self._canvasBig = goutil.findChildComponent(self._mainGO, "type_3", ComponentType.CanvasGroup)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:init()
	self:_updateHead()
end

function M:getMainGO()
	return self._mainGO
end

function M:getPlayerUnit()
	return self._unit
end

function M:setPlayerUnit(unit)
	self._unit = unit
end

function M:setIsMainPlayer(isMainPlayer)
	self._isMainPlayer = isMainPlayer
end

function M:setHead(heroId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)

	IconLoader.setSprite(self._imgHead, IconType.Head, characterCO.modelId)
end

function M:setSmallMode(isSmallMap)
	self._isSmallMap = isSmallMap

	self:_updatePos(true)
end

function M:showHeadIcon(show, ignoreAnim)
	if self._showHead == show then
		return
	end

	self._showHead = show

	self:_showUpdateHead(ignoreAnim)
end

function M:_showUpdateHead(ignoreAnim)
	DG.Tweening.DOTween.Kill(self._mainGO)

	if ignoreAnim then
		self._canvasBig.alpha = 1
		self._canvasSmall.alpha = 1

		self:_updateHead()

		return
	end

	local fadeInCanvas = self._showHead and self._canvasBig or self._canvasSmall
	local fadeOutCanvas = self._showHead and self._canvasSmall or self._canvasBig

	fadeInCanvas.alpha = 0
	fadeOutCanvas.alpha = 1

	goutil.setActive(self._goPlayerSmall, true)
	goutil.setActive(self._goPlayerBig, true)

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:Append(fadeOutCanvas:DOFade(0, 0.5))
	sequence:Append(fadeInCanvas:DOFade(1, 0.5))
	sequence:AppendCallback(self._updateHead, self)
	sequence:SetTarget(self._mainGO)
end

function M:getPointPos()
	return Astral.TransformUtil.GetLocalPos(self._mainGO.transform, 0, 0, 0)
end

function M:getPointAngle()
	local unitRotaX, unitRotaY, unitRotaZ = Astral.TransformUtil.GetLocalRotation(self._mainGO.transform, 0, 0, 0)

	return unitRotaZ
end

function M:_updatePos(forceUpdate)
	local unitPosX, unitPosY = self._unit.navMesh:getNavMeshGoPos()
	local angle = self._unit.navMeshMover:getCurrAngle()
	local scale = self._isMainPlayer and self.PosScaleMain or self.PosScale
	local posX = unitPosX * scale
	local posY = unitPosY * scale

	if self._isMainPlayer and not self._isSmallMap then
		local radius = math.sqrt(posX * posX + posY * posY)
		local changeScale = (radius - 30) / radius

		posX = posX * changeScale
		posY = posY * changeScale
	end

	Astral.TransformUtil.SetLocalPos(self._mainGO.transform, posX, posY, 0)

	angle = self._showHead and 0 or angle

	Astral.TransformUtil.SetLocalRotation(self._mainGO.transform, 0, 0, angle)
end

function M:_updateHead()
	goutil.setActive(self._goMainPlayer, self._isMainPlayer)
	goutil.setActive(self._goPlayerSmall, not self._isMainPlayer and not self._showHead)
	goutil.setActive(self._goPlayerBig, not self._isMainPlayer and self._showHead)
end

return M
