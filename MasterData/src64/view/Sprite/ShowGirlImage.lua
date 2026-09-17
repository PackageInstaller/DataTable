local ShowGirlImage = class("ShowGirlImage", function()
	return ccui.ImageView:create()
end)
local model_data = require("data.model_data")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local conversation_type_data = require("data.conversation_type_data")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_8 = 1000
local var_0_9 = 1001
local var_0_10 = 1002
local var_0_11 = 5
local var_0_12 = 2
local var_0_13 = 1
local var_0_14
local var_0_19 = 5

local function var_0_20(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:match("([^,]+),(.+)")

	return tonumber(var_2_0), tonumber(var_2_1)
end

function ShowGirlImage:create(arg_3_1, arg_3_2)
	local var_3_0 = ShowGirlImage.new()

	var_3_0:init(arg_3_1, arg_3_2)

	return var_3_0
end

function ShowGirlImage:init(arg_4_1, arg_4_2)
	self.isActive = true
	self._modelid = arg_4_1
	self._showtype = arg_4_2

	self:loadTexture(ROLE_IMAGE_PATH .. model_data[arg_4_1].role_image .. ".png")
	self:setScale(model_data[arg_4_1].mainlayer_scale or 1)

	self.face = ccui.ImageView:create("expression/" .. model_data[arg_4_1].expression .. ".png")

	self.face:setAnchorPoint(cc.p(0.5, 0))
	self.face:setPosition(cc.p(self:getContentSize().width / 2, 0))
	self:addChild(self.face)
	self:startAction()
	self:registerCustomEvent()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			self.isActive = false

			if self._talksp then
				self._talksp:runAction(cc.RemoveSelf:create())

				self._talksp = nil
			end
		end
	end)
end

function ShowGirlImage:reset(arg_6_1)
	if arg_6_1 == self._modelid then
		return
	end

	self._modelid = arg_6_1

	self:loadTexture(ROLE_IMAGE_PATH .. model_data[arg_6_1].role_image .. ".png")
	self:setScale(model_data[arg_6_1].mainlayer_scale or 1)
	self.face:loadTexture("expression/" .. model_data[arg_6_1].expression .. ".png")
	self.face:setPosition(cc.p(self:getContentSize().width / 2, 0))
	self.face:setVisible(true)

	self._talktime = 0
	self._angrytime = 0
	self._istalking = false
	self._broken = false

	self:getTalkSP():setVisible(false)

	var_0_13 = 1
	var_0_14 = nil
end

function ShowGirlImage:setRolePosition(arg_7_1)
	self:setPosition(arg_7_1)

	if self._loadingani then
		self._loadingani:setPosition(cc.p(GameDisplay.cx - arg_7_1.x, GameDisplay.cy - arg_7_1.y))
	end
end

function ShowGirlImage:onDownloadProcessing()
	if self._loadingani then
		self._loadingani:setVisible(true)
		self._loadingani:play()

		return
	end

	self._loadingani = require("view.Sprite.LoadingSprite"):create()

	self._loadingani:setPosition(cc.p(GameDisplay.cx - self:getPositionX(), GameDisplay.cy - self:getPositionY()))
	self:addChild(self._loadingani)
end

function ShowGirlImage:afterLoadSuccess(arg_9_1)
	if arg_9_1 ~= ROLE_IMAGE_PATH .. model_data[self._modelid].role_image .. ".png" then
		return
	end

	if self._loadingani then
		self._loadingani:stop()
		self._loadingani:setVisible(false)
	end

	if model_data[self._modelid].is_big_role_image then
		local var_9_0 = GameDisplay.width / 2
		local var_9_1 = GameDisplay.cy - self:getContentSize().height / 2 - GameDisplay.fix_y

		if model_data[self._modelid].big_role_image_offset_x then
			var_9_0 = var_9_0 + model_data[self._modelid].big_role_image_offset_x
		end

		if model_data[self._modelid].big_role_image_offset_y then
			var_9_1 = var_9_1 + model_data[self._modelid].big_role_image_offset_y
		end

		self:setPositionX(var_9_0)
		self:setPositionY(var_9_1)
	end

	if self.face then
		self.face:setPosition(cc.p(self:getContentSize().width / 2, 0))
	end
end

function ShowGirlImage:resetCurTalkConfig()
	var_0_13 = 1
	var_0_14 = nil
end

