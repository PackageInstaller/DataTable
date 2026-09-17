SoulServantInfo = class("SoulServantInfo", function()
	return cc.Layer:create()
end)

local audio_manager = require("controller.audio_manager")
local item_manager = require("controller.item_manager")
local role_conversation_data = require("data.role_conversation_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local servant_data = require("data.servant_data")
local photofile_data = require("data.photofile_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local role_conversation_index_data = require("data.role_conversation_index_data")
local marry_data = require("data.marry_data")
local var_0_12 = {
	ROLE_CONVERSATION_TYPE.home,
	ROLE_CONVERSATION_TYPE.changeShowgilr,
	ROLE_CONVERSATION_TYPE.mainTouch,
	ROLE_CONVERSATION_TYPE.fight,
	ROLE_CONVERSATION_TYPE.passlevel,
	ROLE_CONVERSATION_TYPE.lose,
	ROLE_CONVERSATION_TYPE.dormTouch,
	ROLE_CONVERSATION_TYPE.favorUpgrade,
	ROLE_CONVERSATION_TYPE.gift,
	ROLE_CONVERSATION_TYPE.changeDress,
	ROLE_CONVERSATION_TYPE.angry,
	ROLE_CONVERSATION_TYPE.win,
	ROLE_CONVERSATION_TYPE.dormDaily,
	ROLE_CONVERSATION_TYPE.dormFirst,
	ROLE_CONVERSATION_TYPE.xp,
	ROLE_CONVERSATION_TYPE.marry
}
local var_0_13 = {
	[ROLE_CONVERSATION_TYPE.home] = 0,
	[ROLE_CONVERSATION_TYPE.changeShowgilr] = 1,
	[ROLE_CONVERSATION_TYPE.mainTouch] = 16,
	[ROLE_CONVERSATION_TYPE.fight] = 4,
	[ROLE_CONVERSATION_TYPE.passlevel] = 5,
	[ROLE_CONVERSATION_TYPE.lose] = 6,
	[ROLE_CONVERSATION_TYPE.dormTouch] = 7,
	[ROLE_CONVERSATION_TYPE.favorUpgrade] = 8,
	[ROLE_CONVERSATION_TYPE.gift] = 9,
	[ROLE_CONVERSATION_TYPE.changeDress] = 10,
	[ROLE_CONVERSATION_TYPE.angry] = 11,
	[ROLE_CONVERSATION_TYPE.win] = 12,
	[ROLE_CONVERSATION_TYPE.dormDaily] = 13,
	[ROLE_CONVERSATION_TYPE.dormFirst] = 14,
	[ROLE_CONVERSATION_TYPE.xp] = 15,
	[ROLE_CONVERSATION_TYPE.marry] = 2
}

function SoulServantInfo.create(arg_2_0, arg_2_1)
	local var_2_0 = SoulServantInfo.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function SoulServantInfo:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Soul_servant_info.json" or "Soul_servant_info.ExportJson")

	self:addChild(self.rootLayer)

	self.initParam = arg_3_1

	self:initDownload()
	self:initData(arg_3_1)
	self:initUI()
	self:updateUI()

	self.activity = true
	self.callback = arg_3_1.callback

	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.callback then
				self.callback()
			end

			self.activity = false
		end
	end)
	AnalyticManager.click_soul_servant_info({
		servantid = self.servantid
	})
end

function SoulServantInfo:getAllSound()
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(role_conversation_index_data[tostring(servant_data[self.servantid].major)]) do
		for iter_5_2, iter_5_3 in pairs(ROLE_CONVERSATION_TYPE_TO_STR) do
			if not var_5_1[iter_5_1] and string.find(iter_5_0, iter_5_3) then
				var_5_1[iter_5_1] = {}
				var_5_1[iter_5_1].classification = iter_5_1
				var_5_1[iter_5_1].talktype = iter_5_3
				var_5_1[iter_5_1].major = servant_data[self.servantid].major
				var_5_1[iter_5_1].talkid = iter_5_2
			end
		end
	end

	if role_conversation_index_data[item_data[marry_data[servant_data[self.servantid].major].skin].model] and role_conversation_index_data[item_data[marry_data[servant_data[self.servantid].major].skin].model].marry then
		for iter_5_4, iter_5_5 in pairs(role_conversation_data) do
			if iter_5_5.classification == role_conversation_index_data[item_data[marry_data[servant_data[self.servantid].major].skin].model].marry and iter_5_5.sound and not var_5_1.marry then
				var_5_1.marry = {}
				var_5_1.marry.classification = role_conversation_index_data[item_data[marry_data[servant_data[self.servantid].major].skin].model].marry
				var_5_1.marry.talktype = "marry"
				var_5_1.marry.major = servant_data[self.servantid].major
				var_5_1.marry.talkid = ROLE_CONVERSATION_TYPE.marry or ""
				var_5_1.marry.itemid = marry_data[servant_data[self.servantid].major].skin
				var_5_1.marry.sound = iter_5_5.sound
			end
		end
	end

	local var_5_2 = 1

	while major_factor_data[servant_data[self.servantid].major]["item" .. var_5_2] do
		if major_factor_data[servant_data[self.servantid].major]["item" .. var_5_2 .. "_hide"] ~= 1 then
			if not role_conversation_index_data[tostring(item_data[major_factor_data[servant_data[self.servantid].major]["item" .. var_5_2]].model)] then
				break
			end

			for iter_5_6, iter_5_7 in pairs(role_conversation_index_data[tostring(item_data[major_factor_data[servant_data[self.servantid].major]["item" .. var_5_2]].model)]) do
				for iter_5_8, iter_5_9 in pairs(ROLE_CONVERSATION_TYPE_TO_STR) do
					if not var_5_1[iter_5_7] and string.find(iter_5_6, iter_5_9) then
						var_5_1[iter_5_7] = {}
						var_5_1[iter_5_7].classification = iter_5_7
						var_5_1[iter_5_7].talktype = iter_5_9
						var_5_1[iter_5_7].itemid = major_factor_data[servant_data[self.servantid].major]["item" .. var_5_2]
						var_5_1[iter_5_7].modelid = item_data[major_factor_data[servant_data[self.servantid].major]["item" .. var_5_2]].model
						var_5_1[iter_5_7].talkid = iter_5_8
					end
				end
			end
		end

		var_5_2 = var_5_2 + 1
	end

	local var_5_3 = {}

	for iter_5_10, iter_5_11 in pairs(servant_data) do
		if iter_5_11.major == servant_data[self.servantid].major and iter_5_11.id == self.servantid then
			table.insert(var_5_3, iter_5_11.id)
		end
	end

	for iter_5_12, iter_5_13 in pairs(var_5_3) do
		if role_conversation_index_data[servant_data[iter_5_13].modelid] then
			for iter_5_14, iter_5_15 in pairs(role_conversation_index_data[tostring(servant_data[iter_5_13].modelid)]) do
				for iter_5_16, iter_5_17 in pairs(ROLE_CONVERSATION_TYPE_TO_STR) do
					if not var_5_1[iter_5_15] and string.find(iter_5_14, iter_5_17) then
						var_5_1[iter_5_15] = {}
						var_5_1[iter_5_15].classification = iter_5_15
						var_5_1[iter_5_15].talktype = iter_5_17
						var_5_1[iter_5_15].modelid = servant_data[iter_5_13].modelid
						var_5_1[iter_5_15].servantid = iter_5_13
						var_5_1[iter_5_15].talkid = iter_5_16
					end
				end
			end
		end
	end

	local var_5_4 = {}

	for iter_5_18, iter_5_19 in pairs(var_5_1) do
		for iter_5_20, iter_5_21 in pairs(role_conversation_data) do
			if iter_5_21.classification == iter_5_19.classification and iter_5_21.sound and not var_5_4[iter_5_21.sound] then
				local var_5_5 = {
					type = iter_5_19.talkid
				}

				var_5_5.des = L_ROLE_CONVERSATION_TYPE_DES[iter_5_19.talkid] or ""
				var_5_5.sound = iter_5_21.sound
				var_5_5.talkDec = iter_5_21.dec
				var_5_5.talkid = iter_5_19.talkid
				var_5_5.talktype = iter_5_19.talktype
				var_5_5.itemid = iter_5_19.itemid
				var_5_5.major = iter_5_19.major
				var_5_5.id = iter_5_21.id
				var_5_5.expression = iter_5_21.expression
				var_5_4[iter_5_21.sound] = var_5_5
			end
		end
	end

	return var_5_4
end

function SoulServantInfo:initData(arg_6_1)
	self.servantid = arg_6_1.servantid
	self.showType = "info"
	self.modelid = global_get_servant_skin(self.servantid)

	local var_6_0 = 1

	for iter_6_0, iter_6_1 in pairs(photofile_data) do
		if tonumber(iter_6_1.servant_id) == self.servantid then
			var_6_0 = iter_6_1.id
		end
	end

	self.cvName = favorfile_data[3][var_6_0] or L_CV_UNSURE
	self.painterName = model_data[self.modelid].painter
	self.voiceList = {}
	self.playing = {}

	if role_conversation_index_data[tostring(servant_data[self.servantid].major)] then
		for iter_6_2, iter_6_3 in pairs((self:getAllSound())) do
			table.insert(self.voiceList, iter_6_3)
		end
	end

	local var_6_7
	local var_6_6

	do
		print("这个对话还在读“三层结构”", self.servantid)

		local var_6_1 = {}

		table.insert(var_6_1, servant_data[self.servantid].modelid)

		while servant_data[self.servantid]["modelid" .. 1] do
			table.insert(var_6_1, servant_data[self.servantid]["modelid" .. 1])
		end

		local var_6_3 = {}

		for iter_6_4, iter_6_5 in pairs(var_0_12) do
			for iter_6_6, iter_6_7 in pairs(var_6_1) do
				local var_6_4 = GenerateRoleConversationClass(iter_6_7, iter_6_5)

				for iter_6_8, iter_6_9 in pairs(role_conversation_data) do
					if iter_6_9.classification == var_6_4 and iter_6_9.sound and not var_6_3[iter_6_9.sound] then
						var_6_3[iter_6_9.sound] = iter_6_9.sound

						local var_6_5 = {
							type = iter_6_5
						}

						var_6_5.des = L_ROLE_CONVERSATION_TYPE_DES[iter_6_5] or ""
						var_6_5.sound = iter_6_9.sound
						var_6_5.talkDec = iter_6_9.dec

						table.insert(self.voiceList, var_6_5)
					end
				end
			end
		end

		var_6_6 = {
			[3] = {
				weight = 3,
				func = function(self, arg_9_1)
					local var_9_0 = 0
					local var_9_1 = 0

					if self.itemid and item_manager:getItemNumber(self.itemid) == 0 then
						var_9_0 = 1
					end

					if arg_9_1.itemid and item_manager:getItemNumber(arg_9_1.itemid) == 0 then
						var_9_1 = 1
					end

					if var_9_0 == var_9_1 then
						return "=="
					else
						return var_9_0 < var_9_1
					end
				end
			},
			[2] = {
				weight = 1,
				func = function(self, arg_8_1)
					return tonumber(self.id or 10000000) < tonumber(arg_8_1.id or 10000000)
				end
			}
		}
		var_6_7 = {
			weight = 2
		}
	end

	function var_6_7:func(arg_7_1)
		local var_7_0 = var_0_13[self.type] or 100
		local var_7_1 = var_0_13[arg_7_1.type] or 100

		if var_7_0 == var_7_1 then
			return "=="
		else
			return var_7_0 < var_7_1
		end
	end

	var_6_6[1] = var_6_7

	table.sort(var_6_6, function(arg_10_0, arg_10_1)
		return arg_10_0.weight > arg_10_1.weight
	end)
	table.sort(self.voiceList, function(arg_11_0, arg_11_1)
		for iter_11_0 = 1, #var_6_6 do
			if var_6_6[iter_11_0].func(arg_11_0, arg_11_1) ~= "==" then
				return var_6_6[iter_11_0].func(arg_11_0, arg_11_1)
			end
		end
	end)

	local var_6_8 = 0
	local var_6_9

	for iter_6_10, iter_6_11 in pairs(self.voiceList) do
		if not var_6_9 then
			var_6_9 = iter_6_11.type
			var_6_8 = 1
		end

		if var_6_9 ~= iter_6_11.type then
			var_6_9 = iter_6_11.type
			var_6_8 = 1
		end

		iter_6_11.tag = var_6_8
		var_6_8 = var_6_8 + 1
	end

	local var_6_10 = {}

	for iter_6_12, iter_6_13 in pairs(self.voiceList) do
		var_6_10[iter_6_13.type] = var_6_10[iter_6_13.type] or 0
		var_6_10[iter_6_13.type] = var_6_10[iter_6_13.type] + 1
	end

	for iter_6_14, iter_6_15 in pairs(self.voiceList) do
		if var_6_10[iter_6_15.type] == 1 then
			iter_6_15.tag = nil
		end
	end
end

function SoulServantInfo:initUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	self.backTouchLayer = ccui.Layout:create()

	self.backTouchLayer:setTouchEnabled(true)
	self.backTouchLayer:setVisible(false)
	self.backTouchLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.backTouchLayer:setAnchorPoint(cc.p(0, 0))
	self.backTouchLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.backTouchLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.backTouchLayer:setBackGroundColor(cc.c3b(2, 5, 24))
	self.backTouchLayer:setOpacity(0)
	self.backTouchLayer:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showAll = nil

		self:updateShowAllPanel()
	end)
	self:addChild(self.backTouchLayer, 10000)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):setPositionY(126 - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setPositionY(-GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):setPositionY(-600)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):getPositionY() - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cellBg"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg"):setVisible(false)

	local var_12_0 = cc.Label:createWithTTF("", FONT_DES, 26)

	var_12_0:setColor(cc.c3b(232, 238, 248))
	var_12_0:setAnchorPoint(cc.p(0, 1))
	var_12_0:setName("label")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg"):addChild(var_12_0)

	local var_12_1 = ccui.TextBMFont:create(major_factor_data[servant_data[self.servantid].major].easy_name, "fonts/role_name.fnt")

	var_12_1:setPositionX(0)
	var_12_1:setPositionY(5)
	var_12_1:setAnchorPoint(cc.p(0, 0))
	var_12_1:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_name"):addChild(var_12_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_name"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_name"):getPositionY() + GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_englishName"):setPositionY(var_12_1:getPositionY() + var_12_1:getContentSize().height)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_englishName"):setString(model_data[major_factor_data[servant_data[self.servantid].major].model].English_name)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_englishName"):setColor(cc.c3b(242, 242, 242))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_Big"):setPositionY(GameDisplay.height - GameDisplay.fix_y - 60)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cv"):addTouchEventListener(function()
		if touchType ~= ccui.TouchEventType.ended then
			return
		end

		self.showType = "voice"

		self:updateUI()
		self:changeType()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showType = "info"

		self:updateUI()
		self:changeType()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_microphone"):addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if #self.voiceList == 0 then
			return
		end

		self.showType = "voice"

		self:updateUI()
		self:changeType()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_microphone"):setVisible(#self.voiceList > 0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_painter"):addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if #self.voiceList == 0 then
			return
		end

		self.showType = "voice"

		self:updateUI()
		self:changeType()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_Big"):addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showAll = true

		self:updateShowAllPanel()
	end)
	self:createTableView()
