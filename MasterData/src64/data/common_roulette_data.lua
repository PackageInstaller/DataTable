local var_0_0 = {}
local var_0_1 = {
	"data.activity_roulette.activityconf.common_roulette_champion_745_data",
	"data.activity_roulette.activityconf.common_roulette_champion_755_data",
	"data.activity_roulette.activityconf.common_roulette_champion_766_data",
	"data.activity_roulette.activityconf.common_roulette_champion_767_data",
	"data.activity_roulette.activityconf.common_roulette_champion_768_data",
	"data.activity_roulette.activityconf.common_roulette_champion_775_data",
	"data.activity_roulette.activityconf.common_roulette_champion_776_data",
	"data.activity_roulette.activityconf.common_roulette_champion_787_data",
	"data.activity_roulette.activityconf.common_roulette_champion_792_data",
	"data.activity_roulette.activityconf.common_roulette_champion_806_data",
	"data.activity_roulette.activityconf.common_roulette_champion_813_data",
	"data.activity_roulette.activityconf.common_roulette_champion_830_data",
	"data.activity_roulette.activityconf.common_roulette_champion_837_data",
	"data.activity_roulette.activityconf.common_roulette_champion_838_data",
	"data.activity_roulette.activityconf.common_roulette_champion_852_data",
	"data.activity_roulette.activityconf.common_roulette_champion_855_data",
	"data.activity_roulette.activityconf.common_roulette_champion_861_data",
	"data.activity_roulette.activityconf.common_roulette_champion_865_data",
	"data.activity_roulette.activityconf.common_roulette_champion_866_data",
	"data.activity_roulette.activityconf.common_roulette_champion_868_data",
	"data.activity_roulette.activityconf.common_roulette_champion_872_data",
	"data.activity_roulette.activityconf.common_roulette_champion_887_data",
	"data.activity_roulette.activityconf.common_roulette_champion_888_data",
	"data.activity_roulette.activityconf.common_roulette_champion_894_data",
	"data.activity_roulette.activityconf.common_roulette_champion_897_data",
	"data.common_roulette_champion_data"
}

if DeviceManager.platform == "windows" then
	local var_0_2 = {}

	for iter_0_0, iter_0_1 in ipairs(var_0_1) do
		for iter_0_2, iter_0_3 in pairs((require(iter_0_1))) do
			if var_0_2[iter_0_2] then
				error(iter_0_2 .. " is conflict between " .. var_0_2[iter_0_2] .. " and " .. iter_0_1 .. ", 快叫凯达去改表")
			else
				var_0_2[iter_0_2] = iter_0_1
			end
		end
	end
end

for iter_0_4, iter_0_5 in pairs(var_0_1) do
	table.merge(var_0_0, (require(iter_0_5)))
end

setmetatable(var_0_0, {
	__index = function(arg_1_0, arg_1_1)
		if arg_1_1 then
			print("common_roulette_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
