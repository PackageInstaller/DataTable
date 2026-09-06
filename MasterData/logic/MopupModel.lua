-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mopup/model/MopupModel.lua

module("logic.extensions.mopup.model.MopupModel", package.seeall)

local MopupModel = class("MopupModel", BaseModel)

MopupModel.Default = "default"
MopupModel.ResPlot = "resplot"
MopupModel.Legend = "legend"
MopupModel.MainPlot = "mainplot"
MopupModel.SweepSuccessed = "MopupModel.SweepSuccessed"
MopupModel.SweepSetting = "MopupModel.SweepSetting"

local string_split = string.split

function MopupModel:ctor()
	self.sweepOneCostList = {}
	self._sweepType = GameEnum.SweepType.Default
end

function MopupModel:_tryBuildSweepRewardData(rewardStr)
	if type(rewardStr) ~= "string" then
		return rewardStr
	end

	local matType, defineId, matNum = MaterialMgr.getMatParams(rewardStr)

	if matType == MatType.HolyStripe and matNum == 1 then
		local mo = HolyStripeController.instance:popCollectedSweepHolyStripeMoByDefineId(defineId)

		if mo then
			return {
				cfgStr = rewardStr,
				holyStripeMo = mo
			}
		end
	end

	return rewardStr
end

function MopupModel:_buildSweepRewardList(rewardList)
	local result = {}

	for i, rewardStr in ipairs(rewardList or {}) do
		table.insert(result, self:_tryBuildSweepRewardData(rewardStr))
	end

	return result
end

local function insertTolist(list, input, delimiter)
	local arr = string.split(input, "#")

	for i, str in ipairs(arr) do
		if string.trim(str) ~= "" then
			table.insert(list, str)
		end
	end
end

function MopupModel:getPlotInitReward(challengeId, stageId, teamId, notcalperfect)
	local list = {}
	local data = {
		isInit = true,
		list = {}
	}
	local cfg = CopyConfig.instance:getStageById(challengeId, stageId)
	local cfgTeam

	if cfg then
		local creepsMasterId = cfg.teamIds

		cfgTeam = CopyConfig.instance:getTeamCfg(creepsMasterId)
	end

	if not notcalperfect then
		local isPerfect = PlotCopyModel.instance:isStagePerfectPass(challengeId, stageId)

		if not isPerfect and cfg and not string.nilorempty(cfg.perfectPassMp) then
			local perfectItems = string.split(cfg.perfectPassMp, "#")
			local length = #perfectItems

			for i = 1, length do
				table.insert(data.list, perfectItems[i])
			end
		end
	end

	if cfgTeam and not string.nilorempty(cfgTeam.reward) then
		local str2 = MaterialMgr.changeItemStr(cfgTeam.reward)
		local rewardItems = string.split(str2, "#")
		local length2 = #rewardItems

		for i = 1, length2 do
			table.insert(data.list, rewardItems[i])
		end
	end

	table.insert(list, data)

	return list
end

function MopupModel:getSweepOneCost(challengeId, stageId, teamId)
	local key = string.format("%s@%s@%s", challengeId, stageId, teamId)

	if self.sweepOneCostList[key] ~= nil then
		return self.sweepOneCostList[key]
	else
		local cfg = CopyConfig.instance:getStageById(challengeId, stageId)

		if cfg then
			local creepsMasterId = cfg.teamIds
			local cfgTeam = CopyConfig.instance:getTeamCfg(creepsMasterId)

			if cfgTeam then
				self.sweepOneCostList[key] = cfgTeam.strengthConsumption

				return cfgTeam.strengthConsumption
			end
		end
	end

	return 0
end

