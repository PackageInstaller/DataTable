return {
	setPassedLevel = function(arg_1_0, arg_1_1)
		arg_1_0.level = arg_1_1
	end,
	getPassedLevel = function(self)
		return self.level or 1
	end,
	setLockLevel = function(arg_3_0, arg_3_1)
		RoleDefault:getInstance():setBoolForKey("unlockLevel" .. arg_3_1, false)
	end,
	getLockLevel = function(arg_4_0, arg_4_1)
		return (RoleDefault:getInstance():getBoolForKey("unlockLevel" .. arg_4_1, true))
	end,
	setCurLevel = function(arg_5_0, arg_5_1)
		RoleDefault:getInstance():setIntegerForKey("curlevel", arg_5_1)
	end,
	getCurLevel = function(arg_6_0)
		return RoleDefault:getInstance():getIntegerForKey("curlevel", 1)
	end,
	setUserGold = function(arg_7_0, arg_7_1)
		return
	end,
	getUserGold = function(arg_8_0)
		return 0
	end,
	setUserHearthStone = function(arg_9_0, arg_9_1)
		return
	end,
	getUserHearthStone = function(arg_10_0)
		return 0
	end,
	setPlayerWear = function(arg_11_0, arg_11_1)
		return
	end,
	getPlayerWear = function(arg_12_0)
		return 0
	end,
	setHaveWear = function(arg_13_0, arg_13_1, arg_13_2)
		return
	end,
	getHaveWear = function(arg_14_0, arg_14_1)
		return true
	end,
	setOfflineTime = function(arg_15_0, arg_15_1)
		return
	end,
	getOfflineTime = function(arg_16_0, arg_16_1)
		return -1
	end,
	saveData = function(arg_17_0)
		local playermodel = require("model.playermodel")
		local var_17_1 = "equipment={};"

		for iter_17_0 = 1, TOTAL_SUIT do
			if playermodel.haveSuit[iter_17_0] then
				for iter_17_1 = 1, TOTAL_EQUIPMENT_POS do
					var_17_1 = var_17_1 .. "equipment[" .. iter_17_0 * 100 + iter_17_1 .. "] = " .. (playermodel.playerequip[iter_17_0 * 100 + iter_17_1] or "nil") .. ";"
				end
			end
		end

		local var_17_3 = var_17_1 .. "items={};"

		for iter_17_2, iter_17_3 in pairs(playermodel.items) do
			var_17_3 = var_17_3 .. "items[" .. iter_17_2 .. "]={"

			for iter_17_4, iter_17_5 in pairs(iter_17_3) do
				var_17_3 = var_17_3 .. iter_17_4 .. "=" .. (type(iter_17_5) == "boolean" and (iter_17_5 and "ture" or "false") or iter_17_5 or "nil") .. ","
			end

			var_17_3 = var_17_3 .. "};"
		end

		RoleDefault:getInstance():setStringForKey("playerequipdd", var_17_3)
	end,
	readData = function(arg_18_0, arg_18_1)
		doString((RoleDefault:getInstance():getStringForKey("playerequipdd")))

		if equipment ~= nil then
			arg_18_1.playerequip = equipment
		end

		if items ~= nil then
			arg_18_1.items = items
		end
	end,
	saveSmallEnemy = function(arg_19_0)
		RoleDefault:getInstance():setIntegerForKey("smallEnemyCount", require("model.playermodel").smallEnemyCount)
	end,
	readSmallEnemy = function(arg_20_0)
		return RoleDefault:getInstance():getIntegerForKey("smallEnemyCount", 0)
	end,
	saveAdvenTime = function(arg_21_0)
		require("view.Layer.AdventureLayer")

		local var_21_0 = "AD_TIME={}; "

		for iter_21_0 = 1, 4 do
			if AD_TIME[iter_21_0] ~= nil then
				var_21_0 = var_21_0 .. "AD_TIME[" .. iter_21_0 .. "] = " .. AD_TIME[iter_21_0] .. "; "
			end
		end

		l2Log("时间存储成功")

		local var_21_1 = var_21_0 .. "AD_DATE={}; "

		for iter_21_1 = 1, 4 do
			if AD_DATE[iter_21_1] ~= nil then
				var_21_1 = var_21_1 .. "AD_DATE[" .. iter_21_1 .. "] = " .. AD_DATE[iter_21_1] .. "; "
			end
		end

		l2Log("日期存储成功")

		local var_21_2 = var_21_1 .. "AD_COUNT={}; "

		for iter_21_2 = 1, 4 do
			if AD_COUNT[iter_21_2] ~= nil then
				var_21_2 = var_21_2 .. "AD_COUNT[" .. iter_21_2 .. "] = " .. AD_COUNT[iter_21_2] .. "; "
			end
		end

		l2Log("次数存储成功")
		RoleDefault:getInstance():setStringForKey("AdvenTime", var_21_2)
		l2Log("是这吗？")
	end,
	readAdvenTime = function(arg_22_0)
		local var_22_0 = {}

		var_22_0.Adtime = {}
		var_22_0.Addate = {}
		var_22_0.ChCount = {}

		doString((RoleDefault:getInstance():getStringForKey("AdvenTime")))

		if AD_TIME ~= nil then
			var_22_0.Adtime = AD_TIME
		end

		if AD_DATE ~= nil then
			var_22_0.Addate = AD_DATE
		end

		if AD_COUNT ~= nil then
			var_22_0.ChCount = AD_COUNT
		end

		return var_22_0
	end,
	saveFavorTime = function(arg_23_0)
		RoleDefault:getInstance():setIntegerForKey("favorTime", (os.time()))
	end,
	readFavorTime = function(arg_24_0)
		return RoleDefault:getInstance():getIntegerForKey("favorTime")
	end
}
