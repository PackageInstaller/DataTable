-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreMapCaseAlertMediator.lua

ExploreMapCaseAlertMediator = class("ExploreMapCaseAlertMediator", DmPopupViewMediator, _M)

ExploreMapCaseAlertMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreMapCaseAlertMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")

local kBtnHandlers = {
	["main.backBtn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	["main.back"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}
local kRoleType = {
	NormalEnemy = "ts_bg_putong.png",
	EliteEnemy = "ts_bg_jingying.png",
	BossEnemy = "ts_bg_boss.png"
}
local CaseType = {
	"TYPE1",
	"TYPE2",
	"TYPE3",
	"TYPE4",
	"TYPE5"
}
local kTipImg = {
	End = "endTip"
}

function ExploreMapCaseAlertMediator:initialize()
	super.initialize(self)
end

function ExploreMapCaseAlertMediator:dispose()
	super.dispose(self)
end

function ExploreMapCaseAlertMediator:onRemove()
	super.onRemove(self)
end

function ExploreMapCaseAlertMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)

	self._rightBtn = self:bindWidget("main.rightBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickRight, self)
		}
	})
	self._middleBtn = self:bindWidget("main.middleBtn", TwoLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickMiddle, self)
		}
	})
	self._leftBtn = self:bindWidget("main.leftBtn", TwoLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickLeft, self)
		}
	})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_SETTEAM_SUCC, self, self.refreshTeam)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_ADDPOWER_SUCC, self, self.refreshTeam)
end

function ExploreMapCaseAlertMediator:enterWithData(data)
	self._caseFactor = data.caseFactor
	self._battleId = data.battleId or ""
	self._callback = data.callback
	self._caseType = data.caseType
	self._btnParam = {}

	self:initView()
	self:updateView()
end

function ExploreMapCaseAlertMediator:initView()
	self._main = self:getView():getChildByName("main")
	self._title = self._main:getChildByName("title")
	self._desc = self._main:getChildByName("desc")

	self._desc:getVirtualRenderer():setLineSpacing(6)

	self._icon = self._main:getChildByName("icon")
	self._typePanel1 = self._main:getChildByName("typePanel1")

	self._typePanel1:setVisible(false)

	self._typePanel2 = self._main:getChildByName("typePanel2")

	self._typePanel2:setVisible(false)

	self._combatPanel = self._main:getChildByName("combat")

	self._combatPanel:setVisible(false)

	self._roleType = self._main:getChildByName("type")

	self._roleType:setVisible(false)

	self._curTeamPanel = self._main:getChildByName("curTeamPanel")

	self._curTeamPanel:setVisible(false)

	self._battleTipBtn = self._curTeamPanel:getChildByName("button")

	self._battleTipBtn:setVisible(false)
	self._curTeamPanel:addClickEventListener(function()
		self:onClickAdd()
	end)
	self._battleTipBtn:addClickEventListener(function()
		self:onClickBattleTip()
	end)
	self._roleType:ignoreContentAdaptWithSize(true)
	self._leftBtn:setVisible(false)
	self._middleBtn:setVisible(false)
	self._rightBtn:setVisible(false)

	self._backBtn = self._main:getChildByName("backBtn")

	self._backBtn:setVisible(false)

	local loadingBar = self._curTeamPanel:getChildByFullName("loadingBar")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))
	GameStyle:setCommonOutlineEffect(self._desc)
	GameStyle:setCommonOutlineEffect(self._typePanel1:getChildByFullName("clonePanel.node_1.name"))
	GameStyle:setCommonOutlineEffect(self._typePanel1:getChildByFullName("clonePanel.node_1.progress"))
	GameStyle:setCommonOutlineEffect(self._typePanel1:getChildByFullName("clonePanel.node_2.name"))
	GameStyle:setCommonOutlineEffect(self._typePanel1:getChildByFullName("clonePanel.node_2.progress"))
	self._main:getChildByFullName("back"):setVisible(self._caseType and self._caseType == "BATTLE")
end

