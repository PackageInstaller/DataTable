-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagURMapViewDetailMediator.lua

require("dm.gameplay.develop.view.bag.BagEquipPancel")

BagURMapViewDetailMediator = class("BagURMapViewDetailMediator", DmAreaViewMediator, _M)

BagURMapViewDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BagURMapViewDetailMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local weaponIcon = {
	Weapon = "bb_zb_zb01.png",
	Shoes = "bb_zb_zb04.png",
	Decoration = "bb_zb_zb02.png",
	Tops = "bb_zb_zb03.png"
}
local kBtnHandlers = {
	["main.Button_left"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onLeftClicked"
	},
	["main.Button_right"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onRightClicked"
	},
	["main.usebtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onUseClicked"
	},
	["main.btnGo"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onGOToClicked"
	},
	btn_rule = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	}
}

function BagURMapViewDetailMediator:initialize()
	super.initialize(self)
end

function BagURMapViewDetailMediator:dispose()
	self._equipSystem:clearComposeUsedEquips()
	super.dispose(self)
end

function BagURMapViewDetailMediator:userInject()
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
	self._rewardSystem = self._developSystem:getEquipSystem()
	self._equipModule = self._developSystem:getPlayer():getEquipList()
end

function BagURMapViewDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function BagURMapViewDetailMediator:enterWithData(data)
	self._urMapIndex = data.urMapIndex
	self._urMapList = self._bagSystem:getURMapInfo()
	self._urMapId = self._urMapList[self._urMapIndex].config.Id
	self._urMapConfig = ConfigReader:getRecordById("UREuipmentMap", self._urMapId)
	self._equipList = self._urMapConfig.EquipList

	self:setCurId()
	self:setViewUI()
	self:refreshView()
	self._equipSystem:clearComposeUsedEquips()
end

function BagURMapViewDetailMediator:resumeWithData()
	self:refreshView()
end

function BagURMapViewDetailMediator:setCurId()
	self._curEntryId = self._equipList[1].scrollID

	for i, v in ipairs(self._equipList) do
		if not self._bagSystem:getHasURMapEquipId(self._urMapId, v.equipment) then
			self._curEntryId = v.scrollID

			break
		end
	end
end

function BagURMapViewDetailMediator:refreshView()
	self._canClickBtn = true

	self:setMaterialData()
	self:setListView()
	self:setMaterialView()
	self:setPanelBottomView()
	self:setBtnVisibleView()
end

function BagURMapViewDetailMediator:setMaterialData()
	self._equipSystem:clearComposeUsedEquips()

	self._urMapId = self._urMapList[self._urMapIndex].config.Id
	self._urMapConfig = ConfigReader:getRecordById("UREuipmentMap", self._urMapId)
	self._equipList = self._urMapConfig.EquipList

	local configData = ConfigReader:getRecordById("Compose", self._curEntryId)

	self._configData = configData
	self._target = configData.Show
	self._currency = configData.Currency
	self._tabEnoughHttp = {}
	self._isShowSkillPage = true
	self._realEquip = nil

	if self._bagSystem:getHasURMapEquipId(self._urMapId, self._target.id) then
		local equipList = self._developSystem:getPlayer():getEquipList()
		local equipIds = equipList:getEquipsByType(self._configData.ComposePosition)

		for id, _ in pairs(equipIds) do
			local equip = equipList:getEquipById(id)

			if equip:getEquipId() == self._target.id then
				self._realEquip = equip
			end
		end
	end
end

function BagURMapViewDetailMediator:setViewUI()
	self:setupTopInfoWidget()

	self._main = self:getView():getChildByFullName("main")
	self.currency = self:getView():getChildByFullName("main.currency")
	self.targetName = self:getView():getChildByFullName("main.targetName")
	self.urMapName = self:getView():getChildByFullName("main.urMapName")
	self.listCellClone = self:getView():getChildByFullName("main.listCellClone")

	self.listCellClone:setVisible(false)

	self.listCellClone_Null = self:getView():getChildByFullName("main.listCellClone_Null")

	self.listCellClone_Null:setVisible(false)

	self.targetPanel = self:getView():getChildByFullName("main.targetPanel")
	self.material_3 = self:getView():getChildByFullName("main.material_3")

	self.material_3:setVisible(false)

	self.material_4 = self:getView():getChildByFullName("main.material_4")

	self.material_4:setVisible(false)

	self.material_5 = self:getView():getChildByFullName("main.material_5")

	self.material_5:setVisible(false)

	self.learnAnimPanel = self:getView():getChildByFullName("main.learnAnimPanel")
	self.coinPanel = self:getView():getChildByFullName("main.coinPanel")
	self.starPanel = self:getView():getChildByFullName("main.starPanel")
	self.rarityPanel = self:getView():getChildByFullName("main.rarityPanel")
	self._listView = self._main:getChildByFullName("ListView_1")

	self._listView:setScrollBarEnabled(false)

	self._leftBtn = self._main:getChildByFullName("Button_left")
	self._rightBtn = self._main:getChildByFullName("Button_right")
	self._panelBttom = self._main:getChildByFullName("Panel_bottom")
	self._useBtn = self._main:getChildByFullName("usebtn")
	self._gotoBtn = self._main:getChildByFullName("btnGo")

	local icon = IconFactory:createResourcePic({
		id = CurrencyIdKind.kGold
	})

	icon:addTo(self.coinPanel):center(self.coinPanel:getContentSize())

	local bg = self._main:getChildByName("bg")

	bg:ignoreContentAdaptWithSize(true)
	bg:loadTexture("asset/scene/scene_exhibition_1.jpg", ccui.TextureResType.localType)

	local function callback(sender, eventType)
		self._isShowSkillPage = not self._isShowSkillPage

		self:setPanelBottomView()
	end

	mapButtonHandlerClick(nil, self._panelBttom:getChildByFullName("Image_80"), {
		func = callback
	})
