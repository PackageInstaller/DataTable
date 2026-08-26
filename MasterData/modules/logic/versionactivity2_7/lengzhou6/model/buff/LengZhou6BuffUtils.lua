-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/buff/LengZhou6BuffUtils.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.buff.LengZhou6BuffUtils", package.seeall)

local LengZhou6BuffUtils = class("LengZhou6BuffUtils")
local buffIdToBuff = {
	[1001] = PoisoningBuff,
	[1002] = StiffBuff,
	[1003] = DamageBuff
}

function LengZhou6BuffUtils.createBuff(id)
	if buffIdToBuff[id] == nil then
		logError("LengZhou6BuffUtils.createBuff: buffIdToBuff[id] == nil, id = " .. id)
	end

	return buffIdToBuff[id]:New()
end

LengZhou6BuffUtils.instance = LengZhou6BuffUtils.New()

return LengZhou6BuffUtils
