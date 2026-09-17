local TileSprite = require("view.Sprite.explore.TileSprite")
local PokemonTile = class("PokemonTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)
local var_0_2 = config._DEBUG and 0 or 1
local item_manager = require("controller.item_manager")
local explore_manager = require("controller.explore_manager")
local horcrux_data = require("data.horcrux_data")
local total_skill_data = require("data.total_skill_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local L2Actor = require("view.Sprite.L2Actor")
local playermodel = require("model.playermodel")
local explore_horcrux_data = require("data.explore.explore_horcrux_data")
local var_0_12

require("view.Layer.PopLayer")

local var_0_13 = 4100101
local var_0_14 = 0.24
local var_0_15 = {
	[TILE_TYPE.POKEMON] = "explore/pokemon_title.png"
}

function PokemonTile:create(arg_2_1)
	local var_2_0 = PokemonTile.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PokemonTile:init(arg_3_1)
	var_0_12 = self
	self.initConfig = arg_3_1
	self.tileInfo = arg_3_1.tileInfo
	self.parent = arg_3_1.parent
	self.tileid = arg_3_1.tileInfo.id
	self.horcruxid = self:getHorcruxId(arg_3_1.idx)
	self.modelid = horcrux_data[self.horcruxid].model
	self.gainRate = self:getGainRate(arg_3_1.idx)
	self.idx = arg_3_1.idx
	self.order = arg_3_1.order
	self.pos = arg_3_1.pos
	self.zOrder = arg_3_1.zOrder
	self.fullImage = arg_3_1.fullImage
	self.size_num = arg_3_1.size_num
	self.hp = self.tileInfo.hp or 1
	self.damage = self.tileInfo.damage or 1
	self.attackspeed = self.tileInfo.attackspeed or 1

	self:setPosition(self.pos)
	self:setName(self.order .. "object")
	self.parent.iconLayout:addChild(self, self.zOrder)
	self:createIcon()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_12 = nil
		end
	end)
end

function PokemonTile:getHorcruxId(arg_5_1)
	return explore_horcrux_data[self.tileInfo["result" .. self.parent.usedTile[arg_5_1].result .. "_param"]].horcruxid
end

function PokemonTile:createIcon()
	if not self:isTileShow() then
		return false
	end

	local var_6_0 = horcrux_data[self.horcruxid].model
	local var_6_1 = model_data[horcrux_data[self.horcruxid].model].spine_model
	local var_6_2 = model_data[horcrux_data[self.horcruxid].model].clothes_model
	local var_6_3 = var_0_14
	local var_6_4 = cc.size(model_data[horcrux_data[self.horcruxid].model].modelweight, model_data[horcrux_data[self.horcruxid].model].modelheight)
	local var_6_5

	if model_data[horcrux_data[self.horcruxid].model].spine_model then
		var_6_5 = ROLE_SPINE_PATH .. var_6_1 .. ".json" or nil

		local var_6_6

		if var_6_1 then
			var_6_6 = ROLE_SPINE_PATH .. var_6_1 .. ".atlas" or nil

			local var_6_7

			if var_6_2 then
				var_6_7 = CLOTHES_SPINE_PATH .. var_6_2 .. ".atlas" or nil
			end
		end
	end

	if var_6_5 then
		if true or not (cc.FileUtils:getInstance():isFileExist(var_6_5) or false) then
			self.icon = ccui.ImageView:create(CUTE_ROLE_IMAGE_PATH .. model_data[var_6_0].cute_Q .. ".png")
			self.icon.size = self.icon:getContentSize()

			self.icon:setScale(0.3 * (self.tileInfo.isFlippedX == 1 and -1 or 1), 0.3)
			self.icon:setPosition(TILE_SIZE / 2, TILE_SIZE / 2 + 20)
			self:addChild(self.icon)

			goto label_6_0
		end
	end

	self.icon = L2Actor:create(var_6_5, var_6_6, var_6_7)

	self.icon:setScale(var_6_3 * (self.tileInfo.isFlippedX == 1 and -1 or 1), var_6_3)
	self.icon:setContentSize(var_6_4)
	self.icon:playAni(nil, "idle", true)
	self.icon:setPosition(TILE_SIZE / 2, TILE_SIZE / 2)
	self:addChild(self.icon)

	::label_6_0::

	if var_0_15[self.tileInfo.class] and false then
		local var_6_10

		if config._DEBUG then
			var_6_10 = cc.Sprite:create(var_0_15[self.tileInfo.class]) or cc.Sprite:createWithSpriteFrameName(var_0_15[self.tileInfo.class])
		end

		var_6_10:setAnchorPoint(cc.p(0.5, 1))
		var_6_10:setScale(0.5 / var_0_14)
		var_6_10:setPosition(self.icon.size.width * var_0_14 / 2 - 20, self.icon.size.height * var_0_14 / 2 + 120)
		self.icon:addChild(var_6_10)
	elseif var_0_15[self.tileInfo.class] then
		local var_6_11

		if config._DEBUG then
			var_6_11 = cc.Sprite:create(var_0_15[self.tileInfo.class]) or cc.Sprite:createWithSpriteFrameName(var_0_15[self.tileInfo.class])
		end

		var_6_11:setAnchorPoint(cc.p(0.5, 0.5))
		var_6_11:setScale(1 / var_0_14)
		var_6_11:setPosition(self.icon.size.width / 2, self.icon.size.height / 2 + 180)
		var_6_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(1, cc.p(0, 20)), cc.MoveBy:create(1, cc.p(0, -20)))))
		self.icon:addChild(var_6_11)
	end

	self:createLight()
