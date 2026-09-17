local var_0_0 = {
	anim_fightlayer = {
		totalframe = 50
	},
	anim_bosslayer = {
		totalframe = 240
	},
	anim_gotonextchapter = {
		totalframe = 30
	},
	anim_clear = {
		totalframe = 110
	},
	anim_clear_loop = {
		totalframe = 120
	},
	anim_mission_complete = {
		totalframe = 92
	},
	anim_mission_complete_loop = {
		totalframe = 120
	}
}

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:getAnimation():play(arg_1_1)
	arg_1_0:getAnimation():gotoAndPause(arg_1_2)
	arg_1_0:getAnimation():stop()
end

local var_0_4 = 4
local var_0_5 = 8

function FightLayer:initMapBG()
	local var_2_0 = cc.Node:create()

	var_2_0:setName("fightguidetag")
	var_2_0:setPosition(cc.p(320, 224))
	self.panelMap:addChild(var_2_0)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("fighteffect/anim_fight&clear&boss.ExportJson")

	self.mapBg = ccs.Armature:create("anim_fight&clear&boss")

	self.mapBg:setPosition(cc.p(320, 568))
	self.panelMap:addChild(self.mapBg, 1)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("fighteffect/anim_fight_boss_level.ExportJson")

	self.bossRank = ccs.Armature:create("anim_fight_boss_level")

	self.bossRank:setPosition(cc.p(320, 568))
	self.panelBoss:addChild(self.bossRank, 5)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("fighteffect/effect_btn_fightboss&nextchapter.ExportJson")

	self.btnChallenge = ccs.Armature:create("effect_btn_fightboss&nextchapter")

	self.btnChallenge:setPosition(cc.p(320, 568))
	self.panelMap:addChild(self.btnChallenge, 1)
	self.btnChallenge:setVisible(false)
	self:initControllBtnPressedSkin()
	self:initBossRankSkins()
	self:initRefightBnt()
end

function FightLayer:playBtnBreath(arg_3_1)
	self.btnChallenge:getAnimation():play(arg_3_1 == "boss" and "effect_btn_fight_boss" or "effect_btn_goto_nextchapter")
	self.btnChallenge:setVisible(true)

	if arg_3_1 == "boss" then
		if self.particalBoss then
			self.particalBoss:setVisible(true)
		else
			self.particalBoss = cc.ParticleSystemQuad:create("fighteffect/fight_boss_particle_1.plist")

			self.particalBoss:setPosition(cc.p(548, 123))
			self.panelMap:addChild(self.particalBoss, 1)
		end

		if self.particalNext then
			self.particalNext:removeFromParent()

			self.particalNext = nil
		end
	else
		if self.particalNext then
			self.particalNext:setVisible(true)
		else
			self.particalNext = cc.ParticleSystemQuad:create("fighteffect/goto_nextchapter_particle.plist")

			self.particalNext:setPosition(cc.p(548, 123))
			self.panelMap:addChild(self.particalNext, 1)
		end

		if self.particalBoss then
			self.particalBoss:removeFromParent()

			self.particalBoss = nil
		end
	end
end

function FightLayer:stopBtnBreath()
	self.btnChallenge:getAnimation():stop()
	self.btnChallenge:setVisible(false)

	if self.particalNext then
		self.particalNext:removeFromParent()

		self.particalNext = nil
	end

	if self.particalBoss then
		self.particalBoss:removeFromParent()

		self.particalBoss = nil
	end
end

function FightLayer:showBtnBreath()
	self.btnChallenge:setVisible(true)

	if self.particalBoss then
		self.particalBoss:setVisible(true)
	end

	if self.particalNext then
		self.particalNext:setVisible(true)
	end
end

function FightLayer:hideBtnBreath()
	self.btnChallenge:setVisible(false)

	if self.particalBoss then
		self.particalBoss:setVisible(false)
	end

	if self.particalNext then
		self.particalNext:setVisible(false)
	end
end

function FightLayer:setupMapBG(arg_7_1)
	if arg_7_1 == "hangup" then
		var_0_1(self.mapBg, "anim_fightlayer", 40)
		self.bossRank:setVisible(false)
		self:stopBtnBreath()
	elseif arg_7_1 == "boss" then
		self:updateBossRankSkin(self._chapterboss.rank)
		var_0_1(self.mapBg, "anim_bosslayer", 220)
		self.bossRank:setVisible(true)
		var_0_1(self.bossRank, "boss_level", 180)
		self:playBtnBreath("boss")
	elseif arg_7_1 == "pass" then
		self:playBtnBreath("next")
		self.mapBg:getAnimation():play("anim_clear_loop")
		self.bossRank:setVisible(false)
	elseif arg_7_1 == "complete" then
		self:playBtnBreath("next")
		self.mapBg:getAnimation():play("anim_mission_complete_loop")
		self.bossRank:setVisible(false)
	end
