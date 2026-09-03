-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/view/RankRewardMediator.lua

RankRewardMediator = class("RankRewardMediator", DmPopupViewMediator, _M)

RankRewardMediator:has("_rankSystem", {
	is = "rw"
}):injectWith("RankSystem")

local kBtnHandlers = {
	["main.button_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	}
}
local KTitle = {
	{
		Strings:get("RankRuleUI_7"),
		Strings:get("UITitle_EN_Zhandouli")
	},
	{
		Strings:get("RankRuleUI_8"),
		Strings:get("UITitle_EN_Zhuxianguanqia")
	},
	[9] = {
		Strings:get("RankRuleUI_9"),
		Strings:get("UITitle_EN_Jieshepaihang")
	},
	[14] = {
		Strings:get("RankRuleUI_10"),
		Strings:get("UITitle_EN_Tansuopaihang")
	},
	[51] = {
		Strings:get("RANK_Price_UI2"),
		Strings:get("UITitle_EN_Price")
	}
}

function RankRewardMediator:initialize()
	super.initialize(self)
end

function RankRewardMediator:dispose()
	super.dispose(self)
end

function RankRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function RankRewardMediator:enterWithData(data)
	self._rankType = data.rankType
	self._data = self._rankSystem:getRewardRankListData(data.rankType)
	self._rewardList = self._rankSystem:getRankRewardList()
	self._gotRewards = self._rankSystem:getRankGotRewards()

	self:initView()
	self:initContent()
end

function RankRewardMediator:initView()
	self:bindWidget("main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = KTitle[self._rankType][1],
		title1 = Strings:get("UITitle_EN_Paihang"),
		bgSize = {
			width = 840,
			height = 510
		},
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})

	if self._rankType == RankType.kClub then
		local var_5_0 = Strings:get("RankRuleUI_2")

		if not var_5_0 then
			var_5_0 = Strings:get("RankRuleUI_1")

			local txt = var_5_0

			self:getView():getChildByFullName("main.tipTxt"):setString(txt)

			local bgNode = self:getView():getChildByFullName("main.bgNode")
			local titleText = bgNode:getChildByFullName("title_node.Text_1")
			local titleTextWidth = titleText:getContentSize().width

			self:getView():getChildByFullName("main.button_rule"):setPositionX(bgNode:getPositionX() + titleTextWidth + 90)
		end
	end
end

function RankRewardMediator:initContent()
	self._listView = self:getView():getChildByFullName("main.listview")
	self._contentPanel = self:getView():getChildByFullName("main.clonePanel")

	self._contentPanel:setVisible(false)
	self._listView:setScrollBarEnabled(false)
	self._listView:setSwallowTouches(false)
	self._listView:removeAllChildren(true)

	for i = 1, #self._data do
		local panel = self._contentPanel:clone()

		panel:setVisible(true)
		self._listView:pushBackCustomItem(panel)
		self:setCellView(panel, self._data[i], i)
	end
end

