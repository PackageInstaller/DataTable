-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpRoadView.lua

module("logic.extensions.jumpgame.view.JumpRoadView", package.seeall)

local JumpRoadView = class("JumpRoadView", ViewComponent)

function JumpRoadView:ctor()
	JumpRoadView.super.ctor(self)

	self._pillars = {}
end

function JumpRoadView:bindEvents()
	self._moveBy:AddListener(self._moveByFinishCallBack, self)
end

function JumpRoadView:unbindEvents()
	self._moveBy:RemoveListener()
end

function JumpRoadView:buildUI()
	self._Pnl_Road = self:getGo("Container/Pnl_Road")
	self._moveBy = self._Pnl_Road:GetComponent(UnityTweensType.TweenPositionBy)
	self._imgBg = self:getGo("Img_Bg"):GetComponent("RawImage")
end

function JumpRoadView:destroyUI()
	return
end

function JumpRoadView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.JumpViewOffset, self.moveOffset, self)

	self._gameType = ChallengeModel.instance:getCurPhase()
	self._Pnl_Road.gameObject.transform.localPosition = Vector3.New(-620, -360, 0)

	local pillar = self:getResInstance("ui/views/jumpgame/pillar.prefab")

	goutil.addChildToParent(pillar, self._Pnl_Road)
	JumpTrigger.AddOnce(pillar.gameObject)
	table.insert(self._pillars, pillar)
	self:_onGenerateRoad()
	self:_initMaterial()
end

function JumpRoadView:_initMaterial()
	return
end

function JumpRoadView:_setMaterialNil()
	goutil.destroy(self._mat)

	self._mat = nil
end

function JumpRoadView:onEnterFinished()
	return
end

function JumpRoadView:onExit()
	if self._tweener then
		self._tweener:Kill(true)

		self._tweener = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.JumpViewOffset, self.moveOffset, self)

	for i, v in ipairs(self._pillars) do
		JumpTrigger.Remove(v.gameObject)
		goutil.destroy(v.gameObject)
	end

	self._pillars = {}

	self:_setMaterialNil()
end

function JumpRoadView:onExitFinished()
	return
end

function JumpRoadView:_onPlayerMove(pos)
	local width, height = JumpGameModel.instance:getWidthAndHeight()
end

function JumpRoadView:_onGenerateRoad()
	JumpGameModel.instance:generateRoad()

	local pillarModels = JumpGameModel.instance:getWillPillars()

	pillarModels:ForEach(function(value, idx)
		local space = value:getSpace()

		JumpGameModel.instance:AddPlateFormLen(space)

		local pillar = self:getResInstance("ui/views/jumpgame/pillarnode.prefab")

		pillar.gameObject.transform.localPosition = Vector3.New(JumpGameModel.instance:getInitLen(), 0, 0)

		goutil.addChildToParent(pillar, self._Pnl_Road)

		local trigger = JumpTrigger.AddOnce(pillar.gameObject)

		trigger:setResInstance(self._viewPresentor)
		trigger:initPillarMo(value)
		trigger:initPillars()
		trigger:initItem(value:getItems(), self._gameType)
		table.insert(self._pillars, pillar)
	end)
end

function JumpRoadView:moveOffset()
	local initPlayerPos = JumpGameModel.instance:getInitPlayerPos()
	local playerPos = JumpGameModel.instance:getPlayerPos()
	local distance = playerPos.x - initPlayerPos.x

	JumpGameModel.instance:updateCameraPosX(distance)

	self._moveBy.positionBy = Vector3.New(-distance, 0, 0)

	self._moveBy:Begin()
	self:_moveBg(distance)
end

function JumpRoadView:_moveBg(distance)
	local factor = 0.8
	local offset = distance / 1958 * factor
	local uvRect = self._imgBg.uvRect
	local texOffset = Vector2.New(uvRect.x, uvRect.y)
	local size = self._imgBg.uvRect.size
	local startX = texOffset.x
	local endX = texOffset.x + offset

	local function callback(curNum)
		self._imgBg.uvRect = UnityEngine.Rect.New(curNum, texOffset.y, size.x, size.y)
	end

	if self._tweener then
		self._tweener:Kill(true)

		self._tweener = nil
	end

	self._tweener = TweenUtil.DOTweenNum(startX, endX, 1, callback, self):SetEase(DG.Tweening.Ease.Linear)
end

function JumpRoadView:_moveByFinishCallBack()
	self:_onGenerateRoad()
end

return JumpRoadView
