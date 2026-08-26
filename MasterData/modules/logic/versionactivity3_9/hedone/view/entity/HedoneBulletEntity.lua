-- chunkname: @modules/logic/versionactivity3_9/hedone/view/entity/HedoneBulletEntity.lua

module("modules.logic.versionactivity3_9.hedone.view.entity.HedoneBulletEntity", package.seeall)

local HedoneBulletEntity = class("HedoneBulletEntity", HedoneBaseEntity)

function HedoneBulletEntity:_onRefreshPosition()
	self:_refreshRotation()

	local mo = self:getMO()
	local isArrived = mo and mo:getIsArrivedTarget()

	if not isArrived then
		return
	end

	local bulletUid = mo:getUid()

	HedoneSkillMgr.instance:onSkillBulletHit(bulletUid)
end

function HedoneBulletEntity:_refreshRotation()
	local mo = self:getMO()
	local rotationZ = mo and mo:getRotation()

	if not rotationZ then
		return
	end

	transformhelper.setEulerAngles(self._trans, 0, 0, rotationZ)
end

function HedoneBulletEntity:getPrefabResPath()
	local id = self:getId()
	local bulletRes = HedoneConfig.instance:getHedoneSkillBullet(id)

	if not string.nilorempty(bulletRes) then
		return string.format(HedoneGameEnum.Const.EffectResPath, bulletRes)
	end
end

return HedoneBulletEntity