function ShowGirlImage:startAction()
	if model_data[self._modelid].is_big_role_image then
		return
	end

	local var_11_0 = cc.RepeatForever:create(cc.Sequence:create(cc.EaseInOut:create(cc.Spawn:create(cc.MoveBy:create(2, cc.p(0, 6)), cc.ScaleBy:create(2, 1.007)), 2), cc.EaseInOut:create(cc.Spawn:create(cc.MoveBy:create(2, cc.p(0, -6)), cc.ScaleBy:create(2, 0.99304865938431)), 2)))

	var_11_0:setTag(var_0_8)
	self:runAction(var_11_0)
end

function ShowGirlImage:registerCustomEvent()
	self._talktime = 0
	self._angrytime = 0
	self._broken = false
	self._istalking = false

	self:setTouchEnabled(true)
	self:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._istalking then
			return
		end

		self:shock()

		if not self._broken and self._angrytime >= var_0_12 then
			self:showBroken()
		end

		self:showRoleTalk()

		if self.touchTalkCallback then
			self.touchTalkCallback()
		end
	end)
end

function ShowGirlImage:shock()
	self:runAction(cc.Sequence:create(cc.MoveBy:create(0.06, cc.p(0, 6)), cc.MoveBy:create(0.06 * 2, cc.p(0, -6 * 2)), cc.MoveBy:create(0, cc.p(0, 6))))
end

function ShowGirlImage:showBroken()
	self:loadTexture(ROLE_IMAGE_PATH .. model_data[self._modelid].broken_role .. ".png")
	self.face:setVisible(false)

	self._broken = true
end

function ShowGirlImage:showNormal()
	self:loadTexture(ROLE_IMAGE_PATH .. model_data[self._modelid].role_image .. ".png")
	self.face:setVisible(true)

	self._broken = false
end

function ShowGirlImage:insertTalk(arg_17_1)
	self:showRoleTalk(arg_17_1)
end

function ShowGirlImage:showRoleTalk(arg_18_1)
	if arg_18_1 then
		self.isInsertTalk = arg_18_1
		self._talktime = 0
		self._angrytime = 0
		var_0_13 = 1
		var_0_14 = nil

		if self:genRoleTalk(arg_18_1) then
			self.isInsertTalk = nil
		end
	elseif self.isInsertTalk then
		if self:genRoleTalk(self.isInsertTalk) then
			self.isInsertTalk = nil
		end
	else
		if self._talktime >= var_0_11 then
			self._angrytime = self._angrytime + 1

			self:genRoleTalk(ROLE_SOUND_TYPE.angry)
			LayerManager:shake_screen(2, 5)
			self:stopActionByTag(var_0_10)
		elseif self:genRoleTalk(ROLE_SOUND_TYPE.random) then
			self._talktime = self._talktime + 1
		end

		self:stopActionByTag(var_0_9)
	end
end

function ShowGirlImage:genRoleTalk(arg_19_1)
	if arg_19_1 == ROLE_CONVERSATION_TYPE.mainTouch then
		if var_0_13 == 1 then
			var_0_14 = GenerateRoleConversationClass(self._modelid, arg_19_1)
		end
	else
		var_0_14 = GenerateRoleConversationClass(self._modelid, arg_19_1)
	end

	if not var_0_14 then
		return
	end

	if not role_conversation_data[var_0_14 * 100 + 1] then
		var_0_14 = GenerateRoleConversationClass(self._modelid, ROLE_SOUND_TYPE.random)

		local var_19_0 = 0

		while role_conversation_data[var_0_14 * 100 + var_19_0 + 1] do
			var_19_0 = var_19_0 + 1
		end

		if var_19_0 < var_0_13 then
			var_0_13 = 1
		end

		self:playRoleTalk(var_0_14)

		return false
	end

	local var_19_1 = 0

	while role_conversation_data[var_0_14 * 100 + var_19_1 + 1] do
		var_19_1 = var_19_1 + 1
	end

	if var_19_1 < var_0_13 then
		var_0_13 = 1
	end

	self:playRoleTalk(var_0_14)

	var_0_13 = var_0_13 + 1

	if var_19_1 < var_0_13 then
		var_0_13 = 1
	end

	return var_19_1 < var_0_13
end

