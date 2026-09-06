-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneDatasCacheMgr.lua

module("logicscene.scene.SceneDatasCacheMgr", package.seeall)

local SceneDatasCacheMgr = class("SceneDatasCacheMgr")
local json = require("cjson")

function SceneDatasCacheMgr:ctor()
	self._datasCache = nil
end

function SceneDatasCacheMgr:getSceneData(url)
	if self._datasCache and self._datasCache[url] then
		return self._datasCache[url]
	end

	local res = rescache:GetResourceNoLoadIfNotExists(url)

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	local data = json.decode(mainAsset.text)

	if not data then
		return
	end

	self._datasCache = self._datasCache or {}
	self._datasCache[url] = data

	return data
end

SceneDatasCacheMgr.instance = SceneDatasCacheMgr.New()

return SceneDatasCacheMgr
