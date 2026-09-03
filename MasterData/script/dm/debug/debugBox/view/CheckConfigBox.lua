-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/CheckConfigBox.lua

CheckConfigBox = class("CheckConfigBox", DebugViewTemplate, _M)

function CheckConfigBox:initialize()
	self._viewConfig = {
		{
			default = "",
			name = "Table",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "表名",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local tableNames = {
					"AchievementBase",
					"HeroLove",
					"PansLabTalent",
					"AchievementTask",
					"HeroQuality",
					"Pay",
					"Activity",
					"HeroRelation",
					"PlayerHeadFrame",
					"ActivityBanner",
					"HeroSoul",
					"PlayerHeadModel",
					"ActivityBlockEgg",
					"HeroStarEffect",
					"PlayerHeroATK",
					"ActivityBlockMap",
					"HeroStoryMap",
					"PlayerPlace",
					"ActivityBlockPoint",
					"HeroStoryPoint",
					"RankList",
					"ActivityExchange",
					"HeroTypeAttr",
					"RankOrder",
					"ActivityStoryPoint",
					"HerosLegendBase",
					"RankReward",
					"ActivitySupport",
					"HomeBackground",
					"Reset",
					"ActivitySupportHero",
					"ItemConfig",
					"ResourcesIcon",
					"ActivityTask",
					"ItemResource",
					"Reward",
					"Announce",
					"LevelConfig",
					"RobotConfig",
					"ArenaRank",
					"Loading",
					"RoleModel",
					"ArenaSeason",
					"Mail",
					"ShakeScreen",
					"BackGroundPicture",
					"Mall",
					"ShareConfig",
					"BattleGroundEffect",
					"MapAuto",
					"Shop",
					"BattlePVPBuff",
					"MapBattlePoint",
					"ShopRecommend",
					"BattleSuppress",
					"MapCase",
					"ShopReset",
					"BlockAI",
					"MapCaseEndAction",
					"ShopSurface",
					"BlockBattle",
					"MapCaseFactor",
					"Skill",
					"BlockChallenge",
					"MapItem",
					"SkillAnima",
					"BlockMap",
					"MapMechanismValue",
					"SkillAttrEffect",
					"BlockPoint",
					"MapObject",
					"SkillMovie",
					"BlockPracticePoint",
					"MapObjectRes",
					"SkillSpecialEffect",
					"BlockSp",
					"MapPoint",
					"SkillVideo",
					"BlockSpPoint",
					"MapTask",
					"Sound",
					"BuffModel",
					"MapType",
					"SoundAISAC",
					"ChatEmoji",
					"MasterAura",
					"SoundBlock",
					"ClubDonation",
					"MasterBase",
					"SpecialPicture",
					"ClubTechnology",
					"MasterCoreAddition",
					"StageEventPoint",
					"ClubTechnologyPoint",
					"MasterCoreBase",
					"StagePracticeGuide",
					"ConditionType",
					"MasterCoreExp",
					"StagePracticeMap",
					"ConfigValue",
					"MasterCoreSuite",
					"StagePracticePoint",
					"CrusadeBuff",
					"MasterEmblemBase",
					"StoryPoint",
					"CrusadeFloor",
					"MasterEmblemQuality",
					"StoryPointLove",
					"CrusadePoint",
					"MasterStarPoint",
					"Summoned",
					"CrusadeWeek",
					"MasterStarRate",
					"Surface",
					"DrawCard",
					"MonthCard",
					"TacticsCard",
					"EnemyCard",
					"MonthCheckIn",
					"TargetPreviewRule",
					"EnemyHero",
					"NameFirst",
					"Task",
					"EnemyMaster",
					"NameLast",
					"TowerBase",
					"ExpConsume",
					"NameMiddle",
					"TowerEnemy",
					"ForbiddenChat",
					"NameRobot",
					"TowerMaster",
					"ForbiddenIp",
					"Option",
					"TowerPoint",
					"ForbiddenName",
					"OptionLib",
					"Translate",
					"GalleryHeroInfo",
					"PackageShop",
					"UnlockConditionDraw",
					"GalleryMemory",
					"PansLabAttr",
					"UnlockSystem",
					"GalleryParty",
					"PansLabChapter",
					"VillageBuildingLevel",
					"GalleryPartyReward",
					"PansLabChapterValue",
					"VillageBuildingSurface",
					"GalleryPhoto",
					"PansLabClue",
					"VillageComfort",
					"HeroAwaken",
					"PansLabDPTask",
					"VillageDecorateBuilding",
					"HeroBase",
					"PansLabFightPoint",
					"VillageInteraction",
					"HeroCostAttr",
					"PansLabItem",
					"VillageRoom",
					"HeroEquipAttr",
					"PansLabList",
					"VillageRoomOutward",
					"HeroEquipBase",
					"PansLabOption",
					"VillageSubOre",
					"HeroEquipExp",
					"PansLabOptionInfo",
					"VillageSystemBuilding",
					"HeroEquipStar",
					"PansLabOptionUnlock",
					"Vip",
					"HeroExp",
					"PansLabStoryPoint",
					"HeroInnerAttrBase",
					"PansLabSuspects"
				}
				local ret = {}

				if string.len(selectStr) > 0 then
					for k, v in pairs(tableNames) do
						local lowerV = v:lower()
						local find = lowerV:find(selectStr:lower())

						if find then
							table.insert(ret, v)
						end
					end
				else
					ret = tableNames
				end

				return ret
			end
		},
		{
			default = "",
			name = "Key",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "列名",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}
				local tableName = self._viewConfig[1].mtext

				if tableName and string.len(tableName) > 0 and not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable(tableName)

					if string.len(selectStr) > 0 and dataTable then
						for k, v in pairs(dataTable.columnNames) do
							local lowerV = v:lower()
							local find = lowerV:find(selectStr:lower())

							if find then
								table.insert(ret, v)
							end
						end
					else
						ret = dataTable and dataTable.columnNames or {}
					end
				end

				return ret
			end
		},
		{
			default = "",
			name = "Id",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "id",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}
				local maxRow = 100
				local tableName = self._viewConfig[1].mtext
				local colName = self._viewConfig[2].mtext

				if tableName and string.len(tableName) > 0 and not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable(tableName)

					if not dataTable then
						return ret
					end

					local idIdx, colNameIdx

					for k, v in pairs(dataTable.columnNames) do
						if v == "Id" and idIdx == nil then
							idIdx = k
						end

						if v == colName and colNameIdx == nil then
							colNameIdx = k
						end
					end

					if colName and string.len(colName) > 0 and string.len(selectStr) > 0 then
						local datas = dataTable.table:getRowsByConditionStr("where Id like \"%" .. selectStr .. "%\";")

						for k, v in pairs(datas) do
							table.insert(ret, {
								v[idIdx],
								v[colNameIdx]
							})
						end
					else
						local count = 0
						local config = ConfigReader:getDataTable(tableName)

						for k, v in pairs(config) do
							local var_4_0 = {
								v.Id
							}

							if colNameIdx ~= nil then
								var_4_0[2] = v[colName] or ""
							end

							table.insert(ret, var_4_0)

							count = count + 1

							if maxRow <= count then
								break
							end
						end
					end
				end

				return ret
			end
		}
	}
