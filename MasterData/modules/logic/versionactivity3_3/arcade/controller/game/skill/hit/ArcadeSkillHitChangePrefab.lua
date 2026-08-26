-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitChangePrefab.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitChangePrefab", package.seeall)

local ArcadeSkillHitChangePrefab = class("ArcadeSkillHitChangePrefab", ArcadeSkillHitBase)

function ArcadeSkillHitChangePrefab:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._prefabName = params[2]
end

function ArcadeSkillHitChangePrefab:onHit()
	if string.nilorempty(self._prefabName) then
		return
	end

	if self._context then
		local target = self._context.target

		if not target then
			return
		end

		local scene = ArcadeGameController.instance:getGameScene()

		if not scene then
			return
		end

		local entityType = target:getEntityType()
		local uid = target:getUid()

		scene.entityMgr:changeEntityPrefab(entityType, uid, self._prefabName)
		self:addHiter(target)
	end
end

function ArcadeSkillHitChangePrefab:onHitPrintLog()
	if self._context then
		if not self._context then
			return
		end

		logNormal(string.format("%s ==> 更改单位预制体【%s-%s-%s】 prefab:%s", self:getLogPrefixStr(), self._context:getEntityType(), self._context.id, self._context:getUid(), self._prefabName))
	end
end

return ArcadeSkillHitChangePrefab
