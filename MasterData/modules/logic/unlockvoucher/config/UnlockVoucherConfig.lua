-- chunkname: @modules/logic/unlockvoucher/config/UnlockVoucherConfig.lua

module("modules.logic.unlockvoucher.config.UnlockVoucherConfig", package.seeall)

local UnlockVoucherConfig = class("UnlockVoucherConfig", BaseConfig)

function UnlockVoucherConfig:reqConfigNames()
	return {
		"room_color_const",
		"unlock_voucher"
	}
end

function UnlockVoucherConfig:onInit()
	return
end

function UnlockVoucherConfig:onConfigLoaded(configName, configTable)
	return
end

function UnlockVoucherConfig:getRoomColorConstCfg(constId, nilError)
	local cfg = lua_room_color_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("UnlockVoucherConfig:getRoomColorConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function UnlockVoucherConfig:getRoomColorConst(constId, delimiter, isToNumber)
	local result
	local cfg = self:getRoomColorConstCfg(constId, true)

	if cfg then
		result = cfg.value

		if not string.nilorempty(delimiter) then
			result = isToNumber and string.splitToNumber(result, delimiter) or string.split(result, delimiter)
		elseif isToNumber then
			result = tonumber(result)
		end
	end

	return result
end

function UnlockVoucherConfig:getUnlockVoucherCfg(voucherId, nilError)
	local cfg = lua_unlock_voucher.configDict[voucherId]

	if not cfg and nilError then
		logError(string.format("UnlockVoucherConfig:getUnlockVoucherCfg error, cfg is nil, voucherId:%s", voucherId))
	end

	return cfg
end

function UnlockVoucherConfig:getVoucherRare(voucherId)
	local item = self:getRoomColorConst(UnlockVoucherEnum.ConstId.UseGetVoucherItem, "#", true)
	local itemCfg, _ = ItemModel.instance:getItemConfigAndIcon(item[1], item[2])

	return itemCfg and itemCfg.rare
end

UnlockVoucherConfig.instance = UnlockVoucherConfig.New()

return UnlockVoucherConfig
