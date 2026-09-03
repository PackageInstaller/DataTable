-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/BattleDumpBox.lua

local fileExt = ".txt"
local filePre = "dump@"
local fileIndex = filePre .. "Index" .. fileExt

local function converToNumTable(data)
	local result = {}

	for key, value in pairs(data) do
		result[tonumber(key) or key] = value
	end

	return result
end

function startDumpReplay(self, battleDump)
	local battleData = battleDump.battleData
	local battleConfig = battleDump.battleConfig
	local viewConfig = battleDump.viewConfig
	local opData = battleDump.opData
	local outSelf = self
	local battleDelegate = {}
	local isReplay = true

	if battleData.playerData["1"] then
		battleData.playerData = converToNumTable(battleData.playerData)
	end

	if battleData.enemyData["1"] then
		battleData.enemyData = converToNumTable(battleData.enemyData)
	end

	local battleSession = DumpBattleSession:new({
		battleData = battleData,
		battleConfig = battleConfig,
		battleType = battleDump.battleType
	})

	battleSession:buildAll()

	local battleData = battleSession:getPlayersData()
	local battleConfig = battleSession:getBattleConfig()
	local battleSimulator = battleSession:getBattleSimulator()
	local battleLogic = battleSimulator:getBattleLogic()
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleSimulator(battleSimulator)
	battleDirector:setBattleInterpreter(battleInterpreter)
	battleDirector:setOpData(opData)

	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter
	}

	logicInfo.mainPlayerId = battleDump.mainPlayerId

	function battleDelegate:onLeavingBattle()
		BattleLoader:popBattleView(outSelf)
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.opt == BattlePauseResponse.kLeave then
				leaveCallback()
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		BattleLoader:popBattleView(outSelf)
	end

	function battleDelegate:onBattleFinish(result)
		local summary = battleSession:getResultSummary()

		Bdump("dumpStatist:{}", summary)
		BattleLoader:popBattleView(outSelf)
	end

	function battleDelegate:onDevWin()
		BattleLoader:popBattleView(outSelf)
	end

	viewConfig.btnsShow = {
		speed = {
			visible = false
		},
		skip = {
			visible = false
		},
		auto = {
			visible = false
		},
		pause = {
			visible = true
		},
		restraint = {
			visible = false
		}
	}

	local data = {
		battleType = battleSession:getBattleType(),
		battleData = battleData,
		battleConfig = battleConfig,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate,
		viewConfig = viewConfig,
		loadingType = LoadingType.KArena
	}

	viewConfig.refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content
	viewConfig.battleSuppress = BattleDataHelper:getBattleSuppress()

	BattleLoader:pushBattleView(self, data)
end

SaveBattleDumpBox = class("SaveBattleDumpBox", DebugViewTemplate, _M)

function SaveBattleDumpBox:initialize()
	self._viewConfig = {
		{
			name = "result",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "",
			_selectBoxAutoHide = false,
			selectHandler = function(selectStr)
				local ret = {}

				table.insert(ret, {
					"1",
					"保存至默认路径"
				})
				table.insert(ret, {
					"2",
					"复制dump至剪贴板"
				})

				return ret
			end
		}
	}
end