function ShowGirlImage:playRoleTalk(arg_20_1)
	local var_20_0 = role_conversation_data[arg_20_1 * 100 + var_0_13].dec
	local var_20_1 = role_conversation_data[arg_20_1 * 100 + var_0_13].expression

	self._istalking = true

	local var_20_2 = self._modelid

	if role_conversation_data[arg_20_1 * 100 + var_0_13].dec then
		local var_20_3 = self:getTalkSP()

		var_20_3:getChildByName("talklabel"):setString(role_conversation_data[arg_20_1 * 100 + var_0_13].dec)

		local var_20_4 = var_20_3:getChildByName("talklabel"):getContentSize().width + 100
		local var_20_5 = var_20_3:getChildByName("talklabel"):getContentSize().height + 70

		var_20_4 = var_20_4 < 348 and 348 or var_20_4
		var_20_5 = var_20_5 < 132 and 132 or var_20_5

		var_20_3:setPreferredSize(cc.size(var_20_4, var_20_5))
		var_20_3:getChildByName("talklabel"):setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 20))

		if self._showtype == var_0_19 then
			local var_20_7, var_20_8 = var_0_20(model_data[self._modelid].database_talk_pos_offset or model_data[self._modelid].talk_pos_offset or "0,0")

			var_20_3:setPosition(cc.p(320 + var_20_7, 568 + var_20_8))
		elseif model_data[self._modelid].talk_pos_offset then
			local var_20_9, var_20_10 = var_0_20(model_data[self._modelid].talk_pos_offset)

			var_20_3:setPosition(cc.p(self:getPositionX() + 50 + var_20_9, 600 + var_20_10))
		end

		var_20_3:setVisible(true)
	end

	if role_conversation_data[arg_20_1 * 100 + var_0_13].expression then
		self.face:loadTexture("expression/" .. model_data[self._modelid][role_conversation_data[arg_20_1 * 100 + var_0_13].expression] .. ".png")
	end

	if role_conversation_data[arg_20_1 * 100 + var_0_13].sound then
		audio_manager:stopAllRoleSound()

		audio_manager.playingplayersound = false
	end

	local var_20_11 = role_conversation_data[arg_20_1 * 100 + var_0_13].sound and audio_manager:isPlayerSoundValid()

	local function var_20_12()
		if var_20_11 then
			audio_manager.playingplayersound = false
		end

		if not self then
			return
		end

		if not self.isActive then
			return
		end

		if var_20_2 ~= self._modelid then
			return
		end

		if var_20_0 then
			self:getTalkSP():setVisible(false)
		end

		if var_20_1 then
			self.face:loadTexture("expression/" .. model_data[var_20_2].expression .. ".png")
		end

		if self._talktime >= var_0_11 then
			self:stopActionByTag(var_0_10)

			local var_21_0 = cc.Sequence:create(cc.DelayTime:create(10), cc.CallFunc:create(function()
				self._angrytime = 0
				self._talktime = 0

				if self._broken then
					self:showNormal()
				end
			end))

			var_21_0:setTag(var_0_10)
			self:runAction(var_21_0)
		else
			self:stopActionByTag(var_0_9)

			local var_21_1 = cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(function()
				self._talktime = 0
			end))

			var_21_1:setTag(var_0_9)
			self:runAction(var_21_1)
		end

		self._istalking = false
	end

	if var_20_11 then
		audio_manager.playingplayersound = true

		audio_manager:playPlayerSound("sound/role_voice/" .. role_conversation_data[arg_20_1 * 100 + var_0_13].sound, nil, role_conversation_data[arg_20_1 * 100 + var_0_13].sound_volume, var_20_12)
	else
		self:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(var_20_12)))
	end
end

function ShowGirlImage:getTalkSP()
	if not self._talksp then
		local var_24_0 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_24_0:setMaxLineWidth(357)
		var_24_0:setString(dec)
		var_24_0:setAnchorPoint(cc.p(0, 0.5))
		var_24_0:setColor(cc.c3b(71, 75, 86))
		var_24_0:setName("talklabel")

		if config._DEBUG then
			self._talksp = cc.Scale9Sprite:create("public/talk/word_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/talk/word_bg.png")
		end

		self._talksp:setCapInsets(cc.rect(100, 50, 200, 20))
		self._talksp:setPreferredSize(cc.size(var_24_0:getContentSize().width + 40, var_24_0:getContentSize().height + 37))
		var_24_0:setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 24))
		self._talksp:addChild(var_24_0, 3)
		LayerManager:getCurrentLayerObj():addChild(self._talksp, 100)
		self._talksp:setVisible(false)
		self._talksp:registerScriptHandler(function(arg_25_0)
			if arg_25_0 == "exit" then
				self._talksp = nil
			end
		end)
	end

	return self._talksp
end

function ShowGirlImage:setTouchTalkCallback(arg_26_1)
	self.touchTalkCallback = arg_26_1
end

function ShowGirlImage:playTalkCallBack()
	if self.talkFinishCallback then
		self.talkFinishCallback()
	end
end

function ShowGirlImage:setSwallowTouches(arg_28_1)
	self:setTouchEnabled(arg_28_1)
end

return ShowGirlImage