function MopupModel:FormatSweepRewardAndDoFunc(msg, callback, isChapterCopy)
	local prizes = msg.prizes

	if not msg.multiplyTimes then
		local newList = {}

		for i, v in ipairs(prizes) do
			local list = {}

			insertTolist(list, v.prizes, "#")
			insertTolist(list, v.experience, "#")

			list = self:_buildSweepRewardList(list)

			local multiple = checkint(v.doublingSize) - 1
			local timeMultiply = multiple > 0
			local data = {
				times = v.times,
				list = list,
				rewardMultiply = timeMultiply,
				multiple = multiple
			}

			table.insert(newList, data)
		end

		callback(newList)
	end
end

function MopupModel:setPetTalentUpCostStr(str)
	printInfo("传进来", str)

	self.petTalentUpCostStr = str
end

function MopupModel:getPetTalentCostStr()
	return self.petTalentUpCostStr
end

function MopupModel:checkCanSweep(jumpToStr, finishCallBack)
	local can = false

	if jumpToStr and jumpToStr ~= "" then
		local list = string_split(jumpToStr, "#")
		local tag = list[1]

		if tag == "fb" then
			local petskillOn = ViewMgr.instance:isOpen(ViewName.PetSkillView)
			local talentOn = ViewMgr.instance:isOpen(ViewName.PetTalent)
			local isOpen = self:getPetTalentCostStr() and talentOn or petskillOn

			can = isOpen and PlotCopyModel.instance:isStagePassedAllCopy(checknumber(list[2]), checknumber(list[3]))
		end
	end

	if finishCallBack then
		finishCallBack(can)
	end
end

function MopupModel:clickItemSourceSweep(jumpToStr, matType, matId)
	if jumpToStr and jumpToStr ~= "" then
		local list = string_split(jumpToStr, "#")
		local tag = list[1]

		if tag == "fb" then
			local challengeId = checknumber(list[2])
			local stageId = checknumber(list[3])
			local isFind = false
			local pattern = matType .. ":" .. matId
			local len = #pattern
			local list = self:getPlotInitReward(challengeId, stageId, 0, true)

			for k, v in pairs(list) do
				for _, str in pairs(v.list) do
					local subStr = string.sub(str, 1, len)

					if pattern == subStr then
						isFind = true

						break
					end
				end
			end

			if not isFind then
				FloatWordMgr.instance:show("找不到目标道具，无法扫荡")

				return
			end

			self:doPlotCopySweep(challengeId, stageId, 0, matType, matId)
		end
	end
end

function MopupModel:clickOneKeySweep(rewardStr)
	local rewardList = string.split(rewardStr, "#")

	if rewardList and #rewardList > 0 then
		local curParam = {}

		curParam.type = "onekeysweep"
		curParam.rewardList = rewardList
		curParam.curChallengeId = 0
		curParam.curstageId = 0

		local function getOneCostCallBack()
			return self:getSweepOneCost(curParam.curChallengeId, curParam.curstageId, 0)
		end

		local function getConditionCallBack()
			return ""
		end

		local function getRewardCallBack()
			return self:getPlotInitReward(curParam.curChallengeId, curParam.curstageId, 0)
		end

		local function getAutoDataCallBack()
			return curParam
		end

		local function clickStarCallBack(type, param)
			local function resFunc(msg)
				self:FormatSweepRewardAndDoFunc(msg, param.func)
			end

			if param.times and param.times <= 0 then
				FloatWordMgr.instance:show("至少扫荡1次哦")

				return
			end

			if type == MopupMainView.ClickType.Time then
				PlotCopyController.instance:sendPCLG_SweepsByTimesReq(curParam.curChallengeId, curParam.curstageId, param.times, param.useTicket, resFunc)
			elseif type == MopupMainView.ClickType.Auto then
				PlotCopyController.instance:sendPCLG_SweepAutoReq(curParam.curChallengeId, curParam.curstageId, param.matType, param.matId, param.targetNum, param.useTicket, resFunc)
			end
		end

		local sweepMo
		local ticket = CopyConfig.instance:getFirstTeamTicket()

		if ticket then
			sweepMo = SweepMainPlotMo.New()

			local isSuccess = sweepMo:setMatCost(ticket)

			if not isSuccess then
				sweepMo = nil
			end
		end

		UIStateManager.instance:open(ViewName.MopupMainView, clickStarCallBack, getChallengeCallBack, getOneCostCallBack, getConditionCallBack, getRewardCallBack, getAutoDataCallBack, nil, nil, nil, sweepMo)
	end
