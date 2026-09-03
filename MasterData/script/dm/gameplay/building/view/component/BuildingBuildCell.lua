-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingBuildCell.lua

BuildingBuildCell = class("BuildingBuildCell", DmBaseUI)

BuildingBuildCell:has("_buildingSystem", {
	is = "rw"
})

function BuildingBuildCell:initialize(data)
	super.initialize(self)
	self:setView(data.view)
end

function BuildingBuildCell:update(info)
	self._id = info.id
	self._roomId = info.roomId
	self._showType = info.showType

	self._node_des:stopAllActions()
	self._node_buy:stopAllActions()
	self._node_buy:setVisible(true)
	self._node_des:setVisible(false)
	self._buyStaBg:setVisible(false)
	self._node_another:setVisible(false)
	self._btnbuy:setVisible(false)
	self._node_buy:setScaleX(1)

	if self._showType == 1 then
		local config = self._buildingSystem:getBuildingConfig(self._id)
		local buildingLevel = config.BuildingLevel
		local configLevel = ConfigReader:getRecordById("VillageBuildingLevel", buildingLevel)

		self._text_name:setString(Strings:get(config.Name))
		self._node_des:getChildByName("Text_name"):setString(Strings:get(config.Name))
		self._text_name:setTextAreaSize(cc.size(0, 0))

		local localLanguage = getCurrentLanguage()

		if localLanguage ~= GameLanguageType.CN then
			local Image1 = self._node_buy:getChildByName("Image_8")
			local Image2 = self._node_des:getChildByName("Image_8")

			if self._text_name:getContentSize().width > 130 then
				self._text_name:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
				self._text_name:setTextAreaSize(cc.size(130, 36))
				self._node_des:getChildByName("Text_name"):getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
				self._node_des:getChildByName("Text_name"):setTextAreaSize(cc.size(130, 36))

				local txtsize = cc.size(150, Image1:getContentSize().height)

				Image1:setContentSize(txtsize)
				Image2:setContentSize(txtsize)
			elseif self._text_name:getContentSize().width > 60 then
				local txtsize = cc.size(self._text_name:getContentSize().width + 25, Image1:getContentSize().height)

				Image1:setContentSize(txtsize)
				Image2:setContentSize(txtsize)
			else
				local txtsize = cc.size(87, Image1:getContentSize().height)

				Image1:setContentSize(txtsize)
				Image2:setContentSize(txtsize)
			end
		end

		local node_des = self._node_des:getChildByName("Node_des")
		local text_des = self._node_des:getChildByName("Text_des")

		if node_des then
			node_des:removeAllChildren()

			local desc = Strings:get(config.Desc, {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_M
			})
			local contentText = ccui.RichText:createWithXML(desc, {})

			contentText:setAnchorPoint(cc.p(0, 1))
			contentText:ignoreContentAdaptWithSize(true)
			contentText:rebuildElements()
			contentText:formatText()
			contentText:renderContent(text_des:getContentSize().width, 0, true)
			node_des:addChild(contentText)
		end

		local skinId = config.DefaultSurface
		local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

		self._buildingDecorate:refreshSkin(skinId)
		self._buildingDecorate:updateOffsetX(self._id)
		self._buildingDecorate:getView():setScale(skinConfig.PicScale[1])

		if not skinConfig.Comfort then
			local comfort = 0

			comfort = comfort + configLevel.Comfort

			self._text_comfort:setVisible(false)

			if comfort > 0 then
				self._text_comfort:setVisible(true)
				self._text_comfort:setString(Strings:get("Building_UI_Relax") .. "+" .. comfort)
			end

			local room = self._buildingSystem:getRoom(self._roomId)
			local ownNum = room:getOwnNum(self._id)

			if not config.Amount then
				local maxNum = 1

				self._text_ownNum:setString(ownNum .. "/" .. maxNum)
				self._text_ownNum:setVisible(true)

				local upgradeTime = configLevel.UpgradeTime

				if upgradeTime <= 0 then
					self._node_time:setVisible(false)
				else
					self._node_time:setVisible(true)

					local t, timeDes = self._buildingSystem:getTimeText(upgradeTime)

					self._node_time:getChildByName("Text_time"):setString(timeDes)
				end

				if maxNum <= ownNum then
					self._btnbuy:setVisible(false)
					self._node_another:setVisible(false)
					self._text_des:setVisible(true)
					self._text_des:setString(Strings:get("Building_UI_Purchased"))
					self._buyStaBg:setVisible(true)
				elseif not config.Condition then
					local condition = {}
					local conditionSta = self._buildingSystem:isMeetCondition(condition)

					if conditionSta then
						self._text_des:setVisible(false)

						local upgradeCost = configLevel.UpgradeCost
						local upgradeCostAnother = configLevel.UpgradeCostAnother

						if upgradeCostAnother and #upgradeCostAnother > 0 then
							self._node_another:setVisible(true)

							local __costList = {}

							__costList[#__costList + 1] = upgradeCostAnother[1]
							__costList[#__costList + 1] = upgradeCost[1]

							self:updateAnotherIcon(__costList, self._node_another)

							local btnAnother = self._node_another:getChildByFullName("btnAnother")
							local btnAnotherBuy = self._node_another:getChildByFullName("btnAnotherBuy")

							btnAnother:addTouchEventListener(function(sender, eventType)
								if eventType == ccui.TouchEventType.ended then
									for ___, costData in pairs(upgradeCostAnother) do
										if not self:checkBuildCurrency(costData.type, costData.amount) then
											AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

											return
										end
									end

									self:onClickBuild(true)
								end
							end)
							btnAnotherBuy:addTouchEventListener(function(sender, eventType)
								if eventType == ccui.TouchEventType.ended then
									for ___, costData in pairs(upgradeCost) do
										if not self:checkBuildCurrency(costData.type, costData.amount) then
											AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

											return
										end
									end

									self:onClickBuild()
								end
							end)
						else
							self._btnbuy:setVisible(true)
							self:updateIcon(upgradeCost, self._btnbuy)
							self._btnbuy:addTouchEventListener(function(sender, eventType)
								if eventType == ccui.TouchEventType.ended then
									local beganPos = sender:getTouchBeganPosition()
									local endPos = sender:getTouchEndPosition()

									if math.abs(beganPos.x - endPos.x) < 20 and math.abs(beganPos.y - endPos.y) < 20 then
										for ___, costData in pairs(upgradeCost) do
											if not self:checkBuildCurrency(costData.type, costData.amount) then
												AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

												return
											end
										end

										self:onClickBuild()
									end
								end
							end)
						end
					else
						self._btnbuy:setVisible(false)
						self._node_another:setVisible(false)
						self._text_des:setVisible(true)

						local infoDes = self._buildingSystem:getConditionDesInfo(condition)

						self._text_des:setString(Strings:get(config.UnlockDesc, infoDes))
					end
				end

				self._btnSetUp:setVisible(false)
				self._text_ownDes:setVisible(true)
			end
		end
	elseif self._showType == 2 then
		local config = {}
		local buildingData = {}
		local show = true

		if self._roomId == kStoreRoomName then
			config = ConfigReader:getRecordById("VillageDecorateBuilding", self._id)
			buildingData._levelConfigId = config.BuildingLevel
			buildingData._configId = self._id
			show = false
		else
			buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
			config = ConfigReader:getRecordById("VillageDecorateBuilding", buildingData._configId)
		end

		local buildingLevel = buildingData._levelConfigId
		local configLevel = ConfigReader:getRecordById("VillageBuildingLevel", buildingLevel)

		self._text_name:setString(Strings:get(config.Name))
		self._node_des:getChildByName("Text_name"):setString(Strings:get(config.Name))

		local node_des = self._node_des:getChildByName("Node_des")
		local text_des = self._node_des:getChildByName("Text_des")

		if node_des then
			node_des:removeAllChildren()

			local desc = Strings:get(config.Desc, {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_M
			})
			local contentText = ccui.RichText:createWithXML(desc, {})

			contentText:setAnchorPoint(cc.p(0, 1))
			contentText:ignoreContentAdaptWithSize(true)
			contentText:rebuildElements()
			contentText:formatText()
			contentText:renderContent(text_des:getContentSize().width, 0, true)
			node_des:addChild(contentText)
		end

		local unlockDesc = self._node_buy:getChildByName("UnlockDesc")

		if unlockDesc then
			unlockDesc:removeFromParent()
		end

		if not show then
			local roomName = ConfigReader:getDataByNameIdAndKey("VillageRoom", config.Room, "Name")
			local nameString = Strings:get(roomName)
			local desc = Strings:get("Building_Decorate_Room_Unlock", {
				room = nameString
			})
			local contentText = cc.Label:createWithTTF(desc, TTF_FONT_FZYH_M, 18)

			contentText:enableOutline(cc.c4b(83, 44, 38, 255), 2)
			contentText:addTo(self._node_buy):setName("UnlockDesc")

			local posX = self._btnSetUp:getPositionX()
			local posY = self._btnSetUp:getPositionY()

			contentText:setPositionX(posX)
			contentText:setPositionY(posY)
		end

		local skinId = config.DefaultSurface
		local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

		self._buildingDecorate:refreshSkin(skinId)
		self._buildingDecorate:updateOffsetX(buildingData._configId)
		self._buildingDecorate:getView():setScale(skinConfig.PicScale[1])

		if not skinConfig.Comfort then
			local comfort = 0

			comfort = comfort + configLevel.Comfort

			self._text_comfort:setVisible(false)

			if comfort > 0 then
				self._text_comfort:setVisible(show)
				self._text_comfort:setString(Strings:get("Building_UI_Relax") .. "+" .. comfort)
			end

			self._node_time:setVisible(false)
			self._text_ownNum:setVisible(false)
			self._btnbuy:setVisible(false)
			self._node_another:setVisible(false)
			self._text_des:setVisible(false)
			self._btnSetUp:setVisible(show)
			self._text_ownDes:setVisible(false)
		end
	end
end

function BuildingBuildCell:intiView()
	local view = self:getView()

	self._node_buy = view:getChildByName("Node_buy")
	self._node_des = view:getChildByName("Node_des")
	self._text_name = self._node_buy:getChildByName("Text_name")
	self._node_building = self._node_buy:getChildByName("Node_building")
	self._text_comfort = self._node_buy:getChildByName("Text_comfort")
	self._node_time = self._node_buy:getChildByName("Node_time")
	self._text_ownNum = self._node_buy:getChildByName("Text_ownNum")
	self._text_des = self._node_buy:getChildByName("Text_des")
	self._btnbuy = self._node_buy:getChildByName("btnbuy")
	self._node_another = self._node_buy:getChildByName("Node_another")
	self._btnSetUp = self._node_buy:getChildByName("btnSetUp")
	self._text_ownDes = self._node_buy:getChildByName("Text_ownDes")
	self._buyStaBg = self._node_buy:getChildByName("Image_6")

	self._btnbuy:setSwallowTouches(false)

	local buildingDecorate = self._buildingSystem:getInjector():instantiate("BuildingDecorate", {
		view = self._node_building
	})

	buildingDecorate:enterWithData()
	buildingDecorate:setIsInRoom(false)

	self._buildingDecorate = buildingDecorate

	local btnInfo = self._node_buy:getChildByName("Button_info")

	btnInfo:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Alert_Pop", false)
			self:filpToBack(1)
		end
	end)

	local btnBack = self._node_des:getChildByName("Image_1")

	btnBack:setSwallowTouches(false)
	btnBack:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Alert_Pop", false)
			self:filpToBack(2)
		end
	end)
	self._btnSetUp:getChildByFullName("name"):setString(Strings:get("Building_UI_Setup"))
	self._btnSetUp:getChildByFullName("name"):setAdditionalKerning(4)
	self._btnSetUp:getChildByFullName("button"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onClickSetUp()
		end
	end)
	self._text_comfort:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 2)