end

function PokemonTile:triggerEvent(arg_7_1)
	self.finishCallback = arg_7_1

	self:horcruxInfoPop(function(arg_8_0)
		local function var_8_0()
			local var_9_0 = {
				room_order = self.parent.curRoomOrder,
				object_idx = self.idx,
				result_type = self.tileInfo.result1_type,
				result_param = self.tileInfo.result1_param
			}

			var_9_0.result_count = self.parent.usedTile[self.idx].result or 1

			explore_manager:trigger_event(var_9_0, function(arg_10_0)
				if arg_10_0.result > 0 then
					self:updateState()

					if self.finishCallback then
						self.finishCallback({
							tileInfo = self.tileInfo,
							msg = arg_10_0,
							eventconfig = var_9_0
						})
					end
				elseif self.finishCallback then
					self.finishCallback({
						tileInfo = self.tileInfo,
						msg = arg_10_0,
						eventconfig = var_9_0
					})
				end
			end)
		end

		if not item_manager:haveItem(var_0_13) then
			LayerManager:pushInLayer("PopDoLayer", {
				costtype = "diamond",
				is_need_pop_layer = 1,
				surecallback = var_8_0,
				cancelcallback = arg_8_0,
				own = playermodel.diamond,
				cost = item_data[var_0_13].price_diamond,
				labels = {
					titleImage = "title_EMP_lack.png",
					des = L_EXPLORE_POKEBALL_BUY.des,
					button = L_EXPLORE_POKEBALL_BUY.button
				}
			})
		else
			var_8_0()
		end
	end)
end

function PokemonTile:getGainRate(arg_11_1)
	print("@@@@@@@@@@", self.tileInfo["result" .. self.parent.usedTile[arg_11_1].result .. "_param"])

	return explore_horcrux_data[self.tileInfo["result" .. self.parent.usedTile[arg_11_1].result .. "_param"]].drop1_weight / (explore_horcrux_data[self.tileInfo["result" .. self.parent.usedTile[arg_11_1].result .. "_param"]].drop1_weight + explore_horcrux_data[self.tileInfo["result" .. self.parent.usedTile[arg_11_1].result .. "_param"]].drop2_weight)
end