end

function SoulServantInfo:updateUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_cvName1"):setString(self.cvName)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_cvName2"):setString(self.cvName)

	if self.painterName then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_painterName"):setString(self.painterName)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_painterName"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cv"):setVisible(true)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_painterName"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cv"):setVisible(false)
	end
end

function SoulServantInfo:updateShowAllPanel(...)
	if self.showAll then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_Big"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_name"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):setVisible(false)
		self.backTouchLayer:setVisible(true)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_Big"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_name"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):setVisible(true)
		self.backTouchLayer:setVisible(false)
		self:changeType()
	end
end

function SoulServantInfo:changeType()
	if self.showType == "voice" then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):runAction(cc.MoveTo:create(0.1, cc.p(124, -600)))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setVisible(true)
		self:checkResource()
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.MoveTo:create(0.1, cc.p(320, -600)))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):runAction(cc.MoveTo:create(0.1, cc.p(124, 69)))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setVisible(false)
	end
end

require("controller.filedownloader.download_node_utils"):addDownloadInterface(SoulServantInfo)

function SoulServantInfo:checkResource()
	self._downloadinglist = {}

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.voiceList) do
		table.insert(var_23_0, "sound/role_voice/" .. iter_23_1.sound .. ".ogg")
	end

	local var_23_1, var_23_2 = require("controller.filedownloader.file_check_manager"):checkFileNeedDownloadByList(var_23_0)

	if var_23_1 then
		self:onDownloadProcessing()
		self:startDownload(var_23_2)
	else
		self:onDownloadComplete()
	end
