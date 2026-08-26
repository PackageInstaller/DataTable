-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/controller/MaliAnNaSoliderEntityMgr.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.MaliAnNaSoliderEntityMgr", package.seeall)

local MaliAnNaSoliderEntityMgr = class("MaliAnNaSoliderEntityMgr")

function MaliAnNaSoliderEntityMgr:init(soliderItem, heroItem)
	self._soliderItem = soliderItem
	self._heroItem = heroItem
	self._soliderEntityDict = {}
end

function MaliAnNaSoliderEntityMgr:getSoliderEntity()
	return self._soliderEntityDict
end

function MaliAnNaSoliderEntityMgr:_initPool()
	local maxCount = 20

	self._playerSoliderEntityPool = LuaObjPool.New(maxCount, function()
		return (self:cloneSolider())
	end, function(entity)
		if entity ~= nil then
			entity:onDestroy()
		end
	end, function(entity)
		if entity ~= nil then
			entity:clear()
		end
	end)
	self._enemySoliderEntityPool = LuaObjPool.New(maxCount, function()
		return (self:cloneSolider())
	end, function(entity)
		if entity ~= nil then
			entity:onDestroy()
		end
	end, function(entity)
		if entity ~= nil then
			entity:clear()
		end
	end)
end

function MaliAnNaSoliderEntityMgr:cloneSolider()
	local go = gohelper.cloneInPlace(self._soliderItem, "solider")

	return (MonoHelper.addLuaComOnceToGo(go, MaLiAnNaSoliderEntity))
end

function MaliAnNaSoliderEntityMgr:cloneHeroSolider()
	local go = gohelper.cloneInPlace(self._heroItem, "hero")

	return (MonoHelper.addLuaComOnceToGo(go, MaLiAnNaSoliderHeroEntity))
end

function MaliAnNaSoliderEntityMgr:getEntity(soliderMo)
	local entity

	if soliderMo:isHero() then
		entity = self:cloneHeroSolider()
	else
		if self._playerSoliderEntityPool == nil or self._enemySoliderEntityPool == nil then
			self:_initPool()
		end

		entity = soliderMo:getCamp() == Activity201MaLiAnNaEnum.CampType.Player and self._playerSoliderEntityPool:getObject(soliderMo) or self._enemySoliderEntityPool:getObject(soliderMo)

		if entity == nil or entity:getGo() == nil then
			entity = self:cloneSolider()
		end
	end

	if entity then
		entity:initSoliderInfo(soliderMo)

		self._soliderEntityDict[soliderMo:getId()] = entity

		gohelper.setAsFirstSibling(entity._go)
	end

	return entity
end

function MaliAnNaSoliderEntityMgr:recycleEntity(soliderMo)
	if self._soliderEntityDict == nil or soliderMo == nil then
		return
	end

	local id = soliderMo:getId()
	local entity = self._soliderEntityDict[id]

	if entity == nil then
		return
	end

	if not soliderMo:isHero() then
		if soliderMo:getCamp() == Activity201MaLiAnNaEnum.CampType.Player then
			if self._playerSoliderEntityPool then
				self._playerSoliderEntityPool:putObject(entity)
			end
		elseif self._enemySoliderEntityPool then
			self._enemySoliderEntityPool:putObject(entity)
		end
	else
		entity:onDestroy()
	end

	self._soliderEntityDict[id] = nil
end

function MaliAnNaSoliderEntityMgr:setHideEntity(soliderMo, state)
	if soliderMo == nil or self._soliderEntityDict == nil then
		return
	end

	local id = soliderMo:getId()
	local entity = self._soliderEntityDict[id]

	if entity then
		entity:setHide(state)
	end
end

function MaliAnNaSoliderEntityMgr:clear()
	if self._soliderEntityDict ~= nil then
		for _, entity in pairs(self._soliderEntityDict) do
			if entity then
				entity:onDestroy()
			end
		end

		tabletool.clear(self._soliderEntityDict)
	end
end

function MaliAnNaSoliderEntityMgr:onDestroy()
	self:clear()

	self._soliderEntityDict = nil

	if self._playerSoliderEntityPool ~= nil then
		self._playerSoliderEntityPool:dispose()

		self._playerSoliderEntityPool = nil
	end

	if self._enemySoliderEntityPool ~= nil then
		self._enemySoliderEntityPool:dispose()

		self._enemySoliderEntityPool = nil
	end

	if self._soliderItem ~= nil then
		gohelper.destroy(self._soliderItem)

		self._soliderItem = nil
	end

	if self._heroItem ~= nil then
		gohelper.destroy(self._heroItem)

		self._heroItem = nil
	end
end

MaliAnNaSoliderEntityMgr.instance = MaliAnNaSoliderEntityMgr.New()

return MaliAnNaSoliderEntityMgr
