PopGMLayer = class("PopGMLayer", function()
	return PopBaseLayer:create()
end)

local time_check_manager = require("controller.time_check_manager")
local horcrux_devour_manager = require("controller/horcrux_devour/horcrux_devour_manager")
local var_0_2 = horcrux_devour_manager:getInstance()
local var_0_3 = cc.Director:getInstance().getRunningScene(horcrux_devour_manager):getChildByName("SwitchManageLayer")

local function var_0_4(arg_2_0)
	require(arg_2_0)

	if not package.loaded[arg_2_0] then
		print(" fuck ! can't find mod!")
	end

	arg_2_0 = string.gsub(arg_2_0, "%.", "/")

	local var_2_1 = io.open("./src/" .. arg_2_0 .. ".lua")

	var_2_1:close()

	for iter_2_0, iter_2_1 in pairs(package.loaded[arg_2_0]) do
		package.loaded[arg_2_0][iter_2_0] = nil
	end

	for iter_2_2, iter_2_3 in pairs((loadstring((var_2_1:read("*a")))())) do
		package.loaded[arg_2_0][iter_2_2] = iter_2_3
	end

	return ret
end

local function var_0_5(arg_3_0)
	arg_3_0 = string.gsub(arg_3_0, "%.", "/")

	local var_3_0 = io.open("./src/" .. arg_3_0 .. ".lua")
	local var_3_1 = var_3_0:read("*a")

	var_3_0:close()

	for iter_3_0 in string.gmatch(string.gsub(var_3_1, string.find(var_3_1, "local mergedatas = {\n"), string.find(var_3_1, "}\n")), "data%..-_data") do
		var_0_4(iter_3_0)
	end

	var_0_4(string.gsub(arg_3_0, "/", "%."))
end

local function var_0_6(arg_4_0)
	return arg_4_0
end

local function var_0_7()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(ITEMDATA) do
		var_5_0[tostring(iter_5_0)] = iter_5_1.name
	end

	local var_5_1 = io.open("./itemid2name.js", "w+")

	var_5_1:write("var itemid2name = " .. json.encode(var_5_0) .. ";")
	var_5_1:close()
end

local var_0_10 = 0.16666666666666666
local var_0_11 = config._DEBUG and 0 or 1
local var_0_12 = {
	{
		param = "drop P1-4",
		name = "    掉落    "
	},
	{
		param = "gold 500000000",
		name = "    金币    "
	},
	{
		param = "diamond 500000000",
		name = "    钻石    "
	},
	{
		param = "exp 500000000",
		name = "    经验    "
	},
	{
		param = "class_up",
		name = "    升学    "
	},
	{
		param = "strengthpoint 500000000",
		name = "  科技点  "
	},
	{
		param = "clone",
		name = "  纳命来  "
	},
	{
		param = "scorearena 1 1000",
		name = "  积分赛  "
	},
	{
		param = "additem 1000102 1",
		name = "添加物品"
	},
	{
		param = "test_twist ten 900001 10",
		name = "扭蛋测试"
	},
	{
		param = "test_luck_twist 1 2 1000 -100 0",
		name = "欧气测试"
	},
	{
		param = "add_offers id1,id2,...",
		name = "触发悬赏"
	},
	{
		sever = false,
		name = "触发委托",
		param = "id1,id2,id3",
		func = function(arg_6_0)
			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs((string.split(arg_6_0, ","))) do
				table.insert(var_6_0, tonumber(iter_6_1))
			end

			require("devtools.debug_console").trigger_plots(var_6_0)
		end
	},
	{
		sever = false,
		name = "通过关卡",
		param = "输入levelmode或者levelmode,chapter",
		func = function(self)
			if self and not self:find("[0-9]") then
				global_ShowBlockWords("输入的levelmodeid必须为数字")

				return
			end

			local var_8_0
			local var_8_1

			if self:find(",") then
				var_8_0 = tonumber(string.split(self, ",")[1])
				var_8_1 = tonumber(string.split(self, ",")[2])
			end

			if self:find("，") then
				var_8_0 = tonumber(string.split(self, "，")[1])
				var_8_1 = tonumber(string.split(self, "，")[2])
			end

			self = self or 29
			var_8_0 = var_8_0 or tonumber(self)

			require("devtools.debug_console"):clear_chapter(var_8_1)
		end
	},
	{
		sever = false,
		name = "更新内存",
		param = "点击冲冲冲",
		func = function(...)
			var_0_4("data.activity_template_ui_conf.activity_sign_uiconfig_data")
			var_0_5("data.activity_template_ui_conf.activity_shoptimelimit_uiconfig_data")
			var_0_4("data.activity_template_ui_conf.activity_recharge_uiconfig_data")
			var_0_4("data.activity_template_ui_conf.activity_wakefund_uiconfig_data")
			var_0_4("data.activity_main.uiconfig.activity_main_uiconfig_148_data")
			var_0_4("data.activity_flop.uiconfig.activity_flop_ui_conf_data")
			var_0_4("data.activity_flop.uiconfig.activity_buy_package_ui_conf_data")
			var_0_4("data.activity_task.uiconfig.activity_passlevel_uiconfig_data")
			var_0_4("data.activity_timesign.uiconfig.activity_timesign_uiconfig_data")
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("f1_updateData")))
			global_ShowBlockWords("success")
		end
	},
	{
		param = "addbuff 1 100",
		name = "添加buff"
	},
	{
		sever = false,
		name = "一键高富帅",
		param = "one_key_tall_rich_handsome"
	},
	{
		sever = false,
		name = "预览说明界面",
		param = "在这儿粘贴你的文本。",
		func = function(arg_10_0)
			var_0_4("detail_data")
			LayerManager:pushInLayer("PopActivityDetail", {
				testword = var_0_6(arg_10_0)
			})
		end
	},
	{
		param = "reset_dailystat",
		name = "刷新每日状态"
	},
	{
		param = "returnback_twist",
		name = "触发回归扭蛋up"
	},
	{
		param = "reloadconfig",
		name = "重加载服务器配置"
	},
	{
		param = "reset_expedition_by_type 119",
		name = "重置远征章节信息"
	},
	{
		sever = false,
		name = "导出itemid2name.js",
		param = "点击导出",
		func = function()
			var_0_7()
		end
	},
	{
		param = "reset_servant",
		name = "重置servant \n输入all或者servantid"
	},
	{
		sever = false,
		name = "data工具箱",
		param = "干就完了，奥利给",
		func = function()
			require("file_manager")
			FileM:init()
			WindowM:setWindowStat("Search Data", true)
		end
	},
	{
		param = "eat_skill 角色id 1技能id 2技能id 3技能id 4技能id 5技能id 不需要可以不填",
		name = "魂器吞噬"
	}
}

