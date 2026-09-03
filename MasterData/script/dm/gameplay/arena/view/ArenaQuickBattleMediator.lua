-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaQuickBattleMediator.lua

ArenaQuickBattleMediator = class("ArenaQuickBattleMediator", DmPopupViewMediator, _M)

ArenaQuickBattleMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
ArenaQuickBattleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kArenaTimeCoin = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_ItemUse", "content")
local posWin = {
	{
		cc.p(333, 30)
	},
	{
		cc.p(303, 30),
		cc.p(473, 30)
	},
	{
		cc.p(213, 30),
		cc.p(383, 30),
		cc.p(553, 30)
	},
	{
		cc.p(133, 30),
		cc.p(313, 30),
		cc.p(463, 30),
		cc.p(643, 30)
	},
	{
		cc.p(113, 30),
		cc.p(283, 30),
		cc.p(440, 30),
		cc.p(613, 30),
		cc.p(780, 30)
	}
}
local posLose = {
	{
		cc.p(333, 30)
	},
	{
		cc.p(253, 30),
		cc.p(423, 30)
	},
	{
		cc.p(163, 30),
		cc.p(333, 30),
		cc.p(503, 30)
	},
	{
		cc.p(83, 30),
		cc.p(253, 30),
		cc.p(423, 30),
		cc.p(593, 30)
	},
	{
		cc.p(-7, 30),
		cc.p(163, 30),
		cc.p(333, 30),
		cc.p(503, 30),
		cc.p(673, 30)
	}
}

function ArenaQuickBattleMediator:initialize()
	super.initialize(self)
end

function ArenaQuickBattleMediator:dispose()
	super.dispose(self)
end

function ArenaQuickBattleMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ARENAQUICKBATTLE_SUCC, self, self.setQuickCallBack)

	self._bagSystem = self._developSystem:getBagSystem()

	self:setViewUI()
end

function ArenaQuickBattleMediator:setViewUI()
	self._main = self:getView():getChildByFullName("main")
	self._animNode = self._main:getChildByFullName("animNode")
	self._winLayout = self._main:getChildByFullName("winLayout")

	self._winLayout:setVisible(false)

	self._loseLayout = self._main:getChildByFullName("loseLayout")

	self._loseLayout:setVisible(false)

	self.panel_win = self._winLayout:getChildByFullName("panel_win")
	self._listView = self.panel_win:getChildByFullName("listView")

	self._listView:setScrollBarEnabled(false)

	self._heroPanel = self._winLayout:getChildByFullName("heroPanel")
	self._loseHeroPanel = self._loseLayout:getChildByFullName("heroPanel")

	self:bindWidget("main.winLayout.button_exit", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickButtonExit, self)
		}
	})
	self:bindWidget("main.loseLayout.btn_exit", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickButtonExit, self)
		}
	})
	self:bindWidget("main.loseLayout.btn_manualBattle", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickButtonBattle, self)
		}
	})

	local anim = cc.MovieClip:create("dajia_zhujuedajia")

	anim:addTo(self._animNode):posite(0, 0)
end

function ArenaQuickBattleMediator:enterWithData(data)
	self._data = data

	local delay = cc.DelayTime:create(1)
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		self:sendRequest()
	end))

	self._animNode:runAction(sequence)
end

function ArenaQuickBattleMediator:sendRequest()
	self._arenaSystem:requestQuickBattle(self._data.index)
end

function ArenaQuickBattleMediator:setQuickCallBack(event)
	if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self._animNode) then
		return
	end

	local resetData = event:getData().resetData

	if resetData.resCode ~= GS_SUCCESS then
		self:onClickButtonExit()

		return
	end

	self._animNode:removeAllChildren()

	if resetData.data.battleReport.attackerWin then
		self:showWinView(resetData)
	else
		self:showLoseView(resetData)
	end
end

function ArenaQuickBattleMediator:showWinView(resetData)
	if not resetData.data.battleReport.reward then
		local reward = {}

		if not resetData.data.battleReport.extraReward then
			local extraReward = 0

			for i = 1, #reward do
				local rewardData = reward[i]

				if rewardData.code == CurrencyIdKind.kHonor then
					rewardData.amount = rewardData.amount + extraReward

					break
				end
			end

			self:showReward(reward)
			self:showRole(resetData, true)

			self._winnerName = self._winLayout:getChildByFullName("action_node.winer_name")
			self._winnerRank = self._winLayout:getChildByFullName("action_node.winer_rank")
			self._winerIconBg = self._winLayout:getChildByFullName("action_node.winer_icon_bg.icon_bg")

			self._winerIconBg:removeAllChildren()

			self._winnerRankRise = self._winLayout:getChildByFullName("action_node.rankRise")

			local action_node_4 = self._winnerRankRise:getChildByFullName("action_node_4")
			local anim = cc.MovieClip:create("tisheng_jingjichangjiesuan")

			anim:addTo(action_node_4)
			anim:addEndCallback(function()
				anim:stop()
			end)
			self._winnerName:setString(resetData.data.battleReport.attacker.nickname)
			self._winnerRank:setString(Strings:get("ARENA_RESULT_RANK") .. resetData.data.rank)
			self:checkRankRaise(resetData.data.rankChange)

			local headIcon = IconFactory:createPlayerIcon({
				clipType = 2,
				id = resetData.data.battleReport.attacker.headImg,
				size = cc.size(180, 180)
			})

			headIcon:setScale(0.51)
			headIcon:addTo(self._winerIconBg):posite(47, 45)

			local winTitle = self._winLayout:getChildByName("winTitle")
			local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

			winAnim:addTo(winTitle)
			winAnim:addEndCallback(function()
				winAnim:stop()
			end)
			winAnim:setScale(0.7)

			local title = ccui.ImageView:create("zhandou_txt_win.png", 1)

			title:addTo(winTitle)
			title:setScale(0.7)
			self._winLayout:setVisible(true)
		end
	end
