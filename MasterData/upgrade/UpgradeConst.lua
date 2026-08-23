local var_0_0 = {
	USE_TEST_UPGRADE_URL = "use_test_upgrade_url",
	MICRO_SYNCED_VER = "micro_synced_ver",
	LOCAL_VERSION = "local_version",
	TEST_UPGRADE_URL = "test_upgrade_url",
	EN_FSM_ST = {
		LANG_INFO = 4,
		DOWNLOAD = 2,
		LANG_DOWN = 5,
		INVALID = -1,
		UPGRADE_INFO = 1,
		AUTO_LANG = 21,
		UNZIP = 3,
		VERSION_INFO = 0,
		FINISHED = 6,
		WHOLE_PKG = 7,
		MICRO_CHECK = 11
	},
	EN_UI_MSG = {
		UNZIP = 3,
		VERSION = 0,
		WHOLE = 8,
		LANGVER = 4,
		FINISHED = 7,
		AUTOLANG = 10,
		START = 1,
		LANGPROG = 5,
		PROGRESS = 2,
		REBOOT = 6,
		ERROR = 9
	},
	EN_UI_SILENT = {
		PROGRESS = 2,
		FETCH_URL = 7,
		START = 1,
		UNZIP_OK = 4,
		UNZIP_START = 3,
		FINISHED = 5,
		ERROR = 6
	}
}
local var_0_1 = {}

var_0_1["zh%-Hans"] = "cn"
var_0_1["zh%-Hant"] = "tw"
var_0_1["zh%-TW"] = "tw"
var_0_1["zh%-HK"] = "tw"
var_0_1.ja = "jp"
var_0_1.en = "en"
var_0_1.id = "id"
var_0_1.th = "th"
var_0_1.kr = "kr"
var_0_1.ko = "kr"
var_0_1.fr = "fr"
var_0_1.es = "es"
var_0_1.de = "de"
var_0_1.pt = "pt"
var_0_1.ru = "ru"
var_0_1["in"] = "id"

function var_0_0.getRealLangName(arg_1_0)
	for iter_1_0, iter_1_1 in pairs(var_0_1) do
		if string.find(arg_1_0, iter_1_0) == 1 then
			return iter_1_1
		end
	end

	if string.find(arg_1_0, "zh") == 1 then
		return "cn"
	end

	return nil
end

return var_0_0
