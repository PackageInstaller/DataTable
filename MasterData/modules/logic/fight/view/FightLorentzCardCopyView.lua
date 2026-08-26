-- chunkname: @modules/logic/fight/view/FightLorentzCardCopyView.lua

module("modules.logic.fight.view.FightLorentzCardCopyView", package.seeall)

local FightLorentzCardCopyView = class("FightLorentzCardCopyView", BaseView)

FightLorentzCardCopyView.OpenAnimDuration = 1
FightLorentzCardCopyView.CloseAnimDuration = 1
FightLorentzCardCopyView.FlyItemDuration = 0.2

function FightLorentzCardCopyView:onInitView()
	self.cardItemList = {}
	self.srcPool = self:getUserDataTb_()
	self.curPool = self:getUserDataTb_()

	local goMiddle = gohelper.findChild(self.viewGO, "root/Middle")

	gohelper.setActive(goMiddle, false)
	table.insert(self.srcPool, gohelper.findChild(self.viewGO, "root/Middle/card1"))
	table.insert(self.srcPool, gohelper.findChild(self.viewGO, "root/Middle/card2"))
	table.insert(self.srcPool, gohelper.findChild(self.viewGO, "root/Middle/card3"))

	self.goLayout = gohelper.findChild(self.viewGO, "root/layout")
	self.flyRoot = gohelper.findChild(self.viewGO, "root/#go_flyItemContent")
	self.flyRootRectTr = self.flyRoot:GetComponent(gohelper.Type_RectTransform)
	self.flyItem = gohelper.findChild(self.viewGO, "root/#go_flyItemContent/#fly")

	gohelper.setActive(self.flyItem, false)
end

function FightLorentzCardCopyView:addEvents()
	return
end

function FightLorentzCardCopyView:removeEvents()
	return
end

function FightLorentzCardCopyView.blockEsc()
	return
end

function FightLorentzCardCopyView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
end

function FightLorentzCardCopyView:getPrefabGo()
	if #self.curPool < 1 then
		tabletool.addValues(self.curPool, self.srcPool)
	end

	local go

	if #self.curPool == 1 then
		go = table.remove(self.curPool)
	else
		local index = math.random(1, #self.curPool)

		go = table.remove(self.curPool, index)
	end

	return gohelper.clone(go, self.goLayout)
end

function FightLorentzCardCopyView:createCardItem()
	local go = self:getPrefabGo()
	local item = self:getUserDataTb_()

	item.go = go
	item.rectTr = go:GetComponent(gohelper.Type_RectTransform)
	item.animator = gohelper.findChildComponent(go, "ani", gohelper.Type_Animator)
	item.simage = gohelper.findChildSingleImage(go, "ani/image_card")
	item.imageList = self:getUserDataTb_()
	item.goLvList = self:getUserDataTb_()
	item.starList = self:getUserDataTb_()

	for i = 1, 3 do
		local image = gohelper.findChildSingleImage(go, string.format("ani/lv%s/imgIcon", i))

		table.insert(item.imageList, image)

		local lvGo = gohelper.findChild(go, "ani/lv" .. i)

		table.insert(item.goLvList, lvGo)

		local starGo = gohelper.findChild(go, "ani/star/star" .. i)

		table.insert(item.starList, starGo)
	end

	item.tag = gohelper.findChildSingleImage(go, "ani/tag/tag/tagIcon")
	item.tagTransform = item.tag:GetComponent(gohelper.Type_RectTransform)

	if self.useSkin then
		local goAnim = gohelper.findChild(go, "ani")
		local frontBgRoot = gohelper.create2d(goAnim, "skinFrontBg")

		gohelper.setActive(frontBgRoot, true)
		gohelper.setSibling(frontBgRoot, 3)
		transformhelper.setLocalScale(frontBgRoot.transform, 1.76, 1.76, 1)

		local frontBgNormal = gohelper.create2d(frontBgRoot, "skinFrontBgNormal")
		local imgFrontBgNormal = gohelper.onceAddComponent(frontBgNormal, gohelper.Type_Image)

		UISpriteSetMgr.instance:setFightSkillCardSprite(imgFrontBgNormal, "card_dz4", true)
		recthelper.setAnchorY(frontBgNormal.transform, -7.86)

		local backBgRoot = gohelper.create2d(goAnim, "skinBackBg")

		gohelper.setActive(backBgRoot, true)
		gohelper.setSibling(backBgRoot, 0)
		transformhelper.setLocalScale(backBgRoot.transform, 1.76, 1.76, 1)

		local img = gohelper.onceAddComponent(backBgRoot, gohelper.Type_Image)

		if self.useSkin == 672801 then
			UISpriteSetMgr.instance:setFightSkillCardSprite(img, "card_dz3", true)
		end

		for i, starGo in ipairs(item.starList) do
			local transform = starGo.transform

			for index = 0, transform.childCount - 1 do
				local child = transform:GetChild(index)
				local childName = child.name
				local image = child:GetComponent(gohelper.Type_Image)

				if image then
					if childName == "light" then
						UISpriteSetMgr.instance:setFightSkillCardSprite(image, "xx1", true)
					elseif childName == "lightblue" then
						UISpriteSetMgr.instance:setFightSkillCardSprite(image, "xx3", true)
					elseif string.sub(childName, 1, 4) == "dark" then
						UISpriteSetMgr.instance:setFightSkillCardSprite(image, "xx2", true)
					end
				end
			end
		end
	end

	gohelper.setActive(go, false)
	table.insert(self.cardItemList, item)

	return item
end

function FightLorentzCardCopyView:onUpdateParam()
	self:refreshCardItem()
end

function FightLorentzCardCopyView:onOpen()
	self.useSkin = FightCardDataHelper.getCardSkin()

	self:hideViewAndCopyNode()
	self:refreshCardItem()
end

function FightLorentzCardCopyView:hideViewAndCopyNode()
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)

	local viewContainer = ViewMgr.instance:getContainer(ViewName.FightView)
	local viewGo = viewContainer.viewGO
	local btnRoot = gohelper.findChild(viewGo, "root/btns")
	local anchorX, anchorY = recthelper.getAnchor(btnRoot.transform)

	btnRoot = gohelper.clone(btnRoot, self.viewGO)

	recthelper.setAnchor(btnRoot.transform, anchorX, anchorY)

	local goBtn = gohelper.findChild(btnRoot, "cardBox")

	self.goBtnImage = gohelper.findChild(goBtn, "image")
	self.btnAnimator = goBtn:GetComponent(gohelper.Type_Animator)
