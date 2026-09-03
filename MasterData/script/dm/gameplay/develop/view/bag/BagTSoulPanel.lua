-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagTSoulPanel.lua

BagTSoulPanel = class("BagTSoulPanel", _G.DisposableObject, _M)

function BagTSoulPanel:initialize(view, uiNode)
	super.initialize(self)

	self._view = view
	self._uiNode = uiNode
	self._tSoulSystem = self._view._tSoulSystem
	self._systemKeeper = self._view._systemKeeper

	self:onInitUI()
end

function BagTSoulPanel:dispose()
	super.dispose(self)
end

function BagTSoulPanel:show(entry)
	if not entry then
		return
	end

	local item = entry.item

	self._entryId = item:getId()
	self._tSoulData = item:getTSoulData()
	self._tsoulId = self._tSoulData:getId()

	self._uiNode:setVisible(true)
	self:refreshView()
end

function BagTSoulPanel:hide()
	self._uiNode:setVisible(false)
end

function BagTSoulPanel:onInitUI()
	local view = self._view
	local uiNode = self._uiNode

	view:mapEventListener(view:getEventDispatcher(), EVT_TSOUL_LOCK_SUCC, self, self.refreshViewByLock)

	local this = self

	function view.onClickTsoulLock()
		this:onClickLock()
	end

	self._strengthenWidget = view:bindWidget("mainpanel.tsoulPanel.btnPanel.strengthenBtn", TwoLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStrengthen, self)
		}
	})
	self._nodeDesc = uiNode:getChildByFullName("nodeDesc")
	self._nodeAttr = uiNode:getChildByFullName("nodeAttr")
	self._nodeSkill = uiNode:getChildByFullName("nodeSkill")
	self._strengthenBtn = uiNode:getChildByFullName("btnPanel.strengthenBtn")
	self._attrList = self._nodeAttr:getChildByFullName("ListView_1")
	self._suitList = self._nodeSkill:getChildByFullName("ListView_1_0")

	self._attrList:setScrollBarEnabled(false)
	self._suitList:setScrollBarEnabled(false)

	local nameLabel = self._nodeDesc:getChildByFullName("name")

	nameLabel:enableOutline(cc.c4b(69, 35, 6, 140), 2)

	local limitDesc = self._nodeDesc:getChildByFullName("text")

	limitDesc:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local levelTxt = self._nodeDesc:getChildByFullName("level")

	levelTxt:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function BagTSoulPanel:isShow()
	return self._uiNode:getVisible()
end

function BagTSoulPanel:refreshView()
	self:refreshEquipBaseInfo()
	self:refreshAttr()
	self:refreshSkill()
	self:refreshBtn()
end

function BagTSoulPanel:refreshViewByLock(event)
	local data = event:getData()

	if self._tSoulData and self._tSoulData:getId() == data.id then
		if self._tSoulData:getLock() then
			if not kLockImage[1] then
				local image = kLockImage[2]
				local lockBtn = self._nodeDesc:getChildByFullName("lockBtn")

				lockBtn:getChildByName("image"):loadTexture(image)

				if self._tSoulData:getLock() then
					local var_9_1 = Strings:get("TimeSoul_Success_Lock")

					if not var_9_1 then
						var_9_1 = Strings:get("TimeSoul_Success_Unlock")

						local tip = var_9_1

						self._view:dispatch(ShowTipEvent({
							tip = tip
						}))
					end
				end
			end
		end
	end
end

function BagTSoulPanel:refreshEquipBaseInfo()
	local name = self._tSoulData:getName()
	local rarity = self._tSoulData:getRarity()
	local level = self._tSoulData:getLevel()
	local imgIcon = self._nodeDesc:getChildByFullName("iconpanel")

	imgIcon:ignoreContentAdaptWithSize(true)
	imgIcon:loadTexture(self._tSoulData:getIcon())
	imgIcon:setScale(0.8)

	local rarityPanel = self._nodeDesc:getChildByFullName("rarity")

	rarityPanel:removeAllChildren()

	local imageFile = GameStyle:getEquipRarityImage(rarity + 9)
	local rarityImage = rarityPanel:getChildByName("RarityImage")

	if not rarityImage then
		rarityImage = ccui.ImageView:create(imageFile)

		rarityImage:addTo(rarityPanel)
		rarityImage:setName("RarityImage")
		rarityImage:ignoreContentAdaptWithSize(true)
		rarityImage:setScale(0.9)
	end

	rarityImage:loadTexture(imageFile)

	local levelTxt = self._nodeDesc:getChildByFullName("level")

	levelTxt:setString(Strings:get("Strenghten_Text78", {
		level = level
	}))

	local nameLabel = self._nodeDesc:getChildByFullName("name")

	nameLabel:setString(name)
	GameStyle:setRarityText(nameLabel, rarity + 9)

	local lockBtn = self._nodeDesc:getChildByFullName("lockBtn")

	if self._tSoulData:getLock() then
		if not kLockImage[1] then
			local image = kLockImage[2]

			lockBtn:getChildByName("image"):loadTexture(image)

			local text = self._nodeDesc:getChildByFullName("text")

			text:setString("")
		end
	end