end

function BagURMapViewDetailMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(999)

	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("URMap_Unlock")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("URMaps_Name")
	}

	self._topInfoWidget = self:autoManageObject(self:getInjector():injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function BagURMapViewDetailMediator:setListView()
	self._listView:removeAllChildren()

	for i, v in ipairs(self._equipList) do
		local itemInfo = {
			amount = 1,
			code = v.equipment,
			type = RewardType.kEquip
		}
		local itemIcon

		if not self._bagSystem:getHasURMapEquipId(self._urMapId, v.equipment) then
			itemIcon = IconFactory:createRewardIcon(itemInfo, {
				isWidget = true,
				showAmount = false
			})

			itemIcon:setColor(cc.c3b(120, 120, 120))
		else
			local equipData
			local equipList = self._developSystem:getPlayer():getEquipList()
			local configData = ConfigReader:getRecordById("Compose", v.scrollID)
			local equipIds = equipList:getEquipsByType(configData.ComposePosition)

			for id, _ in pairs(equipIds) do
				local equip = equipList:getEquipById(id)

				if equip:getEquipId() == v.equipment then
					equipData = equip
				end
			end

			local isConsumeEquip = equipData:getPosition() == HeroEquipType.kStarItem
			local star = isConsumeEquip and 1 or equipData:getStar()

			itemIcon = IconFactory:createEquipIcon({
				id = equipData:getEquipId(),
				level = equipData:getLevel(),
				star = star,
				rarity = equipData:getRarity()
			})
		end

		itemIcon:setScale(0.7)

		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(100, 92))
		itemIcon:addTo(layout):center(layout:getContentSize())
		layout:setTouchEnabled(true)
		layout:setSwallowTouches(false)

		local _img = ccui.ImageView:create("asset/common/common_pz_xz.png", ccui.TextureResType.localType)

		_img:setScale(0.64)
		_img:addTo(layout):center(layout:getContentSize())
		_img:setVisible(self._curEntryId == v.scrollID)
		self._listView:pushBackCustomItem(layout)

		local function callback(sender, eventType)
			self._curEntryId = v.scrollID

			self:refreshView()
		end

		mapButtonHandlerClick(nil, layout, {
			func = callback
		})
	end

	if #self._equipList < 5 then
		for i = 1, 5 - #self._equipList do
			local layout = ccui.Layout:create()

			layout:setContentSize(cc.size(100, 92))
			layout:setTouchEnabled(true)
			layout:setSwallowTouches(false)

			local _img = ccui.ImageView:create("common_pz_kong.png", ccui.TextureResType.plistType)

			_img:addTo(layout):center(layout:getContentSize())
			_img:setScale(0.72)
			self._listView:pushBackCustomItem(layout)
		end
	end
end

function BagURMapViewDetailMediator:refreshRedPoint(sender)
	for k, layout in pairs(self._layoutTab) do
		if layout ~= sender then
			local hongdian = layout:getChildByFullName("hongdian")
			local redState = self._bagSystem:getComposeMaterialRedStateById(layout.curMaterial)

			if hongdian:isVisible() then
				hongdian:setVisible(redState)
			end
		end
	end
end

