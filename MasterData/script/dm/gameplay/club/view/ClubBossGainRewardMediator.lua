-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubBossGainRewardMediator.lua

ClubBossGainRewardMediator = class("ClubBossGainRewardMediator", DmPopupViewMediator)

ClubBossGainRewardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBossGainRewardMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {}

function ClubBossGainRewardMediator:initialize()
	super.initialize(self)
end

function ClubBossGainRewardMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ClubBossGainRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local view = self:getView()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_REFRESH_HURTREWARD, self, self.onDoRefrsh)
end

function ClubBossGainRewardMediator:initNodes()
	self._main = self:getView():getChildByName("main")
	self._rewardPanel = self._main:getChildByFullName("rewardPanel")
	self._sureBtn = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onOKClicked, self)
		}
	})

	local bgNode = self._main:getChildByFullName("bg")
	local tempNode = bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("clubBoss_17"),
		title1 = Strings:get("clubBoss_18")
	})

	self._haveImage = self._main:getChildByFullName("haveImage")

	self._haveImage:setVisible(false)
end

function ClubBossGainRewardMediator:onDoRefrsh(event)
	local data = event:getData()

	if data and data.viewType ~= self._viewType then
		return
	end

	self._clubBossInfo = self._developSystem:getPlayer():getClub():getClubBossInfo(self._viewType)

	if self._clubBossInfo:getHurt() < self._clubBossInfo:getHurtTarget() then
		self._sureBtn:setGray(true)
	end

	if self._clubBossInfo:getHurt() >= self._clubBossInfo:getHurtTarget() and self._clubBossInfo:getHasGetHurtAward() == true then
		self._sureBtn:setButtonName(Strings:get("clubBoss_39"), Strings:get("clubBoss_40"))
		self._haveImage:setVisible(true)
		self._sureBtn:setVisible(false)
	end
end

function ClubBossGainRewardMediator:enterWithData(data)
	if data and data.viewType then
		self._viewType = data.viewType
	end

	self:initNodes()

	self._clubBossInfo = self._developSystem:getPlayer():getClub():getClubBossInfo(self._viewType)

	local currentSeasonConfig = self._clubBossInfo:getCurrentSeasonConfig()

	if currentSeasonConfig ~= nil and currentSeasonConfig.DamageReward ~= nil then
		self._rewardsData = ConfigReader:getRecordById("Reward", currentSeasonConfig.DamageReward).Content

		self:setUi()
	end
end

function ClubBossGainRewardMediator:setUi()
	local size = self._rewardPanel:getContentSize()
	local isSingular = #self._rewardsData % 2 == 1

	self._rewardPanel:removeAllChildren()

	if isSingular then
		if not (size.width / 2) then
			local pos_x = size.width / 2 - 50

			for i = 1, #self._rewardsData do
				local node = cc.Node:create()

				if i > 1 then
					pos_x = (i - 1) % 2 == 1 and pos_x + (i - 1) / 2 * 180 or pos_x - (i - 1) / 2 * 180
				end

				node:addTo(self._rewardPanel):posite(pos_x, 0)

				local reward = self._rewardsData[i]
				local rewardIcon = IconFactory:createRewardIcon(reward, {
					isWidget = true
				})

				IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
					needDelay = true
				})
				node:addChild(rewardIcon)
				rewardIcon:setPosition(cc.p(0, 65))
				rewardIcon:setScaleNotCascade(0.7)
			end

			if self._clubBossInfo:getHurt() < self._clubBossInfo:getHurtTarget() then
				self._sureBtn:setGray(true)
			end

			if self._clubBossInfo:getHurt() >= self._clubBossInfo:getHurtTarget() and self._clubBossInfo:getHasGetHurtAward() == true then
				self._sureBtn:setButtonName(Strings:get("clubBoss_39"), Strings:get("clubBoss_40"))
				self._haveImage:setVisible(true)
				self._sureBtn:setVisible(false)
			end
		end
	end
end

function ClubBossGainRewardMediator:onOKClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._clubBossInfo:getHurt() >= self._clubBossInfo:getHurtTarget() then
			if self._clubBossInfo:getHasGetHurtAward() == false then
				self._clubSystem:requestGainClubBossDayHurtReward(self._viewType)
			end
		else
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("clubBoss_16")
			}))
		end
	end
end

function ClubBossGainRewardMediator:onCloseClicked(sender, eventType)
	self:close()
end
