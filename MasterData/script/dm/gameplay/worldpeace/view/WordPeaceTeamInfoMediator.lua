-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceTeamInfoMediator.lua

WordPeaceTeamInfoMediator = class("WordPeaceTeamInfoMediator", DmPopupViewMediator, _M)

WordPeaceTeamInfoMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

local ClubMapBloodPrice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBloodPrice", "content")
local ClubMapReviveHero = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapReviveHero", "content")

function WordPeaceTeamInfoMediator:initialize()
	super.initialize(self)
end

function WordPeaceTeamInfoMediator:dispose()
	super.dispose(self)
end

function WordPeaceTeamInfoMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_BATTLEFEILD_REFRESH, self, self.refreshView)
end

function WordPeaceTeamInfoMediator:enterWithData(data)
	data = data or {}

	if data.wordPeace then
		self._wordPeace = data.wordPeace
	end

	if data.data then
		data = data.data
	end

	self._data = data
	self._playerItems = {}

	self:initWidgetInfo(data)
	self:initContent(data)
end

function WordPeaceTeamInfoMediator:refreshView(data)
	local playerInfo = self._worldPeaceSystem:getMainPlayer()

	if self._data.teamKey then
		self:initContent(playerInfo:getTeamDataList()[self._data.teamKey])
	end

	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local heroCureTime = playerInfo:getHeroCureTime()
	local timeleft, cost1, cost2 = self:checkItemEnouph(heroCureTime[self._data.teamKey])

	self:getView():getChildByName("Times"):setString(Strings:get("ClubMapBoss_Treat_Times") .. timeleft)

	if timeleft then
		self._btn_go:setVisible(true)
		self._btn_go:getChildByName("Image_25"):setVisible(cost2 ~= 0)
		self._btn_go:getChildByName("Blood_0"):setVisible(cost2 ~= 0)
		self._btn_go:getChildByName("Image_25_0"):setVisible(cost1 ~= 0)
		self._btn_go:getChildByName("Blood_0_0"):setVisible(cost1 ~= 0)
		self._btn_go:getChildByName("Blood_0_0"):setString(cost1)
		self._btn_go:getChildByName("Blood_0"):setString(cost2)

		if cost1 > 0 and cost2 > 0 then
			self._btn_go:getChildByName("Image_25_0"):setPositionX(250)
			self._btn_go:getChildByName("Image_25"):setPositionX(325)
			self._btn_go:getChildByName("Blood_0_0"):setPositionX(268)
			self._btn_go:getChildByName("Blood_0"):setPositionX(343)
		else
			self._btn_go:getChildByName("Image_25_0"):setPositionX(285)
			self._btn_go:getChildByName("Image_25"):setPositionX(285)
			self._btn_go:getChildByName("Blood_0_0"):setPositionX(303)
			self._btn_go:getChildByName("Blood_0"):setPositionX(303)
		end
	else
		self._btn_go:setVisible(false)
	end

	if self._wordPeace then
		self._btn_go:setVisible(false)
		self:getView():getChildByName("Times"):setVisible(false)
	end
end

function WordPeaceTeamInfoMediator:setStyle(sender, id, cost)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local cost1 = developSystem:getBagSystem():getItemCount(id)

	if cost <= cost1 then
		setTextWithFontStyle(sender, "FontTipsText")
	else
		setTextWithFontStyle(sender, "FontTSHJText")
	end
end

function WordPeaceTeamInfoMediator:initWidgetInfo(data)
	if not data.title1 then
		local title1 = Strings:get("ClubMapBoss_Treat_Hero")

		if not data.title2 then
			local title2 = Strings:get("ClubMapBoss_Treat_Hero")

			self._bgWidget = bindWidget(self, "nodebg", PopupNormalWidget, {
				btnHandler = {
					clickAudio = "Se_Click_Close_2",
					func = bind1(self.onClickClose, self)
				},
				title = data.title1,
				title1 = title2,
				bgSize = {
					width = 900,
					height = 545
				}
			})
			self._listView = self:getView():getChildByName("listview")
			self._cloneCell = self:getView():getChildByName("clonecell")

			self._cloneCell:setVisible(false)

			local playerInfo = self._worldPeaceSystem:getMainPlayer()
			local heroCureTime = playerInfo:getHeroCureTime()

			if not heroCureTime[self._data.teamKey] then
				local times = 0

				self._btn_go = self:getView():getChildByName("btn_go")

				self._btn_go:addClickEventListener(function()
					if times then
						local timeLeft = #ClubMapReviveHero - times

						if timeLeft > 0 then
							if self._worldPeaceSystem:getStatus() ~= WPStatus.kBattle then
								self:dispatch(ShowTipEvent({
									tip = Strings:get("ClubMapBoss_TreatTips1")
								}))

								return
							end

							self._worldPeaceSystem:cureTeam({
								id = self._data.teamKey
							}, true, function()
								self:close()
							end)
						else
							self:dispatch(ShowTipEvent({
								tip = Strings:get("ClubMapBoss_TreatTips2")
							}))
						end
					end
				end)

				if ClubMapReviveHero[heroCureTime[self._data.teamKey] + 1] then
					self._btn_go:setVisible(true)
					self._btn_go:getChildByName("Blood_0"):setString(ClubMapReviveHero[heroCureTime[self._data.teamKey] + 1])
				else
					self._btn_go:setVisible(false)
				end

				if self._wordPeace then
					self._btn_go:setVisible(false)
				end

				self:refreshView()
			end
		end
	end