end

function MopupModel:doPlotCopySweep(challengeId, stageId, teamId, matType, matId)
	local function getOneCostCallBack()
		return self:getSweepOneCost(challengeId, stageId, teamId)
	end

	local function getConditionCallBack()
		return ""
	end

	local function getRewardCallBack()
		return self:getPlotInitReward(challengeId, stageId, teamId)
	end

	local function getAutoDataCallBack()
		local autoData = false
		local str = self:getPetTalentCostStr()

		if str and str ~= "" then
			local list = string_split(str, "#")

			for i, v in ipairs(list) do
				local list1 = string_split(v, ":")
				local matType1 = tonumber(list1[1])
				local matId1 = tonumber(list1[2])
				local num = tonumber(list1[3])

				if tonumber(matType) == matType1 and tonumber(matId) == matId1 then
					autoData = string.format("%s:%s:%s", matType1, matId1, num)

					break
				end
			end
		end

		return autoData
	end

	local function clickStarCallBack(type, param)
		local function resFunc(msg)
			self:FormatSweepRewardAndDoFunc(msg, param.func)
		end

		if param.times and param.times <= 0 then
			FloatWordMgr.instance:show("至少扫荡1次哦")

			return
		end

		if type == MopupMainView.ClickType.Time then
			PlotCopyController.instance:sendPCLG_SweepsByTimesReq(challengeId, stageId, param.times, param.useTicket, resFunc)
		elseif type == MopupMainView.ClickType.Auto then
			printInfo("test 自动扫荡", challengeId, stageId, param.targetNum, param.useTicket)
			PlotCopyController.instance:sendPCLG_SweepAutoReq(challengeId, stageId, param.matType, param.matId, param.targetNum, param.useTicket, resFunc)
		end
	end

	local sweepMo
	local cfg = CopyConfig.instance:getTeamCfgById(challengeId, stageId)

	if cfg and cfg.ticket then
		sweepMo = SweepMainPlotMo.New()

		local isSuccess = sweepMo:setMatCost(cfg.ticket)

		if not isSuccess then
			sweepMo = nil
		end
	end

	UIStateManager.instance:open(ViewName.MopupMainView, clickStarCallBack, getChallengeCallBack, getOneCostCallBack, getConditionCallBack, getRewardCallBack, getAutoDataCallBack, nil, nil, nil, sweepMo)
end

function MopupModel:cliclMainPlotSweep(challengeId, stageId, teamId)
	local function getOneCostCallBack()
		return self:getSweepOneCost(challengeId, stageId, teamId)
	end

	local function getConditionCallBack()
		return ""
	end

	local function getRewardCallBack()
		return self:getPlotInitReward(challengeId, stageId, teamId)
	end

	local function getAutoDataCallBack()
		return false
	end

	local function clickStarCallBack(type, param)
		local function resFunc(msg)
			self:FormatSweepRewardAndDoFunc(msg, param.func, true)
		end

		if param.times and param.times <= 0 then
			FloatWordMgr.instance:show("至少扫荡1次哦")

			return
		end

		if type == MopupMainView.ClickType.Time then
			PlotCopyController.instance:sendPCLG_SweepsByTimesReq(challengeId, stageId, param.times, param.useTicket, resFunc)
		elseif type == MopupMainView.ClickType.Auto then
			PlotCopyController.instance:sendPCLG_SweepAutoReq(challengeId, stageId, param.matType, param.matId, param.targetNum, param.useTicket, resFunc)
		end
	end

	local sweepMo
	local cfg = CopyConfig.instance:getTeamCfgById(challengeId, stageId)

	if cfg and cfg.ticket then
		sweepMo = SweepMainPlotMo.New()

		local isSuccess = sweepMo:setMatCost(cfg.ticket)

		if not isSuccess then
			sweepMo = nil
		end
	end

	UIStateManager.instance:open(ViewName.MopupMainView, clickStarCallBack, getChallengeCallBack, getOneCostCallBack, getConditionCallBack, getRewardCallBack, getAutoDataCallBack, nil, nil, 0, sweepMo)