end

function FightLorentzCardCopyView:getSkillIdAndCount()
	local defaultSkillId = 31390111
	local defaultCount = 3

	if self.viewParam then
		local entityId = self.viewParam.entityId
		local skillId, count = FightHelper.getEntityRecordSkillIdAndCount(entityId)

		skillId = skillId or defaultSkillId
		count = count or defaultCount

		return skillId, count
	end
end

function FightLorentzCardCopyView:refreshCardItem()
	for _, cardItem in ipairs(self.cardItemList) do
		gohelper.setActive(cardItem.go, false)
	end

	local skillId, count = self:getSkillIdAndCount()

	for i = 1, count do
		local cardItem = self.cardItemList[i]

		cardItem = cardItem or self:createCardItem()

		gohelper.setActive(cardItem.go, true)

		local skillCo = skillId and lua_skill.configDict[skillId]

		if skillCo then
			local url = ResUrl.getSkillIcon(skillCo.icon)

			cardItem.simage:LoadImage(url)

			for j = 1, 3 do
				cardItem.imageList[j]:LoadImage(url)
			end

			local curLv = FightConfig.instance:getSkillLv(skillId)

			for j = 1, 3 do
				gohelper.setActive(cardItem.starList[j], j == curLv)
				gohelper.setActive(cardItem.goLvList[j], j == curLv)
			end

			if not FightViewCardItem.attributePrefix[self.useSkin] then
				local pre = "attribute_"
				local tagUrl = ResUrl.getAttributeIcon(pre .. skillCo.showTag)

				cardItem.tag:LoadImage(tagUrl)

				if not FightViewCardItem.cardTagWidth[self.useSkin] then
					local tagWidth = 168

					if not FightViewCardItem.cardTagHeight[self.useSkin] then
						local tagHeight = 56

						recthelper.setSize(cardItem.tagTransform, tagWidth, tagHeight)
					end
				end
			end
		end
	end

	AudioMgr.instance:trigger(350026)
	TaskDispatcher.runDelay(self.playCloseAnim, self, FightLorentzCardCopyView.OpenAnimDuration)
end

function FightLorentzCardCopyView:playCloseAnim()
	for _, cardItem in ipairs(self.cardItemList) do
		if cardItem.go.activeSelf then
			cardItem.animator:Play("close", 0, 0)
		end
	end

	TaskDispatcher.runDelay(self.startFlyItem, self, FightLorentzCardCopyView.CloseAnimDuration)
end

function FightLorentzCardCopyView:startFlyItem()
	gohelper.setActive(self.flyRoot, true)

	if self.goBtnImage then
		local targetScreenPos = recthelper.uiPosToScreenPos(self.goBtnImage.transform)

		for _, cardItem in ipairs(self.cardItemList) do
			if cardItem.go.activeSelf then
				local startScreenPos = recthelper.uiPosToScreenPos(cardItem.rectTr)
				local flyItem = gohelper.cloneInPlace(self.flyItem)
				local flyItemRectTr = flyItem.transform
				local anchor = recthelper.screenPosToAnchorPos(startScreenPos, flyItemRectTr)
				local flyScript = flyItem:GetComponent(typeof(UnityEngine.UI.UIFlying))

				flyScript.startPosition = anchor

				if targetScreenPos then
					flyScript.endPosition = recthelper.screenPosToAnchorPos(targetScreenPos, flyItemRectTr)
				end

				gohelper.setActive(flyItem, true)
			end
		end

		TaskDispatcher.runDelay(self.triggerEvent, self, FightLorentzCardCopyView.FlyItemDuration)
	end
end

function FightLorentzCardCopyView:triggerEvent()
	AudioMgr.instance:trigger(350027)
	self.btnAnimator:Play("add", 0, 0)
	FightController.instance:dispatchEvent(FightEvent.CardBoxPlayAnim, "add")
end

function FightLorentzCardCopyView:onDestroyView()
	if self.cardItemList then
		for _, cardItem in ipairs(self.cardItemList) do
			cardItem.simage:UnLoadImage()

			for j = 1, 3 do
				cardItem.imageList[j]:UnLoadImage()
			end
		end
	end

	TaskDispatcher.cancelTask(self.playCloseAnim, self)
	TaskDispatcher.cancelTask(self.startFlyItem, self)
	TaskDispatcher.cancelTask(self.triggerEvent, self)
end

return FightLorentzCardCopyView
