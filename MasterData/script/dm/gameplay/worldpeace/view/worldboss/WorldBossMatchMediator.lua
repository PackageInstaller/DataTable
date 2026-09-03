-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/worldboss/WorldBossMatchMediator.lua

WorldBossMatchMediator = class("WorldBossMatchMediator", DmPopupViewMediator, _M)

WorldBossMatchMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldBossMatchMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

local kBtnHandlers = {}

function WorldBossMatchMediator:initialize()
	super.initialize(self)
end

function WorldBossMatchMediator:dispose()
	super.dispose(self)
end

function WorldBossMatchMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._cell = self:getView():getChildByName("cell")

	self._cell:setVisible(false)
end

function WorldBossMatchMediator:enterWithData(data)
	if data.playerData then
		local player = self._developSystem:getPlayer()
		local cell = self._cell:clone()

		cell:setVisible(true)

		local headicon, oldIcon = IconFactory:createPlayerIcon({
			clipType = 4,
			id = player:getHeadId(),
			headFrameId = player:getCurHeadFrame()
		})

		headicon:setScale(1.15)
		oldIcon:setScale(0.45)
		headicon:addTo(cell):center(cell:getContentSize())
		cell:addTo(self._main):posite(147, 248)

		local nameText = cell:getChildByName("Text_name")
		local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
		local remoteTimestamp = gameServerAgent:remoteTimestamp()
		local titleList = player:getTitleList()
		local colorStr, colorStyle = GameStyle:getTitleStr(titleList:getCurTitle(remoteTimestamp))

		if colorStr and colorStr ~= "" then
			nameText:setString("[" .. colorStr .. "]" .. player:getNickName())
		else
			nameText:setString(player:getNickName())
		end

		setTextWithFontStyle(nameText, "FontLSTCHText")
	end

	if data.matchedPlayers then
		for i, v in pairs(data.matchedPlayers) do
			local cell = self._cell:clone()

			cell:setVisible(true)

			local headicon, oldIcon = IconFactory:createPlayerIcon({
				clipType = 4,
				id = v.headImage,
				headFrameId = v.headFrame
			})

			headicon:setScale(1.15)
			oldIcon:setScale(0.45)
			headicon:addTo(cell):center(cell:getContentSize())
			cell:addTo(self._main):posite(147 + i * 170, 248)

			local nameText = cell:getChildByName("Text_name")
			local colorStr, colorStyle = GameStyle:getTitleStr(v.title)

			if colorStr and colorStr ~= "" then
				nameText:setString("[" .. colorStr .. "]" .. v.nickName)
			else
				nameText:setString(v.nickName)
			end
		end
	end

	local cd = ConfigReader:getRecordById("ConfigValue", "WorldBoss_ChallengeTime").content

	self._main:getChildByName("Text_str"):setString(Strings:get("WorldBoss_UI09", {
		Time = cd
	}))
	delayCallByTime(2000, function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guideAgent = storyDirector:getGuideAgent()

		if guideAgent:isGuiding() then
			self:close()

			local view = self:getInjector():getInstance("WordBossBattleView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				bossId = data.bossConfigId
			}))
		else
			self._worldPeaceSystem:startAttackWordBoss({}, true, function()
				self._worldPeaceSystem:createMatchPlayerBoll(data.bossConfigId)
				self:close()

				local view = self:getInjector():getInstance("WordBossBattleView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					bossId = data.bossConfigId
				}))
			end)
		end
	end)
end
