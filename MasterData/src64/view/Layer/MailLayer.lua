MailLayer = class("MailLayer", function()
	return cc.Layer:create()
end)

local mail_data = require("data.mail_data")
local item_data = require("data.item_data")
local postcard_data = require("data.postcard_data")
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local component_manager = require("controller.component_manager")
local mail_manager = require("controller.mail_manager")
local ItemSprite = require("view.Sprite.ItemSprite")

require("view.Layer.PopLayer")

local var_0_10 = {}
local var_0_11 = -1
local var_0_12 = config._DEBUG and 0 or 1
local var_0_13

function MailLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = MailLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function MailLayer:init(arg_3_1)
	var_0_13 = true
	self.exitCallback = arg_3_1 and arg_3_1.exitCallback or nil
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Mail.json" or "Mail.ExportJson")

	self:addChild(self.rootLayer)

	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_16")

	self.panel:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)

	self.nomailimg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_4")
	self.zhupanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_zhu")
	self.mailinfo = ccui.Helper:seekWidgetByName(self.rootLayer, "Img_maildi")
	self.ListView1 = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_6")
	self.ListView2 = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_7")
	self.items1 = ccui.Helper:seekWidgetByName(self.rootLayer, "awarditem")
	self.lefttime = ccui.Helper:seekWidgetByName(self.rootLayer, "lefttime_label")
	self.ListView3 = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_12")
	self.items2 = ccui.Helper:seekWidgetByName(self.rootLayer, "mailitem")
	self.btngetaward = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_getaward")

	self.btngetaward:getChildByName("Label_32"):setString("领取附件")

	self.deletbtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_delelt")
	self.getallbtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_getall")
	self.sendpeopeldi = ccui.Helper:seekWidgetByName(self.rootLayer, "sentmail_img")
	self.maillabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_sentpeopel")
	self.mailnuminfo = ccui.Helper:seekWidgetByName(self.rootLayer, "mailnum")
	self.roleimg = ccui.Helper:seekWidgetByName(self.rootLayer, "role_img")
	self.roleimgpenel = ccui.Helper:seekWidgetByName(self.rootLayer, "role_lihui_panel")

	self.items2:getChildByName("img_biezheng"):setVisible(false)
	self.maillabel:setString("")
	self.lefttime:setString("")
	self.nomailimg:setVisible(false)
	self.zhupanel:setVisible(false)
	self.zhupanel:setAnchorPoint(0.5, 0.5)
	self.zhupanel:setTouchEnabled(false)

	local function var_3_0(arg_4_0, arg_4_1)
		if arg_4_0 then
			self.nomailimg:setVisible(false)
			self.zhupanel:setVisible(true)
			self.zhupanel:setScale(1, 0)
			self.zhupanel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.1), cc.ScaleTo:create(0.05, 1, 1)))
		else
			self.nomailimg:setVisible(true)
			self.zhupanel:setVisible(false)
			self.nomailimg:runAction(cc.ScaleTo:create(0.05, 1, 0))
		end

		if arg_4_1 then
			arg_4_1()
		end
	end

	self.panel:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.zhupanel, function()
			LayerManager:removePopLayer()
		end)
	end)
	self.btngetaward:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:getAward(self.mails[self.rank], self.mails)
	end)
	self.deletbtn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:deletGetAwardMail()
	end)
	self.getallbtn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.mails then
			local var_9_0 = true

			for iter_9_0, iter_9_1 in pairs(self.mails) do
				if not iter_9_1.read then
					var_9_0 = false

					break
				end
			end

			if var_9_0 then
				global_ShowBlockWords(L_MAIL_EMPTY)

				return
			end
		end

		self:getAllMail()
	end)
	mail_manager:get_mail_list(function(arg_10_0)
		if not var_0_13 then
			return
		end

		if arg_10_0 and #arg_10_0 > 0 then
			l2Log("get_mail_data success")
			self:initMailPanel(arg_10_0)
			var_3_0(true)
		else
			l2Log("no mail")
			self.nomailimg:setVisible(true)
			self.zhupanel:setVisible(false)
		end
	end)
	self:registerScriptHandler(function(arg_12_0)
		if arg_12_0 == "exit" then
			AlertManager:unregister_alert(ALERT_MAIL, true)

			var_0_13 = nil
		end
	end)
	self:fullScreen(self.rootLayer)
