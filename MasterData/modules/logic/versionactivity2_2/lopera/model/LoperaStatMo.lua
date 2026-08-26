-- chunkname: @modules/logic/versionactivity2_2/lopera/model/LoperaStatMo.lua

module("modules.logic.versionactivity2_2.lopera.model.LoperaStatMo", package.seeall)

local LoperaStatMo = pureTable("LoperaStatMo")

function LoperaStatMo:ctor()
	self.beginTime = Time.realtimeSinceStartup
end

function LoperaStatMo:setEpisodeId(episdoeId)
	self.episdoeId = episdoeId
end

function LoperaStatMo:fillInfo(episdoeId, result, roundNum, eventNum, remainPower, exploreNum, gainMaterial, product)
	self.roundNum = roundNum and roundNum or self.roundNum
	self.episdoeId = episdoeId and episdoeId or self.episdoeId
	self.result = result and result or self.result
	self.eventNum = eventNum and eventNum or self.eventNum
	self.remainPower = remainPower and remainPower or self.remainPower
	self.exploreNum = exploreNum and exploreNum or self.exploreNum
	self.gainMaterial = gainMaterial and gainMaterial or self.gainMaterial
	self.product = product and product or self.product
end

function LoperaStatMo:sendStatData()
	local round

	StatController.instance:track(StatEnum.EventName.Exit_Lopera_activity, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - self.beginTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(self.episdoeId),
		[StatEnum.EventProperties.Result] = LoperaEnum.resultStatUse[self.result],
		[StatEnum.EventProperties.RoundNum] = self.roundNum,
		[StatEnum.EventProperties.CompletedEventNum] = self.eventNum,
		[StatEnum.EventProperties.RemainingMobility] = self.remainPower,
		[StatEnum.EventProperties.ExploreSceneNum] = self.exploreNum,
		[StatEnum.EventProperties.GainAlchemyStuff] = self.gainMaterial,
		[StatEnum.EventProperties.GainAlchemyProp] = self.product
	})
end

return LoperaStatMo
