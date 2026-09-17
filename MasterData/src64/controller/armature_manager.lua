local var_0_0 = {}
local var_0_1 = {
	NEVER = 0,
	PARENT_RELEASED = 2,
	INSTANTLY = 1
}
local var_0_2 = {
	playerGradeMax = {
		aniName = "Animation1",
		armatureName = "update",
		plistPath = "effect/update/update0.plist",
		path = "effect/update/update.ExportJson",
		releaseType = var_0_1.INSTANTLY
	},
	playerUpClass = {
		aniName = "player_lvup",
		armatureName = "l2_anim",
		plistPath = "effect/player_up_class/l2_anim0.plist",
		path = "effect/player_up_class/l2_anim.ExportJson",
		releaseType = var_0_1.INSTANTLY
	},
	trainFinSkillUp = {
		aniName = "anim_skill_up",
		armatureName = "anim_skill_up",
		plistPath = "effect/skill_up/anim_skill_up0.plist",
		path = "effect/skill_up/anim_skill_up.ExportJson",
		releaseType = var_0_1.PARENT_RELEASED
	},
	swimFinSinUp = {
		aniName = "Animation1",
		armatureName = "metalpower_up",
		plistPath = "effect/san_up/metalpower_up0.plist",
		path = "effect/san_up/metalpower_up.ExportJson",
		releaseType = var_0_1.PARENT_RELEASED
	},
	cachePackGetAward = {
		aniName = "anim_getaward",
		armatureName = "anim_getaward",
		plistPath = "effect/cachepack/anim_getaward0.plist",
		path = "effect/cachepack/anim_getaward.ExportJson",
		releaseType = var_0_1.PARENT_RELEASED
	},
	cachePackGetAwardNew = {
		armatureName = "anim_getaward1",
		plistPath = "effect/cachepack/anim_getaward1/anim_getaward10.plist",
		path = "effect/cachepack/anim_getaward1/anim_getaward1.ExportJson",
		aniName = {
			"anim_getaward1",
			"anim_getaward2",
			"anim_getaward2_1",
			"anim_getaward2_2",
			"anim_getaward2_3",
			"anim_getaward2_4"
		},
		releaseType = var_0_1.PARENT_RELEASED
	},
	horcruxUpClass = {
		armatureName = "anim_girl_up",
		plistPath = "effect/horcrux_up_class/anim_girl_up0.plist",
		path = "effect/horcrux_up_class/anim_girl_up.ExportJson",
		aniName = {
			water = "water_girl_up",
			fire = "fire_girl_up",
			shiling = "dark_girl_up",
			light = "light_girl_up",
			dark = "dark_girl_up",
			imaginary = "dark_girl_up",
			wind = "wind_girl_up",
			null = "wind_girl_up",
			devil = "dark_girl_up"
		},
		releaseType = var_0_1.PARENT_RELEASED
	},
	labLineAct1 = {
		aniName = "anim_productionshop1",
		armatureName = "anim_productionshop1",
		plistPath = "effect/lab_line_act1/anim_productionshop10.plist",
		path = "effect/lab_line_act1/anim_productionshop1.ExportJson",
		releaseType = var_0_1.PARENT_RELEASED
	},
	labLineAct2 = {
		aniName = "anim_productionshop2",
		armatureName = "anim_production2",
		plistPath = "effect/lab_line_act2/anim_production20.plist",
		path = "effect/lab_line_act2/anim_production2.ExportJson",
		releaseType = var_0_1.PARENT_RELEASED
	},
	labMakeResearch = {
		armatureName = "anim_refresh_processshop",
		plistPath = "effect/lab_make_complete/anim_refresh_processshop0.plist",
		path = "effect/lab_make_complete/anim_refresh_processshop.ExportJson",
		aniName = {
			"anim_refresh_processshop",
			"anim_process1",
			"anim_process2",
			"anim_process3"
		},
		releaseType = var_0_1.PARENT_RELEASED
	},
	labResearcgResearch = {
		armatureName = "anim_refresh_material",
		plistPath = "effect/lab_refresh_research/anim_refresh_material0.plist",
		path = "effect/lab_refresh_research/anim_refresh_material.ExportJson",
		aniName = {
			"anim_process4",
			"anim_refresh_material1",
			"anim_refresh_material2",
			"anim_refresh_material3"
		},
		releaseType = var_0_1.PARENT_RELEASED
	},
	marketSweepLight = {
		aniName = "Animation1",
		armatureName = "anim_sweep_light",
		plistPath = "effect/market_sweep_light/anim_sweep_light0.plist",
		path = "effect/market_sweep_light/anim_sweep_light.ExportJson",
		releaseType = var_0_1.PARENT_RELEASED
	},
	fightStage = {
		armatureName = "anim_stage",
		plistPath = "effect/fighteffect/anim_stage0.plist",
		path = "effect/fighteffect/anim_stage.ExportJson",
		aniName = {
			nil,
			"stage0-1",
			"stage1-2",
			"stage2-3",
			"stage3-4"
		},
		releaseType = var_0_1.PARENT_RELEASED
	},
	levelUpAnim = {
		aniName = "anim_role_lvup",
		armatureName = "anim_role_lvup",
		plistPath = "effect/shengji_effect/anim_role_lvup0.plist",
		path = "effect/shengji_effect/anim_role_lvup.ExportJson",
		releaseType = var_0_1.INSTANTLY
	},
	levelUpPowerAnim = {
		aniName = "anim_role_powerup",
		armatureName = "anim_role_powerup",
		plistPath = "effect/shengji_effect/anim_role_powerup.plist",
		path = "effect/shengji_effect/anim_role_powerup.ExportJson",
		releaseType = var_0_1.INSTANTLY
	},
	purchaseResultEnter = {
		aniName = "purchase_result_enter",
		armatureName = "purchase_result_enter",
		plistPath = "effect/purchase_result/purchase_result_enter0.plist",
		path = "effect/purchase_result/purchase_result_enter.ExportJson",
		releaseType = var_0_1.NEVER
	},
	purchaseResultLoop = {
		aniName = "purchase_result_loop",
		armatureName = "purchase_result_loop",
		plistPath = "effect/purchase_result/purchase_result_loop0.plist",
		path = "effect/purchase_result/purchase_result_loop.ExportJson",
		releaseType = var_0_1.NEVER
	},
	electricUpEffect = {
		aniName = "anim_electric",
		armatureName = "anim_electric",
		plistPath = "effect/electric_up_effect/anim_electric.plist",
		path = "effect/electric_up_effect/anim_electric.ExportJson",
		releaseType = var_0_1.PARENT_RELEASED
	},
	fightDangerEffect = {
		aniName = "Animation1",
		armatureName = "danger2",
		plistPath = "effect/fighteffect/danger20.plist",
		path = "effect/fighteffect/danger2.ExportJson",
		releaseType = var_0_1.NEVER
	},
	GirlUpGradeAnim = {
		aniName = "Animation1_Copy1",
		armatureName = "jueseshengjie",
		plistPath = "effect/girl_upgrade/jueseshengjie0.plist",
		path = "effect/girl_upgrade/jueseshengjie.ExportJson",
		releaseType = var_0_1.INSTANTLY
	},
	TVTMatchAnim = {
		aniName = "matching",
		armatureName = "matching",
		plistPath = "effect/three_vs_three/matching0.plist",
		path = "effect/three_vs_three/matching.ExportJson",
		releaseType = var_0_1.INSTANTLY
	},
	flop = {
		aniName = "Animation1",
		armatureName = "flop",
		plistPath = "flop.plist",
		path = "flop.ExportJson",
		releaseType = var_0_1.PARENT_RELEASED
	}
}

