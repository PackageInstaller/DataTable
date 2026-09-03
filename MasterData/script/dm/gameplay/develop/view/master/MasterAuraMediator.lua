-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterAuraMediator.lua

local namekey = {
	"ATK",
	"DEF",
	"HP",
	"SPEED"
}

function MasterCultivateMediator:refeshAuraView()
	self._auraCellList = {}
	self._auraConfigList = self._player:getMasterAura():getAuraData()

	for i = 1, 4 do
		self._auraCellList[i] = self._layouts[5]:getChildByFullName("auracell_" .. i)

		local auraImg = self._auraCellList[i]:getChildByFullName("auraImg")

		auraImg:setVisible(false)

		local aurabtn = self._auraCellList[i]:getChildByFullName("auraBtn")
		local key = namekey[i]
		local info = self:getAuraInfoById(key)

		self._auraCellList[i]:getChildByFullName("auraName"):setString(Strings:find(info[3]) .. "  Lv." .. tostring(self._auraConfigList[key].Level))

		local auraEffect = self:getAuraEffectAttrByType(key)
		local nextAuraEffect = self:getAuraNextEffectByType(key, self._auraConfigList[key].Level)
		local desc = Strings:get(info[4], {
			num = math.floor(auraEffect),
			fontName = TTF_FONT_FZYH_M,
			numAdd = math.floor(nextAuraEffect) - math.floor(auraEffect)
		})
		local label_desc = ccui.RichText:createWithXML(desc, {})

		label_desc:rebuildElements()
		label_desc:formatText()
		label_desc:renderContent()
		label_desc:setPosition(0, 0)
		label_desc:setAnchorPoint(0, 0.5)
		self._auraCellList[i]:getChildByFullName("auraDesc"):removeAllChildren()
		self._auraCellList[i]:getChildByFullName("auraDesc"):addChild(label_desc)

		local price = self._auraConfigList[key].Price

		if price then
			self._auraCellList[i]:getChildByFullName("sourcepanel"):setVisible(true)
			aurabtn:setVisible(true)
			self._auraCellList[i]:getChildByFullName("con_1"):setVisible(true)

			local needprice = price[1].amount
			local itemId = price[1].id
			local count = self._bagSystem:getItemCount(itemId)
			local config = ConfigReader:getRecordById("ItemConfig", tostring(itemId))
			local info = {
				id = itemId
			}
			local iconpanel = self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.iconpanel")

			iconpanel:removeAllChildren()

			local costIcon = IconFactory:createPic(info)

			costIcon:setScale(0.8)
			costIcon:addTo(iconpanel)
			costIcon:setPosition(cc.p(iconpanel:getContentSize().width / 2, iconpanel:getContentSize().height / 2 - 2))
			costIcon:setGray(count < needprice)

			if itemId == CurrencyIdKind.kCrystal then
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.costPanel"):setVisible(false)
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.cost"):setVisible(true)
			else
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.costPanel"):setVisible(true)
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.cost"):setVisible(false)
			end

			local cost_text = self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.costPanel.cost")
			local costLimit_text = self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.costPanel.costLimit")
			local costPanel = self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.costPanel")

			costLimit_text:setString("/" .. needprice)
			cost_text:setString(count)
			costLimit_text:setPositionX(cost_text:getContentSize().width)
			costPanel:setContentSize(cc.size(cost_text:getContentSize().width + costLimit_text:getContentSize().width, 40))
			self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.cost"):setString(needprice)

			if needprice <= count then
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.bg.enoughImg"):setVisible(true)
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.addImg"):setVisible(false)
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.costPanel.costLimit"):setTextColor(GameStyle:getColor(1))
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.costPanel.cost"):setTextColor(GameStyle:getColor(1))
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.cost"):setTextColor(GameStyle:getColor(1))
			else
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.bg.enoughImg"):setVisible(false)
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.addImg"):setVisible(true)
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.costPanel.costLimit"):setTextColor(GameStyle:getColor(7))
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.costPanel.cost"):setTextColor(GameStyle:getColor(7))
				self._auraCellList[i]:getChildByFullName("sourcepanel.costBg.cost"):setTextColor(GameStyle:getColor(7))
			end

			self._auraCellList[i]:getChildByFullName("con_1.w_1"):setString(self:getAllMasterStar())
			self._auraCellList[i]:getChildByFullName("con_1.w_2"):setString(self._auraConfigList[key].NeedMasterStar)
		else
			self._auraCellList[i]:getChildByFullName("sourcepanel"):setVisible(false)
			aurabtn:setVisible(false)
			self._auraCellList[i]:getChildByFullName("con_1"):setVisible(false)
		end
	end
