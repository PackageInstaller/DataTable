-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterEmblemMediator.lua

MasterEmblemMediator = class("MasterEmblemMediator", DmAreaViewMediator, _M)

MasterEmblemMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local kBtnHandlers = {}
local kAttrPosition = {
	kQualityPos = {
		{
			cc.p(90, -5)
		},
		{
			cc.p(90, -5),
			cc.p(378, -5)
		},
		{
			cc.p(90, 15),
			cc.p(378, 15),
			cc.p(90, -30)
		},
		{
			cc.p(90, 15),
			cc.p(378, 15),
			cc.p(90, -30),
			cc.p(378, -30)
		}
	},
	kLevelPos = {
		{
			cc.p(90, -5)
		},
		{
			cc.p(90, 15),
			cc.p(90, -30)
		},
		{
			cc.p(90, 35),
			cc.p(90, -5),
			cc.p(90, -45)
		},
		{
			cc.p(90, 40),
			cc.p(90, 10),
			cc.p(90, -25),
			cc.p(90, -55)
		}
	},
	kFullPos = {
		{
			cc.p(90, 35)
		},
		{
			cc.p(90, 55),
			cc.p(90, 10)
		},
		{
			cc.p(90, 73),
			cc.p(90, 33),
			cc.p(90, -7)
		},
		{
			cc.p(90, 90),
			cc.p(90, 55),
			cc.p(90, 15),
			cc.p(90, -20)
		}
	}
}

function MasterEmblemMediator:initialize()
	super.initialize(self)
end

function MasterEmblemMediator:dispose()
	super.dispose(self)
end

function MasterEmblemMediator:onRegister()
	super.onRegister(self)

	self._developSystem = self:getInjector():getInstance("DevelopSystem")
	self._masterSystem = self._developSystem:getMasterSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.embleminfo.levelNode.quickupBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickQuickUp, self)
		}
	})
	self:bindWidget("main.embleminfo.levelNode.upBtn", OneLevelMainButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickLevelUp, self)
		}
	})
	self:bindWidget("main.embleminfo.upQualityBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickQualityUp, self)
		}
	})
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EMBLEM_LEVELUP_SUCC, self, self.onEmblemCultivateSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EMBLEM_REFORGE_SUCC, self, self.onEmblemCultivateQualitySucc)
end

function MasterEmblemMediator:setupView(parentMedi, data)
	self._mediator = parentMedi

	self:refreshData(data.id)
	self:initNodes()
	self:setupClickEnvs()
end

function MasterEmblemMediator:refreshData(masterId)
	self._masterId = masterId
	self._masterData = self._masterSystem:getMasterById(self._masterId)
end

function MasterEmblemMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._emblemPanel = self._mainPanel:getChildByName("emblem")

	self._emblemPanel:setVisible(false)

	self._emblemCell = self._mainPanel:getChildByName("emblemCell")
	self._emblemInfoPanel = self._mainPanel:getChildByName("embleminfo")
	self._emblemFullPanel = self._mainPanel:getChildByName("emblemFullLevel")
	self._qualityUpBtn = self._emblemInfoPanel:getChildByFullName("upQualityBtn")
	self._levelUpTips = self._emblemInfoPanel:getChildByFullName("Panel_6")
	self._levelNode = self._emblemInfoPanel:getChildByFullName("levelNode")
	self._descBg = self._emblemInfoPanel:getChildByFullName("descBg")
	self._descFullBg = self._emblemFullPanel:getChildByFullName("descBg")
	self._quickUpBtn = self._levelNode:getChildByFullName("quickupBtn")
	self._levelUpBtn = self._levelNode:getChildByFullName("upBtn")
	self._listView = self._mainPanel:getChildByFullName("ListView_1")

	self._listView:setScrollBarEnabled(false)
	self._listView:setSwallowTouches(false)
	self._listView:setDirection(ccui.ScrollViewDir.horizontal)

	self._sourcePanel = self._emblemInfoPanel:getChildByFullName("sourcepanel")
	self._costNode = self._sourcePanel:getChildByFullName("costNode")

	local crystalAddImg = self._costNode:getChildByFullName("costBg.addImg")
	local touchPanel = crystalAddImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kCrystal)
	end)
	self._descBg:getChildByFullName("des_1.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	self._descBg:getChildByFullName("des_2.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	self._descBg:getChildByFullName("des_3.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	self._descBg:getChildByFullName("des_4.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	self._descFullBg:getChildByFullName("des_1.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	self._descFullBg:getChildByFullName("des_3.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	self._descFullBg:getChildByFullName("des_2.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	self._descFullBg:getChildByFullName("des_4.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	GameStyle:setCostNodeEffect(self._costNode)
	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByFullName("Text_All"))

	self._lvStr = Strings:get("CUSTOM_FIGHT_LEVEL")
end

function MasterEmblemMediator:refreshView()
	self:refreshEmblemList()
end

function MasterEmblemMediator:refreshAllView()
	self:refreshView()
end

function MasterEmblemMediator:refreshEmblemList()
	local list = self._masterSystem:getEmblemList()

	self._listView:removeAllChildren(true)

	self._listTable = {}

	local num = ConfigReader:getCountOfRecordByTableName("MasterEmblemBase")

	for i = 1, num do
		local panel = self._emblemCell:clone()

		panel:setVisible(true)
		panel:setTag(i)

		if list[i] == nil then
			self:setEmblemLock(panel, true)
			self:setEmblemLevel(panel, false)
		else
			self:setEmblemLock(panel, false)

			local emblemData = list[i]

			self:setEmblemQuality(panel, emblemData:getImgName())
			panel:getChildByName("levellabel"):setString(self._lvStr .. emblemData._level)
			self:setEmblemLevel(panel, i ~= (self._curSelectEmblemIndex or 1))
		end

		panel:getChildByName("select"):setVisible(i == (self._curSelectEmblemIndex or 1))
		self._listView:pushBackCustomItem(panel)

		self._listTable[i] = panel

		self:refreshEmblemBtn(i, panel)
		self:refreshRightEmblemInfo(self._curSelectEmblemIndex or 1)
	end

	self._listView:jumpToPercentHorizontal(100)

	if not self._curSelectEmblemIndex then
		if self._curSelectEmblemIndex < 8 then
			self._listView:jumpToPercentHorizontal(0)
		else
			self._listView:jumpToPercentHorizontal(100)
		end
	end
end

function MasterEmblemMediator:setEmblemQuality(emblemcell, name)
	local img = emblemcell:getChildByFullName("Image")

	img:loadTexture(name, ccui.TextureResType.plistType)
	img:ignoreContentAdaptWithSize(true)
end

function MasterEmblemMediator:setEmblemLock(emblemView, islock)
	emblemView:getChildByFullName("lock"):setVisible(islock)
	emblemView:getChildByFullName("Image"):setVisible(not islock)
end

function MasterEmblemMediator:setEmblemLevel(emblemView, show)
	emblemView:getChildByFullName("lvBg"):setVisible(show)
	emblemView:getChildByFullName("levellabel"):setVisible(show)
end

function MasterEmblemMediator:refreshEmblemBtn(i, panel)
	self._curSelectEmblem = self._masterSystem:getEmblemList()[self._curSelectEmblemIndex or 1]

	local emblemCellView = panel:getChildByFullName("enblemBtn")

	emblemCellView:addClickEventListener(function()
		self:onClickEmblemCell(i, panel)
	end)
end

function MasterEmblemMediator:refreshSelectEmblem(selectindex, panel)
	local list = self._masterSystem:getEmblemList()

	for i = 1, #self._listTable do
		if list[i] == nil then
			self:setEmblemLevel(self._listTable[i], false)
		else
			self:setEmblemLevel(self._listTable[i], i ~= ((not self._curSelectEmblemIndex or nil) and 1))
			self._listTable[i]:getChildByFullName("select"):setVisible(i == selectindex)
		end
	end

	self:refreshRightEmblemInfo(selectindex)
end

function MasterEmblemMediator:refreshRightEmblemInfo(selectindex)
	local emblemcellNow, descPanel
	local canupquatily = self._curSelectEmblem:isCanUpQuality()
	local isQualityFull = self._curSelectEmblem:checkQualityFull()
	local isLevelFull = self._curSelectEmblem:checkLevelMax()
	local isEmblemFull = isQualityFull and isLevelFull

	if isEmblemFull then
		self._emblemInfoPanel:setVisible(false)
		self._emblemFullPanel:setVisible(true)

		emblemcellNow = self._emblemFullPanel:getChildByFullName("emblemcellNow")
		descPanel = self._descFullBg
	else
		self._emblemInfoPanel:setVisible(selectindex <= #self._masterSystem:getEmblemList())
		self._emblemFullPanel:setVisible(false)

		emblemcellNow = self._emblemInfoPanel:getChildByFullName("emblemcellNow")
		descPanel = self._descBg
	end

	self._levelNode:getChildByFullName("emblemcellMax.lock"):setVisible(false)
	self._levelNode:getChildByFullName("emblemcellMax.levellabel"):setVisible(false)
	self:setEmblemQuality(self._levelNode:getChildByFullName("emblemcellMax"), self._curSelectEmblem:getImgName())
	self._qualityUpBtn:setVisible(canupquatily)
	self._levelUpBtn:setVisible(not canupquatily)

	if canupquatily then
		local var_17_0 = Strings:get("Master_UI_LinkUPCondition")

		if not var_17_0 then
			var_17_0 = Strings:get("Master_UI_LvUPCondition")

			local costTip = var_17_0
			local textDes = self._sourcePanel:getChildByFullName("text_des")

			textDes:setString(costTip)
			self._costNode:setVisible(false)
			self._levelNode:setVisible(true)

			local emblemcellNext = self._emblemInfoPanel:getChildByFullName("emblemcellNext")
			local text_LvNow = emblemcellNow:getChildByFullName("Text_LvNow")
			local text_LvNext = emblemcellNext:getChildByFullName("Text_LvNext")

			if canupquatily then
				self._levelNode:setVisible(false)

				local condition = self._curSelectEmblem:getNextQualityCondition()
				local conditionDesc = self._curSelectEmblem:getNextQualityDesc()

				self._dpCondition = true
				self._mapSuc = true

				if condition then
					for i = 1, 2 do
						local tips = self._levelUpTips:getChildByFullName("tips_" .. i)

						if condition[i] then
							tips:setVisible(true)

							if i == 1 then
								local desid = self._curSelectEmblem:getConfigDesc()

								tips:setString(Strings:get(conditionDesc[1], condition[i]))

								local totalDp = self._developSystem:getPlayer():getExplore():getTotalDp()

								self._dpCondition = tonumber(totalDp) >= tonumber(condition[i].DP)
							elseif i == 2 then
								self._exploreData = self._developSystem:getPlayer():getExplore()
								self._currentMapInfo = self._exploreData:getPointMap()[condition[i].MapPoint]
								self._mapSuc = self._currentMapInfo:getMapTaskCount() > 0

								local name = Strings:get(ConfigReader:getDataByNameIdAndKey("MapPoint", condition[i].MapPoint, "Name"))

								tips:setString(Strings:get(conditionDesc[2], {
									MapPoint = name
								}))
							end
						else
							tips:setVisible(false)
						end
					end
				else
					for i = 1, 2 do
						local tip = self._levelUpTips:getChildByFullName("tips_" .. i)

						tip:setVisible(true)
						tip:setString("")
					end
				end
			else
				self._dpCondition = true
				self._mapSuc = true

				local tips = {
					Strings:get("Master_UI_QuickUpgrade"),
					Strings:get("Master_UI_PresentQualityMax")
				}

				for i = 1, 2 do
					local tip = self._levelUpTips:getChildByFullName("tips_" .. i)

					tip:setVisible(true)
					tip:setString(tips[i])
				end
			end

			local Bg = descPanel:getChildByFullName("bg")
			local needcolor, curql, nextql = self._curSelectEmblem:getNeedColorQuality()

			self._quickUpBtn:setVisible(not canupquatily)

			local ownNum = self._developSystem:getCrystal()

			if canupquatily then
				Bg:setContentSize(cc.size(580, 66))
				self._descBg:setPosition(cc.p(300, 370))
				self:setEmblemQuality(emblemcellNow, self._curSelectEmblem:getImgName())

				local costNum = self._curSelectEmblem:getQualityCurrencyCost()

				if isQualityFull then
					text_LvNow:setString("Lv.Max")
				else
					text_LvNow:setString(self._curSelectEmblem:getQualityName())
				end

				text_LvNow:setTextColor(GameStyle:getColor(self._curSelectEmblem._showQuality))

				if costNum then
					emblemcellNext:setVisible(true)
					text_LvNext:setVisible(true)
					self._emblemInfoPanel:getChildByFullName("upQualityBtn"):setVisible(true)
					self._costNode:setVisible(true)

					local scourcePanel = self._costNode:getChildByFullName("costBg")
					local iconpanel = scourcePanel:getChildByFullName("iconpanel")

					iconpanel:removeAllChildren()

					local icon = IconFactory:createResourcePic({
						scaleRatio = 0.7,
						id = CurrencyIdKind.kCrystal
					}, {
						largeIcon = true
					})

					icon:addTo(iconpanel):center(iconpanel:getContentSize())

					local addImg = scourcePanel:getChildByFullName("addImg")
					local iconpanel = scourcePanel:getChildByFullName("iconpanel")
					local enoughImg = scourcePanel:getChildByFullName("bg.enoughImg")
					local costNumLabel = scourcePanel:getChildByFullName("cost")

					costNumLabel:setVisible(true)
					costNumLabel:setString(costNum)

					self._costNum = costNum
					self._crystalEnough = costNum <= ownNum

					enoughImg:setVisible(self._crystalEnough)
					addImg:setVisible(not self._crystalEnough)
					iconpanel:setGray(not self._crystalEnough)

					local colorNum = self._crystalEnough and 1 or 7

					costNumLabel:setTextColor(GameStyle:getColor(colorNum))
					self:setEmblemQuality(emblemcellNext, self._curSelectEmblem:getNextQualityImgName())

					local nextQualityDes, nextShowQuality = self._curSelectEmblem:getNextQualityName()

					text_LvNext:setString(nextQualityDes)
					text_LvNext:setTextColor(GameStyle:getColor(nextShowQuality))
				else
					self._emblemInfoPanel:getChildByFullName("upQualityBtn"):setVisible(false)
					emblemcellNext:setVisible(false)
					text_LvNext:setVisible(false)
				end
			else
				Bg:setContentSize(cc.size(295, 100))
				self._descBg:setPosition(cc.p(300, 332))
				self._costNode:setVisible(true)

				local costNum = self._curSelectEmblem:getLevelCurrencyCost()
				local scourcePanel = self._costNode:getChildByFullName("costBg")
				local iconpanel = scourcePanel:getChildByFullName("iconpanel")

				iconpanel:removeAllChildren()

				local icon = IconFactory:createResourcePic({
					scaleRatio = 0.7,
					id = CurrencyIdKind.kCrystal
				}, {
					largeIcon = true
				})

				icon:addTo(iconpanel):center(iconpanel:getContentSize())

				local addImg = scourcePanel:getChildByFullName("addImg")
				local iconpanel = scourcePanel:getChildByFullName("iconpanel")
				local enoughImg = scourcePanel:getChildByFullName("bg.enoughImg")
				local costNumLabel = scourcePanel:getChildByFullName("cost")

				costNumLabel:setVisible(true)
				costNumLabel:setString(self._curSelectEmblem:getLevelCurrencyCost())

				self._costNum = costNum
				self._crystalEnough = costNum <= ownNum

				enoughImg:setVisible(self._crystalEnough)
				addImg:setVisible(not self._crystalEnough)
				iconpanel:setGray(not self._crystalEnough)

				local colorNum = self._crystalEnough and 1 or 7

				costNumLabel:setTextColor(GameStyle:getColor(colorNum))

				if isLevelFull then
					text_LvNow:setString("Lv.Max")
					text_LvNext:setString("Lv.Max")
				else
					text_LvNow:setString(self._lvStr .. self._curSelectEmblem._level)
					text_LvNext:setString(self._lvStr .. self._curSelectEmblem._level + 1)
				end

				text_LvNow:setTextColor(GameStyle:getColor(self._curSelectEmblem._showQuality))
				text_LvNext:setTextColor(GameStyle:getColor(self._curSelectEmblem._showQuality))
				self._levelNode:getChildByFullName("Text_LvMax"):setString(self._lvStr .. self._curSelectEmblem:getEmblemLevelQuickup())
				self:setEmblemQuality(emblemcellNow, self._curSelectEmblem:getImgName())
				self:setEmblemQuality(emblemcellNext, self._curSelectEmblem:getImgName())
				emblemcellNext:setVisible(true)
				text_LvNext:setVisible(true)
			end

			emblemcellNow:getChildByFullName("levelBg"):setVisible(text_LvNext:isVisible())
			emblemcellNext:getChildByFullName("levelBg"):setVisible(emblemcellNext:isVisible())

			local curattr, nextattr = self:updateAttrInfo()
			local num = 4

			for i = 1, num do
				descPanel:getChildByFullName("des_" .. i):setVisible(false)
				descPanel:getChildByFullName("des_" .. i .. ".extendText"):setString("")
			end

			local showNum = 0

			for i = 1, #curattr do
				if num < i then
					break
				end

				local dif = ""

				if type(curattr[i].value) == "string" and type(nextattr[i].value) == "string" then
					local numA = tonumber(string.split(curattr[i].value, "%")[1])
					local numB = tonumber(string.split(nextattr[i].value, "%")[1])

					if numB - numA >= 0 then
						dif = numB - numA .. "%"
						showNum = showNum + 1
					end
				else
					local addValue = nextattr[i].value - curattr[i].value

					if addValue >= 0 then
						dif = addValue
						showNum = showNum + 1
					end
				end

				if dif ~= "" then
					descPanel:getChildByFullName("des_" .. showNum .. ".extendText"):setString("+" .. dif)
					descPanel:getChildByFullName("des_" .. showNum):setVisible(true)
					descPanel:getChildByFullName("des_" .. showNum .. ".image"):loadTexture(AttrTypeImage[curattr[i].att], ccui.TextureResType.plistType)
					descPanel:getChildByFullName("des_" .. showNum .. ".text"):setString(curattr[i].value)
					descPanel:getChildByFullName("des_" .. showNum .. ".name"):setString(curattr[i].name)
				end
			end

			if canupquatily == false then
				if showNum == 3 then
					Bg:setContentSize(cc.size(295, 130))
				elseif showNum == 4 then
					Bg:setContentSize(cc.size(295, 160))
				end
			elseif showNum > 2 then
				Bg:setContentSize(cc.size(580, 100))
			end

			local pos = kAttrPosition.kLevelPos[showNum]

			if canupquatily then
				pos = kAttrPosition.kQualityPos[showNum]
			end

			for i = 1, showNum do
				descPanel:getChildByFullName("des_" .. i):setPosition(((isEmblemFull or nil) and kAttrPosition.kFullPos[showNum])[i])
			end
		end
	end
end

local AttToAttrPercentage = {
	DEF = "DEF_RATE",
	HP = "HP_RATE",
	ATK = "ATK_RATE"
}

function MasterEmblemMediator:updateAttrInfo()
	local curattr = {}
	local nextattr = {}

	if self._curSelectEmblem:isCanUpQuality() then
		curattr, nextattr = self._curSelectEmblem:getEmblemQualityGrowUpAttr()
	else
		curattr, nextattr = self._curSelectEmblem:getEmblemLevelGrowUpAttr()
	end

	local leadStageAllAttr = self._masterData:getLeadStageAllAttrByType()
	local id, leadStageLv = self._masterSystem:getMasterLeadStatgeLevel(self._masterId)
	local leadStageAttr = {}

	for k, v in pairs(leadStageAllAttr) do
		local config = ConfigReader:getRecordById("SkillAttrEffect", k)

		for i = 1, #config.Value do
			local attrNum = SkillAttribute:getAddNumByConfig(config, i, leadStageLv)
			local attrType = SkillAttribute:getAddTypeByConfig(config, i)

			leadStageAttr[attrType] = leadStageAttr[attrType] or 0
			leadStageAttr[attrType] = leadStageAttr[attrType] + attrNum
		end
	end

	for i, v in ipairs(curattr) do
		if AttrBaseType[v.att] then
			if not leadStageAttr[AttToAttrPercentage[v.att]] then
				local add = 0

				curattr[i].value = math.floor(curattr[i].value * (1 + add))
			end
		end
	end

	for i, v in ipairs(nextattr) do
		if AttrBaseType[v.att] then
			if not leadStageAttr[AttToAttrPercentage[v.att]] then
				local add = 0

				nextattr[i].value = math.floor(nextattr[i].value * (1 + add))
			end
		end
	end

	return curattr, nextattr
end

function MasterEmblemMediator:getPlayerLevelLimit(pos)
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemBase", "MasterEmblem_" .. pos)

	return qualityconfig.UnlockLevel
end

function MasterEmblemMediator:onEmblemCultivateSucc(event)
	AudioEngine:getInstance():playEffect("Se_Alert_Character_Levelup", false)

	local data = event:getData()

	if data.preData and data.preData.combat then
		local preCombat = data.preData.combat

		self._mediator:showCombatAnim(preCombat, cc.p(433, 208))
	end
end

function MasterEmblemMediator:onEmblemCultivateQualitySucc(event)
	AudioEngine:getInstance():playEffect("Se_Alert_Shengpin", false)

	local data = {
		curSelectEmblem = self._curSelectEmblem,
		oldQualityEmblemQualityId = self._oldQualityEmblemQualityId
	}
	local view = self:getInjector():getInstance("MasterEmblemQualityUpView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, data))
end

function MasterEmblemMediator:onClickQualityUp()
	if self._curSelectEmblem:isCanUpQuality() and self._dpCondition and self._mapSuc then
		if self._curSelectEmblem:checkQualityUpCost() then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			self._oldQualityEmblemQualityId = self._curSelectEmblem._qualityId

			self._masterSystem:requestMasterEmblemQualityUp(self._curSelectEmblem._id)
		else
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Tips_30000003")
			}))
		end
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Team_Except_Title")
		}))
	end
