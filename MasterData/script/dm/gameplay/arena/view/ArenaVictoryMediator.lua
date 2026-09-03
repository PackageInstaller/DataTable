-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaVictoryMediator.lua

ArenaVictoryMediator = class("ArenaVictoryMediator", DmPopupViewMediator, _M)

ArenaVictoryMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
ArenaVictoryMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")
ArenaVictoryMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local pos = {
	{
		cc.p(463, 30)
	},
	{
		cc.p(383, 30),
		cc.p(553, 30)
	},
	{
		cc.p(293, 30),
		cc.p(463, 30),
		cc.p(633, 30)
	},
	{
		cc.p(213, 30),
		cc.p(383, 30),
		cc.p(553, 30),
		cc.p(723, 30)
	},
	{
		cc.p(123, 30),
		cc.p(293, 30),
		cc.p(463, 30),
		cc.p(633, 30),
		cc.p(803, 30)
	}
}

function ArenaVictoryMediator:initialize()
	super.initialize(self)
end

function ArenaVictoryMediator:dispose()
	self._data = nil

	super.dispose(self)
end

function ArenaVictoryMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("bg.button_panel.button_show", OneLevelMainButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickShow, self)
		}
	})
	self:bindWidget("bg.button_panel.button_replay", OneLevelMainButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickReplay, self)
		}
	})
	self:bindWidget("bg.button_panel.button_exit", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickExit, self)
		}
	})
end

function ArenaVictoryMediator:enterWithData(data)
	self:setupView(data)
	self:setupClickEnvs()
end

function ArenaVictoryMediator:setupView(data)
	self._data = data
	self._isFromNewArena = data.isFromNewArena
	self._replayType = self._data.replayType

	if self._replayType == ArenaBattlePlayType.kNormal then
		if self._data.resultData.attackerWin then
			self._winnerId = self._data.resultData.attacker.id

			AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")
		else
			self._winnerId = self._data.resultData.defender.id

			AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Lose")
		end
	elseif self._replayType == ArenaBattlePlayType.kReport then
		if self._data.resultData:getAttackerWin() then
			self._winnerId = self._data.resultData:getAttacker():getId()

			AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")
		else
			self._winnerId = self._data.resultData:getDefender():getId()

			AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Lose")
		end
	end

	self:initWidgetInfo()

	self._win = isWin
end

function ArenaVictoryMediator:initWidgetInfo()
	local bg = self:getView():getChildByName("bg")

	self._animNode = bg:getChildByFullName("animNode")
	self._heroPanel = bg:getChildByFullName("heroPanel")
	self._rewardNode = bg:getChildByFullName("panel_win.rewardNode")
	self._listView = bg:getChildByFullName("panel_win.listView")

	self._listView:setScrollBarEnabled(false)

	self._winnerName = bg:getChildByFullName("node_1.action_node_1.winer_name")
	self._winnerRank = bg:getChildByFullName("node_1.action_node_1.winer_rank")
	self._winerIconBg = bg:getChildByFullName("node_1.action_node_1.winer_icon_bg.icon_bg")
	self._winnerRankRise = bg:getChildByFullName("node_1.action_node_1.rankRise")

	local panelWin = bg:getChildByFullName("panel_win")

	if self._isFromNewArena then
		panelWin:setVisible(false)
	end

	local panelReward = bg:getChildByFullName("Node_rankUp")
	local panelHero = bg:getChildByFullName("heroPanel")

	panelReward:setVisible(false)
	panelHero:setVisible(false)

	local reward = self._data.rewards
	local titleOffsetX = 0
	local bgAnimOffsetY = 0
	local bgAnim, titleAnim
	local title = bg:getChildByFullName("Text_24")
	local rankPanel = bg:getChildByFullName("Panel_2")

	if next(reward) then
		bgAnimOffsetY = -10
		titleOffsetX = 24
		bgAnim = "anim_zuanshi_jingjichangjiesuan"
		titleAnim = "zitizuanshi_FX_jingjichangjiesuan"

		panelReward:setVisible(true)
		title:setString(Strings:get("ClassArena_UI84"))
		self:showRewards(reward)
		title:setFontSize(38)
	else
		titleOffsetX = 50
		bgAnimOffsetY = 2
		bgAnim = "anim_jingjichangjiesuan"
		titleAnim = "shengliz_jingjichangjiesuan"

		panelHero:setVisible(true)
		title:setString(Strings:get("ClassArena_UI85"))
		rankPanel:setPosition(cc.p(514, 360))
		self:showMVP()
	end

	local anim = cc.MovieClip:create(bgAnim)

	anim:addTo(self._animNode):offset(0, bgAnimOffsetY)
	anim:addEndCallback(function()
		anim:stop()
	end)

	local winTitle = bg:getChildByFullName("winTitle")
	local winAnim = cc.MovieClip:create(titleAnim)

	winAnim:addTo(winTitle)
	winAnim:addEndCallback(function()
		winAnim:stop()
	end)

	local mc_title = winAnim:getChildByFullName("text_title")

	title:changeParent(mc_title):center(mc_title:getContentSize()):offset(titleOffsetX, 0)

	local curRank = bg:getChildByFullName("Panel_2.text_rank")
	local rankAdd = bg:getChildByFullName("Panel_2.text_rank_0")

	curRank:setString(self._data.resultData:getRank())
	rankAdd:setString(self._data.resultData:getRankChange())
	CommonUtils.runActionEffectByRootNode(bg, "ArenaVictoryEffect")
end

