CostumeRoomShowLayer = class("CostumeRoomShowLayer", (require("view.Layer.BaseUILayer")))

local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local time_check_manager = require("controller.time_check_manager")
local device_manager = require("controller.device_manager")
local activity_manager = require("controller.activity_manager")
local share_manager = require("controller.share_manager")
local item_data = require("data.item_data")
local shop_data = require("data.shop_data")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local L2Actor = require("view.Sprite.L2Actor")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local TempWidget = require("view.Sprite.TempWidget")
local Utility = require("common.Utility")
local var_0_15 = config._DEBUG and 0 or 1
local var_0_16 = "CostumeRoomShowLayer/"
local var_0_17 = {}
local var_0_18 = {
	[0] = function()
		return playermodel.diamond
	end,
	function()
		return playermodel.gold
	end,
	function()
		return playermodel.honor
	end,
	function()
		return playermodel.explorecoin
	end,
	[100] = function()
		return 0
	end
}

setmetatable(var_0_18, {
	__index = function(arg_6_0, arg_6_1)
		return function()
			return item_manager:getItemNumber(arg_6_1)
		end
	end
})

function CostumeRoomShowLayer:ctor()
	self.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.costume_room_show_manager"):getInstance()
	self.showModel = nil
	self.scalerate = 1
	self.min_scale = 1
	self.max_scale = 1.5

	self:initPopLayerFunc()
end

function CostumeRoomShowLayer.create(arg_9_0, arg_9_1)
	local var_9_0 = CostumeRoomShowLayer.new()

	if var_9_0 and var_9_0:init(arg_9_1) then
		return var_9_0
	end

	return nil
end

function CostumeRoomShowLayer:onEnter()
	self.super.onEnter(self)
	self:initEnterAction()
	activity_manager:registerEventListener("CostumeRoomShowLayer", activity_manager.activityEventId.CHANGE_TEST_A_FIGHT_ARRAY_SUCCESS, function(arg_11_0)
		LayerManager:pushInLayer("TestFightLayer")
	end)
	activity_manager:registerEventListener("CostumeRoomShowLayer", activity_manager.activityEventId.CHANGE_TEST_P_FIGHT_ARRAY_SUCCESS, function(arg_12_0)
		LayerManager:removePopLayer()
		LayerManager:removePopLayer()
	end)
end

function CostumeRoomShowLayer:onExit()
	self.super.onExit(self)
	activity_manager:releaseEventListenerByName("CostumeRoomShowLayer")
end

function CostumeRoomShowLayer:init(arg_14_1)
	self.param = arg_14_1

	self:initLayer()
	self:initListener()

	return true
end

function CostumeRoomShowLayer:initEnterAction()
	self.locallyBtn:move(GameDisplay.width + self.locallyBtn:size().w, self.locallyBtn:getPositionY())
	self.locallyBtn:runAction(cc.MoveBy:create(0.1, cc.p(-self.locallyBtn:size().w, 0)))
	self.screenshotSharingBtn:move(GameDisplay.width + self.screenshotSharingBtn:size().w, self.screenshotSharingBtn:getPositionY())
	self.screenshotSharingBtn:runAction(cc.MoveBy:create(0.1, cc.p(-self.screenshotSharingBtn:size().w, 0)))
	self.titleBg:move(-self.titleBg:size().w, self.titleBg:getPositionY())
	self.titleBg:runAction(cc.MoveBy:create(0.1, cc.p(self.titleBg:size().w, 0)))
	self.backBg:move(self.backBg:getPositionX(), -self.backBg:size().h)
	self.backBg:runAction(cc.MoveBy:create(0.1, cc.p(0, self.backBg:size().h)))

	local var_15_0 = cc.p(self.typeImg:getPosition())

	self.typeImg:move(-self.typeImg:size().w, var_15_0.y)
	self.typeImg:runAction(cc.MoveBy:create(0.1, cc.p(var_15_0.x + self.typeImg:size().w + 20, 0)))
end

function CostumeRoomShowLayer:initLayer()
	local var_16_0 = TempWidget:CreateTempLayout(self)

	var_16_0:setContentSize(self:getContentSize())
	var_16_0:setLocalZOrder(-2)

	self.touchLayout = var_16_0

	local var_16_1 = TempWidget:CreateTempLayout(self)

	var_16_1:setContentSize(self:getContentSize())
	var_16_1:setLocalZOrder(-1)
	var_16_1:align(cc.p(0.5, 0.5), self:getContentSize().width / 2, self:getContentSize().height / 2)

	self.showGirlLayout = var_16_1

	self:addSkinInteractionLayout()

	local var_16_2 = TempWidget:CreateTempLayout(var_16_1)

	var_16_2:setContentSize(var_16_1:size())
	var_16_2:hide()

	self.restoreScaleLayout = var_16_2

	local var_16_3 = TempWidget:CreateTempImg(self.param.bgPath, var_16_1, 0)

	var_16_3:align(cc.p(0, 0), 0, 0)
	var_16_3:setLocalZOrder(-4)
	var_16_3:hide()

	if self.param.bgPath then
		var_16_3:show()
	end

	self.showGirlLayoutBg = var_16_3
	self.showModel = tonumber(self.param.modelId)
	self.showGirlLayer = ShowGirlLayer:create(self.param.modelId, 3)

	self.showGirlLayer:resetCurTalkConfig()
	self.showGirlLayer:setTalkEnabled(true)
	self.showGirlLayer:setLocalZOrder(-2)
	self.showGirlLayer:setPosition(cc.p(0, GameDisplay.fix_y))
	self.showGirlLayout:addChild(self.showGirlLayer)
	self:updatestaticTouchCount()

	local var_16_4 = TempWidget:CreateTempLayout(self.showGirlLayout)

	var_16_4:setContentSize(self.showGirlLayout:size())
	var_16_4:setLocalZOrder(self.showGirlLayer:getLocalZOrder() + 1)

	self.showGirlShareLayout = var_16_4

	self:initShowGirlShareLayout()

	if model_data[self.param.modelId].backgroundid and not self.param.bgPath then
		local var_16_6 = BackGroundLayer:create(model_data[self.param.modelId].backgroundid, (model_data[self.param.modelId].is_own_full_screen_background == 1 or nil) and 2)

		var_16_6:setPosition(cc.p(0, GameDisplay.fix_y))
		self.showGirlLayout:addChild(var_16_6, -3)
	end

	self._root = TempWidget:CreateTempLayout(self)

	self._root:setContentSize(self:getContentSize())

	local var_16_7 = TempWidget:CreateTempImg(var_0_16 .. "down_line.png", self._root)

	var_16_7:setLocalZOrder(99)
	var_16_7:align(cc.p(0, 0), 0, 0)
	var_16_7:setOpacity(0)
	var_16_7:setCascadeOpacityEnabled(false)

	self.backBg = var_16_7

	local var_16_8 = TempWidget:CreateTempBtn(var_0_16 .. "btn_back.png", var_16_7)

	var_16_8:align(cc.p(0, 0.5), 0, var_16_7:size().h / 2)

	self.backBtn = var_16_8

	local var_16_9 = TempWidget:CreateTempBtn(var_0_16 .. "yige.png", self._root)

	var_16_9:align(cc.p(0, 0), 0, var_16_7:getPositionY() + var_16_7:size().h + 10)

	if self.param.uncolorClothes then
		var_16_9:show()
	else
		var_16_9:hide()
	end

	self.changeGirlBtn = var_16_9

	local var_16_10 = TempWidget:CreateTempBtn(var_0_16 .. "apply_btn.png", self._root)

	var_16_10:align(cc.p(1, 0), self._root:size().w - 10, var_16_9:pos().y + var_16_9:size().h + 10)

	self.applyBtn = var_16_10

	self:initBattleStandLayout()
	self:initTitle()
	self:initBuyLayout()
end

