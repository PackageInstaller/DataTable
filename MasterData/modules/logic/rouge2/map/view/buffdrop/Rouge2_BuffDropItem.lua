-- chunkname: @modules/logic/rouge2/map/view/buffdrop/Rouge2_BuffDropItem.lua

module("modules.logic.rouge2.map.view.buffdrop.Rouge2_BuffDropItem", package.seeall)

local Rouge2_BuffDropItem = class("Rouge2_BuffDropItem", LuaCompBase)

function Rouge2_BuffDropItem:init(go)
	self.go = go
	self._imageBg = gohelper.findChildImage(self.go, "root/BG")
	self._imageRare = gohelper.findChildImage(self.go, "root/Info/#image_Rare")
	self._imageNameBg = gohelper.findChildImage(self.go, "root/Info/image_namebg")
	self._simageIcon = gohelper.findChildSingleImage(self.go, "root/Info/#image_Icon")
	self._txtName = gohelper.findChildText(self.go, "root/Info/#txt_Name")
	self._goContainer = gohelper.findChild(self.go, "root/#go_Container")
	self._txtDesc = gohelper.findChildText(self.go, "root/#go_Container/#txt_Desc")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "root/#btn_Click", AudioEnum.Rouge2.SelectDropItem)
	self._goSelect = gohelper.findChild(self.go, "root/#go_Select")
	self._btnSelect = gohelper.findChildButtonWithAudio(self.go, "root/#go_Select/#btn_Select", AudioEnum.Rouge2.ConfirmSelectBuff)
	self._animator = SLFramework.AnimatorPlayer.Get(self.go)
	self._goTeamTips = gohelper.findChild(self.go, "root/#go_TeamTips")
	self._goRecommend = gohelper.findChild(self.go, "root/#go_Recommend")

	gohelper.setActive(self._goSelect, false)
	self:initRareEffectTab()

	self._teamTipsParams = {}
	self._teamTipsLoader = Rouge2_TeamRecommendTipsLoader.Load(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.MultiItemSystemTag)
	self._teamTipsLoader2 = Rouge2_TeamRecommendTipsLoader.Load(self._goRecommend, Rouge2_Enum.TeamRecommendTipType.ItemRecommend)
	self._listener = Rouge2_CommonItemDescModeListener.Get(self.go, Rouge2_Enum.ItemDescModeDataKey.BuffDrop)

	self._listener:initCallback(self._refreshItemDesc, self)
end

function Rouge2_BuffDropItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnSelect:AddClickListener(self._btnSelectOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onConfirmSelectDrop, self._onConfirmSelectDrop, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectDropBuffItem, self._onSelectDropBuffItem, self)
end

function Rouge2_BuffDropItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
end

function Rouge2_BuffDropItem:_btnSelectOnClick()
	if not self._isSelect then
		return
	end

	GameUtil.setActiveUIBlock("Rouge2_BuffDropItem", true, false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onConfirmSelectDrop, self._index)
	self.playAnim(self, "light", self._onSelectAnimDone, self)
end

function Rouge2_BuffDropItem:_onSelectAnimDone()
	GameUtil.setActiveUIBlock("Rouge2_BuffDropItem", false, true)
	self:_tryStatDrop()

	self._rpcCallback = Rouge2_Rpc.instance:sendRouge2SelectDropRequest({
		self._index
	}, self._receiveRpcCallback, self)
end

function Rouge2_BuffDropItem:_receiveRpcCallback(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self._rpcCallback = nil

	ViewMgr.instance:closeView(ViewName.Rouge2_BuffDropView)
end

function Rouge2_BuffDropItem:_tryStatDrop()
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		return
	end

	local itemNameList = Rouge2_BackpackHelper.getItemNameList(self._dataType, self._parentView._buffList)

	Rouge2_StatController.instance:statSelectDrop(Rouge2_MapEnum.DropType.Buff, self._buffId, self._buffCo.name, itemNameList)
end

function Rouge2_BuffDropItem:_btnClickOnClick()
	if self._isSelect then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnSelectDropBuffItem, self._index)
end

function Rouge2_BuffDropItem:onUpdateMO(index, viewType, dataType, dataId, parentView)
	self._parentView = parentView
	self._index = index
	self._viewType = viewType
	self._dataType = dataType
	self._dataId = dataId
	self._buffCo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	self._buffId = self._buffCo and self._buffCo.id
	self._teamTipsParams[Rouge2_Enum.TeamRecommendParam.ItemId] = self._buffId

	self._teamTipsLoader:initInfo(nil, self._teamTipsParams)
	self._teamTipsLoader2:initInfo(nil, self._teamTipsParams)
	self:onSelect(false)
	self:refreshUI()
end

function Rouge2_BuffDropItem:refreshUI()
	self:showRareEffect()

	self._txtName.text = self._buffCo and self._buffCo.name

	self._listener:startListen()
	Rouge2_IconHelper.setBuffIcon(self._buffId, self._simageIcon)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageRare)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageBg, Rouge2_Enum.ItemRareIconType.Bg)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageNameBg, Rouge2_Enum.ItemRareIconType.NameBg)
	gohelper.setActive(self._btnClick.gameObject, self._viewType == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._btnSelect.gameObject, self._viewType == Rouge2_MapEnum.ItemDropViewEnum.Select)
	self:playAnim("normal")
end

function Rouge2_BuffDropItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)

	local animName = isSelect and "select" or "normal"

	self:playAnim(animName)
end

function Rouge2_BuffDropItem:_onSelectDropBuffItem(index)
	self:onSelect(index == self._index)
end

function Rouge2_BuffDropItem:_onConfirmSelectDrop(index)
	if self._index == index or self._close then
		return
	end

	self:playAnim("close")
end

function Rouge2_BuffDropItem:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_BuffDropView or self._close then
		return
	end

	self:playAnim("close")
end

function Rouge2_BuffDropItem:playAnim(animName, callback, callbackObj)
	if not self.go.activeInHierarchy then
		return
	end

	self._close = animName == "close"

	self._animator:Play(animName, callback or self._defaultOnPlayAnimDone, callbackObj or self)
end

function Rouge2_BuffDropItem:_defaultOnPlayAnimDone()
	return
end

function Rouge2_BuffDropItem:onDestroy()
	if self._rpcCallback then
		Rouge2_Rpc.instance:removeCallbackById(self._rpcCallback)

		self._rpcCallback = nil
	end

	self._simageIcon:UnLoadImage()
	GameUtil.setActiveUIBlock("Rouge2_BuffDropItem", false, true)
end

function Rouge2_BuffDropItem:initRareEffectTab()
	self._rareEffectTab = self:getUserDataTb_()

	local goParent = gohelper.findChild(self.go, "root/Info/#Rare")
	local tranParent = goParent.transform
	local effectNum = tranParent.childCount

	for i = 1, effectNum do
		local goeffect = tranParent:GetChild(i - 1).gameObject
		local effectName = goeffect.name

		self._rareEffectTab[effectName] = goeffect
	end

	gohelper.setActive(goParent, true)
end

function Rouge2_BuffDropItem:showRareEffect()
	if self._buffCo then
		local rare = self._buffCo.rare
		local rareName = string.format("rare%s", rare)

		for effectName, goRare in pairs(self._rareEffectTab) do
			gohelper.setActive(goRare, effectName == rareName)
		end
	end
end

function Rouge2_BuffDropItem:_refreshItemDesc(descMode)
	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._dataId, self._txtDesc, descMode)
end

return Rouge2_BuffDropItem