function RankRewardMediator:setCellView(panel, data, index)
	local rewards = self._rewardList[data.Id]

	if rewards then
		if not #rewards then
			local _nowNum = 0
			local cellPanel = panel:getChildByFullName("cellPanel")
			local image_icon = cellPanel:getChildByFullName("image_icon")
			local image_icon_null = cellPanel:getChildByFullName("image_icon_null")

			image_icon:setVisible(not not rewards)
			image_icon_null:setVisible(not rewards)

			local maxLimitNum = 50
			local rolePanel = cellPanel:getChildByFullName("rolePanel")

			rolePanel:removeAllChildren()

			local name = cellPanel:getChildByFullName("name")

			local function callFuncGo(sender, eventType)
				local view = self:getInjector():getInstance("RankRewardTipsView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					data = rewards,
					rankType = self._rankType,
					maxLimitNum = maxLimitNum
				}))
			end

			mapButtonHandlerClick(nil, cellPanel:getChildByFullName("seekBtn"), {
				func = callFuncGo
			})
			cellPanel:getChildByFullName("seekBtn"):setVisible(rewards and true or false)

			local rankTxt1 = cellPanel:getChildByFullName("rankTxt1")

			rankTxt1:setString(Strings:get(data.ConditionDes, {
				Condition = ""
			}) .. " " .. data.Condition)

			if not rewards then
				name:setString(Strings:get("RankRuleUI_4"))
			else
				name:setString(rewards[1].nickname)

				if self._rankType == RankType.kClub then
					local icon = IconFactory:createClubIcon({
						id = rewards[1].headImg
					})

					icon:addTo(rolePanel):center(rolePanel:getContentSize()):offset(0, 0)
				else
					local headIcon, oldIcon = IconFactory:createPlayerIcon({
						clipType = 4,
						id = rewards[1].headImg,
						size = rolePanel:getContentSize(),
						headFrameId = rewards[1].headFrame
					})

					headIcon:addTo(rolePanel):center(rolePanel:getContentSize())
					oldIcon:setScale(0.5)
					headIcon:setScale(0.55)
				end
			end

			for k, dataReward in pairs(data.StageRank) do
				local obtainType = tonumber(k) - 1
				local iconPanel = panel:getChildByFullName("iconPanel_" .. k)
				local rewardIcon = iconPanel:getChildByFullName("iconPanel")
				local rewardId = ""
				local limitNum = 0

				for kk, v in pairs(dataReward) do
					rewardId = v
					limitNum = tonumber(kk)
					maxLimitNum = limitNum

					break
				end

				local rewardData = RewardSystem:getRewardsById(tostring(rewardId))
				local icon = IconFactory:createRewardIcon(rewardData[1], {
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData[1], {
					needDelay = true
				})
				icon:addTo(rewardIcon):center(rewardIcon:getContentSize()):setName("rewardIcon")
				icon:setScaleNotCascade(0.5)

				local rewordIconPanel = iconPanel:getChildByFullName("iconPanel")
				local touchPanel = iconPanel:getChildByFullName("touchPanel")

				touchPanel:setSwallowTouches(false)

				local rewordIconPanelChil = rewordIconPanel:getChildByFullName("iconPanel")
				local image_icon_0 = rewordIconPanel:getChildByFullName("image_icon_0")
				local rewardData = RewardSystem:getRewardsById(tostring(rewardId))
				local icon = IconFactory:createRewardIcon(rewardData[1], {
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData[1], {
					needDelay = true
				})
				icon:addTo(rewordIconPanelChil):center(rewordIconPanelChil:getContentSize()):setName("rewardIcon")
				icon:setScaleNotCascade(0.5)
				iconPanel:getChildByFullName("getImg"):setVisible(false)

				local playerMaxNum_lbl = iconPanel:getChildByFullName("playerMaxNum_lbl")
				local str = self._rankType == RankType.kClub and "RANK_REWARDLIMITCLUB" or "RANK_REWARDLIMIT"

				playerMaxNum_lbl:setString(Strings:get(str))

				local playerNum_Max = iconPanel:getChildByFullName("playerNum_Max")
				local playerNum_Now = iconPanel:getChildByFullName("playerNum_Now")
				local nowNum = _nowNum

				nowNum = limitNum < nowNum and limitNum or nowNum

				playerNum_Now:setString(nowNum)
				playerNum_Max:setString("/" .. limitNum)
				playerNum_Max:setPositionX(playerMaxNum_lbl:getPositionX() - playerMaxNum_lbl:getContentSize().width)
				playerNum_Now:setPositionX(playerNum_Max:getPositionX() - playerNum_Max:getContentSize().width)

				local isCanGetReward = false

				if limitNum == nowNum then
					playerNum_Max:setColor(cc.c3b(181, 240, 88))
					playerNum_Now:setColor(cc.c3b(181, 240, 88))

					isCanGetReward = true
				else
					playerNum_Max:setColor(cc.c3b(255, 255, 255))
					playerNum_Now:setColor(cc.c3b(255, 255, 255))
				end

				local function notGetReward()
					image_icon_0:setVisible(false)

					local function callFuncGo(sender, eventType)
						self:dispatch(ShowTipEvent({
							tip = Strings:get("RankRuleUI_12")
						}))
					end

					touchPanel:addTouchEventListener(function(sender, eventType)
						if eventType == ccui.TouchEventType.ended then
							AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
							callFuncGo()
						end
					end)
				end

				if not rewards then
					notGetReward()
				else
					local function gotIcon()
						iconPanel:getChildByFullName("getImg"):setVisible(true)
						rewordIconPanelChil:setColor(cc.c3b(125, 125, 125))
						image_icon_0:setVisible(false)
						iconPanel:getChildByFullName("image_icon"):setColor(cc.c3b(255, 255, 255))
						self:addRedPoint(rewordIconPanel, data, false)
						rewordIconPanelChil:setTouchEnabled(false)
						touchPanel:setTouchEnabled(false)
					end

					local gotReward = self._gotRewards[(obtainType ~= 0 or nil) and data.Id .. "_" .. obtainType]

					if gotReward then
						gotIcon()
					elseif isCanGetReward then
						self:addRedPoint(rewordIconPanel, data, true)

						local function callFuncGo(sender, eventType)
							self._rankSystem:requestObtainRewardList({
								id = data.Id,
								obtainType = obtainType
							}, function()
								if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(rewordIconPanel) then
									return
								end

								gotIcon()
							end)
						end

						touchPanel:addTouchEventListener(function(sender, eventType)
							if eventType == ccui.TouchEventType.ended then
								AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
								callFuncGo()
							end
						end)
					else
						notGetReward()
					end
				end
			end
		end
	end
end

function RankRewardMediator:addRedPoint(panel, data, status)
	local redPoint = panel:getChildByName("redPoint" .. data.Id)

	if not redPoint then
		redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(panel):posite(80, 75)
		redPoint:setLocalZOrder(99901)
		redPoint:setName("redPoint" .. data.Id)
		redPoint:setScale(0.7)
	end

	redPoint:setVisible(status)
end

function RankRewardMediator:createSkillDescPanel(skillId)
	local title = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Desc")
	local desc = ConfigReader:getEffectDesc("Skill", title, skillId, 1)
	local label = ccui.RichText:createWithXML(desc, {})

	label:renderContent(568, 0)
	label:setAnchorPoint(cc.p(0, 0.5))

	return label
end

function RankRewardMediator:onClickBack()
	self:close()
end

function RankRewardMediator:onClickRule()
	local Arena_RuleTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Rank_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Arena_RuleTranslate
	}, nil)

	self:dispatch(event)
end
