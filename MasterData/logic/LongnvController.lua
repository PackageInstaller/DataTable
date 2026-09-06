-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/LongnvController.lua

module("logic.extensions.timelimitedchallenge.controller.LongnvController", package.seeall)

local LongnvController = class("LongnvController", BaseController)
local localKey = "LongnvController20210816"

function LongnvController:ctor()
	LongnvController.super.ctor(self)
end

function LongnvController:onInit()
	self:onReset()
end

function LongnvController:onReset()
	GameUtil.getUserDayData(localKey, function(value)
		if checknumber(value) == 0 then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_Longnv_Daily, true)
		end
	end)
end

function LongnvController:recordRedPoint()
	GameUtil.saveUserDayData(localKey, 1)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_Longnv_Daily, false)
end

function LongnvController:sendGetInfo()
	LongnvModel.instance:sendGetInfo()
end

function LongnvController:sendGetFightInfo()
	LongnvModel.instance:sendGetFightInfo()
end

function LongnvController:sendGetChallengeInfoByType(type)
	LongnvModel.instance:sendGetChallengeInfoByType(type)
end

function LongnvController:sendBuyTimes()
	LongnvModel.instance:sendBuyTimes()
end

function LongnvController:sendSweep()
	LongnvModel.instance:sendSweep()
end

function LongnvController:sendFight(type, stage)
	LongnvModel.instance:sendFight(type, stage)
end

function LongnvController:tryShowItem(type, stage)
	return
end

function LongnvController:onBattleEnd(type, stage)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local isWin = LongnvModel.instance.isWin

	LongnvModel.instance.isWin = false

	local title = lang("战斗失败")
	local content = lang("未能击败敌阵全部精灵，战斗失败")
	local btnTxt = lang("知道了")
	local totalGet = checknumber(LongnvConfig.instance:getCommonValue("CHALLENGE_PRIZE_LIMIT"))
	local lastDamage = LongnvModel.instance.lastDamage
	local passCount = LongnvModel.instance.passCount
	local planId = LongnvModel.instance:getPlanId()
	local cfg = LongnvConfig.instance:getPlanCfg(planId) or {}
	local monsterPlan = checknumber(cfg.monsterPlan)
	local typeCfg = LongnvConfig.instance:getTypeCfg(type) or {}
	local rId = GameEnum.Races[typeCfg.detectAttr]
	local race = ConstString.Race[rId]
	local minAlivePet = typeCfg.minAlivePet
	local lastStage = typeCfg.stageCount
	local total = LongnvModel.instance:getTotalAliveByType(type)
	local desc = typeCfg.desc
	local totalHp = checknumber(cfg.bossHP)
	local deff = checknumber(cfg.maxDamageDiff)
	local hDeff = deff * 0.5
	local helfHp = totalHp * 0.5
	local min = helfHp - hDeff
	local max = helfHp + hDeff

	if isWin then
		title = lang("战斗胜利")

		local alivePetCount = LongnvModel.instance:getNumAliveByType(type, stage)

		if type == LongnvModel.TYPE_1 or type == LongnvModel.TYPE_2 then
			if stage == lastStage then
				if minAlivePet <= total then
					content = langPara("你成功通过了%s关卡", desc)

					UIJumper.instance:pushOneStack(ViewName.LongnvtowerView, true)
				else
					content = langPara("破阵成功！\n<color=#ff0000>%s属性精灵一共存活=%s只</color>\n但累计存活%s属性精灵条件未达成，可<color=#ff0000>重新挑战</color>对应关卡", race, total, race)

					UIJumper.instance:pushOneStack(ViewName.LongnvtowerView, true)

					if not LongnvModel.instance.isCanChallengeBoss then
						UIJumper.instance:pushOneStack(ViewName.LongnvdetailView, true, type)
					end
				end
			else
				content = langPara("击败敌阵全部精灵，破阵成功！\n<color=#ff0000>%s属性精灵存活=%s只</color>", race, alivePetCount)

				UIJumper.instance:pushOneStack(ViewName.LongnvtowerView, true)

				if not LongnvModel.instance.isCanChallengeBoss then
					UIJumper.instance:pushOneStack(ViewName.LongnvdetailView, true, type)
				end
			end
		elseif type == LongnvModel.TYPE_3 then
			local damage = LongnvModel.instance.damage

			if lastDamage > 0 then
				if passCount > 0 then
					content = langPara("你是<color=#ff0000>今日第%s位</color>，成功通关龙女挑战的玩家！", passCount)
				else
					local damage = LongnvModel.instance.damage
					local bossHp = LongnvModel.instance.bossHP

					content = langPara("第1次对龙女BOSS造成伤害：<color=#ff0000>%s</color>\n第2次对龙女BOSS造成伤害：<color=#ff0000>%s</color>\n龙女BOSS剩余血量：<color=#ff0000>%s</color>\n未能击败龙女BOSS，将<color=#ff0000>重置挑战进度</color>！", lastDamage, damage, bossHp)

					UIJumper.instance:pushOneStack(ViewName.LongnvtowerView, true)
				end
			else
				if min <= damage and damage <= max then
					local bossHp = LongnvModel.instance.bossHP

					content = langPara("第1次对龙女BOSS造成伤害：<color=#ff0000>%s</color>\n龙女BOSS剩余血量：%s", damage, bossHp)
				else
					content = langPara("第1次对龙女BOSS造成伤害：<color=#ff0000>%s</color>\n第1次伤害需%s到%s之间\n<color=#ff0000>未达成</color>，将重置挑战进度！", damage, min, max)
				end

				UIJumper.instance:pushOneStack(ViewName.LongnvtowerView, true)
				UIJumper.instance:pushOneStack(ViewName.LongnventerView, true)
			end
		end
	elseif type == LongnvModel.TYPE_3 then
		if lastDamage > 0 then
			local damage = LongnvModel.instance.damage
			local bossHp = LongnvModel.instance.bossHP

			content = langPara("第1次对龙女BOSS造成伤害：<color=#ff0000>%s</color>\n第2次对龙女BOSS造成伤害：<color=#ff0000>%s</color>\n龙女BOSS剩余血量：<color=#ff0000>%s</color>\n未能击败龙女BOSS，将<color=#ff0000>重置挑战进度</color>！", lastDamage, damage, bossHp)

			UIJumper.instance:pushOneStack(ViewName.LongnvtowerView, true)
		end

		if LongnvController.instance:checkHasTime() then
			UIJumper.instance:pushOneStack(ViewName.LongnvtowerView, true)
			UIJumper.instance:pushOneStack(ViewName.LongnventerView, true)
		end
	else
		UIJumper.instance:pushOneStack(ViewName.LongnvtowerView, true)

		if not LongnvModel.instance.isCanChallengeBoss then
			UIJumper.instance:pushOneStack(ViewName.LongnvdetailView, true, type)
		end
	end

	local ci = LongnvModel.instance.changeSetId

	LongnvModel.instance.changeSetId = -1

	local items = MaterialController.instance:showChangeSetInTemp(ci)
	local str = ""

	if items ~= nil and #items > 0 then
		str = lang("\n获得以下奖励：\n")

		local tem = {}

		for i, v in ipairs(items) do
			local type, id, num = v:getMatType(), v:getId(), v:GetCount()
			local matStr = MaterialMgr.createSerName(type, id, num)
			local c = MaterialMgr.getContentMatStr(matStr, 100, -10, MaterialMgr.ICON_TYPE_MATID)

			table.insert(tem, c)
		end

		str = str .. table.concat(tem, " ")
	end

	content = content .. str

	TipsFacade.instance:openTipWindowValidX(title, content, function()
		BattleController.instance:endBattle()
	end, btnTxt, UnityEngine.TextAnchor.MiddleCenter)

	return true
