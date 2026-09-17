local sproto = require("network.sproto.sproto")
local var_0_1 = {}
local var_0_2 = {
	"arrayc2s",
	"oldc2s",
	"twistc2s",
	"friendc2s",
	"rechargec2s",
	"activityc2s",
	"adventurec2s",
	"3v3c2s",
	"swimc2s",
	"familyc2s",
	"chatc2s",
	"invitec2s",
	"taskc2s",
	"backendc2s",
	"bondc2s",
	"orderc2s",
	"archivesc2s",
	"birthdaypartyc2s",
	"supermarketc2s",
	"offerc2s",
	"soulsc2s",
	"coursec2s",
	"clothesc2s",
	"expeditionc2s",
	"servantrankc2s",
	"testfightc2s",
	"shopc2s",
	"visitcardc2s",
	"chapterc2s",
	"assistarrayc2s",
	"onlinec2s",
	"afklevelc2s",
	"levelmodec2s",
	"aichatc2s"
}
local var_0_3 = {
	"notices2c"
}

function load_sproto()
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_2) do
		table.insert(var_1_0, (require("network.sproto." .. iter_1_1)))
	end

	var_0_1.c2s = sproto.parse((table.concat(var_1_0, "\r\n")))

	local var_1_1 = {}

	for iter_1_2, iter_1_3 in ipairs(var_0_3) do
		table.insert(var_1_1, (require("network.sproto." .. iter_1_3)))
	end

	var_0_1.s2c = sproto.parse((table.concat(var_1_1, "\r\n")))
end

load_sproto()

function var_0_1.reload()
	for iter_2_0, iter_2_1 in ipairs(var_0_2) do
		package.loaded["network.sproto." .. iter_2_1] = nil
	end

	for iter_2_2, iter_2_3 in ipairs(var_0_3) do
		package.loaded["network.sproto." .. iter_2_3] = nil
	end

	load_sproto()
end

return var_0_1
