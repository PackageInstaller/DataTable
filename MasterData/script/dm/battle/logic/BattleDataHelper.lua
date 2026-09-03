-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleDataHelper.lua

BattleDataHelper = BattleDataHelper or {}

function BattleDataHelper:getIntegralBattleData(data)
	local playerData = data.playerData
	local enemyData = data.enemyData
	local leadStageLevel_l = playerData.master.leadStageLevel
	local leadStageLevel_r = enemyData.master.leadStageLevel
	local leadStageId_l = playerData.master.leadStageId
	local leadStageId_r = enemyData.master.leadStageId

	data.playerData = BattleDataHelper:getIntegralPlayerData(playerData)
	data.enemyData = BattleDataHelper:getIntegralPlayerData(enemyData, true)

	local refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content

	data.playerData.refreshCost = refreshCost
	data.enemyData.refreshCost = refreshCost
	data.playerData.leadStageId = leadStageId_l
	data.enemyData.leadStageId = leadStageId_r
	data.playerData.leadStageLevel = leadStageLevel_l
	data.enemyData.leadStageLevel = leadStageLevel_r

	return data
end

function BattleDataHelper:fillSkillData(skillData, protoFactory, enemyBuff)
	local skillProto = protoFactory:getSkillPrototype(skillData.skillId)
	local integralSkillData = skillProto:getBattleSkillData(skillData.level, enemyBuff)

	if integralSkillData then
		for key, value in pairs(integralSkillData) do
			skillData[key] = value
		end
	end

	return skillData
end

