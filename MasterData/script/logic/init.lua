local var_0_0 = {}

local function var_0_1(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs({}) do
		gamecore.register_enum(iter_1_1.name, arg_1_1(arg_1_0 .. "." .. iter_1_1.path))
	end

	for iter_1_2, iter_1_3 in pairs({
		{
			path = "user.request",
			name = "user"
		},
		{
			path = "user.response",
			name = "user"
		},
		{
			path = "user.event",
			name = "user"
		},
		{
			path = "user.response_data",
			name = "user"
		},
		{
			path = "user.character.base",
			name = "user"
		},
		{
			path = "user.character.request",
			name = "user"
		},
		{
			path = "user.character.response_data",
			name = "user"
		},
		{
			path = "user.character.response_update",
			name = "user"
		},
		{
			path = "user.character.base_attribute",
			name = "user"
		},
		{
			path = "user.equip.base",
			name = "user"
		},
		{
			path = "user.equip.request",
			name = "user"
		},
		{
			path = "user.equip.response_data",
			name = "user"
		},
		{
			path = "user.equip.response_update",
			name = "user"
		},
		{
			path = "user.team.base",
			name = "user"
		},
		{
			path = "user.team.request",
			name = "user"
		},
		{
			path = "user.team.response_data",
			name = "user"
		},
		{
			path = "user.team.response_update",
			name = "user"
		},
		{
			path = "user.map.base",
			name = "user"
		},
		{
			path = "user.map.request",
			name = "user"
		},
		{
			path = "user.map.response_data",
			name = "user"
		},
		{
			path = "user.map.response_notify",
			name = "user"
		},
		{
			path = "user.map.response_update",
			name = "user"
		},
		{
			path = "user.dock.base",
			name = "user"
		},
		{
			path = "user.dock.request",
			name = "user"
		},
		{
			path = "user.dock.response_data",
			name = "user"
		},
		{
			path = "user.dock.response_update",
			name = "user"
		},
		{
			path = "user.item.base",
			name = "user"
		},
		{
			path = "user.item.request",
			name = "user"
		},
		{
			path = "user.item.response_data",
			name = "user"
		},
		{
			path = "user.item.response_update",
			name = "user"
		},
		{
			path = "user.cardbook.base",
			name = "user"
		},
		{
			path = "user.cardbook.request",
			name = "user"
		},
		{
			path = "user.cardbook.response_data",
			name = "user"
		},
		{
			path = "user.cardbook.response_update",
			name = "user"
		},
		{
			path = "user.task.base",
			name = "user"
		},
		{
			path = "user.task.request",
			name = "user"
		},
		{
			path = "user.task.response_data",
			name = "user"
		},
		{
			path = "user.task.response_update",
			name = "user"
		},
		{
			path = "user.friend.base",
			name = "user"
		},
		{
			path = "user.friend.request",
			name = "user"
		},
		{
			path = "user.friend.response_data",
			name = "user"
		},
		{
			path = "user.friend.response_update",
			name = "user"
		},
		{
			path = "user.skin.base",
			name = "user"
		},
		{
			path = "user.skin.request",
			name = "user"
		},
		{
			path = "user.skin.response_data",
			name = "user"
		},
		{
			path = "user.skin.response_update",
			name = "user"
		},
		{
			path = "user.restaurant.base",
			name = "user"
		},
		{
			path = "user.restaurant.request",
			name = "user"
		},
		{
			path = "user.restaurant.response_data",
			name = "user"
		},
		{
			path = "user.restaurant.response_update",
			name = "user"
		},
		{
			path = "user.mail.base",
			name = "user"
		},
		{
			path = "user.mail.request",
			name = "user"
		},
		{
			path = "user.mail.response_data",
			name = "user"
		},
		{
			path = "user.mail.response_update",
			name = "user"
		},
		{
			path = "user.mall.base",
			name = "user"
		},
		{
			path = "user.mall.request",
			name = "user"
		},
		{
			path = "user.mall.response_data",
			name = "user"
		},
		{
			path = "user.mall.response_update",
			name = "user"
		},
		{
			path = "user.captainroom.base",
			name = "user"
		},
		{
			path = "user.captainroom.request",
			name = "user"
		},
		{
			path = "user.captainroom.response_data",
			name = "user"
		},
		{
			path = "user.captainroom.response_update",
			name = "user"
		},
		{
			path = "user.college.base",
			name = "user"
		},
		{
			path = "user.college.request",
			name = "user"
		},
		{
			path = "user.college.response_data",
			name = "user"
		},
		{
			path = "user.college.response_update",
			name = "user"
		},
		{
			path = "user.dormitory.base",
			name = "user"
		},
		{
			path = "user.dormitory.request",
			name = "user"
		},
		{
			path = "user.dormitory.response_data",
			name = "user"
		},
		{
			path = "user.dormitory.response_update",
			name = "user"
		},
		{
			path = "user.bathroom.base",
			name = "user"
		},
		{
			path = "user.bathroom.request",
			name = "user"
		},
		{
			path = "user.bathroom.response_data",
			name = "user"
		},
		{
			path = "user.bathroom.response_update",
			name = "user"
		},
		{
			path = "user.support.base",
			name = "user"
		},
		{
			path = "user.support.request",
			name = "user"
		},
		{
			path = "user.support.response_data",
			name = "user"
		},
		{
			path = "user.support.response_update",
			name = "user"
		},
		{
			path = "user.bootyshop.base",
			name = "user"
		},
		{
			path = "user.bootyshop.request",
			name = "user"
		},
		{
			path = "user.bootyshop.response_data",
			name = "user"
		},
		{
			path = "user.bootyshop.response_update",
			name = "user"
		},
		{
			path = "user.guide.base",
			name = "user"
		},
		{
			path = "user.guide.request",
			name = "user"
		},
		{
			path = "user.guide.response_data",
			name = "user"
		},
		{
			path = "user.guide.response_update",
			name = "user"
		},
		{
			path = "user.battle.base",
			name = "user"
		},
		{
			path = "user.battle.request",
			name = "user"
		},
		{
			path = "user.battle.response_data",
			name = "user"
		},
		{
			path = "user.story.base",
			name = "user"
		},
		{
			path = "user.story.request",
			name = "user"
		},
		{
			path = "user.story.response_data",
			name = "user"
		},
		{
			path = "user.story.response_update",
			name = "user"
		},
		{
			path = "user.collection.base",
			name = "user"
		},
		{
			path = "user.collection.request",
			name = "user"
		},
		{
			path = "user.collection.response_data",
			name = "user"
		},
		{
			path = "user.collection.response_update",
			name = "user"
		},
		{
			path = "dormitory_idea.idea_manager",
			name = "dormitory_idea"
		},
		{
			path = "dormitory_idea.ideas.rest_idea",
			name = "dormitory_idea"
		},
		{
			path = "dormitory_idea.ideas.play_idea",
			name = "dormitory_idea"
		},
		{
			path = "dormitory_idea.ideas.drive_idea",
			name = "dormitory_idea"
		},
		{
			path = "dormitory_idea.ideas.play_djbox",
			name = "dormitory_idea"
		},
		{
			path = "dormitory_idea.ideas.drive_inter_idea",
			name = "dormitory_idea"
		},
		{
			path = "dormitory_idea.ideas.asura_inter_idea",
			name = "dormitory_idea"
		},
		{
			path = "dormitory_idea.ideas.animal_to_furniture_idea",
			name = "dormitory_idea"
		},
		{
			path = "user.statistics.base",
			name = "user"
		},
		{
			path = "user.statistics.request",
			name = "user"
		},
		{
			path = "user.statistics.response_data",
			name = "user"
		},
		{
			path = "user.statistics.response_update",
			name = "user"
		},
		{
			path = "user.six_activity.base",
			name = "user"
		},
		{
			path = "user.six_activity.request",
			name = "user"
		},
		{
			path = "user.six_activity.response_data",
			name = "user"
		},
		{
			path = "user.six_activity.response_update",
			name = "user"
		},
		{
			path = "user.workshop.base",
			name = "user"
		},
		{
			path = "user.workshop.request",
			name = "user"
		},
		{
			path = "user.workshop.response_data",
			name = "user"
		},
		{
			path = "user.workshop.response_update",
			name = "user"
		},
		{
			path = "user.tower.base",
			name = "user"
		},
		{
			path = "user.tower.request",
			name = "user"
		},
		{
			path = "user.tower.response_data",
			name = "user"
		},
		{
			path = "user.tower.response_update",
			name = "user"
		},
		{
			path = "user.fearlessness_sea.base",
			name = "user"
		},
		{
			path = "user.fearlessness_sea.request",
			name = "user"
		},
		{
			path = "user.fearlessness_sea.response_data",
			name = "user"
		},
		{
			path = "user.fearlessness_sea.response_update",
			name = "user"
		},
		{
			path = "user.fifth_event.base",
			name = "user"
		},
		{
			path = "user.fifth_event.request",
			name = "user"
		},
		{
			path = "user.fifth_event.response_data",
			name = "user"
		},
		{
			path = "user.fifth_event.response_update",
			name = "user"
		},
		{
			path = "user.strike.base",
			name = "user"
		},
		{
			path = "user.strike.request",
			name = "user"
		},
		{
			path = "user.strike.response_data",
			name = "user"
		},
		{
			path = "user.strike.response_update",
			name = "user"
		},
		{
			path = "user.ocean_map_main.base",
			name = "user"
		},
		{
			path = "user.ocean_map_main.request",
			name = "user"
		},
		{
			path = "user.ocean_map_main.response_data",
			name = "user"
		},
		{
			path = "user.ocean_map_main.response_update",
			name = "user"
		},
		{
			path = "user.setting.base",
			name = "user"
		},
		{
			path = "user.setting.request",
			name = "user"
		},
		{
			path = "user.setting.response_data",
			name = "user"
		},
		{
			path = "user.setting.response_update",
			name = "user"
		},
		{
			path = "user.abyss_event.base",
			name = "user"
		},
		{
			path = "user.abyss_event.request",
			name = "user"
		},
		{
			path = "user.abyss_event.response_data",
			name = "user"
		},
		{
			path = "user.abyss_event.response_update",
			name = "user"
		},
		{
			path = "user.abyss_event.base_attribute",
			name = "user"
		},
		{
			path = "user.seventh_event.base",
			name = "user"
		},
		{
			path = "user.seventh_event.request",
			name = "user"
		},
		{
			path = "user.seventh_event.response_data",
			name = "user"
		},
		{
			path = "user.seventh_event.response_update",
			name = "user"
		},
		{
			path = "user.score_push_map.base",
			name = "user"
		},
		{
			path = "user.score_push_map.request",
			name = "user"
		},
		{
			path = "user.score_push_map.response_data",
			name = "user"
		},
		{
			path = "user.score_push_map.response_update",
			name = "user"
		},
		{
			path = "user.research.base",
			name = "user"
		},
		{
			path = "user.research.request",
			name = "user"
		},
		{
			path = "user.research.response_data",
			name = "user"
		},
		{
			path = "user.research.response_update",
			name = "user"
		},
		{
			path = "user.eighth_activity.base",
			name = "user"
		},
		{
			path = "user.eighth_activity.request",
			name = "user"
		},
		{
			path = "user.eighth_activity.response_data",
			name = "user"
		},
		{
			path = "user.eighth_activity.response_update",
			name = "user"
		},
		{
			path = "user.nf_active.base",
			name = "user"
		},
		{
			path = "user.nf_active.request",
			name = "user"
		},
		{
			path = "user.nf_active.response_data",
			name = "user"
		},
		{
			path = "user.nf_active.response_update",
			name = "user"
		},
		{
			path = "user.ninth_activity.base",
			name = "user"
		},
		{
			path = "user.ninth_activity.request",
			name = "user"
		},
		{
			path = "user.ninth_activity.response_data",
			name = "user"
		},
		{
			path = "user.ninth_activity.response_update",
			name = "user"
		}
	}) do
		gamecore.register_class_extend(iter_1_3.name, arg_1_0 .. "." .. iter_1_3.path)
	end

	for iter_1_4, iter_1_5 in pairs({}) do
		gamecore.register_class_module(iter_1_5.name, arg_1_0 .. "." .. iter_1_5.path)
	end

	for iter_1_6, iter_1_7 in pairs({
		{
			path = "main",
			name = "main"
		}
	}) do
		gamecore.register_class_module(iter_1_7.name, arg_1_0 .. "." .. iter_1_7.path)
	end

	for iter_1_8, iter_1_9 in pairs({
		{
			path = "user.user",
			name = "user"
		},
		{
			path = "dormitory_idea.dormitory_idea",
			name = "dormitory_idea"
		}
	}) do
		gamecore.register_instance(iter_1_9.name, arg_1_0 .. "." .. iter_1_9.path)
	end
end

local function var_0_2()
	local var_2_0 = lx.import

	local function var_2_1(arg_3_0)
		return var_2_0(arg_3_0, "script/")
	end

	if app:isPC() then
		local var_2_2 = io.open("./script/init.lua", "rb")

		if var_2_2 then
			function var_2_1(arg_4_0)
				return var_2_0(arg_4_0, "./../../../../trunk/common/script/")
			end

			lx.add_do_hot_update_prefix("./../../../../trunk/common/script/")
			var_2_2:close()
		end
	end

	var_2_1("common_script_init").init(var_2_1)
end

function var_0_0.link(arg_5_0, arg_5_1)
	var_0_1(arg_5_0, arg_5_1)
end

function var_0_0.init(arg_6_0, arg_6_1)
	return true
end

function var_0_0.finish()
	local var_7_0 = lx.import

	var_0_2()
	lx.import("script.logic.battle_init", ""):init(true)
	lx.import("script.logic.battle_revamp_init", ""):init(true)
	gamecore.user:reinit()

	return true
end

return var_0_0
