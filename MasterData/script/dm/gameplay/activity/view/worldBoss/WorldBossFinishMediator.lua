-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/worldBoss/WorldBossFinishMediator.lua

WorldBossFinishMediator = class("WorldBossFinishMediator", DmPopupViewMediator, _M)

WorldBossFinishMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldBossFinishMediator:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
WorldBossFinishMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.rankbtn"] = {
		ignoreClickAudio = true,
		func = "onClickRank"
	}
}

function WorldBossFinishMediator:initialize()
	super.initialize(self)
end

function WorldBossFinishMediator:dispose()
	super.dispose(self)
end

function WorldBossFinishMediator:userInject()
	return
end

function WorldBossFinishMediator:onRegister()
	super.onRegister(self)

	self._confirmBtn = self:bindWidget("main.challenge_btn", TwoLevelMainButton, {
		clickAudio = "Se_Click_Confirm",
		handler = bind1(self.onClickAgain, self)
	})
	self._cancelBtn = self:bindWidget("main.cancel_btn", TwoLevelViceButton, {
		clickAudio = "Se_Click_Cancle",
		handler = bind1(self.onClickClose, self)
	})
	self._mainPanel = self:getView():getChildByFullName("main")
	self._rewardPanel = self._mainPanel:getChildByFullName("Panel_reward")

	self:mapButtonHandlersClick(kBtnHandlers)
end

function WorldBossFinishMediator:bindWidgets()
	return
end

function WorldBossFinishMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function WorldBossFinishMediator:enterWithData(data)
	self._data = data
	self._activityId = self._data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._bagSystem = self._developSystem:getBagSystem()

	self:createAnim(data)
	self:refreshView(data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dayRsetPush)
end

function WorldBossFinishMediator:formatDamageCount(count)
	if count <= 99999 then
		return tostring(math.floor(count))
	else
		if count > 100000000 then
			count = count - count % 10000000
			count = string.format("%.1f", count / 100000000) .. "e"
		else
			count = count - count % 1000
			count = string.format("%.1f", count / 10000) .. "w"
		end

		return count
	end
end

function WorldBossFinishMediator:createAnim(data)
	local animNode = self._mainPanel:getChildByFullName("animNode")
	local anim = cc.MovieClip:create("tiaozhanjieshu_fubenjiesuan")

	anim:addTo(animNode)
	anim:addEndCallback(function()
		anim:stop()
	end)

	local winNode = anim:getChildByFullName("winNode")
	local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

	winAnim:addEndCallback(function()
		winAnim:stop()
	end)
	winAnim:addTo(winNode)

	local winPanel = winAnim:getChildByFullName("winTitle")
	local title = ccui.ImageView:create("zyfb_tzjs.png", 1)

	title:addTo(winPanel)

	local battleStatist = self._data.statist.players
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local playerBattleData = battleStatist[player:getRid()]
	local team = self._activity:getTeam()
	local mvpPoint = 0
	local masterSystem = developSystem:getMasterSystem()
	local masterData = masterSystem:getMasterById(team:getMasterId())
	local model = masterData:getModel()
	local damage = self._data.damage

	for k, v in pairs(playerBattleData.unitSummary) do
		local roleType = ConfigReader:getDataByNameIdAndKey("RoleModel", v.model, "Type")
		local _unitDmg = v.damage

		if roleType == RoleModelType.kHero then
			local unitMvpPoint = 0

			if _unitDmg then
				unitMvpPoint = unitMvpPoint + _unitDmg
			end

			local _unitCure = v.cure

			if _unitCure then
				unitMvpPoint = unitMvpPoint + _unitCure
			end

			if mvpPoint < unitMvpPoint then
				mvpPoint = unitMvpPoint
				model = v.model
			end
		end
	end

	model = IconFactory:getSpMvpBattleEndMid(model)

	local heroNode = anim:getChildByFullName("roleNode")
	local heroIcon = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})

	heroIcon:setScale(1.1)
	heroIcon:setPosition(cc.p(-320, -300))
	heroNode:addChild(heroIcon)

	local curScore = self._mainPanel:getChildByFullName("hurtNum")

	curScore:setString(Strings:get("WorldBossTotal_Hurt", {
		num = self:formatDamageCount(damage)
	}))

	local highestScore = self._mainPanel:getChildByFullName("highestNum")

	if self._data.pointType == WorldBossPointType.kVanguard then
		self._maxHurtNum = self._activity:getMaxVanguardHurt()

		highestScore:setString(Strings:get("WorldBossTotal_Hurt_Max", {
			num = self:formatDamageCount(self._activity:getMaxVanguardHurt())
		}))
	else
		self._maxHurtNum = self._activity:getMaxBossHurt()

		highestScore:setString(Strings:get("WorldBossTotal_Hurt_Max", {
			num = self:formatDamageCount(self._activity:getMaxBossHurt())
		}))
	end

	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(222, 172, 108, 255)
		}
	}

	highestScore:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	local newRecordText = self._mainPanel:getChildByFullName("newRecord")
	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 241, 91, 255)
		}
	}

	newRecordText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	newRecordText:setVisible(self._maxHurtNum > self._activity:getOldMaxHurtNum())
	self:refreshTimesPanel()
	self:runAction(curScore, -50)
	self:runAction(highestScore, -50)
	self:runAction2(self._confirmBtn:getView())
	self:runAction2(self._cancelBtn:getView())

	local rankBtn = self._mainPanel:getChildByName("rankbtn")

	rankBtn:setVisible(self._data.pointType == WorldBossPointType.kBoss)

	local mvpNode = anim:getChildByName("mvpNode")

	anim:addCallbackAtFrame(9, function()
		mvpNode:setVisible(false)
	end)
	anim:addCallbackAtFrame(17, function()
		mvpNode:setVisible(false)
	end)