end

function WordPeaceTeamInfoMediator:checkItemEnouph(times)
	local timeleft = #ClubMapReviveHero
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local cost1 = developSystem:getBagSystem():getItemCount("IM_ClubMapPotion")
	local cost2 = developSystem:getBagSystem():getItemCount("IR_Diamond")

	if not times then
		local price = ClubMapReviveHero[1]

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
	elseif ClubMapReviveHero[times + 1] then
		local price = ClubMapReviveHero[times + 1]

		timeleft = #ClubMapReviveHero - times

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
		return 0, 0, 0
	end
end

function WordPeaceTeamInfoMediator:initContent(data)
	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local combatMap = playerInfo:getHeroCombat()
	local totalCombat = 0
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()

	self._listView:setScrollBarEnabled(false)

	self._heroDataList = data.heroDataList

	for k, v in pairs(self._heroDataList) do
		totalCombat = totalCombat + combatMap[k]

		if not self._playerItems[k] then
			local item = self._cloneCell:clone()

			item:setVisible(true)

			local iconroot = item:getChildByName("icon")
			local heroCfg = ConfigReader:getRecordById("HeroBase", k)
			local modelId = heroCfg.RoleModel
			local head = ConfigReader:getRecordById("RoleModel", modelId).HeadMain

			self._listView:pushBackCustomItem(item)

			local path = IconFactory:getRoleIconPath(modelId)

			iconroot:loadTexture(path, 0)
			iconroot:setScale(2.4)

			self._playerItems[k] = item

			local bg1 = item:getChildByName("bg1"):setScale(0.6)
			local bg2 = item:getChildByName("bg2"):setScale(0.6)
			local heroInfo = heroSystem:getHeroById(k)

			bg1:loadTexture(GameStyle:getHeroRarityBg(heroCfg.Rareity)[1])
			bg2:loadTexture(GameStyle:getHeroRarityBg(heroCfg.Rareity)[2])

			local level = item:getChildByFullName("levelnum")

			level:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. heroInfo:getLevel())
			item:getChildByFullName("namebg.name"):setString(Strings:get(heroCfg.Name))

			local nextQuality = heroInfo:getNextQuality()
			local quality = {
				heroInfo:getQuality(),
				nextQuality
			}

			GameStyle:setHeroNameByQuality(item:getChildByFullName("namebg.name"), quality[1])

			local zizhi = item:getChildByFullName("zizhi.zizhidi")
			local rarity, posInfo = GameStyle:getHeroRarityImage1(heroInfo:getRarity())

			zizhi:loadTexture(rarity.img, 1)
			zizhi:ignoreContentAdaptWithSize(true)
			zizhi:setScale(0.5)
			zizhi:offset(posInfo[1] - 25)

			local star = heroInfo:getStar()

			for i = 1, HeroStarCountMax do
				local _star = item:getChildByName("star" .. i)

				_star:setVisible(false)
				_star:setVisible(i <= heroInfo:getMaxStar())

				local path = i <= star and "img_yinghun_img_star_full.png" or i == heroInfo:getStar() + 1 and heroInfo:getLittleStar() and "img_yinghun_img_star_half.png" or "img_yinghun_img_star_empty.png"

				_star:loadTexture((heroInfo:getAwakenStar() > 0 or nil) and "jx_img_star.png", ccui.TextureResType.plistType)
			end

			local combatText = item:getChildByFullName("Text_combat")

			combatText:setString(self._worldPeaceSystem:formatShowNum(combatMap[k]))
		end

		self._playerItems[k]:getChildByName("progress"):setPercent(v.hp / v.maxHp * 100)
	end

	local campName = self:getView():getChildByName("camp")
	local campImgPath = IconFactory:getPartyPath(data.camp, "building")

	if not campName.campIcon then
		local titleArray = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroPartyName", "content")

		campName:setString(Strings:get(titleArray[data.camp]))

		local campIcon = ccui.ImageView:create(campImgPath, 0)

		campIcon:setScale(1)
		campIcon:addTo(campName):posite(-30, 10)

		campName.campIcon = campIcon
	end

	local combatText = self:getView():getChildByName("totalCombat")

	combatText:setString(self._worldPeaceSystem:formatShowNum(totalCombat))
end

function WordPeaceTeamInfoMediator:addContent(content, index)
	return
end

function WordPeaceTeamInfoMediator:onClickClose()
	self:close()
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
end