end

function BuildingBuildCell:updateIcon(upgradeCost, baseNode)
	local function updataNode(costType, costNum, icon, labelNum)
		icon:setContentSize(cc.size(200, 200))

		local iconPath = ConfigReader:getDataByNameIdAndKey("ResourcesIcon", costType, "Sicon")

		if iconPath and iconPath ~= "" then
			icon:loadTexture(iconPath .. ".png", ccui.TextureResType.plistType)
		else
			iconPath = ConfigReader:getDataByNameIdAndKey("ItemConfig", costType, "Icon")

			if iconPath and iconPath ~= "" then
				local path = "asset/items/" .. iconPath .. ".png"

				icon:loadTexture(path, ccui.TextureResType.localType)
			end
		end

		labelNum:setString(costNum)
	end

	local node_1 = baseNode:getChildByFullName("Node_1")
	local node_2 = baseNode:getChildByFullName("Node_2")

	node_1:setVisible(false)
	node_2:setVisible(false)

	if #upgradeCost == 1 then
		node_1:setVisible(true)

		local costType = upgradeCost[1].type
		local costNum = upgradeCost[1].amount
		local icon = node_1:getChildByName("icon")
		local num = node_1:getChildByName("cost")

		updataNode(costType, costNum, icon, num)
	elseif #upgradeCost > 0 then
		node_2:setVisible(true)

		local icon_1 = node_2:getChildByName("icon_1")
		local num_1 = node_2:getChildByName("cost_1")
		local icon_2 = node_2:getChildByName("icon_2")
		local num_2 = node_2:getChildByName("cost_2")

		updataNode(upgradeCost[1].type, upgradeCost[1].amount, icon_1, num_1)
		updataNode(upgradeCost[2].type, upgradeCost[2].amount, icon_2, num_2)
	end