end

function SoulServantInfo:onDownloadProcessing()
	if self._loadingani then
		self._loadingani:setVisible(true)
		self._loadingani:play()

		return
	end

	self._loadingani = require("view.Sprite.LoadingSprite"):create()

	self._loadingani:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):addChild(self._loadingani)
end

function SoulServantInfo:onDownloadComplete()
	if self._loadingani then
		self._loadingani:stop()
		self._loadingani:setVisible(false)
	end

	if self.showType ~= "voice" then
		return
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.MoveTo:create(0.1, cc.p(320, 286)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):runAction(cc.MoveTo:create(0.1, cc.p(124, -600)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setVisible(true)
end

function SoulServantInfo:playVoice(arg_26_1, arg_26_2, arg_26_3)
	AnalyticManager.soul_servant_info_playvoice({
		servantid = self.servantid,
		sound = arg_26_1
	})

	if audio_manager:isPlayerSoundValid() then
		self.playing[arg_26_1] = self.playing[arg_26_1] or 0
		self.playing[arg_26_1] = self.playing[arg_26_1] + 1

		audio_manager:stopAllRoleSound()
		self:startPlayVoiceAni(arg_26_2)
		self:setFace(arg_26_3)
		audio_manager:playPlayerSound("sound/role_voice/" .. arg_26_1, nil, nil, function()
			if self.activity then
				if self.playing[arg_26_1] then
					self.playing[arg_26_1] = self.playing[arg_26_1] - 1
				end

				if self.playing[arg_26_1] == 0 then
					self.playing[arg_26_1] = nil
				end

				local var_27_0 = 0

				for iter_27_0, iter_27_1 in pairs(self.playing) do
					var_27_0 = var_27_0 + 1
				end

				if var_27_0 == 0 then
					self:stopPlayVoiceAni()
					self:resetFace()
				end

				self:updateShowingCells()
			end
		end)
	else
		if not self.timer then
			self.timer = cc.Node:create()

			self:addChild(self.timer)
		end

		local var_26_0 = 0

		for iter_26_0, iter_26_1 in pairs(self.playing) do
			var_26_0 = var_26_0 + 1
		end

		if var_26_0 > 0 then
			self.timer:stopAllActions()

			self.playing = {}
		end

		self.playing[arg_26_1] = nil

		self:startPlayVoiceAni(arg_26_2)
		self:setFace(arg_26_3)
		self.timer:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
			if self.activity then
				self.playing = {}

				self:updateShowingCells()
				self:stopPlayVoiceAni()
				self:resetFace()
			end
		end)))
	end