end

function MasterCultivateMediator:checkAuraMoney(key)
	self._auraConfigList = self._player:getMasterAura():getAuraData()

	local price = self._auraConfigList[key].Price
	local needprice = price[1].amount
	local itemId = price[1].id
	local count = self._bagSystem:getItemCount(itemId)
	local have = self._developSystem:getCrystal()

	return needprice <= have, itemId
end

function MasterCultivateMediator:checkAuraStar(key)
	self._auraConfigList = self._player:getMasterAura():getAuraData()

	return self:getAllMasterStar() >= self._auraConfigList[key].NeedMasterStar
end

function MasterCultivateMediator:checkMatsreLevel(key)
	return self._developSystem:getLevel() > self._auraConfigList[key].Level
end

function MasterCultivateMediator:getAuraInfoById(id)
	self._auraInfoConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MasterAuraList", "content")

	for k, v in pairs(self._auraInfoConfig) do
		if id == v[2] then
			return v
		end
	end
end

function MasterCultivateMediator:onClickAuraLvUp(index)
	if not self:checkMatsreLevel(namekey[index]) then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("MASTER_AURA_UP_LEVEL")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local auraConfigList = self._player:getMasterAura():getAuraData()
	local key = namekey[index]
	local price = auraConfigList[key].Price
	local needprice = price[1].amount
	local itemId = price[1].id
	local count = self._bagSystem:getItemCount(itemId)

	if count < needprice then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		if itemId == CurrencyIdKind.kCrystal then
			self:onClickGetCrystal()

			return
		else
			local view = self:getInjector():getInstance("MasterBuyAuraItemView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view))

			return
		end
	end

	if self:checkAuraStar(namekey[index]) then
		AudioEngine:getInstance():playEffect("Se_Alert_Character_Levelup", false)
		self._masterSystem:requestMasterAuraUp(namekey[index])
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("MASTER_AURA_STAR")
		}))
	end
end

function MasterCultivateMediator:getAuraEffectAttrByType(type)
	return self:getSelectedMasterData():getAuraEffectByType(type)
end

function MasterCultivateMediator:getAuraNextEffectByType(type, level)
	return MasterAttribute:getAuraAttr(type, level + 1, self._player)
end

function MasterCultivateMediator:refeshAura(response)
	self:refeshAuraView()
end

function MasterCultivateMediator:initAuraNodes()
	self._auraConfigList = self._player:getMasterAura():getAuraData()

	local layout_5 = self._main:getChildByFullName("layout_5")

	for i = 1, 4 do
		local sourcepanel = layout_5:getChildByFullName("auracell_" .. i .. ".sourcepanel")
		local addImg = sourcepanel:getChildByFullName("costBg.addImg")

		GameStyle:runCostAnim(sourcepanel)
		addImg:setTouchEnabled(true)
		addImg:addClickEventListener(function()
			local key = namekey[i]
			local price = self._auraConfigList[key].Price
			local itemId = price[1].id

			if itemId == CurrencyIdKind.kCrystal then
				self:onClickGetCrystal()
			else
				local view = self:getInjector():getInstance("MasterBuyAuraItemView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view))
			end
		end)

		local addAnim = cc.MovieClip:create("jiahao_yinghun_shengpinjiahao")

		addAnim:addTo(addImg)
		addAnim:setPosition(cc.p(25, 22))
		addAnim:setScale(0.8)
	end
end
