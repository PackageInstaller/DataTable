-- chunkname: @modules/logic/tips/view/RoomManufactureMaterialTipView.lua

module("modules.logic.tips.view.RoomManufactureMaterialTipView", package.seeall)

local RoomManufactureMaterialTipView = class("RoomManufactureMaterialTipView", BaseView)

function RoomManufactureMaterialTipView:onInitView()
	local guideGMNode = GMController.instance:getGMNode("materialtipview", self.viewGO)

	if guideGMNode then
		self._gogm = gohelper.findChild(guideGMNode, "#go_gm")
		self._txtmattip = gohelper.findChildText(guideGMNode, "#go_gm/bg/#txt_mattip")
		self._btnone = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_one")
		self._btnten = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_ten")
		self._btnhundred = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_hundred")
		self._btnthousand = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_thousand")
		self._btntenthousand = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_tenthousand")
		self._btntenmillion = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_tenmillion")
		self._btninput = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_input")
	end

	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._imagequality = gohelper.findChildImage(self.viewGO, "iconbg/#image_quality")
	self._simagepropicon = gohelper.findChildSingleImage(self.viewGO, "iconbg/#simage_propicon")
	self._gohadnumber = gohelper.findChild(self.viewGO, "iconbg/#go_hadnumber")
	self._txthadnumber = gohelper.findChildText(self.viewGO, "iconbg/#go_hadnumber/#txt_hadnumber")
	self._txtpropname = gohelper.findChildText(self.viewGO, "#txt_propname")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._jumpItemParent = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content/jumpItemLayout")
	self._gojumpItem = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content/jumpItemLayout/#go_jumpItem")
	self._txtdec1 = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#txt_dec1")
	self._txtdec2 = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#txt_dec2")
	self._gosource = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content/#go_source")
	self._txtsource = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#go_source/#txt_source")
	self._txtWrongTip = gohelper.findChildText(self.viewGO, "#txt_wrongJump")
	self._btnWrongJump = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#txt_wrongJump/#btn_wrongJump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureMaterialTipView:addEvents()
	if self._gogm then
		self._btnone:AddClickListener(self._btnGMClick, self, 1)
		self._btnten:AddClickListener(self._btnGMClick, self, 10)
		self._btnhundred:AddClickListener(self._btnGMClick, self, 100)
		self._btnthousand:AddClickListener(self._btnGMClick, self, 1000)
		self._btntenthousand:AddClickListener(self._btnGMClick, self, 10000)
		self._btntenmillion:AddClickListener(self._btnGMClick, self, 10000000)
		self._btninput:AddClickListener(self._btninputOnClick, self)
	end

	self._btnWrongJump:AddClickListener(self._btnwrongjumpOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChange, self)
end

function RoomManufactureMaterialTipView:removeEvents()
	if self._gogm then
		self._btnone:RemoveClickListener()
		self._btnten:RemoveClickListener()
		self._btnhundred:RemoveClickListener()
		self._btnthousand:RemoveClickListener()
		self._btntenthousand:RemoveClickListener()
		self._btntenmillion:RemoveClickListener()
		self._btninput:RemoveClickListener()
	end

	self._btnWrongJump:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChange, self)
end

function RoomManufactureMaterialTipView:_btnGMClick(num)
	self:sendGMRequest(num)
end

function RoomManufactureMaterialTipView:_btninputOnClick()
	local inputMo = CommonInputMO.New()

	inputMo.title = "请输入增加道具数量！"
	inputMo.defaultInput = "Enter Item Num"

	function inputMo.sureCallback(inputStr)
		GameFacade.closeInputBox()

		local inputNum = tonumber(inputStr)

		if inputNum and inputNum > 0 then
			self:sendGMRequest(inputNum)
		end
	end

	GameFacade.openInputBox(inputMo)
end

function RoomManufactureMaterialTipView:sendGMRequest(val)
	GameFacade.showToast(ToastEnum.GMTool5, self.viewParam.id)

	if self.viewParam.type == MaterialEnum.MaterialType.Item and self.viewParam.id == 510001 then
		GMRpc.instance:sendGMRequest(string.format("add heroStoryTicket %d", val))
	else
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", self.viewParam.type, self.viewParam.id, val))
	end
end

function RoomManufactureMaterialTipView:_btnwrongjumpOnClick()
	if not self.isWrong then
		return
	end

	if self.wrongBuildingUid then
		ManufactureController.instance:jumpToManufactureBuildingLevelUpView(self.wrongBuildingUid)
	else
		ManufactureController.instance:jump2PlaceManufactureBuildingView()
	end