function SaveBattleDumpBox:onClick(data)
	local function defaultCallback(result, data)
		if result then
			local cjson = require("cjson.safe")

			dump({
				data
			}, "SaveBattleDumpBox:onClick")

			local dumpString = cjson.encode(data)
			local fileName = filePre .. os.date("%Y_%m_%d@%H_%M_%S") .. fileExt

			if not GameConfigs.recordSavedPath then
				local path = device.writablePath
				local filePath = path .. fileName
				local file = io.open(filePath, "w")

				if file == nil then
					cclogf("打开/创建文件失败。可能目录不存在，或者没有写入权限。文件路径：%s", filePath)

					if path == device.writablePath then
						return
					end

					path = device.writablePath
					filePath = device.writablePath .. fileName

					cclogf("尝试写入到默认路径：%s", device.writablePath .. fileName)

					file = io.open(filePath, "w")

					if file == nil then
						cclogf("打开/创建文件失败！")
						self:dispatch(ShowTipEvent({
							tip = "打开/创建文件失败！"
						}))

						return
					end
				end

				file:write(dumpString)
				file:close()

				local indexPath = path .. fileIndex

				if not io.exists(indexPath) then
					file = io.open(indexPath, "w")

					file:close()
				end

				file = io.open(indexPath, "a+")

				file:write(filePath .. "\n")
				file:close()
				cclog("战斗DUMP已保存到文件: " .. filePath)
				self:dispatch(ShowTipEvent({
					tip = "战斗DUMP已保存到文件: " .. filePath
				}))
			end
		else
			self:dispatch(ShowTipEvent({
				tip = data
			}))
		end
	end

	local mText = self._viewConfig[1].mtext

	dump({
		mText
	}, "asdfasdfasdfa")

	if tostring(mText) == "2" then
		local function callback(result, data)
			dump({}, "callback1111111")

			if result then
				local cjson = require("cjson.safe")

				dump({
					data
				}, "SaveBattleDumpBox:onClick")

				local dumpString = cjson.encode(data)

				if app.getDevice and app.getDevice() then
					app.getDevice():copyStringToClipboard(dumpString)
					self:dispatch(ShowTipEvent({
						tip = "dump已复制至剪贴板"
					}))
				else
					self:dispatch(ShowTipEvent({
						tip = "设备不支持复制至剪贴板"
					}))
				end
			end
		end

		dump({}, "callback2222222")
		self:dispatch(Event:new("DEBUG_EVT_SAVE_BATTLE_DUMP", callback))
	else
		self:dispatch(Event:new("DEBUG_EVT_SAVE_BATTLE_DUMP", defaultCallback))
	end
end

ClearBattleDumpBox = class("ClearBattleDumpBox", DebugViewTemplate, _M)

function ClearBattleDumpBox:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function ClearBattleDumpBox:onClick(data)
	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local indexPath = path .. fileIndex

		if not io.exists(indexPath) then
			return
		end

		local f = io.open(indexPath, "r")

		for i in f:lines() do
			if io.exists(i) then
				os.remove(i)
			end
		end

		os.remove(indexPath)
		cclog("成功清除战斗DUMP缓存")
		self:dispatch(ShowTipEvent({
			tip = "成功清除战斗DUMP缓存"
		}))
	end
end

ReplayBattleDumpFileBox = class("ReplayBattleDumpFileBox", DebugViewTemplate, _M)

function ReplayBattleDumpFileBox:initialize()
	self._dynamic = true
	self._viewConfig = {
		{
			default = "1",
			name = "FileIndex",
			title = "输入文件名",
			type = "Input"
		}
	}

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local indexPath = path .. fileIndex

		if not io.exists(indexPath) then
			return
		end

		local f = io.open(indexPath, "r")
		local count = 0

		for i in f:lines() do
			if io.exists(i) then
				count = count + 1

				local pos, posend = string.find(i, filePre, nil, nil, 1)
				local fileName = string.sub(i, posend + 1)

				self._viewConfig[#self._viewConfig + 1] = {
					type = "Label",
					name = i,
					title = count .. " " .. fileName
				}
			end
		end
	end
end

function ReplayBattleDumpFileBox:onClick(data)
	local index = tonumber(data.FileIndex)

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local fileName

		if index then
			local indexPath = path .. fileIndex

			if not io.exists(indexPath) then
				self:dispatch(ShowTipEvent({
					tip = "索引文件不存在"
				}))

				return
			end

			local f = io.open(indexPath, "r")
			local count = 0

			for i in f:lines() do
				if io.exists(i) then
					count = count + 1

					if index == count then
						fileName = i

						break
					end
				end
			end
		else
			fileName = path .. data.FileIndex .. fileExt
		end

		if io.exists(fileName) then
			local file = io.open(fileName, "r")
			local content = file:read("*a")
			local cjson = require("cjson.safe")
			local battleDump = cjson.decode(content)

			startDumpReplay(self, battleDump)
		else
			self:dispatch(ShowTipEvent({
				tip = "文件不存在"
			}))
		end
	end
end

UploadBattleDumpBox = class("UploadBattleDumpBox", DebugViewTemplate, _M)

