local Formation3V3Layer = class("Formation3V3Layer", (require("view.Layer.Formation.BaseFormationLayer")))

require("view.Sprite.BottomBtnList")

local model_data = require("data.model_data")
local arenatft_manager = require("controller.arenatft_manager")
local audio_manager = require("controller.audio_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6 = "Formation3V3Layer/"
local var_0_7 = 300

function Formation3V3Layer:ctor()
	Formation3V3Layer.super.ctor(self)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = 1
	self.configType = CONFIG_TYPE_TVT_ATTACK_FORM
	self.selectGirlType = SELECT_GIRL_TVT_ATTACK
	self.selectHorcruxType = SELECT_HORCRUX_TVT_ATTACK
	self.bInit = true
	self.mapOfEnemy = {}
end

function Formation3V3Layer:initManager()
	self.manager = require("controller.formation.formation_3v3_manager"):getInstance()
end

function Formation3V3Layer:create(arg_3_1)
	local var_3_0 = Formation3V3Layer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function Formation3V3Layer:init(arg_4_1)
	if Formation3V3Layer.super.init(self, arg_4_1) then
		self.formationLayout:move(cc.p(0, self._root:size().h / 2 - self.formationLayout:size().h * 0.7))
		self:updateLayer()

		return true
	end

	return false
end

function Formation3V3Layer:initLayer()
	Formation3V3Layer.super.initLayer(self)

	self.bottomList = BottomBtnList:create(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	self._root:addChild(self.bottomList)

	self._sureBtn = TempWidget:CreateTempBtn("public/button/public_button_big_blue_y.png")

	self._sureBtn:setPosition(cc.p(520, 30))
	self._sureBtn:_addEvent(function()
		local var_7_0 = self.curFormationIndex

		for iter_7_0, iter_7_1 in pairs((arenatft_manager:getAttackArrayData(self.curFormationIndex))) do
			if iter_7_1.fight_girl then
				var_7_0 = false

				break
			end
		end

		if var_7_0 ~= false then
			global_ShowBlockWords(string.format(L_TVT_ATTACK_ARRAY_NIL, var_7_0))

			return
		end

		if not self.mapOfEnemy[self.curFormationIndex] then
			self.mapOfEnemy[self.curFormationIndex] = self.enemySpriteId
		else
			global_ShowBlockWords(L_TVT_CURRENT_HAVE_SET)

			return
		end

		arenatft_manager:set_fight_array_order(self.enemySpriteId, self.curFormationIndex, function()
			self.enemySpriteId = self.enemySpriteId + 1

			if self.enemySpriteId == 4 then
				self.enemySpriteId = 3

				self:startFight()

				return
			end

			self:updateEnemySpriteCell()

			for iter_8_0 = 1, 3 do
				if not self.mapOfEnemy[iter_8_0] then
					self:selectIndex(iter_8_0)

					break
				end
			end
		end)
		audio_manager:playeffectMusicTest("sound/fightBegin")
	end)
	self.bottomList:addChild(self._sureBtn)

	local var_5_0 = TempWidget:CreateTempLabel("", FONT_TITLE, 30)

	var_5_0:setColor(cc.c3b(12, 12, 12))
	var_5_0:setPosition(cc.p(self._sureBtn:getContentSize().width / 2, self._sureBtn:getContentSize().height / 2))
	self._sureBtn:addChild(var_5_0)

	self.labelBtn = var_5_0

	self:initEnemyLayout()
	self:updateSureBtn()
	self:checkAutoFight()
	self._bg:setPositionY(self._root:size().h / 2 - 300)
	self._switchLayout:setVisible(false)
end

function Formation3V3Layer:checkAutoFight()
	if RoleDefault:getInstance():getBoolForKey("TvtAutoFight", false) then
		global_count_down_layer(4, function()
			self:startFight()
		end, function()
			RoleDefault:getInstance():setBoolForKey("TvtAutoFight", false)
		end)
	end
end

function Formation3V3Layer:initListener()
	Formation3V3Layer.super.initListener(self)
	self._root:_addEvent(function()
		return
	end)
end

function Formation3V3Layer:onEnter()
	Formation3V3Layer.super.onEnter(self)
end

function Formation3V3Layer:onExit()
	Formation3V3Layer.super.onExit(self)
end

function Formation3V3Layer:isShowAutoFormationBtn()
	return false
end

function Formation3V3Layer:isShowFetterBtn()
	return false
end

function Formation3V3Layer:isShowSureBtn()
	return false
end

function Formation3V3Layer:initEnemyLayout()
	self.enemySpriteId = 1

	local var_19_0 = TempWidget:CreateTempLayout(self._root)

	var_19_0:setContentSize(cc.size(self._root:size().w, var_0_7))
	var_19_0:align(cc.p(0, 1), 0, self._root:size().h - 150)
	var_19_0:_addEvent(function()
		return
	end)

	local var_19_1 = TempWidget:CreateTempImg(var_0_6 .. "enemy_bg.png", var_19_0)

	var_19_1:setScale9Enabled(true)
	var_19_1:setCapInsets(cc.rect(0, 0, var_19_1:getContentSize().width, var_19_1:getContentSize().height))
	var_19_1:setContentSize(var_19_0:size())
	var_19_1:center()

	local var_19_2 = TempWidget:CreateTempImg(var_0_6 .. "array1.png", var_19_0)

	var_19_2:align(cc.p(0, 1), 0, var_19_0:size().h - 5)

	self.imageArrayName = var_19_2

	local var_19_3 = TempWidget:CreateTempLabel("99", FONT_NAME, 30, var_19_2)

	var_19_3:align(cc.p(0, 0.5), var_19_2:size().w - 125, var_19_2:size().h / 2)

	self.labelEnemyPower = var_19_3

	local var_19_4 = TempWidget:CreateTempListView(var_19_0)

	var_19_4:setDirection(ccui.ListViewDirection.horizontal)
	var_19_4:setContentSize(cc.size(var_19_0:size().w, var_19_0:size().h - 70))

	self.enemyGirlList = var_19_4

	local var_19_5 = cc.size(var_19_4:size().w / FORMATION_SHOW_GIRL_NUM, var_19_4:size().h)

	for iter_19_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_19_6 = TempWidget:CreateTempLayout()

		var_19_6:setContentSize(var_19_5)

		var_19_6._childData = {}

		TempWidget:CreateTempImg(var_0_6 .. "girl_null_bg.png", var_19_6):center()

		local var_19_7 = GirlSprite:create({
			initType = "enemyFormationStyle"
		})

		var_19_6:addChild(var_19_7)
		var_19_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_19_7:setScale(0.9)
		var_19_7:setPosition(cc.p(var_19_6:size().w / 2, var_19_6:size().h / 2))
		var_19_7:setVisible(arenatft_manager:isEnemyArrayMemNil(1, iter_19_0))

		var_19_6._childData.girlSprite = var_19_7

		var_19_4:pushBackCustomItem(var_19_6)
	end

	self:updateEnemySpriteCell()
end

function Formation3V3Layer:updateSureBtn()
	local var_21_0 = self.enemySpriteId or 1

	self._sureBtn:loadTextureNormal(not self.mapOfEnemy[self.curFormationIndex] and "public/button/public_button_big_blue_y.png" or "public/button/public_button_gray.png", var_0_5)
	self.labelBtn:setString(L_TVT_TEAM_TIPS.Lock .. L_TVT_TEAM_TIPS.Team[var_21_0])
end

function Formation3V3Layer:updateEnemySpriteCell()
	self.labelEnemyPower:setString(global_trans_number((arenatft_manager:getEnemyArrayFightpower())))
	self.imageArrayName:loadTexture(var_0_6 .. "array" .. self.enemySpriteId .. ".png", var_0_5)
	self:updateEnemyGirlList()
end

function Formation3V3Layer:updateEnemyGirlList()
	local var_23_0 = self.enemyGirlList:getItems()
	local var_23_1 = arenatft_manager:getEnemyArrayData(self.enemySpriteId)

	for iter_23_0 = 1, #var_23_0 do
		if arenatft_manager:isEnemyArrayMemNil(self.enemySpriteId, iter_23_0) and var_23_1[iter_23_0] then
			var_23_0[iter_23_0]._childData.girlSprite:setVisible(true)

			local var_23_2 = {
				servantId = var_23_1[iter_23_0].servantid,
				contract = var_23_1[iter_23_0].contract
			}

			var_23_2.level = var_23_1[iter_23_0].servantlevel or 100
			var_23_2.rank = var_23_1[iter_23_0].servantrank or 0

			var_23_0[iter_23_0]._childData.girlSprite:update(var_23_2)
		else
			var_23_0[iter_23_0]._childData.girlSprite:setVisible(false)
		end
	end
end

function Formation3V3Layer:startFight(arg_24_1)
	audio_manager:playeffectMusicTest("sound/fightBegin")
	arenatft_manager:start_fight(function(arg_25_0)
		if arg_25_0 == 1 then
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			LayerManager:removePopLayer(self.__queueindex)
		elseif arg_25_0 == 5 then
			global_ShowBlockWords(L_TVT_ATTACK_ARRAY)
		end

		if arg_24_1 then
			arg_24_1()
		end
	end)
end

function Formation3V3Layer:selectIndex(arg_26_1)
	Formation3V3Layer.super.selectIndex(self, arg_26_1)
	self:updateSureBtn()
end

function Formation3V3Layer:exit()
	arenatft_manager:setLayerBtnLock(false)

	local var_27_0 = {
		surecallback = function()
			arenatft_manager:giveup_match_enemy(function()
				LayerManager:removePopLayer(self.__queueindex)
				LayerManager:switchShowLayer("ThreeVsThreeLayer")
			end)
		end
	}
	local var_27_1 = {
		title = L_TVT_EIXT_TITLE
	}

	var_27_1.des = arenatft_manager:isPlayerCanRefuse() and string.format(L_TVT_EIXT_CONFIRM_1, (arenatft_manager:getRemainRefuseTime())) or L_TVT_EIXT_CONFIRM_2
	var_27_0.labels = var_27_1

	LayerManager:pushInLayer("PopDoLayer", var_27_0)
end

return Formation3V3Layer
