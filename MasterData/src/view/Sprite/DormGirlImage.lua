local ShowGirlSpine = require("view.Sprite.ShowGirlSpine")
local ShowGirlImage = require("view.Sprite.ShowGirlImage")
local DormGirlImage = class("DormGirlImage", function(arg_1_0)
	return ShowGirlImage:create(arg_1_0)
end)
local model_data = require("data.model_data")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local conversation_type_data = require("data.conversation_type_data")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_11 = 1001
local var_0_12 = 1002
local var_0_13 = 5
local var_0_15 = 1
local var_0_16

local function var_0_17(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:match("([^,]+),(.+)")

	return tonumber(var_2_0), tonumber(var_2_1)
end

function DormGirlImage:create(arg_3_1)
	var_0_15 = 1
	var_0_16 = nil

	return (DormGirlImage.new(arg_3_1))
end

function DormGirlImage:insertTalk(arg_4_1)
	self:showRoleTalk(arg_4_1)
end

function DormGirlImage:showRoleTalk(arg_5_1)
	if arg_5_1 then
		self.isInsertTalk = arg_5_1
		self._talktime = 0
		self._angrytime = 0
		var_0_15 = 1
		var_0_16 = nil

		if self:genRoleTalk(arg_5_1) then
			self.isInsertTalk = nil
		end
	elseif self.isInsertTalk then
		if self:genRoleTalk(self.isInsertTalk) then
			self.isInsertTalk = nil
		end
	else
		if self._talktime >= var_0_13 then
			self._angrytime = self._angrytime + 1

			self:genRoleTalk(ROLE_CONVERSATION_TYPE.angry)

			if LayerManager:getCurrentLayerName() == "DormRoomLayer" then
				LayerManager:getCurrentLayerObj():shake_screen(2, 5)
			end

			self:stopActionByTag(var_0_12)
		elseif self:genRoleTalk(ROLE_CONVERSATION_TYPE.dormTouch) then
			self._talktime = self._talktime + 1
		end

		self:stopActionByTag(var_0_11)
	end
end

function DormGirlImage:genRoleTalk(arg_6_1)
	if var_0_15 == 1 then
		var_0_16 = GenerateRoleConversationClass(self._modelid, arg_6_1)
	end

	if not var_0_16 then
		return
	end

	if not role_conversation_data[var_0_16 * 100 + 1] then
		return false
	end

	local var_6_0 = 0

	while role_conversation_data[var_0_16 * 100 + var_6_0 + 1] do
		var_6_0 = var_6_0 + 1
	end

	if var_6_0 < var_0_15 then
		var_0_15 = 1
	end

	self:playRoleTalk(var_0_16)

	var_0_15 = var_0_15 + 1

	if var_6_0 < var_0_15 then
		var_0_15 = 1
	end

	return var_6_0 < var_0_15
end

function DormGirlImage:playRoleTalk(arg_7_1)
	local var_7_0 = role_conversation_data[arg_7_1 * 100 + var_0_15].dec
	local var_7_1 = role_conversation_data[arg_7_1 * 100 + var_0_15].expression

	self._istalking = true

	local var_7_2 = self._modelid

	if role_conversation_data[arg_7_1 * 100 + var_0_15].dec then
		local var_7_3 = self:getTalkSP()

		var_7_3:getChildByName("talklabel"):setString(role_conversation_data[arg_7_1 * 100 + var_0_15].dec)

		local var_7_4 = var_7_3:getChildByName("talklabel"):getContentSize().width + 100
		local var_7_5 = var_7_3:getChildByName("talklabel"):getContentSize().height + 90

		var_7_4 = var_7_4 < 348 and 348 or var_7_4
		var_7_5 = var_7_5 < 132 and 132 or var_7_5

		var_7_3:setPreferredSize(cc.size(var_7_4, var_7_5))
		var_7_3:getChildByName("talklabel"):setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 20))

		local var_7_6 = 0
		local var_7_7 = 0

		if model_data[self._modelid].talk_pos_offset then
			var_7_6, var_7_7 = var_0_17(model_data[self._modelid].talk_pos_offset)
		end

		var_7_3:setPosition(cc.p(self:getPositionX() + 50 + var_7_6, 600 + var_7_7))
		var_7_3:setVisible(true)
	end

	if role_conversation_data[arg_7_1 * 100 + var_0_15].expression then
		self.face:loadTexture("expression/" .. model_data[self._modelid][role_conversation_data[arg_7_1 * 100 + var_0_15].expression] .. ".png")
	end

	local var_7_8 = role_conversation_data[arg_7_1 * 100 + var_0_15].sound and audio_manager:isPlayerSoundValid()

	local function var_7_9()
		if var_7_8 then
			audio_manager.playingplayersound = false
		end

		if not self.isActive then
			return
		end

		if var_7_2 ~= self._modelid then
			return
		end

		if var_7_0 then
			self:getTalkSP():setVisible(false)
		end

		if var_7_1 then
			self.face:loadTexture("expression/" .. model_data[var_7_2].expression .. ".png")
		end

		if self._talktime >= var_0_13 then
			self:stopActionByTag(var_0_12)

			local var_8_0 = cc.Sequence:create(cc.DelayTime:create(10), cc.CallFunc:create(function()
				self._angrytime = 0
				self._talktime = 0

				if self._broken then
					self:showNormal()
				end
			end))

			var_8_0:setTag(var_0_12)
			self:runAction(var_8_0)
		else
			self:stopActionByTag(var_0_11)

			local var_8_1 = cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(function()
				self._talktime = 0
			end))

			var_8_1:setTag(var_0_11)
			self:runAction(var_8_1)
		end

		if self.talkFinishCallback then
			self.talkFinishCallback()

			self.talkFinishCallback = nil
		end

		self._istalking = false
	end

	if var_7_8 then
		audio_manager.playingplayersound = true

		audio_manager:playPlayerSound("sound/role_voice/" .. role_conversation_data[arg_7_1 * 100 + var_0_15].sound, nil, role_conversation_data[arg_7_1 * 100 + var_0_15].sound_volume, var_7_9)
	else
		self:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(var_7_9)))
	end
end

function DormGirlImage:getTalkSP()
	if not self._talksp then
		local var_11_0 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_11_0:setMaxLineWidth(357)
		var_11_0:setString(dec)
		var_11_0:setAnchorPoint(cc.p(0, 0.5))
		var_11_0:setColor(cc.c3b(71, 75, 86))
		var_11_0:setName("talklabel")

		if config._DEBUG then
			self._talksp = cc.Scale9Sprite:create("public/talk/word_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/talk/word_bg.png")
		end

		self._talksp:setCapInsets(cc.rect(100, 50, 200, 20))
		self._talksp:setPreferredSize(cc.size(var_11_0:getContentSize().width + 40, var_11_0:getContentSize().height + 37))
		var_11_0:setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 24))
		self._talksp:addChild(var_11_0, 3)
		self._talksp:setName("talksp")

		if DormRoomLayer and DormRoomLayer.getInstance() then
			DormRoomLayer.getInstance().uiPanel:addChild(self._talksp, 2)
		elseif DormRoomPopLayer and DormRoomPopLayer.getInstance() then
			DormRoomPopLayer.getInstance().uiPanel:addChild(self._talksp, 2)
		end

		self._talksp:setVisible(false)
	end

	return self._talksp
end

function DormGirlImage:setTalkCallback(arg_12_1)
	self.talkFinishCallback = arg_12_1
end

return DormGirlImage
