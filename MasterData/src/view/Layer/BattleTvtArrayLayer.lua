BattleTvtArrayLayer = class("BattleTvtArrayLayer", function()
	return BattleArrayLayerNew:createNode()
end)

local var_0_0 = config._DEBUG and 0 or 1
local model_data = require("data.model_data")
local arenatft_manager = require("controller.arenatft_manager")
local audio_manager = require("controller.audio_manager")

require("view.Sprite.GirlSprite")

function BattleTvtArrayLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = BattleTvtArrayLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function BattleTvtArrayLayer.layerExit(arg_3_0)
	return
end

function BattleTvtArrayLayer.createFullScreenMask(arg_4_0)
	return
end

function BattleTvtArrayLayer:initFilepath()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BattleTvtArrayLayer.json" or "BattleTvtArrayLayer.ExportJson")

	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.mapOfEnemy = {}

	self:initBottomList()
end

function BattleTvtArrayLayer:initBottomList()
	require("view.Sprite.BottomBtnList")

	self.bottomList = BottomBtnList:create(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.rootLayer:addChild(self.bottomList)

	self.sureBtn = ccui.Button:create("public/button/public_button_big_blue_y.png", nil, "public/button/public_button_big_blue_y.png", var_0_0)

	self.sureBtn:setPosition(cc.p(520, 30))
	self.sureBtn:setName("Button_sureBtn")
	self.bottomList:addChild(self.sureBtn)

	local var_6_0 = cc.Label:createWithTTF("", FONT_TITLE, 30)

	var_6_0:setName("label_btn")
	var_6_0:setColor(cc.c3b(12, 12, 12))
	var_6_0:setPosition(cc.p(self.sureBtn:getContentSize().width / 2, self.sureBtn:getContentSize().height / 2))
	self.sureBtn:addChild(var_6_0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):removeFromParent()
end

function BattleTvtArrayLayer:initBg(arg_8_1)
	local var_8_0 = ccui.Layout:create()

	var_8_0:setTouchEnabled(true)
	var_8_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_8_0:setAnchorPoint(cc.p(0, 0))
	var_8_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_8_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_8_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_8_0:setOpacity(0)
	self:addChild(var_8_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_9_0)
		self:addChild(arg_9_0, -2)
		arg_9_0:setPositionY(arg_9_0:getPositionY() - GameDisplay.fix_y)

		local var_9_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_9_0:setAnchorPoint(cc.p(0, 0))
		var_9_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_9_0, -1)
		self:init(arg_8_1)
		self:initEnemyInfo(arg_8_1)
		var_8_0:setOpacity(102)
		var_8_0:setTouchEnabled(false)
	end)
end

