-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneEffDistortMgr.lua

module("logicscene.scene.SceneEffDistortMgr", package.seeall)

local SceneEffDistortMgr = class("SceneEffDistortMgr")

function SceneEffDistortMgr:ctor()
	return
end

function SceneEffDistortMgr:startDistort(go, unit)
	self._distorts = self._distorts or {}

	local distort = self:getDistort(go)

	if not distort then
		distort = SceneEffDistort.New(go)
		self._distorts[go] = distort
	end

	distort:startDistort(unit)
	distort:addRef()
end

function SceneEffDistortMgr:stopDistort(go)
	local distort = self:getDistort(go)

	if distort then
		distort:releaseRef()

		if distort:getRef() == 0 then
			distort:stopDistort()

			self._distorts[go] = nil
		end
	end
end

function SceneEffDistortMgr:clear()
	if self._distorts then
		for k, v in pairs(self._distorts) do
			v:stopDistort()
		end

		self._distorts = nil
	end
end

function SceneEffDistortMgr:getDistort(go)
	return self._distorts and self._distorts[go]
end

SceneEffDistortMgr.instance = SceneEffDistortMgr.New()

return SceneEffDistortMgr