end

function FightLayer:playUnlockNewChapterAni()
	self:updateFrameEventCallFunc(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		if arg_9_1 == "chapter_start" then
			-- block empty
		elseif arg_9_1 == "line_start" then
			self:showLineAni()
		elseif arg_9_1 == "checkpoint" then
			self:showLevelsAni(1)
		elseif arg_9_1 == "line_end" then
			self:removeFrameEventCallFunc()
		end
	end)
	self.mapBg:getAnimation():play("anim_fightlayer")
	self.bossRank:setVisible(false)
	self:stopBtnBreath()
end

function FightLayer:playUnlockNewBossAni()
	self:updateFrameEventCallFunc(function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		if arg_11_1 == "boss1" then
			self:playShowBossAni()
		elseif arg_11_1 == "end" then
			self:removeFrameEventCallFunc()

			self.showstat = var_0_4

			self:refreshGuidesOnFight()
			GuideListener.triggerGuide(TRIGGER_PASSBEFOREBOSS)
			self:playBtnBreath("boss")

			self._controllvalid = 1
		end
	end, "anim_bosslayer")
	self:hideBtnBreath()
	self:updateBossRankSkin(self._chapterboss.rank)
	self.mapBg:getAnimation():play("anim_bosslayer")
	self.bossRank:setVisible(true)
	self.bossRank:getAnimation():play("boss_level")
end

function FightLayer:playPassChapterAni(arg_12_1)
	self.showstat = var_0_5

	self:refreshGuidesOnFight()
	GuideListener.triggerGuide(TRIGGER_PASSLEVEL)
	self:updateFrameEventCallFunc(function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		if arg_13_1 == "end" then
			self:removeFrameEventCallFunc()
			self:setupMapBG("pass")

			self._controllvalid = 2
		end
	end, "anim_clear")
	self:hideBtnBreath()
	self.mapBg:getAnimation():play("anim_clear")
	self.bossRank:setVisible(false)
end

function FightLayer:playCompleteAni(arg_14_1)
	self.showstat = var_0_5

	self:refreshGuidesOnFight()
	GuideListener.triggerGuide(TRIGGER_PASSLEVEL)
	self:updateFrameEventCallFunc(function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		if arg_15_1 == "end" then
			self:removeFrameEventCallFunc()
			self:setupMapBG("complete")

			self._controllvalid = 3
		end
	end, "anim_mission_complete")
	self:hideBtnBreath()
	self.mapBg:getAnimation():play("anim_mission_complete")
	self.bossRank:setVisible(false)
end

function FightLayer:playGotoNextChapterAni(arg_16_1)
	self:updateFrameEventCallFunc(function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		if arg_17_1 == "end" then
			self:removeFrameEventCallFunc()

			if arg_16_1 then
				arg_16_1()
			end
		end
	end)
	self.mapBg:getAnimation():play("anim_gotonextchapter")
	self:hideBtnBreath()
end

function FightLayer:updateFrameEventCallFunc(arg_18_1, arg_18_2)
	self.mapBg:getAnimation():setFrameEventCallFunc(arg_18_1)
	self.mapBg:stopAllActions()

	if arg_18_2 then
		self.mapBg:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_0[arg_18_2].totalframe / 60 + 10), cc.CallFunc:create(function()
			arg_18_1(nil, "end")
		end)))
	end
end

function FightLayer:removeFrameEventCallFunc()
	self.mapBg:getAnimation():setFrameEventCallFunc(function(...)
		return
	end)
	self.mapBg:stopAllActions()
end

function FightLayer:stopMapBGActions()
	self.mapBg:getAnimation():stop()
	self:removeFrameEventCallFunc()
end