end

function ArenaQuickBattleMediator:checkRankRaise(raise)
	if tonumber(raise) <= 0 then
		self._winnerRankRise:setVisible(false)
	else
		self._winnerRankRise:setVisible(true)
		self._winnerRankRise:getChildByName("text"):setString(Strings:get("RANK_UI13", {
			num = raise
		}))
	end
end

function ArenaQuickBattleMediator:showLoseView(resetData)
	self:showRole(resetData, false)

	local winTitle = self._loseLayout:getChildByName("winTitle")
	local winAnim = cc.MovieClip:create("shibaiz_jingjijiesuan")

	winAnim:addTo(winTitle):posite(10, -100)
	winAnim:addEndCallback(function()
		winAnim:stop()
	end)
	winAnim:setScale(0.7)

	local title = ccui.ImageView:create("zhandou_txt_fail.png", ccui.TextureResType.plistType)

	title:addTo(winTitle):posite(0, 0)
	title:setScale(0.7)
	self._loseLayout:setVisible(true)
end

function ArenaQuickBattleMediator:onClickButtonExit()
	local data = {
		viewName = "ArenaView"
	}

	BattleLoader:popBattleView(self, data)
	self:close()
end

function ArenaQuickBattleMediator:onClickButtonBattle()
	local remainTimes = self._bagSystem:getItemCount(kArenaTimeCoin)

	if remainTimes <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_10001")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	self._arenaSystem:setShowViewAfterBattle("ArenaView")
	AudioEngine:getInstance():playEffect("Se_Click_Battle", false)
	self._arenaSystem:requestBeginBattle(self._data.index)
	self:close()
end

function ArenaQuickBattleMediator:showReward(rewards)
	self._listView:removeAllItems()

	local showRewards = {}

	for i = 1, #rewards do
		if rewards[i].type ~= RewardType.kSpecialValue then
			table.insert(showRewards, rewards[i])
		end
	end

	if #showRewards > 0 then
		for i = 1, #showRewards do
			local newPanel = ccui.Layout:create()

			newPanel:setAnchorPoint(cc.p(0, 0))
			newPanel:setContentSize(cc.size(82, 85))

			local icon = IconFactory:createRewardIcon(showRewards[i])

			icon:setScale(0.64)
			icon:addTo(newPanel):center(newPanel:getContentSize())

			local delay = cc.DelayTime:create(0.8 + (i - 1) * 0.2)

			icon:setScale(1)
			icon:setOpacity(0)

			local scale = cc.ScaleTo:create(0.2, 0.64)
			local fadeIn = cc.FadeIn:create(0.2)
			local spawn = cc.Spawn:create(scale, fadeIn)
			local seq = cc.Sequence:create(delay, spawn)

			icon:runAction(seq)
			self._listView:pushBackCustomItem(newPanel)
		end
	end
end

function ArenaQuickBattleMediator:showRole(resetData, isWin)
	if isWin then
		if not posWin then
			local pos = posLose

			if isWin then
				if not self._heroPanel then
					local heroPanel = self._loseHeroPanel

					heroPanel:removeAllChildren()

					local role = resetData.data.statist.players
					local _winnerId = resetData.data.battleReport.attacker.id

					if isWin then
						if not RoleAnimType.kStand then
							local animName = "die"
							local once = not isWin

							if role[_winnerId] then
								local unitSummary = role[_winnerId].unitSummary
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
									elseif value.type == "master" then
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
										local heroAnim = RoleFactory:createHeroAnimation(master[1].model, animName, {
											once = once
										})

										heroAnim:setAnchorPoint(cc.p(0.5, 0))
										heroAnim:addTo(heroPanel)
										heroAnim:setScale(0.65)

										local position = pos[1][1]

										heroAnim:setPosition(position)
									end
								else
									local showHeroNum = math.min(#heroes, 5)

									for i = 1, showHeroNum do
										local heroAnim, jsonPath = RoleFactory:createHeroAnimation(heroes[i].model, animName, {
											once = once
										})

										heroAnim:setAnchorPoint(cc.p(0.5, 0))
										heroAnim:addTo(heroPanel)
										heroAnim:setScale(0.65)
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
					end
				end
			end
		end
	end
end

function ArenaQuickBattleMediator:showReward(rewards)
	self._listView:removeAllItems()

	local showRewards = {}

	for i = 1, #rewards do
		if rewards[i].type ~= RewardType.kSpecialValue then
			table.insert(showRewards, rewards[i])
		end
	end

	if #showRewards > 0 then
		for i = 1, #showRewards do
			local newPanel = ccui.Layout:create()

			newPanel:setAnchorPoint(cc.p(0, 0))
			newPanel:setContentSize(cc.size(82, 85))

			local icon = IconFactory:createRewardIcon(showRewards[i])

			icon:setScale(0.64)
			icon:addTo(newPanel):center(newPanel:getContentSize())

			local delay = cc.DelayTime:create(0.8 + (i - 1) * 0.2)

			icon:setScale(1)
			icon:setOpacity(0)

			local scale = cc.ScaleTo:create(0.2, 0.64)
			local fadeIn = cc.FadeIn:create(0.2)
			local spawn = cc.Spawn:create(scale, fadeIn)
			local seq = cc.Sequence:create(delay, spawn)

			icon:runAction(seq)
			self._listView:pushBackCustomItem(newPanel)
		end
	end
end