function ExploreMapCaseAlertMediator:updateView()
	local tag = self._caseFactor:getTag()

	if tag and kTipImg[tag] and self._main:getChildByName(kTipImg[tag]) then
		self._main:getChildByName(kTipImg[tag]):setVisible(true)
	end

	local btnOption = {
		["2"] = "right",
		["1"] = "left"
	}

	self._title:setString(self._caseFactor:getTitle())
	self._desc:setString(self._caseFactor:getDesc())
	self._icon:removeAllChildren()
	self:createImg(self._icon, self._caseFactor:getPic())

	local caseType = self._caseFactor:getType()

	if caseType == CaseType[1] or caseType == CaseType[2] or caseType == CaseType[3] then
		self._leftBtn:setVisible(true)
		self._rightBtn:setVisible(true)
		self._leftBtn:setButtonName(Strings:get(self._caseFactor:getOption()["1"]), "")
		self._rightBtn:setButtonName(Strings:get(self._caseFactor:getOption()["2"]), "")

		for i, v in pairs(self._caseFactor:getOption()) do
			self._btnParam[btnOption[i]] = {
				param = i
			}
		end

		if caseType ~= CaseType[1] then
			self._typePanel2:setVisible(true)
			self._typePanel2:getChildByName("title"):setString(Strings:get("EXPLORE_UI14"))

			local rewards = RewardSystem:getRewardsById(self._caseFactor:getReward())

			for i = 1, #rewards do
				local panel = self._typePanel2:getChildByName("node_" .. i)

				if panel then
					local rewardData = rewards[i]

					panel:removeAllChildren()

					local rewardIcon = IconFactory:createRewardIcon(rewardData, {
						isWidget = true
					})

					IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), rewardData, {
						needDelay = true
					})
					rewardIcon:setAnchorPoint(cc.p(0.5, 0.5))
					rewardIcon:addTo(panel):center(panel:getContentSize())
					rewardIcon:setScaleNotCascade(0.8)
				end
			end

			if self._battleId ~= "" then
				local config = ConfigReader:requireRecordById("MapBattlePoint", self._battleId) or {}
				local specialRuleShow = config.SpecialRuleShow
				local type = config.Type

				if type and kRoleType[type] then
					self._roleType:setVisible(true)
					self._roleType:loadTexture(kRoleType[type], 1)
					self._roleType:setPositionX(self._title:getPositionX() + self._title:getContentSize().width + 30)
				end

				if specialRuleShow then
					self._battleTipBtn:setVisible(true)
				end

				self._curTeamPanel:setVisible(true)
			end

			if caseType == CaseType[3] then
				local factor = self._caseFactor:getBpFactor()

				if factor then
					self._combatPanel:setVisible(true)
					self._combatPanel:getChildByName("combat"):setString(factor)

					if self._roleType:isVisible() then
						self._combatPanel:setPositionX(self._roleType:getPositionX() + self._roleType:getContentSize().width)
					else
						self._combatPanel:setPositionX(self._title:getPositionX() + self._title:getContentSize().width + 30)
					end
				end
			end

			local titleLbl = self._combatPanel:getChildByName("title")
			local combatLbl = self._combatPanel:getChildByName("combat")
			local combatLbl = self._combatPanel:getChildByName("combat")

			combatLbl:setPositionX(titleLbl:getPositionX() + titleLbl:getContentSize().width + combatLbl:getContentSize().width / 2 + 5)
			self._combatPanel:setContentSize(cc.size(titleLbl:getContentSize().width + combatLbl:getContentSize().width + 40, self._combatPanel:getContentSize().height))
			self:refreshTeam()
		end
	elseif caseType == CaseType[4] then
		self._leftBtn:setVisible(true)
		self._rightBtn:setVisible(true)
		self._leftBtn:setButtonName(Strings:get(self._caseFactor:getOption()["1"]), "")
		self._rightBtn:setButtonName(Strings:get(self._caseFactor:getOption()["2"]), "")

		for i, v in pairs(self._caseFactor:getOption()) do
			self._btnParam[btnOption[i]] = {
				param = i
			}

			if self._caseFactor:getCheckOption() and self._caseFactor:getCheckOption() == i and self._exploreSystem:getItemCount(self._caseFactor:getNeedItem()) < self._caseFactor:getNeedNum() then
				self._btnParam[btnOption[i]] = {
					forbid = self._caseFactor:getCheckDes()
				}
			end
		end

		self._typePanel2:setVisible(true)
		self._typePanel2:getChildByName("title"):setString(Strings:get("EXPLORE_UI47"))

		local panel = self._typePanel2:getChildByName("node_1")

		panel:removeAllChildren()

		local info = {
			id = self._caseFactor:getNeedItem(),
			amount = self._caseFactor:getNeedNum()
		}
		local needItem = IconFactory:createIcon(info, {
			isWidget = true
		})

		needItem:addTo(panel):center(panel:getContentSize())
		needItem:setScale(0.8)

		if needItem.getAmountLabel then
			needItem:getAmountLabel():setString(self._exploreSystem:getItemCount(self._caseFactor:getNeedItem()) .. "/" .. self._caseFactor:getNeedNum())
			needItem:adjustAmountBg()
		end

		info = {
			code = self._caseFactor:getNeedItem(),
			amount = self._exploreSystem:getItemCount(self._caseFactor:getNeedItem()),
			type = RewardType.kItem
		}

		IconFactory:bindTouchHander(needItem, IconTouchHandler:new(self), info, {
			hideTipAmount = true,
			showAmount = false,
			needDelay = true
		})
	elseif caseType == CaseType[5] then
		self._typePanel1:setVisible(true)

		local clonePanel = self._typePanel1:getChildByName("clonePanel")

		clonePanel:setVisible(false)

		local listView = self._typePanel1:getChildByName("listView")

		listView:setScrollBarEnabled(false)

		if self._caseFactor:getOption().out then
			self._middleBtn:setVisible(true)

			self._btnParam.middle = {
				param = "out"
			}

			local string = self._caseFactor:getOption().out[next(self._caseFactor:getOption().out)]

			self._middleBtn:setButtonName(Strings:get(string), "")
		end

		local length = math.ceil(#self._caseFactor:getOrder() / 2)

		for i = 1, length do
			local node = clonePanel:clone()

			node:setVisible(true)

			for j = 1, 2 do
				local panel = node:getChildByName("node_" .. j)

				panel:setVisible(false)

				local index = 2 * (i - 1) + j
				local param = self._caseFactor:getOption()[self._caseFactor:getOrder()[index]]

				if param then
					panel:setVisible(true)
					panel:addClickEventListener(function()
						self:onClickPanel(self._caseFactor:getOrder()[index])
					end)
					panel:getChildByName("name"):setString(Strings:get(param.optionDesc))

					local iconBg = panel:getChildByName("iconBg")
					local itemPanel = panel:getChildByName("itemPanel")

					itemPanel:setVisible(false)
					iconBg:setVisible(false)

					local progress = panel:getChildByName("progress")

					progress:setVisible(false)
					GameStyle:setCommonOutlineEffect(progress, 127)

					if param.item then
						iconBg:setVisible(true)
						itemPanel:setVisible(true)
						progress:setVisible(true)
						itemPanel:removeAllChildren()

						local needItem = IconFactory:createItemIcon({
							id = param.item
						})
						local scale = 0.5

						needItem:setScale(scale)

						if needItem.getAmountLabel then
							local label = needItem:getAmountLabel()

							label:setScale(0.8 / scale)
							label:enableOutline(cc.c4b(0, 0, 0, 255), 2)
						end

						needItem:addTo(itemPanel):center(itemPanel:getContentSize())
						progress:setString(self._exploreSystem:getItemCount(param.item) .. "/" .. param.num)
					end
				end
			end

			listView:pushBackCustomItem(node)
		end
	end
end

function ExploreMapCaseAlertMediator:createImg(parent, pic)
	local resConfig = ConfigReader:requireRecordById("MapObjectRes", pic)
	local type = resConfig.Type

	if not resConfig.PicSize then
		local resName = resConfig.Caseimg

		if not resConfig.Scale then
			local scale = {
				1,
				1
			}
			local node

			if type == 1 then
				node = cc.Sprite:createWithSpriteFrameName(resName .. ".png")

				node:setAnchorPoint(cc.p(0.5, 0.5))
			elseif type == 2 then
				node = cc.MovieClip:create(resName)

				node:offset(0, -188 + resConfig.PicSize[2] / 2 * scale[2])
			elseif type == 3 then
				local model = ConfigReader:requireRecordById("RoleModel", resName).Model

				node = RoleFactory:createRoleAnimation(model)

				node:offset(0, -158)
			elseif type == 4 then
				node = cc.Sprite:create("asset/items/" .. resName .. ".png")

				node:setAnchorPoint(cc.p(0.5, 0.5))
			elseif type == 5 then
				node = IconFactory:createRoleIconSpriteNew({
					iconType = 2,
					id = resName
				})

				node:setAnchorPoint(cc.p(0.5, 0.5))
				node:offset(0, -158)
			end

			node = node or cc.Node:create()

			node:setScale(scale[1], scale[2])
			node:addTo(parent)
		end
	end
end

function ExploreMapCaseAlertMediator:refreshTeam()
	if self._battleId == "" then
		return
	end

	self._hpMax = self._exploreSystem:getHpMax()

	local pointId = self._developSystem:getExplore():getCurPointId()
	local pointData = self._exploreSystem:getMapPointObjById(pointId)
	local currentTeamId = pointData:getCurrentTeamId() ~= "" and tonumber(pointData:getCurrentTeamId()) or 1
	local team = pointData:getTeams()[currentTeamId]
	local teamName = self._curTeamPanel:getChildByFullName("teamName")

	teamName:setString(Strings:get("EXPLORE_UI107", {
		num = currentTeamId
	}))

	local loadingBar = self._curTeamPanel:getChildByFullName("loadingBar")
	local curHp = team:getHp()

	loadingBar:setPercent(curHp / self._hpMax * 100)

	local progress = self._curTeamPanel:getChildByFullName("progress")

	progress:setString(curHp .. "/" .. self._hpMax)

	local statusImg = self._curTeamPanel:getChildByFullName("statusImg")
	local combat = self._curTeamPanel:getChildByFullName("combat")
	local status = self._exploreSystem:getHpBuff(curHp)

	if status == "" then
		statusImg:setVisible(false)
	else
		statusImg:setVisible(true)
		statusImg:loadTexture(status .. ".png", 1)
	end

	local heroes = team:getHeroes()
	local totalCombat = 0

	for k, v in pairs(heroes) do
		local heroInfo = self._heroSystem:getHeroById(v)

		totalCombat = totalCombat + heroInfo:getCombat()
	end

	local masterData = self._masterSystem:getMasterById(team:getMasterId())

	totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat

	combat:getChildByFullName("combat"):setString(totalCombat)

	if self._combatPanel:isVisible() then
		local combatNum = self._combatPanel:getChildByName("combat"):getString()

		if totalCombat < tonumber(combatNum) then
			combat:getChildByFullName("combat"):setTextColor(GameStyle:getColor(6))
		end
	end
end

function ExploreMapCaseAlertMediator:onClickAdd()
	local view = self:getInjector():getInstance("ExploreAddPowerView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil))
end

function ExploreMapCaseAlertMediator:onClickBattleTip()
	local tab = ConfigReader:getDataByNameIdAndKey("MapBattlePoint", self._battleId, "SpecialRuleShow")
	local view = self:getInjector():getInstance("StagePracticeSpecialRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		ruleList = tab
	})

	self:dispatch(event)
end

function ExploreMapCaseAlertMediator:onClickClose(sender, eventType)
	if self._callback then
		self._callback(ExploreCloseChooseId)
	end

	self:close()
end

function ExploreMapCaseAlertMediator:onClickLeft(sender, eventType)
	if self._btnParam.left.forbid then
		self:dispatch(ShowTipEvent({
			tip = self._btnParam.left.forbid
		}))

		return
	end

	if self._callback then
		self._callback(self._btnParam.left.param)
	end

	self:close()
end

function ExploreMapCaseAlertMediator:onClickMiddle(sender, eventType)
	if self._btnParam.middle.forbid then
		self:dispatch(ShowTipEvent({
			tip = self._btnParam.middle.forbid
		}))

		return
	end

	if self._callback then
		self._callback(self._btnParam.middle.param)
	end

	self:close()
end

function ExploreMapCaseAlertMediator:onClickRight(sender, eventType)
	if self._btnParam.right.forbid then
		self:dispatch(ShowTipEvent({
			tip = self._btnParam.right.forbid
		}))

		return
	end

	if self._callback then
		self._callback(self._btnParam.right.param)
	end

	self:close()
end

function ExploreMapCaseAlertMediator:onClickPanel(param)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if self._callback then
		self._callback(param)
	end

	self:close()
end

function ExploreMapCaseAlertMediator:onTouchMaskLayer()
	return
end