function UploadBattleDumpBox:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function UploadBattleDumpBox:onClick(data)
	local function callback(result, data)
		if result then
			local cjson = require("cjson.safe")
			local dumpString = cjson.encode(data)
			local shortName = os.date("%Y_%m_%d@%H_%M_%S") .. fileExt

			StatisticSystem:uploadBattleDump("uploadBattleDump", dumpString, function(response)
				self:dispatch(ShowTipEvent({
					tip = response
				}))
			end)
		else
			self:dispatch(ShowTipEvent({
				tip = data
			}))
		end
	end

	self:dispatch(Event:new("DEBUG_EVT_SAVE_BATTLE_DUMP", callback))
end

UploadBattleDumpFileBox = class("UploadBattleDumpFileBox", DebugViewTemplate, _M)

function UploadBattleDumpFileBox:initialize()
	self._dynamic = true
	self._viewConfig = {
		{
			default = "1",
			name = "FileIndex",
			title = "输入文件名",
			type = "Input"
		}
	}

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local indexPath = path .. fileIndex

		if not io.exists(indexPath) then
			return
		end

		local f = io.open(indexPath, "r")
		local count = 0

		for i in f:lines() do
			if io.exists(i) then
				count = count + 1

				local pos, posend = string.find(i, filePre, nil, nil, 1)
				local fileName = string.sub(i, posend + 1)

				self._viewConfig[#self._viewConfig + 1] = {
					type = "Label",
					name = i,
					title = count .. " " .. fileName
				}
			end
		end
	end
end

function UploadBattleDumpFileBox:onClick(data)
	local index = tonumber(data.FileIndex)

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local fileName, shortName

		if index then
			local indexPath = path .. fileIndex

			if not io.exists(indexPath) then
				self:dispatch(ShowTipEvent({
					tip = "索引文件不存在"
				}))

				return
			end

			local f = io.open(indexPath, "r")
			local count = 0

			for i in f:lines() do
				if io.exists(i) then
					count = count + 1

					if index == count then
						fileName = i

						break
					end
				end
			end

			local pos, posend = string.find(fileName, filePre, nil, nil, 1)

			shortName = string.sub(fileName, posend + 1)
		else
			fileName = path .. data.FileIndex .. fileExt
			shortName = data.FileIndex .. fileExt
		end

		if io.exists(fileName) then
			local file = io.open(fileName, "r")
			local battleDumpString = file:read("*a")
			local var_24_1 = {
				type = "battleDump",
				url = "192.168.0.186/saveLog.php",
				content = battleDumpString,
				key = shortName
			}

			var_24_1.rid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()

			CommonUtils.uploadData(var_24_1, function(response)
				self:dispatch(ShowTipEvent({
					tip = response
				}))
			end)
		else
			self:dispatch(ShowTipEvent({
				tip = "文件不存在"
			}))
		end
	end
end

ReplayBattleDumpPhpBox = class("ReplayBattleDumpPhpBox", DebugViewTemplate, _M)

function ReplayBattleDumpPhpBox:initialize()
	self._viewConfig = {
		{
			default = "1",
			name = "FileIndex",
			title = "目前文件名无处获取，待以后完善",
			type = "Input"
		}
	}
end

function ReplayBattleDumpPhpBox:onClick(data)
	local shortName = data.FileIndex .. fileExt
	local var_27_0 = {
		type = "battleDump",
		url = "http:192.168.1.73/getLog.php",
		key = shortName
	}

	var_27_0.rid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()

	CommonUtils.getData(var_27_0, function(response)
		if response and response ~= "" then
			local cjson = require("cjson.safe")
			local battleDump = cjson.decode(response)

			startDumpReplay(self, battleDump)
		end
	end)
end

ReplayBattleCheckResultBox = class("ReplayBattleCheckResultBox", DebugViewTemplate, _M)

function ReplayBattleCheckResultBox:initialize()
	self._viewConfig = {
		{
			default = "fail",
			name = "FileName",
			title = "目前文件名无处获取，待以后完善",
			type = "Input"
		}
	}
end

