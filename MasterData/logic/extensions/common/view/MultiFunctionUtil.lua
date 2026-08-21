-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/MultiFunctionUtil.lua

module("logic.extensions.common.view.MultiFunctionUtil", package.seeall)

local MatchCodes = {
	{
		5001,
		5002,
		5003
	},
	{
		5101,
		5102,
		5103
	},
	{
		5301,
		5302,
		5303
	},
	{
		5201,
		5202,
		5203
	},
	{
		5401,
		5402,
		5403
	}
}
local MatchCodesNumber = {
	BattleExtension_pb.AttributePart.PART_MAX_HP_BASE,
	BattleExtension_pb.AttributePart.PART_ATK_PHY_BASE,
	BattleExtension_pb.AttributePart.PART_ATK_MAG_BASE,
	BattleExtension_pb.AttributePart.PART_DEF_PHY_BASE,
	BattleExtension_pb.AttributePart.PART_DEF_MAG_BASE
}
local attrMap = {}

function getHeroAttrs(heroData)
	local attrs = HeroPowerConfig.instance:getHeroAdditionAttr(heroData:getId())
	local showAttrs = {}
	local hadAttrs = false

	for k, v in pairs(attrs) do
		local co = v.co
		local isUnlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(heroData:getId(), co.code)
		local attr = v.attr
		local attrCode = tonumber(attr.key)

		if isUnlock then
			showAttrs[attrCode] = showAttrs[attrCode] or 0
			showAttrs[attrCode] = showAttrs[attrCode] + attr.value
			hadAttrs = true
		end
	end

	local realShowAttr = {}

	for k, v in pairs(MatchCodes) do
		local maxBaseValue = showAttrs[v[1]] or 0
		local multiValue = showAttrs[v[2]] or 0
		local fixedAddValue = showAttrs[v[3]] or 0
		local baseValue = heroData:getAttrPartsBase(MatchCodesNumber[k])
		local value = maxBaseValue + fixedAddValue + MathUtil.roundingBy456(baseValue * multiValue)

		if value ~= 0 then
			table.insert(realShowAttr, {
				code = v[1],
				value = value
			})
		end
	end

	attrMap = {}

	for k, v in pairs(showAttrs) do
		if not checkInAttrs(k) then
			table.insert(realShowAttr, {
				code = k,
				value = v
			})
		end
	end

	return realShowAttr
end

function checkInAttrs(code)
	if attrMap[code] then
		return true
	end

	for k, v in pairs(MatchCodes) do
		for k1, v1 in pairs(v) do
			if v1 == code then
				attrMap[code] = true

				return true
			end
		end
	end

	return false
end
