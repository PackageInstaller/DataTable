-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessCoinChangeWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessCoinChangeWork", package.seeall)

local AutoChessCoinChangeWork = class("AutoChessCoinChangeWork", AutoChessBaseWork)

function AutoChessCoinChangeWork:onStart()
	local delayTime = 0

	if self.skillEffectId then
		local entity = self.entityMgr:tryGetEntity(self.skillFromUid)

		if entity then
			local param = {
				value1 = self.effect.targetId
			}

			delayTime = entity:playEffect(self.skillEffectId, param)
		end
	end

	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		sceneMo.mall:updateCoin(self.effect.effectNum)
	end

	self:delayCall(self.finishWork, delayTime)
end

return AutoChessCoinChangeWork