function ReplayBattleCheckResultBox:onClick(data)
	local name = tostring(data.FileName)

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local fileName = path .. name .. ".log"

		if io.exists(fileName) then
			local file = io.open(fileName, "r")
			local content = file:read("*a")
			local cjson = require("cjson.safe")
			local logs = cjson.decode(content)

			if logs == nil then
				content = string.gsub(content, "\"[^\"]*\":%s*nil,", "")
				content = string.gsub(content, ",\"[^\"]*\":%s*nil}", "}")
				content = string.gsub(content, "\\\\", "\\")
				logs = cjson.decode(content)
				logs = logs.response
			end

			Bdump(logs.battleInput.playerData)
			Bdump(logs.clientResult.opData)
			Bdump(logs.clientResult.statist)

			local args = logs.battleInput
			local pointId = args.pointId
			local playerData = args.playerData
			local randomSeed = args.randomSeed
			local playerId = playerData.rid
			local battleData = StageBattleLauncher:buildBattleData(pointId, playerData, randomSeed)
			local battleConfig = StageBattleLauncher:genBattleConfigAndData(battleData, pointId, randomSeed)
			local pointConfig = ConfigReader:getRecordById("BlockPoint", pointId)

			if not pointConfig.Background then
				local var_30_1 = {
					battleData = battleData,
					mainPlayerId = {
						playerId
					},
					battleConfig = battleConfig
				}
				local var_30_2 = {
					opPanelRes = "asset/ui/BattleUILayer.csb",
					canChangeSpeedLevel = true,
					opPanelClazz = "BattleUIMediator",
					mainView = "battlePlayer",
					finalHitType = pointConfig.PointType,
					background = pointConfig.Background
				}

				var_30_2.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
				var_30_2.btnsShow = {
					speed = {
						visible = false
					},
					skip = {
						visible = false
					},
					auto = {
						visible = true,
						state = isAuto
					},
					pause = {
						visible = true
					}
				}
				var_30_1.viewConfig = var_30_2
				var_30_1.opData = logs.clientResult.opData

				local battleDump = var_30_1

				startDumpReplay(self, battleDump)
			end
		else
			self:dispatch(ShowTipEvent({
				tip = "文件不存在"
			}))
		end
	end
end

ReplayBCFailClientDumpBox = class("ReplayBCFailClientDumpBox", DebugViewTemplate, _M)

function ReplayBCFailClientDumpBox:initialize()
	self._viewConfig = {
		{
			default = "fail",
			name = "FileName",
			title = "目前文件名无处获取，待以后完善",
			type = "Input"
		}
	}
end

function ReplayBCFailClientDumpBox:onClick(data)
	local name = tostring(data.FileName)

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local fileName = path .. name .. ".log"

		if io.exists(fileName) then
			local file = io.open(fileName, "r")
			local content = file:read("*a")
			local cjson = require("cjson.safe")
			local logs = cjson.decode(content)

			if logs == nil then
				content = string.gsub(content, "\"[^\"]*\":%s*nil,", "")
				content = string.gsub(content, ",\"[^\"]*\":%s*nil}", "}")
				content = string.gsub(content, "\\\\", "\\")
				logs = cjson.decode(content)
			end

			Bdump("clientStatist:", logs.response.clientResult.statist)
			Bdump("serverStatist:", logs.response.serverResult.statist)

			local battleDump = logs.battleDump

			startDumpReplay(self, battleDump)
		else
			self:dispatch(ShowTipEvent({
				tip = "文件不存在"
			}))
		end
	end
end

CompareDataBattleCheckResultBox = class("CompareDataBattleCheckResultBox", DebugViewTemplate, _M)

function CompareDataBattleCheckResultBox:initialize()
	self._viewConfig = {
		{
			default = "fail",
			name = "FileName",
			title = "目前文件名无处获取，待以后完善",
			type = "Input"
		}
	}
end

local function Compare(data1, data2, path)
	if type(data1) ~= "table" or type(data2) ~= "table" then
		if data1 ~= data2 then
			print("Failed! path:", path)
			print("data1", data1)
			print("data2", data2)
		end
	else
		for k, v in pairs(data1) do
			Compare(v, data2[k], path .. "." .. k)
		end
	end
end