end

function LongnvController:checkHasPetLeft()
	local spaceGained = LongnvModel.instance.spaceGained
	local total = checknumber(LongnvConfig.instance:getCommonValue("SPACE_LIMIT"))
	local left = math.max(0, total - spaceGained)

	return left > 0
end

function LongnvController:checkHasTime()
	local todayChallengeTimes = LongnvModel.instance.todayChallengeTimes
	local todayChallengeBuyTimes = LongnvModel.instance.todayChallengeBuyTimes
	local total = checknumber(LongnvConfig.instance:getCommonValue("FREE_CHALLENGE_TIMES")) + todayChallengeBuyTimes
	local left = total - todayChallengeTimes

	return left > 0
end

function LongnvController:checkIfCanChallenge(callBack)
	if not self:checkHasPetLeft() then
		TipsFacade.instance:openCommonTips(lang("今日挑战已达全服每日限量上限请明天再来吧"))
	else
		self:checkIfCanChallengeSmall(callBack)
	end
end

function LongnvController:checkIfCanChallengeSmall(callBack)
	if self:checkHasTime() then
		GameUtil.callBack(callBack)
	else
		self:sendAddTimes()
	end
end

function LongnvController:sendAddTimes()
	local todayChallengeBuyTimes = LongnvModel.instance.todayChallengeBuyTimes
	local limit = LongnvConfig.instance:getTimeCount()

	if todayChallengeBuyTimes < limit then
		local left = limit - todayChallengeBuyTimes
		local idx = todayChallengeBuyTimes + 1
		local consume = LongnvConfig.instance:getTimeCfg(idx)
		local matType, cfgId, num = MaterialMgr.getMatParams(consume)
		local iconContent = MaterialMgr.getContentMatCfg(matType, cfgId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
		local content = langPara("今日没有免费次数了，确定花费%s%s购买挑战次数吗？\n每天最多可购买%s次，还能购买%s次", num, iconContent, limit, left)

		TipsFacade.instance:openPopupCostMatViewNew(matType, cfgId, num, content, function()
			LongnvController.instance:sendBuyTimes()
		end)
	else
		TipsFacade.instance:openCommonTips(lang("今日购买次数已达上限，次日5点刷新免费次数和购买次数！"))
	end
end

LongnvController.instance = LongnvController.New()

return LongnvController
