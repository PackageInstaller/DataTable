-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/gameobject/ReusableLuaBehavior.lua

module("logic.common.pool.gameobject.ReusableLuaBehavior", package.seeall)

local M = class("ReusableLuaBehavior", IReusable)
local kPoolRoot = PoolRootUtil.getScenePoolRoot()

function M:NewObject(prefab, parent)
	local mainGO = goutil.clone(prefab)

	goutil.addChildToParent(mainGO, parent)

	return Astral.SimpleLuaComponentContainer.Add(mainGO, self)
end

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:buildUI()
	self:onEnter()
end

function M:reuse(prefab, parent)
	goutil.addChildToParent(self.mainGO, parent)
	self:onEnter()
end

function M:reset()
	self:onExit()
	goutil.addChildToParent(self.mainGO, kPoolRoot)
end

function M:destroy()
	self:onExit()
	self:destroyUI()
	goutil.destroy(self.mainGO)

	self.mainGO = false
end

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

return M
