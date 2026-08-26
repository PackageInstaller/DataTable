-- chunkname: @modules/logic/commonbufftip/CommonBuffTipView.lua

module("modules.logic.commonbufftip.CommonBuffTipView", package.seeall)

local CommonBuffTipView = class("CommonBuffTipView", BaseView)

function CommonBuffTipView:onInitView()
	self.goclose = gohelper.findChild(self.viewGO, "#go_close")
	self.goscrolltip = gohelper.findChild(self.viewGO, "#scroll_tip")
	self.gocontent = gohelper.findChild(self.viewGO, "#scroll_tip/Viewport/Content")
	self.gotipitem = gohelper.findChild(self.viewGO, "#scroll_tip/Viewport/Content/#go_tipitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonBuffTipView:addEvents()
	return
end

function CommonBuffTipView:removeEvents()
	return
end

function CommonBuffTipView:_editableInitView()
	self.effectTipItemList = {}
	self.effectTipItemPool = {}
	self.addEffectIdDict = {}
	self.rectTrScrollTip = self.goscrolltip:GetComponent(gohelper.Type_RectTransform)
	self.rectTrViewGo = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.rectTrContent = self.gocontent:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(self.gotipitem, false)

	self.closeClick = gohelper.getClickWithDefaultAudio(self.goclose)

	self.closeClick:AddClickListener(self.closeThis, self)

	self.scrollTip = SLFramework.UGUI.ScrollRectWrap.Get(self.goscrolltip)
end

function CommonBuffTipView:setIsShowUI(flag)
	if not flag then
		self:closeThis()
	end
end

function CommonBuffTipView:initViewParam()
	self.effectId = self.viewParam.effectId
	self.scrollAnchorPos = self.viewParam.scrollAnchorPos
	self.pivot = self.viewParam.pivot
	self.clickPosition = self.viewParam.clickPosition
	self.defaultVNP = self.viewParam.defaultVNP or 0
	self.setScrollPosCallback = self.viewParam.setScrollPosCallback
	self.setScrollPosCallbackObj = self.viewParam.setScrollPosCallbackObj
end

function CommonBuffTipView:onOpen()
	self:initViewParam()
	self:setScrollPos()
	self:calculateMaxHeight()
	self:addBuffTip(self.effectId)

	self.scrollTip.verticalNormalizedPosition = self.defaultVNP

	self.addEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self.setIsShowUI, self)
end

function CommonBuffTipView:setScrollPos()
	if self.setScrollPosCallback then
		self.setScrollPosCallback(self.setScrollPosCallbackObj, self.rectTrViewGo, self.rectTrScrollTip)

		return
	end

	if self.scrollAnchorPos then
		self.rectTrScrollTip.pivot = self.pivot

		recthelper.setAnchor(self.rectTrScrollTip, self.scrollAnchorPos.x, self.scrollAnchorPos.y)

		return
	end

	local isRight = GameUtil.checkClickPositionInRight(self.clickPosition)

	if isRight then
		self.rectTrScrollTip.pivot = CommonBuffTipEnum.Pivot.Right or CommonBuffTipEnum.Pivot.Left
	end

	local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(self.clickPosition, self.rectTrViewGo)

	anchorPosX = isRight and anchorPosX - CommonBuffTipEnum.DefaultInterval or anchorPosX + CommonBuffTipEnum.DefaultInterval

	recthelper.setAnchor(self.rectTrScrollTip, anchorPosX, anchorPosY + CommonBuffTipEnum.DefaultInterval)
end

function CommonBuffTipView:calculateMaxHeight()
	local viewHeight = recthelper.getHeight(self.rectTrViewGo)
	local anchorY = recthelper.getAnchorY(self.rectTrScrollTip)

	self.maxHeight = viewHeight / 2 + anchorY - CommonBuffTipEnum.BottomMargin
end

function CommonBuffTipView:addBuffTip(effId)
	local effectId = tonumber(effId)

	if self.addEffectIdDict[effectId] then
		return
	end

	local effectCo = lua_skill_eff_desc.configDict[effectId]

	if not effectCo then
		logError("not found skill_eff_desc , id : " .. tostring(effId))

		return
	end

	self.addEffectIdDict[effectId] = true

	local tipItem = self:getTipItem()

	table.insert(self.effectTipItemList, tipItem)
	gohelper.setActive(tipItem.go, true)
	gohelper.setAsLastSibling(tipItem.go)

	local effectName = effectCo.name

	tipItem.txtName.text = SkillHelper.removeRichTag(effectName)
	tipItem.txtDesc.text = SkillHelper.getSkillDesc(self.viewParam.monsterName, effectCo)

	local tagName = CommonBuffTipController.instance:getBuffTagName(effectName)
	local hadTag = not string.nilorempty(tagName)

	gohelper.setActive(tipItem.goTag, hadTag)

	if hadTag then
		tipItem.txtTag.text = tagName
	end

	self:refreshScrollHeight()
end

function CommonBuffTipView:refreshScrollHeight()
	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)

	local height = recthelper.getHeight(self.rectTrContent)

	height = math.min(self.maxHeight, height)

	recthelper.setHeight(self.rectTrScrollTip, height)

	self.scrollTip.verticalNormalizedPosition = 0
end

function CommonBuffTipView:getTipItem()
	if #self.effectTipItemPool > 0 then
		return table.remove(self.effectTipItemPool)
	end

	local tipItem = self:getUserDataTb_()

	tipItem.go = gohelper.cloneInPlace(self.gotipitem)
	tipItem.txtName = gohelper.findChildText(tipItem.go, "title/txt_name")
	tipItem.txtDesc = gohelper.findChildText(tipItem.go, "txt_desc")
	tipItem.goTag = gohelper.findChild(tipItem.go, "title/txt_name/go_tag")
	tipItem.txtTag = gohelper.findChildText(tipItem.go, "title/txt_name/go_tag/bg/txt_tagname")

	SkillHelper.addHyperLinkClick(tipItem.txtDesc, self.onClickHyperLinkText, self)

	return tipItem
end

function CommonBuffTipView:onClickHyperLinkText(effectId, clickPosition)
	self:addBuffTip(effectId)
end

function CommonBuffTipView:recycleTipItem(tipItem)
	gohelper.setActive(tipItem.go, false)
	table.insert(self.effectTipItemPool, tipItem)
end

function CommonBuffTipView:recycleAllTipItem()
	for _, tipItem in ipairs(self.effectTipItemList) do
		gohelper.setActive(tipItem.go, false)
		table.insert(self.effectTipItemPool, tipItem)
	end

	tabletool.clear(self.effectTipItemList)
end

function CommonBuffTipView:onClose()
	tabletool.clear(self.addEffectIdDict)
	self:recycleAllTipItem()
	self.removeEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self.setIsShowUI, self)
end

function CommonBuffTipView:onDestroyView()
	self.closeClick:RemoveClickListener()

	self.closeClick = nil
end

return CommonBuffTipView
