-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191BuffTipView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191BuffTipView", package.seeall)

local Act191BuffTipView = class("Act191BuffTipView", BaseView)

function Act191BuffTipView:onInitView()
	self.goclose = gohelper.findChild(self.viewGO, "#go_close")
	self.goscrolltip = gohelper.findChild(self.viewGO, "#scroll_tip")
	self.gocontent = gohelper.findChild(self.viewGO, "#scroll_tip/Viewport/Content")
	self.gotipitem = gohelper.findChild(self.viewGO, "#scroll_tip/Viewport/Content/#go_tipitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191BuffTipView:_editableInitView()
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

function Act191BuffTipView:initViewParam()
	self.effectId = self.viewParam.effectId
	self.scrollAnchorPos = self.viewParam.scrollAnchorPos
	self.pivot = self.viewParam.pivot
	self.clickPosition = self.viewParam.clickPosition
	self.setScrollPosCallback = self.viewParam.setScrollPosCallback
	self.setScrollPosCallbackObj = self.viewParam.setScrollPosCallbackObj
end

function Act191BuffTipView:onOpen()
	self:initViewParam()
	self:setScrollPos()
	self:calculateMaxHeight()
	self:addBuffTip(self.effectId)
end

function Act191BuffTipView:setScrollPos()
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

function Act191BuffTipView:calculateMaxHeight()
	local viewHeight = recthelper.getHeight(self.rectTrViewGo)
	local anchorY = recthelper.getAnchorY(self.rectTrScrollTip)

	self.maxHeight = viewHeight / 2 + anchorY - CommonBuffTipEnum.BottomMargin
end

function Act191BuffTipView:addBuffTip(effName)
	if self.addEffectIdDict[effName] then
		return
	end

	local effectCo = Activity191Config.instance:getEffDescCfgByName(effName)

	if not effectCo then
		return
	end

	self.addEffectIdDict[effName] = true

	local tipItem = self:getTipItem()

	table.insert(self.effectTipItemList, tipItem)
	gohelper.setActive(tipItem.go, true)
	gohelper.setAsLastSibling(tipItem.go)

	tipItem.txtName.text = SkillHelper.removeRichTag(effName)
	tipItem.txtDesc.text = Activity191Helper.buildDesc(effectCo.desc, Activity191Enum.HyperLinkPattern.SkillDesc)

	self:refreshScrollHeight()
end

function Act191BuffTipView:refreshScrollHeight()
	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)

	local height = recthelper.getHeight(self.rectTrContent)

	height = math.min(self.maxHeight, height)

	recthelper.setHeight(self.rectTrScrollTip, height)

	self.scrollTip.verticalNormalizedPosition = 0
end

function Act191BuffTipView:getTipItem()
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

function Act191BuffTipView:onClickHyperLinkText(effectName, clickPosition)
	self:addBuffTip(effectName)
end

function Act191BuffTipView:recycleTipItem(tipItem)
	gohelper.setActive(tipItem.go, false)
	table.insert(self.effectTipItemPool, tipItem)
end

function Act191BuffTipView:recycleAllTipItem()
	for _, tipItem in ipairs(self.effectTipItemList) do
		gohelper.setActive(tipItem.go, false)
		table.insert(self.effectTipItemPool, tipItem)
	end

	tabletool.clear(self.effectTipItemList)
end

function Act191BuffTipView:onClose()
	tabletool.clear(self.addEffectIdDict)
	self:recycleAllTipItem()
end

function Act191BuffTipView:onDestroyView()
	self.closeClick:RemoveClickListener()

	self.closeClick = nil
end

return Act191BuffTipView
