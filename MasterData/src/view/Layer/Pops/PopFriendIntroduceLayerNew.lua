PopFriendIntroduceLayerNew = class("PopFriendIntroduceLayerNew", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.AvatarSprite")

local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local score_arena_awards_data = require("data.score_arena_awards_data")
local friend_system_manager = require("controller.friend_system_manager")
local level_manager = require("controller.level_manager")
local bond_manager = require("controller.bond_manager")
local chapter_data = require("data.chapter_data")
local substitution_manager = require("controller.substitution_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local playermodel = require("model.playermodel")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local var_0_14
local var_0_15 = config._DEBUG and 0 or 1
local var_0_16 = {
	ZERO = 0,
	ONE = 1,
	TWO = 2,
	THREE = 3
}
local var_0_17 = {
	[0] = {
		sign = cc.c3b(255, 255, 255),
		info = cc.c3b(255, 255, 255),
		power = cc.c3b(255, 255, 255),
		uid = cc.c3b(255, 255, 255)
	},
	{
		sign = cc.c3b(35, 20, 90),
		info = cc.c3b(4, 6, 8),
		power = cc.c3b(255, 58, 58),
		uid = cc.c3b(4, 6, 8)
	},
	{
		sign = cc.c3b(36, 27, 58),
		info = cc.c3b(36, 27, 58),
		power = cc.c3b(255, 58, 58),
		uid = cc.c3b(255, 255, 255)
	},
	{
		sign = cc.c3b(4, 189, 153),
		info = cc.c3b(255, 255, 255),
		power = cc.c3b(255, 58, 58),
		uid = cc.c3b(255, 255, 255)
	}
}

setmetatable(var_0_17, {
	__index = function(arg_2_0, arg_2_1)
		return {
			sign = cc.c3b(35, 20, 90),
			info = cc.c3b(4, 6, 8),
			power = cc.c3b(255, 58, 58),
			uid = cc.c3b(4, 6, 8)
		}
	end
})

local var_0_18 = {
	PVP = 3,
	BRIEF = 1,
	RECORD = 2
}
local var_0_19 = {
	[var_0_18.BRIEF] = {
		off = "postcard/btn_brief_off_%d.png",
		on = "postcard/btn_brief_on_%d.png"
	},
	[var_0_18.RECORD] = {
		off = "postcard/btn_record_off_%d.png",
		on = "postcard/btn_record_on_%d.png"
	},
	[var_0_18.PVP] = {
		off = "postcard/btn_array_off_%d.png",
		on = "postcard/btn_array_on_%d.png"
	}
}
local var_0_20 = {
	{
		name = L_FRIEND_BRIEF_INDEX[1],
		indexs = {
			"class",
			"level"
		}
	},
	{
		name = L_FRIEND_BRIEF_INDEX[2],
		indexs = {
			"grade"
		}
	},
	{
		name = L_FRIEND_BRIEF_INDEX[3],
		indexs = {
			"familyname"
		}
	}
}
local var_0_21 = {
	{
		img = "friendsystem/info_jifensai.png",
		name = L_FRIEND_RECORDS_INDEX[1],
		indexs = {
			"arenascore"
		}
	},
	{
		img = "friendsystem/info_qingwei.png",
		name = L_FRIEND_RECORDS_INDEX[2],
		indexs = {
			"areanrank"
		}
	},
	{
		img = "friendsystem/info_guanka.png",
		name = L_FRIEND_RECORDS_INDEX[3],
		indexs = {
			"mainchapter"
		}
	},
	{
		img = "friendsystem/info_xueyuan.png",
		name = L_FRIEND_RECORDS_INDEX[4],
		indexs = {
			"rolenum"
		}
	}
}
local var_0_22 = {
	REMOVE = 4,
	APPLY = 5,
	ADD = 1,
	CHAT = 3,
	VISIT = 2
}
local var_0_23 = {
	[var_0_22.ADD] = {
		img = "friendsystem/info_btn_apply.png"
	},
	[var_0_22.VISIT] = {
		img = "friendsystem/drom_visit_btn.png"
	},
	[var_0_22.CHAT] = {
		img = "friendsystem/friend_chat.png"
	},
	[var_0_22.REMOVE] = {
		img = "friendsystem/info_btn_remove.png"
	},
	[var_0_22.APPLY] = {
		img = "friendsystem/info_btn_ing.png"
	}
}
local var_0_24 = {
	{
		subname1 = "",
		name = ""
	},
	{
		name = L_FRIEND_RECORDS_INDEX[1],
		subname1 = L_FRIEND_RECORDS_INDEX[2]
	},
	{
		name = L_FRIEND_RECORDS_INDEX[3],
		subname1 = L_FRIEND_RECORDS_INDEX[4],
		subname2 = L_FRIEND_RECORDS_INDEX[5],
		subname3 = L_FRIEND_RECORDS_INDEX[6]
	},
	{
		name = L_FRIEND_RECORDS_INDEX[7],
		subname1 = L_FRIEND_RECORDS_INDEX[8],
		subname2 = L_FRIEND_RECORDS_INDEX[9],
		subname3 = L_FRIEND_RECORDS_INDEX[10],
		subname4 = L_FRIEND_RECORDS_INDEX[11],
		subname5 = L_FRIEND_RECORDS_INDEX[12]
	}
}

setmetatable(var_0_24, {
	__index = function(arg_3_0, arg_3_1)
		return {
			subname1 = "",
			name = ""
		}
	end
})

function PopFriendIntroduceLayerNew.create(arg_4_0, arg_4_1)
	local var_4_0 = PopFriendIntroduceLayerNew.new()

	var_4_0:initGaussBlur(arg_4_1)

	return var_4_0
end

function PopFriendIntroduceLayerNew:init(arg_5_1)
	self:initData(arg_5_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopFriendIntroduceLayerNew.initData(arg_6_0, arg_6_1)
	arg_6_0.callback = arg_6_1 and arg_6_1.callback

	if arg_6_1 then
		arg_6_0.playerUID = arg_6_1.playeruid or playermodel.playerid
	end

	if arg_6_1 then
		arg_6_0.cardType = arg_6_1.cardType or var_0_16.ZERO
	end

	if arg_6_1 then
		arg_6_0.userInfos = arg_6_1.userInfos or {}
	end

	arg_6_0.subMode = arg_6_1 and arg_6_1.submodemode
	arg_6_0.pvpType = arg_6_1 and arg_6_1.pvptype
	arg_6_0.showType = arg_6_1 and arg_6_1.showType
	arg_6_0.btnSwitchs = {}
	arg_6_0.curBtnType = var_0_18.BRIEF
	arg_6_0.relation = -1
	arg_6_0.pvpData = {}
end

function PopFriendIntroduceLayerNew:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopFriendIntroduceLayerNew.json" or "PopFriendIntroduceLayerNew.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("rootPanel")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)

	self.imgBg = self.panelMain:getChildByName("imgBg")

	self.imgBg:setVisible(false)

	self.listViewSwitch = self.panelMain:getChildByName("listViewSwitch")
	self.listViewBtns = self.panelMain:getChildByName("listViewBtns")
	self.panelCommon = self.panelMain:getChildByName("panelCommon")
	self.panelBrief = self.panelMain:getChildByName("panelBrief")
	self.panelRecord = self.panelMain:getChildByName("panelRecord")
	self.panelPvp = self.panelMain:getChildByName("panelPvp")
	self.labelUID = self.panelCommon:getChildByName("labelUID")
	self.labelName = self.panelCommon:getChildByName("labelName")
	self.listViewInfos = self.panelCommon:getChildByName("listViewInfos")
	self.imgHeadbg = self.panelCommon:getChildByName("imgHeadBg")
	self.labelFightPower = self.panelBrief:getChildByName("labelFightPower")
	self.imgArray = self.panelBrief:getChildByName("imgArray")
	self.imgSignBg = self.panelBrief:getChildByName("imgSignBg")
	self.labelSign = self.imgSignBg:getChildByName("labelSign")
	self.listViewArray = self.panelBrief:getChildByName("listViewArray")
	self.listViewMedals = self.panelBrief:getChildByName("listViewMedals")
	self.listViewRecords = self.panelRecord:getChildByName("listViewRecords")
	self.listViewPvp = self.panelPvp:getChildByName("listViewPvp")

	self.listViewArray:setItemModel(self.listViewArray:getChildByName("panelRole"))
	self.listViewMedals:setItemModel(self.listViewMedals:getChildByName("panelMedal"))
	self.listViewInfos:setItemModel(self.listViewInfos:getChildByName("nodeInfo"))
	self.listViewRecords:setItemModel(self.listViewRecords:getChildByName("panelItem"))
	self.listViewPvp:setItemModel(self.listViewPvp:getChildByName("panelItem"))
	self:initSwitchBtns()
end

function PopFriendIntroduceLayerNew:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootpanel, handler(self, self.hide))
	friend_system_manager:get_friend_information(self.playerUID, handler(self, self.handleGetFriendInfo))

	var_0_14 = self

	self:registerScriptHandler(function(arg_9_0)
		if arg_9_0 == "exit" then
			var_0_14 = nil
		elseif arg_9_0 == "enter" then
			-- block empty
		end
	end)
end

function PopFriendIntroduceLayerNew:initSwitchBtns()
	self.listViewSwitch:removeAllChildren()
	self.listViewSwitch:setItemsMargin(10)

	self.btnSwitchs = {}

	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(var_0_19) do
		if iter_10_0 == var_0_18.PVP and not self.pvpType then
			break
		end

		local var_10_1 = ccui.Button:create(string.format(iter_10_1.off, self.cardType), string.format(iter_10_1.off, self.cardType), string.format(iter_10_1.on, self.cardType), var_0_15)

		Utility:addClickEventListener(var_10_1, handler(self, self.onBtnSwitch), iter_10_0)
		self.listViewSwitch:pushBackCustomItem(var_10_1)

		var_10_0 = var_10_0 + var_10_1:getContentSize().width
		self.btnSwitchs[#self.btnSwitchs + 1] = var_10_1
	end

	self.listViewSwitch:setContentSize(cc.size(var_10_0 + (#var_0_19 - 1) * self.listViewSwitch:getItemsMargin(), self.listViewSwitch:getContentSize().height))
	self.listViewSwitch:setPositionX(self.listViewSwitch:getPositionX() - 10)
end

function PopFriendIntroduceLayerNew:autoSwitch()
	self:onBtnSwitch(self.btnSwitchs[self.curBtnType], var_0_18.BRIEF)
end

function PopFriendIntroduceLayerNew:onBtnSwitch(arg_12_1, arg_12_2)
	if Utility:indexOf(self.btnSwitchs, arg_12_1) < 0 then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(self.btnSwitchs) do
		iter_12_1:loadTextures(string.format(var_0_19[iter_12_0].off, self.cardType), string.format(var_0_19[iter_12_0].off, self.cardType), string.format(var_0_19[iter_12_0].on, self.cardType), var_0_15)
		iter_12_1:setTouchEnabled(iter_12_1 ~= arg_12_1)
		iter_12_1:setBright(iter_12_1 ~= arg_12_1)
	end

	self.curBtnType = arg_12_2

	if self.curBtnType == var_0_18.PVP then
		self:executePvpRequest()
	else
		self:updateLayout()
	end
end

function PopFriendIntroduceLayerNew:executePvpRequest()
	if self.pvpType == 1 then
		-- block empty
	elseif self.pvpType == 2 then
		friend_system_manager:get_someone_array(2, self.playerUID, handler(self, self.handleGetPvpArrayData))
	elseif self.pvpType == 3 then
		friend_system_manager:get_enemy_defence_array(self.playerUID, handler(self, self.handleGetPvpArrayData))
	elseif self.pvpType == 4 then
		substitution_manager:get_substitution_battlearray_data(self.subMode, self.playerUID, handler(self, self.handleGetPvpArrayData))
	end
end

function PopFriendIntroduceLayerNew:updateLayout()
	self.panelCommon:setVisible(self.curBtnType ~= var_0_18.RECORD)
	self.panelBrief:setVisible(self.curBtnType == var_0_18.BRIEF)
	self.panelRecord:setVisible(self.curBtnType == var_0_18.RECORD)
	self.panelPvp:setVisible(self.curBtnType == var_0_18.PVP)

	if self.panelCommon:isVisible() then
		self:updateCommonUI()
	end

	if self.panelBrief:isVisible() then
		self:updateBriefUI()
	end

	if self.panelRecord:isVisible() then
		self:updateRecordUI()
	end

	if self.panelPvp:isVisible() then
		self:updatePvpUI()
	end
end

function PopFriendIntroduceLayerNew:updateCommonUI()
	self.labelName:setString(self.userInfos.name)
	self.labelName:setColor(var_0_17[self.cardType].info)
	self.labelSign:setString("个性签名：" .. ((self.userInfos.signment ~= "" or nil) and (self.userInfos.signment or "这个人很懒，什么都没留下")))
	self.labelSign:setColor(var_0_17[self.cardType].sign)
	self.labelUID:setString("编号: " .. math.abs(self.userInfos.playerid))
	self.labelUID:setColor(var_0_17[self.cardType].uid)
	self.labelUID:setVisible(not self.userInfos.robot)
	self.imgHeadbg:loadTexture(string.format("postcard/head_bg_%d.png", self.cardType), var_0_15)
	self.imgBg:loadTexture(string.format("postcard/bg_%d.png", self.cardType), var_0_15)
	self.imgBg:setVisible(true)
	self:updateHeadUI(self.userInfos.head_sculpture, self.imgHeadbg)
	self:updateInfoUI()
end

function PopFriendIntroduceLayerNew.updateHeadUI(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 or not arg_16_2 then
		return
	end

	arg_16_2:getChildByName("imgHead"):setVisible(false)

	if not arg_16_2:getChildByName("nodeHead") then
		local var_16_0 = AvatarSprite:create(tonumber(arg_16_1))

		var_16_0:setPosition(cc.p(35, 12))
		var_16_0:setName("nodeHead")
		var_16_0:setScale(0.75)
		arg_16_2:addChild(var_16_0)
	else
		arg_16_2:getChildByName("nodeHead"):switchShowAvatar(tonumber(arg_16_1))
	end
end

function PopFriendIntroduceLayerNew:updateInfoUI()
	self.listViewInfos:removeAllChildren()

	for iter_17_0, iter_17_1 in ipairs(var_0_20) do
		self.listViewInfos:pushBackDefaultItem()

		local var_17_0 = self.listViewInfos:getItem(iter_17_0 - 1)
		local var_17_1 = var_17_0:getChildByName("imgIcon")
		local var_17_2 = var_17_0:getChildByName("labelInfo")
		local var_17_3 = var_17_0:getChildByName("labelName")

		var_17_0:loadTexture(string.format("postcard/group_%d.png", self.cardType), var_0_15)
		var_17_3:setString(iter_17_1.name)

		for iter_17_2, iter_17_3 in ipairs(iter_17_1.indexs) do
			if iter_17_3 == "class" then
				local var_17_4 = self.userInfos.class or 1

				var_17_1:setVisible(true)
				self:updatePlayerGrade(var_17_4, var_17_1)
				var_17_3:setVisible(false)
			else
				local var_17_5

				if iter_17_3 == "level" then
					var_17_5 = L_SOULSTRENGTHLAYER[6] or ""

					if iter_17_3 == "grade" then
						local var_17_6 = math.abs(self.userInfos[iter_17_3])

						var_17_2:setString(var_17_5 .. (var_17_6 < 1000 and string.format("%04d", var_17_6) or var_17_6))

						goto label_17_0
					end
				end

				var_17_2:setString(var_17_5 .. self.userInfos[iter_17_3])

				::label_17_0::

				var_17_2:setColor(var_0_17[self.cardType].info)
			end
		end
	end
end

function PopFriendIntroduceLayerNew.updatePlayerGrade(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 or not arg_18_2 then
		return
	end

	local var_18_0

	if arg_18_1 == 5 then
		var_18_0 = "TopcostLayer/new_doctor.png"
	elseif arg_18_1 == 4 then
		var_18_0 = "TopcostLayer/new_master.png"
	elseif arg_18_1 == 3 then
		var_18_0 = "TopcostLayer/new_Univ.png"
	elseif arg_18_1 == 2 then
		var_18_0 = "TopcostLayer/new_Senior.png"
	elseif arg_18_1 == 1 then
		var_18_0 = "TopcostLayer/new_Junior.png"
	end

	arg_18_2:setScale(0.8)
	arg_18_2:loadTexture(var_18_0, var_0_15)
end

function PopFriendIntroduceLayerNew:updateBriefUI()
	self.labelFightPower:setString(global_trans_number(self.userInfos.array.fightpower or 0))
	self.labelFightPower:setColor(var_0_17[self.cardType].power)
	self:updateArrayUI()
	self:updateMedalUI()
end

function PopFriendIntroduceLayerNew:updateMedalUI()
	self.listViewMedals:removeAllChildren()

	for iter_20_0, iter_20_1 in ipairs(self.userInfos.medals or {}) do
		self.listViewMedals:pushBackDefaultItem()
		self:createMedal(iter_20_1, (self.listViewMedals:getItem(iter_20_0 - 1):getChildByName("imgBg")))
	end
end

local var_0_25 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_26 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 84, 0, 150)
}

function PopFriendIntroduceLayerNew.createMedal(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 0 then
		return
	end

	local var_21_0 = item_data[arg_21_1]

	arg_21_2:loadTexture((item_data[arg_21_1].bg or nil) and ("equipment/" .. item_data[arg_21_1].bg .. ".png" or var_0_25[var_21_0.equip_quality]))
	arg_21_2:setScale(0.6)

	local var_21_1 = cc.Label:createWithTTF(var_21_0.name, FONT_DES, 54)

	var_21_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_21_1:setPosition(cc.p(arg_21_2:getContentSize().width / 2 + 5, arg_21_2:getContentSize().height / 2 - 5))
	var_21_1:enableOutline(var_0_26[var_21_0.equip_quality], 1)
	var_21_1:enableShadow(var_0_26[var_21_0.equip_quality], cc.size(0, 0))
	arg_21_2:addChild(var_21_1)
end

function PopFriendIntroduceLayerNew:updateArrayUI()
	self.listViewArray:removeAllChildren()
	self.imgArray:loadTexture(string.format("postcard/array_%d.png", self.cardType), var_0_15)

	for iter_22_0, iter_22_1 in ipairs(self.userInfos.array.fight_girls or {}) do
		self.listViewArray:pushBackDefaultItem()

		local var_22_0 = self.listViewArray:getItem(iter_22_0 - 1)

		var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)

		local var_22_1 = var_22_0:getChildByName("imgRoleBg")
		local var_22_2 = var_22_0:getChildByName("labelLevel")
		local var_22_3 = var_22_0:getChildByName("imgBreak")

		var_22_1:loadTexture(string.format("postcard/role_bg_%d.png", self.cardType), var_0_15)

		if iter_22_1.level >= 0 then
			var_22_2:setString(L_SOULSTRENGTHLAYER[6] .. iter_22_1.level)
			var_22_3:loadTexture(string.format("public/rolebg/breakout_%d.png", iter_22_1.rank), var_0_15)
			var_22_3:setScale(0.5)
			var_22_3:setPositionX(var_22_2:getPositionX() + var_22_2:getContentSize().width - 2)
		end

		local var_22_4 = ccui.ImageView:create()

		if iter_22_1.modelid and iter_22_1.modelid ~= "-1" and model_data[iter_22_1.modelid] then
			var_22_4:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[iter_22_1.modelid].cute_role .. ".png")
			var_22_4:setPosition(var_22_0:getContentSize().width / 2, var_22_0:getContentSize().height / 2 + 20)
			var_22_4:setScale(0.28)
		else
			var_22_4:loadTexture("friendsystem/info_array_no.png", var_0_15)
			var_22_4:setPosition(var_22_0:getContentSize().width / 2, var_22_0:getContentSize().height / 2 + 25)
			var_22_4:setScale(0.3)
		end

		var_22_0:addChild(var_22_4)
		var_22_2:setVisible(iter_22_1.level >= 0)
		var_22_3:setVisible(iter_22_1.level >= 0)
	end
end

function PopFriendIntroduceLayerNew:updateRecordUI()
	self.listViewRecords:removeAllChildren()

	for iter_23_0, iter_23_1 in ipairs(var_0_21) do
		self.listViewRecords:pushBackDefaultItem()

		local var_23_0 = self.listViewRecords:getItem(iter_23_0 - 1)
		local var_23_1 = var_23_0:getChildByName("imgBg")
		local var_23_2 = var_23_0:getChildByName("labelInfo")
		local var_23_3 = var_23_0:getChildByName("imgIcon")

		var_23_1:loadTexture(iter_23_1.img, var_0_15)

		for iter_23_2, iter_23_3 in ipairs(iter_23_1.indexs) do
			var_23_3:setVisible(iter_23_3 == "arenascore")
			var_23_2:setVisible(iter_23_3 ~= "arenascore")

			local var_23_4 = ""
			local var_23_5 = self.userInfos[iter_23_3]

			if iter_23_3 == "areanrank" then
				var_23_4 = (not var_23_5 or var_23_5 == -1) and L_FRIEND_INTRODUCE_LAYER.no_rank_arean or var_23_5 > 0 and var_23_4 .. var_23_5 or ""
			elseif iter_23_3 == "arenascore" then
				var_23_3:loadTexture("arenascenenew/duanwei" .. "_" .. self:calculatePlayerRank(var_23_5) .. ".png", var_0_15)
			elseif iter_23_3 == "mainchapter" and var_23_5 then
				local var_23_6 = ""

				if chapter_data[var_23_5] then
					var_23_6 = chapter_data[var_23_5].name
				end

				local var_23_7, var_23_8 = string.match(var_23_5, "(%d+)-(%d+)")
				local var_23_9 = level_manager:getDifficultByMode(tonumber(var_23_7))

				if var_23_9 then
					local var_23_10 = var_23_2:clone()

					var_23_10:setPositionY(var_23_2:getPositionY() + 25)
					var_23_10:setString(L_MODE_DIFFICULTY[var_23_9])
					var_23_0:addChild(var_23_10)
				end

				var_23_4 = var_23_4 .. (var_23_6 ~= "" and var_23_6 or var_23_5)
			elseif iter_23_3 == "rolenum" then
				var_23_4 = var_23_4 .. (var_23_5 or 1)
			end

			var_23_2:setString(var_23_4)
		end
	end
end

function PopFriendIntroduceLayerNew.calculatePlayerRank(arg_24_0, arg_24_1)
	arg_24_1 = arg_24_1 or 0

	local var_24_0 = 5

	for iter_24_0, iter_24_1 in ipairs(score_arena_awards_data) do
		if arg_24_1 >= iter_24_1.min and arg_24_1 <= iter_24_1.max then
			var_24_0 = iter_24_0

			break
		end
	end

	return var_24_0
end

function PopFriendIntroduceLayerNew:updatePvpUI()
	self.listViewPvp:removeAllChildren()

	for iter_25_0, iter_25_1 in ipairs(self.pvpData) do
		self.listViewPvp:pushBackDefaultItem()

		local var_25_0 = self.listViewPvp:getItem(iter_25_0 - 1)
		local var_25_1 = var_25_0:getChildByName("listViewItems")

		var_25_1:setItemModel(var_25_1:getChildByName("nodeItem"))
		var_25_1:setItemsMargin(-18)
		var_25_1:removeAllChildren()

		local var_25_2 = var_25_0:getChildByName("imgBg")
		local var_25_3 = var_25_0:getChildByName("labelName")
		local var_25_4 = var_25_0:getChildByName("labelArray")
		local var_25_5 = var_25_0:getChildByName("imgFight")
		local var_25_6 = var_25_0:getChildByName("labelPower")

		var_25_2:loadTexture(string.format("postcard/array_bg_%d.png", self.cardType), var_0_15)
		var_25_5:loadTexture(string.format("postcard/sword_%d.png", self.cardType), var_0_15)
		var_25_3:setString(var_0_24[self.pvpType].name)
		var_25_3:setColor(var_0_17[self.cardType].info)
		var_25_4:setString(var_0_24[self.pvpType]["subname" .. iter_25_0])
		var_25_4:setColor(var_0_17[self.cardType].info)
		var_25_6:setString(global_trans_number(iter_25_1.fightpower))
		var_25_6:setColor(var_0_17[self.cardType].power)
		var_25_3:setPositionX(var_25_6:getPositionX() + var_25_6:getContentSize().width + 10)
		var_25_4:setPositionX(var_25_3:getPositionX() + var_25_3:getContentSize().width + 10)

		for iter_25_2, iter_25_3 in ipairs(iter_25_1.array or {}) do
			var_25_1:pushBackDefaultItem()

			local var_25_7 = var_25_1:getItem(iter_25_2 - 1)

			var_25_7:getChildByName("btnItem"):setTouchEnabled(false)

			local var_25_8 = var_25_7:getChildByName("imgBgLevel")
			local var_25_9 = var_25_8:getChildByName("labelLevel")
			local var_25_10 = var_25_8:getChildByName("imgClass")

			var_25_10:setPosition(cc.p(100, 75))

			if iter_25_3.modelid == "-1" then
				var_25_10:setVisible(false)
				var_25_9:setVisible(false)
			else
				var_25_10:loadTexture("Array/icon_" .. global_get_all_servant_attrs(iter_25_3.servantid).main .. ".png", var_0_15)
				var_25_10:setScale(0.65)
				var_25_9:setString(L_SOULSTRENGTHLAYER[6] .. iter_25_3.servantlevel)

				local var_25_11 = self:createArrayRole(iter_25_3.servantid)

				var_25_11:setPosition(cc.p(var_25_7:getContentSize().width / 2, var_25_7:getContentSize().height / 2))
				var_25_7:addChild(var_25_11)
			end

			var_25_7:setScale(0.92)
		end
	end
end

function PopFriendIntroduceLayerNew.createArrayRole(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return
	end

	local var_26_0 = servant_data[arg_26_1].modelid

	if not servant_data[arg_26_1].modelid then
		return
	end

	local var_26_1 = model_data[var_26_0].portrait_image
	local var_26_2 = ccui.ImageView:create("GUI/image.png", var_0_15)

	var_26_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_26_2:setScale(60 / var_26_2:getContentSize().height)
	var_26_2:setName("imgHead")
	var_26_2:loadTexture(ROLE_PORTRAIT_PATH .. var_26_1 .. ".png")

	return var_26_2
end

function PopFriendIntroduceLayerNew:updateListViewBtns()
	self.listViewBtns:removeAllChildren()

	if self.playerUID == playermodel.playerid or self.relation == 999 then
		return
	end

	local var_27_0 = ccui.Button:create()

	if self.relation == -1 and not self.userInfos.robot then
		var_27_0:loadTextures(var_0_23[var_0_22.ADD].img, nil, var_0_23[var_0_22.ADD].img, var_0_15)
	elseif self.relation == 1 then
		var_27_0:loadTextures(var_0_23[var_0_22.REMOVE].img, nil, var_0_23[var_0_22.REMOVE].img, var_0_15)
	elseif self.relation == 3 then
		var_27_0:loadTextures(var_0_23[var_0_22.APPLY].img, nil, var_0_23[var_0_22.APPLY].img, var_0_15)
	end

	Utility:addClickEventListener(var_27_0, handler(self, self.onBtnFriend))
	self.listViewBtns:pushBackCustomItem(var_27_0)

	if self.showType ~= 1 and not self.userInfos.robot then
		local var_27_1 = ccui.Button:create(var_0_23[var_0_22.VISIT].img, nil, var_0_23[var_0_22.VISIT].img, var_0_15)

		Utility:addClickEventListener(var_27_1, handler(self, self.onBtnVisit))
		self.listViewBtns:pushBackCustomItem(var_27_1)
	end

	if self.relation == 1 and not self.userInfos.robot then
		local var_27_2 = ccui.Button:create(var_0_23[var_0_22.CHAT].img, nil, var_0_23[var_0_22.CHAT].img, var_0_15)

		Utility:addClickEventListener(var_27_2, handler(self, self.onBtnChat))
		self.listViewBtns:pushBackCustomItem(var_27_2)
	end

	local var_27_3 = self.listViewBtns:getChildren()

	if #var_27_3 == 0 then
		return
	end

	self.listViewBtns:setContentSize(cc.size(var_27_3[1]:getContentSize().width * #var_27_3 + math.max(0, #var_27_3 - 1) * self.listViewBtns:getItemsMargin(), self.listViewBtns:getContentSize().height))
	self.listViewBtns:doLayout()
	self.listViewBtns:setAnchorPoint(0.5, 0)
	self.listViewBtns:setPositionX(self.panelMain:getContentSize().width / 2)
end

function PopFriendIntroduceLayerNew:onBtnFriend(arg_28_1)
	if self.relation == 3 or self.isRequesting then
		return
	end

	self.isRequesting = true

	if self.relation == 1 then
		friend_system_manager:delete_add_friend(self.playerUID, handler(self, self.handleDelFriend))
	elseif self.relation == -1 then
		friend_system_manager:apply_add_friend(self.playerUID, handler(self, self.handleAddFriend))
	end
end

function PopFriendIntroduceLayerNew:onBtnChat(arg_29_1)
	LayerManager:pushInLayer("PopChatInterfaceLayer", {
		friendid = self.playerUID
	})
end

function PopFriendIntroduceLayerNew:onBtnVisit(arg_30_1)
	if self.isRequesting then
		return
	end

	self.isRequesting = true

	friend_system_manager:getFriendDormData(self.playerUID, function(arg_31_0)
		if arg_31_0.result == 1 then
			LayerManager:pushInLayer("DormVisitLayer", {
				name = self.userInfos.name,
				msg = arg_31_0,
				playerid = self.playerUID,
				faceid = self.userInfos.head_sculpture
			})
		end

		self.isRequesting = false
	end)
end

function PopFriendIntroduceLayerNew:onEnter()
	friend_system_manager:get_friend_information(self.playerUID, handler(self, self.handleGetFriendInfo))
end

function PopFriendIntroduceLayerNew.onExit(arg_33_0)
	EventManager:unsubscribe(arg_33_0)
end

function PopFriendIntroduceLayerNew:show()
	self.showActions.extendVertical(self)
end

function PopFriendIntroduceLayerNew:hide()
	STATIC_INDEX = nil

	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopFriendIntroduceLayerNew:handleGetFriendInfo(arg_37_1)
	if not var_0_14 then
		return
	end

	if not arg_37_1 then
		return
	end

	if arg_37_1 and arg_37_1.result == 1 then
		self.userInfos = arg_37_1.data
		self.relation = arg_37_1.relation

		if self.userInfos.visitcardid == 0 then
			self.userInfos.visitcardid = nil
		end

		if self.userInfos.visitcardid then
			self.cardType = self.userInfos.visitcardid % 8000900 or var_0_16.ZERO
		end

		self:autoSwitch()
		self:updateListViewBtns()
	end
end

function PopFriendIntroduceLayerNew:handleGetPvpArrayData(arg_38_1)
	if arg_38_1 and type(arg_38_1) == "table" then
		self.pvpData = {}

		if self.pvpType == 1 then
			-- block empty
		elseif self.pvpType == 2 then
			self.pvpData[#self.pvpData + 1] = {
				array = arg_38_1,
				fightpower = arg_38_1.fightpower
			}
		elseif self.pvpType == 3 then
			for iter_38_0, iter_38_1 in ipairs(arg_38_1) do
				self.pvpData[#self.pvpData + 1] = {
					array = iter_38_1.battlearray,
					fightpower = iter_38_1.fightpower
				}
			end
		elseif self.pvpType == 4 then
			while arg_38_1["array_" .. 1] do
				self.pvpData[#self.pvpData + 1] = {
					array = arg_38_1["array_" .. 1].array,
					fightpower = arg_38_1["array_" .. 1].score
				}
			end
		end
	end

	self:updateLayout()
end

function PopFriendIntroduceLayerNew:handleAddFriend(arg_39_1)
	if not arg_39_1 then
		return
	end

	self.isRequesting = false

	if arg_39_1.result == 1 then
		friend_system_manager:get_friend_information(self.playerUID, handler(self, self.handleGetFriendInfo))
	elseif arg_39_1.result == 2 then
		global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_max_limit)
	elseif arg_39_1.result == 3 then
		global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_is_friend)
	elseif arg_39_1.result == 4 then
		global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_is_self)
	elseif arg_39_1.result == 5 then
		global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.apply_list_limit)
	elseif arg_39_1.result == 6 then
		global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.target_friend_max_limit)
	else
		global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_friend_fail)
	end
end

function PopFriendIntroduceLayerNew:handleDelFriend(arg_40_1)
	if not arg_40_1 then
		return
	end

	self.isRequesting = false

	if arg_40_1 and arg_40_1.result == 1 then
		friend_system_manager:get_friend_information(self.playerUID, handler(self, self.handleGetFriendInfo))

		if self.callback then
			self.callback()
		end
	end
end

PopFriendIntroduceLayerFix = class("PopFriendIntroduceLayerFix", function()
	return cc.Layer:create()
end)

local LocalEvent = require("common.LocalEvent")

function PopFriendIntroduceLayerFix.create(arg_42_0, arg_42_1)
	local var_42_0 = PopFriendIntroduceLayerFix.new()

	var_42_0:init(arg_42_1)

	return var_42_0
end

function PopFriendIntroduceLayerFix:init(arg_43_1)
	arg_43_1.playeruid = arg_43_1.playeruid or playermodel.playerid
	self.initParams = arg_43_1

	self:setPositionY(-GameDisplay.fix_y)
	Utility:registerNodeEvent(self)
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.LAYER_EXIT_SCENE, handler(self, self.handleLayerExitScene))
end

function PopFriendIntroduceLayerFix:onEnter()
	friend_system_manager:get_friend_information(self.initParams.playeruid, handler(self, self.handleGetFriendInfo))
end

function PopFriendIntroduceLayerFix.onExit(arg_45_0)
	LocalEvent:removeEvent(arg_45_0)
end

function PopFriendIntroduceLayerFix:handleGetFriendInfo(arg_46_1)
	if not arg_46_1 then
		return
	end

	if arg_46_1 and arg_46_1.result == 1 then
		if not arg_46_1.data.visitcardid or arg_46_1.data.visitcardid == 0 then
			LayerManager:pushInLayer("PopFriendIntroduceLayerOld", self.initParams)
		else
			LayerManager:pushInLayer("PopFriendIntroduceLayerNew", self.initParams)
		end
	else
		LayerManager:pushInLayer("PopFriendIntroduceLayerOld", self.initParams)
	end
end

function PopFriendIntroduceLayerFix:handleLayerExitScene(arg_47_1)
	if not arg_47_1 then
		return
	end

	if arg_47_1.name == "PopFriendIntroduceLayerNew" or arg_47_1.name == "PopFriendIntroduceLayerOld" then
		LayerManager:removePopLayer(self.__queueindex)
	end
end
