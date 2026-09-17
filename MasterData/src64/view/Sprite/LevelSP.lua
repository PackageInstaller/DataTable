local var_0_0 = {}
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local l2utils = require("controller.l2utils")
local chapter_data = require("data.chapter_data")
local model_data = require("data.model_data")
local var_0_7 = config._DEBUG and 0 or 1
local var_0_8 = {
	48,
	65,
	76,
	97,
	108
}
local var_0_9 = {
	47,
	75,
	86,
	107,
	118
}
local var_0_10 = {
	"FightLayer/img_wave.png",
	"FightLayer/img_wave_foundation.png",
	"FightLayer/img_wave_military.png",
	"FightLayer/img_wave_killer.png",
	"FightLayer/img_wave_blue.png"
}
local var_0_11 = {
	"update_ai_locked",
	"update_foundation_locked",
	"update_military_locked",
	"update_killer_locked",
	"update_ai_locked"
}
local var_0_12 = {
	"search_effect",
	"search_foundation",
	"search_military",
	"search_killer",
	"search_effect"
}
local var_0_13 = {
	"unlock_effect",
	"unlock_foundation",
	"unlock_military",
	"unlock_killer",
	"unlock_effect"
}
local var_0_14 = {
	"update_ai",
	"update_foundation",
	"update_military",
	"update_killer",
	"update_ai"
}
local var_0_15 = {}

