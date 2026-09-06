-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/game/FlynuoPipe.lua

module("logic.extensions.flyingnuo.view.game.FlynuoPipe", package.seeall)

local FlynuoPipe = class("FlynuoPipe")

FlynuoPipe.ItemType = {
	HpShield = 1,
	Score = 2
}

function FlynuoPipe:ctor(go)
	self.mainGO = go
	self.transform = go.transform

	self:buildUI()
	self:onEnter()
end

function FlynuoPipe:buildUI()
	self._pipe = goutil.findChild(self.mainGO, "pipe")
	self._child1 = goutil.findChild(self._pipe, "go1")
	self._child2 = goutil.findChild(self._pipe, "go2")
	self._passTransform = self._child1.transform
	self._cornorsUp = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	self._cornorsDown = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	self._cornorsProp = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	self._propGo = goutil.findChild(self._pipe, "prop")
	self._propTr = self._propGo.transform
	self._rectTr1 = self._child1:GetComponent(goutil.Type_RectTransform)
	self._rectTr2 = self._child2:GetComponent(goutil.Type_RectTransform)

	goutil.setActive(self._propGo)
end

function FlynuoPipe:onEnter()
	self.posX = 0
	self._bounds = false
	self.id = 0
end

function FlynuoPipe:onExit()
	self:stop()
	uGuiUtil.clearImage(self._propGo)
end

function FlynuoPipe:OnDestroy()
	self:onExit()
end

function FlynuoPipe:setLocalPos(x, y)
	GameUtil.setAnchoredPos(self.mainGO, x, y)
end

function FlynuoPipe:getLocalPosX(x, y)
	local v3 = GameUtil.getLocalPos(self.mainGO)

	return v3.x
end

function FlynuoPipe:getCenterY()
	return self._centerY
end

function FlynuoPipe:move(factory, speed, centerY, sizeY)
	self._isHitProp = false
	self._factory = factory
	self._speed = speed or 80
	self._centerY = centerY

	local halfSizeY = sizeY / 2

	GameUtil.setAnchoredPos(self._child1, 0, halfSizeY)
	GameUtil.setAnchoredPos(self._child2, 0, -halfSizeY)
	GameUtil.setAnchoredPos(self._pipe, 0, centerY)

	self._bounds = self._bounds or BoundingBox2D.New()
end

function FlynuoPipe:randomItem()
	self._isHitProp = false

	local hpItemPR = FlyNuoConfig.instance:getHpItemPR()
	local hpItemOut = false
	local scoreItemOut = false
	local num = math.random(1, 100)

	if num <= hpItemPR then
		hpItemOut = true
		self._itemType = FlynuoPipe.ItemType.HpShield
		hpItemOut = FlyNuoModel.instance:checkCanAddRandomItem(1)
	end

	if not hpItemOut then
		local scoreItemPR = FlyNuoConfig.instance:getScoreItemPR()

		num = math.random(1, 100)

		if num <= scoreItemPR then
			scoreItemOut = true
			self._itemType = FlynuoPipe.ItemType.Score
			self._score = FlyNuoConfig.instance:getItemScore()
			scoreItemOut = FlyNuoModel.instance:checkCanAddRandomItem(2)
		end
	end

	self._itemOut = hpItemOut or scoreItemOut

	local resName = ""

	if hpItemOut then
		resName = "icon_hudun"
	elseif scoreItemOut then
		if self._score == 5 then
			resName = "icon_jifenyou"
		elseif self._score == 10 then
			resName = "icon_jifenyou_01"
		elseif self._score == 15 then
			resName = "icon_jifenyou_02"
		end
	end

	if resName ~= "" then
		resName = GameUrl.getItemIconUrl(resName)

		uGuiUtil.setSpriteToImage(self._propGo, nil, resName)
	end

	goutil.setActive(self._propGo, self._itemOut)
end

function FlynuoPipe:stop()
	return
end

function FlynuoPipe:recycleToFactory()
	self._itemOut = false
	self._isHitProp = false

	self._factory:recyclePipe(self)
end

function FlynuoPipe:update(deltaTime)
	self.posX = self.transform.localPosition.x - self._speed * deltaTime

	GameUtil.setLocalPos(self.mainGO, self.posX, 0)

	if self.posX <= -1000 then
		self:recycleToFactory()
	end
end

function FlynuoPipe:getHitBounds()
	self._child1.transform:GetWorldCorners(self._cornorsUp)
	self._child2.transform:GetWorldCorners(self._cornorsDown)

	return self._cornorsUp, self._cornorsDown
end

function FlynuoPipe:getPassPipePos()
	return self._passTransform.position
end

function FlynuoPipe:changeSpeed(speed)
	self._speed = speed
end

function FlynuoPipe:isItemBorn()
	return self._itemOut
end

function FlynuoPipe:getPropBound()
	self._propTr:GetWorldCorners(self._cornorsProp)

	return self._cornorsProp
end

function FlynuoPipe:getPropItemType()
	return self._itemType
end

function FlynuoPipe:getItemScore()
	return self._score
end

function FlynuoPipe:isHitProp()
	return self._isHitProp
end

function FlynuoPipe:setHitPorp(bool)
	self._isHitProp = bool

	goutil.setActive(self._propGo, false)
end

function FlynuoPipe:getRectTrs()
	return self._rectTr1, self._rectTr2
end

return FlynuoPipe