function BattleTvtArrayLayer:initEnemyInfo(arg_10_1)
	self.enemyBottom = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_enemy_bottom")

	local var_10_0 = self.enemyBottom:getChildByName("Panel_servant")

	self.labelEnemyPower = self.enemyBottom:getChildByName("BitmapLabel_enemy_power")
	self.imageArrayName = self.enemyBottom:getChildByName("Image_array_name")
	self.panelServantTable = {}

	for iter_10_0 = 1, 4 do
		local var_10_1 = var_10_0:clone()

		var_10_1:setPosition(cc.p(15, 32))
		self.enemyBottom:addChild(var_10_1, 99)

		self.panelServantTable[#self.panelServantTable + 1] = var_10_1
	end

	self.enemySpriteId = 1
	self.enemyArrays = arg_10_1.enemy_arrays
	self.enemyFightInfo = arg_10_1.enemy_fight_info

	self:initEnemyGirlSprite()
	self:updateEnemySpriteCell(self.enemySpriteId)
	var_10_0:setVisible(false)
end

function BattleTvtArrayLayer:initEnemyGirlSprite()
	for iter_11_0, iter_11_1 in pairs(self.panelServantTable) do
		local var_11_0 = GirlSprite:create({
			initType = "enemyStyle"
		})

		var_11_0:setPositionX(self.panelServantTable[iter_11_0]:getContentSize().width / 2)
		var_11_0:setPositionY(self.panelServantTable[iter_11_0]:getContentSize().height / 2)
		var_11_0:setName("girlSprite")
		self.panelServantTable[iter_11_0]:addChild(var_11_0, 99)
		self.panelServantTable[iter_11_0]:setVisible(true)
		var_11_0:setTouchEnabled(false)
		var_11_0:setVisible(arenatft_manager:isEnemyArrayMemNil(1, iter_11_0))
	end
end

function BattleTvtArrayLayer:updateEnemySpriteCell(arg_12_1)
	local var_12_0 = arenatft_manager:getEnemyArrayData(arg_12_1)

	self.labelEnemyPower:setString(global_trans_number((arenatft_manager:getEnemyArrayFightpower())))
	self.imageArrayName:loadTexture("PopTvtRecordLayer/array" .. arg_12_1 .. ".png", var_0_0)

	for iter_12_0 = 1, 4 do
		self:updateEnemySpriteSlot(var_12_0[iter_12_0], arg_12_1, iter_12_0)
	end
end

function BattleTvtArrayLayer:updateEnemySpriteSlot(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0

	if arenatft_manager:isEnemyArrayMemNil(arg_13_2, arg_13_3) then
		local var_13_1 = {
			servantId = arg_13_1.servantid,
			contract = arg_13_1.contract
		}

		var_13_1.level = arg_13_1.servantlevel or 100
		var_13_1.rank = arg_13_1.servantrank or 0
		var_13_0 = var_13_1
	end

	self.panelServantTable[arg_13_3].servantid = var_13_0

	self.panelServantTable[arg_13_3]:setVisible(true)

	local var_13_3 = self.panelServantTable[arg_13_3]:getChildByName("girlSprite")

	if var_13_0 then
		var_13_3:update(var_13_0)
		var_13_3:setVisible(true)
		ccui.Helper:seekWidgetByName(self.panelServantTable[arg_13_3], "Panel_servant"):getChildByName("Image_bg"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(self.panelServantTable[arg_13_3], "Panel_servant"):getChildByName("Image_bg"):setVisible(true)
		var_13_3:setVisible(false)
	end
end

function BattleTvtArrayLayer.createArrayIndexBtn(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 == "+" and ccui.ImageView:create("public/button/array_inde_btn_add.png", var_0_0) or ccui.ImageView:create("public/button/array_index_btn.png", var_0_0)

	var_14_0:setTouchEnabled(true)

	var_14_0.index = arg_14_1

	var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_15_0.index == "+" then
			arg_14_0:addArray()

			return
		end

		arg_14_0.curSelectArrayId = arg_15_0.index

		arg_14_0:updateAllCell()
		arg_14_0:updateTeamSkill()
		arg_14_0:initArrayFightCapacity()
		arg_14_0:updateArrayListPanel()
		arg_14_0:updateSureBtn(arg_14_0.enemySpriteId)
	end)

	local var_14_1 = cc.Label:createWithTTF(arg_14_1, FONT_NAME, 28)

	var_14_1:setColor(cc.c3b(208, 233, 247))
	var_14_1:setName("label")
	var_14_1:setPositionX(var_14_0:getContentSize().width / 2)
	var_14_1:setPositionY(var_14_0:getContentSize().height / 2)
	var_14_0:addChild(var_14_1)

	return var_14_0
end

function BattleTvtArrayLayer:updateNextArray()
	self:updateAllCell()
	self:initArrayFightCapacity()
	self:updateArrayListPanel()
end

function BattleTvtArrayLayer:updateSureBtn(arg_17_1)
	arg_17_1 = arg_17_1 or 1

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString("")
	self.sureBtn:loadTextures(not self.mapOfEnemy[self.curSelectArrayId] and "public/button/public_button_big_blue_y.png" or "public/button/public_button_gray.png", nil, not self.mapOfEnemy[self.curSelectArrayId] and "public/button/public_button_big_blue_y.png" or "public/button/public_button_gray.png", var_0_0)
	self.sureBtn:getChildByName("label_btn"):setString(L_TVT_TEAM_TIPS.Lock .. L_TVT_TEAM_TIPS.Team[arg_17_1])
end

function BattleTvtArrayLayer:btnSureEvent(arg_18_1)
	local var_18_0 = self.curSelectArrayId

	for iter_18_0, iter_18_1 in pairs((arenatft_manager:getAttackArrayData(self.curSelectArrayId))) do
		if iter_18_1.fight_girl then
			var_18_0 = false

			break
		end
	end

	if var_18_0 ~= false then
		if arg_18_1 then
			arg_18_1()
		end

		global_ShowBlockWords(string.format(L_TVT_ATTACK_ARRAY_NIL, var_18_0))

		return
	end

	if not self.mapOfEnemy[self.curSelectArrayId] then
		self.mapOfEnemy[self.curSelectArrayId] = self.enemySpriteId
	else
		if arg_18_1 then
			arg_18_1()
		end

		global_ShowBlockWords(L_TVT_CURRENT_HAVE_SET)

		return
	end

	local function var_18_1()
		self.enemySpriteId = self.enemySpriteId + 1

		if self.enemySpriteId == 4 then
			self.enemySpriteId = 3

			self:startFight(arg_18_1)

			return
		end

		self:updateEnemySpriteCell(self.enemySpriteId)

		for iter_19_0 = 1, 3 do
			if not self.mapOfEnemy[iter_19_0] then
				self.curSelectArrayId = iter_19_0

				break
			end
		end

		self:updateNextArray()
		self:updateTeamSkill()
		self:updateSureBtn(self.enemySpriteId)

		if arg_18_1 then
			arg_18_1()
		end
	end

	print("self.enemySpriteId,self.curSelectArrayId=============", self.enemySpriteId, self.curSelectArrayId)
	arenatft_manager:set_fight_array_order(self.enemySpriteId, self.curSelectArrayId, var_18_1)
	audio_manager:playeffectMusicTest("sound/fightBegin")
end

function BattleTvtArrayLayer.startFight(arg_20_0, arg_20_1)
	audio_manager:playeffectMusicTest("sound/fightBegin")
	arenatft_manager:start_fight(function(arg_21_0)
		if arg_21_0 == 1 then
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			LayerManager:removePopLayer(arg_20_0.__queueindex)
		elseif arg_21_0 == 5 then
			global_ShowBlockWords(L_TVT_ATTACK_ARRAY)
		end

		if arg_20_1 then
			arg_20_1()
		end
	end)
end

function BattleTvtArrayLayer.exit(arg_22_0)
	arenatft_manager:setLayerBtnLock(false)

	local var_22_0 = {
		surecallback = function()
			arenatft_manager:giveup_match_enemy(function()
				LayerManager:removePopLayer(arg_22_0.__queueindex)
				LayerManager:removePopLayer()
			end)
		end
	}
	local var_22_1 = {
		title = L_TVT_EIXT_TITLE
	}

	var_22_1.des = arenatft_manager:isPlayerCanRefuse() and string.format(L_TVT_EIXT_CONFIRM_1, (arenatft_manager:getRemainRefuseTime())) or L_TVT_EIXT_CONFIRM_2
	var_22_0.labels = var_22_1

	LayerManager:pushInLayer("PopDoLayer", var_22_0)
end

return BattleTvtArrayLayer