function BattleDataHelper:fillSummonData(summon, skillData, protoFactory, summonMap)
	local summoned = skillData.summoned

	if summoned and #summoned > 0 then
		for _, summonId in ipairs(summoned) do
			local summonData = ConfigReader:getRecordById("Summoned", summonId)

			if summonData and summonMap[summonId] == nil then
				summonMap[summonId] = true

				if not summonData.Flags then
					summonData.Flags[#summonData.Flags + 1] = "SUMMONED"

					if summonData.Type then
						local typeFlags = ConfigReader:getDataByNameIdAndKey("ConfigValue", "TypeFlags", "content")[summonData.Type]

						if typeFlags then
							summonData.Flags[#summonData.Flags + 1] = typeFlags
						end
					end

					local var_3_0 = {
						id = summonId,
						modelId = summonData.RoleModel,
						cost = summonData.Cost,
						skillrate = summonData.SkillRate,
						angerRules = summonData.RageRules,
						anger = summonData.RageBase,
						killAnger = summonData.KillRage,
						masterRage = summonData.MasterRage,
						flags = summonData.Flags,
						genre = summonData.Type,
						extraSurFace = summonData.SummonSurface
					}

					var_3_0.sex = summonData.Sex or 0

					local summonInfo = var_3_0

					summon[#summon + 1] = summonInfo
					summonInfo.skills = {}

					if summonData.NormalSkill and summonData.NormalSkill ~= "" then
						summonInfo.skills.normal = {
							skillId = summonData.NormalSkill,
							level = skillData.level
						}

						self:fillSkillData(summonInfo.skills.normal, protoFactory)
					end

					if summonData.ProudSkill and summonData.ProudSkill ~= "" then
						summonInfo.skills.proud = {
							skillId = summonData.ProudSkill,
							level = skillData.level
						}

						self:fillSkillData(summonInfo.skills.proud, protoFactory)
					end

					if summonData.UniqueSkill and summonData.UniqueSkill ~= "" then
						if string.find(summonData.UniqueSkill, "|") and string.find(summonData.UniqueSkill, "|") > 0 then
							summonInfo.skills.unique = {}

							local uniques = string.split(summonData.UniqueSkill, "|")
							local index = 1

							for k, v in pairs(uniques) do
								if v and v ~= "" then
									summonInfo.skills["master" .. index] = {
										skillId = v,
										level = skillData.level
									}

									self:fillSkillData(summonInfo.skills["master" .. index], protoFactory)
								end

								index = index + 1
							end
						else
							summonInfo.skills.unique = {
								skillId = summonData.UniqueSkill,
								level = skillData.level
							}

							self:fillSkillData(summonInfo.skills.unique, protoFactory)
						end
					end

					if summonData.DoubleSkill and summonData.DoubleSkill ~= "" then
						summonInfo.skills.dblhit = {
							skillId = summonData.DoubleSkill,
							level = skillData.level
						}

						self:fillSkillData(summonInfo.skills.dblhit, protoFactory)
					end

					if summonData.CounterSkill and summonData.CounterSkill ~= "" then
						summonInfo.skills.cntrhit = {
							skillId = summonData.CounterSkill,
							level = skillData.level
						}

						self:fillSkillData(summonInfo.skills.cntrhit, protoFactory)
					end

					if summonData.DeathSkill and summonData.DeathSkill ~= "" then
						summonInfo.skills.death = {
							skillId = summonData.DeathSkill,
							level = skillData.level
						}

						self:fillSkillData(summonInfo.skills.death, protoFactory)
						self:fillSummonData(summon, summonInfo.skills.death, protoFactory, summonMap)
					end

					if summonData.PassiveSkill and type(summonData.PassiveSkill) == "table" then
						summonInfo.skills.passive = {}

						for i, passive in ipairs(summonData.PassiveSkill) do
							summonInfo.skills.passive[i] = {
								skillId = passive,
								level = skillData.level
							}

							self:fillSkillData(summonInfo.skills.passive[i], protoFactory)
							self:fillSummonData(summon, summonInfo.skills.passive[i], protoFactory, summonMap)
						end
					end
				end
			end
		end
	end
end

function BattleDataHelper:fillCardAI(card)
	if card.hero and card.hero.blockAI and card.hero.blockAI ~= "" then
		card.cardAI = ConfigReader:getRecordById("BlockAI", card.hero.blockAI)
	end
end

function BattleDataHelper:getIntegralPlayerData(playerData, isEnemy)
	if playerData == nil then
		return nil
	end

	local master = playerData.master
	local summon = {}
	local summonMap = {}

	playerData.summon = summon

	if master then
		playerData.waves = {
			{
				master = master
			}
		}
		playerData.master = nil

		self:fillMasterData(master, playerData, 1, isEnemy, summon, summonMap)
	end

	local cards = playerData.cards

	if cards then
		for idx, card in ipairs(cards) do
			cards[idx] = self:fillCardData(card, playerData.rid, "c", idx, isEnemy, summon, summonMap)
		end

		playerData.cards = cards
	end

	local extraCards2 = playerData.extraCards2

	if extraCards2 then
		for idx, card in ipairs(extraCards2) do
			extraCards2[idx] = self:fillCardData(card, playerData.rid, "c", idx, isEnemy, summon, summonMap)
		end

		playerData.extraCards2 = extraCards2
	end

	local heros = playerData.heros

	if heros then
		for idx, hero in pairs(heros) do
			self:fillHeroData(hero, playerData.rid, 1, idx + 1, isEnemy, summon, summonMap)
		end

		if playerData.waves then
			playerData.waves[1].heros = heros
		else
			playerData.waves = {
				{
					heros = heros
				}
			}
		end

		playerData.heros = nil
	end

	local waves = playerData.waveData

	if waves then
		playerData.waves = playerData.waves or {}

		for waveIndex, waveData in ipairs(waves) do
			if waveData.master then
				self:fillMasterData(waveData.master, playerData, waveIndex, isEnemy, summon, summonMap)
			end

			if waveData.heros then
				for idx, hero in pairs(waveData.heros) do
					self:fillHeroData(hero, playerData.rid, 1, idx + 1, isEnemy, summon, summonMap)
				end
			end

			if playerData.waves[waveIndex] then
				playerData.waves[waveIndex].heros = waveData.heros
				playerData.waves[waveIndex].master = waveData.maser
			elseif waveData.master or waveData.heros then
				playerData.waves[waveIndex] = {
					master = waveData.maser,
					heros = waveData.heros
				}
			end
		end

		playerData.waveData = nil
	end

	local assist = playerData.assist

	if assist then
		for idx, hero in pairs(assist) do
			self:dealWithSkills(hero.skills, summon, summonMap)

			hero.uid = hero.id
			hero.cid = hero.configId
		end
	end

	self:fillAttackEffect(playerData)

	return playerData
end

function BattleDataHelper:fillAttackEffect(playerData)
	local function attachAttckEffect(target)
		local allkeys = ConfigReader:getKeysOfTable("Surface")

		for k, v in pairs(allkeys) do
			local model = ConfigReader:getDataByNameIdAndKey("Surface", v, "Model")

			if model == target.modelId then
				target.attackEffect = ConfigReader:getDataByNameIdAndKey("Surface", v, "AnimeList")
			end
		end
	end

	for k, v in pairs(playerData.waves or {}) do
		if v.master then
			attachAttckEffect(v.master)
		end

		for k, v in pairs(v.heros or {}) do
			attachAttckEffect(v)
		end
	end

	for k, v in pairs(playerData.cards or {}) do
		attachAttckEffect(v.hero)
	end
end

function BattleDataHelper:dealWithTransform(master, summon, summonMap)
	if master.transform and type(master.transform) == "table" then
		self:dealWithSkills(master.transform.skills, summon, summonMap)

		master.transform.uid = master.transform.id
		master.transform.id = master.id
		master.transform.genre = master.transform.genre and master.transform.genre:sub(1, 1):upper() .. master.transform.genre:sub(2)

		if master.transform.attrs then
			for k, v in pairs(master.transform.attrs) do
				master.transform[k] = master.transform[k] or v
			end

			master.transform.attrs = nil
		end

		self:dealWithTransform(master.transform, summon, summonMap)
	else
		master.transform = nil
	end
end

function BattleDataHelper:dealWithHeroTransform(hero, summon, summonMap)
	if hero.transform and type(hero.transform) == "table" then
		self:dealWithSkills(hero.transform.skills, summon, summonMap)

		hero.transform.uid = hero.transform.id
		hero.transform.id = hero.id
		hero.transform.genre = hero.transform.genre and hero.transform.genre:sub(1, 1):upper() .. hero.transform.genre:sub(2)

		if hero.transform.attrs then
			for k, v in pairs(hero.transform.attrs) do
				hero.transform[k] = hero.transform[k] or v
			end

			hero.transform.attrs = nil
		end

		self:dealWithHeroTransform(hero.transform, summon, summonMap)
	else
		hero.transform = nil
	end
end

function BattleDataHelper:dealWithSkills(skills, summon, summonMap)
	if type(skills) ~= "table" then
		return
	end

	local protoFactory = PrototypeFactory:getInstance()

	for name, config in pairs(skills) do
		if name == "passive" or name == "extrapasv" then
			for i, cfg in ipairs(config) do
				if type(cfg) == "userdata" then
					config[i] = nil
				end
			end

			local ret = {}

			for k, v in pairs(config) do
				ret[#ret + 1] = v
			end

			skills[name] = ret
		end
	end

	for name, config in pairs(skills) do
		if name == "passive" then
			for i, cfg in ipairs(config) do
				self:fillSkillData(cfg, protoFactory)
				self:fillSummonData(summon, cfg, protoFactory, summonMap)
			end
		elseif name == "extrapasv" then
			for i, cfg in ipairs(config) do
				self:fillSkillData(cfg, protoFactory)
				self:fillSummonData(summon, cfg, protoFactory, summonMap)
			end
		else
			self:fillSkillData(config, protoFactory)
			self:fillSummonData(summon, config, protoFactory, summonMap)
		end
	end
end

function BattleDataHelper:fillCardData(card, rid, waveStr, idx, isEnemy, summon, summonMap)
	local hero = card.hero

	card.hero = self:fillHeroData(hero, rid, waveStr, idx, isEnemy, summon, summonMap)

	BattleDataHelper:fillCardAI(card)

	return card
end

function BattleDataHelper:fillHeroData(hero, rid, waveStr, idx, isEnemy, summon, summonMap)
	self:dealWithSkills(hero.skills, summon, summonMap)

	hero.uid = hero.id
	hero.cid = hero.configId
	hero.id = BattleSoleIdProcessor:genUnitId(rid, waveStr, idx, isEnemy, hero.id)

	if hero.attrs then
		for k, v in pairs(hero.attrs) do
			hero[k] = hero[k] or v
		end

		hero.attrs = nil
	end

	hero.genre = hero.genre and hero.genre:sub(1, 1):upper() .. hero.genre:sub(2)

	self:dealWithHeroTransform(hero, summon, summonMap)

	if hero.genre then
		hero.suppress = ConfigReader:getRecordById("BattleSuppress", hero.genre) or {}
	end

	if isEnemy then
		local enemyHero = ConfigReader:getRecordById("EnemyHero", hero.cid)

		hero.surfaceIndex = enemyHero and enemyHero.SurfaceNum and enemyHero.SurfaceNum > 0 and enemyHero.SurfaceNum or 0
		hero.sex = self:getSex("EnemyHero", hero)
	else
		hero.surfaceIndex = self:getSufaceIndex("HeroBase", hero)
		hero.sex = self:getSex("HeroBase", hero)
	end

	hero.sheilUplimit = self:getSheilUpLimit("Shield_UpLimit_Pets")

	return hero
end

function BattleDataHelper:getSex(HeroTag, hero)
	local sex = ConfigReader:getDataByNameIdAndKey(HeroTag, hero.cid, "Sex")

	sex = sex or 0

	return sex
end

function BattleDataHelper:getSheilUpLimit(ruleKey)
	local sheilUp = ConfigReader:getDataByNameIdAndKey("ConfigValue", ruleKey, "content")

	if sheilUp and sheilUp ~= "" then
		return sheilUp
	end

	return nil
end

function BattleDataHelper:getSufaceIndex(HeroTag, hero)
	local surfaceCfg = ConfigReader:getDataByNameIdAndKey(HeroTag, hero.cid, "SurfaceList")
	local sufaces = {}

	for k, v in pairs(surfaceCfg or {}) do
		local model = ConfigReader:getDataByNameIdAndKey("Surface", v, "Model")
		local order = ConfigReader:getDataByNameIdAndKey("Surface", v, "Sort")

		sufaces[#sufaces + 1] = {
			model = model,
			order = order
		}
	end

	table.sort(sufaces, function(a, b)
		return a.order < b.order
	end)

	local surface_index = 0

	for k, v in pairs(sufaces) do
		if v.model == hero.modelId then
			surface_index = k - 1
		end
	end

	return surface_index
end

function BattleDataHelper:fillMasterData(master, playerData, waveStr, isEnemy, summon, summonMap)
	self:dealWithSkills(master.skills, summon, summonMap)

	master.uid = master.id
	master.cid = master.configId
	master.id = BattleSoleIdProcessor:genUnitId(playerData.rid, 1, 1, isEnemy, master.id)

	if master.tactics then
		local tactics = {}
		local protoFactory = PrototypeFactory:getInstance()

		for idx, tactic in ipairs(master.tactics) do
			local config = ConfigReader:getRecordById("TacticsCard", tactic)
			local data = {
				id = tactic,
				targetType = config.Type,
				skillPic = config.SkillPic,
				cost = config.SkillCost,
				skill = {
					level = 1,
					skillId = config.Skill
				},
				weight = config.Weight,
				autoWeight = config.AutoWeight
			}

			self:fillSkillData(data.skill, protoFactory)
			self:fillSummonData(summon, data.skill, protoFactory, summonMap)

			tactics[#tactics + 1] = data
		end

		playerData.tactics = tactics
	end

	if master.extraTactics then
		local tactics = {}
		local protoFactory = PrototypeFactory:getInstance()

		for idx, tactic in ipairs(master.extraTactics) do
			local config = ConfigReader:getRecordById("TacticsCard", tactic)
			local data = {
				id = tactic,
				targetType = config.Type,
				skillPic = config.SkillPic,
				cost = config.SkillCost,
				skill = {
					level = 1,
					skillId = config.Skill
				},
				weight = config.Weight,
				autoWeight = config.AutoWeight
			}

			self:fillSkillData(data.skill, protoFactory)
			self:fillSummonData(summon, data.skill, protoFactory, summonMap)

			tactics[#tactics + 1] = data
		end

		playerData.extraTactics = tactics
	end

	self:dealWithTransform(master, summon, summonMap)

	if master.attrs then
		for k, v in pairs(master.attrs) do
			master[k] = master[k] or v
		end

		master.attrs = nil
	end

	master.genre = master.genre and master.genre:sub(1, 1):upper() .. master.genre:sub(2)

	if master.genre then
		master.suppress = ConfigReader:getRecordById("BattleSuppress", master.genre) or {}
	end

	if isEnemy then
		local enemyMaster = ConfigReader:getRecordById("EnemyMaster", master.cid)

		master.surfaceIndex = enemyMaster and enemyMaster.SurfaceNum and enemyMaster.SurfaceNum > 0 and enemyMaster.SurfaceNum or 0
		master.sex = self:getSex("EnemyMaster", master)
	else
		master.surfaceIndex = self:getSufaceIndex("MasterBase", master)
		master.sex = self:getSex("MasterBase", master)
	end

	if master.leadStageId and master.leadStageId ~= "" then
		local data = ConfigReader:getRecordById("MasterLeadStage", master.leadStageId)

		master.modelId = data.ModelId
	end

	master.sheilUplimit = self:getSheilUpLimit("Shield_UpLimit_Master")
end

local function deepCopy(desc, src)
	local d = desc or {}

	for k, v in pairs(src) do
		d[k] = type(v) == "table" and deepCopy({}, v) or v
	end

	return d
end

function BattleDataHelper:addExtraPasvSkill(unit, skill, enemyBuff)
	local protoFactory = PrototypeFactory:getInstance()

	unit.skills.extrapasv = unit.skills.extrapasv or {}
	unit.skills.extrapasv[#unit.skills.extrapasv + 1] = self:fillSkillData(deepCopy({}, skill), protoFactory, enemyBuff)
end

function BattleDataHelper:getStagePassiveSkill(playerData)
	local playerShow = {}

	playerShow.showMasterSkill = true

	if playerData then
		if not playerData.waves then
			do
				local waves = {}

				if not playerData.cards then
					for index, wave in ipairs(playerData.waves) do
						local master = wave.master

						if master then
							if master.skills then
								if not master.skills.passive then
									local masterPassive = {}

									if playerData.skillBuff then
										if not playerData.skillBuff then
											local masterBuffes = {}
											local masterSkill = {}
											local stageBuffes = {}

											if master.leadStageId and master.leadStageId ~= "" then
												local leaderStagePass = ConfigReader:getDataByNameIdAndKey("MasterLeadStage", master.leadStageId, "Skill")

												if leaderStagePass and leaderStagePass.Skill then
													for k, v in pairs(leaderStagePass.Skill) do
														masterSkill[v] = k
													end
												end

												if leaderStagePass and leaderStagePass.Attr then
													for k, v in pairs(leaderStagePass.Attr) do
														stageBuffes[v] = k
													end
												end
											end

											for k, v in pairs(masterBuffes) do
												local buffId = k
												local buffLv = v

												if stageBuffes[buffId] then
													playerShow[#playerShow + 1] = {
														master = true,
														id = buffId,
														lv = buffLv,
														index = #playerShow + 1
													}
												end
											end

											for k, v in pairs(masterPassive) do
												local skillId = v.skillId
												local skillLv = v.level
												local showInbattle = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "ShowInBattle")

												if true and masterSkill[skillId] then
													playerShow[#playerShow + 1] = {
														master = true,
														id = skillId,
														lv = skillLv,
														index = masterSkill[skillId]
													}
												end
											end
										end
									end
								end
							end
						end

						playerShow.leadStageLevel = master.leadStageLevel
						playerShow.leadStageId = master.leadStageId
					end
				end
			end

			if not playerShow or not playerShow.leadStageLevel or playerShow.leadStageLevel <= 0 then
				playerShow = nil
			end

			if not playerShow or not playerShow.leadStageId or playerShow.leadStageId == "" then
				playerShow = nil
			end
		end
	end

	return playerShow
end

function BattleDataHelper:getPassiveSkill(playerData)
	local playerShow = {}

	playerShow.showMasterSkill = true

	if playerData then
		if not playerData.waves then
			if not playerData.cards then
				local cards = {}

				for index, wave in ipairs(playerData.waves) do
					local master = wave.master

					if master then
						if master.skills then
							if not master.skills.passive then
								do
									local masterPassive = {}
									local masterSkill = {}
									local firstSkill

									for _index = 1, 6 do
										local passiveSkill = ConfigReader:getDataByNameIdAndKey("MasterBase", master.configId, "TeamSkill" .. _index)

										if passiveSkill and passiveSkill ~= "" then
											masterSkill[passiveSkill] = _index
											firstSkill = firstSkill or passiveSkill
										end
									end

									for k, v in pairs(masterPassive) do
										local skillId = v.skillId
										local skillLv = v.level
										local showInbattle = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "ShowInBattle")

										if true and masterSkill[skillId] then
											playerShow[#playerShow + 1] = {
												master = true,
												id = skillId,
												lv = skillLv,
												index = masterSkill[skillId]
											}
										end
									end

									if playerShow[1] and playerShow[1].id == nil then
										playerShow[1] = {
											master = true,
											lv = 1,
											lock = true,
											id = firstSkill or "SectSkill_Master_XueZhan_1"
										}
									end
								end

								local heros = wave.heros

								if heros and #heros > 0 then
									for _, hero in pairs(heros) do
										local passiveSkill = ConfigReader:getDataByNameIdAndKey("HeroBase", hero.configId, "BattlePassiveSkill")

										if hero.skills then
											if not hero.skills.passive then
												local heroPassive = {}

												for k, v in pairs(heroPassive) do
													local skillId = v.skillId
													local skillLv = v.level
													local showInbattle = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "ShowInBattle")

													if showInbattle and passiveSkill == skillId then
														playerShow[#playerShow + 1] = {
															id = skillId,
															lv = skillLv
														}
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

				for _, card in pairs(cards) do
					local hero = card.hero
					local passiveSkill = ConfigReader:getDataByNameIdAndKey("HeroBase", hero.configId, "KeyPassiveSkill")

					if hero.skills then
						if not hero.skills.passive then
							local heroPassive = {}

							for k, v in pairs(heroPassive) do
								local skillId = v.skillId
								local skillLv = v.level
								local showInbattle = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "ShowInBattle")

								if showInbattle and passiveSkill == skillId then
									playerShow[#playerShow + 1] = {
										id = skillId,
										lv = skillLv
									}
								end
							end
						end
					end
				end
			end
		end
	end

	return playerShow
end

function BattleDataHelper:getTowerPassiveSkill(playerData)
	local playerShow = {}

	playerShow.showMasterSkill = true

	if playerData then
		if not playerData.waves then
			if not playerData.cards then
				local cards = {}

				for index, wave in ipairs(playerData.waves) do
					local master = wave.master

					if master then
						if master.skills then
							if not master.skills.passive then
								do
									local masterPassive = {}
									local masterSkill = {}
									local firstSkill

									for _index = 1, 6 do
										local passiveSkill = ConfigReader:getDataByNameIdAndKey("TowerMaster", master.configId, "TeamSkill" .. _index)

										if passiveSkill and passiveSkill ~= "" then
											masterSkill[passiveSkill] = _index
											firstSkill = firstSkill or passiveSkill
										end
									end

									for k, v in pairs(masterPassive) do
										local skillId = v.skillId
										local skillLv = v.level
										local showInbattle = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "ShowInBattle")

										if showInbattle and masterSkill[skillId] then
											playerShow[#playerShow + 1] = {
												master = true,
												id = skillId,
												lv = skillLv,
												index = masterSkill[skillId]
											}
										end
									end

									if playerShow[1] and playerShow[1].id == nil then
										playerShow[1] = {
											master = true,
											lv = 1,
											lock = true,
											id = firstSkill or "SectSkill_Master_XueZhan_1"
										}
									end
								end

								local heros = wave.heros

								if heros and #heros > 0 then
									for _, hero in pairs(heros) do
										local passiveSkill = ConfigReader:getDataByNameIdAndKey("HeroBase", hero.configId, "BattlePassiveSkill")

										if hero.skills then
											if not hero.skills.passive then
												local heroPassive = {}

												for k, v in pairs(heroPassive) do
													local skillId = v.skillId
													local skillLv = v.level
													local showInbattle = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "ShowInBattle")

													if showInbattle and passiveSkill == skillId then
														playerShow[#playerShow + 1] = {
															id = skillId,
															lv = skillLv
														}
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

				for _, card in pairs(cards) do
					local hero = card.hero
					local passiveSkill = ConfigReader:getDataByNameIdAndKey("HeroBase", hero.configId, "KeyPassiveSkill")

					if hero.skills then
						if not hero.skills.passive then
							local heroPassive = {}

							for k, v in pairs(heroPassive) do
								local skillId = v.skillId
								local skillLv = v.level
								local showInbattle = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "ShowInBattle")

								if showInbattle and passiveSkill == skillId then
									playerShow[#playerShow + 1] = {
										id = skillId,
										lv = skillLv
									}
								end
							end
						end
					end
				end
			end
		end
	end

	return playerShow
