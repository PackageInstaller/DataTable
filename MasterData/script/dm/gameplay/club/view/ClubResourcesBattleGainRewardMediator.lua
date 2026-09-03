-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubResourcesBattleGainRewardMediator.lua

ClubResourcesBattleGainRewardMediator = class("ClubResourcesBattleGainRewardMediator", DmPopupViewMediator)

ClubResourcesBattleGainRewardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubResourcesBattleGainRewardMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {}

function ClubResourcesBattleGainRewardMediator:initialize()
	super.initialize(self)
end

function ClubResourcesBattleGainRewardMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ClubResourcesBattleGainRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local view = self:getView()
end

function ClubResourcesBattleGainRewardMediator:initNodes()
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
end

function ClubResourcesBattleGainRewardMediator:onDoRefrsh(event)
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
	end
end

function ClubResourcesBattleGainRewardMediator:enterWithData(data)
	self._viewType = data.baseOrWin
	self._mainData = data.mainData
	self._rewardId = self._mainData.baseBoxRewardId

	if data.baseOrWin == 2 then
		self._rewardId = self._mainData.winBoxRewardId
	end

	self:initNodes()

	self._clubBossInfo = self._developSystem:getPlayer():getClub():getClubBossInfo(self._viewType)

	local currentSeasonConfig = self._clubBossInfo:getCurrentSeasonConfig()

	if self._rewardId ~= nil and self._rewardId ~= "" then
		self._rewardsData = ConfigReader:getRecordById("Reward", self._rewardId).Content

		self:setUi()
	end
end

function ClubResourcesBattleGainRewardMediator:setUi()
	local text1 = self._main:getChildByFullName("text1")

	text1:setString(Strings:get("Club_ResourceBattle_12", {
		num = self._mainData.index
	}))

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

			if self._viewType == 1 then
				if not self._mainData.baseRewardHasGet then
					local hasGet = self._mainData.winRewardHasGet

					if hasGet then
						self._sureBtn:setButtonName(Strings:get("clubBoss_39"), Strings:get("clubBoss_40"))
					end

					if self._viewType == 1 then
						if not self._mainData.canBaseReward then
							local canGet = self._mainData.canWinReward

							if canGet == false then
								self._sureBtn:setGray(true)
							end
						end
					end
				end
			end
		end
	end
end

function ClubResourcesBattleGainRewardMediator:onOKClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._viewType == 1 then
			if not self._mainData.baseRewardHasGet then
				local hasGet = self._mainData.winRewardHasGet

				if hasGet then
					return
				end

				if self._viewType == 1 then
					if not self._mainData.canBaseReward then
						local canGet = self._mainData.canWinReward

						if canGet then
							self._clubSystem:requestClubBattleReward(self._mainData.index, self._viewType - 1)
							self:close()
						elseif self._viewType == 2 and self._mainData.winScoreEnough == true then
							self:dispatch(ShowTipEvent({
								duration = 0.35,
								tip = Strings:get("Club_ResourceBattle_13")
							}))
						else
							self:dispatch(ShowTipEvent({
								duration = 0.35,
								tip = Strings:get("Club_ResourceBattle_12", {
									num = self._mainData.index
								})
							}))
						end
					end
				end
			end
		end
	end
end

function ClubResourcesBattleGainRewardMediator:onCloseClicked(sender, eventType)
	self:close()
end
