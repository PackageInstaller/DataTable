PopAnswerQuestionLayer = class("PopAnswerQuestionLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local item_data = require("data.item_data")
local var_0_4 = {
	"A",
	"B",
	"C",
	"D"
}
local var_0_5 = {
	"yuwen",
	"shuxue",
	"waiyu",
	"kexue"
}

function PopAnswerQuestionLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopAnswerQuestionLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopAnswerQuestionLayer:init(arg_3_1)
	print("open poplayer : PopAnswerQuestionLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopAnswerQuestionLayer.json" or "PopAnswerQuestionLayer.ExportJson")

	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self:addChild(self.rootLayer)

	if arg_3_1 then
		self.id = arg_3_1.activityid or nil
	end

	if arg_3_1 then
		self.arrayid = arg_3_1.arrayid or 1
	end

	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_question_list(self.id, self.arrayid)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if arg_3_1.callback then
				arg_3_1.callback()
			end

			activity_manager:releaseEventListenerByName("PopAnswerQuestionLayer")
		end
	end)
end

function PopAnswerQuestionLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("PopAnswerQuestionLayer", activity_manager.activityEventId.QUSETION_LIST_UPDATE, function(arg_6_0)
		arg_5_0.questions = arg_6_0 and arg_6_0.questions

		arg_5_0:updateUI()
	end)
	activity_manager:registerEventListener("PopAnswerQuestionLayer", activity_manager.activityEventId.ANSWER_QUSTION_SUCCESS, function(arg_7_0)
		activity_manager:get_activity_question_list(arg_5_0.id, arg_5_0.arrayid)
	end)
end

function PopAnswerQuestionLayer:fullscreen()
	self.rootLayer:setPositionY(0 - GameDisplay.fix_y)

	local var_8_0 = self.rootLayer:getChildByName("bg")

	var_8_0:setPosition(cc.p(310, 700))

	var_8_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_8_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	var_8_0:setPositionY(var_8_0.full_posY)
end

function PopAnswerQuestionLayer:initUI()
	local var_9_0 = self.rootLayer:getChildByName("bg")

	var_9_0:loadTexture("PopAnswerQuestionLayer/Panel_bg_" .. var_0_5[self.arrayid] .. ".png", var_0_0)
	var_9_0:getChildByName("btn_detail"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_question"
		})
	end)
	self.rootLayer:getChildByName("bg"):setTouchEnabled(true)

	self.questionLbl = self.rootLayer:getChildByName("bg"):getChildByName("question")

	self.questionLbl:setString(L_ACTIVITY_QUESTION_END)
	self.questionLbl:setContentSize(cc.size(500, 230))
	self.questionLbl:setPosition(cc.p(320.5, 405))
	self.rootLayer:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0:setBright(false)
		self:exit()
	end)

	local var_9_1 = ccui.ImageView:create("PopAnswerQuestionLayer/img_detail.png", var_0_0)

	var_9_1:setAnchorPoint(cc.p(1, 0))
	var_9_1:setPosition(cc.p(630, 5))
	self.rootLayer:getChildByName("bg"):addChild(var_9_1)

	self.btn_last = ccui.Button:create("PopAnswerQuestionLayer/btn_last.png", "PopAnswerQuestionLayer/btn_last.png", "PopAnswerQuestionLayer/btn_last.png", var_0_0)

	self.btn_last:setPosition(cc.p(200, 295))
	self.btn_last:setVisible(false)
	self.rootLayer:addChild(self.btn_last)

	self.btn_next = ccui.Button:create("PopAnswerQuestionLayer/btn_next.png", "PopAnswerQuestionLayer/btn_next.png", "PopAnswerQuestionLayer/btn_next.png", var_0_0)

	self.btn_next:setPosition(cc.p(470, 295))
	self.btn_next:setVisible(false)
	self.rootLayer:addChild(self.btn_next)
	self.btn_last:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curindex = math.max(1, self.curindex - 1)

		self:updateUI()
	end)
	self.btn_next:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.questions or not next(self.questions) then
			return
		end

		if self.questions[self.curindex].stat == 0 then
			global_ShowBlockWords(L_ACTIVITY_NOTICE_ANSWER)

			return
		end

		self.curindex = math.min(#self.questions, self.curindex + 1)

		self:updateUI()
	end)
	self:fullscreen()
