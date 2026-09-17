local ActivityGarrisonSelectLayer = class("ActivityGarrisonSelectLayer", (require("view.Layer.BaseUILayer")))

require("view.Sprite.ItemSprite")

local Utility = require("common.Utility")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_4 = ""
local var_0_5 = 4
local texture_manager = require("controller.texture_manager")
local var_0_7 = require("controller.activity_garrison.activity_garrison_manager"):getInstance()
local drop_manager = require("controller.drop_manager")
local playermodel = require("model.playermodel")
local servant_data = require("data.servant_data")
local item_data = require("data.item_data")
local model_data = require("data.model_data")

function ActivityGarrisonSelectLayer:ctor()
	ActivityGarrisonSelectLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/activity_garrison/activity_garrison_select_manager"):getInstance()
	self._selectGirls = {}
end

function ActivityGarrisonSelectLayer:create(arg_2_1)
	local var_2_0 = ActivityGarrisonSelectLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ActivityGarrisonSelectLayer:onEnter()
	ActivityGarrisonSelectLayer.super.onEnter(self)
	self.manager:registerNotification("ActivityGarrisonSelectGirl", function(arg_4_0)
		self._selectGirls[arg_4_0.selectGirlIndex] = arg_4_0.selectGirl

		self:updateGirlList()
		self:updateRewardAddNumText()
	end)
	self.manager:registerNotification("ActivityGarrisonStart", function(arg_5_0)
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function ActivityGarrisonSelectLayer:onExit()
	ActivityGarrisonSelectLayer.super.onExit(self)

	if not config._DEBUG then
		texture_manager:unloadPopLayerTextures()
	end
end

function ActivityGarrisonSelectLayer:init(arg_7_1)
	self:initData(arg_7_1)
	self:initLayer()
	self:initListener()

	return true
end

function ActivityGarrisonSelectLayer:initData(arg_8_1)
	self._id = arg_8_1.activityId
	self._index = arg_8_1.index
	var_0_4 = string.format("ActivityGarrisonSelectLayer_%s/", self._id)

	if not config._DEBUG then
		texture_manager:loadPopLayerTextures({
			string.format("ActivityGarrisonSelectLayer_%s", self._id)
		})
	end

	self._config = var_0_7:getConfig(self._id)[self._index]

	local var_8_0 = string.split(self._config.need_servants, ",")

	self._needServantsList = var_8_0
	self._needServantsNum = #var_8_0
	self._girlNum = self._config.max_servant

	local var_8_1, var_8_2 = var_0_7:getGarrisonGirls(self._id)

	for iter_8_0 = 1, #var_8_0 do
		local var_8_3 = tonumber(var_8_0[iter_8_0])

		if playermodel.haveServant[var_8_3] and not var_8_2[var_8_3] then
			self._selectGirls[iter_8_0] = var_8_3
		end
	end
end

function ActivityGarrisonSelectLayer:initLayer()
	local var_9_0 = TempWidget:CreateTempLayout(self)

	var_9_0:_setBack()
	var_9_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_9_0:setBackGroundColorOpacity(150)
	var_9_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_9_0

	local var_9_1 = TempWidget:CreateTempImg(var_0_4 .. "bg.png", var_9_0)

	var_9_1:center()
	var_9_1:_addEvent(function()
		return
	end)

	local var_9_2 = TempWidget:CreateTempLabel(self._config.name_garrison, FONT_NAME, 50, var_9_1)

	var_9_2:align(cc.p(0.5, 0.5), var_9_1:size().w / 2, var_9_1:size().h - 60)

	local var_9_3 = TempWidget:CreateTempImg(var_0_4 .. "time_bg.png", var_9_1)

	var_9_3:align(cc.p(0.5, 0.5), var_9_2:pos().x, var_9_2:pos().y - var_9_2:size().h - 5)

	local var_9_4 = TempWidget:CreateTempLabel(string.format(L_ACTIVITY_GARRISON[7], Global_format_time_str(self._config.patrol_time)), FONT_NAME, 30, var_9_3)

	var_9_4:_setColor("fff100")
	var_9_4:align(cc.p(0.5, 0.5), var_9_3:size().w / 2, var_9_3:size().h / 2 - 2)

	local var_9_5 = TempWidget:CreateTempImg(var_0_4 .. "reward_title.png", var_9_1)

	var_9_5:align(cc.p(0, 0.5), 15, var_9_3:pos().y - var_9_3:size().h / 2 - 35)

	local var_9_6 = TempWidget:CreateTempImg(var_0_4 .. "reward_add_bg.png", var_9_1)

	var_9_6:align(cc.p(1, 0.5), var_9_1:size().w - 32, var_9_5:pos().y)

	local var_9_7 = TempWidget:CreateTempLabel(string.format(L_ACTIVITY_GARRISON[8], self:getAddValue()), FONT_NAME, 20, var_9_6)

	var_9_7:align(cc.p(0.5, 0.5), var_9_6:size().w / 2, var_9_6:size().h / 2 + 5)

	self._rewardAddNumText = var_9_7

	local var_9_8 = TempWidget:CreateTempListView(var_9_1)

	var_9_8:setDirection(ccui.ScrollViewDir.horizontal)
	var_9_8:setContentSize(cc.size(var_9_1:size().w - 90, 111))
	var_9_8:align(cc.p(0.5, 0.5), var_9_1:size().w / 2, var_9_5:pos().y - var_9_5:size().h / 2 - 64)

	self._rewardList = var_9_8

	self:updateRewardList()

	local var_9_9 = TempWidget:CreateTempListView(var_9_1)

	var_9_9:setContentSize(cc.size(var_9_1:size().w - 100, 390))
	var_9_9:setDirection(ccui.ScrollViewDir.vertical)
	var_9_9:align(cc.p(0.5, 1), var_9_1:size().w / 2, var_9_8:pos().y - var_9_8:size().h / 2 - 80)

	self._girlList = var_9_9

	self:initGirlList()

	local var_9_10 = TempWidget:CreateTempBtn(var_0_4 .. "go_btn.png", var_9_1)

	var_9_10:align(cc.p(0.5, 0.5), var_9_1:size().w / 2 + 150, -50)

	self._goBtn = var_9_10

	local var_9_11 = TempWidget:CreateTempBtn(var_0_4 .. "qucik_select_btn.png", var_9_1)

	var_9_11:align(cc.p(0.5, 0.5), var_9_1:size().w / 2 - 150, -50)

	self._quickSelectBtn = var_9_11
end

function ActivityGarrisonSelectLayer:initListener()
	self._root:_addEvent(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self._goBtn:_addEvent(function()
		var_0_7:requestStart(self._id, self._index, self._selectGirls)
	end)
	self._quickSelectBtn:_addEvent(function()
		self:quickSelectGirls()
	end)
end

function ActivityGarrisonSelectLayer:getAddValue()
	local var_15_0 = 0
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in pairs(self._selectGirls) do
		var_15_1 = (playermodel.soulContract[iter_15_1] or 0) == 5 and var_15_1 + 1 or var_15_1
		var_15_0 = var_15_0 + 1
	end

	return var_15_1 * 20 + var_15_0 * 20
end

function ActivityGarrisonSelectLayer:getGirlOutSide(arg_16_1)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs(self._selectGirls) do
		var_16_0[#var_16_0 + 1] = iter_16_1
		var_16_1[iter_16_1] = true
	end

	if self._config.need_attr then
		if self._needServantsNum + 1 == arg_16_1 then
			for iter_16_2, iter_16_3 in pairs(servant_data) do
				if playermodel.haveServant[iter_16_3.id] then
					if not model_data[iter_16_3.modelid][self._config.need_attr] and not var_16_1[iter_16_3.id] then
						var_16_0[#var_16_0 + 1] = iter_16_3.id
					end
				else
					var_16_0[#var_16_0 + 1] = iter_16_3.id
				end
			end
		end
	else
		for iter_16_4, iter_16_5 in pairs(servant_data) do
			if not playermodel.haveServant[iter_16_5.id] and not var_16_1[iter_16_5.id] then
				var_16_0[#var_16_0 + 1] = iter_16_5.id
			end
		end
	end

	return var_16_0
end

function ActivityGarrisonSelectLayer:quickSelectGirls()
	local var_17_0, var_17_1 = var_0_7:getNeedGirls(self._id)
	local var_17_2, var_17_3 = var_0_7:getGarrisonGirls(self._id)
	local var_17_4 = {}
	local var_17_5 = {}
	local var_17_6 = {}

	for iter_17_0, iter_17_1 in pairs(playermodel.haveServant) do
		if not var_17_3[iter_17_0] then
			if var_17_1[iter_17_0] then
				var_17_6[#var_17_6 + 1] = iter_17_0
			else
				var_17_4[#var_17_4 + 1] = iter_17_0
				var_17_5[iter_17_0] = true
			end
		end
	end

	for iter_17_2 = self._needServantsNum + 1, self._girlNum do
		if not self._selectGirls[iter_17_2] and var_0_7:isUnlockGirl(self._id, iter_17_2) then
			local var_17_7

			if self._config.need_attr then
				var_17_7 = self._needServantsNum + 1
			end

			if var_17_7 and var_17_7 == iter_17_2 then
				for iter_17_3, iter_17_4 in pairs(var_17_4) do
					if model_data[servant_data[iter_17_4].modelid][self._config.need_attr] then
						table.remove(var_17_4, iter_17_3)

						self._selectGirls[iter_17_2] = iter_17_4

						break
					end
				end
			else
				for iter_17_5, iter_17_6 in pairs(var_17_4) do
					self._selectGirls[iter_17_2] = iter_17_6

					table.remove(var_17_4, iter_17_5)

					break
				end
			end
		end
	end

	for iter_17_7 = self._needServantsNum + 1, self._girlNum do
		if not self._selectGirls[iter_17_7] and var_0_7:isUnlockGirl(self._id, iter_17_7) then
			local var_17_8

			if self._config.need_attr then
				var_17_8 = self._needServantsNum + 1
			end

			if var_17_8 and var_17_8 == iter_17_7 then
				for iter_17_8, iter_17_9 in pairs(var_17_6) do
					if model_data[servant_data[iter_17_9].modelid][self._config.need_attr] then
						table.remove(var_17_6, iter_17_8)

						self._selectGirls[iter_17_7] = iter_17_9

						break
					end
				end
			else
				for iter_17_10, iter_17_11 in pairs(var_17_6) do
					self._selectGirls[iter_17_7] = iter_17_11

					table.remove(var_17_6, iter_17_10)

					break
				end
			end
		end
	end

	self:updateGirlList()
	self:updateRewardAddNumText()
end

function ActivityGarrisonSelectLayer:updateLayer()
	return
end

function ActivityGarrisonSelectLayer:updateRed()
	return
end

function ActivityGarrisonSelectLayer:updateRewardList()
	local var_20_0 = drop_manager:getAllDrops(var_0_7:getConfig(self._id)[self._index].dropid)

	for iter_20_0 = 1, #var_20_0 do
		local var_20_1 = var_20_0[iter_20_0].dropid
		local var_20_4 = TempWidget:CreateTempLayout()

		var_20_4:setContentSize(cc.size(100, self._rewardList:size().h))

		local var_20_5 = ItemSprite:createNewWithItemId(var_20_0[iter_20_0].dropid, var_20_0[iter_20_0].dropNum)

		var_20_5:setScale(0.45)
		var_20_4:addChild(var_20_5)
		var_20_5:setPosition(cc.p(var_20_4:getContentSize().width / 2, var_20_4:getContentSize().height / 2))
		var_20_4:_addEvent(function()
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_20_1
			})
		end)
		self._rewardList:pushBackCustomItem(var_20_4)
	end
end

function ActivityGarrisonSelectLayer:initGirlList()
	self._offsetX = 10
	self._cellLayoutWidth = (self._girlList:size().w - 10 * (var_0_5 - 1)) / var_0_5
	self._cellLayoutHeight = 130
	self._cellGirlImgHeight = self._cellLayoutHeight - 30

	for iter_22_0 = 1, math.ceil(self._girlNum / var_0_5) do
		self._girlList:pushBackCustomItem((self:createGirlRowLayout(iter_22_0)))
	end
end

function ActivityGarrisonSelectLayer:createGirlRowLayout(arg_23_1)
	local var_23_0 = TempWidget:CreateTempLayout()

	var_23_0:setContentSize(cc.size(self._girlList:size().w, self._cellLayoutHeight))

	for iter_23_0 = 1, var_0_5 do
		if (arg_23_1 - 1) * var_0_5 + iter_23_0 <= self._girlNum then
			local var_23_1 = self:createGirlCell((arg_23_1 - 1) * var_0_5 + iter_23_0)

			var_23_1:setTag((arg_23_1 - 1) * var_0_5 + iter_23_0)
			var_23_0:addChild(var_23_1)
			var_23_1:align(cc.p(0, 0), (iter_23_0 - 1) * (self._cellLayoutWidth + self._offsetX), 0)
		else
			break
		end
	end

	function var_23_0._update()
		for iter_24_0 = 1, var_0_5 do
			local var_24_0 = var_23_0:getChildByTag((arg_23_1 - 1) * var_0_5 + iter_24_0)

			if var_24_0 then
				var_24_0:_update()
			end
		end
	end

	return var_23_0
end

function ActivityGarrisonSelectLayer:createGirlCell(arg_25_1)
	local var_25_0 = TempWidget:CreateTempLayout()

	var_25_0:setContentSize(cc.size(self._cellLayoutWidth, self._cellLayoutHeight))

	local var_25_1 = self:createFixedLayout(arg_25_1)

	var_25_0:addChild(var_25_1)

	local var_25_2 = self:createSpecifiedLayout(arg_25_1)

	var_25_0:addChild(var_25_2)

	local var_25_3 = self:createNormalLayout(arg_25_1)

	var_25_0:addChild(var_25_3)

	function var_25_0._update()
		if arg_25_1 <= self._needServantsNum then
			var_25_1._update()
			var_25_1:show()
		else
			var_25_1:hide()
		end

		if self._config.need_attr and self._needServantsNum + 1 == arg_25_1 then
			var_25_2:_update()
			var_25_2:show()
		else
			var_25_2:hide()
		end

		local var_26_0 = self._needServantsNum

		if self._config.need_attr then
			var_26_0 = var_26_0 + 1
		end

		if var_26_0 < arg_25_1 then
			var_25_3._update()
			var_25_3:show()
		else
			var_25_3:hide()
		end
	end

	var_25_0._update()

	return var_25_0
end

function ActivityGarrisonSelectLayer:createFixedLayout(arg_27_1)
	local var_27_0 = TempWidget:CreateTempLayout()

	var_27_0:setContentSize(cc.size(self._cellLayoutWidth, self._cellLayoutHeight))

	function var_27_0._update()
		return
	end

	if arg_27_1 <= self._needServantsNum then
		local var_27_1 = TempWidget:CreateTempImg(var_0_4 .. "girl_normal_bg.png", var_27_0)

		var_27_1:align(cc.p(0.5, 1), var_27_0:size().w / 2, var_27_0:size().h)
		TempWidget:CreateTempImg(var_0_4 .. "girl_img_frame.png", var_27_1):center()

		local var_27_2 = TempWidget:CreateTempImg("equipment/" .. item_data[servant_data[tonumber(self._needServantsList[arg_27_1])].itemid].image_id .. ".png", var_27_1, 0)

		var_27_2:setScale(0.555)
		var_27_2:align(cc.p(0.5, 0.5), var_27_1:size().w / 2, var_27_1:size().h / 2 - 2)

		local var_27_3 = TempWidget:CreateTempImg(var_0_4 .. "girl_fixed_noget.png", var_27_0)

		var_27_3:align(cc.p(0.5, 1), var_27_0:size().w / 2, var_27_0:size().h)

		local var_27_4 = TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[9], FONT_NAME, 20, var_27_3)

		var_27_4:align(cc.p(0.5, 0.5), var_27_3:size().w / 2, var_27_3:size().h / 2)
		TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[10], FONT_NAME, 20, var_27_0):align(cc.p(0.5, 0), var_27_0:size().w / 2, 0)
		var_27_0:_addEvent(function()
			if self._selectGirls[arg_27_1] then
				global_ShowBlockWords(L_ACTIVITY_GARRISON[11])
			else
				local var_29_0, var_29_1 = var_0_7:getGarrisonGirls(self._id)
				local var_29_2 = tonumber(self._needServantsList[arg_27_1])

				if var_29_1[var_29_2] then
					global_ShowBlockWords(L_ACTIVITY_GARRISON[17])
				else
					for iter_29_0, iter_29_1 in ipairs((Utility:parseDataByElement(item_data[servant_data[var_29_2].itemid], {
						{
							index = "targetlayer",
							name = "roleJump"
						},
						{
							index = "targetlayer_starttime",
							name = "startTime",
							hyphen = "_"
						},
						{
							index = "targetlayer_finishtime",
							name = "endTime",
							hyphen = "_"
						}
					}))) do
						if tonumber(iter_29_1.roleJump) and Utility:isTimeRangeValid(iter_29_1.startTime, iter_29_1.endTime) or tonumber(iter_29_1.roleJump) and not iter_29_1.startTime and not iter_29_1.endTime then
							Utility:executeLayerJump({
								systemid = tonumber(iter_29_1.roleJump)
							})

							return
						end
					end

					global_ShowBlockWords(L_ACTIVITY_GARRISON[12])
				end
			end
		end)

		function var_27_0._update()
			if self._selectGirls[arg_27_1] then
				var_27_3:hide()
			else
				local var_30_0, var_30_1 = var_0_7:getGarrisonGirls(self._id)

				if var_30_1[tonumber(self._needServantsList[arg_27_1])] then
					var_27_4:setString(L_ACTIVITY_GARRISON[18])
				else
					var_27_4:setString(L_ACTIVITY_GARRISON[9])
				end

				var_27_3:show()
			end
		end
	end

	var_27_0._update()

	return var_27_0
end

function ActivityGarrisonSelectLayer:createSpecifiedLayout(arg_31_1)
	local var_31_0 = TempWidget:CreateTempLayout()

	var_31_0:setContentSize(cc.size(self._cellLayoutWidth, self._cellLayoutHeight))

	function var_31_0._update()
		return
	end

	if self._config.need_attr and self._needServantsNum + 1 == arg_31_1 then
		local var_31_1 = TempWidget:CreateTempImg(var_0_4 .. "girl_normal_bg.png", var_31_0)

		var_31_1:align(cc.p(0.5, 1), var_31_0:size().w / 2, var_31_0:size().h)

		local var_31_2 = TempWidget:CreateTempImg(var_0_4 .. "girl_img_frame.png", var_31_1)

		var_31_2:center()
		TempWidget:CreateTempImg(var_0_4 .. "add_img.png", var_31_2):center()

		local var_31_4 = TempWidget:CreateTempImg("equipment/1313120.png", var_31_1, 0)

		var_31_4:setScale(0.555)
		var_31_4:align(cc.p(0.5, 0.5), var_31_1:size().w / 2, var_31_1:size().h / 2 - 2)

		local var_31_5 = TempWidget:CreateTempImg(var_0_4 .. "specified_attr_bg.png", var_31_1)

		var_31_5:align(cc.p(0, 0), -2, -2)

		local var_31_6 = TempWidget:CreateTempImg("public/career_icon/link_" .. self._config.need_attr .. ".png", var_31_5)

		var_31_6:setScale(0.35)
		var_31_6:center()
		var_31_0:_addEvent(function()
			LayerManager:pushInLayer("GirlSelectLayer", {
				hideFilter = true,
				selectType = SELECT_GIRL_ACTIVITY_GARRISON,
				selectGirlIndex = arg_31_1,
				outSide = self:getGirlOutSide(arg_31_1)
			})
		end)

		function var_31_0._update()
			if self._selectGirls[arg_31_1] then
				var_31_4:loadTextureEx("equipment/" .. item_data[servant_data[self._selectGirls[arg_31_1]].itemid].image_id .. ".png", 0)
				var_31_4:show()
			else
				var_31_4:hide()
			end
		end
	end

	return var_31_0
end

function ActivityGarrisonSelectLayer:createNormalLayout(arg_35_1)
	local var_35_0 = TempWidget:CreateTempLayout()

	var_35_0:setContentSize(cc.size(self._cellLayoutWidth, self._cellLayoutHeight))

	function var_35_0._update()
		return
	end

	local var_35_1 = self._needServantsNum

	if self._config.need_attr then
		var_35_1 = var_35_1 + 1
	end

	if var_35_1 < arg_35_1 then
		local var_35_2 = TempWidget:CreateTempImg(var_0_4 .. "girl_normal_bg.png", var_35_0)

		var_35_2:align(cc.p(0.5, 1), var_35_0:size().w / 2, var_35_0:size().h)

		local var_35_3 = TempWidget:CreateTempImg(var_0_4 .. "girl_img_frame.png", var_35_2)

		var_35_3:center()

		local var_35_4 = TempWidget:CreateTempImg(var_0_4 .. "add_img.png", var_35_3)

		var_35_4:center()

		local var_35_6 = TempWidget:CreateTempImg("equipment/1313120.png", var_35_2, 0)

		var_35_6:setScale(0.555)
		var_35_6:align(cc.p(0.5, 0.5), var_35_2:size().w / 2, var_35_2:size().h / 2 - 2)

		local var_35_7 = TempWidget:CreateTempImg(var_0_4 .. "lock_bg.png", var_35_2)

		var_35_7:center()

		local var_35_8 = TempWidget:CreateTempLabel(L_ACTIVITY_GARRISON[13], FONT_NAME, 20, var_35_7)

		var_35_8:align(cc.p(0.5, 0.5), var_35_7:size().w / 2, var_35_7:size().h / 2 - 20)

		function var_35_0._update()
			if self._selectGirls[arg_35_1] then
				var_35_6:loadTextureEx("equipment/" .. item_data[servant_data[self._selectGirls[arg_35_1]].itemid].image_id .. ".png", 0)
				var_35_6:show()
			else
				var_35_6:hide()
			end

			local var_37_0 = var_0_7:getProConfig(self._id)
			local var_37_1 = var_0_7:getTaskLevel(self._id)

			if var_37_0[var_37_1].go_into_battle_num2 < arg_35_1 then
				for iter_37_0 = var_37_1 + 1, #var_37_0 do
					if var_37_0[iter_37_0].go_into_battle_num2 >= arg_35_1 then
						var_35_8:setString(string.format(L_ACTIVITY_GARRISON[14], iter_37_0))

						break
					end
				end

				var_35_7:show()
				var_35_4:hide()
			else
				var_35_7:hide()
				var_35_4:show()
			end
		end

		var_35_0:_addEvent(function()
			if var_0_7:getProConfig(self._id)[var_0_7:getTaskLevel(self._id)].go_into_battle_num2 < arg_35_1 then
				global_ShowBlockWords(L_ACTIVITY_GARRISON[13])
			else
				LayerManager:pushInLayer("GirlSelectLayer", {
					selectType = SELECT_GIRL_ACTIVITY_GARRISON,
					selectGirlIndex = arg_35_1,
					outSide = self:getGirlOutSide(arg_35_1)
				})
			end
		end)
	end

	return var_35_0
end

function ActivityGarrisonSelectLayer:updateGirlList()
	local var_39_0 = self._girlList:getItems()

	for iter_39_0 = 1, #var_39_0 do
		var_39_0[iter_39_0]._update()
	end
end

function ActivityGarrisonSelectLayer:updateRewardAddNumText()
	self._rewardAddNumText:setString(string.format(L_ACTIVITY_GARRISON[8], self:getAddValue()))
end

return ActivityGarrisonSelectLayer
