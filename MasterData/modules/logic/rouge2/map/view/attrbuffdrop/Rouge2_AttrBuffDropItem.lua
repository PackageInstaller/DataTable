-- chunkname: @modules/logic/rouge2/map/view/attrbuffdrop/Rouge2_AttrBuffDropItem.lua

module("modules.logic.rouge2.map.view.attrbuffdrop.Rouge2_AttrBuffDropItem", package.seeall)

local Rouge2_AttrBuffDropItem = class("Rouge2_AttrBuffDropItem", LuaCompBase)

Rouge2_AttrBuffDropItem.Rare2DescColor = {
	"#B5B3B1",
	"#E5C59B",
	"#FCFBF6"
}
Rouge2_AttrBuffDropItem.bracketColor = "#6088FF"
Rouge2_AttrBuffDropItem.percentColor = "#CE6A51"

function Rouge2_AttrBuffDropItem:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "root")
	self._simageBg = gohelper.findChildSingleImage(self.go, "root/BG_dissolve")
	self._simageBg2 = gohelper.findChildSingleImage(self.go, "root/image_BG")
	self._imageRareIcon = gohelper.findChildImage(self.go, "root/#image_RareIcon")
	self._imageRareIcon2 = gohelper.findChildImage(self.go, "root/#image_rare")
	self._simageIcon = gohelper.findChildSingleImage(self.go, "root/#simage_Icon")
	self._txtName = gohelper.findChildText(self.go, "root/#txt_Name")
	self._scrollOverview = gohelper.findChild(self.go, "root/#scroll_overview"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._goContent = gohelper.findChild(self.go, "root/#scroll_overview/Viewport/Content")
	self._txtDesc = gohelper.findChildText(self.go, "root/#scroll_overview/Viewport/Content/#txt_desc")
	self._btnClick = gohelper.getClickWithAudio(self.go, AudioEnum.Rouge2.ClickAttrBuffItem)
	self._btnClick2 = gohelper.findChildClickWithAudio(self.go, "root/#scroll_overview/Viewport", AudioEnum.Rouge2.ClickAttrBuffItem)
	self._goSelect = gohelper.findChild(self.go, "root/#go_Select")
	self._btnSelect = gohelper.findChildButtonWithAudio(self.go, "root/#go_Select/#btn_Select", AudioEnum.Rouge2.ChooseAttrBuffItem)
	self._goTips = gohelper.findChild(self.go, "root/#go_Tips")
	self._txtTips = gohelper.findChildText(self.go, "root/#go_Tips/#txt_Tips")
	self._btnTips = gohelper.findChildButtonWithAudio(self.go, "root/#go_Tips/#txt_Tips/#btn_Tips", AudioEnum.Rouge2.OpenAttrBuffTips)
	self._goEmptyTips = gohelper.findChild(self.go, "root/#go_EmptyTips")
	self._txtEmptyTips = gohelper.findChildText(self.go, "root/#go_EmptyTips/#txt_EmptyTips")
	self._goRecommend = gohelper.findChild(self.go, "root/#go_Recommend")
	self._animator = SLFramework.AnimatorPlayer.Get(self._goRoot)

	gohelper.setActive(self._goSelect, false)
	self:initRareEffectTab()

	self._listener = Rouge2_CommonItemDescModeListener.Get(self.go, Rouge2_Enum.ItemDescModeDataKey.AttrBuffDrop)

	self._listener:initCallback(self._refreshItemDesc, self)

	self._teamTipsParam = {}
	self._teamTipsLoader = Rouge2_TeamRecommendTipsLoader.Load(self._goRecommend, Rouge2_Enum.TeamRecommendTipType.AttrBuffDrop)
end

function Rouge2_AttrBuffDropItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnClick2:AddClickListener(self._btnClickOnClick, self)
	self._btnSelect:AddClickListener(self._btnSelectOnClick, self)
	self._btnTips:AddClickListener(self._btnTipsOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onConfirmSelectDrop, self._onConfirmSelectDrop, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectDropBuffItem, self._onSelectDropBuffItem, self)
end

function Rouge2_AttrBuffDropItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnClick2:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnTips:RemoveClickListener()
end

function Rouge2_AttrBuffDropItem:_btnSelectOnClick()
	if not self._isSelect then
		return
	end

	GameUtil.setActiveUIBlock("Rouge2_AttrBuffDropItem", true, false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onConfirmSelectDrop, self._index)
	self.playAnim(self, "light", self._onSelectAnimDone, self)
end

function Rouge2_AttrBuffDropItem:_onSelectAnimDone()
	GameUtil.setActiveUIBlock("Rouge2_AttrBuffDropItem", false, true)
	self:_tryStatDrop()

	self._rpcCallback = Rouge2_Rpc.instance:sendRouge2SelectDropRequest({
		self._index
	}, self._receiveRpcCallback, self)
end

function Rouge2_AttrBuffDropItem:_receiveRpcCallback(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self._rpcCallback = nil

	ViewMgr.instance:closeView(ViewName.Rouge2_AttrBuffDropView)
end

function Rouge2_AttrBuffDropItem:_tryStatDrop()
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		return
	end

	local itemNameList = Rouge2_BackpackHelper.getItemNameList(self._dataType, self._parentView._itemList)

	Rouge2_StatController.instance:statSelectDrop(Rouge2_MapEnum.DropType.AttrBuff, self._buffId, self._buffCo.name, itemNameList)
end

function Rouge2_AttrBuffDropItem:_btnClickOnClick()
	if self._isSelect or self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnSelectDropBuffItem, self._index)
end

function Rouge2_AttrBuffDropItem:_btnTipsOnClick()
	ViewMgr.instance:openView(ViewName.Rouge2_HeroGroupEditView, {
		attrBuffId = self._buffId
	})
end

function Rouge2_AttrBuffDropItem:setParentScroll(goParentScroll)
	self._scrollOverview.parentGameObject = goParentScroll
end

function Rouge2_AttrBuffDropItem:onUpdateMO(index, viewType, dataType, dataId, parentView)
	self._parentView = parentView
	self._index = index
	self._viewType = viewType
	self._dataType = dataType
	self._dataId = dataId
	self._buffCo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	self._buffId = self._buffCo and self._buffCo.id
	self._attrId = self._buffCo and self._buffCo.attributeTag

	self:onSelect(false)
	self:refreshUI()
end

function Rouge2_AttrBuffDropItem:refreshUI()
	self:showRareEffect()

	self._txtName.text = self._buffCo and self._buffCo.name

	self._listener:startListen()

	self._teamTipsParam[Rouge2_Enum.TeamRecommendParam.ItemId] = self._buffId

	self._teamTipsLoader:initInfo(nil, self._teamTipsParam)
	Rouge2_IconHelper.setAttrBuffRareIcon(self._buffId, self._simageBg, Rouge2_Enum.ItemRareIconType.Bg)
	Rouge2_IconHelper.setAttrBuffRareIcon(self._buffId, self._simageBg2, Rouge2_Enum.ItemRareIconType.Bg)
	Rouge2_IconHelper.setAttrBuffRareIcon(self._buffId, self._imageRareIcon2, Rouge2_Enum.ItemRareIconType.Default)
	Rouge2_IconHelper.setItemIconAndRare(self._buffId, self._simageIcon, self._imageRareIcon, Rouge2_Enum.ItemRareIconType.TagBg)
	self:refreshTips()
	self:refreshDescColor()
	self:playAnim("normal")
end

function Rouge2_AttrBuffDropItem:refreshDescColor()
	if self._buffCo then
		local rare = self._buffCo.rare
		local color = rare and Rouge2_AttrBuffDropItem.Rare2DescColor[rare]

		if not color then
			color = "#FFFFFF"

			logError("肉鸽属性谐波文本缺少颜色配置 buffId = %s, rare = %s", self._buffId, rare)
		end

		SLFramework.UGUI.GuiHelper.SetColor(self._txtDesc, color)
	end
end

function Rouge2_AttrBuffDropItem:refreshTips()
	if self._buffCo then
		local battleTag = self._buffCo.battleTag
		local hasBattleTag = not string.nilorempty(battleTag)
		local hasRecommendHero = Rouge2_SystemController.instance:hasAnyRecommendHero(battleTag)

		gohelper.setActive(self._goTips, hasBattleTag and hasRecommendHero)
		gohelper.setActive(self._goEmptyTips, hasBattleTag and not hasRecommendHero)

		if not hasBattleTag then
			return
		end

		local battleTagCo = HeroConfig.instance:getBattleTagConfigCO(battleTag)

		if battleTagCo then
			if not battleTagCo.tagName then
				local tagName = ""

				self._txtTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_attrbuffdropview_tips"), tagName)
				self._txtEmptyTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_attrbuffdropview_nonehero"), tagName)
			end
		end
	end
end

function Rouge2_AttrBuffDropItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)

	local animName = isSelect and "select" or "normal"

	self:playAnim(animName)