end

function BuildingBuildCell:updateAnotherIcon(upgradeCost, baseNode)
	local function updataNode(costType, costNum, icon, labelNum)
		icon:setContentSize(cc.size(200, 200))

		local iconPath = ConfigReader:getDataByNameIdAndKey("ResourcesIcon", costType, "Sicon")

		if iconPath and iconPath ~= "" then
			icon:loadTexture(iconPath .. ".png", ccui.TextureResType.plistType)
		else
			iconPath = ConfigReader:getDataByNameIdAndKey("ItemConfig", costType, "Icon")

			if iconPath and iconPath ~= "" then
				local path = "asset/items/" .. iconPath .. ".png"

				icon:loadTexture(path, ccui.TextureResType.localType)
			end
		end

		labelNum:setString(costNum)
	end

	for i = 1, #upgradeCost do
		local node = baseNode:getChildByFullName("Node_" .. i)
		local icon = node:getChildByName("icon")
		local num = node:getChildByName("cost")

		updataNode(upgradeCost[i].type, upgradeCost[i].amount, icon, num)
	end
end

function BuildingBuildCell:checkBuildCurrency(costtype, costNum)
	local canbuild = CurrencySystem:checkEnoughCurrency(self, costtype, costNum)

	if canbuild == nil then
		canbuild = false

		local ownCount = CurrencySystem:getCurrencyCount(self._buildingSystem, costtype)

		if costNum <= ownCount then
			canbuild = true
		end
	end

	if not canbuild then
		self:dispatch(ShowTipEvent({
			duration = 0.5,
			tip = Strings:get("Error_1032")
		}))
	end

	return canbuild
