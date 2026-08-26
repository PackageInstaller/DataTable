-- chunkname: @modules/logic/survival/view/reputation/shop/SurvivalReputationShopView.lua

module("modules.logic.survival.view.reputation.shop.SurvivalReputationShopView", package.seeall)

local SurvivalReputationShopView = class("SurvivalReputationShopView", BaseView)

function SurvivalReputationShopView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebuilding = gohelper.findChildSingleImage(self.viewGO, "Left/go_building/#simage_building")
	self._txtname = gohelper.findChildText(self.viewGO, "Left/go_building/#txt_name")
	self._imagecamp = gohelper.findChildImage(self.viewGO, "Left/go_building/#image_camp")
	self._imagelevelbg = gohelper.findChildImage(self.viewGO, "Left/go_building/#image_levelbg")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "Left/go_building/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "Left/go_building/#btn_right")
	self._leftRedDot = gohelper.findChild(self.viewGO, "Left/go_building/#leftRedDot")
	self._rightRedDot = gohelper.findChild(self.viewGO, "Left/go_building/#rightRedDot")
	self._txtlevel = gohelper.findChildText(self.viewGO, "Left/go_building/#txt_level")
	self._txtcamp = gohelper.findChildText(self.viewGO, "Left/go_building/#txt_camp")
	self._imageprogresspre = gohelper.findChildImage(self.viewGO, "Left/go_building/score/progress/#image_progress_pre")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "Left/go_building/score/progress/#image_progress")
	self._txtcurrent = gohelper.findChildText(self.viewGO, "Left/go_building/score/#txt_current")
	self._txttotal = gohelper.findChildText(self.viewGO, "Left/go_building/score/#txt_total")
	self._txtcondition = gohelper.findChildText(self.viewGO, "Left/go_building/#txt_condition")
	self._godetail = gohelper.findChild(self.viewGO, "#go_detail")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "Right/scroll_shop/Viewport/#go_scroll_content")
	self._gotopright = gohelper.findChild(self.viewGO, "Right/#go_topright")
	self._txttag = gohelper.findChildText(self.viewGO, "Right/#go_topright/tag/#txt_tag")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self.survivalreputationshopitem = gohelper.findChild(self.viewGO, "Right/scroll_shop/Viewport/#go_scroll_content/survivalreputationshopitem")

	gohelper.setActive(self.survivalreputationshopitem, false)

	self.playerViewGo = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self.refreshFlow = FlowSequence.New()

	self.refreshFlow:addWork(TimerWork.New(0.167))
	self.refreshFlow:addWork(FunctionWork.New(self.refresh, self))

	self.customItems = {}
end

function SurvivalReputationShopView:addEvents()
	self.addClickCb(self, self._btnleft, self.onClickLeftArrow, self)
	self.addClickCb(self, self._btnright, self.onClickRightArrow, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnClickTipsBtn, self._onTipsClick, self)
end

function SurvivalReputationShopView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	self.weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	self.reputationBuilds = self.weekInfo:getReputationBuilds()
	self.buildingId = self.viewParam.buildingId
	self.selectPos = self:getSelectPos()

	self:refresh()

	local res = self.viewContainer._viewSetting.otherRes.infoView
	local infoGo = self:getResInst(res, self._godetail)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:updateMo(nil)
	self._infoPanel:setCloseShow(true, self.closeInfoView, self)

	self.selectSurvivalBagItem = nil
end

function SurvivalReputationShopView:onClose()
	return
end

function SurvivalReputationShopView:onDestroyView()
	self.refreshFlow:clearWork()
end

function SurvivalReputationShopView:onShelterBagUpdate()
	self:refreshCurrency()
end

function SurvivalReputationShopView:onClickLeftArrow()
	if self.selectPos > 1 then
		self.selectPos = self.selectPos - 1
		self.buildingId = self.reputationBuilds[self.selectPos].id
	end

	self.playerViewGo:Play("switchleft", nil, nil)
	self.refreshFlow:clearWork()
	self.refreshFlow:start()
end

function SurvivalReputationShopView:onClickRightArrow()
	if self.selectPos < #self.reputationBuilds then
		self.selectPos = self.selectPos + 1
		self.buildingId = self.reputationBuilds[self.selectPos].id
	end

	self.playerViewGo:Play("switchright", nil, nil)
	self.refreshFlow:clearWork()
	self.refreshFlow:start()
end

function SurvivalReputationShopView:refresh()
	self.mo = self.weekInfo:getBuildingInfo(self.buildingId)
	self.survivalShopMo = self.mo.survivalReputationPropMo.survivalShopMo
	self.shopId = self.survivalShopMo.id
	self.shopCfg = lua_survival_shop.configDict[self.shopId]
	self.buildingCfgId = self.mo.buildingId
	self.buildCfg = SurvivalConfig.instance:getBuildingConfig(self.buildingCfgId, self.mo.level)
	self.survivalReputationPropMo = self.mo.survivalReputationPropMo
	self.prop = self.survivalReputationPropMo.prop
	self.reputationId = self.prop.reputationId
	self.reputationLevel = self.prop.reputationLevel
	self.reputationCfg = SurvivalConfig.instance:getReputationCfgById(self.reputationId, self.reputationLevel)
	self.reputationExp = self.prop.reputationExp
	self.isMaxLevel = self.survivalReputationPropMo:isMaxLevel()

	self:refreshBuild()
	self:refreshArrow()
	self:refreshCurrency()
	self:refreshItemList()