function BagURMapViewDetailMediator:setMaterialView()
	self.isDelay = false

	local MaterialTab = {}

	self._layoutTab = {}

	for i = 1, 10 do
		local curMaterial = self._configData["Item" .. i]

		if curMaterial then
			local layout = self.listCellClone:clone()

			layout.curMaterial = curMaterial

			table.insert(MaterialTab, layout)
		else
			for i = 3, 5 do
				self["material_" .. i]:setVisible(i == #MaterialTab)
			end

			self.MaterialLayout = self["material_" .. #MaterialTab]

			for i = 1, #MaterialTab do
				local material_cell = self.MaterialLayout:getChildByFullName("material_cell_" .. i)

				material_cell:removeAllChildren()

				local layout = MaterialTab[i]

				if layout.curMaterial.id then
					local layoutNull = self.listCellClone_Null:clone()
					local materialImage = layoutNull:getChildByFullName("materialImage")
					local pos = self._bagSystem:getComposePos(layout.curMaterial.id)

					materialImage:setVisible(true)
					materialImage:loadTexture(composePosImage[pos], ccui.TextureResType.plistType)

					layoutNull.curMaterial = layout.curMaterial
					layout = layoutNull

					self:refreshNullMaterialPanel(layoutNull, i)
					table.insert(self._layoutTab, layout)

					local index = i

					layout:addTouchEventListener(function(sender, eventType)
						if eventType == ccui.TouchEventType.began then
							self.isDelay = false

							local delayAct = cc.DelayTime:create(0.2)
							local judgeShowAct = cc.CallFunc:create(function()
								self.isDelay = true
							end)
							local seqAct = cc.Sequence:create(delayAct, judgeShowAct)

							sender:runAction(seqAct)
						elseif eventType == ccui.TouchEventType.moved then
							-- block empty
						elseif eventType == ccui.TouchEventType.ended then
							if self.isDelay then
								return
							end

							AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
							self:onSelectMaterial(sender, index)
						end
					end)
				else
					local layoutNull = self.listCellClone_Null:clone()
					local materialImage = layoutNull:getChildByFullName("materialImage")

					materialImage:setVisible(not not weaponIcon[layout.curMaterial.type])

					if weaponIcon[layout.curMaterial.type] then
						materialImage:loadTexture(weaponIcon[layout.curMaterial.type], ccui.TextureResType.plistType)
					end

					layoutNull.curMaterial = layout.curMaterial
					layout = layoutNull

					self:refreshNullMaterialPanel(layoutNull, i)
					table.insert(self._layoutTab, layout)

					local index = i

					layout:addTouchEventListener(function(sender, eventType)
						if eventType == ccui.TouchEventType.began then
							self.isDelay = false

							local delayAct = cc.DelayTime:create(0.2)
							local judgeShowAct = cc.CallFunc:create(function()
								self.isDelay = true
							end)
							local seqAct = cc.Sequence:create(delayAct, judgeShowAct)

							sender:runAction(seqAct)
						elseif eventType == ccui.TouchEventType.moved then
							-- block empty
						elseif eventType == ccui.TouchEventType.ended then
							if self.isDelay then
								return
							end

							AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
							self:onSelectMaterial(sender, index)
						end
					end)
				end

				layout:setVisible(true)
				layout:addTo(material_cell):posite(0, 1)
			end

			local material_cell = self._main:getChildByFullName("material_cell_0")

			material_cell:setVisible(true)
			material_cell:getChildByFullName("text_1"):setString(Strings:get("URSourceTag_TimeLimit"))

			local nodeIcon = material_cell:getChildByFullName("Node_36")
			local curHave = self._bagSystem:getItemCount(self._curEntryId)
			local itemInfo = {
				code = self._curEntryId,
				amount = curHave,
				type = RewardType.kItem
			}
			local haveNum = material_cell:getChildByFullName("haveNum")
			local needNum = material_cell:getChildByFullName("needNum")
			local numBg = material_cell:getChildByFullName("Image_100")

			haveNum:setString(curHave > 0 and 1 or 0)
			needNum:setString("/1")
			haveNum:setTextColor(curHave >= 1 and cc.c3b(0, 255, 0) or cc.c3b(255, 0, 0))
			haveNum:setPositionX(needNum:getPositionX() - needNum:getContentSize().width)
			numBg:setScaleX((haveNum:getContentSize().width + needNum:getContentSize().width + 12) / 42.31)
			material_cell:setPositionY(#MaterialTab == 5 and 225 or 263)

			local itemIcon = IconFactory:createRewardIcon(itemInfo, {
				isWidget = true,
				showAmount = false
			})

			itemIcon:setScale(0.8)
			itemIcon:addTo(nodeIcon):center(nodeIcon:getContentSize())

			if curHave == 0 then
				itemIcon:setTouchEnabled(true)

				local function callback(sender, eventType)
					local param = {
						needNum = 1,
						isNeed = true,
						hasWipeTip = true,
						itemId = self._curEntryId,
						hasNum = curHave
					}
					local view = self:getInjector():getInstance("sourceView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
					}, param, nil))
				end

				mapButtonHandlerClick(nil, itemIcon, {
					func = callback
				})
			else
				IconFactory:bindTouchHander(itemIcon, IconTouchHandler:new(self), itemInfo, {
					swallowTouches = true,
					needDelay = true
				})
			end

			break
		end
	end

	self.materialTab = MaterialTab

	self.currency:setString(self._currency.amount)

	local gold = self._developSystem:getGolds()

	if gold >= self._currency.amount then
		self.currency:setColor(cc.c3b(255, 255, 255))

		self._tabEnoughHttp.coin = {
			isEnough = true,
			id = self._currency.id
		}
	else
		self.currency:setColor(cc.c3b(255, 0, 0))

		self._tabEnoughHttp.coin = {
			isEnough = false,
			id = self._currency.id
		}
	end

	self.targetPanel:removeAllChildren()
	self:addIcon(self._target, self.targetPanel)

	local config = self:getMaterialData(self._target)
	local icon = IconFactory:createPic({
		id = self._target.id,
		rarity = config.Rareity
	}, {
		shine = true,
		ignoreScaleSize = true,
		largeIcon = true
	})
	local countBg = self._main:getChildByFullName("countBg")

	countBg:setVisible(false)

	if self._realEquip then
		countBg:setVisible(true)
		countBg:getChildByFullName("count"):setString("Lv." .. self._realEquip:getLevel())
	end

	icon:setScale(0.5)
	icon:addTo(self.targetPanel):center(self.targetPanel:getContentSize())
	self:addEquipStar()
	self.targetName:setString(Strings:get(config.Name))
	self.urMapName:setString(Strings:get(self._urMapConfig.MapName))
	self.rarityPanel:removeAllChildren()

	if self._target.type == "Equip" then
		local rarity = config.Rareity

		if rarity >= 15 then
			local flashFile = GameStyle:getEquipRarityFlash(rarity)
			local anim = cc.MovieClip:create(flashFile)

			anim:addTo(self.rarityPanel):center(self.rarityPanel:getContentSize())
		else
			local imageFile = GameStyle:getEquipRarityImage(rarity)
			local rarityImage = ccui.ImageView:create(imageFile)

			rarityImage:addTo(self.rarityPanel):center(self.rarityPanel:getContentSize())
			rarityImage:ignoreContentAdaptWithSize(true)
			rarityImage:setScale(0.9)
		end
	elseif self._target.type == "Item" then
		-- block empty
	end

	self.coinPanel:setVisible(true)
	self.currency:setVisible(true)
	self._useBtn:setVisible(true)
	self._gotoBtn:setVisible(false)

	if self._bagSystem:getHasURMapEquipId(self._urMapId, self._target.id) then
		for i = 3, 5 do
			self["material_" .. i]:setVisible(false)
		end

		local material_cell = self._main:getChildByFullName("material_cell_0")

		material_cell:setVisible(false)
		self.coinPanel:setVisible(false)
		self.currency:setVisible(false)
		self._useBtn:setVisible(false)
		self._gotoBtn:setVisible(true)
	end
end

function BagURMapViewDetailMediator:refreshNullMaterialPanel(layout, index, _data)
	local animLayer = layout:getChildByFullName("animLayer")
	local limitLayer = layout:getChildByFullName("limitLayer")
	local jiahaoLayer = layout:getChildByFullName("jiahaoLayer")
	local hongdian = layout:getChildByFullName("hongdian")

	hongdian:setVisible(false)
	jiahaoLayer:setVisible(not _data)
	limitLayer:setVisible(not _data)
	limitLayer:setScale(0.9)
	limitLayer:removeAllChildren()

	if layout.curMaterial.Quality then
		local rarity = layout.curMaterial.Quality

		if tonumber(rarity) >= 15 then
			local flashFile = GameStyle:getEquipRarityFlash(rarity)
			local anim = cc.MovieClip:create(flashFile)

			anim:addTo(limitLayer):center(limitLayer:getContentSize())
		else
			local imageFile = GameStyle:getEquipRarityImage(rarity)
			local rarityImage = ccui.ImageView:create(imageFile)

			rarityImage:addTo(limitLayer):center(limitLayer:getContentSize())
			rarityImage:ignoreContentAdaptWithSize(true)
			rarityImage:setScale(0.9)
		end
	end

	local animLayerAnim = animLayer:getChildByFullName("addAnim_kuang")
	local jiahaoLayerAnim = jiahaoLayer:getChildByFullName("addAnim_jiahao")

	if not animLayerAnim then
		local addAnim_kuang = self:getKuangAnim()

		addAnim_kuang:setName("addAnim_kuang")
		addAnim_kuang:addTo(animLayer):center(animLayer:getContentSize())

		local addAnim_jiahao = self:getJiaHaoAnim()

		addAnim_jiahao:setName("addAnim_jiahao")
		addAnim_jiahao:addTo(jiahaoLayer):center(jiahaoLayer:getContentSize())
	end

	if _data and _data.useItem then
		if self._tabEnoughHttp["Item" .. index] then
			self._tabEnoughHttp["Item" .. index] = self._tabEnoughHttp["Item" .. index] or {}
		end

		self._tabEnoughHttp["Item" .. index].id = _data and {
			{
				[_data.id] = 1
			}
		} or {}

		if _data then
			self._tabEnoughHttp["Item" .. index].isEnough = _data.isEnough or false
		end
	else
		if self._tabEnoughHttp["Item" .. index] then
			self._tabEnoughHttp["Item" .. index] = self._tabEnoughHttp["Item" .. index] or {}
		end

		self._tabEnoughHttp["Item" .. index].id = _data and {
			_data.uuId
		} or {}

		if _data then
			self._tabEnoughHttp["Item" .. index].isEnough = _data.isEnough or false
		end
	end

	if _data then
		local selectPanel = layout:getChildByFullName("selectPanel")

		selectPanel:removeAllChildren()

		local icon, data = self:getMaterialIcon(_data, 0.75)

		icon:addTo(selectPanel):center(selectPanel:getContentSize())

		local nodeToActionMap = {}

		nodeToActionMap[icon] = wpNodeAnim

		local startFunc2, stopFunc2 = CommonUtils.bindNodeToActionNode(nodeToActionMap, jiahaoLayerAnim, false)

		startFunc2()
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), data, {
			needDelay = true
		})
	else
		local redState = self._bagSystem:getComposeMaterialRedStateById(layout.curMaterial)

		hongdian:setVisible(redState)
	end

	local numBg = layout:getChildByFullName("Image_100")
	local haveNum = layout:getChildByFullName("haveNum")
	local needNum = layout:getChildByFullName("needNum")

	numBg:setVisible(false)
	haveNum:setString("")
	needNum:setString("")

	if _data and _data.useItem then
		numBg:setVisible(true)
		haveNum:setString("1")
		needNum:setString("/" .. layout.curMaterial.amount)
	end