function CompareDataBattleCheckResultBox:onClick(data)
	local name = tostring(data.FileName)

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local fileName = path .. name .. ".log"

		if io.exists(fileName) then
			local file = io.open(fileName, "r")
			local content = file:read("*a")
			local cjson = require("cjson.safe")
			local logs = cjson.decode(content)

			if logs == nil then
				content = string.gsub(content, "\"[^\"]*\":%s*nil,", "")
				content = string.gsub(content, ",\"[^\"]*\":%s*nil}", "}")
				content = string.gsub(content, "\\\\", "\\")
				logs = cjson.decode(content)
			end

			local dumpBattleData = logs.battleDump.battleData
			local dumpBattleConfig = logs.battleDump.battleConfig
			local args = logs.response.battleInput
			local pointId = args.pointId
			local playerData = args.playerData
			local randomSeed = args.randomSeed
			local battleData = StageBattleLauncher:buildBattleData(pointId, playerData, randomSeed)
			local battleConfig = StageBattleLauncher:genBattleConfigAndData(battleData, pointId, randomSeed)

			Compare(dumpBattleData, battleData, "data")
			Compare(dumpBattleConfig, battleConfig, "battelConfig")
		else
			self:dispatch(ShowTipEvent({
				tip = "文件不存在"
			}))
		end
	end
end

CustomBattle = class("CustomBattle", DebugViewTemplate, _M)

CustomBattle:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

function CustomBattle:initialize()
	self._viewConfig = {
		{
			title = "自定义英雄战斗配置",
			name = "FileName",
			type = "Label"
		}
	}
end