function CostumeRoomShowLayer:initBattleStandLayout()
	self._isShowFightModel = false

	local var_17_0 = TempWidget:CreateTempLayout(self._root)

	var_17_0:setContentSize(cc.size(250, 300))
	var_17_0:align(cc.p(1, 0), self._root:size().w / 2 + 70, 0)

	var_17_0._curPos = cc.p(var_17_0:size().w, var_17_0:size().h / 2)
	var_17_0._nextPos = cc.p(var_17_0:size().w - 150, var_17_0:size().h / 2)
	var_17_0._isAction = false
	self._battleStandLayout = var_17_0

	local var_17_1
	local var_17_2
	local var_17_3 = 0.8
	local var_17_4 = 0.3
	local var_17_5 = {
		var_17_0._curPos,
		cc.p(var_17_0._curPos.x - 150 / 2, var_17_0._curPos.y + 80),
		var_17_0._nextPos
	}
	local var_17_6 = {
		var_17_0._nextPos,
		cc.p(var_17_0._nextPos.x + 150 / 2, var_17_0._nextPos.y - 80),
		var_17_0._curPos
	}

	local function var_17_7()
		var_17_0._isAction = true
		self._isShowFightModel = not self._isShowFightModel

		if self.showGirlLayer then
			if self.showGirlLayer:getChildByName("roleimage") then
				self.showGirlLayer:getChildByName("roleimage")._talksp = nil
			end

			if self._isShowFightModel then
				self.showGirlLayer:update(tostring(self.param.fightModelId))
				self.changeGirlBtn:hide()
			else
				self.showGirlLayer:update(tostring(self.showModel))

				if self.param.uncolorClothes then
					self.changeGirlBtn:show()
				else
					self.changeGirlBtn:hide()
				end
			end

			if self.showGirlLayer:getChildByName("roleimage") then
				self.showGirlLayer:getChildByName("roleimage")._talksp = nil
			end
		end

		self:updateSpine()
		self:updateTitle()
		self:updateBuyLayoutVisible()
		self:updateTypeImgVisible()

		local var_18_0 = false
		local var_18_1 = false
		local var_18_2
		local var_18_3
		local var_18_4
		local var_18_5

		if var_17_1._state == 0 then
			var_18_2 = var_17_1
			var_18_3 = var_17_2
			var_18_4 = var_17_0._topBg1
			var_18_5 = var_17_0._topBg2
		else
			var_18_2 = var_17_2
			var_18_3 = var_17_1
			var_18_4 = var_17_0._topBg2
			var_18_5 = var_17_0._topBg1
		end

		var_18_3:setLocalZOrder(var_18_2:getLocalZOrder() + 1)
		var_18_2:stopAllActions()
		var_18_2:runAction(cc.Sequence:create(cc.Spawn:create(cc.BezierTo:create(var_17_4, var_17_5), cc.ScaleTo:create(var_17_4, var_17_3)), cc.CallFunc:create(function()
			var_18_0 = true
			var_18_2._state = 1

			var_18_4:loadTextureEx(var_0_16 .. "stand_next_bg.png")

			if var_18_0 and var_18_1 then
				var_17_0._isAction = false
			end
		end)))
		var_18_3:stopAllActions()
		var_18_3:runAction(cc.Sequence:create(cc.Spawn:create(cc.BezierTo:create(var_17_4, var_17_6), cc.ScaleTo:create(var_17_4, 1)), cc.CallFunc:create(function()
			var_18_1 = true
			var_18_3._state = 0

			var_18_5:loadTextureEx(var_0_16 .. "stand_cur_bg.png")

			if var_18_0 and var_18_1 then
				var_17_0._isAction = false
			end
		end)))
	end

	var_17_1 = TempWidget:CreateTempImg(var_0_16 .. "stand_bg.png", var_17_0)
	var_17_1._state = 0

	var_17_1:align(cc.p(1, 0.5), var_17_0._curPos)
	var_17_1:_addEvent(function()
		if not var_17_0._isAction then
			var_17_7()
		end
	end)

	var_17_0._standImg1 = var_17_1

	local var_17_8 = TempWidget:CreateTempImg("", var_17_1)

	var_17_8:center()

	var_17_0._roleImage1 = var_17_8

	local var_17_9 = TempWidget:CreateTempImg(var_0_16 .. "stand_cur_bg.png", var_17_1)

	;(nil):setLocalZOrder(5)
	;(nil):center()

	var_17_0._topBg1 = nil

	local var_17_10 = TempWidget:CreateTempLabel("", FONT_NAME, 19, var_17_1)

	var_17_10:align(cc.p(0.5, 0), var_17_1:size().w / 2, 15)
	var_17_10:setLocalZOrder((nil):getLocalZOrder() + 1)

	var_17_0._name1 = var_17_10
	var_17_2 = TempWidget:CreateTempImg(var_0_16 .. "stand_bg.png", var_17_0)
	var_17_2._state = 1

	var_17_2:setScale(0.8)
	var_17_2:align(cc.p(1, 0.5), var_17_0._nextPos)
	var_17_2:_addEvent(function()
		if not var_17_0._isAction then
			var_17_7()
		end
	end)

	var_17_0._standImg2 = var_17_2

	local var_17_11 = TempWidget:CreateTempImg("", var_17_2)

	var_17_11:center()

	var_17_0._roleImage2 = var_17_11

	local var_17_12 = TempWidget:CreateTempImg(var_0_16 .. "stand_next_bg.png", var_17_2)

	;(nil):setLocalZOrder(5)
	;(nil):center()

	var_17_0._topBg2 = nil

	local var_17_13 = TempWidget:CreateTempLabel("", FONT_NAME, 19, var_17_2)

	var_17_13:align(cc.p(0.5, 0), var_17_1:size().w / 2, 15)
	var_17_13:setLocalZOrder((nil):getLocalZOrder() + 1)

	var_17_0._name2 = var_17_13

	self:updateBattleStandLayout()
end

function CostumeRoomShowLayer:updateBattleStandLayout()
	self._battleStandLayout._roleImage1:loadTextureEx("roleimage/role/shop_image/" .. model_data[tostring(self.showModel)].role_image .. ".png", 0)
	self._battleStandLayout._roleImage1:setScaleX((self._battleStandLayout._standImg1:size().w - 13) / self._battleStandLayout._roleImage1:size().w)
	self._battleStandLayout._roleImage1:setScaleY((self._battleStandLayout._standImg1:size().h - 13) / self._battleStandLayout._roleImage1:size().h)
	self._battleStandLayout._name1:setString(self.param.name)
	self._battleStandLayout._roleImage2:loadTextureEx("roleimage/role/shop_image/" .. model_data[tostring(self.param.fightModelId)].role_image .. ".png", 0)
	self._battleStandLayout._roleImage2:setScaleX((self._battleStandLayout._standImg2:size().w - 13) / self._battleStandLayout._roleImage2:size().w)
	self._battleStandLayout._roleImage2:setScaleY((self._battleStandLayout._standImg2:size().h - 13) / self._battleStandLayout._roleImage2:size().h)
	self._battleStandLayout._name2:setString(self.param.fightModelInfo.name or "")
end