function var_0_0.registryFrameEventListener(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_3 then
		return
	end

	arg_1_1:getAnimation():setFrameEventCallFunc(function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		if arg_1_3[arg_2_1] then
			arg_1_3[arg_2_1](arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		end
	end)
end

function var_0_0.registryMovementEventListener(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_3 then
		return
	end

	arg_3_1:getAnimation():setMovementEventCallFunc(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_3_3[arg_4_2] then
			arg_3_3[arg_4_2](arg_3_1, arg_4_1, arg_4_2)
		end
	end)
end

function var_0_0.addCachedName(arg_5_0, arg_5_1)
	({
		[var_0_1.NEVER] = function()
			return
		end,
		[var_0_1.INSTANTLY] = function()
			local var_7_0 = require("controller.layer_manager"):getCurrentLayerName()

			arg_5_0.addedCachedMap[var_7_0] = arg_5_0.addedCachedMap[var_7_0] or {}
			arg_5_0.addedCachedMap[var_7_0][arg_5_1] = arg_5_0.addedCachedMap[var_7_0][arg_5_1] or {}

			table.insert(arg_5_0.addedCachedMap[var_7_0][arg_5_1], {
				jsonPath = var_0_2[arg_5_1].path,
				plistPath = var_0_2[arg_5_1].plistPath
			})
		end,
		[var_0_1.PARENT_RELEASED] = function()
			local var_8_0 = require("controller.layer_manager"):getCurrentLayerName()

			arg_5_0.addedCachedMap[var_8_0] = arg_5_0.addedCachedMap[var_8_0] or {}
			arg_5_0.addedCachedMap[var_8_0][arg_5_1] = arg_5_0.addedCachedMap[var_8_0][arg_5_1] or {}

			table.insert(arg_5_0.addedCachedMap[var_8_0][arg_5_1], {
				jsonPath = var_0_2[arg_5_1].path,
				plistPath = var_0_2[arg_5_1].plistPath
			})
		end
	})[var_0_2[arg_5_1].releaseType]()
end

function var_0_0.changeDisplay(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_2 then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_2) do
		if arg_9_1:getBone(iter_9_0) then
			arg_9_1:getBone(iter_9_0):addDisplay((string.find(iter_9_1, "equipment") or string.find(iter_9_1, "roleimage") or string.find(iter_9_1, ROLE_IMAGE_PATH) or string.find(iter_9_1, CUTE_ROLE_IMAGE_PATH)) and cc.Sprite:create(iter_9_1) or config._DEBUG and cc.Sprite:create(iter_9_1) or cc.Sprite:createWithSpriteFrameName(iter_9_1), 1)
			arg_9_1:getBone(iter_9_0):changeDisplayWithIndex(1, true)
		end
	end
end

function var_0_0:updateArmatureCached(arg_10_1)
	if self.addedCachedMap and self.addedCachedMap[arg_10_1] and next(self.addedCachedMap[arg_10_1]) then
		for iter_10_0, iter_10_1 in pairs(self.addedCachedMap[arg_10_1]) do
			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				local function var_10_0(arg_11_0)
					cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(arg_11_0)
					cc.Director:getInstance():getTextureCache():removeTextureForKey(arg_11_0:match("(.+).plist") .. ".png")
				end

				ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo(iter_10_3.jsonPath)

				if type(iter_10_3.plistPath) == "table" then
					for iter_10_4, iter_10_5 in pairs(iter_10_3.plistPath) do
						var_10_0(iter_10_5.plistPath)
					end
				else
					var_10_0(iter_10_3.plistPath)
				end
			end
		end

		self.addedCachedMap[arg_10_1] = nil
	end
end

function var_0_0:createAndPlayArmature(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	self.addedCachedMap = self.addedCachedMap or {}

	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(var_0_2[arg_12_1].path)
	self:addCachedName(arg_12_1)

	local var_12_0 = type(var_0_2[arg_12_1].armatureName) == "table" and ccs.Armature:create(var_0_2[arg_12_1].armatureName.aniIndex) or ccs.Armature:create(var_0_2[arg_12_1].armatureName)

	var_12_0:setPosition(cc.p(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2))
	self:changeDisplay(var_12_0, arg_12_2)
	self:registryMovementEventListener(var_12_0, arg_12_1, arg_12_3)
	self:registryFrameEventListener(var_12_0, arg_12_1, arg_12_4)

	if type(var_0_2[arg_12_1].aniName) == "table" then
		var_12_0:getAnimation():play(var_0_2[arg_12_1].aniName[arg_12_5])
	else
		var_12_0:getAnimation():play(var_0_2[arg_12_1].aniName)
	end

	return var_12_0
end

function var_0_0.reStartAnim(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if type(var_0_2[arg_13_2].aniName) == "table" then
		arg_13_1:getAnimation():play(var_0_2[arg_13_2].aniName[arg_13_3])
	else
		arg_13_1:getAnimation():play(var_0_2[arg_13_2].aniName)
	end
end

function var_0_0.setTestData(arg_14_0, arg_14_1, arg_14_2)
	var_0_2[arg_14_1] = arg_14_2
end

return var_0_0
