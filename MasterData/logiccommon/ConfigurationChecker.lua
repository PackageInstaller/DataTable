-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/ConfigurationChecker.lua

module("logiccommon.common.util.ConfigurationChecker", package.seeall)

local ConfigurationChecker = class("ConfigurationChecker")

function ConfigurationChecker:checkConfigurations()
	if not Framework.OSDef.isEditor then
		return
	end

	self:_checkPetSkill()
	self:_checkRankType()
	self:_checkPayshopTime()
	self:_checkChatBubble()
	self:_checkItemUse()
	self:_checkBeastRichMan()
end

function ConfigurationChecker:_checkRankType()
	if not TimeLimitedConfig.instance._timed_challenge_rank then
		for i, v in ipairs((not TimeLimitedConfig.instance._timed_challenge_rank.dataList or nil) and {}) do
			local hasFound = false

			for k, typeV in pairs(GameEnum.RankType) do
				if v.idx == typeV then
					hasFound = true

					break
				end
			end

			if hasFound == false then
				printError("export_限时挑战排行榜  in  x限时挑战.xlsx  t_timed_challenge_rank 表里面的ID=" .. v.idx .. "   必须当常量配置到 GameEnum.RankType 里面 ")
			end
		end
	end
end

function ConfigurationChecker:_checkPetSkill()
	local petCfgs = PetSkinConfig.instance:getPetSkinCfgList()

	for i = 1, #petCfgs do
		if petCfgs[i].normalSkillId ~= 0 then
			local skillCo = BattleConfig.instance:getSkillCo(petCfgs[i].normalSkillId)

			if not skillCo then
				self:_printPetSkillIdError(petCfgs[i].normalSkillId)

				return
			end
		end

		if petCfgs[i].ultSkillId ~= 0 then
			local skillCo = BattleConfig.instance:getSkillCo(petCfgs[i].ultSkillId)

			if not skillCo then
				self:_printPetSkillIdError(petCfgs[i].ultSkillId)

				return
			end
		end

		if petCfgs[i].passiveSkillId ~= 0 then
			local skillCo = BattleConfig.instance:getSkillCo(petCfgs[i].passiveSkillId)

			if not skillCo then
				self:_printPetSkillIdError(petCfgs[i].passiveSkillId)

				return
			end
		end

		if petCfgs[i].heroSkillId ~= 0 then
			local skillCo = BattleConfig.instance:getSkillCo(petCfgs[i].heroSkillId)

			if not skillCo then
				self:_printPetSkillIdError(petCfgs[i].heroSkillId)

				return
			end
		end

		if petCfgs[i].summonSkillId ~= 0 then
			local skillCo = BattleConfig.instance:getSkillCo(petCfgs[i].summonSkillId)

			if not skillCo then
				self:_printPetSkillIdError(petCfgs[i].summonSkillId)

				return
			end
		end

		if petCfgs[i].circleSkillId ~= 0 then
			local skillCo = BattleConfig.instance:getSkillCo(petCfgs[i].circleSkillId)

			if not skillCo then
				self:_printPetSkillIdError(petCfgs[i].circleSkillId)

				return
			end
		end

		if petCfgs[i].combinationSkillId ~= 0 then
			local skillCo = BattleConfig.instance:getSkillCo(petCfgs[i].combinationSkillId)

			if not skillCo then
				self:_printPetSkillIdError(petCfgs[i].combinationSkillId)

				return
			end
		end

		if CharacterConfig.instance:getSkillInfoById(petCfgs[i].skinId) == nil then
			printError("在精灵基础信息表中 的 export_技能升级 sheet 中找不到 配置 出错 皮肤ID：" .. petCfgs[i].skinId)
		end
	end
end

function ConfigurationChecker:_printPetSkillIdError(id)
	printError("技能ID=" .. id .. "   在精灵表里面有引用，但是没有配置在战斗技能表")
end

