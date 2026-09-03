-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeacePlayerInfoMediator.lua

WordPeacePlayerInfoMediator = class("WordPeacePlayerInfoMediator", DmPopupViewMediator, _M)

WordPeacePlayerInfoMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

local ClubMapReviveMaster = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapReviveMaster", "content")
local ClubMapBloodPrice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBloodPrice", "content")

function WordPeacePlayerInfoMediator:initialize()
	super.initialize(self)
end

function WordPeacePlayerInfoMediator:dispose()
	super.dispose(self)
end

function WordPeacePlayerInfoMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_BATTLEFEILD_REFRESH, self, self.refreshView)
end

function WordPeacePlayerInfoMediator:enterWithData(data)
	data = data or {}
	self._data = data
	self._playerItems = {}

	self:initWidgetInfo(data)
	self:initContent(data)
end

function WordPeacePlayerInfoMediator:refreshView()
	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local heroCureTime = playerInfo:getHeroCureTime()
	local masterCureTime = playerInfo:getMasterCureTimes()
	local timeLeft = #ClubMapReviveMaster - masterCureTime

	self:getView():getChildByName("Times"):setString("TimeLeft:" .. timeLeft)

	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local targetCnt = developSystem:getBagSystem():getItemCount("IM_ClubMapPotion")
	local timeleft, cost1, cost2 = self:checkItemEnouph(masterCureTime)

	if timeleft then
		self._btn_go:setVisible(true)
		self._btn_go:getChildByName("Image_25"):setVisible(true)
		self._btn_go:getChildByName("Blood_0"):setVisible(true)
		self._btn_go:getChildByName("Image_25_0"):setVisible(true)
		self._btn_go:getChildByName("Blood_0_0"):setVisible(true)
		self._btn_go:getChildByName("Blood_0_0"):setString(cost1)
		self._btn_go:getChildByName("Blood_0"):setString(cost2)
		self:setStyle(self._btn_go:getChildByName("Blood_0"), "IR_Diamond", cost1)
		self:setStyle(self._btn_go:getChildByName("Blood_0_0"), "IM_ClubMapPotion", cost2)
	else
		self._btn_go:setVisible(false)
	end
end

function WordPeacePlayerInfoMediator:setStyle(sender, id, cost)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local cost1 = developSystem:getBagSystem():getItemCount(id)

	if cost <= cost1 then
		setTextWithFontStyle(sender, "FontTipsText")
	else
		setTextWithFontStyle(sender, "FontTSHJText")
	end
end

function WordPeacePlayerInfoMediator:checkItemEnouph(times)
	local timeleft = #ClubMapReviveMaster
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local cost1 = developSystem:getBagSystem():getItemCount("IM_ClubMapPotion")
	local cost2 = developSystem:getBagSystem():getItemCount("IR_Diamond")

	if not times then
		local price = ClubMapReviveMaster[1]

		if price <= cost1 then
			return timeleft, price, 0
		else
			local cost = (price - cost1) * ClubMapBloodPrice

			if cost <= cost2 then
				return timeleft, cost1, cost
			else
				return timeleft, cost1, cost
			end
		end
	elseif ClubMapReviveMaster[times + 1] then
		local price = ClubMapReviveMaster[times + 1]

		timeleft = #ClubMapReviveMaster - times

		if price <= cost1 then
			return timeleft, price, 0
		else
			local cost = (price - cost1) * ClubMapBloodPrice

			if cost <= cost2 then
				return timeleft, cost1, cost
			else
				return timeleft, cost1, cost
			end
		end
	else
		return nil, nil, nil
	end
end

function WordPeacePlayerInfoMediator:initWidgetInfo(data)
	if not data.title1 then
		local title1 = Strings:get("ClubMapBoss_Treat_Master")

		if not data.title2 then
			local title2 = Strings:get("ClubMapBoss_Treat_Master")

			self._bgWidget = bindWidget(self, "bg", PopupNormalWidget, {
				btnHandler = {
					clickAudio = "Se_Click_Close_2",
					func = bind1(self.onClickClose, self)
				},
				title = data.title1,
				title1 = title2
			})

			local playerIcon = self._view:getChildByName("mask")
			local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
			local player = developSystem:getPlayer()
			local headicon = IconFactory:createRoleIconSpriteNew({
				id = "Model_Master_XueZhan",
				frameId = "bustframe7_2"
			})

			headicon:setScale(0.2)
			headicon:addTo(playerIcon)
			headicon:center(playerIcon:getContentSize())
			headicon:offset(-32, -45)
			playerIcon:setScale(2.35)

			self._playerIcon = playerIcon
			self._btn_go = self:getView():getChildByName("btn_go")

			self._btn_go:addClickEventListener(function()
				local playerInfo = self._worldPeaceSystem:getMainPlayer()
				local masterCureTime = playerInfo:getMasterCureTimes()
				local timeLeft = #ClubMapReviveMaster - masterCureTime

				if timeLeft > 0 then
					if self._worldPeaceSystem:getStatus() ~= WPStatus.kBattle then
						self:dispatch(ShowTipEvent({
							tip = Strings:get("ClubMapBoss_TreatTips1")
						}))

						return
					end

					self._worldPeaceSystem:cureTeam({
						id = "MASTER"
					}, true, function()
						self:close()
						AudioEngine:getInstance():playEffect("Se_Click_Goth_Close_1", false)
					end)
				else
					self:dispatch(ShowTipEvent({
						tip = Strings:get("ClubMapBoss_TreatTips2")
					}))
				end
			end)
			self:refreshView()
		end
	end
end

function WordPeacePlayerInfoMediator:initContent(data)
	return
end

function WordPeacePlayerInfoMediator:onClickClose()
	AudioEngine:getInstance():playEffect("Se_Click_Goth_Close_1", false)
	self:close()
end
