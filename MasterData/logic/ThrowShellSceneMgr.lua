-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/ThrowShellSceneMgr.lua

module("logic.extensions.throwshells.view.ThrowShellSceneMgr", package.seeall)

local ThrowShellSceneMgr = class("ThrowShellSceneMgr")

function ThrowShellSceneMgr:ctor(parentGo, loadFinishBack, monsterCfg, terrainCfg)
	self._sceneGo = sceneGo
	self._parentGo = parentGo
	self._mainActorPos = {
		z = 0,
		x = 0,
		y = 0
	}
	self._wallColliderGo = {}
	self._monsterColliders = {}
	self._loadFinishBack = loadFinishBack
	self._monsterCfg = monsterCfg
	self._resPath = langPara("ui/views/throwshells/%s.prefab", terrainCfg.terrainName)

	getres(self._resPath, self._onPrefabResourcesLoaded, self)
end

function ThrowShellSceneMgr:_onPrefabResourcesLoaded(res)
	if res and res.IsSuccess then
		res:Retain()

		self._res = res
		self._sceneGo = goutil.cloneAndSetParent(res:GetMainAsset(), self._parentGo.transform)

		Framework.TransformUtil.SetLocalPos(self._sceneGo.transform, 0, 0, 0)

		local originGo = goutil.findChild(self._sceneGo, "origin")

		Framework.TransformUtil.SetLocalPos(originGo.transform, 0, 0, 0)

		local mainActorGo = goutil.findChild(self._sceneGo, "origin/mainActor")
		local x, y, z = Framework.TransformUtil.GetLocalPos(mainActorGo.transform, 0, 0, 0)

		self._mainActorPos = {
			x = x,
			y = y,
			z = z
		}

		for i = 1, 200 do
			local wall = goutil.findChild(self._sceneGo, langPara("origin/wall(%s)", i))

			if wall then
				table.insert(self._wallColliderGo, TSColliderCombine.New(wall))
			else
				break
			end
		end

		for i = 1, 200 do
			local monsterGo = goutil.findChild(self._sceneGo, langPara("origin/monster(%s)", i))

			if monsterGo and self._monsterCfg[i] then
				table.insert(self._monsterColliders, TSCMonster.New(monsterGo, self._monsterCfg[i]))
			else
				break
			end
		end

		if self._loadFinishBack then
			GameUtil.callBack(self._loadFinishBack, self._mainActorPos)
		end
	end
end

function ThrowShellSceneMgr:checkCollide(pos, radius, damage)
	local collide = false

	for k, v in pairs(self._wallColliderGo) do
		if v:checkCollide(pos, radius) then
			collide = true

			GlobalDispatcher:dispatch(GlobalNotify.ThrowShellsCollideWall)
		end
	end

	for k, v in pairs(self._monsterColliders) do
		local collideM = v:checkCollide(pos, radius, damage)

		if collideM then
			collide = true
		end
	end

	return collide
end

function ThrowShellSceneMgr:onDestroy()
	table.clear(self._wallColliderGo)

	for k, v in pairs(self._monsterColliders) do
		v:onDestroy()
	end

	table.clear(self._monsterColliders)
	removeresl(self._resPath, self._onPrefabResourcesLoaded, self)

	if self._res then
		self._res:Release()
	end

	self._res = nil

	if not goutil.isNil(self._sceneGo) then
		goutil.destroy(self._sceneGo)
	end

	self._sceneGo = nil
	self._mainActorPos = nil
	self._loadFinishBack = nil
end

function ThrowShellSceneMgr:getMonstersPos()
	local pos = {}

	for k, v in pairs(self._monsterColliders) do
		local posM = v:getPos()

		if posM then
			table.insert(pos, posM)
		end
	end

	return pos
end

return ThrowShellSceneMgr