end

function RoomManufactureMaterialTipView:_btncloseOnClick()
	self:closeThis()
end

function RoomManufactureMaterialTipView:_onItemChange()
	self:refreshItemQuantity()
end

function RoomManufactureMaterialTipView:jumpBtnOnClick(index)
	local jumpItem = self.jumpItemList[index]

	if not jumpItem then
		return
	end

	if jumpItem.cantJumpTips then
		GameFacade.showToastWithTableParam(jumpItem.cantJumpTips, jumpItem.cantJumpParam)

		return
	end

	if not self.canJump then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
		NavigateButtonsView.homeClick()

		return
	end

	JumpController.instance:dispatchEvent(JumpEvent.JumpBtnClick, jumpItem.jumpId)
	GameFacade.jump(jumpItem.jumpId, self._onJumpFinish, self, self.viewParam.recordFarmItem)
end

function RoomManufactureMaterialTipView:_onJumpFinish()
	self:closeThis()
end

function RoomManufactureMaterialTipView:_editableInitView()
	if self._gogm then
		gohelper.setActive(self._gogm, GMController.instance:isOpenGM())
	end

	self._txtsource.text = luaLang("materialview_source")
	self.jumpItemList = {}
end

function RoomManufactureMaterialTipView:onUpdateParam()
	self.type = nil
	self.id = nil

	if self.viewParam then
		self.type = self.viewParam.type
		self.id = self.viewParam.id
		self.canJump = self.viewParam.canJump
	end

	self:setItem()
	self:setJumpItems()

	self._scrolldesc.verticalNormalizedPosition = 1
end

function RoomManufactureMaterialTipView:onOpen()
	self:onUpdateParam()
end

function RoomManufactureMaterialTipView:setItem()
	self.config, self.icon = ItemModel.instance:getItemConfigAndIcon(self.type, self.id)
	self._txtpropname.text = self.config.name
	self._txtdec1.text = self.config.useDesc
	self._txtdec2.text = self.config.desc

	self._simagepropicon:LoadImage(self.icon)

	local rare = self.config.rare

	UISpriteSetMgr.instance:setCritterSprite(self._imagequality, "critter_manufacture_itemquality" .. rare)

	if self._txtmattip then
		self._txtmattip.text = tostring(self.type) .. "#" .. tostring(self.id)
	end

	self:refreshItemQuantity()
	self:checkWrong()
end

function RoomManufactureMaterialTipView:checkWrong()
	self.isWrong = false
	self.wrongBuildingUid = nil

	local manufactureItemIdList = ManufactureConfig.instance:getManufactureItemListByItemId(self.id)
	local manufactureItemId = manufactureItemIdList[1]

	if manufactureItemId then
		local hasBuilding = ManufactureController.instance:checkPlaceProduceBuilding(manufactureItemId)

		if hasBuilding then
			local needUpgrade, buildingUid, needLevel = ManufactureController.instance:checkProduceBuildingLevel(manufactureItemId)

			if needUpgrade then
				local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
				local langStr = luaLang("room_upgrade_building_unlock")

				self._txtWrongTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(langStr, (buildingMO or nil) and buildingMO.config.useDesc, needLevel)
				self.wrongBuildingUid = buildingUid
				self.isWrong = true
			end
		else
			local produceBuildingList = ManufactureConfig.instance:getManufactureItemBelongBuildingList(manufactureItemId)
			local buildingConfig = RoomConfig.instance:getBuildingConfig(produceBuildingList[1])
			local langStr = luaLang("room_place_building_to_unlock")

			self._txtWrongTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(langStr, (buildingConfig or nil) and buildingConfig.useDesc)
			self.isWrong = true
		end
	end

	gohelper.setActive(self._txtWrongTip, self.isWrong)
end

function RoomManufactureMaterialTipView:refreshItemQuantity()
	local quantity = ItemModel.instance:getItemQuantity(self.type, self.id) or 0
	local manufactureItemIdList = ManufactureConfig.instance:getManufactureItemListByItemId(self.id)
	local manufactureItemId = manufactureItemIdList[1]
	local numStr = tostring(GameUtil.numberDisplay((manufactureItemId or nil) and ManufactureModel.instance:getManufactureItemCount(manufactureItemId)))

	self._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", numStr)
end