end

local function var_0_14(arg_13_0, arg_13_1)
	local var_13_0, var_13_1, var_13_2, var_13_3, var_13_4, var_13_5 = string.match(arg_13_0, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local var_13_6, var_13_7, var_13_8, var_13_9, var_13_10, var_13_11 = string.match(arg_13_1, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local var_13_12 = {
		var_13_0,
		var_13_1,
		var_13_2,
		var_13_3,
		var_13_4,
		var_13_5
	}
	local var_13_13 = {
		var_13_6,
		var_13_7,
		var_13_8,
		var_13_9,
		var_13_10,
		var_13_11
	}

	for iter_13_0 = 1, 6 do
		if var_13_12[iter_13_0] > var_13_13[iter_13_0] then
			return 1
		elseif var_13_12[iter_13_0] < var_13_13[iter_13_0] then
			return 2
		end
	end

	return 3
end

local function var_0_16(arg_15_0)
	local var_15_0 = {}

	if arg_15_0 and next(arg_15_0) then
		var_15_0 = global_deepCopy(arg_15_0)

		table.sort(var_15_0, function(arg_16_0, arg_16_1)
			return global_get_time_by_date(arg_16_0.sendtime) > global_get_time_by_date(arg_16_1.sendtime)
		end)
	end

	return var_15_0
end

local function var_0_17(arg_17_0)
	local var_17_0 = 1

	if arg_17_0 and arg_17_0.slave and next(arg_17_0.slave) then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.slave) do
			if type(iter_17_1) == "number" and iter_17_1 ~= 0 or type(iter_17_1) == "table" and next(iter_17_1) ~= nil or type(iter_17_1) == "string" and iter_17_1 ~= "0" then
				var_17_0 = 0

				break
			else
				var_17_0 = 1
			end
		end
	end

	return var_17_0
end

function MailLayer:initBottomList()
	self:addChild(BottomBtnList:create(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.exitCallback then
			self.exitCallback()
		else
			local var_19_0 = cc.EventCustom:new("switchShowLayer")

			var_19_0.layerName = "MainLayer"

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_19_0)
		end
	end), 5)
end

function MailLayer:initMailPanel(arg_20_1, arg_20_2)
	self.ListView3:removeAllChildren()

	var_0_10 = {}

	if arg_20_1 == nil or #arg_20_1 == 0 then
		self.nomailimg:setVisible(true)
		self.zhupanel:setVisible(false)

		return
	else
		self.nomailimg:setVisible(false)
		self.zhupanel:setVisible(true)
	end

	local var_20_0 = {}
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		if not iter_20_1.read then
			table.insert(var_20_0, iter_20_1)
		else
			table.insert(var_20_1, iter_20_1)
		end
	end

	self.unReadMailNum = #var_20_0

	local var_20_3 = var_0_16(arg_20_1)

	self.mails = var_20_3

	for iter_20_2 = 1, #var_20_3 do
		self:initMailsInfo(var_20_3[iter_20_2], iter_20_2, var_20_3, arg_20_2)
	end

	self:changBtnImag()

	if arg_20_2 and arg_20_2 == 1 then
		self:showMailInfo(self.rank, self.mails[self.rank], self.mails)
	end
end

