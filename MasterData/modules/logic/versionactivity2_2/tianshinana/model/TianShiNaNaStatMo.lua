-- chunkname: @modules/logic/versionactivity2_2/tianshinana/model/TianShiNaNaStatMo.lua

module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaStatMo", package.seeall)

local TianShiNaNaStatMo = pureTable("TianShiNaNaStatMo")

function TianShiNaNaStatMo:ctor()
	self.beginTime = Time.realtimeSinceStartup
	self.backNum = 0
end

function TianShiNaNaStatMo:reset()
	self.beginTime = Time.realtimeSinceStartup
	self.backNum = 0
end

function TianShiNaNaStatMo:addBackNum()
	self.backNum = self.backNum + 1
end

function TianShiNaNaStatMo:sendStatData(result)
	StatController.instance:track(StatEnum.EventName.Exit_Anjo_Nala_activity, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - self.beginTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(TianShiNaNaModel.instance.episodeCo.id),
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.RoundNum] = TianShiNaNaModel.instance.nowRound,
		[StatEnum.EventProperties.BackNum] = self.backNum
	})
end

return TianShiNaNaStatMo
