-- chunkname: @modules/logic/versionactivity2_2/tianshinana/entity/TianShiNaNaPlaceEntity.lua

module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaPlaceEntity", package.seeall)

local TianShiNaNaPlaceEntity = class("TianShiNaNaPlaceEntity", LuaCompBase)

function TianShiNaNaPlaceEntity.Create(x, y, canOperDirs, cubeType, parent)
	local go = UnityEngine.GameObject.New("Place")

	if parent then
		go.transform:SetParent(parent.transform, false)
	end

	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, TianShiNaNaPlaceEntity, {
		x = x,
		y = y,
		canOperDirs = canOperDirs,
		cubeType = cubeType
	}))
end

function TianShiNaNaPlaceEntity:ctor(param)
	self.x = param.x
	self.y = param.y
	self.canOperDirs = param.canOperDirs
	self.cubeType = param.cubeType
	self._maxLen = self.cubeType == TianShiNaNaEnum.CubeType.Type1 and 1 or 2
end

function TianShiNaNaPlaceEntity:init(go)
	self.go = go
	self.trans = go.transform

	local pos = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2(self.x, self.y))

	transformhelper.setLocalPos(self.trans, pos.x, pos.y, pos.z)

	self._renderOrder = TianShiNaNaHelper.getSortIndex(self.x, self.y)

	for name, dir in pairs(TianShiNaNaEnum.OperDir) do
		if self.canOperDirs[dir] then
			local operOffset = TianShiNaNaHelper.getOperOffset(dir)
			local dirGo = gohelper.create3d(self.go, name)

			if self.cubeType == TianShiNaNaEnum.CubeType.Type2 then
				if dir == TianShiNaNaEnum.OperDir.Left or dir == TianShiNaNaEnum.OperDir.Right then
					transformhelper.setLocalScale(dirGo.transform, -1, 1, 1)
				end

				if dir == TianShiNaNaEnum.OperDir.Back or dir == TianShiNaNaEnum.OperDir.Right then
					operOffset.x = operOffset.x * 2
					operOffset.y = operOffset.y * 2
				end
			end

			pos = TianShiNaNaHelper.nodeToV3(operOffset)

			transformhelper.setLocalPos(dirGo.transform, pos.x, pos.y, pos.z)

			local loader = PrefabInstantiate.Create(dirGo)
			local path = self.cubeType == TianShiNaNaEnum.CubeType.Type1 and "scenes/v2a2_m_s12_tsnn_jshd/prefab/uidikuai1.prefab" or "scenes/v2a2_m_s12_tsnn_jshd/prefab/uidikuai2.prefab"

			loader:startLoad(path, self._onLoadEnd, self)
		end
	end
end

function TianShiNaNaPlaceEntity:_onLoadEnd()
	local renderers = self.go:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, renderers.Length - 1 do
		renderers[i].sortingOrder = self._renderOrder - 10
	end
end

function TianShiNaNaPlaceEntity:getClickDir(clickPos)
	local clickDir

	if clickPos.x == self.x then
		local len = math.abs(clickPos.y - self.y)

		if len > 0 and len <= self._maxLen then
			clickDir = clickPos.y > self.y and TianShiNaNaEnum.OperDir.Forward or TianShiNaNaEnum.OperDir.Back
		end
	elseif clickPos.y == self.y then
		local len = math.abs(clickPos.x - self.x)

		if len > 0 and len <= self._maxLen then
			clickDir = clickPos.x > self.x and TianShiNaNaEnum.OperDir.Right or TianShiNaNaEnum.OperDir.Left
		end
	end

	if self.canOperDirs[clickDir] then
		return clickDir
	end
end

function TianShiNaNaPlaceEntity:dispose()
	gohelper.destroy(self.go)
end

return TianShiNaNaPlaceEntity