local function var_0_16(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or 1

	return (string.gsub(arg_1_0, "[%d/]", function(arg_2_0)
		if arg_2_0 == "/" then
			return string.char(var_0_9[arg_1_1])
		else
			return string.char(string.byte(arg_2_0) - 48 + var_0_8[arg_1_1])
		end
	end))
end

local function var_0_17(arg_3_0)
	arg_3_0 = arg_3_0 or 1

	return var_0_10[arg_3_0]
end

local function var_0_18(arg_4_0)
	arg_4_0 = arg_4_0 or 1

	return var_0_12[arg_4_0]
end

local function var_0_19(arg_5_0)
	arg_5_0 = arg_5_0 or 1

	return var_0_13[arg_5_0]
end

local function var_0_20(arg_6_0)
	arg_6_0 = arg_6_0 or 1

	return var_0_11[arg_6_0]
end

local function var_0_21(arg_7_0)
	arg_7_0 = arg_7_0 or 1

	return var_0_14[arg_7_0]
end

local function var_0_22(arg_8_0)
	return "find_effect"
end

local function var_0_23(arg_9_0)
	return "beat_boss"
end

local function var_0_24(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:getAnimation():play(arg_10_1)
	arg_10_0:getAnimation():gotoAndPause(arg_10_2)
	arg_10_0:getAnimation():stop()
end

local var_0_25 = {
	info = cc.p(0, -32),
	infobg = cc.p(0, -32),
	wave = cc.p(10, 46)
}

function var_0_0:setPosition(arg_11_1)
	self.bg:setPosition(arg_11_1)

	for iter_11_0, iter_11_1 in pairs(var_0_25) do
		self[iter_11_0]:setPosition(cc.p(arg_11_1.x + iter_11_1.x, arg_11_1.y + iter_11_1.y))
	end
end

function var_0_0:setVisible(arg_12_1)
	self.bg:setVisible(arg_12_1)
	self.info:setVisible(arg_12_1)
	self.infobg:setVisible(arg_12_1)

	if not arg_12_1 then
		self:removeBoss()
		self.wave:setVisible(false)
	end
end

function var_0_0:setInfo(arg_13_1, arg_13_2)
	self._mode = arg_13_1
	self._level = arg_13_2

	self:initBossID()
	self:updateInfo()

	self._state = nil
end

local var_0_26 = {
	"I",
	"II",
	"III",
	"IV",
	"V",
	"VI",
	"VII",
	"VIII",
	"IX",
	"X"
}

local function var_0_27(arg_14_0)
	local var_14_0, var_14_1 = arg_14_0:match("(%d+)-(%d+)")

	return var_0_26[tonumber(var_14_1)]
end

function var_0_0:updateInfo()
	self.info:setString("PLOT." .. var_0_27(self._level))
	self.infobg:setContentSize(cc.size(self.info:getVirtualRendererSize().width + 30, 23))
end

function var_0_0:initBossID()
	local var_16_0 = monster_manager.getLevelBoss(self._mode, self._level)

	self._bossid = var_16_0 and var_16_0.majorlist.modelid or nil
end

function var_0_0:addBoss(arg_17_1)
	if not self._bossid then
		return
	end

	if not self._boss then
		self._boss = cc.ClippingNode:create()

		self._boss:setInverted(false)

		local var_17_0 = cc.Sprite:create(CUTE_ROLE_IMAGE_PATH .. model_data[self._bossid].cute_role .. ".png")

		var_17_0:setScale(0.3)
		self._boss:setStencil(var_17_0)
		self._boss:setAlphaThreshold(0.1)

		local var_17_1 = cc.Sprite:create(CUTE_ROLE_IMAGE_PATH .. model_data[self._bossid].cute_role .. ".png")

		var_17_1:setScale(0.3)
		var_17_1:setName("boss")
		self._boss:addChild(var_17_1)
		l2utils:shakeNode(var_17_1)
		self._boss:addChild((config._DEBUG or nil) and (cc.Sprite:create("FightLayer/fight_region_boss_red.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/fight_region_boss_red.png")))

		local var_17_2, var_17_3 = self.bg:getPosition()

		self._boss:setPosition(cc.p(var_17_2, var_17_3 + (var_17_1:getContentSize().height / 2 - 17) * 0.3))
		self.bg:getParent():addChild(self._boss, 4)
	end

	if arg_17_1 then
		self._boss:setOpacity(0)
		self._boss:runAction(cc.FadeIn:create(0.18))
	end
end

function var_0_0:removeBoss(arg_18_1)
	if not self._boss then
		return
	end

	if arg_18_1 then
		self._boss:runAction(cc.Sequence:create(cc.FadeOut:create(0.25), cc.RemoveSelf:create()))
		l2utils:shakeNode(self._boss:getChildByName("boss"), {
			waitframe = 0
		})

		self._boss = nil
	else
		self._boss:removeFromParent()

		self._boss = nil
	end
end

function var_0_0:bossExist()
	return self._bossid ~= nil
end

function var_0_0:getChapter()
	local var_20_0, var_20_1 = self._level:match("(%d+)-(%d+)")

	return tonumber(var_20_0), tonumber(var_20_1)
end

function var_0_0:getLevel()
	return self._level
end

function var_0_0:getPosition()
	local var_22_0, var_22_1 = self.bg:getPosition()

	return var_22_0, var_22_1
end

local var_0_28 = 1
local var_0_29 = 2
local var_0_30 = 3
local var_0_31 = 4
local var_0_32 = 5
local var_0_33 = 6
local var_0_34 = 7
local var_0_35 = 8

function var_0_0:stateLOCK(arg_23_1)
	self:removeBoss()
	self.wave:setVisible(false)

	self._state = var_0_28
end

function var_0_0:stateUNLOCK(arg_24_1, arg_24_2)
	self:removeBoss()
	self.wave:setVisible(false)

	self._state = var_0_29

	if not arg_24_2 and arg_24_1 then
		self:stateHANGUP(nil, true)
		self:playUnlockAni()
	end
end

function var_0_0:statePASS(arg_25_1, arg_25_2)
	self:removeBoss(arg_25_1 and not arg_25_2)
	self.wave:setVisible(false)

	self._state = var_0_30

	if not arg_25_2 and not arg_25_1 then
		var_0_24(self.bg, var_0_21(var_0_15[self._mode]), 25)
	end
end

function var_0_0:stateHANGUP(arg_26_1, arg_26_2)
	self:removeBoss()

	if arg_26_2 or arg_26_1 == "0/0" then
		self.wave:setVisible(false)
	else
		self.wave:setVisible(true)
		self.wave:setString(var_0_16(arg_26_1, var_0_15[self._mode]))
		self.wave:getChildByName("img"):loadTexture(var_0_17(var_0_15[self._mode]), var_0_7)
	end

	self._state = var_0_31

	if not arg_26_2 then
		self:playHangupAni()
	end
end

function var_0_0:stateHANGUPBOSS(arg_27_1)
	if arg_27_1 then
		self:removeBoss()
	else
		self:addBoss()
	end

	self.wave:setVisible(false)

	self._state = var_0_32
end

function var_0_0:stateFIGHTING(arg_28_1, arg_28_2)
	self.wave:setVisible(false)

	self._state = var_0_33

	if arg_28_2 then
		self:removeBoss()
	elseif arg_28_1 then
		self:playFindBossAni()
	else
		self:addBoss()
	end
end

function var_0_0:stateHANGUPPASS(arg_29_1)
	self:removeBoss()
	self.wave:setVisible(false)

	self._state = var_0_34
end

function var_0_0:stateBOSS(arg_30_1)
	if arg_30_1 then
		self:removeBoss()
	else
		self:addBoss()
	end

	self.wave:setVisible(false)

	self._state = var_0_35
end

function var_0_0:showAni(arg_31_1)
	self:setFrameEventCallFunc(function(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
		if arg_32_1 == "update" then
			if arg_31_1 then
				arg_31_1()
			end
		elseif arg_32_1 == "end" then
			self:unlockToCurState()
		end
	end)
	self:setVisible(true)
	self.bg:getAnimation():play(var_0_20(var_0_15[self._mode]))
end

function var_0_0:unlockToCurState()
	if self._state == var_0_28 then
		self:removeFrameEventCallFunc()
	else
		self:playUnlockAni()
	end
end

function var_0_0:transToCurState()
	if self._state == var_0_28 then
		var_0_24(self.bg, var_0_20(self._mode), 19)
	elseif self._state == var_0_29 then
		var_0_24(self.bg, var_0_19(self._mode), 30)
	elseif self._state == var_0_30 then
		self:statePASS()
	elseif self._state == var_0_31 then
		self:stateHANGUP(level_manager:getCurHangupInfo(playermodel.curMode, playermodel.curLevel))
	elseif self._state == var_0_32 then
		self:stateHANGUPBOSS()
	elseif self._state == var_0_33 then
		self:stateFIGHTING(true)
	elseif self._state == var_0_34 then
		self:stateHANGUPPASS()
	elseif self._state == var_0_35 then
		self:stateBOSS()
	end
end

function var_0_0:playUnlockAni()
	self:setFrameEventCallFunc(function(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
		if arg_36_1 == "end" then
			self:removeFrameEventCallFunc()
			self:transToCurState()
		end
	end)
	self.bg:getAnimation():play(var_0_19(var_0_15[self._mode]))
end

function var_0_0:playUpdateAni(arg_37_1)
	self:setFrameEventCallFunc(function(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
		if arg_38_1 == "end" then
			self:removeFrameEventCallFunc()

			if arg_37_1 then
				arg_37_1()
			end
		end
	end)
	self.bg:getAnimation():play(var_0_21(var_0_15[self._mode]))
end

function var_0_0:playFindBossAni()
	self:setFrameEventCallFunc(function(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
		if arg_40_1 == "enemy_1" then
			self:addBoss(true)
		elseif arg_40_1 == "enemy_2" then
			self:removeFrameEventCallFunc()
			self:playHangupAni()
		end
	end)
	self.bg:getAnimation():play(var_0_22())
end

function var_0_0:playBeatBossAni(arg_41_1, arg_41_2)
	self:setFrameEventCallFunc(function(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
		if arg_42_1 == "disappear1" then
			self:statePASS(true)
		elseif arg_42_1 == "disappear2" then
			self:removeFrameEventCallFunc()

			if arg_41_1 then
				arg_41_1()
			end

			self:playUpdateAni(arg_41_2)
		end
	end)
	self.bg:getAnimation():play(var_0_23())
end

function var_0_0:playHangupAni()
	self.bg:getAnimation():play(var_0_18(var_0_15[self._mode]))
end

function var_0_0:setFrameEventCallFunc(arg_44_1)
	self.bg:getAnimation():setFrameEventCallFunc(arg_44_1)
end

function var_0_0:removeFrameEventCallFunc()
	self.bg:getAnimation():setFrameEventCallFunc(function(...)
		return
	end)
end

return var_0_0
