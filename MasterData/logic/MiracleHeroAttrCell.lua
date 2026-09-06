-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroAttrCell.lua

module("logic.extensions.miraclehero.view.MiracleHeroAttrCell", package.seeall)

local MiracleHeroAttrCell = class("MiracleHeroAttrCell")

function MiracleHeroAttrCell:ctor(componetContainer)
	self._container = componetContainer
	self._x_space = 60
	self._y_space = 60
	self._x_spacing = 0
	self._y_spacing = 16
	self._moveList = Array.New()
end

function MiracleHeroAttrCell:initCell(view, mo)
	self.data = mo
	self._view = view

	self:onBuildUI()
	self:onBuildEvent()

	local raceTypeCfg = MiracleHeroConfig.instance:getRaceType(self.data.type)

	self._typeChange:SetState(self.data.type - 1)
	self._moveList:Clear()
end

function MiracleHeroAttrCell:resetData(go, mo)
	self.data = mo

	local raceTypeCfg = MiracleHeroConfig.instance:getRaceType(self.data.type)

	self._typeChange:SetState(self.data.type - 1)
	self._moveList:Clear()
	self:setSelect(false)

	self._container = go
end

function MiracleHeroAttrCell:onBuildUI()
	self._typeChange = goutil.findChildComponent(self._container.gameObject, "imgAttr", "UIImageSpriteChange")
	self._select = goutil.findChild(self._container, "imgSelect")
	self._moveBy = self._container:GetComponent(UnityTweensType.TweenPositionBy)
	self._fadeOut = self._container:GetComponent(UnityTweensType.UITweenFadeOut)
end

function MiracleHeroAttrCell:onBuildAction(moveByFunc)
	self._moveList:Clear()

	self._moveByFunc = moveByFunc

	local dir = Vector3.New(-self._container.transform.localPosition.x + (self._y_space + self._y_spacing) * (self.data.y - 1), 0, 0)

	if self._moveList:IsEmpty() then
		self._moveBy.positionBy = dir
	end

	self._moveList:PushBack(dir)
	self._moveBy:Begin()
end

function MiracleHeroAttrCell:onBuildEvent()
	self._moveBy:AddListener(self._moveByFinishCallBack, self)
	self._fadeOut:AddListener(self._fadeOutFinishCallBack, self)
end

function MiracleHeroAttrCell:setSelect(bool)
	if bool == true and not self._selectEffect then
		local selectEfectPath = "fx_ui_shouchong/fx_ui_leichong_shouchong.prefab"

		self._selectEffect = UIEffectManager.instance:playEffect(self._view, selectEfectPath, nil, 0, 0, true)

		self._selectEffect:setParent(self._select.transform)
		self._selectEffect:setLocalPos(0, 0, 0)
		self._selectEffect:setScale(0.7)
	end

	GameUtil.SetActive(self._select, bool)
end

function MiracleHeroAttrCell:checkHit(pos)
	if goutil.isNil(self._container) == true then
		return false
	end

	local selfPos = GameUtil.getLocalPos(self._container.gameObject)

	if pos.x > selfPos.x and pos.x < selfPos.x + self._x_space and pos.y > selfPos.y and pos.y < selfPos.y + self._y_space then
		return true
	else
		return false
	end
end

function MiracleHeroAttrCell:checkHitAABB(posA, posB)
	if goutil.isNil(self._container) == true then
		return false
	end

	local maxX, minX = posA.x, posB.x

	if maxX < minX then
		minX = posA.x
		maxX = posB.x
	end

	local maxY, minY = posA.y, posB.y

	if maxY < minY then
		minY = posA.y
		maxY = posB.y
	end

	local selfPos = GameUtil.getLocalPos(self._container.gameObject)

	if minX > selfPos.x + self._x_space or maxX < selfPos.x then
		return false
	end

	if minY > selfPos.y + self._y_space or maxY < selfPos.y then
		return false
	end

	return true
end

function MiracleHeroAttrCell:onChangePos(x, y, moveByFunc)
	self._moveByFunc = moveByFunc
	self._container.name = tostring(y * 10 + x)

	local dir = Vector3.New((self._y_space + self._y_spacing) * (y - self.data.y), (self._x_space + self._x_spacing) * (x - self.data.x), 0)

	if self._moveList:IsEmpty() then
		self._moveBy.positionBy = dir
	end

	self._moveList:PushBack(dir)
	self._moveBy:Begin()
end

function MiracleHeroAttrCell:onRemove(removeFunc)
	self._removeFunc = removeFunc

	self:setSelect(false)
	self._fadeOut:Begin()

	if self._fadeOutTag == false then
		self._fadeOutTag = true
	end
end

function MiracleHeroAttrCell:getDistanceFromPos(pos)
	local selfPos = GameUtil.getLocalPos(self._container.gameObject)
	local dx = selfPos.x + self._x_space / 2 - pos.x
	local dy = selfPos.y + self._y_space / 2 - pos.y

	return dx * dx + dy * dy
end

function MiracleHeroAttrCell:_moveByFinishCallBack()
	self._moveList:PopFront()

	if not self._moveList:IsEmpty() then
		self._moveBy.positionBy = self._moveList:Get(0)

		self._moveBy:Begin()
	end

	if self._moveByFunc and self._moveList:IsEmpty() then
		self._moveByFunc()
	end
end

function MiracleHeroAttrCell:_fadeOutFinishCallBack()
	if self._removeFunc then
		self:_removeFunc()
	end

	self:setSelect(false)

	self._fadeOutTag = false

	if self._container and not goutil.isNil(self._container) then
		self._container.gameObject:SetActive(false)
	end
end

function MiracleHeroAttrCell:onDestroy()
	if self._selectEffect then
		UIEffectManager.instance:stopEffect(self._selectEffect)

		self._selectEffect = nil
	end

	goutil.destroy(self._container.gameObject)
end

function MiracleHeroAttrCell:getType()
	return self.data.type
end

function MiracleHeroAttrCell:getObj()
	return self._container.gameObject
end

return MiracleHeroAttrCell
