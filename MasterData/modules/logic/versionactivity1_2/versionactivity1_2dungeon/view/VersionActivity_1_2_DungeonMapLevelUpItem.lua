-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_DungeonMapLevelUpItem.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapLevelUpItem", package.seeall)

local VersionActivity_1_2_DungeonMapLevelUpItem = class("VersionActivity_1_2_DungeonMapLevelUpItem", BaseViewExtended)

function VersionActivity_1_2_DungeonMapLevelUpItem:onInitView()
	self._topRight = gohelper.findChild(self.viewGO, "topRight")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gomaxbg = gohelper.findChild(self.viewGO, "rotate/#go_maxbg")
	self._txtmaxlv = gohelper.findChildText(self.viewGO, "rotate/#go_maxbg/bgimag/#txt_max_lv")
	self._gobg = gohelper.findChild(self.viewGO, "rotate/#go_bg")
	self._gocurrentlv = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_currentlv")
	self._txtlv = gohelper.findChildText(self.viewGO, "rotate/#go_bg/#go_currentlv/#txt_lv")
	self._gonextlv = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_nextlv")
	self._txtnextlv = gohelper.findChildText(self.viewGO, "rotate/#go_bg/#go_nextlv/#txt_next_lv")
	self._goop = gohelper.findChild(self.viewGO, "rotate/#go_op")
	self._simageicon = gohelper.findChildImage(self.viewGO, "rotate/#go_op/cost/iconnode/icon")
	self._txtcost = gohelper.findChildText(self.viewGO, "rotate/#go_op/cost/#txt_cost")
	self._txtdoit = gohelper.findChildText(self.viewGO, "rotate/#go_op/bg/#txt_doit")
	self._btndoit = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op/bg/#btn_doit")
	self._txttitle = gohelper.findChildText(self.viewGO, "rotate/layout/top/title/#txt_title")
	self._upEffect = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_nextlv/vx")
	self._simagebgimag = gohelper.findChildSingleImage(self.viewGO, "rotate/#go_maxbg/bgimag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_DungeonMapLevelUpItem:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndoit:AddClickListener(self._btndoitOnClick, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveUpgradeElementReply, self._onReceiveUpgradeElementReply, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeElementView, self._btncloseOnClick, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, self._btncloseOnClick, self)
end

function VersionActivity_1_2_DungeonMapLevelUpItem:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btndoit:RemoveClickListener()
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_onReceiveUpgradeElementReply(elementId)
	if elementId == self._config.id then
		gohelper.setActive(self._upEffect, false)
		gohelper.setActive(self._upEffect, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
		self:onOpen()
	end
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_btndoitOnClick()
	if #self._costData > 0 then
		local enough = ItemModel.instance:goodsIsEnough(self._costData[1], self._costData[2], self._costData[3])

		if not enough then
			GameFacade.showToast(ToastEnum.Acticity1_2MaterialNotEnough)

			return
		end
	end

	StatController.instance:track(StatEnum.EventName.FacilityMutually, {
		[StatEnum.EventProperties.FacilityName] = self._config.title,
		[StatEnum.EventProperties.AfterLevel] = self._buildingConfig.level + 1,
		[StatEnum.EventProperties.PlotProgress2] = tostring(VersionActivity1_2DungeonController.instance:getNowEpisodeId())
	})
	Activity116Rpc.instance:sendUpgradeElementRequest(self._config.id)
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_btncloseOnClick()
	local animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.DESTROYSELF, self)
end

function VersionActivity_1_2_DungeonMapLevelUpItem:onRefreshViewParam(config)
	self._config = config
end

function VersionActivity_1_2_DungeonMapLevelUpItem:onOpen()
	self._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bg_neirongdi_2"))

	self._elementData = VersionActivity1_2DungeonModel.instance:getElementData(self._config.id)
	self._levelList = {}

	for k, v in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(self._config.id)) do
		table.insert(self._levelList, v)
	end

	table.sort(self._levelList, function(item1, item2)
		return item1.level < item2.level
	end)

	if self._elementData then
		self._curLevel = self._elementData.level or 0
	end

	self._nextLevel = self._curLevel + 1
	self._buildingConfig = self._levelList[self._curLevel + 1]
	self._nextBuildingConfig = self._levelList[self._nextLevel + 1]

	gohelper.setActive(self._gobg, self._nextBuildingConfig)
	gohelper.setActive(self._goop, self._nextBuildingConfig)
	gohelper.setActive(self._gomaxbg, not self._nextBuildingConfig)

	if not self._nextBuildingConfig then
		self:_showMaxLevel()
	else
		self:_showLevelUpDate()
		self:_showCost()
	end

	if self._buildingConfig then
		self._txttitle.text = self._buildingConfig.name or self._nextBuildingConfig.name
	end
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_showCurrency()
	self:com_loadAsset(CurrencyView.prefabPath, self._onCurrencyLoaded)
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_onCurrencyLoaded(loader)
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

function VersionActivity_1_2_DungeonMapLevelUpItem:_showMaxLevel()
	self._txtmaxlv.text = "Lv. " .. self._buildingConfig.level

	self:_showGianText(self._buildingConfig.desc, gohelper.findChild(self.viewGO, "rotate/#go_maxbg/bgimag/content"))
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_showLevelUpDate()
	self._txtlv.text = "Lv. " .. self._curLevel

	self:_showGianText(self._buildingConfig.desc, gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_currentlv/content"))

	self._txtnextlv.text = "Lv. " .. self._nextLevel

	self:_showGianText(self._nextBuildingConfig.desc, gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_nextlv/content"))
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_showGianText(desc, contend)
	local strArr = string.split(desc, "|")

	self:com_createObjList(self._onAttrShow, strArr, contend, gohelper.findChild(contend, "line1"))
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_onAttrShow(obj, data, index)
	local text = gohelper.findChildText(obj, "")

	text.text = data
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_showCost()
	local arr = string.splitToNumber(self._nextBuildingConfig.cost, "#")

	self._costData = arr

	if #arr > 0 then
		local currencyname = CurrencyConfig.instance:getCurrencyCo(arr[2]).icon

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._simageicon, currencyname .. "_1")

		self._txtcost.text = arr[3]
		self._costIconClick = gohelper.getClick(self._simageicon.gameObject)

		self._costIconClick:AddClickListener(self._onBtnCostIcon, self)

		local enough = ItemModel.instance:goodsIsEnough(arr[1], arr[2], arr[3])

		if enough then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#ACCB8A")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#D97373")
		end
	else
		gohelper.setActive(gohelper.findChild(self.viewGO, "rotate/#go_op/cost"))
	end
end

function VersionActivity_1_2_DungeonMapLevelUpItem:_onBtnCostIcon()
	local arr = string.splitToNumber(self._nextBuildingConfig.cost, "#")

	MaterialTipController.instance:showMaterialInfo(arr[1], arr[2])
end

function VersionActivity_1_2_DungeonMapLevelUpItem:onClose()
	if self._costIconClick then
		self._costIconClick:RemoveClickListener()
	end
end

function VersionActivity_1_2_DungeonMapLevelUpItem:onDestroyView()
	self._simagebgimag:UnLoadImage()
end

return VersionActivity_1_2_DungeonMapLevelUpItem