end

function MopupModel:clickLegenSweep(challengeId, stageId)
	local legendChallengeCfg = LegendConfig.instance:getLegendChallengeCfg(challengeId)
	local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
	local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)
	local strengthConsumption = cfgTeam.strengthConsumption

	local function getOneCostCallBack()
		return strengthConsumption
	end

	local function getConditionCallBack()
		local condition1 = "扫荡次数:"
		local curIndependentTime = LegendModel.instance:getCurIndependentTimes(challengeId)
		local maxCount = VipModel.instance:getFreeChallengeTimesOfPet()

		condition1 = condition1 .. string.format("%d/%d", curIndependentTime, maxCount)

		return condition1
	end

	local function getInitRewardCallBack()
		local list = {}

		if cfgTeam and not string.nilorempty(cfgTeam.reward) then
			local data = {
				isInit = true,
				list = {}
			}
			local str2 = MaterialMgr.changeItemStr(cfgTeam.reward)
			local rewardItems = string.split(str2, "#")
			local length2 = #rewardItems

			for i = 1, length2 do
				if not string.nilorempty(rewardItems[i]) then
					local rewardStr = rewardItems[i]

					table.insert(data.list, rewardStr)
				end
			end

			table.insert(list, data)
		end

		return list
	end

	local function getAutoDataCallBack()
		return false
	end

	local sweepTicketId = 3101

	local function clickStarCallBack(type, param)
		if not param.times then
			local needNum = 0
			local independentCount = LegendModel.instance:getCurIndependentTimes(challengeId)
			local sweepTicketCount = MaterialFacade.instance:getMatNumber(MatType.Item, sweepTicketId)

			if needNum <= 0 then
				FloatWordMgr.instance:show("目标次数应该大于等于1次")

				return
			end

			if needNum > independentCount + sweepTicketCount then
				FloatWordMgr.instance:show("扫荡券不足，无法进行扫荡")

				return
			end

			local isNotOpen = GameUtil.getUserDayData(LegendConst.SweepTicketTip)

			if independentCount < needNum and not isNotOpen then
				local title = "提示"
				local text = string.format("您确定要消耗扫荡券进行扫荡%d次吗？\n\n今天的扫荡次数还剩：%d次\n需要额外消耗扫荡券：%d张", needNum, independentCount, needNum - independentCount)

				local function func1()
					self:_doLegendSweep(challengeId, type, param)
				end

				local func2

				local function funcTog()
					GameUtil.saveUserDayData(LegendConst.SweepTicketTip, true)
				end

				local btnText1 = "确定消耗"
				local btnText2 = "取消"
				local togText = "今日不再提示"

				TipsFacade.instance:openPopupWindowWithTog(title, text, func1, func2, funcTog, btnText1, btnText2, togText, UnityEngine.TextAnchor.MiddleCenter)

				return
			end

			self:_doLegendSweep(challengeId, type, param)
		end
	end

	local function getChallengeLeftTimeCallBack()
		local curIndependentTime = LegendModel.instance:getCurIndependentTimes(challengeId)
		local sweepTicketCount = MaterialFacade.instance:getMatNumber(MatType.Item, sweepTicketId)
		local num = curIndependentTime + sweepTicketCount

		return num <= 5 and num or 5
	end

	if ViewMgr.instance:isOpen(ViewName.MopupMainView) then
		ViewMgr.instance:close(ViewName.MopupMainView)
	end

	local secondItemParam = {
		sweepType = MopupModel.Legend,
		matType = MatType.Item,
		matId = sweepTicketId
	}

	UIStateManager.instance:open(ViewName.MopupMainView, clickStarCallBack, getChallengeCallBack, getOneCostCallBack, getConditionCallBack, getInitRewardCallBack, getAutoDataCallBack, getChallengeLeftTimeCallBack, nil, nil, secondItemParam)
