-- chunkname: @modules/logic/sodache/util/SodacheUtil.lua

module("modules.logic.sodache.util.SodacheUtil", package.seeall)

local SodacheUtil = class("SodacheUtil")

function SodacheUtil.isInside()
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return false
	end

	return outSideMo.inside
end

function SodacheUtil.isRookie()
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return false
	end

	return outSideMo.prop.rookie
end

function SodacheUtil.getAttr(attrId)
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return 0
	end

	return outSideMo.attrContainer:getAttr(attrId)
end

function SodacheUtil.getCurrencyName()
	local co = lua_sodache_item.configDict[SodacheEnum.CurrencyId.Coin]

	if not co then
		return ""
	end

	return co.name
end

function SodacheUtil.getCurrencyIcon()
	local co = lua_sodache_item.configDict[SodacheEnum.CurrencyId.Coin]

	if not co then
		return ""
	end

	return co.icon
end

function SodacheUtil.getItemCount(itemId, bagType)
	bagType = bagType or SodacheEnum.BagType.Outside

	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return 0
	end

	local bag = outSideMo:getBag(bagType)

	if not bag then
		return 0
	end

	return bag:getItemQuantity(itemId)
end

function SodacheUtil.getItemsByCardType(cardType, bagType)
	bagType = bagType or SodacheEnum.BagType.Outside

	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return {}
	end

	local bag = outSideMo:getBag(bagType)

	if not bag then
		return {}
	end

	return bag:getItemsByCardType(cardType)
end

function SodacheUtil.isOpen(openId)
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return false
	end

	return tabletool.indexOf(outSideMo.functionBox.functionIds, openId)
end

function SodacheUtil.setInside(isInside)
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if outSideMo then
		if outSideMo.inside == isInside then
			return
		end

		outSideMo.inside = isInside
	else
		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.InsideStatusChange, isInside)

	if isInside then
		SodacheController.instance:realEnterInsideScene()
	else
		SodacheController.instance:enterScene()
	end

	SodacheUtil.closeViews(not isInside)
end

local outsideViews = {
	ViewName.SodacheMainView,
	ViewName.SodacheMapSelectView,
	ViewName.SodacheMapDetailView,
	ViewName.SodacheCardSelectView
}
local insideViews = {
	ViewName.SodacheMapView
}

function SodacheUtil.closeViews(isInside)
	if isInside then
		if not insideViews then
			local views = outsideViews

			for k, v in pairs(views) do
				ViewMgr.instance:closeView(v)
			end
		end
	end
end

function SodacheUtil.checkUnlockCondition(condition)
	local params = string.split(condition, "#")

	if params[1] == "haveItem" then
		local costs = string.splitToNumber(params[2], ":")
		local itemCnt = SodacheUtil.getItemCount(costs[1])

		return itemCnt, costs[2], costs[1]
	elseif params[1] == "level" then
		local needLvl = tonumber(params[2])
		local outsideMo = SodacheModel.instance:getOutsideMo()
		local curLvl = outsideMo.prop.level

		return curLvl, needLvl
	elseif params[1] == "buildingLevel" then
		local needLvl = tonumber(params[3])
		local outsideMo = SodacheModel.instance:getOutsideMo()
		local buildingMo = outsideMo.buildingBox:getBuildingMo(tonumber(params[2]))
		local curLvl = buildingMo.level

		return curLvl, needLvl
	end
end

function SodacheUtil.compareNum(num, mode, val)
	if mode == 1 then
		return val <= num
	elseif mode == 2 then
		return num <= val
	elseif mode == 3 then
		return num == val
	end
end

function SodacheUtil.getRelicAttrs(relicId, level)
	local strs = {}
	local configs = lua_sodache_upgrade.configDict[relicId]

	for _, config in ipairs(configs) do
		if level >= config.level then
			strs[#strs + 1] = config.globalAttri
		end
	end

	return strs
end

function SodacheUtil.getGlobalAttrMap(globalAttr, attrMap)
	attrMap = attrMap or {}

	local params = GameUtil.splitString2(globalAttr, true)

	if params then
		for _, param in ipairs(params) do
			local id = param[1]
			local value = param[2]

			attrMap[id] = attrMap[id] and attrMap[id] + value or value
		end
	end

	return attrMap
end

function SodacheUtil.getBuildingResUrl(name)
	return string.format("modules/sodache/scene/prefab/%s.prefab", name)
end

function SodacheUtil.showToast(msg)
	if not ViewMgr.instance:isOpen(ViewName.SodacheToastView) then
		table.insert(SodacheModel.instance.toastList, msg)
		ViewMgr.instance:openView(ViewName.SodacheToastView)
	elseif ViewMgr.instance:isOpening(ViewName.SodacheToastView) then
		table.insert(SodacheModel.instance.toastList, msg)
	else
		SodacheController.instance:dispatchEvent(SodacheEvent.ShowToast, msg)
	end
end

function SodacheUtil.showCardToast(data)
	if not ViewMgr.instance:isOpen(ViewName.SodacheCardToastView) then
		table.insert(SodacheModel.instance.cardToastList, data)
		ViewMgr.instance:openView(ViewName.SodacheCardToastView)
	elseif ViewMgr.instance:isOpening(ViewName.SodacheCardToastView) then
		table.insert(SodacheModel.instance.cardToastList, data)
	else
		SodacheController.instance:dispatchEvent(SodacheEvent.ShowCardToast, data)
	end
end

function SodacheUtil.checkOneKeyUpRelic()
	local outsideMo = SodacheModel.instance:getOutsideMo()

	return outsideMo.relicBox:getFirstUpMo()
end

function SodacheUtil.isSodacheEpisode()
	local episodeId = HeroGroupModel.instance.episodeId

	return episodeId == SodacheEnum.EpisodeId
end

local colorDict = {
	["3"] = "#CC38D9",
	["6"] = "#D70F0F",
	["2"] = "#2C62FF",
	["5"] = "#D45100",
	["1"] = "#068E15",
	["4"] = "#C56D08"
}

function SodacheUtil.changeDescColor(desc)
	desc = string.gsub(desc, "【(.-)<([^<>]-)>】", function(content, colorIndex)
		if colorDict[colorIndex] then
			return string.format("<color=%s>【%s】</color>", colorDict[colorIndex], content)
		end

		return string.format("【%s<%s>】", content, colorIndex)
	end)
	desc = string.gsub(desc, "{(.-)<([^<>]-)>}", function(content, colorIndex)
		if colorDict[colorIndex] then
			return string.format("<color=%s>%s</color>", colorDict[colorIndex], content)
		end

		return string.format("{%s<%s>}", content, colorIndex)
	end)

	return desc
end

function SodacheUtil.setMaterialValue(material, value)
	material:SetFloat("_LerpOffset", value)

	local waveX = value == 0 and 0 or 0.05

	material:SetVector("_WaveOffset", Vector4.New(waveX, 3.94, 5, 5))
end

return SodacheUtil