function PokemonTile:horcruxInfoPop(arg_12_1)
	local var_12_0 = ccui.Layout:create()

	var_12_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_12_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_12_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_12_0:setBackGroundColorOpacity(145)
	var_12_0:setCascadeOpacityEnabled(false)
	var_12_0:setTouchEnabled(true)
	var_12_0:setName("horcruxInfoPop")

	self.horcruxInfoPanel = var_12_0

	global_basic_scene:addChild(var_12_0)
	var_12_0:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.parent.root.touchLock = false
		self.horcruxInfoPanel = nil
		self.skillDesPanel = nil

		var_12_0:runAction(cc.RemoveSelf:create())
	end)

	local var_12_1 = ccui.ImageView:create("explore/horcrux_bg.png", var_0_2)

	var_12_1:setPosition(320, 570)
	var_12_1:setTouchEnabled(true)
	var_12_0:addChild(var_12_1)

	local var_12_2 = cc.Sprite:create(CUTE_ROLE_IMAGE_PATH .. model_data[self.modelid].cute_Q .. ".png")

	var_12_2:setScale(0.6)
	var_12_2:setAnchorPoint(cc.p(0.5, 0))
	var_12_2:setPosition(120, 20)
	var_12_1:addChild(var_12_2)

	local var_12_3 = cc.Label:createWithTTF(horcrux_data[self.horcruxid].name, FONT_DES, 33)

	var_12_3:setColor(cc.c3b(0, 180, 255))
	var_12_3:setAnchorPoint(cc.p(0, 0.5))
	var_12_3:setPosition(230, 240)
	var_12_1:addChild(var_12_3)

	local var_12_4 = ccui.ImageView:create(RARITY_ICON[rarity], var_0_2)

	var_12_4:setAnchorPoint(cc.p(0, 0.5))
	var_12_4:setPosition(230, 208)
	var_12_1:addChild(var_12_4)

	local var_12_5 = cc.Label:createWithTTF(self.gainRate * 100, FONT_DES, 42)

	var_12_5:setColor(cc.c3b(255, 209, 2))
	var_12_5:setAnchorPoint(cc.p(1, 0))
	var_12_5:setPosition(cc.p(514, 208))
	var_12_1:addChild(var_12_5)

	for iter_12_0 = 1, 2 do
		local var_12_6 = ccui.ImageView:create("explore/horcrux_skill_bg.png", var_0_2)

		var_12_6:setPosition(300 + (iter_12_0 - 1) * 156, 110)
		var_12_1:addChild(var_12_6)

		if horcrux_data[self.horcruxid]["skill" .. iter_12_0] then
			local var_12_7 = ccui.ImageView:create("skill_new/skill/" .. total_skill_data[horcrux_data[self.horcruxid]["skill" .. iter_12_0]].icon .. ".png", var_0_2)

			var_12_7:setPosition(var_12_6:getContentSize().width / 2, var_12_6:getContentSize().height / 2)
			var_12_7:setTouchEnabled(true)

			var_12_7.skillid = horcrux_data[self.horcruxid]["skill" .. iter_12_0]

			var_12_7:addTouchEventListener(function(arg_14_0, arg_14_1)
				if arg_14_1 == ccui.TouchEventType.began then
					self:schedulerWithCallback(function()
						if not var_0_12 then
							return
						end

						self:showSkillDetailPanel(arg_14_0.skillid)
					end, 1)
				elseif arg_14_1 == ccui.TouchEventType.ended then
					self:closSkillDetailPanel()
				elseif arg_14_1 == ccui.TouchEventType.canceled then
					self:closSkillDetailPanel()
				end
			end)
			var_12_6:addChild(var_12_7)

			local var_12_8 = cc.Label:createWithTTF(total_skill_data[horcrux_data[self.horcruxid]["skill" .. iter_12_0]].name, FONT_NAME, 26)

			var_12_8:setColor(cc.c3b(173, 191, 211))
			var_12_8:setPosition(var_12_6:getContentSize().width / 2, -20)
			var_12_6:addChild(var_12_8)
		else
			local var_12_9 = cc.Label:createWithTTF("---", FONT_NAME, 26)

			var_12_9:setColor(cc.c3b(173, 191, 211))
			var_12_9:setPosition(var_12_6:getContentSize().width / 2, -20)
			var_12_6:addChild(var_12_9)
		end

		local var_12_10 = ccui.ImageView:create("explore/horcrux_skill_frame.png", var_0_2)

		var_12_10:setPosition(var_12_6:getContentSize().width / 2, var_12_6:getContentSize().height / 2)
		var_12_6:addChild(var_12_10)
	end

	local var_12_11 = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_2)

	var_12_11:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Sure)
	var_12_11:setTitleColor(cc.c3b(0, 0, 0))
	var_12_11:setTitleFontName(FONT_BUTTON)
	var_12_11:setTitleFontSize(30)
	var_12_11:setPosition(270, -30)
	var_12_1:addChild(var_12_11)
	var_12_11:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_16_0:isBright() then
			return
		end

		arg_16_0:setBright(false)

		if arg_12_1 then
			arg_12_1(function()
				self.parent.root.touchLock = false
			end)
		end

		self.horcruxInfoPanel = nil
		self.skillDesPanel = nil

		var_12_0:runAction(cc.RemoveSelf:create())
	end)

	local var_12_12 = ccui.ImageView:create("explore/pokeball_icon.png", var_0_2)

	var_12_12:setPosition(240, -100)
	var_12_1:addChild(var_12_12)

	local var_12_13 = cc.Label:createWithTTF(item_manager:getItemNumber(var_0_13) .. "/1", FONT_NAME, 35)

	var_12_13:setAnchorPoint(cc.p(0, 0.5))
	var_12_13:setPosition(290, -100)
	var_12_13:setColor(cc.c3b(255, 209, 2))
	var_12_1:addChild(var_12_13)