function FightLayer:initBossRankSkins()
	local var_23_0

	if config._DEBUG then
		var_23_0 = cc.Sprite:create("FightLayer/level_a.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_a.png")

		local var_23_1

		if config._DEBUG then
			var_23_1 = cc.Sprite:create("FightLayer/level_a.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_a.png")

			local var_23_2

			if config._DEBUG then
				var_23_2 = cc.Sprite:create("FightLayer/level_b.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_b.png")

				local var_23_3

				if config._DEBUG then
					var_23_3 = cc.Sprite:create("FightLayer/level_b.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_b.png")

					local var_23_4

					if config._DEBUG then
						var_23_4 = cc.Sprite:create("FightLayer/level_c.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_c.png")

						local var_23_5

						if config._DEBUG then
							var_23_5 = cc.Sprite:create("FightLayer/level_c.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_c.png")

							local var_23_6

							if config._DEBUG then
								var_23_6 = cc.Sprite:create("FightLayer/level_d.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_d.png")

								local var_23_7

								if config._DEBUG then
									var_23_7 = cc.Sprite:create("FightLayer/level_d.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_d.png")

									local var_23_8

									if config._DEBUG then
										var_23_8 = cc.Sprite:create("FightLayer/level_s.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_s.png")

										local var_23_9

										if config._DEBUG then
											var_23_9 = cc.Sprite:create("FightLayer/level_s.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/level_s.png")
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	self.bossRank:getBone("boss_level"):addDisplay(var_23_6, 1)
	self.bossRank:getBone("boss_level1"):addDisplay(var_23_7, 1)
	self.bossRank:getBone("boss_level"):addDisplay(var_23_4, 2)
	self.bossRank:getBone("boss_level1"):addDisplay(var_23_5, 2)
	self.bossRank:getBone("boss_level"):addDisplay(var_23_2, 3)
	self.bossRank:getBone("boss_level1"):addDisplay(var_23_3, 3)
	self.bossRank:getBone("boss_level"):addDisplay(var_23_0, 4)
	self.bossRank:getBone("boss_level1"):addDisplay(var_23_1, 4)
	self.bossRank:getBone("boss_level"):addDisplay(var_23_8, 5)
	self.bossRank:getBone("boss_level1"):addDisplay(var_23_9, 5)
end

function FightLayer:updateBossRankSkin(arg_24_1)
	self.bossRank:getBone("boss_level"):changeDisplayWithIndex(arg_24_1, true)
	self.bossRank:getBone("boss_level1"):changeDisplayWithIndex(arg_24_1, true)
end

function FightLayer:initControllBtnPressedSkin()
	self.mapBg:getBone("btn_challenge"):addDisplay(cc.Sprite:createWithSpriteFrameName("btn_fight_boss1_4.png"), 15)
	self.mapBg:getBone("btn_challenge"):addDisplay(cc.Sprite:createWithSpriteFrameName("btn_goto_nextchapter2.png"), 16)
	self.mapBg:getBone("btn_challenge"):addDisplay(cc.Sprite:createWithSpriteFrameName("btn_goto_nextchapter4.png"), 17)
end

function FightLayer:onControllBtnPressed()
	if self._controllvalid == 1 then
		self.mapBg:getBone("btn_challenge"):changeDisplayWithIndex(15, false)
	elseif self._controllvalid == 2 then
		self.mapBg:getBone("btn_challenge"):changeDisplayWithIndex(16, true)
	elseif self._controllvalid == 3 then
		self.mapBg:getBone("btn_challenge"):changeDisplayWithIndex(17, true)
	end

	self:hideBtnBreath()
end

function FightLayer:onControllBtnReleased()
	if self._controllvalid == 1 then
		self.mapBg:getBone("btn_challenge"):changeDisplayWithIndex(5, false)
	elseif self._controllvalid == 2 then
		self.mapBg:getBone("btn_challenge"):changeDisplayWithIndex(7, false)
	elseif self._controllvalid == 3 then
		self.mapBg:getBone("btn_challenge"):changeDisplayWithIndex(14, false)
	end

	self:showBtnBreath()
end

function FightLayer:initRefightBnt()
	self.refightBnt = ccui.Button:create("FightLayer/refight_bnt.png", nil, "FightLayer/refight_bnt.png", config._DEBUG and 0 or 1)

	self.refightBnt:setPosition(cc.p(520, 380))
	self.panelMap:addChild(self.refightBnt, 99)
	self.refightBnt:setVisible(false)
	self.refightBnt:addTouchEventListener(function(arg_29_0, arg_29_1)
		local var_29_0

		if arg_29_1 ~= ccui.TouchEventType.ended then
			do return end

			var_29_0 = {
				configtype = CONFIG_TYPE_REFIGHT
			}
		end

		function var_29_0.configcallback()
			LayerManager:getUIElement("TopcostLayer"):setTouchLock(false)
			LayerManager:getUIElement("ListButton"):setTouchLock(false)
			require("controller.autopop_manager"):pauseAchievementPop()
			FightManager.startRefightBigBoss()

			self._controllvalid = nil
		end

		require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationMainLayer", var_29_0)
	end)
end

function FightLayer:updateRefightBnt(arg_31_1)
	local level_manager = require("controller.level_manager")
	local playermodel = require("model.playermodel")

	arg_31_1 = arg_31_1 or false

	if level_manager:isMainChapterOrFeederChapter(playermodel.curMode) and not level_manager:isTalkLevel(playermodel.curMode) then
		self.refightBnt:setVisible(arg_31_1)
	else
		self.refightBnt:setVisible(false)
	end
end