end

function SoulServantInfo:setFace(arg_29_1)
	if not arg_29_1 then
		self:resetFace()
	end
end

function SoulServantInfo.resetFace(arg_30_0)
	return
end

function SoulServantInfo:startPlayVoiceAni(arg_31_1)
	local var_31_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg")

	var_31_0:setVisible(true)

	local var_31_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg"):getChildByName("label")

	var_31_1:setMaxLineWidth(450)
	var_31_1:setString(arg_31_1)

	local var_31_2 = math.max(var_31_1:getContentSize().height + 30, 88)

	var_31_0:setContentSize(cc.size(var_31_0:getContentSize().width, var_31_2))
	var_31_1:setPosition(cc.p(10, var_31_2 - 20))
end

function SoulServantInfo:stopPlayVoiceAni()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg"):setVisible(false)
end

local var_0_14 = 32
local var_0_15 = 20
local var_0_16 = 554
local var_0_17 = 271
local var_0_18 = 70
local var_0_19 = 271

function SoulServantInfo:createTableView()
	self.voiceTableView = cc.TableView:create(cc.size(var_0_16, var_0_17))
	self.voiceTableView.displayheight = tv_height

	self.voiceTableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	self.voiceTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.voiceTableView:setPosition(cc.p(var_0_14, var_0_15))
	self.voiceTableView:setDelegate()
	self.voiceTableView:setName("voiceTableView")

	self.voiceTableView.anchorPoint = cc.p(0, 0)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):addChild(self.voiceTableView)
	self.voiceTableView:registerScriptHandler(function(arg_34_0, arg_34_1)
		return var_0_18, var_0_19
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_33_0()
		local var_35_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cellBg"):clone()

		var_35_0:setVisible(true)
		var_35_0:setSwallowTouches(false)
		var_35_0:addTouchEventListener(function(arg_36_0, arg_36_1)
			if math.abs(arg_36_0:getTouchBeganPosition().x - arg_36_0:getTouchEndPosition().x) > 50 then
				return
			end

			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.voiceList[arg_36_0.index].itemid and item_manager:getItemNumber(self.voiceList[arg_36_0.index].itemid) == 0 then
				return
			end

			self:playVoice(arg_36_0.sound, arg_36_0.talkDec, arg_36_0.expression)
			self:updateShowingCells()
		end)

		function var_35_0:update(arg_37_1)
			if self.voiceList[arg_37_1] then
				self:setVisible(true)

				self.des = self.voiceList[arg_37_1].des
				self.sound = self.voiceList[arg_37_1].sound
				self.talkDec = self.voiceList[arg_37_1].talkDec
				self.expression = self.voiceList[arg_37_1].expression
				self.index = arg_37_1

				self:getChildByName("Label_vioceDes"):setString(glabal_trans_text_horizontal_to_vertical(self.des .. ((self.voiceList[arg_37_1].tag or nil) and self.voiceList[arg_37_1].tag)))
				self:getChildByName("Label_vioceDes"):setVisible(true)
				self:getChildByName("Panel_lock"):setVisible(false)

				if self.voiceList[arg_37_1].itemid and item_manager:getItemNumber(self.voiceList[arg_37_1].itemid) == 0 then
					self:getChildByName("Panel_lock"):setVisible(true)
					self:getChildByName("Label_vioceDes"):setVisible(false)
					self:getChildByName("Panel_lock"):getChildByName("Label_lockDes"):setString(glabal_trans_text_horizontal_to_vertical(string.format(L_STRING_FORMATH_UNLOCK, (string.gsub(item_data[self.voiceList[arg_37_1].itemid].name, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*", {
						】 = "﹄",
						【 = "﹃"
					})))))
				end

				if self.playing[self.sound] then
					self:getChildByName("Image_playing"):setOpacity(64)
					self:getChildByName("Image_playing"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.6, 255), cc.FadeTo:create(0.6, 64))))
				else
					self:getChildByName("Image_playing"):setOpacity(0)
					self:getChildByName("Image_playing"):stopAllActions()
				end
			else
				self:setVisible(false)
			end
		end

		return var_35_0
	end

	self.voiceTableView:registerScriptHandler(function(arg_38_0, arg_38_1)
		local var_38_0 = arg_38_0:dequeueCell()

		if not var_38_0 then
			var_38_0 = cc.TableViewCell:create()

			local var_38_1 = var_33_0()

			var_38_1:setAnchorPoint(cc.p(0, 0))
			var_38_1:setVisible(true)
			var_38_1:setName("sp")
			var_38_1:setPosition(3, 0)
			var_38_0:addChild(var_38_1)
			var_38_1:update(arg_38_1 + 1)
		else
			var_38_0:getChildByName("sp"):update(arg_38_1 + 1)
		end

		return var_38_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.voiceTableView:registerScriptHandler(function(arg_39_0, arg_39_1)
		return #self.voiceList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.voiceTableView:reloadData()
end

function SoulServantInfo:updateShowingCells(arg_40_1)
	local var_40_0, var_40_1 = GetTableViewShowCellIdx(self.voiceTableView, {
		cellsize = cc.size(var_0_18, var_0_19),
		maxcount = #self.voiceList
	})

	for iter_40_0 = var_40_0, var_40_1 do
		self.voiceTableView:updateCellAtIndex(iter_40_0)
	end
end

function SoulServantInfo:exit()
	if self.initParam and self.initParam.returnBtnHandel then
		self.initParam.returnBtnHandel()
	end

	LayerManager:removePopLayer(self.__queueindex)
end
