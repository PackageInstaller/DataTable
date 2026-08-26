-- chunkname: @modules/logic/versionactivity1_4/act129/define/Activity129Enum.lua

module("modules.logic.versionactivity1_4.act129.define.Activity129Enum", package.seeall)

local Activity129Enum = _M

Activity129Enum.PoolType = {
	Limite = 1,
	Unlimite = 2
}
Activity129Enum.ConstEnum = {
	OnceCost = 1,
	MaxMoreDraw = 2,
	CostId = 3
}
Activity129Enum.VoiceType = {
	ClickHero = 2,
	ClickEmptyPool = 4,
	DrawGoosById = 6,
	DrawGoodsByRare = 5,
	EnterShop = 1,
	ClickPool = 3
}

return Activity129Enum
