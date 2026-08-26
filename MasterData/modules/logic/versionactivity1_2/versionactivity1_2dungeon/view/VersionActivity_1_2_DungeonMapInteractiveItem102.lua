-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_DungeonMapInteractiveItem102.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapInteractiveItem102", package.seeall)

local VersionActivity_1_2_DungeonMapInteractiveItem102 = class("VersionActivity_1_2_DungeonMapInteractiveItem102", BaseViewExtended)

function VersionActivity_1_2_DungeonMapInteractiveItem102:onInitView()
	self._topRight = gohelper.findChild(self.viewGO, "topRight")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gopickupbg = gohelper.findChild(self.viewGO, "rotate/#go_pickupbg")
	self._gopickup = gohelper.findChild(self.viewGO, "rotate/#go_pickupbg/#go_pickup")
	self._txttitle = gohelper.findChildText(self.viewGO, "rotate/#go_pickupbg/#go_pickup/#txt_title")
	self._goop = gohelper.findChild(self.viewGO, "rotate/#go_op")
	self._simageicon = gohelper.findChildImage(self.viewGO, "rotate/#go_op/cost/iconnode/icon")
	self._txtcost = gohelper.findChildText(self.viewGO, "rotate/#go_op/cost/#txt_cost")
	self._txtdoit = gohelper.findChildText(self.viewGO, "rotate/#go_op/bg/#txt_doit")
	self._btndoit = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op/bg/#btn_doit")
	self._contenttitle = gohelper.findChild(self.viewGO, "rotate/#go_pickupbg/#go_pickup/contenttitle")
	self._goline = gohelper.findChild(self.viewGO, "rotate/layout/fragment/#go_line")
	self._simagebgimag = gohelper.findChildSingleImage(self.viewGO, "rotate/#go_pickupbg/bgimag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndoit:AddClickListener(self._btndoitOnClick, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeBuildingRepairItem, self._onBtnCloseSelf, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, self._btncloseOnClick, self)
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btndoit:RemoveClickListener()
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:_btndoitOnClick()
	if #self._costData > 0 then
		local enough = ItemModel.instance:goodsIsEnough(self._costData[1], self._costData[2], self._costData[3])

		if not enough then
			GameFacade.showToast(ToastEnum.Acticity1_2MaterialNotEnough)
		end
	end

	StatController.instance:track(StatEnum.EventName.FacilityMutually, {
		[StatEnum.EventProperties.FacilityName] = self._config.title,
		[StatEnum.EventProperties.PlotProgress2] = tostring(VersionActivity1_2DungeonController.instance:getNowEpisodeId())
	})
	DungeonRpc.instance:sendMapElementRequest(self._config.id)
	self:_onBtnCloseSelf()
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:_btncloseOnClick()
	self:_onBtnCloseSelf()
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:_onBtnCloseSelf()
	local animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.DESTROYSELF, self)
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:onRefreshViewParam(config, mapElement)
	self._config = config
	self._mapElement = mapElement
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:onOpen()
	self._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
	gohelper.setActive(self._contenttitle, false)

	for k, v in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(self._config.id)) do
		self._buildingConfig = v
	end

	self._txttitle.text = self._buildingConfig.desc

	self:_showCost()
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:_showCost()
	self._costData = string.splitToNumber(self._buildingConfig.cost, "#")

	if #self._costData > 0 then
		local currencyname = CurrencyConfig.instance:getCurrencyCo(self._costData[2]).icon

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._simageicon, currencyname .. "_1")

		self._txtcost.text = self._costData[3]
		self._costIconClick = gohelper.getClick(self._simageicon.gameObject)

		self._costIconClick:AddClickListener(self._onBtnCostIcon, self)

		local enough = ItemModel.instance:goodsIsEnough(self._costData[1], self._costData[2], self._costData[3])

		if enough then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#ACCB8A")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#D97373")
		end
	else
		gohelper.setActive(gohelper.findChild(self.viewGO, "rotate/#go_op/cost"))
	end
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:_onBtnCostIcon()
	MaterialTipController.instance:showMaterialInfo(self._costData[1], self._costData[2])
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:_showCurrency()
	self:com_loadAsset(CurrencyView.prefabPath, self._onCurrencyLoaded)
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:_onCurrencyLoaded(loader)
	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, self._topRight)
	local currencyType = CurrencyEnum.CurrencyType
	local currencyParam = {
		currencyType.DryForest
	}
	local currencyView = self:openSubView(CurrencyView, obj, nil, currencyParam)

	currencyView.foreShowBtn = true

	currencyView:_hideAddBtn(CurrencyEnum.CurrencyType.DryForest)
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:onClose()
	if self._costIconClick then
		self._costIconClick:RemoveClickListener()
	end
end

function VersionActivity_1_2_DungeonMapInteractiveItem102:onDestroyView()
	self._simagebgimag:UnLoadImage()
end

return VersionActivity_1_2_DungeonMapInteractiveItem102
