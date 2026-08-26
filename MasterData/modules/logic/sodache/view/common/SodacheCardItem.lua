-- chunkname: @modules/logic/sodache/view/common/SodacheCardItem.lua

module("modules.logic.sodache.view.common.SodacheCardItem", package.seeall)

local SodacheCardItem = class("SodacheCardItem", LuaCompBase)

function SodacheCardItem:init(go)
	self.go = go
	self.canvasGroup = gohelper.onceAddComponent(go, gohelper.Type_CanvasGroup)
	self.goTypeMap = self:getUserDataTb_()
	self.txtNameMap = self:getUserDataTb_()

	self:initTypeGos()

	local parentGo = self:getTypeInfoRoot(1)

	self.imageMaterialsBG = gohelper.findChildImage(parentGo, "image_MaterialsBG")
	self.imagePropBG = gohelper.findChildImage(parentGo, "image_PropBG")
	self.simageMaterial = gohelper.findChildSingleImage(parentGo, "image_PropBG/simage_Material")
	parentGo = self:getTypeInfoRoot(2)
	self.imageAdventureBG = gohelper.findChildImage(parentGo, "image_AdventureBG")
	self.simageAdventure = gohelper.findChildSingleImage(parentGo, "Mask/simage_Adventure")
	self.goDiceItem = gohelper.findChild(parentGo, "go_DiceItem")

	gohelper.setActive(self.goDiceItem, false)

	self.goDiceLess = gohelper.findChild(parentGo, "go_DiceLess")
	self.goDiceMoreUp = gohelper.findChild(parentGo, "go_DiceMore/Up")
	self.goDiceMoreDown = gohelper.findChild(parentGo, "go_DiceMore/Down")
	parentGo = self:getTypeInfoRoot(3)
	self.imageBulletRare = gohelper.findChildImage(parentGo, "image_BulletRare")
	self.simageBullet = gohelper.findChildSingleImage(parentGo, "simage_Bullet")
	parentGo = self:getTypeInfoRoot(4)
	self.goBuff = gohelper.findChild(parentGo, "Buff")
	self.simageBuff = gohelper.findChildSingleImage(parentGo, "Buff/mask/simage_Buff")
	self.goDebuff = gohelper.findChild(parentGo, "Debuff")
	self.simageDebuff = gohelper.findChildSingleImage(parentGo, "Debuff/mask/simage_Debuff")
	parentGo = self:getTypeInfoRoot(5)
	self.imageRelicRare = gohelper.findChildImage(parentGo, "image_RelicRare")
	self.simageRelic = gohelper.findChildSingleImage(parentGo, "frame/simage_Relic")
	self.imageRelicAttr = gohelper.findChildImage(parentGo, "Attrs/image_RelicAttr")
	self.goStars = gohelper.findChild(parentGo, "Stars")
	self.isShowStar = false
	self.goRelicStars = self:getUserDataTb_()

	for i = 1, 5 do
		self.goRelicStars[i] = gohelper.findChild(parentGo, "Stars/Star" .. i)
	end

	self.goValue = gohelper.findChild(go, "Info/go_Value")
	self.txtValue = gohelper.findChildText(go, "Info/go_Value/txt_Value")
	self.goCount = gohelper.findChild(go, "Info/Right/go_Count")
	self.txtCount = gohelper.findChildText(go, "Info/Right/go_Count/txt_Count")
	self.goCost = gohelper.findChild(go, "Info/Right/go_Cost")
	self.txtCost = gohelper.findChildText(go, "Info/Right/go_Cost/txt_Cost")
	self.goSelect = gohelper.findChild(go, "go_Select")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self._gorecommend = gohelper.findChild(go, "Info/go_Recommend")
	self._goRate = gohelper.findChild(go, "Info/go_Rate")

	self:_editableInitView()
end

function SodacheCardItem:initTypeGos()
	for i = 1, 5 do
		self.goTypeMap[i] = gohelper.findChild(self.go, "type" .. i)
		self.txtNameMap[i] = gohelper.findChildText(self.goTypeMap[i], "txt_Name")
	end
