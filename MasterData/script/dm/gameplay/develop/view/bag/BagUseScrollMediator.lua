-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagUseScrollMediator.lua

require("dm.gameplay.develop.view.bag.BagEquipPancel")

BagUseScrollMediator = class("BagUseScrollMediator", DmPopupViewMediator, _M)

BagUseScrollMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local weaponIcon = {
	Weapon = "bb_zb_zb01.png",
	Shoes = "bb_zb_zb04.png",
	Decoration = "bb_zb_zb02.png",
	Tops = "bb_zb_zb03.png"
}
local kBtnHandlers = {
	["main.leftBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onLeftClicked"
	},
	["main.rightBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onRightClicked"
	},
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}

function BagUseScrollMediator:initialize()
	super.initialize(self)
end

function BagUseScrollMediator:dispose()
	self._equipSystem:clearComposeUsedEquips()
	super.dispose(self)
end

function BagUseScrollMediator:userInject()
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
	self._rewardSystem = self._developSystem:getEquipSystem()
	self._equipModule = self._developSystem:getPlayer():getEquipList()
end

function BagUseScrollMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._useBtn = self:bindWidget("main.usebtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onUseClicked, self)
		}
	})

	self._useBtn:setButtonName(Strings:get("bag_UI31"), Strings:get("UITitle_EN_ZueXi"))
end

function BagUseScrollMediator:enterWithData(data)
	self._canClickBtn = true
	self._curEntryId = data.curEntryId
	self._curEntryIds = data.curEntryIds

	self:setViewUI()
	self:refreshView()
	self._equipSystem:clearComposeUsedEquips()
end

function BagUseScrollMediator:refreshView()
	self:setMaterialData()
	self:setMaterialView()
end

function BagUseScrollMediator:setMaterialData()
	local configData = ConfigReader:getRecordById("Compose", self._curEntryId)

	self._configData = configData
	self._target = configData.Show
	self._currency = configData.Currency
	self._tabEnoughHttp = {}
end

function BagUseScrollMediator:setViewUI()
	self.mainPanel = self:getView():getChildByFullName("main")
	self.currency = self:getView():getChildByFullName("main.currency")

	self:getView():getChildByFullName("main.leftBtn"):setVisible(false)
	self:getView():getChildByFullName("main.rightBtn"):setVisible(false)

	self.targetName = self:getView():getChildByFullName("main.targetName")
	self.listCellClone = self:getView():getChildByFullName("main.listCellClone")

	self.listCellClone:setVisible(false)

	self.listCellClone_Null = self:getView():getChildByFullName("main.listCellClone_Null")

	self.listCellClone_Null:setVisible(false)

	self.targetPanel = self:getView():getChildByFullName("main.targetPanel")
	self.material_2 = self:getView():getChildByFullName("main.material_2")

	self.material_2:setVisible(false)

	self.material_3 = self:getView():getChildByFullName("main.material_3")

	self.material_3:setVisible(false)

	self.material_4 = self:getView():getChildByFullName("main.material_4")

	self.material_4:setVisible(false)

	self.material_5 = self:getView():getChildByFullName("main.material_5")

	self.material_5:setVisible(false)
	self:getView():getChildByFullName("main.Text_1"):setString(Strings:get("bag_UI32"))
	self:getView():getChildByFullName("main.Text_2"):setString(Strings:get("bag_EN_UI32"))

	self.learnAnimPanel = self:getView():getChildByFullName("main.learnAnimPanel")
	self.coinPanel = self:getView():getChildByFullName("main.coinPanel")
	self.starPanel = self:getView():getChildByFullName("main.starPanel")
	self.rarityPanel = self:getView():getChildByFullName("main.rarityPanel")

	local icon = IconFactory:createResourcePic({
		id = CurrencyIdKind.kGold
	})

	icon:addTo(self.coinPanel):center(self.coinPanel:getContentSize())
end

function BagUseScrollMediator:refreshRedPoint(sender)
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

function BagUseScrollMediator:setMaterialView()
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
			for i = 2, 5 do
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

	icon:setScale(0.5)
	icon:addTo(self.targetPanel):center(self.targetPanel:getContentSize())
	self:addEquipStar()
	self.targetName:setString(Strings:get(config.Name))
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
end

function BagUseScrollMediator:refreshNullMaterialPanel(layout, index, _data)
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

function BagUseScrollMediator:updataSelectMaterial(sender, index, _data, _selectEquipId, _selectEquipUUId, _selectItemId)
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

function BagUseScrollMediator:showSourcePath(itemId, hasNum, needNumLbl, layout, index)
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

function BagUseScrollMediator:onSelectMaterial(sender, index)
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

function BagUseScrollMediator:addIcon(_data, _parentNode, isMaterial)
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

function BagUseScrollMediator:getMaterialIcon(_data, _scale, isShowQualityRect)
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

function BagUseScrollMediator:shwoHeChenAnim(_MaterialNum, _callBackSucc)
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

function BagUseScrollMediator:getJiaHaoAnim()
	return (cc.MovieClip:create("jhAnim_beibaoxuexi"))
end

function BagUseScrollMediator:getKuangAnim()
	return (cc.MovieClip:create("kuangjy_beibaoxuexi"))
end

function BagUseScrollMediator:getLiziAnim()
	return (cc.MovieClip:create("lizi_beibaoxuexi"))
end

function BagUseScrollMediator:getManjiAnim()
	return (cc.MovieClip:create("manji_beibaoxuexi"))
end

function BagUseScrollMediator:showBomb(_callBackSucc)
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

function BagUseScrollMediator:getMaterialData(info, style)
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

function BagUseScrollMediator:onClickClose()
	self:close()
end

function BagUseScrollMediator:onUseClicked()
	if not self._tabEnoughHttp.coin then
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
			self:onClickClose()
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

function BagUseScrollMediator:onLeftClicked()
	for k, v in pairs(self._curEntryIds) do
		if v == self._curEntryId and self._curEntryIds[k - 1] and self._curEntryIds[k - 1] ~= -1 then
			self._curEntryId = self._curEntryIds[k - 1]

			self:refreshView()

			break
		end
	end
end

function BagUseScrollMediator:onRightClicked()
	for k, v in pairs(self._curEntryIds) do
		if v == self._curEntryId and self._curEntryIds[k + 1] and self._curEntryIds[k + 1] ~= -1 then
			self._curEntryId = self._curEntryIds[k + 1]

			self:refreshView()

			break
		end
	end
end

function BagUseScrollMediator:addEquipStar()
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

	if star and star > 0 then
		local intervalX = 35
		local startX = 70 - (star - 1) * 0.5 * intervalX

		for index = 1, star do
			local starImg = ccui.ImageView:create("img_yinghun_img_star_full.png", 1)

			starImg:setScale(0.6)

			if index >= 6 then
				starImg = ccui.ImageView:create("asset/common/yinghun_img_star_color.png")

				starImg:setScale(1)
			end

			starImg:setPosition(startX + (index - 1) * intervalX, 15)
			self.starPanel:addChild(starImg)
		end
	end
end