end

function WorldBossFinishMediator:runAction(node, xOffset)
	local posX, posY = node:getPosition()

	node:setPositionX(posX + xOffset)
	node:setOpacity(0)
	node:runAction(cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveTo:create(0.2, cc.p(posX, posY))))
end

function WorldBossFinishMediator:runAction2(node)
	node:setOpacity(0)
	node:runAction(cc.FadeIn:create(0.3))
end

function WorldBossFinishMediator:refreshView(data)
	self:refreshTimesPanel(data)
end

function WorldBossFinishMediator:refreshTimesPanel(data)
	local timesText = self._mainPanel:getChildByFullName("Text_times")

	timesText:setString(Strings:get("Activity_Darts_Residualtimes") .. self._activity:getFightTimes(self._data.pointType))
end

function WorldBossFinishMediator:buyTimes(pointType, callback)
	local cost = self._activity:getCostBuyTimes(pointType)
	local bagSystem = self._developSystem:getBagSystem()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			if not bagSystem:checkCostEnough(cost.id, cost.amount, {
				type = "tip"
			}) then
				return
			end

			outSelf._activitySystem:requestDoActivity(outSelf._activityId, {
				doActivityType = 106,
				pointType = pointType
			}, function()
				if not checkDependInstance(outSelf) then
					return
				end

				if callback then
					callback()
				end
			end)
		end
	end

	local data = {
		isRich = true,
		title = Strings:get("MiniGame_BuyTimes_UI1"),
		content = Strings:get("WorldBoss_Buy", {
			fontName = TTF_FONT_FZYH_R,
			num = cost.amount,
			count = cost.eachBuyNum
		}),
		sureBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function WorldBossFinishMediator:dayRsetPush(event)
	self:refreshTimesPanel()
end

function WorldBossFinishMediator:activityClose(event)
	self:close()
end

function WorldBossFinishMediator:onClickAgain(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local function enterBattle()
			self._activity:setOldMaxHurtNum(self._maxHurtNum)

			local team = self._activity:getTeam()

			AudioTimerSystem:playStartBattleVoice(team)
			self._activitySystem:setBattleTeamInfo(team)
			self._activitySystem:requestDoActivity(self._activityId, {
				doActivityType = 102,
				pointType = self._data.pointType
			}, function(rsdata)
				if rsdata.resCode == GS_SUCCESS then
					self:close()

					rsdata.data.isWorldBoss = true

					self._activitySystem:enterActstageBattle(rsdata.data, self._activityId)
				end
			end, true)
		end

		if self._activity:getFightTimes(self._data.pointType) == 0 then
			if self._activity:isCanBuyTimes(self._data.pointType) then
				self:buyTimes(self._data.pointType, enterBattle)
			else
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Activity_WorldBoss_Tip3")
				}))
			end

			return
		end

		enterBattle()
	end
end

function WorldBossFinishMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		BattleLoader:popBattleView(self, {})
	end
end

function WorldBossFinishMediator:onClickRank()
	local view = self:getInjector():getInstance("WorldBossRankView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		tab = 2,
		activityId = self._activityId
	}, nil))
end