function RoomManufactureMaterialTipView:setJumpItems()
	local sourceTables = {}
	local sourcesConfig = self.config.sources

	if not string.nilorempty(sourcesConfig) then
		local sources = string.split(sourcesConfig, "|")

		for _, source in ipairs(sources) do
			local sourceParam = string.splitToNumber(source, "#")
			local sourceTable = {}

			sourceTable.sourceId = sourceParam[1]
			sourceTable.probability = sourceParam[2]
			sourceTable.episodeId = JumpConfig.instance:getJumpEpisodeId(sourceTable.sourceId)

			local isOpen = JumpConfig.instance:isOpenJumpId(sourceTable.sourceId)
			local isNormal = sourceTable.probability ~= MaterialEnum.JumpProbability.Normal
			local hasPass = DungeonModel.instance:hasPassLevel(sourceTable.episodeId)

			if isOpen and (isNormal or not hasPass) then
				table.insert(sourceTables, sourceTable)
			end
		end
	end

	gohelper.CreateObjList(self, self._onSetJumpItem, sourceTables, self._jumpItemParent, self._gojumpItem)
	gohelper.setActive(self._gosource, #sourceTables > 0)
end

function RoomManufactureMaterialTipView:_onSetJumpItem(obj, data, index)
	local jumpItem = self:getUserDataTb_()

	jumpItem.go = obj
	jumpItem.indexText = gohelper.findChildText(obj, "indexText")
	jumpItem.originText = gohelper.findChildText(obj, "layout/originText")
	jumpItem.jumpHardTagGO = gohelper.findChild(obj, "layout/hardtag")
	jumpItem.probabilityBg = gohelper.findChild(obj, "layout/bg")
	jumpItem.txtProbability = gohelper.findChildText(obj, "layout/bg/probality")
	jumpItem.hasJump = gohelper.findChild(obj, "jump")
	jumpItem.jumpBgGO = gohelper.findChild(obj, "jump/bg")
	jumpItem.jumpBtn = gohelper.findChildButtonWithAudio(obj, "jump/jumpBtn")
	jumpItem.jumpText = gohelper.findChildText(obj, "jump/jumpBtn/jumpText")
	jumpItem.jumpText.text = luaLang("p_materialtip_jump")

	jumpItem.jumpBtn:AddClickListener(self.jumpBtnOnClick, self, index)

	jumpItem.data = data
	jumpItem.jumpId = data.sourceId

	local jumpConfig = JumpConfig.instance:getJumpConfig(jumpItem.jumpId)

	if jumpConfig then
		local jumpName, jumpIndex

		if string.nilorempty(jumpConfig.param) then
			jumpName = jumpConfig.name
		else
			jumpName, jumpIndex = JumpConfig.instance:getJumpName(jumpItem.jumpId, "#D0AB74")
		end

		jumpItem.originText.text = jumpName or ""
		jumpItem.indexText.text = jumpIndex or ""

		local episodeId = jumpItem.data.episodeId

		gohelper.setActive(jumpItem.jumpHardTagGO, JumpConfig.instance:isJumpHardDungeon(episodeId))

		local probability = jumpItem.data.probability
		local showProbability = episodeId and probability and MaterialEnum.JumpProbabilityDisplay[probability]
		local probabilityText = ""

		if showProbability then
			probabilityText = luaLang(MaterialEnum.JumpProbabilityDisplay[probability])
		end

		jumpItem.txtProbability.text = probability

		gohelper.setActive(jumpItem.probabilityBg, showProbability and true or false)

		local isOnlyShowJump = JumpController.instance:isOnlyShowJump(jumpItem.jumpId)

		gohelper.setActive(jumpItem.hasJump, not isOnlyShowJump)

		local isOpen = JumpController.instance:isJumpOpen(jumpItem.jumpId)

		if isOpen then
			jumpItem.cantJumpTips, jumpItem.cantJumpParam = JumpController.instance:cantJump(jumpConfig.param)
		else
			jumpItem.cantJumpTips, jumpItem.cantJumpParam = OpenHelper.getToastIdAndParam(jumpConfig.openId)
		end

		ZProj.UGUIHelper.SetGrayscale(jumpItem.jumpText.gameObject, jumpItem.cantJumpTips)
		ZProj.UGUIHelper.SetGrayscale(jumpItem.jumpBgGO, jumpItem.cantJumpTips)
	else
		gohelper.setActive(jumpItem.go, false)
	end

	self.jumpItemList[index] = jumpItem
end

function RoomManufactureMaterialTipView:onClose()
	self._simagepropicon:UnLoadImage()
end

function RoomManufactureMaterialTipView:onDestroyView()
	for _, jumpItem in ipairs(self.jumpItemList) do
		jumpItem.jumpBtn:RemoveClickListener()
	end
end

return RoomManufactureMaterialTipView
