local ShowGirlSpine = class("ShowGirlSpine", function()
	return cc.Node:create()
end)
local var_0_3 = 3
local model_data = require("data.model_data")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local conversation_type_data = require("data.conversation_type_data")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_11 = 1001
local var_0_12 = 1002
local var_0_13 = 1
local var_0_14
local var_0_15 = 0.5
local var_0_21 = 5
local var_0_22
local var_0_23 = {
	["114025_1"] = true
}

local function var_0_24(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:match("([^,]+),(.+)")

	return tonumber(var_2_0), tonumber(var_2_1)
end

function ShowGirlSpine:create(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = ShowGirlSpine.new()

	var_3_0:init(arg_3_1, arg_3_2, arg_3_3)

	return var_3_0
end

function ShowGirlSpine:init(arg_4_1, arg_4_2, arg_4_3)
	var_0_22 = self
	self._modelid = arg_4_1
	self._showtype = arg_4_3
	self.skeletonData = nil
	self.lastAniName = nil
	self.lastAniCycled = nil
	self.aniListener = {}
	self.autocollect = arg_4_2
	self._nowjsonfile = nil
	self._nowatlasfile = nil
	self.isCanTouch = true
	self._swallowtouch = true
	self._listener = nil

	self:initDownload()
	self:checkResource({
		json = ROLE_SPINE_PATH .. model_data[arg_4_1].rolespine .. ".json",
		atlas = ROLE_SPINE_PATH .. model_data[arg_4_1].rolespine .. ".atlas"
	})
	self:registerCustomEvent()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_22 = nil

			if self.skeletonData then
				self.skeletonData:release()

				self.skeletonData = nil
			end

			if self._talksp then
				self._talksp:runAction(cc.RemoveSelf:create())

				self._talksp = nil
			end

			if self.skeletonAnimation then
				self.skeletonAnimation:removeFromParent()

				self.skeletonAnimation = nil
			end

			SpineCacheManager:removeShowGirlSpineCache(self._nowjsonfile, self._nowatlasfile)
		end
	end)
end

function ShowGirlSpine:reset(arg_6_1)
	if arg_6_1 == self._modelid then
		return
	end

	self._modelid = arg_6_1

	self:checkResource({
		json = ROLE_SPINE_PATH .. model_data[arg_6_1].rolespine .. ".json",
		atlas = ROLE_SPINE_PATH .. model_data[arg_6_1].rolespine .. ".atlas"
	})

	self._talktime = 0
	self._angrytime = 0
	self._istalking = false

	self:getTalkSP():setVisible(false)

	var_0_13 = 1
	var_0_14 = nil
end

require("controller.filedownloader.download_node_utils"):addDownloadInterface(ShowGirlSpine, "Spine")

function ShowGirlSpine:onDownloadProcessing()
	if self.skeletonAnimation then
		self:removeChild(self.skeletonAnimation)

		self.skeletonAnimation = nil
	end

	if self.skeletonData then
		self.skeletonData:release()

		self.skeletonData = nil

		SpineCacheManager:removeShowGirlSpineCache(self._nowjsonfile, self._nowatlasfile)
	end

	if self._loadingani then
		self._loadingani:setVisible(true)
		self._loadingani:play()

		return
	end

	self._loadingani = require("view.Sprite.LoadingSprite"):create()

	self._loadingani:setPosition(cc.p(GameDisplay.cx - self:getPositionX(), GameDisplay.cy - self:getPositionY()))
	self:addChild(self._loadingani)
end

function ShowGirlSpine:onDownloadComplete(arg_8_1)
	if not arg_8_1 then
		return
	end

	if arg_8_1.json ~= ROLE_SPINE_PATH .. model_data[self._modelid].rolespine .. ".json" then
		return
	end

	self:refreshSkeleton()

	if self.lastAniName then
		self:play(self.lastAniName, self.lastAniCycled)
	end
end

function ShowGirlSpine:resetCurTalkConfig()
	var_0_13 = 1
	var_0_14 = nil
end

function ShowGirlSpine:play(arg_10_1, arg_10_2)
	if arg_10_2 == nil then
		arg_10_2 = true
	end

	if not self.skeletonAnimation then
		self.lastAniName = arg_10_1
		self.lastAniCycled = arg_10_2

		return
	end

	self.skeletonAnimation:setAnimation(0, arg_10_1, arg_10_2)

	self.lastAniName = arg_10_1
	self.lastAniCycled = arg_10_2
end

function ShowGirlSpine:addAnimation(arg_11_1, arg_11_2)
	if arg_11_2 == nil then
		arg_11_2 = true
	end

	if not self.skeletonAnimation then
		self.lastAniName = arg_11_1
		self.lastAniCycled = arg_11_2

		return
	end

	self.skeletonAnimation:addAnimation(0, arg_11_1, arg_11_2)

	if self.lastAniName ~= nil then
		self.skeletonAnimation:setMix(self.lastAniName, arg_11_1, 0.1)
	end

	self.lastAniName = arg_11_1
	self.lastAniCycled = arg_11_2
end

function ShowGirlSpine:isAnimationExist(arg_12_1)
	if not arg_12_1 then
		if DeviceManager.platform == "windows" then
			global_ShowBlockWords(string.format(L_SPINE_NOT_HAVE_ANI, self._modelid))
		end

		return false
	end

	if not self.skeletonAnimation then
		return false
	end

	return self.skeletonAnimation:isAnimationExist(arg_12_1)
end

function ShowGirlSpine:refreshSkeleton()
	if self._loadingani then
		self._loadingani:stop()
		self._loadingani:setVisible(false)
	end

	if self.skeletonAnimation then
		self:removeChild(self.skeletonAnimation)

		self.skeletonAnimation = nil
	end

	if self.skeletonData then
		self.skeletonData:release()

		self.skeletonData = nil

		SpineCacheManager:removeShowGirlSpineCache(self._nowjsonfile, self._nowatlasfile)
	end

	self.aniListener = {}
	self.skeletonData = SpineCacheManager:addSpineData(ROLE_SPINE_PATH .. model_data[self._modelid].rolespine .. ".json", ROLE_SPINE_PATH .. model_data[self._modelid].rolespine .. ".atlas")

	self.skeletonData:retain()

	self.skeletonAnimation = sp.SkeletonAnimation:create(self.skeletonData:getData())

	if var_0_23[model_data[self._modelid].rolespine] then
		self.skeletonAnimation:setSkin((RoleDefault:getInstance():getIntegerForKey("spine_skin_" .. model_data[self._modelid].rolespine, 1)))
	end

	self:addChild(self.skeletonAnimation)

	local var_13_0 = model_data[self._modelid].mainlayer_scale or 1

	self.skeletonAnimation:setScale(var_13_0, var_13_0)
	self:registerEventListener()

	self._nowjsonfile = ROLE_SPINE_PATH .. model_data[self._modelid].rolespine .. ".json"
	self._nowatlasfile = ROLE_SPINE_PATH .. model_data[self._modelid].rolespine .. ".atlas"
end

function ShowGirlSpine:registerEventListener()
	self.skeletonAnimation:registerSpineEventHandler(function(arg_15_0)
		if self.aniListener[arg_15_0.animation] then
			self.aniListener[arg_15_0.animation]()
		end
	end, var_0_3)
end

local function var_0_25(arg_16_0)
	if not arg_16_0 then
		return true
	end

	local var_16_0 = arg_16_0:getParent()

	if var_16_0 and not var_16_0:isVisible() then
		return false
	end

	return var_0_25(var_16_0)
end

function ShowGirlSpine:updateSkin()
	if cc.FileUtils:getInstance():isFileExist(ROLE_SPINE_PATH .. model_data[self._modelid].rolespine .. "_shake.json") then
		local var_17_0 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[self._modelid].rolespine .. "_shake.json", ROLE_SPINE_PATH .. model_data[self._modelid].rolespine .. "_shake.atlas", nil, true)

		var_17_0:refreshSkeleton()
		var_17_0:setPosition(cc.p(0, 0))
		self:addChild(var_17_0, 1)
		var_17_0:play("shake")
		var_17_0.skeletonAnimation:registerSpineEventHandler(function(arg_18_0)
			self:refreshSkeleton()
			self:play("idle")
			var_17_0:runAction(cc.RemoveSelf:create())
		end, var_0_3)
	else
		self:refreshSkeleton()
		self:play("idle")
	end