function CostumeRoomShowLayer:initTitle()
	local var_24_0 = TempWidget:CreateTempImg(var_0_16 .. "title.png", self._root)

	var_24_0:align(cc.p(0, 1), 0, GameDisplay.height - 60)

	self.titleBg = var_24_0

	local var_24_1 = TempWidget:CreateTempLabel(self.param.roleEasyName or "", FONT_W5, 27)

	var_24_0:addChild(var_24_1)
	var_24_1:align(cc.p(0, 1), 5, var_24_0:size().h - 2)

	self.roleNameText = var_24_1

	local var_24_2 = TempWidget:CreateTempLabel(self.param.cvName or "", FONT_W5, 19)

	var_24_0:addChild(var_24_2)
	var_24_2:align(cc.p(0, 1), var_24_1:pos().x, var_24_1:pos().y - var_24_1:size().h - 8)

	self.cvText = var_24_2

	local var_24_3 = TempWidget:CreateTempLabel(self.param.name or "", FONT_W5, 26)

	var_24_3:_setColor("#000000")
	var_24_0:addChild(var_24_3)
	var_24_3:align(cc.p(0.5, 0), var_24_0:size().w / 2 - 5, 45)

	self.skinNameText = var_24_3

	local var_24_4

	if self.param.bLive2d then
		var_24_4 = var_0_16 .. "live2d_sign.png"
	elseif self.param.bRoleSpine then
		var_24_4 = var_0_16 .. "dynamic.png"
	end

	local var_24_5 = TempWidget:CreateTempImg(var_24_4, self._root)

	var_24_5:align(cc.p(0, 0), 0, var_24_0:getPositionY() - var_24_0:size().h - var_24_5:size().h - 10)
	var_24_5:hide()
	var_24_5:setRotation(-20)

	if self.param.bLive2d or self.param.bRoleSpine then
		var_24_5:show()
	end

	self.typeImg = var_24_5

	local var_24_6 = TempWidget:CreateTempImg(var_0_16 .. "q_kuang.png", self._root)

	var_24_6:align(cc.p(1, 1), GameDisplay.width - 10, GameDisplay.height - 20)

	self.qKuangImg = var_24_6

	self:updateSpine()

	local var_24_7 = TempWidget:CreateTempBtn(var_0_16 .. "locally_btn.png", self._root)

	var_24_7:hide()
	var_24_7:align(cc.p(1, 0), GameDisplay.width, var_24_6:getPositionY() - var_24_6:size().h - var_24_7:size().h - 5)

	self.locallyBtn = var_24_7

	if cc.Native.imageWriteToPhotosAlbum then
		var_24_7:show()
	end

	local var_24_8 = TempWidget:CreateTempBtn(var_0_16 .. "screenshotSharing_btn.png", self._root)

	var_24_8:hide()
	var_24_8:align(cc.p(1, 0), GameDisplay.width, var_24_7:getPositionY() - var_24_8:size().h)

	self.screenshotSharingBtn = var_24_8

	if share_manager:can_share() then
		var_24_8:show()
	end

	self.applyBtn:_addEvent(function()
		local test_fight_manager = require("controller/test_fight_manager")
		local var_25_1 = {
			{
				servantid = 203020
			},
			{},
			{},
			{},
			{}
		}

		var_25_1[1].modelid = servant_data[var_25_1[1].servantid].modelid

		if self._isShowFightModel then
			test_fight_manager:changeTestFightArray(var_25_1, {
				{
					servantid = self.param.fightModelInfo.servant,
					modelid = self.param.fightModelId
				},
				{},
				{},
				{},
				{}
			})
		else
			test_fight_manager:changeTestFightArray(var_25_1, {
				{
					servantid = self.param.fightModelInfo.servant,
					modelid = self.param.modelId
				},
				{},
				{},
				{},
				{}
			})
		end
	end)
end