function PopGMLayer.create(arg_13_0, arg_13_1)
	local var_13_0 = PopGMLayer.new()

	var_13_0:init(arg_13_1)

	return var_13_0
end

function PopGMLayer:init(arg_14_1)
	print("open poplayer : PopGMLayer")

	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.initConfig = arg_14_1 or {}

	self:initBg()
	self:initBtns()
	self:initEditBox()
	self:initSendBtn()
	self:checkPlatform()
	self:registerScriptHandler(function(arg_15_0)
		if arg_15_0 == "exit" then
			-- block empty
		end
	end)
end

function PopGMLayer:initBg()
	self.rootpanel = ccui.ImageView:create("mainScenebg/activity_achievement.jpg")

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootpanel:setName("bottom_bg")
	self.rootLayer:addChild(self.rootpanel)
	self:createFullScreenMask(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_17_0:isBright() then
			return
		end

		arg_17_0:setBright(false)
		self.rootpanel:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_10), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end)

	local var_16_0 = cc.Label:createWithTTF("", FONT_NAME, 24)

	var_16_0:setPositionX(self.rootLayer:getContentSize().width / 2)
	var_16_0:setPositionY(1080 + GameDisplay.fix_y * 2)
	self.rootLayer:addChild(var_16_0)

	local playermodel = require("model.playermodel")

	var_16_0:setString("服务器时间:" .. os.date("%c", time_check_manager:getCurTime()))

	local var_16_2 = cc.Label:createWithTTF("使用的服务器节点：" .. config.clientbranch, FONT_NAME, 24)

	var_16_2:setPositionX(self.rootLayer:getContentSize().width / 2)
	var_16_2:setPositionY(1050 + GameDisplay.fix_y * 2)
	self.rootLayer:addChild(var_16_2)

	local var_16_3 = cc.Label:createWithTTF("是否为大图模式:  " .. (not config._DEBUG and "是" or "否") .. " 将config._DEBUG = false即开启大图模式", FONT_NAME, 24)

	var_16_3:setPositionX(self.rootLayer:getContentSize().width / 2)
	var_16_3:setPositionY(1020 + GameDisplay.fix_y * 2)
	self.rootLayer:addChild(var_16_3)

	local var_16_4 = cc.Label:createWithTTF(string.format("账号上次离线时间:%s", playermodel.common_update_time), FONT_NAME, 24)

	var_16_4:setPositionX(self.rootLayer:getContentSize().width / 2)
	var_16_4:setPositionY(1110 + GameDisplay.fix_y * 2)
	self.rootLayer:addChild(var_16_4)
