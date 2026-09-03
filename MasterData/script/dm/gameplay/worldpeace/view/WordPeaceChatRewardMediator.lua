-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceChatRewardMediator.lua

WordPeaceChatRewardMediator = class("WordPeaceChatRewardMediator", DmPopupViewMediator, _M)

WordPeaceChatRewardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WordPeaceChatRewardMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

function WordPeaceChatRewardMediator:initialize()
	super.initialize(self)
end

function WordPeaceChatRewardMediator:dispose()
	super.dispose(self)
end

function WordPeaceChatRewardMediator:onRegister()
	super.onRegister(self)
	bindWidget(self, "bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:find("ClubMapBoss_Reward_Rank")
	})
end

function WordPeaceChatRewardMediator:enterWithData(data)
	for k, v in pairs(data) do
		local icon = IconFactory:createRewardIcon(v, {
			showAmount = true,
			isWidget = true
		})
		local reward = self:getView():getChildByName("node" .. k)

		icon:addTo(reward):center(reward:getContentSize())
		icon:setScale(0.8)
	end

	self._worldPeace = self._worldPeaceSystem:getWorldPeace()

	local status = self._worldPeace:getRewardStatusByType(WPRewardType.kClubSeason)

	if status == 2 then
		self:getView():getChildByName("ok"):getChildByName("Text_37"):setString(Strings:get("ClubGift_Tips_7"))
	end

	self:getView():getChildByName("ok"):addClickEventListener(function()
		local status = self._worldPeace:getRewardStatusByType(WPRewardType.kClubSeason)

		print(status)

		if status == 0 then
			return
		end

		if status == 2 then
			return
		end

		self._worldPeaceSystem:requestReward(WPRewardType.kClubSeason)
		self:close()
	end)
	self:getView():getChildByName("time"):setString(self._worldPeace:getJoinDay() .. "/3")
	self:getView():getChildByName("time_0"):setString(self._worldPeace:getJoinChatDay() .. "/3")
end

function WordPeaceChatRewardMediator:onClickClose()
	self:close()
end