function MailLayer:initMailsInfo(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	var_0_10[arg_21_2] = self.items2:clone()

	var_0_10[arg_21_2]:setVisible(true)
	var_0_10[arg_21_2]:setOpacity(255)
	var_0_10[arg_21_2]:setAnchorPoint(cc.p(0.5, 0.5))
	var_0_10[arg_21_2]:setCascadeOpacityEnabled(false)
	self.ListView3:pushBackCustomItem(var_0_10[arg_21_2])

	local var_21_0 = string.sub(arg_21_1.mailid, 1, 1)
	local var_21_1 = arg_21_1.mailid:match("%d+$")
	local var_21_2 = RoleDefault:getInstance():getStringForKey("MailhasReadStr")
	local var_21_3, var_21_4, var_21_5, var_21_6, var_21_7, var_21_8 = string.match(arg_21_1.sendtime, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local var_21_12 = var_21_3 .. "-" .. var_21_4 .. "-" .. var_21_5

	if arg_21_1.read then
		var_0_10[arg_21_2]:getChildByName("img_biezheng"):setVisible(false)

		var_0_10[arg_21_2].readTag = 1

		var_0_10[arg_21_2]:getChildByName("lefttime_label_0"):setVisible(true)
		var_0_10[arg_21_2]:getChildByName("mail_getflag"):setVisible(false)
		var_0_10[arg_21_2]:getChildByName("img_nopen"):setVisible(false)
		var_0_10[arg_21_2]:getChildByName("img_open"):setVisible(true)
	else
		var_0_10[arg_21_2]:getChildByName("img_nopen"):setVisible(true)
		var_0_10[arg_21_2]:getChildByName("img_open"):setVisible(false)
		var_0_10[arg_21_2]:getChildByName("mail_getflag"):setVisible(false)
		var_0_10[arg_21_2]:getChildByName("lefttime_label_0"):setVisible(true)

		if arg_21_1.slave and next(arg_21_1.slave) then
			var_0_10[arg_21_2]:getChildByName("img_biezheng"):setVisible(true)
		else
			var_0_10[arg_21_2]:getChildByName("img_biezheng"):setVisible(false)
		end

		var_0_10[arg_21_2].readTag = 2
	end

	local var_21_14

	if arg_21_1.title ~= nil and string.len(arg_21_1.title) > 0 then
		var_21_14 = arg_21_1.title or mail_data[tonumber(var_21_1)].name
	end

	ccui.Helper:seekWidgetByName(var_0_10[arg_21_2], "mail_namelabel"):setString((not var_21_14 or var_21_14 == "") and L_MAIL_DEFAULT_TITLE or string.find(var_21_14, "@") and string.sub(var_21_14, 1, string.find(var_21_14, "@") - 1) or var_21_14)

	local var_21_15 = global_get_time_by_date(arg_21_1.expiretime) - os.time()
	local var_21_16 = math.ceil(var_21_15 / 86400)
	local var_21_17 = math.ceil(var_21_15 - var_21_16 * 24 * 3600 - math.ceil(var_21_15 - var_21_16 * 24 * 3600) / 3600 * 3600) / 60

	ccui.Helper:seekWidgetByName(var_0_10[arg_21_2], "lefttime_label_0"):setString(var_21_12)

	if (not arg_21_4 or arg_21_4 and arg_21_4 ~= 1) and arg_21_2 == 1 then
		self.rank = arg_21_2

		if var_0_10[arg_21_2].readTag == 2 and arg_21_1.slave and not next(arg_21_1.slave) then
			self.unReadMailNum = self.unReadMailNum - 1
			var_0_10[arg_21_2].readTag = 1

			var_0_10[arg_21_2]:getChildByName("img_open"):setVisible(true)
			var_0_10[arg_21_2]:getChildByName("img_nopen"):setVisible(false)
		end

		mail_manager:read_mail(arg_21_1.mailid)
		self:showMailInfo(index, arg_21_1, arg_21_3)
	end

	var_0_10[arg_21_2]:getChildByName("Button_14"):addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		for iter_22_0 = 1, #var_0_10 do
			if iter_22_0 == arg_21_2 then
				var_0_10[iter_22_0]:getChildByName("Button_14"):loadTextures("Mail/mailxuanzyhong.png", nil, "Mail/mailxuanzyhong.png", var_0_12)
			elseif var_0_10[iter_22_0] then
				var_0_10[iter_22_0]:getChildByName("Button_14"):loadTextures("Mail/commondi.png", nil, "Mail/commondi.png", var_0_12)
			end
		end

		self.rank = arg_21_2
		var_0_11 = -1

		if var_0_10[arg_21_2].readTag == 2 and arg_21_3[arg_21_2].slave and not next(arg_21_3[arg_21_2].slave) then
			self.unReadMailNum = self.unReadMailNum - 1
			var_0_10[arg_21_2].readTag = 1
		end

		mail_manager:read_mail(arg_21_3[arg_21_2].mailid)
		self:showMailInfo(arg_21_2, arg_21_3[arg_21_2], arg_21_3, function()
			arg_22_0:setTouchEnabled(true)
		end)
	end)
end

function MailLayer:showMailInfo(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if var_0_10 and var_0_10[arg_24_1] and var_0_10[arg_24_1].readTag == 1 then
		var_0_10[arg_24_1]:getChildByName("img_open"):setVisible(true)
		var_0_10[arg_24_1]:getChildByName("img_nopen"):setVisible(false)

		if arg_24_2 and arg_24_2.slave and not next(arg_24_2.slave) then
			for iter_24_0, iter_24_1 in ipairs(self.mails) do
				if iter_24_1.mailid == arg_24_2.mailid then
					iter_24_1.read = true

					break
				end
			end
		end
	end

	if arg_24_2 and arg_24_2.slave and next(arg_24_2.slave) then
		local l2utils = require("controller.l2utils")

		self.btngetaward:setVisible(true)

		if arg_24_2.read then
			l2utils:shaderNode(self.btngetaward:getVirtualRenderer(), true)
		else
			l2utils:recoverShader(self.btngetaward:getVirtualRenderer(), true)
		end
	else
		self.btngetaward:setVisible(false)
	end

	local var_24_1 = arg_24_2.mailid:match("%d+$")
	local var_24_2, var_24_3, var_24_4, var_24_5, var_24_6, var_24_7 = string.match(arg_24_2.sendtime, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

	self.postcard = -1

	if var_0_17(arg_24_2) == 0 then
		local var_24_10 = global_get_time_by_date(arg_24_2.expiretime) - os.time()
		local var_24_11 = math.ceil(var_24_10 / 86400)
		local var_24_12 = math.ceil(var_24_10 - var_24_11 * 24 * 3600) / 3600

		if var_24_11 >= 1 then
			self.lefttime:setString(L_TIME_REST .. string.format(L_TIME_SINGLE.Day, var_24_11))
		elseif var_24_12 >= 1 then
			self.lefttime:setString(L_TIME_REST .. string.format(L_TIME_SINGLE.Hour, var_24_11))
		elseif math.ceil(var_24_10 - var_24_11 * 24 * 3600 - var_24_12 * 3600) / 60 >= 1 then
			self.lefttime:setString(L_TIME_REST .. string.format(L_TIME_SINGLE.Minute, var_24_11))
		else
			self.lefttime:setString(L_TIME_SINGLE.Less)
		end
	end

	self:initAwardPanel(arg_24_2.slave, self:dealwithdata(1, arg_24_2, (tonumber(var_24_1))), arg_24_2.read)

	if arg_24_4 then
		arg_24_4()
	end

	self:updataMailNmber()
end

function MailLayer.dealwithdata(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_1 = var_0_17(arg_25_2)
	local var_25_2 = {}

	if arg_25_1 == 1 then
		local var_25_3

		if arg_25_2.title ~= nil and string.len(arg_25_2.title) > 0 then
			var_25_3 = arg_25_2.title or mail_data[arg_25_3] and mail_data[arg_25_3].name
		end

		local var_25_4
		local var_25_5
		local var_25_6

		if var_25_3 and var_25_3 ~= "" then
			local var_25_7 = {}

			for iter_25_0 in string.gmatch(var_25_3, "([^@]+)") do
				var_25_7[#var_25_7 + 1] = iter_25_0
			end

			var_25_6 = var_25_7[3]
			var_25_5 = var_25_7[2]
			var_25_4 = var_25_7[1] or var_25_3
		else
			var_25_4 = L_MAIL_DEFAULT_TITLE
		end

		if not var_25_5 or var_25_5 == "" then
			var_25_5 = L_MAIL_DEFAULT_SENDER_NAME
		end

		if not var_25_6 or var_25_6 == "" then
			var_25_6 = "100"
		end

		local var_25_8

		if arg_25_2.info ~= nil and string.len(arg_25_2.info) > 0 then
			var_25_8 = arg_25_2.info or mail_data[arg_25_3] and mail_data[arg_25_3].info

			if not var_25_8 or var_25_8 == "" then
				var_25_8 = L_MAIL_DEFAULT_INFO
			end
		end

		var_25_2.mailtitle = var_25_4
		var_25_2.mailsender = var_25_5
		var_25_2.mailpicture = var_25_6
		var_25_2.mailinfo = var_25_8
		var_25_2.mailid = arg_25_3
	elseif arg_25_1 == 2 then
		print("mail is nil")
	else
		print("nuknow error")
	end

	return var_25_2
end

function MailLayer:initAwardPanel(arg_26_1, arg_26_2, arg_26_3)
	self.maillabel:setString(L_MAIL_SENDER .. arg_26_2.mailsender)
	self.ListView1:removeAllChildren()
	self:initMainLabel(arg_26_2)
	self.roleimg:loadTexture("role/" .. arg_26_2.mailpicture .. ".png")
	self.roleimg:setScale(0.6)
	self.roleimg:setAnchorPoint(cc.p(0.5, 0.5))
	self.roleimg:setPosition(cc.p(self.roleimgpenel:getContentSize().width / 2 + 120, self.roleimgpenel:getContentSize().height / 2 - 170))
	self.roleimg:setOpacity(41)

	local function var_26_0(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
		local var_27_0 = ccui.Layout:create()

		var_27_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_27_0:setContentSize(cc.size(112, 120))

		local var_27_1 = ItemSprite:createNewWithItemId(arg_27_0, arg_27_1, nil, arg_27_2)
		local var_27_2 = var_27_1:getContentSize()

		var_27_1:setScale(0.65, 0.65)
		var_27_1:setAnchorPoint(cc.p(0.5, 0))
		var_27_1:setPosition(cc.p(56, 0))
		var_27_0:addChild(var_27_1, 8)

		local var_27_3 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "", var_0_12)

		var_27_3:setContentSize(cc.size(174, 228))
		var_27_3:setSwallowTouches(false)
		var_27_3:setScale(0.65, 0.65)
		var_27_3:setOpacity(0)
		var_27_3:setAnchorPoint(cc.p(0, 0))
		var_27_3:setColor(cc.c3b(255, 255, 255))
		var_27_3:setTouchEnabled(true)
		var_27_3:setPosition(cc.p(20, 65))
		var_27_1:addChild(var_27_3)

		local var_27_5 = {
			hideGainButton = true,
			itemid = arg_27_0,
			itemattr = arg_27_3
		}

		if type(arg_27_0) == "number" then
			-- block empty
		else
			return var_27_0
		end

		var_27_3:addTouchEventListener(function(arg_28_0, arg_28_1)
			if arg_28_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_28_0:getTouchBeganPosition().x - arg_28_0:getTouchEndPosition().x) > 30 then
				return
			end

			arg_28_0:setBright(false)

			local var_28_0 = PopLayer:Item(var_27_5)
		end)

		return var_27_0
	end

	local var_26_1 = {}

	if not arg_26_1 or not next(arg_26_1) then
		self.ListView2:removeAllChildren()

		return
	end

	local var_26_3 = tonumber(arg_26_1.gold)

	if var_26_3 and var_26_3 ~= 0 then
		var_26_1[#var_26_1 + 1] = var_26_0("gold", var_26_3, L_GOLD)
	end

	if arg_26_1.diamond and arg_26_1.diamond ~= 0 then
		var_26_1[#var_26_1 + 1] = var_26_0("diamond", arg_26_1.diamond, L_DIAMOND)
	end

	if arg_26_1.honor and arg_26_1.honor ~= 0 then
		var_26_1[#var_26_1 + 1] = var_26_0("honor", arg_26_1.honor, L_PLAYER_DATA_TYPE.Honor)
	end

	if arg_26_1.postcard and postcard_data[arg_26_1.postcard].image then
		self.postcard = arg_26_1.postcard
		var_26_1[#var_26_1 + 1] = (function(arg_29_0, arg_29_1, arg_29_2)
			local var_29_0 = ccui.ImageView:create("mainScenebg/postcard/" .. postcard_data[arg_29_1].image .. ".png")

			var_29_0.postcard = true

			var_29_0:setScale(math.max(113.10000000000001 / var_29_0:getContentSize().width, 148.20000000000002 / var_29_0:getContentSize().height))
			var_29_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_29_0:setTouchEnabled(true)
			var_29_0:addTouchEventListener(function(arg_30_0, arg_30_1)
				if arg_30_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:showPostcard(arg_29_1)
			end)

			return var_29_0
		end)("postcard", arg_26_1.postcard, L_PLAYER_DATA_TYPE.Postcard)
	end

	if arg_26_1.items and #arg_26_1.items ~= 0 then
		for iter_26_0, iter_26_1 in pairs(arg_26_1.items) do
			var_26_1[#var_26_1 + 1] = item_data[iter_26_1.dropid].bag_item_type == kITEM_COMPONENT and var_26_0(iter_26_1.dropid, iter_26_1.dropNum, item_data[iter_26_1.dropid].name, iter_26_1.item_attr) or var_26_0(iter_26_1.dropid, iter_26_1.dropNum, item_data[iter_26_1.dropid].name, iter_26_1.item_attr)
		end
	end

	self.ListView2:removeAllChildren()
	self.ListView2:setItemsMargin(2)

	for iter_26_2 = 1, #var_26_1 do
		local var_26_4 = self.items1:clone()

		var_26_4:getChildByName("award_img"):setOpacity(0)
		var_26_4:getChildByName("award_img"):setCascadeOpacityEnabled(false)

		if not var_26_1[iter_26_2].postcard then
			var_26_1[iter_26_2]:setPosition(cc.p(var_26_4:getChildByName("award_img"):getContentSize().width / 2 + 2, var_26_4:getChildByName("award_img"):getContentSize().height / 2 + 28))
		else
			var_26_4:setContentSize(cc.size(var_26_1[iter_26_2]:getContentSize().width * var_26_1[iter_26_2]:getScaleX() + 20, 200))
			var_26_1[iter_26_2]:setPosition(cc.p(var_26_4:getChildByName("award_img"):getContentSize().width / 2 + 65, var_26_4:getChildByName("award_img"):getContentSize().height / 2 + 43))
		end

		var_26_4:getChildByName("award_img"):addChild(var_26_1[iter_26_2])

		if iter_26_2 == 1 then
			var_26_4:getChildByName("award_name"):setVisible(true)
		else
			var_26_4:getChildByName("award_name"):setVisible(false)
		end

		if arg_26_3 then
			local var_26_7 = var_26_1[iter_26_2]:getContentSize()
			local var_26_8 = var_26_1[iter_26_2]:getScaleX()
			local var_26_9 = ccui.Layout:create()

			if not var_26_1[iter_26_2].postcard then
				var_26_9:setContentSize(cc.size(var_26_7.width * var_26_8, var_26_7.height * var_26_8 + 28))
			else
				var_26_9:setContentSize(cc.size(var_26_7.width * var_26_8, var_26_7.height * var_26_8))
			end

			var_26_9:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_26_9:setCascadeOpacityEnabled(false)
			var_26_9:setBackGroundColorOpacity(190)
			var_26_9:setAnchorPoint(0.5, 0.5)
			var_26_9:setBackGroundColor(cc.c3b(0, 0, 0))
			var_26_9:setTouchEnabled(false)

			if not var_26_1[iter_26_2].postcard then
				var_26_9:setPosition(cc.p(var_26_4:getContentSize().width / 2 + 1, var_26_4:getContentSize().height / 2 + 25))
			else
				var_26_9:setPosition(cc.p(var_26_4:getContentSize().width / 2, var_26_4:getContentSize().height / 2 + 24))
			end

			var_26_4:addChild(var_26_9, 0)

			local var_26_10 = ccui.ImageView:create("Mail/fragment_tic_new.png", var_0_12)

			var_26_10:setScale(0.6)
			var_26_10:setAnchorPoint(cc.p(0, 1))

			if not var_26_1[iter_26_2].postcard then
				var_26_10:setPosition(cc.p(0, var_26_9:getContentSize().height))
			else
				var_26_10:setPosition(cc.p(var_26_9:getContentSize().width / 2 + 86, var_26_9:getContentSize().height - 116))
			end

			var_26_9:addChild(var_26_10)
		end

		self.ListView2:pushBackCustomItem(var_26_4)
	end
end

function MailLayer.deletGetAwardMail(arg_31_0)
	mail_manager:delete_mail_one_key(function(arg_32_0)
		if not var_0_13 then
			return
		end

		arg_31_0.mails = arg_32_0

		arg_31_0:initMailPanel(arg_31_0.mails)
	end)
end

function MailLayer:changBtnImag()
	for iter_33_0 = 1, #self.mails do
		if iter_33_0 == self.rank then
			if var_0_10[iter_33_0]:getChildByName("Button_14") then
				var_0_10[iter_33_0]:getChildByName("Button_14"):loadTextures("Mail/mailxuanzyhong.png", nil, "Mail/mailxuanzyhong.png", var_0_12)
			end
		elseif var_0_10[iter_33_0]:getChildByName("Button_14") then
			var_0_10[iter_33_0]:getChildByName("Button_14"):loadTextures("Mail/commondi.png", nil, "Mail/commondi.png", var_0_12)
		end
	end
end

function MailLayer:updataMailNmber()
	local var_34_1 = 0

	for iter_34_0, iter_34_1 in pairs(self.mails) do
		if iter_34_1.read then
			var_34_1 = var_34_1 + 1
		end
	end

	self.mailnuminfo:getChildByName("Label_4"):setString(#self.mails - var_34_1)
end

function MailLayer.getAllMail(arg_35_0)
	mail_manager:get_mail_drops_one_key(DeviceManager:getChannelID(), function(arg_36_0, arg_36_1)
		if not var_0_13 then
			return
		end

		if arg_36_0 == 1 then
			arg_35_0.mails = arg_36_1

			arg_35_0:initMailPanel(arg_35_0.mails)
		else
			global_ShowBlockWords(L_MAIL_EMPTY)
		end
	end)
end

function MailLayer.getAward(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1.slave and next(arg_37_1.slave) then
		mail_manager:get_mail_drops(arg_37_1.mailid, function(arg_38_0, arg_38_1)
			if not var_0_13 then
				return
			end

			if arg_38_0 == 1 then
				for iter_38_0, iter_38_1 in ipairs(arg_37_0.mails) do
					if iter_38_1.mailid == arg_37_1.mailid then
						iter_38_1.read = true

						break
					end
				end

				AnalyticManager.click_getmail()
				arg_37_0:initMailPanel(arg_37_0.mails, 1)
			elseif arg_38_0 == 2 then
				global_ShowBlockWords(L_MAIL_HAVEGOT)
			else
				global_ShowBlockWords(L_MAIL_NIL)
			end
		end)
	else
		global_ShowBlockWords(L_MAIL_NO_AWARD)
	end
end

function MailLayer.showPostcard(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1 and postcard_data[arg_39_1].image or 1
	local var_39_1 = ccui.Layout:create()

	var_39_1:setContentSize(cc.size(640, GameDisplay.height))
	var_39_1:setPosition(0, 0)
	var_39_1:setTouchEnabled(true)
	global_basic_scene:addChild(var_39_1, 999)
	var_39_1:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_39_1:runAction(cc.RemoveSelf:create())
	end)

	local var_39_2 = cc.Sprite:create("mainScenebg/postcard/" .. var_39_0 .. ".png")

	var_39_2:setPosition(320, GameDisplay.height / 2)
	var_39_2:setScale(0.2)
	var_39_2:setOpacity(0)
	var_39_2:runAction(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1, 1)))
	var_39_1:addChild(var_39_2)
end

function MailLayer.initMainLabel(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_1.mailid
	local var_41_1 = {}
	local var_41_2 = false
	local var_41_3

	if not string.find(arg_41_1.mailinfo, "</a>") then
		var_41_1[1] = {
			type = "p",
			des = arg_41_1.mailinfo
		}
	else
		for iter_41_0 in arg_41_1.mailinfo:gmatch("([^<^>]+)") do
			if string.find(iter_41_0, "herf=") then
				var_41_2 = true
				var_41_3 = iter_41_0:match("herf=(.+)")
			elseif string.find(iter_41_0, "/a") then
				var_41_2 = false
				var_41_3 = nil
			else
				table.insert(var_41_1, {
					des = iter_41_0,
					type = var_41_2 and "a" or "p",
					url = var_41_3
				})
			end
		end
	end

	local var_41_4 = {
		a = function(arg_42_0, arg_42_1)
			local var_42_0 = ccui.Button:create("public/button/hyperlink_button.png", "public/button/hyperlink_button.png", "public/button/hyperlink_button.png", config._DEBUG and 0 or 1)

			var_42_0:setScale9Enabled(true)
			var_42_0:setCapInsets(cc.rect(0, 0, 10, 1))

			local var_42_1 = cc.Label:createWithTTF(arg_42_1.des, FONT_DES, 22)

			var_42_1:setAnchorPoint(0.5, 0.5)
			var_42_1:setColor(cc.c3b(0, 187, 255))
			var_42_0:setContentSize(cc.size(var_42_1:getContentSize().width, var_42_1:getContentSize().height + 5))
			var_42_1:setPosition(cc.p(var_42_1:getContentSize().width / 2, var_42_1:getContentSize().height / 2 + 2.5))
			var_42_0:addChild(var_42_1)
			var_42_0:addTouchEventListener(function(arg_43_0, arg_43_1)
				if arg_43_1 == ccui.TouchEventType.began then
					arg_43_0:setScale(1.1)
					var_42_1:setScale(1)
				end

				if arg_43_1 == ccui.TouchEventType.canceled then
					arg_43_0:setScale(1)
					var_42_1:setScale(1)
				end

				if arg_43_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_43_0:setScale(1)
				var_42_1:setScale(1)
				DeviceManager.openURL(arg_42_1.url)
				mail_manager:click_hyperlink(var_41_0)
				AnalyticManager.click_mail_url({
					url = arg_42_1.url
				})
			end)
			arg_41_0.ListView1:pushBackCustomItem(var_42_0)
		end,
		p = function(arg_44_0, arg_44_1)
			local var_44_0 = ccui.Layout:create()

			var_44_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_44_0:setContentSize(cc.size(440, 300))
			var_44_0:setTouchEnabled(false)

			local var_44_1 = cc.Label:createWithTTF("1", FONT_DES, 22)

			var_44_1:setMaxLineWidth(440)
			var_44_1:setAnchorPoint(cc.p(0, 1))
			var_44_1:setColor(cc.c3b(228, 241, 255))
			var_44_1:setName("Label_word" .. arg_44_0)
			var_44_1:setString(arg_44_1.des)
			var_44_0:addChild(var_44_1)
			var_44_0:setContentSize(cc.size(440, var_44_1:getContentSize().height + 10))
			var_44_1:setPosition(cc.p(0, var_44_0:getContentSize().height))
			arg_41_0.ListView1:pushBackCustomItem(var_44_0)
		end
	}

	for iter_41_1, iter_41_2 in ipairs(var_41_1) do
		var_41_4[iter_41_2.type](iter_41_1, iter_41_2)
	end
end

function MailLayer:initBg(arg_45_1)
	local var_45_0 = ccui.Layout:create()

	var_45_0:setTouchEnabled(true)
	var_45_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_45_0:setAnchorPoint(cc.p(0, 0))
	var_45_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_45_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_45_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_45_0:setOpacity(0)
	self:addChild(var_45_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_46_0)
		self:addChild(arg_46_0, -2)
		arg_46_0:setPositionY(arg_46_0:getPositionY() - GameDisplay.fix_y)

		local var_46_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_46_0:setAnchorPoint(cc.p(0, 0))
		var_46_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_46_0, -1)
		self:init(arg_45_1, initInfo)
		var_45_0:setOpacity(102)
		var_45_0:setTouchEnabled(false)
	end)
end

function MailLayer:fullScreen(arg_47_1)
	local var_47_0 = GameDisplay.getScreenSize()

	arg_47_1:setContentSize(var_47_0)
	arg_47_1:setPositionY(arg_47_1:getPositionY() - GameDisplay.fix_y)
	self.zhupanel:setPosition(cc.p(var_47_0.width / 2, var_47_0.height / 2))
	self.nomailimg:setPositionY(self.nomailimg:getPositionY() + GameDisplay.fix_y)
	self.mailnuminfo:setPositionY(self.mailnuminfo:getPositionY() - GameDisplay.fix_y)
end
