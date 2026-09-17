local ShowGirlSpine = require("view.Sprite.ShowGirlSpine")
local ShowGirlImage = require("view.Sprite.ShowGirlImage")
local DormGirlSpine = class("DormGirlSpine", function(arg_1_0)
	return ShowGirlSpine:create(arg_1_0)
end)
local model_data = require("data.model_data")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local conversation_type_data = require("data.conversation_type_data")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_14 = 1001
local var_0_15 = 1002
local var_0_16 = 1
local var_0_17
local var_0_18 = 5

local function var_0_20(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:match("([^,]+),(.+)")

	return tonumber(var_2_0), tonumber(var_2_1)
end

function DormGirlSpine:create(arg_3_1)
	var_0_16 = 1
	var_0_17 = nil

	return (DormGirlSpine.new(arg_3_1))
end

function DormGirlSpine:insertTalk(arg_4_1)
	self:showRoleTalk(arg_4_1)
end

function DormGirlSpine:showRoleTalk(arg_5_1)
	if arg_5_1 then
		self.isInsertTalk = arg_5_1
		self._talktime = 0
		self._angrytime = 0
		var_0_16 = 1
		var_0_17 = nil

		if self:genRoleTalk(arg_5_1) then
			self.isInsertTalk = nil
		end
	elseif self.isInsertTalk then
		if self:genRoleTalk(self.isInsertTalk) then
			self.isInsertTalk = nil
		end
	else
		if self._talktime >= var_0_18 then
			self._angrytime = self._angrytime + 1

			self:genRoleTalk(ROLE_CONVERSATION_TYPE.angry)

			if LayerManager:getCurrentLayerName() == "DormRoomLayer" then
				LayerManager:getCurrentLayerObj():shake_screen(2, 5)
			end

			self:stopActionByTag(var_0_15)
		elseif self:genRoleTalk(ROLE_CONVERSATION_TYPE.dormTouch) then
			self._talktime = self._talktime + 1
		end

		self:stopActionByTag(var_0_14)
	end
end

function DormGirlSpine:genRoleTalk(arg_6_1)
	if var_0_16 == 1 then
		var_0_17 = GenerateRoleConversationClass(self._modelid, arg_6_1)
	end

	if not var_0_17 then
		return
	end

	if not role_conversation_data[var_0_17 * 100 + 1] then
		return false
	end

	local var_6_0 = 0

	while role_conversation_data[var_0_17 * 100 + var_6_0 + 1] do
		var_6_0 = var_6_0 + 1
	end

	if var_6_0 < var_0_16 then
		var_0_16 = 1
	end

	self:playRoleTalk(global_get_conversation_ani(var_0_17 * 100 + var_0_16, self._modelid, 1), role_conversation_data[var_0_17 * 100 + var_0_16].dec, role_conversation_data[var_0_17 * 100 + var_0_16].sound)

	var_0_16 = var_0_16 + 1

	if var_6_0 < var_0_16 then
		var_0_16 = 1
	end

	return var_6_0 < var_0_16
end

function DormGirlSpine:playRoleTalk(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._istalking = true

	local var_7_0 = self._modelid

	if arg_7_2 then
		local var_7_1 = self:getTalkSP()

		var_7_1:getChildByName("talklabel"):setString(arg_7_2)

		local var_7_2 = var_7_1:getChildByName("talklabel"):getContentSize().width + 100
		local var_7_3 = var_7_1:getChildByName("talklabel"):getContentSize().height + 90

		var_7_2 = var_7_2 < 348 and 348 or var_7_2
		var_7_3 = var_7_3 < 132 and 132 or var_7_3

		var_7_1:setPreferredSize(cc.size(var_7_2, var_7_3))
		var_7_1:getChildByName("talklabel"):setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 20))

		local var_7_4 = 0
		local var_7_5 = 0

		if model_data[self._modelid].talk_pos_offset then
			var_7_4, var_7_5 = var_0_20(model_data[self._modelid].talk_pos_offset)
		end

		var_7_1:setPosition(cc.p(self:getPositionX() + 50 + var_7_4, 600 + var_7_5))
		var_7_1:setVisible(true)
	end

	if arg_7_3 and audio_manager:isPlayerSoundValid() then
		audio_manager.playingplayersound = true

		audio_manager:playPlayerSound("sound/role_voice/" .. arg_7_3, nil, arg_7_4, function()
			audio_manager.playingplayersound = false

			if var_7_0 ~= self._modelid then
				return
			end

			if arg_7_2 then
				self:getTalkSP():setVisible(false)
			end

			self._istalking = false

			self:play("idle")

			if self._talktime >= var_0_18 then
				self:stopActionByTag(var_0_15)

				local var_8_0 = cc.Sequence:create(cc.DelayTime:create(10), cc.CallFunc:create(function()
					self._angrytime = 0
					self._talktime = 0

					if self._broken then
						self:showNormal()
					end
				end))

				var_8_0:setTag(var_0_15)
				self:runAction(var_8_0)
			else
				self:stopActionByTag(var_0_14)

				local var_8_1 = cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(function()
					self._talktime = 0
				end))

				var_8_1:setTag(var_0_14)
				self:runAction(var_8_1)
			end

			if self.talkFinishCallback then
				self.talkFinishCallback()

				self.talkFinishCallback = nil
			end
		end)

		if self:isAnimationExist(arg_7_1) then
			self.aniListener[arg_7_1] = function()
				self:play("idle")
			end

			self:play(arg_7_1, false)
		end
	else
		local function var_7_6()
			if arg_7_2 then
				self:getTalkSP():setVisible(false)
			end

			self._istalking = false

			if self.talkFinishCallback then
				self.talkFinishCallback()

				self.talkFinishCallback = nil
			end
		end

		if self:isAnimationExist(arg_7_1) then
			self.aniListener[arg_7_1] = function()
				var_7_6()
				self:play("idle")
			end

			self:play(arg_7_1, false)
		else
			self:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(var_7_6)))
		end
	end
end

function DormGirlSpine:getTalkSP()
	if not self._talksp then
		local var_14_0 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_14_0:setMaxLineWidth(357)
		var_14_0:setString(dec)
		var_14_0:setAnchorPoint(cc.p(0, 0.5))
		var_14_0:setColor(cc.c3b(71, 75, 86))
		var_14_0:setName("talklabel")

		if config._DEBUG then
			self._talksp = cc.Scale9Sprite:create("public/talk/word_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/talk/word_bg.png")
		end

		self._talksp:setCapInsets(cc.rect(100, 50, 200, 20))
		self._talksp:setPreferredSize(cc.size(var_14_0:getContentSize().width + 40, var_14_0:getContentSize().height + 37))
		var_14_0:setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 24))
		self._talksp:addChild(var_14_0, 3)
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

function DormGirlSpine:setTalkCallback(arg_15_1)
	self.talkFinishCallback = arg_15_1
end

return DormGirlSpine
