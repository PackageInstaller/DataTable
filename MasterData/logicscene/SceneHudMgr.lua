-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/hud/SceneHudMgr.lua

module("logicscene.scene.component.hud.SceneHudMgr", package.seeall)

local SceneHudMgr = class("SceneHudMgr")

SceneHudMgr.HUD_TASK_COMPELETE = 1
SceneHudMgr.HUD_TASK_ACCEPTED = 2
SceneHudMgr.HUD_PLAYER = 3
SceneHudMgr.HUD_OTHERS_PLAYER = 4
SceneHudMgr.HUD_NPC = 5
SceneHudMgr.HUD_TRANSMITPOINT = 6
SceneHudMgr.HUD_TALKING = 7
SceneHudMgr.HUD_PATHS = CommonResPath.sceneHuds

local getres = getres

function SceneHudMgr:ctor()
	self._hudCacheParent = nil
	self._hudsCache = nil
	self._hudRes = nil
	self.isValid = true
end

function SceneHudMgr:setHudCacheParent(type, parent)
	self._hudCacheParent = self._hudCacheParent or {}
	self._hudCacheParent[type] = parent
end

function SceneHudMgr:getHudCacheParent(type)
	if not self._hudCacheParent then
		return
	end

	return self._hudCacheParent[type]
end

function SceneHudMgr:getHud(type, onLoaded, onLoadedObj)
	if self.isValid then
		local hud = self:_getFromCache(type)

		if hud then
			return hud
		end

		return self:_getFromRes(type, onLoaded, onLoadedObj)
	end
end

function SceneHudMgr:recycle(type, go)
	if self.isValid then
		self._hudsCache = self._hudsCache or {}

		local huds = self._hudsCache[type]

		if not huds then
			huds = {}
			self._hudsCache[type] = huds
		end

		local parent = self:getHudCacheParent(type)

		if parent then
			go.transform:SetParent(parent.transform)
		end

		huds[#huds + 1] = go

		go:SetActive(false)
	else
		UnityEngine.GameObject.Destroy(go)
	end
end

function SceneHudMgr:_getFromCache(type)
	if self._hudsCache then
		local huds = self._hudsCache[type]

		if huds then
			local hud = huds[1]

			if hud then
				table.remove(huds, 1)

				return hud
			end
		end
	end
end

function SceneHudMgr:_getFromRes(type, onLoaded, onLoadedObj)
	local res

	if self._hudRes then
		res = self._hudRes[type]
	end

	if not res then
		local resPath = SceneHudMgr.HUD_PATHS[type]

		getres(resPath, function(resLoaded)
			if self.isValid then
				self._hudRes = self._hudRes or {}

				if not self._hudRes[type] or self._hudRes[type] ~= resLoaded then
					resLoaded:Retain()

					self._hudRes[type] = resLoaded
				end

				self:_notiFyHudLoaded(resLoaded, type, onLoaded, onLoadedObj)
			end
		end)
	else
		local prefab = res:GetMainAsset()

		return (goutil.clone(prefab))
	end
end

function SceneHudMgr:_notiFyHudLoaded(res, type, onLoaded, onLoadedObj)
	local prefab = res:GetMainAsset()
	local go = goutil.clone(prefab)

	if onLoaded then
		if onLoadedObj then
			onLoaded(onLoadedObj, type, go)
		else
			onLoaded(type, go)
		end
	else
		self:recycle(type, go)
	end
end

function SceneHudMgr:_clearAllHuds()
	if self._hudsCache then
		for k, v in pairs(self._hudsCache) do
			if v then
				local cnt = #v

				for j = 1, cnt do
					if v[j] then
						UnityEngine.GameObject.Destroy(v[j])
					end
				end
			end
		end

		self._hudsCache = nil
	end

	if self._hudRes then
		for k, v in pairs(self._hudRes) do
			if v then
				v:Release()
				GameUtil.unloadResource(v)
			end
		end

		self._hudRes = nil
	end
end

function SceneHudMgr:clear()
	self:_clearAllHuds()

	self.isValid = nil
end

SceneHudMgr.instance = SceneHudMgr.New()

return SceneHudMgr