end

function BagURMapViewDetailMediator:updataSelectMaterial(sender, index, _data, _selectEquipId, _selectEquipUUId, _selectItemId)
	local data = {}

	if _selectItemId == nil then
		data = {
			isEnough = true,
			type = "Equip",
			useItem = false,
			amount = 1,
			id = _selectEquipId,
			uuId = _selectEquipUUId
		}

		local key = _selectEquipId .. "_" .. _selectEquipUUId

		self._equipSystem:addComposeUsedEquips(index, key)
	else
		data = {
			isEnough = true,
			type = "Item",
			useItem = true,
			amount = 1,
			id = _selectItemId
		}
	end

	self:refreshNullMaterialPanel(sender, index, data)
	self:refreshRedPoint(sender)
end

function BagURMapViewDetailMediator:showSourcePath(itemId, hasNum, needNumLbl, layout, index)
	local function callBack()
		local haveLbl = self._bagSystem:getItemCount(itemId)

		if layout.curMaterial.type == "Item" then
			layout:getChildByFullName("haveNum"):setString(haveLbl)

			local haveNum = layout:getChildByFullName("haveNum")
			local needNum = layout:getChildByFullName("needNum")
			local numBg = layout:getChildByFullName("Image_100")
			local addAnim_kuang = layout:getChildByFullName("addAnim_kuang")
			local addAnim_jiahao = layout:getChildByFullName("addAnim_jiahao")

			if haveLbl == 0 then
				local color = cc.c3b(150, 150, 150)

				layout:getChildByFullName("IconNode"):setColor(color)
				numBg:setColor(color)
				needNum:setColor(color)
				haveNum:setColor(cc.c3b(200, 0, 0))

				if addAnim_kuang then
					addAnim_kuang:setVisible(true)
				end

				if addAnim_jiahao then
					addAnim_jiahao:setVisible(true)
				end

				self._tabEnoughHttp["Item" .. index].isEnough = false
			elseif haveLbl < needNumLbl then
				local color = cc.c3b(250, 250, 250)

				layout:getChildByFullName("IconNode"):setColor(color)
				numBg:setColor(color)
				needNum:setColor(color)
				haveNum:setColor(cc.c3b(255, 0, 0))

				self._tabEnoughHttp["Item" .. index].isEnough = false

				if addAnim_kuang then
					addAnim_kuang:setVisible(false)
				end

				if addAnim_jiahao then
					addAnim_jiahao:setVisible(false)
				end
			else
				self._tabEnoughHttp["Item" .. index].isEnough = true

				local color = cc.c3b(250, 250, 250)

				layout:getChildByFullName("IconNode"):setColor(color)
				numBg:setColor(color)
				needNum:setColor(color)
				haveNum:setColor(cc.c3b(0, 255, 0))

				if addAnim_kuang then
					addAnim_kuang:setVisible(false)
				end

				if addAnim_jiahao then
					addAnim_jiahao:setVisible(false)
				end
			end

			haveNum:setPositionX(needNum:getPositionX() - needNum:getContentSize().width)
			numBg:setScaleX((haveNum:getContentSize().width + needNum:getContentSize().width + 12) / 42.31)
		end
	end

	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = itemId,
		hasNum = hasNum,
		needNum = needNumLbl
	}
	local delegate = {}

	function delegate:willClose(popupMediator, data)
		callBack()
	end

	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param, delegate))
