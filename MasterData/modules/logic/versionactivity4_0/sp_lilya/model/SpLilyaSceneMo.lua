-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/model/SpLilyaSceneMo.lua

module("modules.logic.versionactivity4_0.sp_lilya.model.SpLilyaSceneMo", package.seeall)

local SpLilyaSceneMo = class("SpLilyaSceneMo")

function SpLilyaSceneMo:ctor()
	self:reset()
end

function SpLilyaSceneMo:reset()
	self.useMoDic = nil
	self.unuseMoList = nil
	self.spawnList = nil
	self.destroyList = nil
	self.createdList = nil
	self.movedList = nil
	self.stateChangedList = nil
	self.enemyHurtList = nil
	self.aimMoDic = nil
	self.sceneWidth = 0
	self.sceneHeight = 0
	self.groundHeight = 0
	self.groundPosX = 0
	self.groundPosY = 0
	self.bulletBoundaryPosX = 0
	self.bulletBoundaryPosY = 0
	self.clearWaveTime = nil
	self.activeWaveId = nil
	self.activeWaveStartTime = nil
	self.elapsedTime = 0
	self.unuseBulletMoList = nil
	self.useBulletMoDic = nil
	self._bulletUid = 0
	self.bulletCreatedList = nil
	self.bulletMovedList = nil
	self.bulletDestroyList = nil
	self.bulletExplodeList = nil
end

function SpLilyaSceneMo:init()
	self.useMoDic = {}
	self.unuseMoList = {}
	self.spawnList = {}
	self.destroyList = {}
	self.createdList = {}
	self.movedList = {}
	self.stateChangedList = {}
	self.enemyHurtList = {}
	self.aimMoDic = {}
	self.sceneWidth = 0
	self.sceneHeight = 0

	self:_refreshGroundPos()

	self.clearWaveTime = nil
	self.activeWaveId = nil
	self.activeWaveStartTime = nil
	self.elapsedTime = 0
	self.unuseBulletMoList = {}
	self.useBulletMoDic = {}
	self._bulletUid = 0
	self.bulletCreatedList = {}
	self.bulletMovedList = {}
	self.bulletDestroyList = {}
	self.bulletExplodeList = {}
end

function SpLilyaSceneMo:setSceneSize(width, height)
	self.sceneWidth = width
	self.sceneHeight = height

	self:_refreshGroundPos()
end

function SpLilyaSceneMo:getHalfWidth()
	return ((self.sceneWidth > 0 or nil) and (self.sceneWidth or SpLilyaEnum.SceneDefaultSize.width)) / 2
end

function SpLilyaSceneMo:getHalfHeight()
	return ((self.sceneHeight > 0 or nil) and (self.sceneHeight or SpLilyaEnum.SceneDefaultSize.height)) / 2
end

function SpLilyaSceneMo:_refreshGroundPos()
	local halfWidth = self:getHalfWidth()
	local halfHeight = self:getHalfHeight()

	self.groundHeight = select(2, SpLilyaHelper.ConvertOriginPos(0, SpLilyaEnum.DefaultGroundHeight, halfWidth, halfHeight))
	self.groundPosX = halfWidth
	self.groundPosY = select(2, SpLilyaHelper.ConvertOriginPos(0, SpLilyaEnum.DefaultGroundPosY, halfWidth, halfHeight))

	if not SpLilyaEnum.BulletBoundaryMargin then
		self.bulletBoundaryPosX = self.groundPosX + SpLilyaEnum.BulletBoundaryMargin
		self.bulletBoundaryPosY = self.groundPosY + SpLilyaEnum.BulletBoundaryMargin
	end
end

function SpLilyaSceneMo:addEnemy(co)
	local mo = table.remove(self.unuseMoList)

	mo = mo or SpLilyaEnemyMO.New()

	mo:init(co, self:getHalfWidth(), self:getHalfHeight())

	self.useMoDic[mo.uid] = mo

	table.insert(self.createdList, mo)

	return mo
end

function SpLilyaSceneMo:removeEnemy(mo)
	if not mo then
		return nil
	end

	self.useMoDic[mo.uid] = nil

	table.insert(self.unuseMoList, mo)

	return mo
end

function SpLilyaSceneMo:addAimEnemy(mo)
	if not mo then
		return
	end

	self.aimMoDic[mo.uid] = mo
end

function SpLilyaSceneMo:removeAimEnemy(mo)
	if not mo then
		return
	end

	self.aimMoDic[mo.uid] = nil
end

function SpLilyaSceneMo:addBullet(posX, posY, dirX, dirY, trajectorySpeed, damage, energy, radius, explodeRadius, type, moveSpeed)
	local mo = table.remove(self.unuseBulletMoList)

	mo = mo or SpLilyaBulletMO.New()
	self._bulletUid = self._bulletUid + 1

	mo:init(posX, posY, dirX, dirY, trajectorySpeed, damage, energy, radius, explodeRadius, type, self._bulletUid, moveSpeed)
	logNormal(string.format("[SpLilya] 发射子弹 uid=%d 类型=%d 方向=(%.2f,%.2f) 弹道速度=%.2f 飞行速度=%.2f 伤害=%.2f 碰撞半径=%.2f 爆炸半径=%.2f", mo.uid, type, dirX, dirY, trajectorySpeed, mo.speed, damage, radius, explodeRadius))

	self.useBulletMoDic[mo.uid] = mo

	table.insert(self.bulletCreatedList, mo)

	return mo
end

function SpLilyaSceneMo:removeBullet(uid)
	local mo = self.useBulletMoDic[uid]

	if mo then
		self.useBulletMoDic[uid] = nil

		table.insert(self.unuseBulletMoList, mo)

		return mo
	end

	return nil
end

return SpLilyaSceneMo