function ConfigurationChecker:_checkPetSkins()
	local petSkinCfg = PetSkinConfig.instance.pet_skin_cfg.dataList
	local invalidSkils

	for i = 1, #petSkinCfg do
		if petSkinCfg[i].isHide ~= 1 then
			local modelCo = CharacterConfig.instance:getModelCo(petSkinCfg[i].skinId)

			if not modelCo then
				invalidSkils = invalidSkils or {}

				table.insert(invalidSkils, "精灵皮肤没隐藏,ID=" .. petSkinCfg[i].skinId .. "在精灵皮肤表里面有引用，但是没模型配置表【没有配置】,请提示策划隐藏")
			else
				if string.nilorempty(modelCo.resName) then
					invalidSkils = invalidSkils or {}

					table.insert(invalidSkils, "精灵皮肤没隐藏,ID=" .. petSkinCfg[i].skinId .. "模型配置表【没有配置】战斗态资源(resName),请提示策划隐藏")
				else
					local resName = modelCo.resName
					local dic = GameUrl._handleSpineDic(resName)
					local resPath = string.format("character/%s/%s_p.prefab", dic, resName)

					if not GoUtil.IsAssetExist(resPath) then
						invalidSkils = invalidSkils or {}

						table.insert(invalidSkils, "精灵皮肤,ID=" .. petSkinCfg[i].skinId .. "模型配置表id" .. modelCo.id .. "战斗态【美术资源】(resName)不存在:" .. resPath)
					end
				end

				if string.nilorempty(modelCo.bustName) then
					-- block empty
				else
					local resName = modelCo.bustName
					local dic = GameUrl._handleSpineDic(resName)
					local resPath = string.format("lihui_spine/%s/%s_p.prefab", dic, resName)

					if not GoUtil.IsAssetExist(resPath) then
						invalidSkils = invalidSkils or {}

						table.insert(invalidSkils, "精灵皮肤,ID=" .. petSkinCfg[i].skinId .. "模型配置表id" .. modelCo.id .. "立绘【美术资源】(bustName)不存在:" .. resPath)
					end
				end
			end
		end
	end

	if invalidSkils then
		for i = 1, #invalidSkils do
			printError(invalidSkils[i])
		end
	end
end

function ConfigurationChecker:_checkPayshopTime()
	local cfgs = PayShopConfig.instance:getPayShopMibaoCfgs()

	if cfgs and cfgs.dataList then
		local maxTime = GameUtil.date2time(2030, 1, 1, 0, 0, 0)

		for i, v in ipairs(cfgs.dataList) do
			if not string.nilorempty(v.onlineTime) then
				local time = GameUtil.string2time(v.onlineTime)

				if not time or maxTime <= time then
					printError("秘宝-时间配置太长了，限制2030年之前，当前onlineTime：", v.onlineTime, "  秘宝id:", v.id)
				end
			end

			if not string.nilorempty(v.offlineTime) then
				local time = GameUtil.string2time(v.offlineTime)

				if not time or maxTime <= time then
					printError("秘宝-时间配置太长了，限制2030年之前，当前offlineTime：", v.offlineTime, "  秘宝id:", v.id)
				end
			end
		end
	end
end

function ConfigurationChecker:_checkChatBubble()
	if not Framework.OSDef.isEditor then
		return
	end
end

function ConfigurationChecker:_checkItemUse()
	if not Framework.OSDef.isEditor then
		return
	end

	local itemList = ItemConfig.instance._itemCfg.dataList

	for i, item in ipairs(itemList) do
		if item.useType == 1 then
			local cfg = MaterialConfig.instance:getCfgByMatAndId(4, item.id)

			if cfg then
				-- block empty
			else
				local subType = item.subType

				if subType == MatType.Item_ConsumeLottery then
					-- block empty
				elseif subType == MatType.Item_Flower then
					-- block empty
				else
					printError(">>>> 物品使用表里面 没有 配置。 跑前端自定义使用  但还是没指定功能 ！！", 4, item.id)
				end
			end
		end
	end
end

function ConfigurationChecker:_checkBeastRichMan()
	local dataList = BeastRichmanConfig.instance._beast_rich_man_grid.dataList

	for i, v in ipairs(dataList) do
		if v.gridType == BeastRichManEnum.CellType.StorySelect or v.gridType == BeastRichManEnum.CellType.StoryPlay then
			local storyId = checknumber(v.gridParam)
			local storyCfg = BeastRichmanConfig.instance:getStoryCfgById(v.activityId, storyId)

			if v.gridType == BeastRichManEnum.CellType.StorySelect and storyCfg.type ~= BeastRichManEnum.StoryType.Select then
				printError(string.format("瑞兽 export_路径配置：actId:%s zoneId:%s gridId:%s 格子配了选择，但是剧情表里面不是配选择的！！", v.activityId, v.zoneId, v.gridId))
			elseif v.gridType == BeastRichManEnum.CellType.StoryPlay and storyCfg.type ~= BeastRichManEnum.StoryType.Play then
				printError(string.format("瑞兽 export_路径配置：actId:%s zoneId:%s gridId:%s 格子配了播放，但是剧情表里面不是配播放的！！", v.activityId, v.zoneId, v.gridId))
			end
		end
	end
end

ConfigurationChecker.instance = ConfigurationChecker.New()

return ConfigurationChecker
