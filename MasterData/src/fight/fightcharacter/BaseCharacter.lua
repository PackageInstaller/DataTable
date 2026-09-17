BaseCharacter = class("BaseCharacter", function(arg_1_0, arg_1_1, arg_1_2)
	return MonsterCharacter:create(arg_1_0, arg_1_1, arg_1_2)
end)

local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local substitution_manager = require("controller.substitution_manager")
local old_substitution_manager = require("controller.old_substitution_manager")
local infinite_fight_manager = require("controller.infinite_fight_manager")
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local item_data = require("data.item_data")
local battlefield_status_data = require("data.battlefield_status_data")

function BaseCharacter.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = BaseCharacter.new(arg_2_1, arg_2_2, arg_2_3)

	var_2_0:initMonster()

	return var_2_0
end

function BaseCharacter.onPlayerFightBoss(arg_3_0)
	return
end