end

function BattleDataHelper:getBattleSuppress()
	local battleSuppress = {}
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSuppress", "content")

	if config then
		for k, v in pairs(config) do
			local info = {}

			info.Sup = {}

			if not v.Sup then
				for kk, vv in pairs(v.Sup) do
					info.Sup[vv] = true
				end

				info.BySup = {}

				if not v.BySup then
					for kk, vv in pairs(v.BySup) do
						info.BySup[vv] = true
					end

					battleSuppress[k] = info
				end
			end
		end
	end

	return battleSuppress
end

function BattleDataHelper:getBattleFinishWaitTime(battleType)
	local specialData = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleStatementDelay_Special", "content")

	if battleType and specialData[battleType] then
		return specialData[battleType]
	end

	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleStatementDelay_Default", "content")
end

function BattleDataHelper:fillEnemyCostData(data)
	if not data or not data.modelId then
		return
	end

	local roleModel = ConfigReader:getRecordById("RoleModel", data.modelId)
	local heroCfg = ConfigReader:getRecordById("HeroBase", roleModel.Model)

	if heroCfg then
		data.heroCost = heroCfg.Cost
	else
		local enemyCfg = ConfigReader:getRecordById("EnemyHero", data.id)

		if enemyCfg then
			data.enemyCost = enemyCfg.EnergyCost
		end

		data.heroCost = -1
	end
end
