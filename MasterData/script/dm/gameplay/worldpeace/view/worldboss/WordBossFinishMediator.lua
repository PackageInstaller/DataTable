-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/worldboss/WordBossFinishMediator.lua

WordBossFinishMediator = class("WordBossFinishMediator", DmPopupViewMediator, _M)

WordBossFinishMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")
WordBossFinishMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
WordBossFinishMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WordBossFinishMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

local kBtnHandlers = {}

function WordBossFinishMediator:initialize()
	super.initialize(self)
end

function WordBossFinishMediator:dispose()
	local rewardStatus = self._worldPeaceSystem:getWorldBoss():getRewardStatus()
	local inBattle = self._worldPeaceSystem:isBattleTime()

	if not inBattle and rewardStatus == 0 then
		self._worldPeaceSystem:getBossRewards({})
	end

	super.dispose(self)
end

function WordBossFinishMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_BATTLEFEILD_REFRESH, self, self.updateInfo)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDBOSS_CANREWARD, self, self.refreshRewardBtnState)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.onDoReset)
end

function WordBossFinishMediator:enterWithData(data)
	self._main = self:getView():getChildByName("main")

	local bgNode = self._main:getChildByFullName("bgNode")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onClickClose, self),
		title = Strings:get("WorldBoss_UI05")
	})
	self:bindWidget("main.btn_ok", TwoLevelMainButton, {
		handler = bind1(self.onOkClicked, self)
	})

	self._bossId = data.bossId
	self._parent = data.parent

	local box = self._main:getChildByName("Image_box")

	self._boxImg = box

	self:updateInfo()

	local fix_shijieboss = cc.MovieClip:create("loop_shijieboss")

	fix_shijieboss:addTo(box:getParent())
	fix_shijieboss:setPosition(box:getPosition())
	fix_shijieboss:setLocalZOrder(1)
	box:setLocalZOrder(2)
	fix_shijieboss:setName("boxAnim")

	local fix_shijieboss = cc.MovieClip:create("max_shijieboss")

	fix_shijieboss:addTo(box:getParent())
	fix_shijieboss:setPosition(box:getPosition())
	fix_shijieboss:setLocalZOrder(1)
	box:setLocalZOrder(2)
	fix_shijieboss:setName("boxMaxAnim")
	fix_shijieboss:setVisible(true)
	box:changeParent(fix_shijieboss:getChildByName("box"))
	box:center(fix_shijieboss:getChildByName("box"):getContentSize())
	fix_shijieboss:gotoAndStop(1)

	self._boxAnim = fix_shijieboss

	fix_shijieboss:addEndCallback(function(cid, mc)
		fix_shijieboss:gotoAndStop(1)
	end)
end

function WordBossFinishMediator:checkIsFinish()
	local worldBoss = self._worldPeaceSystem:getWorldBoss()
	local startAttackTime = worldBoss:getLastAttackTime() * 0.001

	self._gameServerAgent = DmGame:getInstance()._injector:getInstance("GameServerAgent")

	local curTime = self._gameServerAgent:remoteTimestamp()
	local challengeTime = ConfigReader:getRecordById("ConfigValue", "WorldBoss_ChallengeTime").content

	return (curTime > challengeTime + startAttackTime or nil) and true
end

function WordBossFinishMediator:updateInfo()
	local bossCfg = ConfigReader:getRecordById("WorldBoss", self._bossId)
	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossData = battleField:getBossById(self._bossId)
	local bossIndex = bossData:getIndex()
	local rewardConfig = bossCfg.DmgReward
	local rewards = {}

	for i = 1, (bossData:getHpr() > 0 or nil) and bossIndex do
		local isExtra, time = self._worldPeaceSystem:isWorldBossExtraRewardTime()

		rewards[#rewards + 1] = isExtra and rewardConfig[i].RewardS or rewardConfig[i].Reward
	end

	self._main:getChildByName("text_num"):setString("x" .. #rewards)

	local isFinish = self:checkIsFinish()

	self._main:getChildByName("text_content"):setVisible(not isFinish)

	local list = self._main:getChildByName("list")
	local cell = self._main:getChildByName("cell")
	local allrewards = {}

	for k, v in pairs(rewards) do
		local rewardConfig = ConfigReader:getRecordById("Reward", tostring(v))

		if rewardConfig then
			for k_, v_ in pairs(rewardConfig.Content) do
				allrewards[#allrewards + 1] = v_
			end
		end
	end

	self:refreshRewardBtnState()

	if table.nums(self._allrewards or {}) == table.nums(allrewards) then
		return
	end

	self._allrewards = allrewards

	list:removeAllItems()
	list:setScrollBarEnabled(false)

	local length = math.ceil(#allrewards / 8)
	local iconInstances = {}

	for i = 1, length do
		local cellclone = cell:clone()
		local index = 1

		for j = (i - 1) * 8 + 1, i * 8 do
			local v = allrewards[j]

			if v then
				local icon = IconFactory:createRewardIcon(v, {
					showAmount = true,
					isWidget = true
				})

				icon:addTo(cellclone)
				icon:setScaleNotCascade(0.5)
				icon:offset((index - 1) * 90 + 70, 50)

				index = index + 1

				icon:setOpacity(0)

				iconInstances[#iconInstances + 1] = icon
			end
		end

		list:pushBackCustomItem(cellclone)
	end

	self._initList = true

	local box = self._boxImg
	local title = self._main:getChildByName("title")
	local animIndex = 0

	for k, v in pairs(self._allrewards) do
		local icon = IconFactory:createRewardIcon(v, {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(self._main)
		icon:setScaleNotCascade(0.5)
		icon:setScale(0)
		icon:setPosition(box:getPosition())

		local pos = cc.p(title:getPosition())

		animIndex = animIndex + 1

		icon:runAction(cc.Sequence:create(cc.DelayTime:create((animIndex - 1) * 0.3), cc.Spawn:create(cc.MoveTo:create(0.3, pos), cc.ScaleTo:create(0.3, 0.4)), cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			animIndex = animIndex - 1

			icon:runAction(cc.FadeTo:create(0.1, 0))

			if animIndex <= 0 then
				-- block empty
			end

			iconInstances[k]:runAction(cc.FadeTo:create(0.2, 255))
		end)))
	end
end

function WordBossFinishMediator:refreshRewardBtnState()
	local isFinish = self:checkIsFinish()
	local rewardStatus = self._worldPeaceSystem:getWorldBoss():getRewardStatus()

	self._main:getChildByName("btn_ok"):setVisible(isFinish and rewardStatus == 1)
	self._main:getChildByName("text_content"):setVisible(not isFinish and rewardStatus ~= 1)
end

function WordBossFinishMediator:onDoReset()
	self:onClickClose()
end

function WordBossFinishMediator:onOkClicked(sender, eventType)
	self._worldPeaceSystem:getBossRewards({}, function(response)
		if DisposableObject:isDisposed(self) then
			return
		end

		if response.data and response.data.rewards then
			local rewards = response.data.rewards

			if rewards and next(rewards) then
				local delegate, outSelf = {}, self

				function delegate:willClose()
					outSelf:onClickClose()
				end

				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 200
				}, {
					rewards = rewards
				}, delegate))
			end

			self:refreshRewardBtnState()
		end
	end)
end

function WordBossFinishMediator:onClickClose(sender, eventType)
	local isFinish = self:checkIsFinish()

	self:close()

	self._parent._isOpenFinish = false

	if isFinish then
		self._parent:onClickBack()
	end
end