end

function CheckConfigBox:onClick(data)
	local tableName = data.Table
	local id = data.Id
	local key = data.Key
	local config = ConfigReader:getDataTable(tableName)

	if not config then
		self:dispatch(ShowTipEvent({
			tip = tableName .. "表不存在"
		}))

		return
	end

	local item = config[id]

	if not item then
		self:dispatch(ShowTipEvent({
			tip = tableName .. "表里没有" .. id .. "项"
		}))

		return
	end

	local value = item[key]

	if not value then
		self:dispatch(ShowTipEvent({
			tip = tableName .. "表" .. id .. "项" .. key .. "列不存在或者为nil"
		}))

		return
	end

	local valueType = type(value)
	local delay = 4

	if valueType == "number" then
		self:dispatch(ShowTipEvent({
			tip = tableName .. "表" .. id .. "项" .. key .. "列为数字,值为" .. value,
			delay = delay
		}))

		return
	elseif valueType == "string" then
		self:dispatch(ShowTipEvent({
			tip = tableName .. "表" .. id .. "项" .. key .. "列为字符串,值为" .. value,
			delay = delay
		}))

		return
	elseif valueType == "boolean" then
		self:dispatch(ShowTipEvent({
			tip = tableName .. "表" .. id .. "项" .. key .. "列为布尔值,值为" .. value,
			delay = delay
		}))

		return
	else
		local cjson = require("cjson.safe")
		local content = cjson.encode(value)

		self:dispatch(ShowTipEvent({
			tip = tableName .. "表" .. id .. "项" .. key .. "列为table,值为" .. content,
			delay = delay
		}))

		return
	end
end