end

function MasterEmblemMediator:onClickLevelUp()
	if self._curSelectEmblem:checkPlayerLv() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Master_EmblemLV")
		}))

		return
	end

	if self._curSelectEmblem:checkLevelMax() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Error_13001")
		}))

		return
	end

	if not self._curSelectEmblem:checkLeveUpCost() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Tips_30000003")
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local combat, attrData = self._masterData:getCombat()
	local preData = {
		combat = combat
	}

	self._masterSystem:requestMasterEmblemLevelUp(self._curSelectEmblem._id, preData)
end

function MasterEmblemMediator:onClickQuickUp()
	if not self._curSelectEmblem:isCanUpQuality() then
		if self._curSelectEmblem:checkLevelMax() then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Error_13001")
			}))

			return
		end

		local costEnough = self._curSelectEmblem:checkLeveUpCost()

		if not costEnough then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Tips_30000003")
			}))

			return
		end

		if self._curSelectEmblem:checkPlayerLv() then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Master_EmblemLV")
			}))

			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local combat, attrData = self._masterData:getCombat()
		local preData = {
			combat = combat
		}

		self._masterSystem:requestMasterEmblemOnekeyLevelup(self._curSelectEmblem._id, preData)
	end
end

function MasterEmblemMediator:onClickEmblemCell(i, panel)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if i > #self._masterSystem:getEmblemList() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Unlock_Shop_Fragment_Tips", {
				uLevel = self:getPlayerLevelLimit(i)
			})
		}))
	else
		AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

		self._curSelectEmblem = self._masterSystem:getEmblemList()[i]
		self._curSelectEmblemIndex = i

		self:refreshSelectEmblem(i, panel)
	end