end

function PopAnswerQuestionLayer:updateUI()
	if not self.questions or not next(self.questions) then
		global_ShowBlockWords(L_ACTIVITY_NO_QUESTION)

		return
	end

	if self.curindex == nil then
		self.curindex = 1

		for iter_14_0 = 1, #self.questions do
			if self.questions[iter_14_0].stat == 0 then
				self.curindex = iter_14_0

				break
			end
		end
	end

	local var_14_0 = self.questions[self.curindex]
	local var_14_1 = self.questions[self.curindex].data

	self.questionLbl:setString(self.questions[self.curindex].data.qusetion)

	local var_14_2 = 1

	while self.questions[self.curindex].data["answer_" .. 1] do
		local var_14_3 = self.rootLayer:getChildByName("bg"):getChildByName("lbl_bg_" .. var_14_2)

		if var_14_3 then
			var_14_3:removeFromParent()
		end

		local var_14_4 = self:createAnswerSprite(self.questions[self.curindex].data, var_14_2, var_14_0.stat)

		var_14_4:setPosition(cc.p(300, 444 - 55 * var_14_2))

		var_14_4.index = var_14_2

		self.rootLayer:getChildByName("bg"):addChild(var_14_4)
		var_14_4:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_14_0.stat > 0 then
				global_ShowBlockWords(L_ACTIVITY_HAD_ANSWER)

				return
			end

			self:playOutFireAni(var_14_4, (var_14_2 ~= var_14_1.true_answer or nil) and "cuo", function()
				activity_manager:activity_answer_question(self.id, var_14_1.id, arg_15_0.index)
			end)
		end)

		var_14_2 = var_14_2 + 1
	end

	local var_14_6 = self.rootLayer:getChildByName("bg")
	local var_14_7 = var_14_6:getChildByName("drop_bg")

	if var_14_6 then
		var_14_7:getChildByName("drop"):removeFromParent()
	end

	local var_14_8 = self:createDropSptite(self.questions[self.curindex].data, var_14_0.stat)

	var_14_8:setName("drop")
	var_14_8:setPosition(cc.p(120, 70))
	var_14_7:addChild(var_14_8)
	self.btn_last:setVisible(self.curindex ~= 1)
	self.btn_next:setVisible(self.curindex ~= #self.questions)
end

function PopAnswerQuestionLayer.createAnswerSprite(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = ccui.Button:create("PopAnswerQuestionLayer/bg_normal.png", nil, "PopAnswerQuestionLayer/bg_normal.png", var_0_0)

	var_17_0:setName("lbl_bg_" .. arg_17_2)

	local var_17_1 = cc.Label:createWithTTF(var_0_4[arg_17_2], FONT_NAME, 24)

	var_17_1:setPosition(cc.p(25, var_17_0:getContentSize().height / 2 - 1))
	var_17_0:addChild(var_17_1)

	local var_17_2 = cc.Label:createWithTTF(arg_17_1["answer_" .. arg_17_2], FONT_NAME, 24)

	var_17_2:setPosition(cc.p(var_17_0:getContentSize().width / 2 + 20, var_17_0:getContentSize().height / 2 - 1))
	var_17_0:addChild(var_17_2)

	local var_17_3 = cc.p(495, 20)

	if arg_17_3 ~= 0 then
		if arg_17_2 == arg_17_3 and arg_17_1.true_answer == arg_17_2 then
			var_17_0:loadTextures("PopAnswerQuestionLayer/bg_true.png", nil, "PopAnswerQuestionLayer/bg_true.png", var_0_0)

			local var_17_4 = ccui.ImageView:create("PopAnswerQuestionLayer/true.png", var_0_0)

			var_17_4:setPosition(var_17_3)
			var_17_0:addChild(var_17_4)
			var_17_2:setColor(cc.c3b(0, 102, 99))
		elseif arg_17_2 == arg_17_3 and arg_17_1.true_answer ~= arg_17_2 then
			var_17_0:loadTextures("PopAnswerQuestionLayer/bg_false.png", nil, "PopAnswerQuestionLayer/bg_false.png", var_0_0)

			local var_17_5 = ccui.ImageView:create("PopAnswerQuestionLayer/false.png", var_0_0)

			var_17_5:setPosition(var_17_3)
			var_17_0:addChild(var_17_5)
			var_17_2:setColor(cc.c3b(255, 255, 255))
		elseif arg_17_2 == arg_17_1.true_answer and arg_17_2 ~= arg_17_3 then
			var_17_0:loadTextures("PopAnswerQuestionLayer/bg_true.png", nil, "PopAnswerQuestionLayer/bg_true.png", var_0_0)

			local var_17_6 = ccui.ImageView:create("PopAnswerQuestionLayer/true.png", var_0_0)

			var_17_6:setPosition(var_17_3)
			var_17_0:addChild(var_17_6)
			var_17_2:setColor(cc.c3b(80, 80, 80))
		end
	end

	return var_17_0
end

function PopAnswerQuestionLayer.createDropSptite(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = drop_manager:getAllDrops(arg_18_1.true_drop)

	if drop_manager:getGold(arg_18_1.true_drop) > 0 then
		table.insert(var_18_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(id)
		})
	end

	if drop_manager:getDiamond(arg_18_1.true_drop) > 0 then
		table.insert(var_18_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(id)
		})
	end

	var_18_0[2] = var_18_0[2] or {}

	local var_18_1 = ItemPurchaseSprite:createPurchaseItem(var_18_0[2].dropid or var_18_0[1].dropid, var_18_0[2].dropNum or var_18_0[1].dropNum)

	var_18_1:setScale(0.7)
	var_18_1:setTouchEnabled(true)
	var_18_1:setSwallowTouches(false)
	var_18_1:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		showItemDetails(var_18_0[2].dropid or var_18_0[1].dropid)
	end)

	if arg_18_2 > 0 and arg_18_1.true_answer == arg_18_2 then
		var_18_1:getChildByName("numLabel"):setString(L_BUTTON_TEXT.Got)
	end

	if item_data[var_18_0[2].dropid or var_18_0[1].dropid].bag_item_type == kITEM_SKIN then
		local var_18_2 = ccui.ImageView:create("PopAnswerQuestionLayer/img_skin.png", var_0_0)

		var_18_2:setPosition(cc.p(134, 140))
		var_18_2:setScale(1.4)
		var_18_1:addChild(var_18_2, 99)
	end

	return var_18_1