end

function BagURMapViewDetailMediator:onSelectMaterial(sender, index)
	local function callBack(_data, _selectEquipId, _selectEquipUUId, _selectItemId)
		self:updataSelectMaterial(sender, index, _data, _selectEquipId, _selectEquipUUId, _selectItemId)
	end

	local param = {
		curMaterial = sender.curMaterial,
		callBack = callBack,
		index = index,
		useComposeItem = index == 1,
		curComposeId = self._curEntryId
	}
	local view = self:getInjector():getInstance("BagSelectMaterialView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function BagURMapViewDetailMediator:addIcon(_data, _parentNode, isMaterial)
	local haveLbl = 0
	local isShowBg = false

	if _data.type == "Equip" then
		local allEquips = self._equipModule:getEquips()

		for k, v in pairs(allEquips) do
			if v:getEquipId() == _data.id and v:getLevel() == 1 and v:getUnlock() and v:getHeroId() == "" then
				haveLbl = haveLbl + 1
			end
		end
	else
		haveLbl = self._bagSystem:getItemCount(_data.id)
	end

	local icon, data = self:getMaterialIcon(_data, nil, isShowBg)
	local iconNode = _parentNode:getChildByFullName("IconNode") and _parentNode:getChildByFullName("IconNode") or _parentNode

	icon:addTo(iconNode):center(iconNode:getContentSize())

	local numBg = _parentNode:getChildByFullName("Image_100")
	local haveNum = _parentNode:getChildByFullName("haveNum")
	local needNum = _parentNode:getChildByFullName("needNum")

	if not numBg then
		icon:setVisible(false)

		if _data.type == "Equip" then
			IconFactory:bindClickHander(_parentNode, IconTouchHandler:new(self), data, {
				touchDisappear = true,
				swallowTouches = true
			})
		else
			IconFactory:bindTouchHander(_parentNode, IconTouchHandler:new(self), data, {
				needDelay = true
			})
		end

		return
	elseif _data.type == "Equip" then
		IconFactory:bindClickHander(_parentNode, IconTouchHandler:new(self), data, {
			touchDisappear = true,
			swallowTouches = true
		})
	else
		IconFactory:bindTouchHander(_parentNode, IconTouchHandler:new(self), data, {
			needDelay = true
		})
	end

	numBg:setVisible(not not isMaterial)
	haveNum:setString("")
	needNum:setString("")
	needNum:setColor(cc.c3b(255, 255, 255))

	local equipIds = self._equipModule:getEquipsByType(type)
	local needLbl = data.amount
	local isEnough = false

	if isMaterial then
		haveNum:setString(haveLbl)
		needNum:setString("/" .. needLbl)

		if needLbl <= haveLbl then
			haveNum:setColor(cc.c3b(0, 255, 0))

			isEnough = true
		else
			haveNum:setColor(cc.c3b(255, 0, 0))

			isEnough = false and isEnough
		end
	end

	haveNum:setPositionX(needNum:getPositionX() - needNum:getContentSize().width)
	numBg:setScaleX((haveNum:getContentSize().width + needNum:getContentSize().width + 12) / 42.31)

	return isEnough, haveLbl, needLbl
end

function BagURMapViewDetailMediator:getMaterialIcon(_data, _scale, isShowQualityRect)
	local data = {}

	for k, v in pairs(_data) do
		data[k] = v
	end

	if data.type == "Item" then
		data.type = RewardType.kItem
	elseif data.type == "Equip" then
		data.type = RewardType.kEquip
	end

	if data.amount then
		data.amount = data.amount or 1
	end

	data.code = _data.id

	local icon = IconFactory:createRewardIcon(data, {
		showAmount = false,
		isWidget = true,
		notShowQulity = isShowQualityRect
	})

	icon:setScaleNotCascade(_scale and _scale or 0.8)
	icon:setSwallowTouches(false)

	return icon, data
end

function BagURMapViewDetailMediator:shwoHeChenAnim(_MaterialNum, _callBackSucc)
	self.learnAnimPanel:removeAllChildren()

	if _MaterialNum == 2 then
		local lianggeyanshi = cc.MovieClip:create("lianggeyanshi_beibaoxuexi")

		lianggeyanshi:addTo(self.learnAnimPanel):posite(50, 5)
		lianggeyanshi:addCallbackAtFrame(10, function()
			lianggeyanshi:stop()
			self:showBomb(_callBackSucc)
		end)

		return
	end

	local manjiAnim = self:getManjiAnim()

	manjiAnim:addTo(self.learnAnimPanel):center(self.learnAnimPanel:getContentSize())

	for i = 1, 4 do
		local index = i
		local point = manjiAnim:getChildByFullName("point" .. i)

		if _MaterialNum == 3 then
			if index == 2 then
				point:setVisible(false)
			else
				point:addCallbackAtFrame(11, function()
					point:stop()

					if index == 4 then
						manjiAnim:stop()
						self:showBomb(_callBackSucc)
					end
				end)
			end
		else
			point:addCallbackAtFrame(11, function()
				point:stop()

				if index == 4 then
					manjiAnim:stop()
					self:showBomb(_callBackSucc)
				end
			end)
		end
	end
end

function BagURMapViewDetailMediator:getJiaHaoAnim()
	return (cc.MovieClip:create("jhAnim_beibaoxuexi"))
end

function BagURMapViewDetailMediator:getKuangAnim()
	return (cc.MovieClip:create("kuangjy_beibaoxuexi"))
end

function BagURMapViewDetailMediator:getLiziAnim()
	return (cc.MovieClip:create("lizi_beibaoxuexi"))
end

function BagURMapViewDetailMediator:getManjiAnim()
	return (cc.MovieClip:create("manji_beibaoxuexi"))
end

function BagURMapViewDetailMediator:showBomb(_callBackSucc)
	local liziAnim = self:getLiziAnim()

	liziAnim:addTo(self.learnAnimPanel):center(self.learnAnimPanel:getContentSize())
	liziAnim:addCallbackAtFrame(30, function()
		liziAnim:stop()
	end)

	local anim = cc.MovieClip:create("chenBomb_beibaoxuexi")

	anim:addTo(self.learnAnimPanel):center(self.learnAnimPanel:getContentSize())
	anim:addCallbackAtFrame(25, function()
		anim:stop()
	end)
	anim:addCallbackAtFrame(20, function()
		if _callBackSucc then
			_callBackSucc()
		end
	end)
end

function BagURMapViewDetailMediator:getMaterialData(info, style)
	assert(info ~= nil and info.id ~= nil, "Bad argument")

	local id = tostring(info.id)
	local config = ConfigReader:getRecordById("ResourcesIcon", id)

	if config and config.Id then
		return config
	end

	config = ConfigReader:getRecordById("HeroEquipBase", id)

	if config and config.Id then
		return config
	end

	config = ConfigReader:getRecordById("Skill", id)

	if config and config.Id then
		return config
	end

	config = ConfigReader:getRecordById("ItemConfig", id)

	if config and config.Id then
		return config
	end

	return nil
end

function BagURMapViewDetailMediator:onUseClicked()
	if not self._tabEnoughHttp.coin then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("bag_UI37")
		}))

		return
	end

	local curHave = self._bagSystem:getItemCount(self._curEntryId)

	if curHave < 1 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("bag_UI37")
		}))

		return
	end

	for k, v in pairs(self._tabEnoughHttp) do
		if not v.isEnough then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("bag_UI37")
			}))

			return
		end
	end

	local function callBackSucc()
		local function callback(responseRewardData)
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = responseRewardData
			}))
			self:refreshView()
		end

		local tab = {}

		for k, v in pairs(self._tabEnoughHttp) do
			if k ~= "coin" then
				if v.uuId then
					tab[k] = v.uuId or v.id
				end
			end
		end

		local data = {
			itemId = self._curEntryId,
			selected = tab
		}

		self._bagSystem:requestScrollCompose(data, callback)
	end

	if not self._canClickBtn then
		return
	end

	self._canClickBtn = false

	self:shwoHeChenAnim(#self.materialTab, callBackSucc)
end

function BagURMapViewDetailMediator:onGOToClicked()
	local param = {
		equipId = self._realEquip:getId()
	}

	self._equipSystem:tryEnter(param)
end

function BagURMapViewDetailMediator:setPanelBottomView()
	local HeroEquipExpMax = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExpMax", "content")
	local HeroEquipStarMax = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStarMax", "content")
	local config = ConfigReader:getRecordById("HeroEquipBase", self._target.id)
	local showSkilPanel = self._panelBttom:getChildByFullName("Panel_64")
	local text_desc = self._panelBttom:getChildByFullName("text_limit_0")

	showSkilPanel:getChildByFullName("Text_79"):setString(Strings:get("Equip_ShowUI"))
	showSkilPanel:setVisible(false)
	text_desc:setVisible(false)

	if not self._isShowSkillPage then
		text_desc:setVisible(true)
		text_desc:setString(Strings:get(config.Desc))

		return
	end

	showSkilPanel:setVisible(true)

	local limitDesc = showSkilPanel:getChildByFullName("text_limit")
	local limitNode = showSkilPanel:getChildByFullName("Node_limit")

	limitNode:removeAllChildren()

	local rarity = config.Rareity
	local level = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", HeroEquipExpMax[tostring(rarity)], "ShowLevel")
	local star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", HeroEquipStarMax[tostring(rarity)], "StarLevel")
	local equipOccu = config.Profession
	local occupationDesc = config.ProfessionDesc
	local occupationType = config.ProfessionType

	if occupationDesc ~= "" then
		limitDesc:setVisible(true)
		limitDesc:ignoreContentAdaptWithSize(true)
		limitDesc:setString(Strings:get(occupationDesc))
	else
		limitDesc:setVisible(false)

		if occupationType == nil or occupationType == 0 then
			if equipOccu then
				for i = 1, #equipOccu do
					local occupationName, occupationIcon = GameStyle:getHeroOccupation(equipOccu[i])
					local image = ccui.ImageView:create(occupationIcon)

					image:setAnchorPoint(cc.p(0, 0.5))
					image:setPosition(cc.p(40 * (i - 1), 0))
					image:setScale(0.5)
					image:addTo(limitNode)
				end
			end
		elseif occupationType == 1 and equipOccu then
			for i = 1, #equipOccu do
				local heroInfo = {
					id = IconFactory:getRoleModelByKey("HeroBase", equipOccu[i])
				}
				local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

				headImgName:setScale(0.2)

				headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

				headImgName:setAnchorPoint(cc.p(0, 0.5))
				headImgName:setPosition(cc.p(40 * (i - 1), 0))
				headImgName:addTo(limitNode)
			end
		end
	end

	local attrList = {}
	local params = {
		level = level,
		rarity = rarity,
		star = (rarity >= 15 and config.StartEquipEndID or nil) and ConfigReader:getDataByNameIdAndKey("HeroEquipStar", config.StartEquipEndID, "StarLevel"),
		config = config
	}
	local attrMap = HeroEquipAttr:getBaseAttrNum(nil, params)

	for i, v in pairs(attrMap) do
		if AttributeCategory:getAttNameAttend(v.attrType) == "" then
			v.attrNum = math.round(v.attrNum)
		end

		attrList[#attrList + 1] = v
	end

	table.sort(attrList, function(a, b)
		return a.index < b.index
	end)

	for i = 1, 2 do
		local attrPanel = showSkilPanel:getChildByFullName("desc_" .. i)

		attrPanel:setVisible(false)

		if attrList[i] then
			attrPanel:setVisible(true)

			local attrType = attrList[i].attrType
			local attrNum = attrList[i].attrNum
			local attrImage = attrPanel:getChildByFullName("image")

			attrImage:loadTexture(AttrTypeImage[attrType], 1)

			local attrText = attrPanel:getChildByFullName("text")

			attrText:setString(attrNum)

			if AttributeCategory:getAttNameAttend(attrType) ~= "" then
				attrText:setString(attrNum * 100 .. "%")
			end

			local name = attrPanel:getChildByFullName("name")

			name:setString(AttributeCategory:getAttName(attrType))
		end
	end

	if #attrList == 1 then
		local attrPanel = showSkilPanel:getChildByFullName("desc_1")

		attrPanel:setPositionY(30)
	else
		local attrPanel = showSkilPanel:getChildByFullName("desc_1")

		attrPanel:setPositionY(46)
	end

	local skillName = showSkilPanel:getChildByName("name")
	local skillLevel = showSkilPanel:getChildByName("level")
	local skillPro = PrototypeFactory:getInstance():getSkillPrototype(config.Skill)
	local skillConfig = skillPro:getConfig()

	skillName:setString(Strings:get(skillConfig.Name))

	local HeroEquipSkillLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipSkillLevel", "content")
	local URUPSkillLV = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", self._target.id, "URUPSkillLV")

	if URUPSkillLV then
		HeroEquipSkillLevel = URUPSkillLV
	end

	local maxSkillLevel = #HeroEquipSkillLevel
	local tip = Strings:get("Strenghten_Text78", {
		level = maxSkillLevel
	})

	skillLevel:setString(tip)

	local skillListView = showSkilPanel:getChildByFullName("listView")

	skillListView:removeAllChildren()
	skillListView:setScrollBarEnabled(false)

	local title = skillConfig.Desc
	local skillId = config.Skill
	local style = {
		fontSize = 18,
		fontColor = "#FFFFFF",
		fontName = TTF_FONT_FZYH_M
	}
	local desc = ConfigReader:getEffectDesc("Skill", title, skillId, maxSkillLevel, style)
	local getSkillDesc = skillPro:getAttrDescs(1, style)[1]

	if getSkillDesc then
		local add = "<font face='asset/font/CustomFont_FZYH_M.TTF' size='18' color='#FFFFFF'>，</font>"

		desc = getSkillDesc .. add .. desc
	end

	local width = skillListView:getContentSize().width
	local label = ccui.RichText:createWithXML(desc, {})

	label:renderContent(width, 0)
	label:setAnchorPoint(cc.p(0, 0))
	label:setPosition(cc.p(0, 0))

	local height = label:getContentSize().height
	local newPanel = ccui.Layout:create()

	newPanel:setContentSize(cc.size(width, height))
	label:addTo(newPanel)
	skillListView:pushBackCustomItem(newPanel)
end

function BagURMapViewDetailMediator:onLeftClicked()
	if self._urMapIndex <= 1 then
		return
	end

	self._urMapIndex = self._urMapIndex - 1
	self._urMapId = self._urMapList[self._urMapIndex].config.Id
	self._urMapConfig = ConfigReader:getRecordById("UREuipmentMap", self._urMapId)
	self._equipList = self._urMapConfig.EquipList

	self:setCurId()
	self:refreshView()
	self:setBtnVisibleView()
end

function BagURMapViewDetailMediator:onRightClicked()
	if self._urMapIndex >= #self._urMapList then
		return
	end

	self._urMapIndex = self._urMapIndex + 1
	self._urMapId = self._urMapList[self._urMapIndex].config.Id
	self._urMapConfig = ConfigReader:getRecordById("UREuipmentMap", self._urMapId)
	self._equipList = self._urMapConfig.EquipList

	self:setCurId()
	self:refreshView()
	self:setBtnVisibleView()
end

function BagURMapViewDetailMediator:setBtnVisibleView()
	self._leftBtn:setVisible(self._urMapIndex > 1)
	self._rightBtn:setVisible(self._urMapIndex < #self._urMapList)
end

function BagURMapViewDetailMediator:addEquipStar()
	local star = 0
	local starId = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", self._target.id, "StartEquipStarID")

	if starId then
		star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", starId, "StarLevel")
	else
		local HeroEquipStar = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStar", "content")
		local rarity = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", self._target.id, "Rareity")

		star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", HeroEquipStar[tostring(rarity)], "StarLevel")
	end

	self.starPanel:removeAllChildren(true)

	if self._realEquip then
		star = self._realEquip:getStar()
	end

	local showStar = star >= 5 and 5 or star

	if star and star > 0 then
		local intervalX = 35
		local startX = 70 - (showStar - 1) * 0.5 * intervalX

		for index = 1, showStar do
			local starImg = ccui.ImageView:create("img_yinghun_img_star_full.png", 1)

			starImg:setScale(0.6)

			if star - index >= 5 then
				starImg = ccui.ImageView:create("asset/common/yinghun_img_star_color.png")

				starImg:setScale(1)
			end

			starImg:setPosition(startX + (index - 1) * intervalX, 15)
			self.starPanel:addChild(starImg)
		end
	end
end

function BagURMapViewDetailMediator:onClickBack()
	self:dismiss()
end

function BagURMapViewDetailMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "URMap_RuleText", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {}
	}))
end