function CostumeRoomShowLayer:initBuyLayout()
	local var_26_0 = TempWidget:CreateTempLayout(self._root)

	var_26_0:setContentSize(cc.size(GameDisplay.width, 100))
	var_26_0:align(cc.p(0, 0.5), 0, self.backBg:size().h / 2 + var_26_0:size().h)

	self.buyLayout = var_26_0

	local var_26_1 = TempWidget:CreateTempBtn(var_0_16 .. "bigImage.png", self._root)

	var_26_1:align(cc.p(1, 0.5), GameDisplay.width, var_26_0:getPositionY() + var_26_0:size().h / 2)
	var_26_1:hide()

	self.largerPictureBtn = var_26_1

	self:updateLargerPictureBtnVisible()

	local var_26_2 = TempWidget:CreateTempImg(var_0_16 .. "noget.png", var_26_0)

	var_26_2:align(cc.p(1, 0.5), var_26_0:size().w, var_26_0:size().h / 2)
	var_26_2:hide()

	self.noGetImg = var_26_2

	self:updateNoGetImg()
	var_26_2:move(GameDisplay.width + var_26_2:size().w, var_26_2:getPositionY())
	var_26_2:runAction(cc.MoveBy:create(0.1, cc.p(-var_26_2:size().w, 0)))
	var_26_0:move(GameDisplay.width, var_26_0:getPositionY())
	var_26_0:runAction(cc.MoveBy:create(0.1, cc.p(-var_26_0:size().w, 0)))

	if self.param.shopType then
		self.manager:getShopData(self.param.shopType)
	end

	local var_26_3 = TempWidget:CreateTempLayout(self._root)

	var_26_3:setContentSize(var_26_0:size())
	var_26_3:hide()
	var_26_3:align(cc.p(0, 0.5), 0, self.backBg:size().h / 2 + var_26_3:size().h)

	self._fightGirlGetLayout = var_26_3

	local var_26_5 = TempWidget:CreateTempBtn((playermodel.haveServant[self.param.fightModelInfo.servant] or nil) and var_0_16 .. "fight_girl_have_btn.png", var_26_3)

	var_26_5:setName("fightGirlGetBtn")
	var_26_5:align(cc.p(1, 0.5), var_26_3:size().w, var_26_3:size().h / 2)
	var_26_5:_addEvent(function()
		for iter_27_0, iter_27_1 in ipairs((Utility:parseDataByElement(item_data[servant_data[self.param.fightModelInfo.servant].itemid], {
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
			if tonumber(iter_27_1.roleJump) and Utility:isTimeRangeValid(iter_27_1.startTime, iter_27_1.endTime) or tonumber(iter_27_1.roleJump) and not iter_27_1.startTime and not iter_27_1.endTime then
				if not playermodel.haveServant[self.param.fightModelInfo.servant] then
					Utility:executeLayerJump({
						systemid = tonumber(iter_27_1.roleJump)
					})
				else
					global_ShowBlockWords("已拥有该学员")
				end

				return
			end
		end

		global_ShowBlockWords("暂时没有获取该学员的途径")
	end)
end

function CostumeRoomShowLayer:addSkinInteractionLayout()
	local var_28_0 = TempWidget:CreateTempLayout(self.showGirlLayout)

	var_28_0:setLocalZOrder(-1)
	var_28_0:setContentSize(self.showGirlLayout:size())

	local var_28_1 = cc.EventListenerTouchOneByOne:create()

	var_28_1:setSwallowTouches(false)
	var_28_1:registerScriptHandler(function(arg_29_0, arg_29_1)
		if self.param.haveNum >= 1 then
			return true
		end

		local var_29_0 = self.param.modelId

		if var_0_17[playermodel.playerid][self.param.modelId] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 and self.param.haveNum ~= 1 then
			if self.buyBtn then
				self.buyBtn.buyFunc()
			else
				global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)
			end

			return true
		elseif var_0_17[playermodel.playerid][var_29_0] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_17[playermodel.playerid][var_29_0] = var_0_17[playermodel.playerid][var_29_0] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_28_1:registerScriptHandler(function(arg_30_0, arg_30_1)
		return false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_28_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_28_1, var_28_0)
end

function CostumeRoomShowLayer:addMoveShowGirlLayout()
	if self.moveShowGirlLayout or not self.param.bgPath then
		return
	end

	local var_31_0 = self.showGirlLayout
	local var_31_1 = self.showGirlLayer
	local var_31_2 = self.showGirlLayer:getContentSize()
	local var_31_3 = TempWidget:CreateTempLayout(self.showGirlLayout)

	var_31_3:hide()
	var_31_3:setTouchEnabled(false)
	var_31_3:setContentSize(var_31_0:size())

	self.moveShowGirlLayout = var_31_3

	local var_31_4 = cc.EventListenerTouchAllAtOnce:create()

	var_31_4:registerScriptHandler(function(arg_32_0, arg_32_1)
		return true
	end, cc.Handler.EVENT_TOUCHES_BEGAN)
	var_31_4:registerScriptHandler(function(arg_33_0, arg_33_1)
		if #arg_33_0 == 1 then
			local var_33_0 = arg_33_0[1]:getLocation()
			local var_33_1 = arg_33_0[1]:getPreviousLocation()
			local var_33_2 = arg_33_0[1]:getStartLocation()
			local var_33_3 = var_31_1:getPositionX() - (var_33_1.x - var_33_0.x)
			local var_33_4 = var_31_1:getPositionY() - (var_33_1.y - var_33_0.y)

			if var_33_3 < -var_31_2.width / 2 then
				var_33_3 = -var_31_2.width / 2
			end

			if var_33_3 > var_31_2.width / 2 then
				var_33_3 = var_31_2.width / 2
			end

			if var_33_4 < -var_31_2.height / 2 + GameDisplay.fix_y then
				var_33_4 = -var_31_2.height / 2 + GameDisplay.fix_y
			end

			if var_33_4 > var_31_2.height / 2 + GameDisplay.fix_y then
				var_33_4 = var_31_2.height / 2 + GameDisplay.fix_y
			end

			var_31_1:setPosition(var_33_3, var_33_4)

			self.lastdis = 0

			if ((var_33_2.x - var_33_0.x)^2 + (var_33_2.y - var_33_0.y)^2)^0.5 > 12 then
				self.is_more_touch = true
			end
		elseif #arg_33_0 == 2 then
			local var_33_5 = arg_33_0[1]:getLocation()
			local var_33_6 = arg_33_0[2]:getLocation()
			local var_33_7 = arg_33_0[1]:getStartLocation()
			local var_33_8 = arg_33_0[2]:getStartLocation()

			self.scalerate = (((var_33_5.x - var_33_6.x)^2 + (var_33_5.y - var_33_6.y)^2)^0.5 - ((var_33_7.x - var_33_8.x)^2 + (var_33_7.y - var_33_8.y)^2)^0.5 - self.lastdis) / 550 + self.scalerate
			self.lastdis = ((var_33_5.x - var_33_6.x)^2 + (var_33_5.y - var_33_6.y)^2)^0.5 - ((var_33_7.x - var_33_8.x)^2 + (var_33_7.y - var_33_8.y)^2)^0.5

			if self.scalerate < self.min_scale then
				self.scalerate = self.min_scale
			end

			if self.scalerate > self.max_scale then
				self.scalerate = self.max_scale
			end

			self.showGirlLayout:setScale(self.scalerate)

			self.is_more_touch = true
		end
	end, cc.Handler.EVENT_TOUCHES_MOVED)
	var_31_4:registerScriptHandler(function(arg_34_0, arg_34_1)
		return
	end, cc.Handler.EVENT_TOUCHES_ENDED)
	var_31_3:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_31_4, var_31_3)
end

function CostumeRoomShowLayer:removeMoveShowGirlLayout()
	if self.moveShowGirlLayout then
		self.moveShowGirlLayout:removeFromParent()

		self.moveShowGirlLayout = nil
	end
end

function CostumeRoomShowLayer:initListener()
	self.touchLayout:_addEvent(function()
		return
	end)
	self.backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.screenshotSharingBtn:_addEvent(function()
		self:createShareLayout()
	end, {
		touchDelay = 1
	})
	self.locallyBtn:_addEvent(function()
		local function var_40_0(arg_41_0, arg_41_1)
			self._root:show()

			if arg_41_0 then
				if cc.Native.imageWriteToPhotosAlbum then
					if device_manager.platform == "android" then
						cc.Native:imageWriteToPhotosAlbum(arg_41_1, "CostumeSkin" .. os.date("%Y%m%d%H%M%S") .. ".png")
					else
						device_manager.imageWriteToPhotosAlbum(arg_41_1)
					end
				else
					print("没有" .. "cc.Native.imageWriteToPhotosAlbum")
				end

				global_ShowBlockWords("保存成功")
				cc.Director:getInstance():getTextureCache():removeTextureForKey(arg_41_1)

				local var_41_0 = TempWidget:CreateTempImg(arg_41_1, nil, 0)

				var_41_0:setName("capSp")
				var_41_0:setScale9Enabled(true)
				var_41_0:setCapInsets(cc.rect(0, 0, var_41_0:getContentSize().width, var_41_0:getContentSize().height))
				var_41_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
				self._root:addChild(var_41_0, 99)
				var_41_0:setPosition(GameDisplay.cx, GameDisplay.cy)

				local var_41_1 = {}

				table.insert(var_41_1, (cc.Spawn:create(cc.ScaleTo:create(0.2, 0.2), cc.MoveTo:create(0.2, cc.p(GameDisplay.width - var_41_0:getContentSize().width * 0.2 / 2 - 10, GameDisplay.height - var_41_0:getContentSize().height * 0.2 / 2 - 17)))))
				table.insert(var_41_1, (cc.DelayTime:create(0.2)))

				local var_41_2 = cc.MoveBy:create(2, cc.p(0, 10))

				table.insert(var_41_1, (cc.Spawn:create(cc.Repeat:create(cc.Sequence:create(var_41_2, (var_41_2:reverse())), 4), (cc.Sequence:create(cc.DelayTime:create(4 * 2 - 1), cc.FadeOut:create(1), (cc.CallFunc:create(function()
					self._root:removeChildByName("capSp")
				end)))))))
				var_41_0:runAction((cc.Sequence:create(var_41_1)))
				var_41_0:_addEvent(function()
					var_41_0:stopAllActions()
					var_41_0:setOpacity(255)
					var_41_0:runAction(cc.Spawn:create(cc.ScaleTo:create(0.2, 1), cc.MoveTo:create(0.2, cc.p(GameDisplay.cx, GameDisplay.cy))))
					var_41_0:_addEvent(function()
						var_41_0:hide()
					end)
				end)
			else
				print("Capture screen failed.")
			end
		end

		;(function(arg_45_0, arg_45_1)
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("cleanTouchEffect"))
			self._root:removeChildByName("capSp")
			self._root:hide()

			local var_45_0 = time_check_manager:getCurTime()

			cc.utils:captureScreen(var_40_0, cc.FileUtils:getInstance():getWritablePath() .. "Horcrux_Skin_CaptureScreen.png")
		end)()
	end, {
		touchDelay = 1.5
	})
	self.changeGirlBtn:_addEvent(function()
		if self._isShowFightModel then
			return
		end

		local var_46_0 = {
			var_0_16 .. "yige.png",
			var_0_16 .. "benge.png"
		}
		local var_46_1 = (self.changeGirlBtn.selectTag or 1) == 1 and 2 or 1

		self.changeGirlBtn.selectTag = (self.changeGirlBtn.selectTag or 1) == 1 and 2 or 1

		if self.showModel == tonumber(self.param.modelId) then
			self.showModel = tonumber(self.param.uncolorClothes)
		elseif self.showModel == tonumber(self.param.uncolorClothes) then
			self.showModel = tonumber(self.param.modelId)
		end

		self.changeGirlBtn:loadTextureNormal(var_46_0[var_46_1], var_0_15)

		if self.showGirlLayer then
			if self.showGirlLayer:getChildByName("roleimage") then
				self.showGirlLayer:getChildByName("roleimage")._talksp = nil
			end

			self.showGirlLayer:update(tostring(self.showModel))

			if self.showGirlLayer:getChildByName("roleimage") then
				self.showGirlLayer:getChildByName("roleimage")._talksp = nil
			end
		end

		local var_46_2 = require("controller.costume_room_manager"):getInstance()
		local var_46_3 = var_46_2:getAdaptiveFilterShowSkin()

		self.param = var_46_2:getParamByItemId(self.param.uncolorClothes_ItemId)
		self.param.uncolorClothes = self.param.modelId
		self.param.uncolorClothes_ItemId = self.param.itemId
		self.param.uncolorClothesHaveNum = self.param.haveNum

		self:updateTitle()
		self:updateShowGirlLayoutBg()
		self:updateNoGetImg()
		self:updateLargerPictureBtnVisible()
		self:updateSpine()
		self:updateBattleStandLayout()

		if self.param.shopType then
			self.manager:getShopData(self.param.shopType)
		end
	end)
	self.largerPictureBtn:_addEvent(function()
		self._root:hide()
		self.restoreScaleLayout:show()
		self:addMoveShowGirlLayout()
	end)
	self.restoreScaleLayout:_addEvent(function()
		self.restoreScaleLayout:hide()
		self:removeMoveShowGirlLayout()
		self.showGirlLayer:setPosition(cc.p(0, GameDisplay.fix_y))
		self._root:show()
	end)
end

function CostumeRoomShowLayer.updateLayer(arg_49_0)
	return
end

function CostumeRoomShowLayer:updateBuyLayout(arg_50_1)
	local var_50_0

	self.msgInfo = nil

	for iter_50_0, iter_50_1 in pairs(arg_50_1) do
		if iter_50_1.shopid == self.param.shopId then
			var_50_0 = iter_50_1
			self.msgInfo = iter_50_1

			break
		end
	end

	if not self.msgInfo then
		self.msgInfo = clone(self.param)
		self.msgInfo.buy_limit = self.msgInfo.buy_limit or 1
		self.msgInfo.have_bought = self.msgInfo.haveBoughtNum or 1
		self.msgInfo.buyLimitNum = self.msgInfo.buyLimitNum or 1
	end

	local function var_50_1(arg_51_0)
		local var_51_0 = arg_51_0 - time_check_manager:getCurTime()
		local var_51_1 = math.floor(var_51_0 / 86400)
		local var_51_2 = math.floor((var_51_0 - var_51_1 * 86400) / 3600)

		return "商品剩余时间：" .. (var_51_1 > 0 and var_51_1 .. "天" .. var_51_2 .. "小时" or var_51_2 .. "小时" .. math.floor((var_51_0 - var_51_1 * 86400 - var_51_2 * 3600) / 60) .. "分")
	end

	local function var_50_2()
		if self.param.priceTable and next(self.param.priceTable) and self.param.priceTable[1].bBuy then
			self.buyLayout:removeChildByName("buyBtn")

			local var_52_0 = self.param.priceTable[1]

			if self.param.priceTable[2] and self.param.priceTable[2].slideCost.nowHave >= self.param.priceTable[2].slideCost.costnum then
				var_52_0 = self.param.priceTable[2]
			end

			local var_52_1 = TempWidget:CreateTempBtn(var_0_16 .. "buy_btn.png", self.buyLayout)

			var_52_1:setName("buyBtn")
			var_52_1:align(cc.p(1, 0.5), self.buyLayout:size().w, self.buyLayout:size().h / 2)
			var_52_1:_addEvent(function()
				self:clickBuy(var_52_0)
			end)

			self.buyBtn = var_52_1

			function self.buyBtn.buyFunc()
				self:clickBuy(var_52_0)
			end

			local var_52_2 = TempWidget:CreateTempImg(var_52_0.costIconPath, var_52_1)

			var_52_2:align(cc.p(0, 0.5), 15, var_52_1:size().h / 2)

			local var_52_3 = TempWidget:CreateTempLayout(var_52_1)

			var_52_3:setContentSize(cc.size(50, var_52_1:size().h))
			var_52_3:align(cc.p(0, 0.5), var_52_2:getPositionX() + var_52_2:size().w + 5, var_52_1:size().h / 2)

			local var_52_4 = cc.DrawNode:create()

			var_52_3:addChild(var_52_4)
			var_52_4:setLocalZOrder(99)

			if var_52_0.bDiscount then
				local var_52_5 = TempWidget:CreateTempLabel(var_52_0.originalPrice, FONT_W5, 22)

				var_52_3:addChild(var_52_5)
				var_52_5:align(cc.p(0.5, 0.5), var_52_3:size().w / 2, var_52_3:size().h / 2 + 13)
				var_52_4:drawSegment(cc.p(var_52_5:getPositionX() - var_52_5:size().w / 2 - 5, var_52_5:getPositionY() + var_52_5:size().h / 2 - 5), cc.p(var_52_5:getPositionX() + var_52_5:size().w / 2 + 5, var_52_5:getPositionY() - var_52_5:size().h / 2 + 5), 2, cc.c4f(1, 0, 0, 1))

				local var_52_6 = TempWidget:CreateTempLabel(var_52_0.currentPrice, FONT_W5, 32)

				var_52_3:addChild(var_52_6)
				var_52_6:_setColor("#fff722")
				var_52_6:align(cc.p(0.5, 0.5), var_52_3:size().w / 2, var_52_3:size().h / 2 - 13)
			else
				local var_52_7 = TempWidget:CreateTempLabel(var_52_0.currentPrice, FONT_W5, 28)

				var_52_3:addChild(var_52_7)
				var_52_7:align(cc.p(0.5, 0.5), var_52_3:size().w / 2, var_52_3:size().h / 2)
			end
		end
	end

	local var_50_3 = var_0_18[self.param.itemId]()
	local var_50_4 = time_check_manager:getCurTime()

	if var_50_3 == 0 then
		if var_50_0 and (not var_50_0.sell_time or var_50_4 < global_get_time_by_date(var_50_0.sell_time)) then
			local costume_room_manager = require("controller.costume_room_manager")

			self.param.priceTable[1] = self.param.priceTable[1] or {}
			self.param.priceTable[1].currency = var_50_0.currency
			self.param.priceTable[1].haveNum = var_50_3
			self.param.priceTable[1].haveBoughtNum = var_50_0.have_bought
			self.param.priceTable[1].buyLimitNum = var_50_0.buy_limit
			self.param.priceTable[1].originalPrice = var_50_0.price
			self.param.priceTable[1].discountedPrice = var_50_0.discount
			self.param.priceTable[1].currentPrice = var_50_0.discount
			self.param.priceTable[1].startTime = var_50_0.start_time or self.param.priceTable[1].startTime
			self.param.priceTable[1].finishTime = var_50_0.finish_time or self.param.priceTable[1].finishTime

			if self.param.priceTable[1].startTime and self.param.priceTable[1].finishTime then
				local var_50_6 = global_get_time_by_date(self.param.priceTable[1].finishTime)

				if global_get_time_by_date(self.param.priceTable[1].startTime) <= var_50_4 and var_50_4 < var_50_6 then
					self.param.priceTable[1].bBuy = true
					self.param.priceTable[1].limitTimeStr = var_50_1(var_50_6)
				end
			elseif self.param.priceTable[1].startTime and not self.param.priceTable[1].finishTime then
				if var_50_4 >= global_get_time_by_date(self.param.priceTable[1].startTime) then
					self.param.priceTable[1].bBuy = true
				end
			elseif not self.param.priceTable[1].startTime and self.param.priceTable[1].finishTime then
				local var_50_7 = global_get_time_by_date(self.param.priceTable[1].finishTime)

				if var_50_4 < var_50_7 then
					self.param.priceTable[1].bBuy = true
					self.param.priceTable[1].limitTimeStr = var_50_1(var_50_7)
				end
			elseif not self.param.priceTable[1].startTime and not self.param.priceTable[1].finishTime then
				self.param.priceTable[1].bBuy = true
			end

			self.param.priceTable[1].costIconPath = costume_room_manager.CostIconPath[var_50_0.currency]
			self.param.priceTable[1].bDiscount = self.param.priceTable[1].originalPrice ~= self.param.priceTable[1].currentPrice
			self.param.priceTable[1].slideCost = {
				costnum = self.param.priceTable[1].currentPrice,
				costtype = self.param.priceTable[1].costIconPath,
				nowHave = var_0_18[self.param.priceTable[1].currency]()
			}

			if var_50_0.discount2 then
				self.param.priceTable[2] = self.param.priceTable[2] or {}
				self.param.priceTable[2].currency = var_50_0.currency2
				self.param.priceTable[2].haveBoughtNum = var_50_0.have_bought
				self.param.priceTable[2].buyLimitNum = var_50_0.buy_limit
				self.param.priceTable[2].originalPrice = var_50_0.price2
				self.param.priceTable[2].discountedPrice = var_50_0.discount2
				self.param.priceTable[2].currentPrice = var_50_0.discount2
				self.param.priceTable[2].startTime = self.param.priceTable[1].startTime
				self.param.priceTable[2].finishTime = self.param.priceTable[1].finishTime
				self.param.priceTable[2].bBuy = self.param.priceTable[1].bBuy
				self.param.priceTable[2].costIconPath = costume_room_manager.CostIconPath[var_50_0.currency2]
				self.param.priceTable[2].limitTimeStr = self.param.priceTable[1].limitTimeStr
				self.param.priceTable[2].bDiscount = self.param.priceTable[2].originalPrice ~= self.param.priceTable[2].currentPrice
				self.param.priceTable[2].slideCost = {
					costnum = self.param.priceTable[2].currentPrice,
					costtype = self.param.priceTable[2].costIconPath,
					nowHave = var_0_18[self.param.priceTable[2].currency]()
				}
			else
				self.param.priceTable[2] = nil
			end

			var_50_2()
		else
			if self.param.priceTable[1] then
				self.param.priceTable[1].slideCost = {
					costnum = self.param.priceTable[1].currentPrice,
					costtype = self.param.priceTable[1].costIconPath,
					nowHave = var_0_18[self.param.priceTable[1].currency]()
				}
			end

			if self.param.priceTable[2] then
				self.param.priceTable[2].slideCost = {
					costnum = self.param.priceTable[2].currentPrice,
					costtype = self.param.priceTable[2].costIconPath,
					nowHave = var_0_18[self.param.priceTable[2].currency]()
				}
			end

			var_50_2()
		end

		if not self.noGetImg then
			local var_50_8 = TempWidget:CreateTempImg(var_0_16 .. "noget.png", self.buyLayout)

			var_50_8:align(cc.p(1, 0.5), self.buyLayout:size().w, self.buyLayout:size().h / 2)
			var_50_8:hide()

			self.noGetImg = var_50_8

			if not next(self.param.priceTable) or not self.param.priceTable[1].bBuy then
				var_50_8:show()
			end

			var_50_8:move(GameDisplay.width + var_50_8:size().w, var_50_8:getPositionY())
			var_50_8:runAction(cc.MoveBy:create(0.1, cc.p(-var_50_8:size().w, 0)))
		end
	else
		self.param.priceTable = {}
		self.param.haveNum = var_50_3

		self.buyLayout:removeChildByName("buyBtn")
	end

	self:updateBuyLayoutVisible()
	self:updateNoGetImg()
	self:updateLargerPictureBtnVisible()
	self:updateSpine()
	self:updatestaticTouchCount()
end

function CostumeRoomShowLayer:clickBuy(arg_55_1)
	local var_55_0 = {
		ShopSliderCallback = function()
			self:sureBuy(arg_55_1)
		end,
		costIcon = arg_55_1.costIconPath,
		cost_old = arg_55_1.originalPrice,
		currency = arg_55_1.currency,
		have_bought_num = arg_55_1.haveBoughtNum
	}

	var_55_0.hideGainButton = true
	var_55_0.itemid = self.param.itemId
	var_55_0.limitNum = arg_55_1.buyLimitNum
	var_55_0.limit_buy_num = arg_55_1.limit_buy_num

	function var_55_0.shopcallback()
		return
	end

	var_55_0.shopid = self.param.shopId
	var_55_0.slidecost = arg_55_1.slideCost

	LayerManager:pushInLayer("PopGoodsLayer", var_55_0)
end

function CostumeRoomShowLayer:sureBuy(arg_58_1)
	if self.param.shopId and shop_data[self.param.shopId] then
		if shop_data[self.param.shopId].buy_need_item and var_0_18[shop_data[self.param.shopId].buy_need_item]() == 0 then
			global_ShowBlockWords("请先购买" .. ((item_data[shop_data[self.param.shopId].buy_need_item] and item_data[shop_data[self.param.shopId].buy_need_item].name or nil) and item_data[shop_data[self.param.shopId].buy_need_item].name))

			return
		end
	end

	if self.msgInfo.have_bought >= self.msgInfo.buy_limit then
		global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	if self.msgInfo.sell_time and time_check_manager:getCurTime() < global_get_time_by_date(self.msgInfo.sell_time) then
		global_ShowBlockWords(self.msgInfo.sell_time .. L_START_BUY)

		return
	end

	if arg_58_1.currentPrice > var_0_18[arg_58_1.currency]() then
		LayerManager:removePopLayer()
		self.dumpPopLayerFunc[arg_58_1.currency]()

		return
	end

	require("controller.shop_manager"):shop_buy(self.param.shopType, self.param.shopId, function(arg_59_0)
		if arg_59_0 == 1 then
			print("购买成功")
			self.manager:buySuccess(arg_59_0)
		end
	end, nil, function(arg_60_0)
		LayerManager:removePopLayer()
	end)
end

function CostumeRoomShowLayer:initPopLayerFunc()
	self.dumpPopLayerFunc = {
		function()
			({}).callback = function()
				return
			end

			LayerManager:removePopLayer()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = "gold",
				callback = function()
					return
				end
			})
		end,
		[0] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1,
				callback = function()
					return
				end
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[BLACK_CARD] = function()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = BLACK_CARD
			})
		end,
		[BLACK_SP_CARD] = function()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = BLACK_SP_CARD
			})
		end,
		[GIFT_TICKET] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer",
				callback = updateCoinLabel
			})
		end
	}

	setmetatable(self.dumpPopLayerFunc, {
		__index = function(arg_72_0, arg_72_1)
			return function(arg_73_0)
				if not item_data[arg_73_0].targetlayer1 then
					global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_72_1].name))

					return
				end

				if arg_73_0 then
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = arg_73_0
					})
				end

				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})
