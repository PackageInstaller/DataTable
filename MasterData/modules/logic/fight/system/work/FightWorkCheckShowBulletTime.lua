-- chunkname: @modules/logic/fight/system/work/FightWorkCheckShowBulletTime.lua

module("modules.logic.fight.system.work.FightWorkCheckShowBulletTime", package.seeall)

local FightWorkCheckShowBulletTime = class("FightWorkCheckShowBulletTime", FightWorkItem)

FightWorkCheckShowBulletTime.ShowBulletTimeDuration = 1

local tempEntityMoList = {}

function FightWorkCheckShowBulletTime:onStart()
	local bulletBuffId = FightModel.instance:getBulletTimeBuffId()

	if not bulletBuffId then
		return self:onDone(true)
	end

	local entityMoList = tempEntityMoList

	tabletool.clear(entityMoList)

	local entityList = FightDataHelper.entityMgr:getMyNormalList(entityMoList)

	for _, entityMo in ipairs(entityList) do
		if entityMo:hasBuffId(bulletBuffId) then
			FightController.instance:dispatchEvent(FightEvent.Rouge2_ShowBulletTime)
			self:com_registTimer(self.finishWork, FightWorkCheckShowBulletTime.ShowBulletTimeDuration)

			return
		end
	end

	return self:onDone(true)
end

return FightWorkCheckShowBulletTime