end

function ShowGirlSpine:registerCustomEvent()
	self._talktime = 0
	self._angrytime = 0
	self._istalking = false

	local var_19_0 = cc.EventListenerTouchOneByOne:create()

	var_19_0:setSwallowTouches(true)
	var_19_0:registerScriptHandler(function(arg_20_0, arg_20_1)
		if not self.skeletonAnimation then
			return false
		end

		print("TouchShowGirlSpine: ", self._istalking)

		if self._istalking then
			return false
		end

		if not self:isVisible() then
			return false
		end

		if not var_0_25(self) then
			return false
		end

		return cc.rectContainsPoint(self.skeletonAnimation:getBoundingBox(), (self:convertTouchToNodeSpace(arg_20_0)))
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_19_0:registerScriptHandler(function(arg_21_0, arg_21_1)
		print("TouchShowGirlSpineEnd: ", self.isCanTouch)

		if self.isCanTouch == true then
			self:showRoleTalk()

			if self.touchTalkCallback then
				self.touchTalkCallback()
			end

			local var_21_0 = model_data[self._modelid].rolespine

			if var_0_23[model_data[self._modelid].rolespine] then
				RoleDefault:getInstance():setIntegerForKey("spine_skin_" .. var_21_0, RoleDefault:getInstance():getIntegerForKey("spine_skin_" .. var_21_0, 1) == 1 and 2 or 1)

				local var_21_1 = cc.EventCustom:new("SHOW_GIRL_SPINE_UPDATE")

				var_21_1.rolespine = var_21_0
				var_21_1.instance = self

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_21_1)
			end
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_19_0, self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("SHOW_GIRL_SPINE_UPDATE", function(arg_22_0)
		if model_data[self._modelid].rolespine ~= arg_22_0.rolespine then
			return
		end

		if self == arg_22_0.instance then
			self:updateSkin()
		else
			self:refreshSkeleton()
			self:play("idle")
		end
	end), self)

	self._listener = var_19_0