end

function PopGMLayer:initBtns()
	local var_19_0 = "public/button/public_button_red.png"
	local var_19_1 = 0

	for iter_19_0, iter_19_1 in pairs(var_0_12) do
		var_19_1 = var_19_1 + 1

		if iter_19_1.sever == false then
			var_19_0 = "public/button/public_button_big_blue_y.png"
		end

		local var_19_2 = ccui.Button:create(var_19_0, nil, var_19_0, var_0_11)
		local var_19_3 = cc.Label:createWithTTF(iter_19_1.name, FONT_NAME, 28)

		var_19_3:setPosition(cc.p(var_19_2:getContentSize().width / 2, var_19_2:getContentSize().height / 2))
		var_19_2:addChild(var_19_3)
		var_19_2:setPosition(cc.p(170 + (var_19_1 + 1) % 2 * 300, GameDisplay.height - 180 - (math.floor(var_19_1 / 2) + var_19_1 % 2 - 1) * 100))
		self.rootLayer:addChild(var_19_2)
		var_19_2:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectIndex = iter_19_0

			self.editBox:setText(iter_19_1.param)
		end)
	end
end

function PopGMLayer:initEditBox()
	self.editBox = cc.EditBox:create(cc.size(450, 50), (config._DEBUG or nil) and (cc.Scale9Sprite:create("login/word_bg_short.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/bg_4.png")))

	self.editBox:setPosition(cc.p(320, 150))
	self.editBox:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.rootLayer:addChild(self.editBox)
end

local function var_0_13(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 then
		local var_22_0 = io.open(arg_22_0:gsub(" ", "_") .. os.time() .. ".csv", "a+")

		for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
			var_22_0:write(iter_22_1 .. "\n")
			var_22_0:flush()
		end

		var_22_0:close()
	end

	if arg_22_2 then
		local var_22_1 = io.open(arg_22_0:gsub(" ", "_") .. "_otherdrops.csv", "a+")
		local var_22_2 = json.decode(arg_22_2)

		var_22_1:write("baodi," .. var_22_2.guarantee .. "\n")
		var_22_1:write("MR xueyuan," .. var_22_2.servant_mr .. "\n")
		var_22_1:write("SP xueyuan," .. var_22_2.servant_sp .. "\n")
		var_22_1:write("MR hunqi," .. var_22_2.horcrux_mr .. "\n")
		var_22_1:write("SP hunqi," .. var_22_2.horcrux_sp .. "\n")
		var_22_1:flush()
		var_22_1:close()
	end

	print("Write Finish!!!!!")
end

local function var_0_14(arg_23_0, arg_23_1)
	if arg_23_1 then
		local var_23_0 = io.open(arg_23_0:gsub(" ", "_") .. os.time() .. ".csv", "a+")

		for iter_23_0, iter_23_1 in ipairs((json.decode(arg_23_1))) do
			var_23_0:write(table.concat(iter_23_1, ",") .. "\n")
			var_23_0:flush()
		end

		var_23_0:close()
	end

	print("Write Finish!!!!!")
end

function PopGMLayer:initSendBtn()
	local var_24_0 = ccui.Button:create("public/button/public_button_red.png", nil, "public/button/public_button_red.png", var_0_11)
	local var_24_1 = cc.Label:createWithTTF("冲冲冲", FONT_NAME, 28)

	var_24_1:setPosition(cc.p(var_24_0:getContentSize().width / 2, var_24_0:getContentSize().height / 2))
	var_24_0:addChild(var_24_1)
	var_24_0:setPosition(cc.p(320, 80))
	self.rootLayer:addChild(var_24_0)
	var_24_0:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_25_0 = self.editBox:getText()

		if var_0_12[self.selectIndex].sever == false and var_0_12[self.selectIndex].func then
			var_0_12[self.selectIndex].func(var_25_0)

			return
		end

		local network = require("network.network")

		print("sendText", var_25_0)
		network:rpc("gm_command", {
			msg = var_25_0
		}, function(arg_26_0)
			global_ShowBlockWords(arg_26_0.err or "gm error")

			if arg_26_0.result == 1 then
				if var_25_0:find("test_twist") then
					var_0_13(var_25_0, arg_26_0.list, arg_26_0.extra)
				elseif var_25_0:find("test_luck_twist") then
					var_0_14(var_25_0, arg_26_0.extra)
				else
					global_gain(arg_26_0)
				end
			end
		end)

		if var_25_0 == "one_key_tall_rich_handsome" then
			ConsoleExt.restart()
		end
	end)