function CustomBattle:onClick(data)
	local keys = {
		"Speed",
		"StarId",
		"Cost",
		"MasterRage",
		"AttackFactor",
		"DefenceFactor",
		"HpFactor",
		"AtkRate",
		"DefRate",
		"DefWeaken",
		"AtkWeaken",
		"CritRate",
		"UncritRate",
		"CritStrg",
		"BlockRate",
		"UnblockRate",
		"BlockStrg",
		"HurtRate",
		"UnhurtRate",
		"Absorption",
		"Reflection",
		"EffectRate",
		"UneffectRate",
		"EffectStrg",
		"BeCuredRate",
		"UndeadRate",
		"DoubleRate",
		"CounterRate",
		"SkillRate",
		"Flags",
		BaseHp = "hp",
		BaseAttack = "atk",
		BaseStar = "star",
		Type = "genre",
		RoleModel = "modelId",
		Rareity = "rarity",
		Anger = "angerRules",
		BaseDefence = "def"
	}

	local function readConfig(configId, tableName, isMaster, index)
		local ret = {}
		local cfg = {}
		local srcCfg = ConfigReader:getRecordById(tableName, configId)

		assert(srcCfg ~= nil, "表" .. tableName .. "没有id为" .. configId .. "的数据")
		table.deepcopy(srcCfg, cfg)

		for k, v in pairs(keys) do
			if type(k) == "string" then
				ret[v] = cfg[k]
			else
				ret[string.lower(v)] = cfg[v]
			end
		end

		if isMaster then
			ret.id = "m-" .. configId .. "-" .. index or "h-" .. configId .. "-" .. index
		end

		if cfg.SurfaceList then
			ret.surfaceId = cfg.SurfaceList[1] or "Surface_ZTXChang_1"
		end

		ret.combat = 1000
		ret.level = 1
		ret.maxHp = cfg.BaseHp
		ret.skills = not isMaster and {
			normal = {
				level = 1,
				skillId = cfg.NormalSkill
			},
			proud = {
				level = 1,
				skillId = cfg.ProudSkill
			},
			unique = {
				level = 1,
				skillId = cfg.UniqueSkill
			},
			passive = {
				level = 1,
				skillId = cfg.BattlePassiveSkill
			}
		} or {
			normal = {
				level = 1,
				skillId = cfg.AttackSkill
			}
		}

		return ret
	end

	local function fillCards(cardPool, heroCards)
		for k, v in pairs(cardPool) do
			local heroCfg = readConfig(v.configId, "HeroBase", false, k)

			for subk, subv in pairs(v) do
				heroCfg[subk] = subv
			end

			local cfg = {
				id = heroCfg.id,
				hero = heroCfg,
				cost = heroCfg.cost
			}

			table.insert(heroCards, cfg)
		end
	end

	local function fillHeros(heroPool, heros)
		local idx = 1

		for k, v in pairs(heroPool) do
			local heroCfg = readConfig(v.configId, "HeroBase", false, idx)

			for subk, subv in pairs(v) do
				heroCfg[subk] = subv
			end

			heros[tostring(idx)] = heroCfg
			idx = idx + 1
		end
	end

	local function genMaster(master)
		local cfg = readConfig(master.configId, "MasterBase", true, 1)

		for subk, subv in pairs(master) do
			cfg[subk] = subv
		end

		return cfg
	end

	local fakeData = require(GameConfigs.recordSavedPath .. "/fakeData")
	local master = {}
	local enemyMaster = {}
	local cardsA = {}
	local cardsB = {}
	local herosA = {}
	local herosB = {}

	master = genMaster(fakeData:getMasterData())
	enemyMaster = genMaster(fakeData:getEnemyMasterData())

	fillCards(fakeData:getCardPoolA(), cardsA)
	fillCards(fakeData:getCardPoolB(), cardsB)
	fillHeros(fakeData:getHeroPoolA(), herosA)
	fillHeros(fakeData:getHeroPoolB(), herosB)

	local playerData = {
		initiative = 100,
		headImg = "Head_Master_XueZhan",
		rid = "123411_105",
		nickname = "队长12345",
		combat = 1000,
		energy = {
			capacity = 30,
			base = 20
		},
		master = master,
		heros = herosA,
		cards = cardsA
	}
	local enemyData = {
		initiative = 100,
		headImg = "Head_Master_XueZhan",
		rid = "54321_105",
		nickname = "队长54321",
		combat = 1000,
		energy = {
			capacity = 30,
			base = 20
		},
		master = enemyMaster,
		heros = herosB,
		cards = cardsB
	}

	dump({
		playerData
	}, "fakeData playerData-----------------------")
	dump({
		enemyData
	}, "fakeData enemyData--------------------")

	local logicSeed = fakeData:getLogicSeed()
	local battleType = SettingBattleTypes.kNormalStage
	local battleSession = FakeBattleSession:new({
		logicSeed = 23,
		playerData = playerData,
		enemyData = enemyData,
		battleType = battleType
	})

	battleSession:buildAll({
		noAutoStrategies = true
	})

	local battleData = battleSession:getPlayersData()
	local battleConfig = battleSession:getBattleConfig()
	local battleSimulator = battleSession:getBattleSimulator()
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleSimulator(battleSimulator)
	battleDirector:setBattleInterpreter(battleInterpreter)

	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			playerData.rid
		}
	}
	local outSelf = self
	local battleDelegate = {}
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local this = self

	local function battleOver()
		BattleLoader:popBattleView(this, {
			response = AlertResponse.kClose
		})
	end

	function battleDelegate:onLeavingBattle()
		battleOver()
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.opt == BattlePauseResponse.kLeave then
				leaveCallback()
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		battleOver()
	end

	function battleDelegate:onBattleFinish(result)
		battleOver()
	end

	function battleDelegate:onDevWin()
		self:onBattleFinish()
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, nil, timeScale)
	end

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_PetRace", "content")
	local var_37_0 = {
		isReplay = false,
		battleType = battleSession:getBattleType(),
		battleData = battleData,
		battleConfig = battleConfig,
		logicInfo = logicInfo,
		delegate = battleDelegate
	}
	local var_37_1 = {
		mainView = "battlePlayer",
		canChangeSpeedLevel = true,
		opPanelRes = "asset/ui/BattleUILayer.csb",
		opPanelClazz = "BattleUIMediator",
		background = "Battle_Scene_27",
		bgm = BGM,
		refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
		battleSuppress = BattleDataHelper:getBattleSuppress()
	}

	var_37_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
	var_37_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
	var_37_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")

	local var_37_2 = {
		speed = {
			visible = false
		},
		skip = {
			visible = false
		}
	}
	local var_37_3 = {
		enable = false
	}

	var_37_3.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
	var_37_3.lock = not systemKeeper:isUnlock("AutoFight")
	var_37_2.auto = var_37_3
	var_37_2.pause = {
		visible = true
	}

	local var_37_4 = {}

	var_37_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
	var_37_4.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
	var_37_2.restraint = var_37_4
	var_37_1.btnsShow = var_37_2
	var_37_0.viewConfig = var_37_1
	var_37_0.loadingType = LoadingType.KArena

	local data = var_37_0

	BattleLoader:pushBattleView(self, data)
end
