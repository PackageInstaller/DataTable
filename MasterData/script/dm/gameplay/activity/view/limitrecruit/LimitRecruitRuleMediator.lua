-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/limitrecruit/LimitRecruitRuleMediator.lua

LimitRecruitRuleMediator = class("LimitRecruitRuleMediator", DmPopupViewMediator, _M)

LimitRecruitRuleMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function LimitRecruitRuleMediator:initialize()
	super.initialize(self)
end

function LimitRecruitRuleMediator:dispose()
	super.dispose(self)
end

function LimitRecruitRuleMediator:userInject()
	return
end

function LimitRecruitRuleMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")

	self._listView:setLocalZOrder(99999)
	self._listView:setScrollBarEnabled(false)

	self._descClone = self._main:getChildByName("desc")

	self._descClone:setVisible(false)

	self._titleClone = self._main:getChildByName("title")

	self._titleClone:setVisible(false)

	self._rewardClone = self._main:getChildByName("reward")

	self._rewardClone:setVisible(false)
end

function LimitRecruitRuleMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._ruleList = data.ruleList or ConfigReader:getDataByNameIdAndKey("ConfigValue", "LimitRecruit_RuleTitle", "content")
	self._main = self:getView():getChildByName("main")

	local bgNode = self._main:getChildByFullName("bg")

	self:bindWidget(bgNode, PopupNormalWidget, {
		title = "规则",
		ignoreBtnBg = true,
		btnHandler = bind1(self.onClickClose, self)
	})
	self:setupView()
end

function LimitRecruitRuleMediator:setupView()
	self:addTitle("基本规则")

	for i, v in pairs(self._ruleList) do
		local ruleStr = Strings:get(v, {
			score = self._activity:getOnceScore()
		})

		if ruleStr and ruleStr ~= "" then
			self:addRuleContent(ruleStr)
		else
			break
		end
	end

	self:addTitle(Strings:get("StageArena_EN05"))

	local rewardList = self._activity:getActivityTimeLimit()

	for i, v in pairs(rewardList) do
		self:addRewardPanel(v)
	end
end

function LimitRecruitRuleMediator:addRuleContent(desc)
	local kMaxWidth = 520
	local panel = self._descClone:clone()
	local panelSize = panel:getContentSize()

	panel:setVisible(true)

	local descText = panel:getChildByName("Text_desc")

	descText:setVisible(false)

	local textData = string.split(desc, "<font")

	if #textData <= 1 then
		local str = "<font face='asset/font/CustomFont_FZYH_R.TTF' size='22' color='#FFFFFF'>${desc}</font>"
		local t = TextTemplate:new(str)

		desc = t:stringify({
			desc = desc
		})
	end

	local descLabel = ccui.RichText:createWithXML(desc, {})

	descLabel:setAnchorPoint(cc.p(0, 0.5))
	descLabel:ignoreContentAdaptWithSize(false)
	descLabel:renderContent(kMaxWidth, 0)

	local labelSize = descLabel:getContentSize()

	panel:setContentSize(cc.size(panelSize.width + 5, labelSize.height + 10))
	descLabel:addTo(panel):center(panel:getContentSize()):offset(-7, 3)
	self._listView:pushBackCustomItem(panel)
end

function LimitRecruitRuleMediator:addTitle(title)
	local panel = self._titleClone:clone()
	local titleText = panel:getChildByName("Text_des")

	titleText:setString(title)

	local panelSize = panel:getContentSize()

	panel:setVisible(true)
	panel:setContentSize(cc.size(panelSize.width, 5 + panelSize.height))
	self._listView:pushBackCustomItem(panel)
end

function LimitRecruitRuleMediator:addRewardPanel(id)
	local config = ConfigReader:getRecordById("RankReward", id)
	local panel = self._rewardClone:clone()

	panel:setVisible(true)

	local descText = panel:getChildByName("Text_des")
	local rankStr = ""

	rankStr = config.Rank[1] == config.Rank[2] and config.Rank[1] or config.Rank[1] .. "-" .. config.Rank[2]

	descText:setString(Strings:get("TimeLimit_Hero_RankRule1", {
		rank = rankStr,
		score = config.Score
	}))

	local rewardPanel = panel:getChildByName("Panel_reward")
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", config.Reward, "Content")

	for i = 1, 4 do
		local reward = rewards[i]

		if reward then
			local icon = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			icon:addTo(rewardPanel):setScale(0.63)
			icon:setPosition((i - 1) * 80 + 35, 35)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
				swallowTouches = true,
				needDelay = true
			})
		end
	end

	self._listView:pushBackCustomItem(panel)
end

function LimitRecruitRuleMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