function ArenaVictoryMediator:showRewards(rewards)
	local bg = self:getView():getChildByName("bg")
	local nodeRank = bg:getChildByFullName("Node_rankUp")
	local iconNum = nodeRank:getChildByFullName("text_rank_0")
	local rankdesc2 = nodeRank:getChildByFullName("text_desc_0")
	local itemNum = 0

	for k, v in pairs(rewards or {}) do
		if v.code == CurrencyIdKind.kDiamond then
			itemNum = itemNum + v.amount
		end
	end

	iconNum:setTextColor(GameStyle:getColor(3))
	iconNum:setString(Strings:get("ClassArena_UI36", {
		Num = itemNum
	}))
	rankdesc2:setString("")

	local curRank = self._data.resultData:getRank()
	local nextReward = self._arenaNewSystem:getNextFirstReward(curRank)

	if next(nextReward) ~= nil then
		local f = Strings:get("ClassArena_UI37", {
			fontSize = 18,
			fontName = TTF_FONT_FZYH_M,
			Num1 = nextReward.nextRank,
			Num2 = nextReward.rewardNum
		})
		local richText = ccui.RichText:createWithXML(f, {})

		richText:setAnchorPoint(rankdesc2:getAnchorPoint())
		richText:setPosition(cc.p(0, 0))
		richText:addTo(rankdesc2)
	end
end

function ArenaVictoryMediator:showMVP()
	self._heroPanel:removeAllChildren()

	local role = self._data.battleStatist

	if role[self._winnerId] then
		local unitSummary = role[self._winnerId].unitSummary
		local heroes = {}
		local master = {}

		for key, value in pairs(unitSummary) do
			local num = 0

			if value.type == "hero" then
				if value.cure then
					num = num + value.cure
				end

				if value.damage then
					num = num + value.damage
				end

				local type = ConfigReader:getDataByNameIdAndKey("RoleModel", value.model, "Type")

				if num ~= 0 and type == RoleModelType.kHero then
					local addSta = false

					for _index, _value in pairs(heroes) do
						if _value.model == value.model then
							addSta = true
							_value.num = _value.num + num
						end
					end

					if not addSta then
						heroes[#heroes + 1] = {
							model = value.model,
							num = num
						}
					end
				end
			elseif value.type == "master" and value.presentMaster then
				master[#master + 1] = {
					model = value.model
				}
			end
		end

		table.sort(heroes, function(a, b)
			return a.num > b.num
		end)

		if #heroes == 0 then
			if master[1] then
				local heroAnim = RoleFactory:createHeroAnimation(master[1].model)

				heroAnim:setAnchorPoint(cc.p(0.5, 0))
				heroAnim:addTo(self._heroPanel)
				heroAnim:setScale(0.75)
				heroAnim:setPosition(pos[1][1])

				if master[1].model == "Model_LFKLFTe_DGun" then
					heroAnim:setScale(0.35)
					heroAnim:offset(-270, 40)
				end
			end
		else
			local showHeroNum = math.min(#heroes, 5)

			for i = 1, showHeroNum do
				local heroAnim, jsonPath = RoleFactory:createHeroAnimation(heroes[i].model)

				heroAnim:setAnchorPoint(cc.p(0.5, 0))
				heroAnim:addTo(self._heroPanel)
				heroAnim:setScale(0.75)
				heroAnim:setOpacity(0)
				heroAnim:setTag(i)

				local position = pos[showHeroNum][i]

				heroAnim:setPosition(cc.p(position.x - 30, position.y))

				local moveto = cc.MoveTo:create(0.2, cc.p(position.x, position.y))
				local spawn = cc.Spawn:create(cc.FadeIn:create(0.2), moveto)
				local seq = cc.Sequence:create(cc.DelayTime:create(i * 0.1), spawn)

				heroAnim:runAction(seq)
			end
		end
	end
end

function ArenaVictoryMediator:onClickReplay(sender, eventType, oppoRecord)
	if self._replayType == ArenaBattlePlayType.kNormal then
		self._arenaSystem:requestReportDetail(self._data.resultData.reportId)
	elseif self._replayType == ArenaBattlePlayType.kReport then
		if self._isFromNewArena then
			self._arenaNewSystem:requestReportDetail(self._data.resultData:getId())
		else
			self._arenaSystem:requestReportDetail(self._data.resultData:getId())
		end
	end
end

function ArenaVictoryMediator:onClickExit(sender, eventType, oppoRecord)
	local data

	if self._replayType == ArenaBattlePlayType.kNormal then
		data = {
			viewName = "ArenaView"
		}
	elseif self._replayType == ArenaBattlePlayType.kReport then
		local var_13_0 = {}

		if self._isFromNewArena then
			var_13_0.viewName = self._arenaNewSystem:getShowViewAfterBattle() or self._arenaSystem:getShowViewAfterBattle()
		end

		data = var_13_0
	end

	local retData = self._data.retData
	local pushPacakge = not not (self._data.retData and self._data.retData.refreshRival == true and not self._win)

	BattleLoader:popBattleView(self, data)

	if self._isFromNewArena and retData.refreshRival then
		self._arenaNewSystem:requestGainChessArena()

		local dispatcher = DmGame:getInstance()

		dispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, dispatcher:getInjector():getInstance(self._arenaNewSystem:getShowViewAfterBattle()), nil, {
			pushPacakge = pushPacakge
		}))
	end
end

function ArenaVictoryMediator:onClickShow()
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:find("ARENAVIEW_NOTICE")
	}))
end

function ArenaVictoryMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local button_exit = self:getView():getChildByFullName("bg.button_panel.button_exit")

		storyDirector:setClickEnv("ArenaVictoryMediator.button_exit", button_exit, function(sender, eventType)
			self:onClickExit(sender, eventType)
		end)
		storyDirector:notifyWaiting("enter_ArenaVictoryMediator")
	end))

	self:getView():runAction(sequence)
end

function ArenaVictoryMediator:onTouchMaskLayer()
	return
end
