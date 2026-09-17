local CostumeRoomShowManager = class("CostumeRoomShowManager", (require("controller.base_manager")))

CostumeRoomShowManager.MULTITON_MSG = "CostumeRoomShowManager instancealready constructed!"
CostumeRoomShowManager.IconPath = {
	[0] = "public/currency/UI_battleEnd_diamond.png",
	"public/currency/UI_battleEnd_gold.png",
	"public/currency/arenascene_dot_1.png",
	"public/currency/explorecoin.png",
	[1500001] = "public/currency/1500001_1.png",
	[100] = "public/currency/rmb_white.png"
}

setmetatable(CostumeRoomShowManager.IconPath, {
	__index = function(arg_1_0, arg_1_1)
		return "public/currency/" .. require("data.item_data")[arg_1_1].image_id .. ".png"
	end
})

function CostumeRoomShowManager:ctor()
	self.super.ctor(self)

	self._data = {}
	self._config = require("data.pic_share_conf_data")
end

function CostumeRoomShowManager:getShareRewardInfo()
	local drop_data = require("data.drop_data")
	local var_3_1 = {}

	if self._config[1] then
		if drop_data[self._config[1].dropid] then
			if drop_data[self._config[1].dropid].diamond then
				var_3_1.num = drop_data[self._config[1].dropid].diamond
				var_3_1.iconPath = self.IconPath[0]
			elseif drop_data[self._config[1].dropid].gold then
				var_3_1.num = drop_data[self._config[1].dropid].gold
				var_3_1.iconPath = self.IconPath[1]
			end
		end
	end

	return var_3_1
end

function CostumeRoomShowManager:requestInfo(arg_4_1)
	return
end

function CostumeRoomShowManager:handlerInfo(arg_5_1)
	return
end

function CostumeRoomShowManager:getShareConfig(arg_6_1)
	require("network.network"):rpc("get_pic_share_data", {
		shareid = 1,
		sharetest = false,
		channelid = DeviceManager.getChannelID()
	}, function(arg_7_0)
		dumpEx_3_10(arg_7_0)

		if arg_6_1 then
			arg_6_1()
		end
	end)
end

function CostumeRoomShowManager:shareSuccess(arg_8_1)
	require("network.network"):rpc("pic_share_success", {
		shareid = 1
	}, function(arg_9_0)
		dumpEx_3_10(arg_9_0)

		if arg_9_0.result == 1 then
			global_gain(arg_9_0)
		end

		if arg_8_1 then
			arg_8_1()
		end
	end)
end

function CostumeRoomShowManager:getShopData(arg_10_1, arg_10_2)
	require("controller.shop_manager"):get_shop_data(arg_10_1, function(arg_11_0)
		self:updateBuyLayout(arg_11_0)

		if arg_10_2 then
			arg_10_2(arg_11_0)
		end
	end)
end

function CostumeRoomShowManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function CostumeRoomShowManager:updateBuyLayout(arg_13_1)
	if self.layer then
		self.layer:updateBuyLayout(arg_13_1)
	end
end

function CostumeRoomShowManager:buySuccess(arg_14_1)
	if self.layer then
		self.layer:buySuccess(arg_14_1)
	end

	require("controller.costume_room_manager"):getInstance():updateLayer()
end

return CostumeRoomShowManager