end

function MopupModel:_doLegendSweep(challengeId, type, param)
	local function resFunc(msg)
		self:resLegendSweep(msg, param.func, challengeId)
	end

	if param.times and param.times <= 0 then
		FloatWordMgr.instance:show("至少扫荡1次哦")

		return
	end

	if type == MopupMainView.ClickType.Time then
		LegendController.instance:sendSweepsByTimesReq(challengeId, param.times, resFunc)
	elseif type == MopupMainView.ClickType.Auto then
		LegendController.instance:sendSweepAutoReq(challengeId, param.matType, param.matId, param.targetNum, resFunc)
	end
end

function MopupModel:resLegendSweep(msg, callback, challengeId)
	LegendModel.instance:reduceCurIndependentTimes(challengeId, #msg.prizes)
	GlobalDispatcher:dispatch(MopupModel.SweepSuccessed, challengeId)

	local newList = {}
	local prizes = msg.prizes

	for i, v in ipairs(prizes) do
		local list = {}

		insertTolist(list, v.prizes, "#")
		insertTolist(list, v.experience, "#")

		local data = {
			times = v.times,
			list = list
		}

		table.insert(newList, data)
	end

	if callback then
		callback(newList)
	end
end

function MopupModel:cliclResPlotSweep(challengeId, stageId, teamId)
	local function getOneCostCallBack()
		return 0
	end

	local function getConditionCallBack()
		return ""
	end

	local function getRewardCallBack()
		return
	end

	local function getAutoDataCallBack()
		return false
	end

	local function clickStarCallBack(type, param)
		local curCount, totalCount = MaterialChallengeModel.instance:getCostLimitCount(challengeId)

		if totalCount <= curCount then
			FloatWordMgr.instance:show("当前剩余次数不足")

			return
		end

		local isDoubleTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Material, challengeId)

		local function resFunc(msg)
			MaterialChallengeModel.instance:addChallengeCount(challengeId, #msg.prizes)

			if isDoubleTime then
				MaterialChallengeModel.instance:addChallengeDoubleRewardCount(challengeId, msg.multiplyTimes)
			end

			GlobalDispatcher:dispatch(MopupModel.SweepSuccessed)
			self:FormatSweepRewardAndDoFunc(msg, param.func)
		end

		if param.times and param.times <= 0 then
			FloatWordMgr.instance:show("至少扫荡1次哦")

			return
		end

		if type == MopupMainView.ClickType.Time then
			if param.useTicket and not param.isTicketEnough then
				FloatWordMgr.instance:show("您的扫荡券数量不足")

				return
			end

			MaterialChallengeController.instance:sendMCLG_SweepsByTimesReq(challengeId, stageId, param.times, param.useTicket, resFunc)
		elseif type == MopupMainView.ClickType.Auto then
			MaterialChallengeController.instance:sendMCLG_SweepAutoReq(challengeId, stageId, param.matType, param.matId, param.targetNum, resFunc)
		end
	end

	local function getChallengeLeftTimeCallBack()
		return 5
	end

	local sweepMo
	local cfg = MaterialChallengeConfig.instance:getStageById(challengeId, stageId)

	if cfg and cfg.ticket then
		sweepMo = SweepResPlotMo.New()

		local isSuccess = sweepMo:setMatCost(cfg.ticket)

		if not isSuccess then
			sweepMo = nil
		end
	end

	UIStateManager.instance:open(ViewName.MopupMainView, clickStarCallBack, getChallengeCallBack, getOneCostCallBack, getConditionCallBack, getRewardCallBack, getAutoDataCallBack, getChallengeLeftTimeCallBack, nil, challengeId, sweepMo)
end

function MopupModel:clickStarGodChallengeSweep(id)
	local cfg = StarGodChallengeConfig.instance:getChallengeCfg(id)
	local matType, id, matNum = MaterialMgr.getMatParams(cfg.singleCost)

	local function getOneCostCallBack()
		return matNum
	end

	local function getConditionCallBack()
		local totalCount = checknumber(StarGodChallengeConfig.instance:getConstValue("TODAY_GAME_TIMES"))
		local curCount = StarGodChallengeModel.instance:getTodayGameTimes()
		local leftCount = totalCount - curCount

		leftCount = leftCount >= 0 and leftCount or 0

		local fmtStr = "%d/%d"

		return "今日剩余次数：" .. string.format(fmtStr, leftCount, totalCount)
	end

	local function getRewardCallBack()
		return
	end

	local function getAutoDataCallBack()
		return false
	end

	local function clickStarCallBack(type, param)
		local totalCount = checknumber(StarGodChallengeConfig.instance:getConstValue("TODAY_GAME_TIMES"))
		local curCount = StarGodChallengeModel.instance:getTodayGameTimes()

		if totalCount <= curCount then
			FloatWordMgr.instance:show("当前剩余次数不足")

			return
		end

		local function resFunc(msg)
			StarGodChallengeController.instance:addTodayGameTimes(checknumber(param.times))
			GlobalDispatcher:dispatch(MopupModel.SweepSuccessed)
			self:FormatSweepRewardAndDoFunc(msg, param.func)
		end

		if param.times and param.times <= 0 then
			FloatWordMgr.instance:show("至少扫荡1次哦")

			return
		end

		if type == MopupMainView.ClickType.Time then
			StarGodChallengeController.instance:addSweepParam(param.times, resFunc)
			StarGodChallengeAgent.instance:sendPM_StarGodChallengeSweepReq(id, param.times)
		end
	end

	local function getChallengeLeftTimeCallBack()
		local totalCount = checknumber(StarGodChallengeConfig.instance:getConstValue("TODAY_GAME_TIMES"))
		local curCount = StarGodChallengeModel.instance:getTodayGameTimes()
		local leftCount = totalCount - curCount

		leftCount = leftCount > 5 and 5 or leftCount >= 0 and leftCount or 0

		return leftCount
	end

	UIStateManager.instance:open(ViewName.MopupMainView, clickStarCallBack, getChallengeCallBack, getOneCostCallBack, getConditionCallBack, getRewardCallBack, getAutoDataCallBack, getChallengeLeftTimeCallBack)
end

function MopupModel:clickOpenHolyStripeCopySweep(tabId, stageId)
	local cfg = HolyStripeCopyConfig.instance:getStageCfg(tabId, stageId)

	local function getOneCostCallBack()
		return cfg.strengthCost
	end

	local function getConditionCallBack()
		local totalCount = HolyStripeCopyModel.instance:getLimitSoloTime()
		local leftCount = HolyStripeCopyModel.instance:getLeftSoloTime()

		leftCount = leftCount >= 0 and leftCount or 0

		local fmtStr = "%d/%d"

		return "今日剩余次数：" .. string.format(fmtStr, leftCount, totalCount)
	end

	local function getRewardCallBack()
		return
	end

	local function getAutoDataCallBack()
		return false
	end

	local function clickStarCallBack(type, param)
		local leftCount = HolyStripeCopyModel.instance:getLeftSoloTime()

		if leftCount <= 0 then
			FloatWordMgr.instance:show("当前剩余次数不足")

			return
		end

		local function resFunc(msg)
			GlobalDispatcher:dispatch(MopupModel.SweepSuccessed)
			self:FormatSweepRewardAndDoFunc(msg, param.func)
			HolyStripeController.instance:endCollectSweepHolyStripes()
		end

		if param.times and param.times <= 0 then
			FloatWordMgr.instance:show("至少扫荡1次哦")

			return
		end

		if type == MopupMainView.ClickType.Time then
			HolyStripeController.instance:beginCollectSweepHolyStripes()
			HolyStripeCopyController.instance:addSweepParam(resFunc)
			LingWenAgent.instance:sendPM_LingWenSweepReq(tabId, stageId, param.times)
		end
	end

	local function getChallengeLeftTimeCallBack()
		local leftCount = HolyStripeCopyModel.instance:getLeftSoloTime()

		leftCount = leftCount > 5 and 5 or leftCount >= 0 and leftCount or 0

		return leftCount
	end

	UIStateManager.instance:open(ViewName.MopupMainView, clickStarCallBack, getChallengeCallBack, getOneCostCallBack, getConditionCallBack, getRewardCallBack, getAutoDataCallBack, getChallengeLeftTimeCallBack)
end

function MopupModel:cliclkOperationPlotSweep(chapterId, stageId)
	local stageCfg = ScenariocopyConfig.instance:getStageCfg(chapterId, stageId)
	local actId = ScenariocopyModel.instance:getActivityId()
	local scCfg = ScenariocopyConfig.instance:getActCfg(actId)
	local energyMat = scCfg.energy
	local energyMatArr = string.splitToNumber(energyMat, ":")
	local energyId = energyMatArr[2]
	local energyCfg = EnergyConfig.instance:getEnergyCfg(energyId)

	if stageCfg then
		local function getOneCostCallBack()
			return string.splitToNumber(stageCfg.energyConsume, ":")[3]
		end

		local function getConditionCallBack()
			return ""
		end

		local function getRewardCallBack()
			local list = {}
			local data = {
				isInit = true,
				list = {}
			}
			local rewardItems = string.split(stageCfg.comReward, "#")
			local length2 = #rewardItems

			for i = 1, length2 do
				if not string.nilorempty(rewardItems[i]) then
					local rewardStr = rewardItems[i]

					table.insert(data.list, rewardStr)
				end
			end

			table.insert(list, data)

			return list
		end

		local function getAutoDataCallBack()
			return false
		end

		local function clickStartCallBack(type, param)
			local function resFunc(msg)
				self:FormatSweepRewardAndDoFunc(msg, param.func)
			end

			if param.times and param.times <= 0 then
				FloatWordMgr.instance:show("至少扫荡1次哦")

				return
			end

			local activityId = ScenariocopyModel.instance:getActivityId()
			local storyId = ScenariocopyModel.instance:getTypeId()

			if type == MopupMainView.ClickType.Time then
				OperationPlotAgent.instance:sendPM_OperationPlotSweepsByTimesReq(activityId, storyId, chapterId, stageId, param.times, resFunc)
			end
		end

		local function numCallBack()
			return EnergyModel.instance:getCurEnergy(energyId)
		end

		local function txtCallBack()
			local hasNum = EnergyModel.instance:getCurEnergy(energyId)
			local cfg = EnergyConfig.instance:getEnergyCfg(energyId)

			return hasNum .. "/" .. cfg.recoveryLimit
		end

		local addCallBack
		local isHaveSource = not string.nilorempty(energyCfg.source)

		if isHaveSource then
			function addCallBack()
				EnergyController.instance:openBuyView(energyId)
			end
		end

		UIStateManager.instance:open(ViewName.MopupMainView, clickStartCallBack, getChallengeCallBack, getOneCostCallBack, getConditionCallBack, getRewardCallBack, getAutoDataCallBack, nil, nil, nil, nil, {
			matStr = scCfg.energy,
			numCallBack = numCallBack,
			txtCallBack = txtCallBack,
			addCallBack = addCallBack
		})
	end
end

function MopupModel:getSweepSetting()
	return GameUtil.getUserData(MopupModel.SweepSetting, value)
end

function MopupModel:setSweepSetting(value)
	GameUtil.saveUserData(MopupModel.SweepSetting, value, value)
end

function MopupModel:getSweepType()
	return self._sweepType
end

function MopupModel:setSweepType(sType)
	self._sweepType = sType
end

MopupModel.instance = MopupModel.New()

return MopupModel