end

function CostumeRoomShowLayer:buySuccess(arg_74_1)
	if self.param.shopType then
		self.manager:getShopData(self.param.shopType)
	else
		local var_74_0 = self.noGetImg

		self.noGetImg:hide()

		if not next(self.param.priceTable) then
			var_74_0:show()
		end
	end
end

function CostumeRoomShowLayer:updateSkinNameText()
	if self._isShowFightModel then
		self.skinNameText:setString(self.param.fightModelInfo.name or "")
	else
		self.skinNameText:setString(self.param.name or "")
	end
end

function CostumeRoomShowLayer:updateRoleNameText()
	self.roleNameText:setString(self.param.roleEasyName or "")
end

function CostumeRoomShowLayer:updateCvText()
	self.cvText:setString(self.param.cvName or "")
end

function CostumeRoomShowLayer:updateTitle()
	self:updateSkinNameText()
	self:updateRoleNameText()
	self:updateCvText()
end

function CostumeRoomShowLayer:updateShowGirlLayoutBg()
	self.showGirlLayoutBg:loadTexture(self.param.bgPath)
	self.showGirlLayoutBg:hide()

	if self.param.bgPath then
		self.showGirlLayoutBg:show()
	end
end

function CostumeRoomShowLayer:updateLargerPictureBtnVisible()
	self.largerPictureBtn:hide()