end

function Rouge2_AttrBuffDropItem:_onSelectDropBuffItem(index)
	self:onSelect(index == self._index)
end

function Rouge2_AttrBuffDropItem:_onConfirmSelectDrop(index)
	if self._index == index or self._close then
		return
	end

	self:playAnim("close")
end

function Rouge2_AttrBuffDropItem:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_AttrBuffDropView or self._close then
		return
	end

	self:playAnim("close")
end

function Rouge2_AttrBuffDropItem:playAnim(animName, callback, callbackObj)
	if not self.go.activeInHierarchy then
		return
	end

	self._close = animName == "close"

	self._animator:Play(animName, callback or self._defaultOnPlayAnimDone, callbackObj or self)
end

function Rouge2_AttrBuffDropItem:_defaultOnPlayAnimDone()
	return
end

function Rouge2_AttrBuffDropItem:onDestroy()
	if self._rpcCallback then
		Rouge2_Rpc.instance:removeCallbackById(self._rpcCallback)

		self._rpcCallback = nil
	end

	self._simageIcon:UnLoadImage()
	GameUtil.setActiveUIBlock("Rouge2_AttrBuffDropItem", false, true)
end

function Rouge2_AttrBuffDropItem:initRareEffectTab()
	self._rareEffectTab = self:getUserDataTb_()

	local goParent = gohelper.findChild(self.go, "root/#Rare")
	local tranParent = goParent.transform
	local effectNum = tranParent.childCount

	for i = 1, effectNum do
		local goeffect = tranParent:GetChild(i - 1).gameObject
		local effectName = goeffect.name

		self._rareEffectTab[effectName] = goeffect
	end

	gohelper.setActive(goParent, true)
end

function Rouge2_AttrBuffDropItem:showRareEffect()
	if self._buffCo then
		local rare = self._buffCo.rare
		local rareName = string.format("rare%s", rare)

		for effectName, goRare in pairs(self._rareEffectTab) do
			gohelper.setActive(goRare, effectName == rareName)
		end
	end
end

function Rouge2_AttrBuffDropItem:_refreshItemDesc(descMode)
	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._dataId, self._txtDesc, descMode, nil, Rouge2_AttrBuffDropItem.percentColor, Rouge2_AttrBuffDropItem.bracketColor)
	self:refreshDescColor()
end

return Rouge2_AttrBuffDropItem