end

function PopGMLayer:checkPlatform()
	if DeviceManager.platform ~= "windows" or config.packagechannel ~= "palmpi" then
		global_ShowBlockWords("ILLEGAL ENTRY !!!")
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			cc.Director:getInstance():endToLua()
		end)))
	end
end

local var_0_15

return {
	update = function(self)
		if not WindowM:getWindowStat("Gm") then
			return
		end

		local var_29_0, var_29_1 = imgui.begin("Gm", WindowM:getWindowStat("Gm"), {
			imgui.ImGuiWindowFlags_MenuBar
		})

		WindowM:setWindowStat("Gm", var_29_1)
		imgui.setWindowSize(1000, 800)
		imgui.text("是否为大图模式：" .. (not config._DEBUG and "是" or "否"))
		imgui.sameLine()
		imgui.helpMarker("将config._DEBUG = false即开启大图模式")
		imgui.text("服务器时间：" .. os.date("%c", time_check_manager:getCurTime()))
		imgui.text("使用的服务器节点：" .. config.clientbranch)

		for iter_29_0, iter_29_1 in pairs(var_0_12) do
			imgui.pushId(iter_29_0)
			imgui.setNextItemWidth(200)

			local var_29_2 = imgui.button(iter_29_1.name)

			imgui.sameLine()

			var_0_15, iter_29_1.param = imgui.inputText("", iter_29_1.param, 255)

			if var_29_2 then
				print("sendText", iter_29_1.param)

				local network = require("network.network")

				if iter_29_1.sever == false and iter_29_1.func then
					iter_29_1.func(iter_29_1.param)
					imgui.popId()
					imgui.endToLua()

					return
				end

				network:rpc("gm_command", {
					msg = iter_29_1.param
				}, function(arg_30_0)
					global_ShowBlockWords(arg_30_0.err or "gm error")

					if arg_30_0.result == 1 then
						if iter_29_1.param:find("test_twist") then
							var_0_13(iter_29_1.param, arg_30_0.list, arg_30_0.extra)
						elseif iter_29_1.param:find("test_luck_twist") then
							var_0_14(iter_29_1.param, arg_30_0.extra)
						elseif iter_29_1.param:find("eat_skill") then
							require("model.playermodel"):loadPlayerSoulsFromServer(function()
								sendNotification("HorcruxDevourSucceeded")
							end)
						else
							global_gain(arg_30_0)
						end
					end
				end)

				if iter_29_1.param == "one_key_tall_rich_handsome" then
					ConsoleExt.restart()
				end
			end

			imgui.popId()
		end

		self:horcruxDevour()
		imgui.endToLua()

		if not var_29_1 then
			imgui.clear()
		end
	end,
	init = function(arg_32_0)
		require("activity_main")

		local search_data_window = require("search_data_window")

		imgui:create()
		imgui:addImGui("GM", function()
			imgui.pushChineseFont()
			WindowM:setWindowStat("Gm", true)
			arg_32_0:update()
			imgui.popFont()
		end)
		imgui:addImGui("search", function()
			search_data_window:update()
		end)
	end,
	horcruxDevour = function(arg_35_0)
		if var_0_3 then
			if var_0_3._uilayer and var_0_3._poplayer then
				local var_35_0 = var_0_3._uilayer:getChildByName("EquipLayer")
				local var_35_1 = var_0_3._poplayer:getChildByName("SoulsLayer")
				local var_35_2

				if var_35_0 then
					var_35_2 = var_35_0.curSoul
				end

				if var_35_1 then
					var_35_2 = var_35_1.curSoul
				end

				if var_35_2 then
					imgui.text("servantId")
					imgui.sameLine()

					var_0_15 = imgui.inputText("", tostring(var_35_2), 255)

					for iter_35_0 = 1, HORCRUX_DEVOUR_MAX do
						local var_35_3 = var_0_2:getSkillInfo(var_35_2, iter_35_0)

						imgui.text("吞噬技能" .. iter_35_0 .. "id")
						imgui.sameLine()

						var_0_15 = imgui.inputText("", (var_35_3 or nil) and tostring(var_35_3.skillid), 255)
					end
				end
			end
		end
	end
}