end

function CostumeRoomShowLayer:updateBuyLayoutVisible()
	if self._isShowFightModel then
		self.buyLayout:hide()
		self._fightGirlGetLayout:show()
	else
		self._fightGirlGetLayout:hide()

		if self.param.haveNum > 0 then
			self.buyLayout:hide()
		else
			self.buyLayout:show()
		end
	end
end

function CostumeRoomShowLayer:updateNoGetImg()
	self.noGetImg:hide()

	if self.param and self.param.haveNum == 0 then
		if self.param.priceTable then
			self.noGetImg:show()

			for iter_82_0 = 1, #self.param.priceTable do
				if self.param.priceTable[iter_82_0].bBuy then
					self.noGetImg:hide()

					break
				end
			end
		else
			self.noGetImg:show()
		end
	end

	if self.noGetImg:isVisible() then
		local var_82_0 = "暂不可获得"

		self.noGetImg:removeAllChildren()

		if self.param.targetlayer1 then
			local var_82_1 = time_check_manager:getCurTime()
			local var_82_2 = false

			if self.param.targetlayer_starttime_1 and self.param.targetlayer_finishtime_1 then
				if var_82_1 >= global_get_time_by_date(self.param.targetlayer_starttime_1) and var_82_1 < global_get_time_by_date(self.param.targetlayer_finishtime_1) then
					var_82_2 = true
				end
			elseif self.param.targetlayer_starttime_1 and not self.param.targetlayer_finishtime_1 then
				if var_82_1 >= global_get_time_by_date(self.param.targetlayer_starttime_1) then
					var_82_2 = true
				end
			elseif not self.param.targetlayer_starttime_1 and self.param.targetlayer_finishtime_1 then
				if var_82_1 < global_get_time_by_date(self.param.targetlayer_finishtime_1) then
					var_82_2 = true
				end
			elseif not self.param.targetlayer_starttime_1 and not self.param.targetlayer_finishtime_1 then
				var_82_2 = true
			end

			if var_82_2 then
				var_82_0 = self.param.targetdes1

				self.noGetImg:setTouchEnabled(true)
				self.noGetImg:loadTextureEx(var_0_16 .. "noget1.png")
				self.noGetImg:_addEvent(function()
					if self.param.targetactivity1 then
						if activity_manager:getCurrentActivites()[tonumber(self.param.targetactivity1)] then
							goto_complete_system({
								jump_to_system = tonumber(self.param.targetlayer1)
							})
						else
							global_ShowBlockWords("活动已结束")
						end
					else
						goto_complete_system({
							jump_to_system = tonumber(self.param.targetlayer1)
						})
					end
				end)
				TempWidget:CreateTempLabel(var_82_0, FONT_NAME, 24, self.noGetImg):align(cc.p(1, 0.5), self.noGetImg:size().w - 55, self.noGetImg:size().h / 2)
				TempWidget:CreateTempImg(var_0_16 .. "noget_son.png", self.noGetImg):align(cc.p(1, 0.5), self.noGetImg:size().w - 15, self.noGetImg:size().h / 2)
			else
				self.noGetImg:setTouchEnabled(false)
				self.noGetImg:loadTextureEx(var_0_16 .. "noget.png")
				TempWidget:CreateTempLabel(var_82_0, FONT_NAME, 24, self.noGetImg):align(cc.p(1, 0.5), self.noGetImg:size().w - 20, self.noGetImg:size().h / 2)
			end
		else
			self.noGetImg:setTouchEnabled(false)
			self.noGetImg:loadTextureEx(var_0_16 .. "noget.png")
			TempWidget:CreateTempLabel(var_82_0, FONT_NAME, 24, self.noGetImg):align(cc.p(1, 0.5), self.noGetImg:size().w - 20, self.noGetImg:size().h / 2)
		end
	end