end

function BuildingBuildCell:onClickBuild(another)
	local revert = false
	local pos = self._buildingSystem:getBuildingPutPos(self._roomId, self._id, true, revert)

	if pos then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._buildingSystem:dispatch(Event:new(BUILDING_BUY_PUT_TO_MAP, {
			roomId = self._roomId,
			buildingId = self._id,
			pos = pos,
			revert = revert,
			another = another
		}))
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.5,
			tip = Strings:get("Building_Tips_PlaceFull")
		}))
	end
end

function BuildingBuildCell:onClickSetUp()
	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
	local pos = self._buildingSystem:getBuildingPutPos(self._roomId, buildingData._configId, false, buildingData._revert)

	if pos then
		self._buildingSystem:dispatch(Event:new(BUILDING_WAREHOUSE_TO_MAP, {
			roomId = self._roomId,
			buildingId = buildingData._configId,
			id = self._id,
			pos = pos,
			revert = buildingData._revert
		}))
	else
		self:dispatch(ShowTipEvent({
			duration = 0.5,
			tip = Strings:get("Building_Tips_PlaceFull")
		}))
	end
end

function BuildingBuildCell:filpToBack(go)
	if self._node_des:getActionByTag(101) then
		return
	end

	if self._node_buy:getActionByTag(101) then
		return
	end

	local aniTime = 0.3

	if go == 1 then
		self._node_buy:setVisible(true)
		self._node_des:setVisible(false)
		self._node_buy:setScaleX(1)
		self._node_des:setScaleX(-1)

		local seq = cc.Sequence:create(cc.ScaleTo:create(aniTime / 2, 0.01, 1), cc.CallFunc:create(function(...)
			self._node_buy:setVisible(false)
			self._node_des:setVisible(true)
		end), cc.ScaleTo:create(aniTime / 2, 1, 1))

		seq:setTag(101)
		self._node_des:runAction(seq)
		self._node_buy:runAction(cc.ScaleTo:create(aniTime, -1, 1))
	else
		self._node_buy:setVisible(false)
		self._node_des:setVisible(true)
		self._node_buy:setScaleX(-1)
		self._node_des:setScaleX(1)

		local seq = cc.Sequence:create(cc.ScaleTo:create(aniTime / 2, 0.01, 1), cc.CallFunc:create(function(...)
			self._node_buy:setVisible(true)
			self._node_des:setVisible(false)
		end), cc.ScaleTo:create(aniTime / 2, 1, 1))

		seq:setTag(101)
		self._node_buy:runAction(seq)
		self._node_des:runAction(cc.ScaleTo:create(aniTime, -1, 1))
	end
end