end

function MasterEmblemMediator:runStartAction()
	self._mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/MasterEmblem.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)
	action:setTimeSpeed(1.2)

	local bgAnim2 = self._descBg:getChildByFullName("bgAnim2")
	local bgAnim3 = self._descFullBg:getChildByFullName("bgAnim2")

	if not bgAnim2:getChildByFullName("BgAnim1") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim2)
		anim:offset(0, -3)
		anim:setName("BgAnim1")
	end

	bgAnim2:getChildByFullName("BgAnim1"):gotoAndStop(1)

	if not bgAnim3:getChildByFullName("BgAnim2") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim3)
		anim:offset(0, -3)
		anim:setName("BgAnim2")
	end

	bgAnim3:getChildByFullName("BgAnim2"):gotoAndStop(1)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "CostAnim1" then
			GameStyle:runCostAnim(self._costNode)
		end

		if str == "BgAnim2" then
			bgAnim2:getChildByFullName("BgAnim1"):gotoAndPlay(1)
			bgAnim3:getChildByFullName("BgAnim2"):gotoAndPlay(1)
		end

		if str == "EndAnim" then
			-- block empty
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function MasterEmblemMediator:showStarAnim(star, index)
	local starMax = self._masterData:getMaxStar()

	if starMax < index then
		return
	end

	local starBg = self._starPanel:getChildByFullName("starBg" .. index)

	if index <= star then
		starBg:getChildByName("StarAnim1"):setVisible(true)
		starBg:getChildByName("StarAnim1"):gotoAndPlay(1)
	elseif index == star + 1 and self._masterSystem:hasRedPointByStar(self._masterId) then
		starBg:getChildByName("StarAnim2"):setVisible(true)
		starBg:getChildByName("StarAnim2"):gotoAndPlay(1)
	end
end

function MasterEmblemMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local emblemBg = self._mainPanel:getChildByFullName("emblem")

	if emblemBg then
		storyDirector:setClickEnv("MasterEmblemMediator.topemblemBg", emblemBg, function(sender, eventType)
			return
		end)
	end

	local embleminfo = self._mainPanel:getChildByFullName("embleminfo.Panel_2")

	if embleminfo then
		storyDirector:setClickEnv("MasterEmblemMediator.attremblemBg", embleminfo, function(sender, eventType)
			return
		end)
	end

	local embleminfo = self._mainPanel:getChildByFullName("embleminfo.levelNode.quickupBtn")

	if embleminfo then
		storyDirector:setClickEnv("MasterEmblemMediator.emblemUpBtn", embleminfo, function(sender, eventType)
			self:onClickQuickUp()

			local sequence = cc.Sequence:create(cc.CallFunc:create(function()
				storyDirector:notifyWaiting("click_MasterCultivateMediator_emblemUp")
			end))

			self:getView():runAction(sequence)
		end)
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_MasterEmblemMediator")
	end))

	self:getView():runAction(sequence)
end