end

function ShowGirlSpine:insertTalk(arg_23_1)
	self:showRoleTalk(arg_23_1)
end

function ShowGirlSpine:showRoleTalk(arg_24_1)
	if arg_24_1 then
		self.isInsertTalk = arg_24_1
		self._talktime = 0
		self._angrytime = 0
		var_0_13 = 1
		var_0_14 = nil

		if self:genRoleTalk(arg_24_1) then
			self.isInsertTalk = nil
		end
	elseif self.isInsertTalk then
		if self:genRoleTalk(self.isInsertTalk) then
			self.isInsertTalk = nil
		end
	else
		if self._talktime >= var_0_15 then
			self._angrytime = self._angrytime + 1

			self:genRoleTalk(ROLE_SOUND_TYPE.angry)
			LayerManager:shake_screen(2, 5)
			self:stopActionByTag(var_0_12)

			local var_24_0 = cc.Sequence:create(cc.DelayTime:create(10), cc.CallFunc:create(function()
				self._talktime = 0
				self._angrytime = 0
			end))

			var_24_0:setTag(var_0_12)
			self:runAction(var_24_0)
		elseif self:genRoleTalk(ROLE_SOUND_TYPE.random) then
			self._talktime = self._talktime + 1
		end

		self:stopActionByTag(var_0_11)
	end
end

function ShowGirlSpine:genRoleTalk(arg_26_1)
	if arg_26_1 == ROLE_CONVERSATION_TYPE.mainTouch then
		if var_0_13 == 1 then
			var_0_14 = GenerateRoleConversationClass(self._modelid, arg_26_1)
		end
	else
		var_0_14 = GenerateRoleConversationClass(self._modelid, arg_26_1) or GenerateRoleConversationClass(self._modelid, ROLE_CONVERSATION_TYPE.mainTouch)
	end

	if not role_conversation_data[var_0_14 * 100 + 1] then
		return false
	end

	local var_26_1 = 0

	while role_conversation_data[var_0_14 * 100 + var_26_1 + 1] do
		var_26_1 = var_26_1 + 1
	end

	if var_26_1 < var_0_13 then
		var_0_13 = 1
	end

	self:playRoleTalk(var_0_14)

	var_0_13 = var_0_13 + 1

	if var_26_1 < var_0_13 then
		var_0_13 = 1
	end

	return var_26_1 < var_0_13
end

