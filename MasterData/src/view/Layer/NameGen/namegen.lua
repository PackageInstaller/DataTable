local surname = require("view.Layer.NameGen.surname")
local boyname = require("view.Layer.NameGen.boyname")
local girlname = require("view.Layer.NameGen.girlname")
local var_0_3 = {}

var_0_3.SetRandomSeed = nil
var_0_3.GenerateName = nil
var_0_3.test = nil

local var_0_4 = "Missing "
local var_0_5 = ""

function var_0_3.GenerateName(arg_1_0, arg_1_1)
	local var_1_0 = surname[math.random(#surname)].surname

	if not var_1_0 or #var_1_0 < 1 then
		var_1_0 = var_0_4
	end

	local var_1_1

	if arg_1_1 then
		var_1_1 = boyname[math.random(#boyname)].lastname

		if not var_1_1 or #var_1_1 < 1 then
			var_1_1 = var_0_5
		end
	else
		var_1_1 = girlname[math.random(#girlname)].lastname

		if not girlname[math.random(#girlname)].lastname or #var_1_1 < 1 then
			var_1_1 = var_0_5
		end
	end

	return var_1_0 .. var_1_1, var_1_0, var_1_1
end

function var_0_3.SetRandomSeed(arg_2_0)
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
end

function var_0_3:test()
	self:SetRandomSeed()
	self:GenerateName(true)
	self:GenerateName(false)
end

return var_0_3
