-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/water/WaterMgr.lua

module("logicscene.scene.water.WaterMgr", package.seeall)

local WaterMgr = class("WaterMgr")

WaterMgr.WaterSceneInfo = {
	sceneId = 108,
	maxWidth = 44,
	maxHeight = 34
}

function WaterMgr:ctor()
	return
end

function WaterMgr:_onSceneLoaded(_curSceneId)
	if not _curSceneId then
		return
	end

	self._curSceneId = _curSceneId
	self._tileMat = {}

	removetimer(self._waveTimer, self)

	if _curSceneId == WaterMgr.WaterSceneInfo.sceneId then
		settimer(0.2, self._waveTimer, self, true)
	end
end

function WaterMgr:clickWater(roleX, roleY)
	if not self._curSceneId or self._curSceneId ~= WaterMgr.WaterSceneInfo.sceneId then
		return
	end

	local size = SceneFacade.instance:getSceneSize()
	local _tileSize = 10.24
	local _titleRow = math.floor(roleX / _tileSize)
	local _titleCol = math.floor(roleY / _tileSize)
	local xInTile = roleX % _tileSize
	local yInTile = roleY % _tileSize
	local _tileName = "tile_" .. _titleCol .. "_" .. _titleRow .. "_p(Clone)"
	local _tileWidth, _tileHeight, _tileMat

	if self._tileMat[_tileName] then
		_tileMat = self._tileMat[_tileName]._tileMat
		_tileHeight = self._tileMat[_tileName]._tileHeight
		_tileWidth = self._tileMat[_tileName]._tileWidth
	else
		local _tileParentGO = goutil.find("SceneObjectsRoot/" .. _tileName)

		if not goutil.isNil(_tileParentGO) then
			local _tileParentGOScaleX, _tileParentGOScaleY, _ = Framework.TransformUtil.GetLocalScale(go.transform, 0, 0, 0)

			_tileHeight = _tileParentGOScaleY
			_tileWidth = _tileParentGOScaleX

			local _tileGO = goutil.findChild(_tileParentGO, "tile")

			if not goutil.isNil(_tileGO) then
				_tileMat = _tileGO:GetComponent(typeof(UnityEngine.MeshRenderer)).material
				self._tileMat[_tileName] = {
					_tileWidth = _tileWidth,
					_tileHeight = _tileHeight,
					_tileMat = _tileMat
				}
			end
		end
	end

	_tileMat:SetFloat("_ClickF", 50)
	_tileMat:SetFloat("_ClickSpeed", 10)
	_tileMat:SetFloat("_ClickR", 0.3)
	_tileMat:SetFloat("_ClickA", 0.06)
	_tileMat:SetFloat("_ClickU", xInTile / _tileWidth)
	_tileMat:SetFloat("_ClickV", yInTile / _tileHeight)

	self._tileMat[_tileName]._ClickA = 0.06
	self._tileMat[_tileName]._ClickU = xInTile / _tileWidth
	self._tileMat[_tileName]._ClickV = yInTile / _tileHeight
end

function WaterMgr:_waveTimer()
	if not self._tileMat then
		return
	end

	for k, v in pairs(self._tileMat) do
		if v._ClickA and v._ClickA > 0 then
			v._ClickA = v._ClickA - 0.01

			self._tileMat[k]._tileMat:SetFloat("_ClickA", v._ClickA)
		else
			self._tileMat[k]._tileMat:SetFloat("_ClickA", 0)
			self._tileMat[k]._tileMat:SetFloat("_ClickU", 0)
			self._tileMat[k]._tileMat:SetFloat("_ClickV", 0)
		end
	end
end

WaterMgr.instance = WaterMgr.New()

return WaterMgr