function ShowGirlSpine:playRoleTalk(arg_27_1)
	local var_27_0 = role_conversation_data[arg_27_1 * 100 + var_0_13].dec
	local var_27_1 = global_get_conversation_ani(arg_27_1 * 100 + var_0_13, self._modelid, 1)

	self._istalking = true

	local var_27_2 = self._modelid

	if role_conversation_data[arg_27_1 * 100 + var_0_13].dec then
		local var_27_3 = self:getTalkSP()

		var_27_3:getChildByName("talklabel"):setString(role_conversation_data[arg_27_1 * 100 + var_0_13].dec)

		local var_27_4 = var_27_3:getChildByName("talklabel"):getContentSize().width + 100
		local var_27_5 = var_27_3:getChildByName("talklabel"):getContentSize().height + 70

		var_27_4 = var_27_4 < 348 and 348 or var_27_4
		var_27_5 = var_27_5 < 132 and 132 or var_27_5

		var_27_3:setPreferredSize(cc.size(var_27_4, var_27_5))
		var_27_3:getChildByName("talklabel"):setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 20))

		if self._showtype == var_0_21 then
			local var_27_7, var_27_8 = var_0_24(model_data[self._modelid].database_talk_pos_offset or model_data[self._modelid].talk_pos_offset or "0,0")

			var_27_3:setPosition(cc.p(320 + var_27_7, 568 + var_27_8))
		elseif model_data[self._modelid].talk_pos_offset then
			local var_27_9, var_27_10 = var_0_24(model_data[self._modelid].talk_pos_offset)

			var_27_3:setPosition(cc.p(self:getPositionX() + 50 + var_27_9, 600 + var_27_10))
		end

		var_27_3:setVisible(true)
	end

	if role_conversation_data[arg_27_1 * 100 + var_0_13].sound then
		audio_manager:stopAllRoleSound()

		audio_manager.playingplayersound = false
	end

	if role_conversation_data[arg_27_1 * 100 + var_0_13].sound and audio_manager:isPlayerSoundValid() then
		audio_manager.playingplayersound = true

		audio_manager:playPlayerSound("sound/role_voice/" .. role_conversation_data[arg_27_1 * 100 + var_0_13].sound, nil, role_conversation_data[arg_27_1 * 100 + var_0_13].sound_volume, function()
			audio_manager.playingplayersound = false

			if var_27_2 ~= self._modelid then
				return
			end

			if var_27_0 then
				self:getTalkSP():setVisible(false)
			end

			self._istalking = false

			self:stopActionByTag(var_0_11)

			local var_28_0 = cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(function()
				self._talktime = 0
			end))

			var_28_0:setTag(var_0_11)
			self:runAction(var_28_0)
		end)

		if self:isAnimationExist(var_27_1) then
			self.aniListener[var_27_1] = function()
				self:play("idle")
			end

			self:play(var_27_1, false)
		end
	else
		local function var_27_11()
			if var_27_0 then
				self:getTalkSP():setVisible(false)
			end

			self._istalking = false

			self:stopActionByTag(var_0_11)

			local var_31_0 = cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(function()
				self._talktime = 0
			end))

			var_31_0:setTag(var_0_11)
			self:runAction(var_31_0)
		end

		if self:isAnimationExist(var_27_1) then
			self.aniListener[var_27_1] = function()
				var_27_11()
				self:play("idle")
			end

			self:play(var_27_1, false)
		else
			self:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(var_27_11)))
		end
	end
end

function ShowGirlSpine:getTalkSP()
	if not self._talksp then
		local var_34_0 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_34_0:setMaxLineWidth(357)
		var_34_0:setString(dec)
		var_34_0:setAnchorPoint(cc.p(0, 0.5))
		var_34_0:setColor(cc.c3b(71, 75, 86))
		var_34_0:setName("talklabel")

		if config._DEBUG then
			self._talksp = cc.Scale9Sprite:create("public/talk/word_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/talk/word_bg.png")
		end

		self._talksp:setCapInsets(cc.rect(100, 50, 200, 20))
		self._talksp:setPreferredSize(cc.size(var_34_0:getContentSize().width + 40, var_34_0:getContentSize().height + 37))
		var_34_0:setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 24))
		self._talksp:addChild(var_34_0, 3)
		LayerManager:getCurrentLayerObj():addChild(self._talksp, 100)
		self._talksp:setVisible(false)
		self._talksp:registerScriptHandler(function(arg_35_0)
			if arg_35_0 == "exit" then
				self._talksp = nil
			end
		end)
	end

	return self._talksp
end

function ShowGirlSpine:setTouchTalkCallback(arg_36_1)
	self.touchTalkCallback = arg_36_1
end

function ShowGirlSpine:playTalkCallBack()
	if self.talkFinishCallback then
		self.talkFinishCallback()
	end
end

function ShowGirlSpine:setTouchEnabled(arg_38_1)
	self.isCanTouch = arg_38_1
end

function ShowGirlSpine:setSwallowTouches(arg_39_1)
	self._swallowtouch = arg_39_1

	if self._listener then
		self._listener:setSwallowTouches(arg_39_1)
	end
end

return ShowGirlSpine
