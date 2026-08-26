-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/controller/MaliAnNaBulletEntityMgr.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.MaliAnNaBulletEntityMgr", package.seeall)

local MaliAnNaBulletEntityMgr = class("MaliAnNaBulletEntityMgr")

function MaliAnNaBulletEntityMgr:init(parent)
	self._parent = parent
	self._bulletEffectEntityList = {}
end

local bulletId = 0

function MaliAnNaBulletEntityMgr:getBulletEffectEntity()
	if self._parent == nil then
		return
	end

	local go = gohelper.create2d(self._parent, "bulletEffect")
	local entity = MonoHelper.addLuaComOnceToGo(go, MaLiAnNaBulletEntity)

	entity:setOnlyId(bulletId + 1)

	bulletId = bulletId + 1
	self._bulletEffectEntityList[entity:getOnlyId()] = entity

	return entity
end

function MaliAnNaBulletEntityMgr:update(deltaTime)
	if self._bulletEffectEntityList == nil then
		return
	end

	for _, entity in pairs(self._bulletEffectEntityList) do
		entity:onUpdate(deltaTime)
	end
end

function MaliAnNaBulletEntityMgr:releaseBulletEffectEntity(entity)
	if entity == nil then
		return
	end

	local onlyId = entity:getOnlyId()

	if self._bulletEffectEntityList[onlyId] then
		self._bulletEffectEntityList[onlyId]:onDestroy()

		self._bulletEffectEntityList[onlyId] = nil
	end
end

function MaliAnNaBulletEntityMgr:clear()
	if self._bulletEffectEntityList ~= nil then
		for _, entity in pairs(self._bulletEffectEntityList) do
			if entity then
				entity:onDestroy()
			end
		end
	end

	tabletool.clear(self._bulletEffectEntityList)
end

function MaliAnNaBulletEntityMgr:onDestroy()
	self:clear()

	self._bulletEffectEntityList = nil

	if self._parent then
		self._parent = nil
	end
end

MaliAnNaBulletEntityMgr.instance = MaliAnNaBulletEntityMgr.New()

return MaliAnNaBulletEntityMgr