end

function BagTSoulPanel:refreshAttr()
	self._attrList:removeAllChildren()

	local attrClone = self._nodeAttr:getChildByFullName("Panel_attr")

	attrClone:setVisible(false)

	local position = self._tSoulData:getPosition()
	local totalNum = self._tSoulData:getMaxAttrNum() + 1
	local attrs = getTSoulAttNumber(self._tSoulData:getAllAttr())

	for i = 1, #attrs do
		local node = attrClone:clone()

		node:setVisible(true)

		local img = node:getChildByName("image")
		local text = node:getChildByName("text_name")
		local text2 = node:getChildByName("text_value")
		local imgDi = node:getChildByName("Image_70")
		local imgLock = node:getChildByName("Image_lock")

		img:setVisible(false)
		text:setVisible(false)
		text2:setVisible(false)
		imgLock:setVisible(false)

		if attrs[i] then
			imgDi:loadTexture((i == 1 or nil) and (KTSoulAttrBgName[KTSoulAttrBgState.KNormal] or KTSoulAttrBgName[KTSoulAttrBgState.KKong]), ccui.TextureResType.plistType)
			img:setVisible(true)
			text:setVisible(true)
			text2:setVisible(true)
			img:loadTexture(attrs[i].icon, ccui.TextureResType.plistType)
			text:setString(attrs[i].attrName .. " :   " .. attrs[i].num)
			text2:setString("")
		elseif i <= totalNum then
			imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KKong], ccui.TextureResType.plistType)
		else
			imgLock:setVisible(true)
			imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KLock], ccui.TextureResType.plistType)
		end

		self._attrList:pushBackCustomItem(node)
	end
end

function BagTSoulPanel:refreshSkill()
	self._suitList:removeAllChildren()

	local width = self._suitList:getContentSize().width
	local suitData = self._tSoulData:getSuitData()

	if suitData then
		local SuitDesc = suitData.SuitDesc
		local index = 1

		for k, v in pairs(SuitDesc) do
			if index < 3 then
				local attrType = suitData.Suitattr[tonumber(k) - 1] or suitData.Suitlevattr[1]
				local attrNum = suitData.Partattr[tonumber(k) - 1] or suitData.Partlevattr[1]

				if AttributeCategory:getAttNameAttend(attrType) ~= "" then
					attrNum = attrNum * 100 .. "%"
				end

				local des = Strings:get(v, {
					Suitattr = getAttrNameByType(attrType),
					Partattr = attrNum,
					fontName = TTF_FONT_FZYH_M
				})
				local label = ccui.RichText:createWithXML(des, {})

				label:renderContent(width, 0)
				label:setAnchorPoint(cc.p(0, 0))
				label:setPosition(cc.p(0, 8))

				local newPanel = ccui.Layout:create()
				local height = label:getContentSize().height + 12

				newPanel:setContentSize(cc.size(width, height))
				label:addTo(newPanel)
				self._suitList:pushBackCustomItem(newPanel)
			else
				local Tsoul_SuitLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_SuitLevel", "content")
				local maxLevel = {}

				for level, id in pairs(Tsoul_SuitLevel) do
					table.insert(maxLevel, level)
				end

				table.sort(maxLevel, function(a, b)
					return tonumber(a) < tonumber(b)
				end)

				for key, level in pairs(maxLevel) do
					local attrName = Tsoul_SuitLevel[level]
					local attrType = suitData.Suitlevattr[1]

					if suitData[attrName] then
						local attrNum = suitData[attrName][1]

						if AttributeCategory:getAttNameAttend(attrType) ~= "" then
							attrNum = attrNum * 100 .. "%"
						end

						local des = Strings:get(v, {
							level = level,
							Suitattr = getAttrNameByType(attrType),
							Partattr = attrNum,
							fontName = TTF_FONT_FZYH_M
						})
						local label = ccui.RichText:createWithXML(des, {})

						label:renderContent(width, 0)
						label:setAnchorPoint(cc.p(0, 0))
						label:setPosition(cc.p(0, 8))

						local height = label:getContentSize().height + 12
						local newPanel = ccui.Layout:create()

						newPanel:setContentSize(cc.size(width, height))
						label:addTo(newPanel)
						self._suitList:pushBackCustomItem(newPanel)
					end
				end
			end

			index = index + 1
		end
	end
end

function BagTSoulPanel:refreshBtn()
	local unlock = self._systemKeeper:isUnlock("Projection")

	self._strengthenBtn:setVisible(unlock)
end

function BagTSoulPanel:onClickStrengthen(sender, eventType)
	local view = self._view:getInjector():getInstance("TSoulIntensifyView")

	self._view:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		chooseId = self._tsoulId
	}, nil))
end

function BagTSoulPanel:onClickLock()
	local params = {
		tsoulId = self._tsoulId
	}

	self._tSoulSystem:requestTSoulLock(params)
end
