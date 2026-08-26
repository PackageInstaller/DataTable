-- chunkname: @modules/logic/explore/map/unit/comp/ExploreRoleAnimEffectComp.lua

module("modules.logic.explore.map.unit.comp.ExploreRoleAnimEffectComp", package.seeall)

local ExploreRoleAnimEffectComp = class("ExploreRoleAnimEffectComp", LuaCompBase)

function ExploreRoleAnimEffectComp:ctor(unit)
	self.unit = unit
	self._effects = {}
end

function ExploreRoleAnimEffectComp:init(go)
	self.go = go
end

function ExploreRoleAnimEffectComp:setStatus(status)
	self._status = status

	local co = lua_explore_hero_effect.configDict[status]

	if co then
		for i = 1, #co do
			if co[i].audioId and co[i].audioId > 0 then
				AudioMgr.instance:trigger(co[i].audioId)
			end

			if not self._effects[i] then
				self._effects[i] = {}
				self._effects[i].go = UnityEngine.GameObject.New()
				self._effects[i].loader = PrefabInstantiate.Create(self._effects[i].go)
			else
				gohelper.setActive(self._effects[i].go, true)
			end

			self._effects[i].loader:dispose()

			if not string.nilorempty(co[i].effectPath) then
				self._effects[i].path = co[i].hangPath

				self._effects[i].loader:startLoad(ResUrl.getExploreEffectPath(co[i].effectPath))

				local tr = self.unit._displayTr

				if not string.nilorempty(self._effects[i].path) then
					local trans = self.unit._displayTr:Find(self._effects[i].path)

					if trans then
						tr = trans
					end
				end

				self._effects[i].go.transform:SetParent(tr, false)
			else
				gohelper.setActive(self._effects[i].go, false)
			end
		end

		for i = #co + 1, #self._effects do
			gohelper.setActive(self._effects[i].go, false)
		end
	else
		for i = 1, #self._effects do
			gohelper.setActive(self._effects[i].go, false)
		end
	end
end

function ExploreRoleAnimEffectComp:_releaseEffectGo()
	ResMgr.ReleaseObj(self._effectGo)

	self._effectGo = nil
	self._effectPath = nil
end

function ExploreRoleAnimEffectComp:onDestroy()
	for k, v in pairs(self._effects) do
		v.loader:dispose()
		gohelper.destroy(v.go)
	end

	self._effects = {}
end

return ExploreRoleAnimEffectComp
