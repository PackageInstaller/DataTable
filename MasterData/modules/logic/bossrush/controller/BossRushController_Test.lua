-- chunkname: @modules/logic/bossrush/controller/BossRushController_Test.lua

module("modules.logic.bossrush.controller.BossRushController_Test", package.seeall)

local BossRushController_Test = class("BossRushController_Test", BaseController)
local sMyPrintf = getGlobal("ddd") or SLFramework.SLLogger.Log

function BossRushController_Test:onInit()
	return
end

function BossRushController_Test:_test(inputText)
	if not inputText then
		return
	end

	local prefix = "bossrush"

	if inputText == "bossrush demo" then
		self:_test_demo()

		return
	end

	if inputText == "bossrush red" then
		self:_test_red()

		return
	end

	if inputText == "bossrush red reset" then
		self:_test_red_reset()

		return
	end

	if inputText == "bossrush" then
		BossRushController.instance:openMainView()

		return
	end

	local battleId = tonumber(inputText:sub(#prefix + 1))

	if battleId then
		self:_test_battle_demo(battleId)
	end
end

function BossRushController_Test:_test_demo()
	local stages = BossRushConfig.instance:getStages()
	local infiniteDoubleMaxTimes = BossRushConfig.instance:InfiniteDoubleMaxTimes()
	local activityId = BossRushModel.instance:getActivityId()
	local sTotalPoint = 800000

	local function _make_bossDetail(stage)
		local rewardList = BossRushConfig.instance:getStageRewardList(stage)
		local var_4_0 = {
			bossId = stage
		}

		var_4_0.totalPoint = sTotalPoint or math.random(0, 99999)
		var_4_0.hasGetBonusIds = {}
		var_4_0.highestPoint = math.random(0, 99999)
		var_4_0.doubleNum = math.random(0, infiniteDoubleMaxTimes)

		local res = var_4_0
		local N = 0
		local gotList = {}

		for i, v in ipairs(rewardList) do
			if res.totalPoint >= v.rewardPointNum then
				N = i
				gotList[#gotList + 1] = v.id
			end
		end

		local n = N or math.random(0, N)

		for i = 1, n do
			local id = gotList[i]

			res.hasGetBonusIds[id] = true
		end

		return res
	end

	local function _make_task(id)
		local CO = BossRushConfig.instance:getTaskCO(id)
		local maxFinishCount = CO.maxFinishCount
		local maxProgress = CO.maxProgress
		local finishCount = math.random(0, maxFinishCount)
		local hasFinished = math.random(0, 100) % 2 == 0

		if maxFinishCount <= finishCount then
			hasFinished = false
		end

		local progress = hasFinished and maxProgress or math.random(0, maxProgress)

		return {
			id = id,
			finishCount = finishCount,
			progress = progress,
			hasFinished = hasFinished,
			expiryTime = math.random(1000, 2000),
			type = math.random(1, 2)
		}
	end

	local _activities = {
		[activityId] = {}
	}

	for _, v in pairs(stages) do
		local stage = v.stage

		_activities[activityId][stage] = _make_bossDetail(stage)
	end

	local function _get_bossDetail(stage)
		return tabletool.copy(_activities[activityId][stage])
	end

	local function _get_hasGetBonusIds(stage)
		local hasGetBonusIds = _activities[activityId][stage]
		local res = {}

		for k, _ in pairs(hasGetBonusIds) do
			res[#res + 1] = k
		end

		return res
	end

	local function _make_heroMo(heroId)
		local res = HeroMo.New()
		local config = HeroConfig.instance:getHeroCO(heroId)
		local info = {
			heroId = heroId,
			skin = config.skinId
		}

		res:init(info, config)

		return res
	end

	local function _make_equipMo(equipId)
		local res = EquipMO.New()
		local info = {
			count = 1,
			isLock = false,
			exp = 0,
			uid = math.random(1, 9999999),
			equipId = equipId,
			level = math.random(1, 10),
			breakLv = math.random(1, 2),
			refineLv = math.random(1, 2)
		}

		res:init(info)

		return res
	end

	local function _get_config_id(lua_xxx_config)
		local list = lua_xxx_config.configList
		local idx = math.random(1, #list)

		return list[idx].id
	end

	local resultCode = 0
	local fightParam = FightParam.New()
	local cCtrl = BossRushController
	local cRpc = BossRushRpc
	local cModel = BossRushModel

	function cRpc:sendGet128InfosRequest(callback)
		local msg = {
			activityId = activityId,
			bossDetail = {}
		}

		for _, v in pairs(stages) do
			local stage = v.stage

			table.insert(msg.bossDetail, _get_bossDetail(stage))
		end

		BossRushRpc.instance:onReceiveGet128InfosReply(resultCode, msg)

		if callback then
			callback()
		end
	end

	function cRpc:sendAct128GetTotalRewardsRequest(stage)
		local _bossInfo = _activities[activityId][stage]
		local rewardList = BossRushConfig.instance:getStageRewardList(stage)

		for _, v in ipairs(rewardList) do
			if not _bossInfo.hasGetBonusIds[v.id] and _bossInfo.totalPoint >= v.rewardPointNum then
				_bossInfo.hasGetBonusIds[v.id] = true
			end
		end

		local msg = {
			activityId = activityId,
			bossId = stage,
			hasGetBonusIds = _get_hasGetBonusIds(stage)
		}

		BossRushRpc.instance:onReceiveAct128GetTotalRewardsReply(resultCode, msg)
	end

	function cRpc:sendAct128DoublePointRequest(stage)
		local _bossInfo = _activities[activityId][stage]
		local doublePoint = math.random(10000, 200000)

		_bossInfo.totalPoint = _bossInfo.totalPoint + doublePoint

		local doubleNum = _bossInfo.doubleNum + 1

		_bossInfo.doubleNum = doubleNum

		local msg = {
			activityId = activityId,
			bossId = stage,
			doublePoint = doublePoint,
			totalPoint = _bossInfo.totalPoint,
			doubleNum = doubleNum
		}

		BossRushRpc.instance:onReceiveAct128DoublePointReply(resultCode, msg)
	end

	function cModel:getRealStartTimeStamp()
		return os.time()
	end

	function cModel:getRealEndTimeStamp()
		return os.time() + 2000
	end

	function cModel:getRemainTimeStr()
		return "xxxx"
	end

	function cModel:isBossLayerOpen(stage, layer)
		return true
	end

	function cModel:isActOnLine()
		return true
	end

	function cCtrl:sendGetTaskInfoRequest()
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function cCtrl:enterFightScene(stage, layer)
		function cModel:getBattleStageAndLayer()
			return stage, layer
		end

		BossRushController.instance:openResultPanel()
	end

	function cCtrl:isInBossRushInfiniteFight()
		return true
	end

	function TaskModel:getTaskMoList()
		local taskCOList = BossRushConfig.instance:getAllTaskList()
		local res = {}

		for _, v in ipairs(taskCOList) do
			local id = v.id
			local pb = _make_task(id)

			res[#res + 1] = {
				id = pb.id,
				progress = pb.progress,
				hasFinished = pb.hasFinished,
				finishCount = pb.finishCount,
				config = v
			}
		end

		return res
	end

	function cModel:getBattleStageAndLayer()
		return 1, 3
	end

	local sFightScore = 1000000

	function cModel:getFightScore()
		local stage, layer = BossRushModel.instance:getBattleStageAndLayer()
		local max = BossRushConfig.instance:getBattleMaxPoints(stage, layer)

		if max == 0 then
			max = math.max(0, 99999999999)
		end

		return sFightScore or math.random(0, max)
	end

	function FightModel:getFightParam()
		return fightParam
	end

	function cModel:getStageScore()
		local res = {}
		local n = math.random(3, 5)

		for i = 1, n do
			res[#res + 1] = math.random(1000, 999999)
		end

		return res
	end

	function cModel:setStageLastTotalPoint(stage, value)
		return
	end

	local heroCount = 0
	local kMaxHeroCount = 4

	function FightParam:getAllHeroMoList()
		local heroMoList = {}
		local n = heroCount

		heroCount = (heroCount + 1) % kMaxHeroCount

		for i = 0, n do
			local id = _get_config_id(_G.lua_character)

			table.insert(heroMoList, _make_heroMo(id))
		end

		return heroMoList
	end

	function FightParam:getEquipMoList()
		local equipMoList = {}
		local n = math.random(1, 4)

		for i = 1, n do
			local id = _get_config_id(_G.lua_equip)

			equipMoList[i] = _make_equipMo(id)
		end

		return equipMoList
	end

	function PlayerModel:getPlayinfo()
		return {
			portrait = 0,
			name = "123456"
		}
	end

	function ResUrl.getPlayerHeadIcon()
		local resName = 170000 + math.random(1, 5)

		return string.format("singlebg/playerheadicon/%s.png", resName)
	end

	function cModel.isBossOnline()
		return true
	end

	function cModel:getLastPointInfo()
		return {
			cur = 0,
			max = 2500000
		}
	end

	local cViewContainer = V1a4_BossRushMainViewContainer

	function cViewContainer:onContainerInit()
		return
	end

	BossRushController.instance:openMainView(nil, true)
end

function BossRushController_Test:_test_battle_demo(battleId)
	local battleCO = lua_battle.configDict[battleId]

	if not battleCO then
		logError("battleId not exist" .. tostring(battleId))

		return
	end

	HeroGroupModel.instance:setParam(battleId, nil, nil)

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()
	local equips = curGroupMO:getAllHeroEquips()
	local fightParam = FightController.instance:setFightParamByBattleId(battleId)
	local E = DungeonEnum.ChapterType

	for _, v in ipairs(lua_episode.configList) do
		if v.battleId == battleId then
			local episodeId = v.id
			local chapterId = v.chapterId
			local chapterCO = DungeonConfig.instance:getChapterCO(chapterId)
			local t = chapterCO.type

			if t == E.BossRushNormal or t == E.BossRushInfinite then
				fightParam.chapterId = chapterId
				fightParam.episodeId = episodeId
				FightResultModel.instance.episodeId = episodeId

				DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)

				break
			end
		end
	end

	if not fightParam.chapterId then
		logError("invalid battleid: " .. tostring(battleId))

		return
	end

	fightParam:setMySide(curGroupMO.clothId, main, sub, equips)
	FightController.instance:sendTestFightId(fightParam)
end

function BossRushController_Test:_test_red()
	local E = RedDotEnum.DotNode
	local focusIds = {
		[E.BossRushEnter] = "BossRushEnter(活动入口Root)",
		[E.BossRushOpen] = "BossRushOpen(新功能开启)",
		[E.BossRushBoss] = "BossRushBoss(Boss Root)",
		[E.BossRushNewBoss] = "BossRushNewBoss(新boss解锁)",
		[E.BossRushNewLayer] = "BossRushNewLayer(新难度解锁)",
		[E.BossRushBossReward] = "BossRushBossReward(奖励可领取Root)",
		[E.BossRushBossSchedule] = "BossRushBossSchedule(累计奖励可领)",
		[E.BossRushBossAchievement] = "BossRushBossAchievement(成就奖励可领)"
	}
	local str = ""
	local dotInfos = {}

	for id, v in pairs(RedDotModel.instance._dotInfos or {}) do
		local name = focusIds[id]

		if name then
			dotInfos[id] = v
		end
	end

	for id, v in pairs(dotInfos) do
		local name = focusIds[id]
		local defineId = id
		local s = "(" .. tostring(id) .. ")" .. name .. ":"
		local infos = v.infos

		for uid, vv in pairs(infos) do
			local value = vv.value
			local valueDesc = ""
			local uidDesc = ""
			local playerPrefsDesc = ""

			if id == E.BossRushBossSchedule or id == E.BossRushBossAchievement then
				playerPrefsDesc = " <color=#FF00FF>(tingjie)</color>"
			else
				local defaultValue = BossRushRedModel.instance:getDefaultValue(defineId)
				local savedValue = BossRushRedModel.instance:_get(defineId, uid, defaultValue)

				playerPrefsDesc = "(<color=#FFFF00>" .. tostring(savedValue) .. "</color>)"
			end

			valueDesc = value > 0 and " (<color=#00FF00>" .. tostring(value) .. "</color>)" or " (" .. tostring(value) .. ")"

			if id == E.BossRushNewLayer then
				local stage = math.modf(uid / 1000)
				local layer = math.modf(uid % 1000)

				uidDesc = "uid" .. playerPrefsDesc .. ": " .. tostring(uid) .. string.format("[%s-%s]", stage, layer)
			else
				uidDesc = "uid" .. playerPrefsDesc .. ": " .. tostring(uid)
			end

			s = s .. "\n\t" .. uidDesc .. valueDesc
		end

		if str ~= "" then
			str = str .. "\n"
		end

		str = str .. s
	end

	if str == "" then
		str = "BossRush red data is NULL!!"
	end

	sMyPrintf("\n" .. str)
end

function BossRushController_Test:_test_red_reset()
	local E = RedDotEnum.DotNode
	local stages = BossRushConfig.instance:getStages()

	for _, v in pairs(stages) do
		local stage = v.stage

		BossRushRedModel.instance:_deleteByDSL(E.BossRushOpen, stage)
		BossRushRedModel.instance:_deleteByDSL(E.BossRushNewBoss, stage)

		local episodeStages = BossRushConfig.instance:getEpisodeStages(stage)

		for _, layerCO in pairs(episodeStages) do
			local layer = layerCO.layer

			BossRushRedModel.instance:_deleteByDSL(E.BossRushNewLayer, stage, layer)
		end
	end

	UnityEngine.PlayerPrefs.Save()
	BossRushRedModel.instance:_reload()
end

function BossRushController_Test:_v1a6Enter()
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_EnterView)

	local cEnterView = V1a6_BossRush_EnterView
	local cStoreModel = V1a6_BossRush_StoreModel
	local cConfig = BossRushConfig
	local cModel = BossRushModel
	local cFightParam = FightParam

	function cEnterView:_btnUnOpenOnClick()
		BossRushController_Test.instance:_test_demo()
	end

	function cEnterView:_btnNormalOnClick()
		BossRushController_Test.instance:_test_demo()
	end

	function cModel:getEvaluateList()
		local ids = {}

		for i = 1, 10 do
			table.insert(ids, i)
		end

		return ids
	end

	function cConfig:getEvaluateInfo(id)
		local name = "测试标题—" .. id
		local desc = "测试评价—" .. id

		return name, desc
	end

	function cStoreModel:checkStoreNewGoods()
		return true
	end

	function cFightParam:getHeroEquipMoList()
		local heroEquipMoList = {}
		local equidMoList = cFightParam.getEquipMoList()
		local herosMoList = cFightParam.getAllHeroMoList()

		for i, heroMo in pairs(herosMoList) do
			table.insert(heroEquipMoList, {
				heroMo = heroMo,
				equipMo = equidMoList[i]
			})
		end

		return heroEquipMoList
	end
end

function BossRushController_Test:_test_demo_v3a2()
	local v2Detail = {
		haveFight = true,
		acceptExpPoint = 0
	}
	local bossDetail = {
		{
			bossId = 1,
			layer4TotalPoint = 0,
			highestPoint = 2500,
			spHighestPoint = 0,
			doubleNum = 0,
			layer4HighestPoint = 0,
			totalPoint = 2500,
			hasGetBonusIds = {},
			spItemTypeIds = {},
			v2Detail = v2Detail
		}
	}
	local msg = {
		playerExp = 0,
		playerLevel = 1,
		gainMilestoneLevel = 0,
		activityId = 13230,
		bossDetail = bossDetail
	}

	Activity128Rpc.instance:onReceiveAct128InfoUpdatePush(0, msg)

	function BossRushRpc.instance:sendAct128GetExpRequest(activityId, bossId, callback, callbackobj)
		local mo = V3a2_BossRushModel.instance:getHandBookMo(bossId)
		local info = {
			acceptExpPoint = mo.saveExp,
			haveFight = mo.haveFight
		}

		mo:setV3a2Detail(info)

		if callback then
			callback(callbackobj)
		end
	end

	function BossRushRpc.instance:sendAct128GetMilestoneBonusRequest(activityId, callback, callbackobj)
		local rank = V3a2_BossRushModel.instance:getRank()
		local msg = {
			activityId = activityId,
			gainMilestoneLevel = rank
		}

		BossRushRpc.instance:onReceiveAct128GetMilestoneBonusReply(0, msg)

		if callback then
			callback(callbackobj)
		end
	end
end

function BossRushController_Test:_test_V3a2_Result_Score(baseScore, ruleScore)
	function V3a2_BossRushModel.instance.getScore()
		return {
			baseScore = baseScore,
			ruleScore = ruleScore
		}
	end

	function BossRushModel.instance.getFightScore()
		return baseScore + ruleScore
	end
end

BossRushController_Test.instance = BossRushController_Test.New()

return BossRushController_Test
