local var_0_0 = {}
local item_data = require("data.item_data")
local hexie_conf_data = require("data.hexie_conf_data")
local var_0_3 = {}

function var_0_0.init(arg_1_0)
	for iter_1_0 in hexie_conf_data.channels.value:gmatch("([^,]+)") do
		var_0_3[iter_1_0] = true
	end
end

function var_0_0.setAutoAntihexie(arg_2_0, arg_2_1)
	arg_2_0.autoantihexie = arg_2_1
end

function var_0_0.isHexieAccount(arg_3_0)
	return false
end

function var_0_0.needHexie(arg_4_0)
	local var_4_0 = DeviceManager.getChannelID()

	return var_0_3[(cc.Native.getHexieChannelId or nil) and cc.Native:getHexieChannelId()] ~= nil
end

function var_0_0:checkLevelAndRecharge(arg_5_1, arg_5_2, arg_5_3)
	if self.autoantihexie then
		return true
	end

	if arg_5_3 then
		local var_5_0 = DeviceManager.getChannelID()

		if ((cc.Native.getHexieChannelId or nil) and cc.Native:getHexieChannelId()) ~= arg_5_3 then
			return true
		end
	end

	if arg_5_1 then
		if require("controller.level_manager"):isPlayerPassLevel(arg_5_1) then
			return true
		end
	end

	if arg_5_2 and arg_5_2 <= require("model.playermodel").rechargeamount then
		return true
	end

	return false
end

function var_0_0:canShowShopLimit(arg_6_1)
	if not arg_6_1 then
		return false
	end

	if not self:needHexie() then
		return true
	end

	local recharge_hexie_data = require("data.hexie.recharge_hexie_data")

	if not recharge_hexie_data[arg_6_1] then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	else
		if self:checkLevelAndRecharge(recharge_hexie_data[arg_6_1].unlock_level, recharge_hexie_data[arg_6_1].rechargeamount) then
			return true
		end

		return false
	end

	return true
end

function var_0_0.canShowSkinMarket(arg_7_0)
	return true
end

function var_0_0.canSwitchMainLayerShowGirl(arg_8_0)
	return true
end

function var_0_0:canPreviewSkin(arg_9_1, arg_9_2)
	local item_manager = require("controller.item_manager")

	if self:isChannelInShenheTime() and not item_manager:haveItem(arg_9_1) then
		return false
	end

	if not self:needHexie() then
		return true
	end

	local skin_hexie_data = require("data.hexie.skin_hexie_data")

	if not skin_hexie_data[arg_9_1] then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if item_manager:haveItem(arg_9_1) then
		return true
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	else
		if self:checkLevelAndRecharge(skin_hexie_data[arg_9_1].unlock_level, skin_hexie_data[arg_9_1].rechargeamount, skin_hexie_data[arg_9_1].channel) then
			return true
		end

		return false
	end
end

function var_0_0.canSwitchSkinLayer(arg_10_0, arg_10_1)
	return true
end

function var_0_0:canShowBroken()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_broken.unlock_level, hexie_conf_data.unlock_broken.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canShowLockedServant()
	if DeviceManager.getChannelID() == "270056" then
		if self:checkLevelAndRecharge(hexie_conf_data.unlock_servant.unlock_level, hexie_conf_data.unlock_servant.rechargeamount) then
			return true
		end

		return false
	end

	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_servant.unlock_level, hexie_conf_data.unlock_servant.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canShowServant(arg_13_1)
	if self:canShowLockedServant() then
		return true
	elseif require("model.playermodel").haveServant[arg_13_1] then
		return true
	elseif require("data.servant_data")[arg_13_1].linkage then
		return false
	end

	return false
end

function var_0_0:canShowGirl(arg_14_1)
	if self:canShowLockedServant() then
		return true
	else
		return require("model.playermodel").haveSuit[arg_14_1] == true
	end

	return false
end

function var_0_0:canShowAllPhoto()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_photo.unlock_level, hexie_conf_data.unlock_photo.rechargeamount) then
		return true
	end

	return false
end

function var_0_0.canShowMainButton(arg_16_0)
	return true
end

function var_0_0:canShowCalendar()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_calendar.unlock_level, hexie_conf_data.unlock_calendar.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canShowCostumeBtn()
	if require("controller.account_manager"):getChannel() == "270054" then
		return false
	end

	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_costume.unlock_level, hexie_conf_data.unlock_costume.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canShowDormVisit()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_dorm.unlock_level, hexie_conf_data.unlock_dorm.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canShowMarry()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_marry.unlock_level, hexie_conf_data.unlock_marry.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canShowOverClock()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_overclock.unlock_level, hexie_conf_data.unlock_overclock.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canTestFight()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_testfight.unlock_level, hexie_conf_data.unlock_testfight.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canShowActivityList()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_activitylist.unlock_level, hexie_conf_data.unlock_activitylist.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canShowNotice()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_notice.unlock_level, hexie_conf_data.unlock_notice.rechargeamount) then
		return true
	end

	return false
end

function var_0_0:canShowPlot()
	if not self:needHexie() then
		return true
	end

	if self:isHexieAccount() then
		return false
	end

	if cc.UserDefault:getInstance():getBoolForKey("antishenhe", false) then
		return true
	end

	if self:checkLevelAndRecharge(hexie_conf_data.unlock_plot.unlock_level, hexie_conf_data.unlock_plot.rechargeamount) then
		return true
	end

	return false
end

local var_0_5 = {
	[96] = true,
	[174] = true,
	[97] = true,
	[205] = true,
	[176] = true,
	[204] = true,
	[403] = true,
	[175] = true,
	[102] = true,
	[95] = true,
	[404] = true,
	[163] = true,
	[100] = true,
	[164] = true,
	[101] = true,
	[99] = true,
	[203] = true
}

function var_0_0:needHexieCalendar(arg_26_1)
	if not var_0_5[arg_26_1] then
		return false
	end

	return self:needHexie()
end

function var_0_0.needHexieInput(arg_27_0)
	if require("controller.account_manager"):getChannel() ~= "270054" then
		return false
	end

	return true
end

function var_0_0.isChannelInShenheTime(arg_28_0)
	if DeviceManager.getChannelID() == "270055" then
		return true
	end

	if cc.Native.getHexieChannelId and cc.Native:getHexieChannelId() == "999" then
		return true
	end

	return false
end

var_0_0:init()

return var_0_0