end

function PokemonTile:showSkillDetailPanel(arg_18_1)
	if self.skillDesPanel == nil then
		self.skillDesPanel = ccui.Layout:create()

		self.skillDesPanel:setContentSize(cc.size(450, 200))
		self.skillDesPanel:setAnchorPoint(cc.p(0, 0))
		self.skillDesPanel:setPosition(cc.p(80, 600))
		self.skillDesPanel:setClippingEnabled(true)
		self.skillDesPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.skillDesPanel:setBackGroundColor(cc.c3b(0, 0, 0))
		self.skillDesPanel:setBackGroundColorOpacity(200)
		self.skillDesPanel:setVisible(false)
		self.horcruxInfoPanel:addChild(self.skillDesPanel)

		local var_18_0 = cc.Label:createWithTTF("???", FONT_NAME, 28)

		var_18_0:setAnchorPoint(cc.p(0, 0.5))
		var_18_0:setPosition(cc.p(20, self.skillDesPanel:getContentSize().height - 25))
		var_18_0:setColor(cc.c3b(255, 150, 0))
		var_18_0:setName("skillDesPanelName")
		self.skillDesPanel:addChild(var_18_0)

		local var_18_1 = cc.Label:createWithTTF("???", FONT_DES, 22)

		var_18_1:setAnchorPoint(cc.p(0, 1))
		var_18_1:setPosition(cc.p(20, self.skillDesPanel:getContentSize().height - 45))
		var_18_1:setColor(cc.c3b(255, 255, 255))
		var_18_1:setMaxLineWidth(self.skillDesPanel:getContentSize().width - 40)
		var_18_1:setLineBreakWithoutSpace(true)
		var_18_1:setName("skillDesPanelDes")
		self.skillDesPanel:addChild(var_18_1)
	end

	self.skillDesPanel:setVisible(true)
	self.skillDesPanel:getChildByName("skillDesPanelName"):setString(total_skill_data[arg_18_1].name)
	self.skillDesPanel:getChildByName("skillDesPanelDes"):setString(total_skill_data[arg_18_1].description)
end

function PokemonTile:closSkillDetailPanel()
	if self.skillDesPanel then
		self.skillDesPanel:setVisible(false)
	end
end

function PokemonTile:schedulerWithCallback(arg_20_1, arg_20_2)
	arg_20_2 = arg_20_2 or 1

	if self.scheduler ~= nil then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
	end

	self.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		if type(arg_20_1) == "function" then
			arg_20_1()
		end

		if self.scheduler ~= nil then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
		end
	end, arg_20_2, false)
end

return PokemonTile
