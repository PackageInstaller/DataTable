-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/drop/DropBase.lua

module("logicscene.scene.drop.DropBase", package.seeall)

local dropItemsPath = {
	[GameEnum.ResCopyType.Exp] = "scene/drops/prefabs/drop_exp.prefab",
	[GameEnum.ResCopyType.Coin] = "scene/drops/prefabs/drop_coin.prefab",
	[GameEnum.ResCopyType.Stargod] = "scene/drops/prefabs/drop_stargod.prefab",
	[GameEnum.ResCopyType.Equip] = "scene/drops/prefabs/drop_equip.prefab"
}
local DropBase = class("DropBase")

DropBase.dropItemsPath = dropItemsPath

function DropBase:ctor(type)
	self._dropType = type
end

function DropBase:start(unit)
	self._dropUnit = unit
	self._resObj = ResCache.instance:newObject(dropItemsPath[self._dropType], self._onDropItemLoaded, self)
end

function DropBase:clear()
	if self._resObj then
		local go = self._resObj.go

		if go then
			UnityTweens.TweenBezier.StopTween(go)
		end

		ResCache.instance:recycleObject(self._resObj)

		self._resObj = nil
	end
end

function DropBase:_onDropItemLoaded(resObject)
	local zorder = BattleEffectOrderCtrl.getOrderByPosIndex(self._dropUnit.posRow)
	local startPos, ctrlPos, destPos = self:_getDropPath()
	local go = resObject.go

	GoUtil.SetSortingOrder(go, zorder + 5)
	UnityTweens.TweenBezier.StartTweenWithSpeed(go, startPos, destPos, ctrlPos, 30):AddListener(function()
		GoUtil.SetSortingOrder(go, 0)
		DropManager.instance:onDropFinished()
	end)
end

function DropBase:_getDropPath()
	local startPosNode = self._dropUnit:getMountPoint(GameEnum.MountPointType.Center)
	local startPos = startPosNode.transform.position

	if self._dropType == GameEnum.ResCopyType.Coin or self._dropType == GameEnum.ResCopyType.Exp then
		local rZone = math.random(0, 3)

		if rZone < 1.5 then
			return self:_getBottomZone(startPos)
		end

		if rZone < 2.3 then
			return self:_getFrontZone(startPos)
		end

		return self:_getBehindZone(startPos)
	end

	local ramdonCX = math.random(-2, 2)
	local ramdonCY = math.random(10, 30)
	local ramdonCZ = math.random(-10, 10)
	local ramdonDX = math.random(-3, 3)
	local ramdonDY = math.random(-10, -1)
	local ramdonDZ
	local zSign = math.random(1, 3)
	local destPos = Vector3.New(ramdonDX, startPos.y + ramdonDY, startPos.z + (zSign == 1 and math.random(-6, -3) or math.random(3, 6)))
	local ctrlPos = Vector3.New(startPos.x + ramdonCX, startPos.y + ramdonCY, startPos.z + ramdonCZ)

	return startPos, ctrlPos, destPos
end

function DropBase:_getBottomZone(startPos)
	local ramdonCX = math.random(-10, 10)
	local ramdonCY = math.random(10, 30)
	local ramdonDX = math.random(-11, 11)
	local ramdonDY = math.random(-20, -10)
	local destPos = Vector3.New(startPos.x + ramdonDX, startPos.y + ramdonDY, startPos.z)
	local ctrlPos = Vector3.New(startPos.x + ramdonCX, startPos.y + ramdonCY, startPos.z)

	return startPos, ctrlPos, destPos
end

function DropBase:_getFrontZone(startPos)
	local ramdonCX = math.random(-20, 20)
	local ramdonCY = math.random(10, 30)
	local ramdonCZ = math.random(-10, 10)
	local ramdonDX = math.random(-20, -10)
	local ramdonDY = math.random(-10, -1)
	local ramdonDZ
	local zSign = math.random(1, 3)
	local destPos = Vector3.New(startPos.x + ramdonDX, startPos.y + ramdonDY, startPos.z + (zSign == 1 and math.random(-6, -3) or math.random(3, 6)))
	local ctrlPos = Vector3.New(startPos.x + ramdonCX, startPos.y + ramdonCY, startPos.z + ramdonCZ)

	return startPos, ctrlPos, destPos
end

function DropBase:_getBehindZone(startPos)
	local ramdonCX = math.random(-10, 10)
	local ramdonCY = math.random(10, 30)
	local ramdonCZ = math.random(-10, 10)
	local ramdonDX = math.random(10, 15)
	local ramdonDY = math.random(-10, 1)
	local ramdonDZ
	local zSign = math.random(1, 3)
	local destPos = Vector3.New(startPos.x + ramdonDX, startPos.y + ramdonDY, startPos.z + (zSign == 1 and math.random(-6, -3) or math.random(3, 6)))
	local ctrlPos = Vector3.New(startPos.x + ramdonCX, startPos.y + ramdonCY, startPos.z + ramdonCZ)

	return startPos, ctrlPos, destPos
end

return DropBase