end

function SurvivalReputationShopView:refreshArrow()
	gohelper.setActive(self._btnleft, self.selectPos > 1)
	gohelper.setActive(self._btnright, self.selectPos < #self.reputationBuilds)

	if self.selectPos > 1 then
		local survivalShelterBuildingMo = self.reputationBuilds[self.selectPos - 1]

		gohelper.setActive(self._leftRedDot, survivalShelterBuildingMo:getReputationShopRedDot() > 0)
	else
		gohelper.setActive(self._leftRedDot, false)
	end

	if self.selectPos < #self.reputationBuilds then
		local survivalShelterBuildingMo = self.reputationBuilds[self.selectPos + 1]

		gohelper.setActive(self._rightRedDot, survivalShelterBuildingMo:getReputationShopRedDot() > 0)
	else
		gohelper.setActive(self._rightRedDot, false)
	end
end

function SurvivalReputationShopView:refreshBuild()
	self._simagebuilding:LoadImage(self.buildCfg.icon)

	self._txtname.text = self.buildCfg.name

	UISpriteSetMgr.instance:setSurvivalSprite(self._imagecamp, self.reputationCfg.icon .. "_1")

	self._txtlevel.text = "Lv." .. self.reputationLevel
	self._txtcamp.text = self.reputationCfg.name

	local leveBg = self.survivalReputationPropMo:getLevelBkg()

	UISpriteSetMgr.instance:setSurvivalSprite2(self._imagelevelbg, leveBg)

	leveBg = self.survivalReputationPropMo:getLevelProgressBkg(true)

	UISpriteSetMgr.instance:setSurvivalSprite2(self._imageprogresspre, leveBg)

	leveBg = self.survivalReputationPropMo:getLevelProgressBkg()

	UISpriteSetMgr.instance:setSurvivalSprite2(self._imageprogress, leveBg)

	if self.isMaxLevel then
		self._imageprogress.fillAmount = 1
	else
		local reputationCost = SurvivalConfig.instance:getReputationCost(self.reputationId, self.reputationLevel)

		self._imageprogress.fillAmount = self.reputationExp / reputationCost
	end

	if self.isMaxLevel then
		self._txtcurrent.text = "--"
		self._txttotal.text = "--"
	else
		self._txtcurrent.text = self.reputationExp
		self._txttotal.text = SurvivalConfig.instance:getReputationCost(self.reputationId, self.reputationLevel)
	end

	self._txtcondition.text = self.buildCfg.desc
end

function SurvivalReputationShopView:refreshCurrency()
	self._txttag.text = self.weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):getItemCountPlus(SurvivalEnum.CurrencyType.Gold)
end

function SurvivalReputationShopView:refreshItemList()
	local listData = {}
	local reputationMaxLevel = self.survivalShopMo:getReputationItemMaxLevel()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local clientData = weekMo.clientData
	local lastLevel = clientData:getReputationShopUILevel(self.shopId)

	for i = 1, reputationMaxLevel do
		local posLevel = i
		local isLock = self.survivalShopMo:isReputationShopLevelLock(posLevel)
		local t = {
			viewContainer = self.viewContainer,
			survivalReputationPropMo = self.survivalReputationPropMo,
			index = i,
			reputationLevel = self.reputationLevel,
			isPlayLockAnim = not isLock and lastLevel < posLevel
		}

		table.insert(listData, t)
	end

	local customItemAmount = #self.customItems
	local listLength = #listData

	for i = 1, listLength do
		local data = listData[i]

		if customItemAmount < i then
			local obj = gohelper.clone(self.survivalreputationshopitem, self._goscrollcontent)

			gohelper.setActive(obj, true)

			self.customItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalReputationShopItem)
		end

		self.customItems[i]:updateMo(data, self)
	end

	clientData:setReputationShopUILevel(self.shopId, self.reputationLevel)
	clientData:saveDataToServer()
end

function SurvivalReputationShopView:getSelectPos()
	for i, mo in ipairs(self.reputationBuilds) do
		if mo.id == self.buildingId then
			return i
		end
	end
end

function SurvivalReputationShopView:showInfoPanel(survivalBagItem, itemMo, shopId, shopType, isHideBuy)
	if self.selectSurvivalBagItem then
		self.selectSurvivalBagItem:setIsSelect(false)
	end

	self.selectSurvivalBagItem = survivalBagItem

	self.selectSurvivalBagItem:setIsSelect(true)
	self._infoPanel:setShopData(shopId, shopType)
	self._infoPanel:updateMo(itemMo, {
		hideBuy = isHideBuy
	})
end

function SurvivalReputationShopView:closeInfoView()
	self._infoPanel:updateMo(nil)

	if self.selectSurvivalBagItem then
		self.selectSurvivalBagItem:setIsSelect(false)

		self.selectSurvivalBagItem = nil
	end
end

function SurvivalReputationShopView:_onTipsClick()
	self:closeInfoView()
end

return SurvivalReputationShopView
