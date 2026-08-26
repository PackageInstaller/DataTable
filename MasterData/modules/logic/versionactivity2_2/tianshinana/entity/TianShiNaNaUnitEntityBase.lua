-- chunkname: @modules/logic/versionactivity2_2/tianshinana/entity/TianShiNaNaUnitEntityBase.lua

module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaUnitEntityBase", package.seeall)

local TianShiNaNaUnitEntityBase = class("TianShiNaNaUnitEntityBase", LuaCompBase)

function TianShiNaNaUnitEntityBase:init(go)
	self.go = go
	self.trans = go.transform
end

function TianShiNaNaUnitEntityBase:updateMo(unitMo)
	self._unitMo = unitMo

	if not string.nilorempty(unitMo.co.unitPath) and not self._loader then
		self._loader = PrefabInstantiate.Create(self.go)

		self._loader:startLoad(unitMo.co.unitPath, self._onResLoaded, self)
	end

	local pos = TianShiNaNaHelper.nodeToV3(unitMo)

	transformhelper.setLocalPos(self.trans, pos.x, pos.y, pos.z)
end

function TianShiNaNaUnitEntityBase:updatePosAndDir()
	self:_killTween()

	local pos = TianShiNaNaHelper.nodeToV3(self._unitMo)

	transformhelper.setLocalPos(self.trans, pos.x, pos.y, pos.z)
	self:setDir()
	self:updateSortOrder()
end

function TianShiNaNaUnitEntityBase:getWorldPos()
	local x, y, z = transformhelper.getPos(self.trans)

	return TianShiNaNaHelper.getV3(x, y, z)
end

function TianShiNaNaUnitEntityBase:getLocalPos()
	local x, y, z = transformhelper.getLocalPos(self.trans)

	return TianShiNaNaHelper.getV3(x, y, z)
end

function TianShiNaNaUnitEntityBase:moveTo(x, y, dir, callback, callbackObj)
	if x == self._unitMo.x and y == self._unitMo.y then
		if dir ~= self._unitMo.dir then
			self._unitMo.dir = dir

			self:setDir()
		end

		callback(callbackObj)

		return
	end

	local preX = self._unitMo.x
	local preY = self._unitMo.y

	self._unitMo.x = x
	self._unitMo.y = y
	self._unitMo.dir = dir
	self._moveEndCall = callback
	self._moveEndCallObj = callbackObj

	self:setDir()

	if self._isMoveHalf then
		self._isMoveHalf = false

		self:_killTween()
		self:_onEndMoveHalf()
	else
		local halfPos = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2((x + preX) / 2, (y + preY) / 2))

		self:_beginMoveHalf(halfPos)
	end
end

function TianShiNaNaUnitEntityBase:moveToHalf(x, y, callback, callbackObj)
	if self._unitMo:isPosEqual(x, y) then
		callback(callbackObj)

		return
	end

	self._isMoveHalf = true

	local targetPos = TianShiNaNaHelper.getV2(x, y)

	self:changeDir(x, y)

	self._moveEndCall = callback
	self._moveEndCallObj = callbackObj

	self:_killTween()
	targetPos:Add(self._unitMo):Div(2)

	local pos = TianShiNaNaHelper.nodeToV3(targetPos)

	self._targetPos = pos:Clone()
	self._beginPos = self:getLocalPos():Clone()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.15, self._onMoving, self._onEndMove, self, nil, EaseType.Linear)
end

function TianShiNaNaUnitEntityBase:changeDir(x, y)
	local targetPos = TianShiNaNaHelper.getV2(x, y)

	self._unitMo.dir = TianShiNaNaHelper.getDir(self._unitMo, targetPos, self._unitMo.dir)

	self:setDir()
end

function TianShiNaNaUnitEntityBase:_beginMoveHalf(pos)
	self:_killTween()

	self._targetPos = pos:Clone()
	self._beginPos = self:getLocalPos():Clone()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.15, self._onMoving, self._onEndMoveHalf, self, nil, EaseType.Linear)
end

function TianShiNaNaUnitEntityBase:_onEndMoveHalf()
	self:updateSortOrder()

	self._targetPos = TianShiNaNaHelper.nodeToV3(self._unitMo):Clone()
	self._beginPos = self:getLocalPos():Clone()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.15, self._onMoving, self._onEndMove, self, nil, EaseType.Linear)
end

function TianShiNaNaUnitEntityBase:_onEndMove()
	self._tweenId = nil

	local endCall, callObj = self._moveEndCall, self._moveEndCallObj

	self._moveEndCall = nil
	self._moveEndCallObj = nil

	if endCall then
		endCall(callObj)
	end
end

function TianShiNaNaUnitEntityBase:_onMoving(value)
	if not self._beginPos or not self._targetPos then
		return
	end

	local lerpPos = TianShiNaNaHelper.lerpV3(self._beginPos, self._targetPos, value)

	transformhelper.setLocalPos(self.trans, lerpPos.x, lerpPos.y, lerpPos.z)
	self:onMoving()
end

function TianShiNaNaUnitEntityBase:onMoving()
	return
end

function TianShiNaNaUnitEntityBase:_onResLoaded()
	self._resGo = self._loader:getInstGO()
	self._dirs = self:getUserDataTb_()

	for _, dir in pairs(TianShiNaNaEnum.OperDir) do
		self._dirs[dir] = gohelper.findChild(self._resGo, TianShiNaNaEnum.ResDirPath[dir])
	end

	local renderers = self._resGo:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	if renderers.Length > 0 then
		self._renderers = {}

		for i = 0, renderers.Length - 1 do
			self._renderers[i + 1] = renderers[i]
		end
	end

	self:setDir()
	self:updateSortOrder()
	self:onResLoaded()
end

function TianShiNaNaUnitEntityBase:onResLoaded()
	return
end

function TianShiNaNaUnitEntityBase:reAdd()
	return
end

function TianShiNaNaUnitEntityBase:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function TianShiNaNaUnitEntityBase:setDir()
	if not self._resGo then
		return
	end

	for dir, go in pairs(self._dirs) do
		gohelper.setActive(go, dir == self._unitMo.dir)
	end
end

function TianShiNaNaUnitEntityBase:updateSortOrder()
	if not self._renderers then
		return
	end

	for _, renderer in pairs(self._renderers) do
		renderer.sortingOrder = TianShiNaNaHelper.getSortIndex(self._unitMo.x, self._unitMo.y)
	end
end

function TianShiNaNaUnitEntityBase:onDestroy()
	self:_killTween()
end

function TianShiNaNaUnitEntityBase:dispose()
	gohelper.destroy(self.go)
end

return TianShiNaNaUnitEntityBase