end

function SodacheCardItem:getTypeInfoRoot(index)
	return self.goTypeMap[index]
end

function SodacheCardItem:_editableInitView()
	self.isShowInfo = {
		true,
		true,
		true
	}
	self.anim = gohelper.findComponentAnim(self.go)
	self.goVx1 = gohelper.findChild(self.go, "#leveup1")
	self.goVx2 = gohelper.findChild(self.go, "#leveup2")
end

function SodacheCardItem:addEventListeners()
	self.btnClick:AddClickListener(self._onClickItem, self)
end

function SodacheCardItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

function SodacheCardItem:onDestroy()
	TaskDispatcher.cancelTask(self.delayHide, self)
	TaskDispatcher.cancelTask(self.refreshStar, self)
end

function SodacheCardItem:updateMo(mo)
	self.data = mo
	self.config = mo.serverMo.itemCo

	local cardType = self.config.type
	local value = SodacheConfig.instance:getItemPrice(self.config.id)

	self:setValue(value)
	self:setCount(mo.serverMo.count)
	self:setCost(self.config.cost)

	self.txtNameMap[cardType].text = self.config.name

	local func = self["refreshCardType" .. cardType]

	if self.config and func then
		func(self)
	end

	for type, go in pairs(self.goTypeMap) do
		gohelper.setActive(go, type == cardType)
	end

	if self._gorecommend then
		gohelper.setActive(self._gorecommend, self.data.serverMo:isRecommend())
	end
end

function SodacheCardItem:_onClickItem()
	if self.noNeedClick then
		return
	end

	if self.callback then
		self.callback(self.callbackObj, self.callbackParam)

		return
	end

	if not self.data then
		return
	end

	ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
		cardMo = self.data
	})
end

function SodacheCardItem:setNoNeedClick()
	self.noNeedClick = true
end

function SodacheCardItem:showInfo(param)
	param = param or {
		false,
		false,
		false
	}

	gohelper.setActive(self.goValue, param[1])
	gohelper.setActive(self.goCount, param[2])
	gohelper.setActive(self.goCost, param[3])

	self.isShowInfo = param
end

function SodacheCardItem:setValue(value)
	if self.isShowInfo[1] then
		value = value or 0
		self.txtValue.text = value

		gohelper.setActive(self.goValue, value > 0)
	end
end

function SodacheCardItem:setCost(cost)
	if self.isShowInfo[3] then
		cost = cost or 0
		self.txtCost.text = cost

		gohelper.setActive(self.goCost, cost > 0)
	end
end

function SodacheCardItem:setCount(count)
	if self.isShowInfo[2] then
		count = count or 1
		self.txtCount.text = count

		gohelper.setActive(self.goCount, count > 1)
	end
end

function SodacheCardItem:setActiveLock(isLock)
	self.canvasGroup.alpha = isLock and 0.5 or 1
end

function SodacheCardItem:setActiveSelect(isSelect)
	gohelper.setActive(self.goSelect, isSelect)
end

function SodacheCardItem:setActiveClick(active)
	gohelper.setActive(self.btnClick, active)
end

function SodacheCardItem:setOverrideClick(callback, callbackObj, callbackParam)
	self.callback = callback
	self.callbackObj = callbackObj
	self.callbackParam = callbackParam
end

function SodacheCardItem:refreshCardType1()
	local quality = self.config.quality

	UISpriteSetMgr.instance:setSodacheSprite(self.imageMaterialsBG, "sodache_card_materials_bg_0" .. tostring(quality))
	UISpriteSetMgr.instance:setSodache2Sprite(self.imagePropBG, "sodache_card_materials_0" .. tostring(quality))
	SodacheCardItem.loadItemIcon(self.simageMaterial, self.config.icon)
end

