-- chunkname: @modules/logic/fight/model/data/FightCardExtraInfoData.lua

module("modules.logic.fight.model.data.FightCardExtraInfoData", package.seeall)

local FightCardExtraInfoData = FightDataClass("FightCardExtraInfoData")

FightCardExtraInfoData.ExtraKey = {
	AnchorValue = 7,
	NotUseActPoint = 8,
	AnchorKey = 6,
	NotUse = 5,
	SpecialCard = 2,
	NotMove = 4,
	NotCompose = 1,
	ClientParams1 = 3
}

if isDebugBuild then
	FightCardExtraInfoData.ExtraKey2Name = {
		[FightCardExtraInfoData.ExtraKey.NotCompose] = "不能合成",
		[FightCardExtraInfoData.ExtraKey.SpecialCard] = "特殊卡牌",
		[FightCardExtraInfoData.ExtraKey.ClientParams1] = "客户端参数",
		[FightCardExtraInfoData.ExtraKey.NotMove] = "不能移动",
		[FightCardExtraInfoData.ExtraKey.NotUse] = "不能使用",
		[FightCardExtraInfoData.ExtraKey.AnchorKey] = "锚点key",
		[FightCardExtraInfoData.ExtraKey.AnchorValue] = "锚点value"
	}
end

function FightCardExtraInfoData:onConstructor(proto)
	self.key = proto.key
	self.values = {}

	if proto.values then
		for _, value in ipairs(proto.values) do
			table.insert(self.values, value)
		end
	end
end

return FightCardExtraInfoData
