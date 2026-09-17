local MonopolyPlayerWinManager = class("MonopolyPlayerWinManager", (require("controller.base_manager")))

MonopolyPlayerWinManager.MULTITON_MSG = "MonopolyPlayerWinManager instancealready constructed!"

function MonopolyPlayerWinManager:ctor()
	MonopolyPlayerWinManager.super.ctor(self)

	self._data = {}
end

function MonopolyPlayerWinManager:requestInfo(arg_2_1)
	return
end

function MonopolyPlayerWinManager:handlerInfo(arg_3_1)
	return
end

function MonopolyPlayerWinManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyPlayerWinManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MonopolyPlayerWinManager:getRewardInfo()
	local item_data = require("data/item_data")
	local var_6_1 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_6_2 = require("controller/drop_manager"):getAllDrops(var_6_1:getLevelConfigByLevel(var_6_1:getLevel()).finish_drop)
	local var_6_3 = {
		"weapon_bg_white.png",
		"weapon_bg_green.png",
		"weapon_bg_blue.png",
		"weapon_bg_purple.png",
		"weapon_bg_orange.png",
		"weapon_bg_red.png"
	}
	local var_6_4 = {}

	for iter_6_0 = 1, #var_6_2 do
		local var_6_5 = item_data[var_6_2[iter_6_0].dropid].image_id
		local var_6_6

		if not item_data[var_6_2[iter_6_0].dropid].image_id then
			var_6_5 = ""
			var_6_6 = {
				id = var_6_2[iter_6_0].dropid,
				num = var_6_2[iter_6_0].dropNum,
				bgPath = "public/box/" .. var_6_3[item_data[var_6_2[iter_6_0].dropid].equip_quality]
			}
		end

		var_6_6.iconPath = "equipment/" .. var_6_5 .. ".png"
		var_6_4[iter_6_0] = var_6_6
	end

	return var_6_4
end

return MonopolyPlayerWinManager
