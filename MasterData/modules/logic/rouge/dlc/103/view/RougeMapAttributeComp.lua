-- chunkname: @modules/logic/rouge/dlc/103/view/RougeMapAttributeComp.lua

module("modules.logic.rouge.dlc.103.view.RougeMapAttributeComp", package.seeall)

local RougeMapAttributeComp = class("RougeMapAttributeComp", BaseViewExtended)

function RougeMapAttributeComp:definePrefabUrl()
	self:setPrefabUrl("ui/viewres/rouge/dlc/103/rougedistortruleitem.prefab")
end

function RougeMapAttributeComp:onInitView()
	self._btndistortrule = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_distortrule")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._scrolloverview = gohelper.findChildScrollRect(self.viewGO, "#go_tips/#scroll_overview")
	self._txttitle1 = gohelper.findChildText(self.viewGO, "#go_tips/#scroll_overview/Viewport/Content/txt_title1")
	self._txtdec1 = gohelper.findChildText(self.viewGO, "#go_tips/#scroll_overview/Viewport/Content/#txt_dec1")
	self._txttitle2 = gohelper.findChildText(self.viewGO, "#go_tips/#scroll_overview/Viewport/Content/txt_title2")
	self._txtdec2 = gohelper.findChildText(self.viewGO, "#go_tips/#scroll_overview/Viewport/Content/#txt_dec2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tips/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapAttributeComp:addEvents()
	self._btndistortrule:AddClickListener(self._btndistortruleOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RougeMapAttributeComp:removeEvents()
	self._btndistortrule:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RougeMapAttributeComp:_btndistortruleOnClick()
	self._tipAnimatorPlayer:Play("open", function()
		return
	end, self)
	self:setTipVisible(true)
end

function RougeMapAttributeComp:_btncloseOnClick()
	self._tipAnimatorPlayer:Play("close", self.closeTips, self)
end

function RougeMapAttributeComp:_editableInitView()
	self._monsterRuleItemTab = self:getUserDataTb_()

	gohelper.setActive(self._txtdec2.gameObject, false)

	self._tipAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gotips)
	self._canvasgroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)
	self._scrollViewTran = self._scrolloverview.transform
	self._scrollWidth = recthelper.getWidth(self._scrollViewTran)
	self._scrollScreenPos = recthelper.uiPosToScreenPos(self._scrollViewTran)
	self._effectTipViewPosX = recthelper.screenPosToAnchorPos2(self._scrollScreenPos, self.PARENT_VIEW.viewGO.transform) + self._scrollWidth

	SkillHelper.addHyperLinkClick(self._txtdec1, self.clcikHyperLink, self)
	gohelper.fitScreenOffset(self._scrollViewTran)
	self:initInfo()
	self:setTipVisible(false)
	self:checkAndSetIconVisible()
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
end

function RougeMapAttributeComp:_onUpdateMapInfo()
	self:initInfo()
	self:checkAndSetIconVisible()
end

function RougeMapAttributeComp:initInfo()
	self._monsterRuleIds = RougeMapModel.instance:getChoiceCollection()

	if self._monsterRuleIds then
		self._monsterRuleNum = #self._monsterRuleIds or 0
	end

	local isNormalLayer = RougeMapModel.instance:isNormalLayer()

	if isNormalLayer then
		local layerId = RougeMapModel.instance:getLayerId()
		local layerChoiceInfo = RougeMapModel.instance:getLayerChoiceInfo(layerId)

		self._ruleCo = layerChoiceInfo and layerChoiceInfo:getMapRuleCo()
	else
		self._ruleCo = nil
	end
end

function RougeMapAttributeComp:checkAndSetIconVisible()
	if self._monsterRuleNum then
		local isVisible = self._monsterRuleNum > 0

		isVisible = isVisible or self._ruleCo ~= nil

		self:setIconVisible(isVisible)
	end
end

function RougeMapAttributeComp:setIconVisible(isVisible)
	self._canvasgroup.alpha = isVisible and 1 or 0
	self._canvasgroup.interactable = isVisible
	self._canvasgroup.blocksRaycasts = isVisible
end

function RougeMapAttributeComp:setTipVisible(isVisible)
	gohelper.setActive(self._gotips, isVisible)

	if not isVisible then
		return
	end

	self:refreshMapRule()
	self:refreshMonsterRules()
end

function RougeMapAttributeComp:closeTips()
	self:setTipVisible(false)
end

function RougeMapAttributeComp:refreshMapRule()
	gohelper.setActive(self._txttitle1, false)
	gohelper.setActive(self._txtdec1, false)

	if not self._ruleCo then
		return
	end

	if self._ruleCo then
		if not self._ruleCo.desc then
			local ruleDesc = ""

			gohelper.setActive(self._txttitle1, true)
			gohelper.setActive(self._txtdec1, true)

			self._txtdec1.text = SkillHelper.buildDesc(ruleDesc)
		end
	end
end

function RougeMapAttributeComp:clcikHyperLink(effectId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(effectId, function(_, rectTrViewGo, rectTrScrollTip)
		local isRight = GameUtil.checkClickPositionInRight(clickPosition)

		if isRight then
			rectTrScrollTip.pivot = CommonBuffTipEnum.Pivot.Right or CommonBuffTipEnum.Pivot.Left
		end

		local _, anchorPosY = recthelper.screenPosToAnchorPos2(clickPosition, rectTrViewGo)

		recthelper.setAnchor(rectTrScrollTip, self._effectTipViewPosX, anchorPosY + CommonBuffTipEnum.DefaultInterval)
	end)
end

function RougeMapAttributeComp:refreshMonsterRules()
	local useMap = {}

	for index, ruleId in ipairs(self._monsterRuleIds or {}) do
		local monsterRuleItem = self:_getOrCreateMonsterRuleItem(index)
		local monsterRuleCo = RougeDLCConfig103.instance:getMonsterRuleConfig(ruleId)
		local monsterRuleDesc = monsterRuleCo and monsterRuleCo.desc

		monsterRuleItem.txtdec.text = SkillHelper.buildDesc(monsterRuleDesc)

		gohelper.setActive(monsterRuleItem.viewGO, true)

		useMap[monsterRuleItem] = true
	end

	for _, monsterRuleItem in pairs(self._monsterRuleItemTab) do
		if not useMap[monsterRuleItem] then
			gohelper.setActive(monsterRuleItem.viewGO, false)
		end
	end

	gohelper.setActive(self._txttitle2.gameObject, self._monsterRuleNum > 0)
end

function RougeMapAttributeComp:_getOrCreateMonsterRuleItem(index)
	local monsterRuleItem = self._monsterRuleItemTab[index]

	if not monsterRuleItem then
		monsterRuleItem = self:getUserDataTb_()
		monsterRuleItem.viewGO = gohelper.cloneInPlace(self._txtdec2.gameObject, "debuff_" .. index)
		monsterRuleItem.txtdec = gohelper.onceAddComponent(monsterRuleItem.viewGO, gohelper.Type_TextMesh)

		SkillHelper.addHyperLinkClick(monsterRuleItem.txtdec, self.clcikHyperLink, self)

		self._monsterRuleItemTab[index] = monsterRuleItem
	end

	return monsterRuleItem
end

function RougeMapAttributeComp:onDestroy()
	return
end

return RougeMapAttributeComp
