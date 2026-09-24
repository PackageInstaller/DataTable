-- chunkname: @modules/logic/fight/config/FightKeyEnum.lua

module("modules.logic.fight.config.FightKeyEnum", package.seeall)

local FightKeyEnum = _M
local getKeyId = GameUtil.getUniqueTb(0)

FightKeyEnum.FightViewUIKey = {
	Default = getKeyId(),
	QteStateChange = getKeyId()
}

return FightKeyEnum
