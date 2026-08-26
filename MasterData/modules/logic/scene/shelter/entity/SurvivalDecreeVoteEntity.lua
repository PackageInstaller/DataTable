-- chunkname: @modules/logic/scene/shelter/entity/SurvivalDecreeVoteEntity.lua

module("modules.logic.scene.shelter.entity.SurvivalDecreeVoteEntity", package.seeall)

local SurvivalDecreeVoteEntity = class("SurvivalDecreeVoteEntity", LuaCompBase)

function SurvivalDecreeVoteEntity.Create(resPath, root, pos, dir)
	if dir == nil then
		dir = math.random(0, 5)
	end

	local go = gohelper.create3d(root, tostring(pos))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, dir * 60, 0)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalDecreeVoteEntity, resPath)
end

function SurvivalDecreeVoteEntity:ctor(resPath)
	self.resPath = resPath
end

function SurvivalDecreeVoteEntity:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function SurvivalDecreeVoteEntity:init(go)
	self.go = go
	self.transform = go.transform

	self:showModel()
end

function SurvivalDecreeVoteEntity:showModel()
	if not gohelper.isNil(self.goModel) then
		return
	end

	if self._loader then
		return
	end

	self._loader = PrefabInstantiate.Create(self.go)

	local path = self:getResPath()

	if string.nilorempty(path) then
		return
	end

	self._loader:startLoad(path, self._onResLoadEnd, self)
end

function SurvivalDecreeVoteEntity:getResPath()
	return self.resPath
end

function SurvivalDecreeVoteEntity:_onResLoadEnd()
	local go = self._loader:getInstGO()
	local trans = go.transform

	self.goModel = go

	transformhelper.setLocalPos(trans, 0, 0, 0)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	transformhelper.setLocalScale(trans, 1, 1, 1)
	gohelper.setActive(self.goModel, true)
end

function SurvivalDecreeVoteEntity:dispose()
	if not gohelper.isNil(self.go) then
		gohelper.destroy(self.go)
	end
end

return SurvivalDecreeVoteEntity