function SodacheCardItem:refreshCardType2()
	local quality = GameUtil.clamp(self.config.quality - 1, 1, 4)

	UISpriteSetMgr.instance:setSodacheSprite(self.imageAdventureBG, "sodache_card_adventure_0" .. tostring(quality))
	SodacheCardItem.loadItemIcon(self.simageAdventure, self.config.icon)

	local diceIds = string.splitToNumber(self.config.diceList, "#")

	self.diceItemList = self.diceItemList or {}

	local diceCount = #diceIds

	for k, id in ipairs(diceIds) do
		local diceItem = self.diceItemList[k]

		if diceCount < 4 then
			local var_20_0 = self.goDiceLess

			if not self.goDiceLess then
				if k < 4 then
					var_20_0 = self.goDiceMoreUp

					if not self.goDiceMoreUp then
						local parent = self.goDiceMoreDown

						if not diceItem then
							local go = gohelper.clone(self.goDiceItem, parent)

							diceItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheDiceItem)
							self.diceItemList[k] = diceItem
						end

						gohelper.setParent(diceItem.go, parent)
						diceItem:setData(id)
						gohelper.setActive(diceItem.go, true)
					end
				end
			end
		end
	end

	for i = #diceIds + 1, #self.diceItemList do
		gohelper.setActive(self.diceItemList[i].go, false)
	end
end

function SodacheCardItem:refreshCardType3()
	local quality = self.config.quality

	UISpriteSetMgr.instance:setSodacheSprite(self.imageBulletRare, "sodache_card_bullet_0" .. tostring(quality))
	SodacheCardItem.loadItemIcon(self.simageBullet, self.config.icon)
end

function SodacheCardItem:refreshCardType4()
	if self.config.subType == SodacheEnum.CardSubType.Status_Buff then
		SodacheCardItem.loadItemIcon(self.simageBuff, self.config.icon)
		gohelper.setActive(self.goBuff, true)
	elseif self.config.subType == SodacheEnum.CardSubType.Status_Debuff then
		SodacheCardItem.loadItemIcon(self.simageDebuff, self.config.icon)
		gohelper.setActive(self.goDebuff, true)
	end
end

function SodacheCardItem:refreshCardType5()
	local quality = GameUtil.clamp(self.config.quality - 3, 1, 3)

	self:setRelicImage(quality)
	SodacheCardItem.loadItemIcon(self.simageRelic, self.config.icon)
	UISpriteSetMgr.instance:setSodache2Sprite(self.imageRelicAttr, "sodache_card_career_0" .. tostring(self.config.subType - 500))
	self:refreshStar()
end

function SodacheCardItem:refreshStar()
	if self.isShowStar then
		local relicBox = SodacheModel.instance:getOutsideMo().relicBox
		local level = relicBox:getRelicLv(self.config.id)

		for k, goStar in ipairs(self.goRelicStars) do
			gohelper.setActive(goStar, k <= level)
		end
	end

	gohelper.setActive(self.goStars, self.isShowStar)
end

function SodacheCardItem:playLevelUp(isMax)
	if isMax then
		self.showVx = self.goVx2 or self.goVx1
	end

	gohelper.setActive(self.showVx, true)
	TaskDispatcher.runDelay(self.delayHide, self, 0.67)
	TaskDispatcher.runDelay(self.refreshStar, self, 0.34)
end

function SodacheCardItem:delayHide()
	if self.showVx then
		gohelper.setActive(self.showVx, false)

		self.showVx = nil
	end
end

function SodacheCardItem:setRelicGray(isGray)
	UIColorHelper.setGray(self.imageRelicRare.gameObject, isGray)
	UIColorHelper.setGray(self.simageRelic.gameObject, isGray)
	UIColorHelper.setGray(self.imageRelicAttr.gameObject, isGray)
end

function SodacheCardItem:setRate(bool)
	if self._goRate then
		gohelper.setActive(self._goRate, bool)
	end
end

function SodacheCardItem:setShowStar(bool)
	self.isShowStar = bool
end

function SodacheCardItem:setRelicImage(quality)
	UISpriteSetMgr.instance:setSodacheSprite(self.imageRelicRare, "sodache_card_relic_0" .. tostring(quality))
end

function SodacheCardItem.loadItemIcon(singleImage, name)
	singleImage:LoadImage(ResUrl.getSodacheSingleBg(name, "collection"))
end

return SodacheCardItem