end

function CostumeRoomShowLayer:updatestaticTouchCount()
	local var_84_0 = self.param.modelId

	if not var_0_17[playermodel.playerid] then
		var_0_17[playermodel.playerid] = {}
		var_0_17[playermodel.playerid][var_84_0] = var_0_17[playermodel.playerid][var_84_0] or 0
	else
		var_0_17[playermodel.playerid][var_84_0] = var_0_17[playermodel.playerid][var_84_0] or 0
	end

	self.showGirlLayer:setTalkEnabled(self.param.haveNum > 0 or var_0_17[playermodel.playerid][var_84_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showGirlLayer:setTouchTalkCallback(function()
		var_0_17[playermodel.playerid][var_84_0] = var_0_17[playermodel.playerid][var_84_0] + 1

		self.showGirlLayer:setTalkEnabled(self.param.haveNum > 0 or var_0_17[playermodel.playerid][var_84_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
end

function CostumeRoomShowLayer:updateSpine()
	self.qKuangImg:removeAllChildren()
	self.qKuangImg:_addEvent(function()
		return
	end)

	local var_86_0
	local var_86_1

	if self._isShowFightModel then
		var_86_0 = model_data[self.param.fightModelId].spine_model
		var_86_1 = model_data[self.param.fightModelId].clothes_model
	else
		var_86_0 = self.param.spineModel
		var_86_1 = self.param.clothesModel
	end

	if var_86_0 then
		local var_86_3 = L2Actor:create(ROLE_SPINE_PATH .. var_86_0 .. ".json", ROLE_SPINE_PATH .. var_86_0 .. ".atlas", (var_86_1 or nil) and (CLOTHES_SPINE_PATH .. var_86_1 .. ".atlas" or nil))

		if self._isShowFightModel then
			var_86_3:setScale(self.param.spineScale * 0.27, self.param.spineScale * 0.27)
		else
			var_86_3:setScale(self.param.spineScale * 0.35, self.param.spineScale * 0.35)
		end

		var_86_3:setPosition(cc.p(self.qKuangImg:getContentSize().width / 2, self.qKuangImg:getContentSize().height / 2 - 80))
		self.qKuangImg:addChild(var_86_3, 99)
		var_86_3:playAni(nil, "idle", true)
		self.qKuangImg:_addEvent(function()
			local var_88_0 = math.random(2, 5)

			local function var_88_1()
				var_86_3:playAni(nil, "idle", true)
			end

			if var_88_0 == 2 then
				var_86_3:playAni(var_88_1, "run", false)
			elseif var_88_0 == 3 then
				var_86_3:playAni(var_88_1, "yule", false)
			elseif var_88_0 == 4 then
				var_86_3:playAni(var_88_1, "chihe", false)
			else
				var_86_3:playAni(var_88_1, "fadai", false)
			end
		end)
	end
end

function CostumeRoomShowLayer:initShowGirlShareLayout()
	self.showGirlShareLayout:hide()

	local var_90_0

	self.showGirlShareLayout:registerScriptHandler(function(arg_91_0)
		if arg_91_0 == "exit" then
			var_90_0:release()
			cc.Director:getInstance():getTextureCache():removeUnusedTextures()
		end
	end)

	local var_90_1 = TempWidget:CreateTempImg(var_0_16 .. "title.png", self.showGirlShareLayout)

	var_90_1:align(cc.p(0, 0), 0, 100)

	local var_90_2 = TempWidget:CreateTempLabel(self.param.cvName or "", FONT_W5, 19.25)

	var_90_1:addChild(var_90_2)
	var_90_2:align(cc.p(1, 1), var_90_1:size().w - 10, var_90_1:size().h)

	local var_90_3 = TempWidget:CreateTempLabel(self.param.name or "", FONT_W5, 26)

	var_90_3:_setColor("#222222")
	var_90_3:setName("skinNameText")
	var_90_1:addChild(var_90_3)
	var_90_3:align(cc.p(0.5, 0), var_90_1:size().w / 2 - 5, 45)

	self.showGirlShareLayout._skinNameText = var_90_3

	local var_90_4 = TempWidget:CreateTempImg(var_0_16 .. "qr_code_bg.png", self.showGirlShareLayout)

	var_90_4:align(cc.p(1, 1), self.showGirlShareLayout:size().w - 20, self.showGirlShareLayout:size().h - 70)
	var_90_4:hide()

	if cc.QRSprite and cc.QRSprite.create then
		var_90_4:addChild((cc.QRSprite:create("https://www.h-college.com/index/", 1)))
	end

	local var_90_5 = self.showGirlShareLayout:getContentSize()
	local var_90_8 = TempWidget:CreateTempLabel(self.param.roleEasyName or "", FONT_NAME, 38)
	local var_90_9 = var_90_5.width - var_90_8:size().w
	local var_90_10 = var_90_5.height - var_90_8:size().h

	var_90_8:setPosition(cc.p(self.showGirlShareLayout:size().w / 2 - var_90_9 / 2, self.showGirlShareLayout:size().h / 2 - var_90_10 / 2))

	var_90_0 = cc.RenderTexture:create(var_90_5.width - var_90_9, var_90_5.height - var_90_10, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)

	var_90_0:setVisible(false)
	var_90_0:retain()
	var_90_0:setPosition(cc.p(self.showGirlShareLayout:size().w / 2, self.showGirlShareLayout:size().h / 2))
	var_90_1:addChild(var_90_0)
	var_90_0:begin()
	var_90_8:visit()
	var_90_0:endToLua()

	local var_90_11 = string.format("skin_share_img.png", 0)

	performWithDelay(self.showGirlShareLayout, function()
		local var_92_0 = var_90_0:newImage()

		cc.Director:getInstance():getTextureCache():removeTextureForKey(var_90_11)
		var_92_0:release()

		local var_92_1 = cc.Sprite:createWithTexture((cc.Director:getInstance():getTextureCache():addImage(var_92_0, var_90_11)))

		var_92_1:setAnchorPoint(0.5, 0)
		var_92_1:setPosition(var_90_1:size().w / 2 - 10, 0)

		local var_92_2 = cc.ClippingNode:create()

		var_92_2:setInverted(false)
		var_92_2:setAlphaThreshold(0.5)
		var_92_2:setStencil(var_92_1)

		local var_92_3 = TempWidget:CreateTempImg(var_0_16 .. "name_bg.png")

		var_92_3:setScale(var_90_1:size().w / var_92_3:size().w, var_92_1:getContentSize().height / var_92_3:size().h)
		var_92_2:setContentSize(var_92_3:size())
		var_92_2:addChild(var_92_3)
		var_92_3:align(cc.p(0, 0), 0, 0)
		var_90_1:addChild(var_92_2)
		var_92_2:setPosition(0, var_90_1:size().h + 5)
	end, 0)
	TempWidget:CreateTempImg(var_0_16 .. "yellow_rect.png", var_90_1):align(cc.p(0, 0), 0, var_90_1:size().h + 10)
end

function CostumeRoomShowLayer:updateShowGirlShareLayout()
	if self._isShowFightModel then
		self.showGirlShareLayout._skinNameText:setString(self.param.fightModelInfo.name)
	else
		self.showGirlShareLayout._skinNameText:setString(self.param.name or "")
	end
end

function CostumeRoomShowLayer:createShareLayout()
	self._root:removeChildByName("ShareLayout")

	local function var_94_0(arg_95_0, arg_95_1)
		self._root:show()

		if arg_95_0 then
			self.showGirlShareLayout:hide()

			local var_95_0 = TempWidget:CreateTempLayout(self._root)

			var_95_0:setContentSize(self._root:size())
			var_95_0:setLocalZOrder(99)
			var_95_0:setName("ShareLayout")
			var_95_0:_setBack()
			var_95_0:setBackGroundColor(cc.c3b(0, 0, 0))
			var_95_0:setOpacity(150)
			var_95_0:_addEvent(function(arg_96_0)
				arg_96_0:hide()
			end)

			local var_95_1 = TempWidget:CreateTempLayout(var_95_0)

			var_95_1:setCascadeOpacityEnabled(false)
			var_95_1:setContentSize(self._root:size())
			var_95_1:setLocalZOrder(99)
			var_95_1:setName("ShareLayout")
			var_95_1:_setBack()
			var_95_1:setBackGroundColor(cc.c3b(255, 255, 255))
			var_95_1:align(cc.p(0.5, 0.5), var_95_0:size().w / 2, var_95_0:size().h / 2)
			var_95_1:_addEvent(function(arg_97_0)
				return
			end)
			cc.Director:getInstance():getTextureCache():removeTextureForKey(arg_95_1)

			local var_95_2 = TempWidget:CreateTempImg(arg_95_1, var_95_1, 0)

			var_95_2:setScale9Enabled(true)
			var_95_2:setCapInsets(cc.rect(0, 0, var_95_2:getContentSize().width, var_95_2:getContentSize().height))
			var_95_2:setContentSize(var_95_1:size())
			var_95_2:setScale(0.92)
			var_95_2:align(cc.p(0.5, 1), var_95_1:size().w / 2, var_95_1:size().h - 30)
			var_95_1:runAction(cc.ScaleTo:create(0.2, 0.88))

			local var_95_3 = TempWidget:CreateTempLayout(var_95_1)

			var_95_3:setBackGroundColorOpacity(50)
			var_95_3:setContentSize(cc.size(var_95_1:size().w, var_95_1:size().h * (1 - 0.92) - 30))

			local var_95_4 = self.manager:getShareRewardInfo()

			if next(var_95_4) then
				local var_95_5 = TempWidget:CreateTempLayout(var_95_3)

				var_95_5:setContentSize(cc.size(180, var_95_3:size().h))

				local var_95_6 = TempWidget:CreateTempImg(var_95_4.iconPath, var_95_5)

				var_95_6:move(var_95_5:size().w / 2 - 25, var_95_5:size().h / 2 + 15)

				local var_95_7 = TempWidget:CreateTempLabel(var_95_4.num or 0, FONT_NAME, 23, var_95_5)

				var_95_7:align(cc.p(0, 0.5), var_95_6:getPositionX() + var_95_6:size().w / 2, var_95_6:getPositionY())
				var_95_7:_setColor("#1c073b")

				local var_95_8 = TempWidget:CreateTempLabel("每周首次分享", FONT_NAME, 23, var_95_5)

				var_95_8:move(var_95_5:size().w / 2, var_95_5:size().h / 2 - 18)
				var_95_8:_setColor("#1c073b")
			end

			local var_95_9 = TempWidget:CreateTempLayout(var_95_3)

			var_95_9:setContentSize(cc.size(var_95_3:size().w - 150, var_95_3:size().h))
			var_95_9:align(cc.p(1, 0), var_95_3:size().w, 0)

			local var_95_10 = {
				{
					shareType = 3,
					path = var_0_16 .. "weibo.png"
				},
				{
					shareType = 2,
					path = var_0_16 .. "qq.png"
				},
				{
					shareType = 1,
					path = var_0_16 .. "wx_circle.png"
				},
				{
					shareType = 0,
					path = var_0_16 .. "wx_friend.png"
				}
			}
			local var_95_11 = {}

			for iter_95_0, iter_95_1 in pairs((share_manager:getShareChannelArr())) do
				if iter_95_0 == "weixinfriend" and iter_95_1 or iter_95_1 == "weixinfriend" then
					table.insert(var_95_11, var_95_10[4])
				elseif iter_95_0 == "weixingroup" and iter_95_1 or iter_95_1 == "weixingroup" then
					table.insert(var_95_11, var_95_10[3])
				elseif iter_95_0 == "qqfriend" and iter_95_1 or iter_95_1 == "qqfriend" then
					table.insert(var_95_11, var_95_10[2])
				elseif iter_95_0 == "weibo" and iter_95_1 or iter_95_1 == "weibo" then
					table.insert(var_95_11, var_95_10[1])
				end
			end

			for iter_95_2 = 1, #var_95_11 do
				local var_95_12 = TempWidget:CreateTempBtn(var_95_11[iter_95_2].path, var_95_9)

				var_95_12:_addEvent(function()
					var_95_12:setTouchEnabled(false)
					performWithDelay(var_95_12, function()
						var_95_12:setTouchEnabled(true)
					end, 2)

					if not share_manager:can_share() then
						return
					end

					share_manager:registerShareHandler(function(arg_100_0)
						if arg_100_0 == 0 then
							global_ShowBlockWords("分享成功")
							self.manager:shareSuccess()
						end
					end)
					share_manager:doChannelShare(var_95_11[iter_95_2].shareType, "养肝护肾，为AI发电！", arg_95_1, "快加入魂器学院吧")
				end)
				var_95_12:setScale(0.9)
				var_95_12:align(cc.p(1, 0.5), var_95_9:size().w - 50 - (4 - iter_95_2) * (var_95_12:size().w + 10), var_95_9:size().h / 2)
			end
		else
			print("Capture screen failed.")
		end
	end

	;(function(arg_101_0, arg_101_1)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("cleanTouchEffect"))
		self:updateShowGirlShareLayout()
		self._root:hide()
		self.showGirlShareLayout:show()

		local var_101_0 = time_check_manager:getCurTime()

		cc.utils:captureScreen(var_94_0, cc.FileUtils:getInstance():getWritablePath() .. "Horcrux_Skin_CaptureScreen_Share.png")
	end)()
end

function CostumeRoomShowLayer:updateTypeImgVisible()
	if self.param.bLive2d or self.param.bRoleSpine then
		if self._isShowFightModel then
			self.typeImg:hide()
		else
			self.typeImg:show()
		end
	else
		self.typeImg:hide()
	end
end

return CostumeRoomShowLayer