end

function PopAnswerQuestionLayer:initBg(arg_20_1)
	local var_20_0 = ccui.Layout:create()

	var_20_0:setTouchEnabled(true)
	var_20_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_20_0:setAnchorPoint(cc.p(0, 0))
	var_20_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_20_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_20_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_20_0:setOpacity(0)
	self:addChild(var_20_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_21_0)
		self:addChild(arg_21_0, -2)
		arg_21_0:setPositionY(arg_21_0:getPositionY() - GameDisplay.fix_y)

		local var_21_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_21_0:setAnchorPoint(cc.p(0, 0))
		var_21_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_21_0, -1)
		self:init(arg_20_1)
		var_20_0:setOpacity(102)
		var_20_0:setTouchEnabled(false)
	end)
end

function PopAnswerQuestionLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopAnswerQuestionLayer.playOutFireAni(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = L2Skeleton:create("spine/ui/dianjitexiao.json", "spine/ui/dianjitexiao.atlas")

	var_24_0:refreshSkeleton()
	var_24_0:setVisible(true)
	var_24_0:play(arg_24_2, false)
	var_24_0:setPosition(cc.p(arg_24_1:getContentSize().width / 2, arg_24_1:getContentSize().height / 2))
	var_24_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_25_0)
		if arg_24_3 then
			arg_24_3()
		end

		var_24_0:runAction(cc.RemoveSelf:create())
	end)
	arg_24_1:addChild(var_24_0, 2)
end
