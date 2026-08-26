-- chunkname: @modules/logic/tips/view/MaterialTipView.lua

module("modules.logic.tips.view.MaterialTipView", package.seeall)

local MaterialTipView = class("MaterialTipView", BaseView)

function MaterialTipView:onInitView()
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

	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagepropicon = gohelper.findChildSingleImage(self.viewGO, "iconbg/#simage_propicon")
	self._goequipicon = gohelper.findChild(self.viewGO, "iconbg/#go_equipicon")
	self._simageequipicon = gohelper.findChildSingleImage(self.viewGO, "iconbg/#go_equipicon/#simage_equipicon")
	self._gohadnumber = gohelper.findChild(self.viewGO, "iconbg/#go_hadnumber")
	self._txthadnumber = gohelper.findChildText(self.viewGO, "iconbg/#go_hadnumber/#txt_hadnumber")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "iconbg/#btn_detail")
	self._btnplayerbg = gohelper.findChildButtonWithAudio(self.viewGO, "iconbg/#btn_playerbg")
	self._txtpropname = gohelper.findChildText(self.viewGO, "#txt_propname")
	self._txtproptip = gohelper.findChildText(self.viewGO, "#txt_proptip")
	self._txtexpire = gohelper.findChildText(self.viewGO, "#txt_expire")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._gojumptxt = gohelper.findChild(self.viewGO, "#scroll_desc/#go_jumptxt")
	self._gojumpItem = gohelper.findChild(self.viewGO, "#scroll_desc/#go_jumpItem")
	self._gosource = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content/#go_source")
	self._txtsource = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#go_source/#txt_source")
	self._gouse = gohelper.findChild(self.viewGO, "#go_use")
	self._gouseDetail = gohelper.findChild(self.viewGO, "#go_use/#go_usedetail")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "#go_use/#go_usedetail/valuebg/#input_value")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#go_usedetail/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#go_usedetail/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#go_usedetail/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#go_usedetail/#btn_max")
	self._btnuse = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#btn_use")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_close")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._goinclude = gohelper.findChild(self.viewGO, "#go_include")
	self._goincludetxt = gohelper.findChild(self.viewGO, "#go_include/go_includetxt")
	self._gofilterherotxt = gohelper.findChild(self.viewGO, "#go_include/go_filterherotxt")
	self._goplayericon = gohelper.findChild(self.viewGO, "iconbg/#go_playericon")
	self._simageheadicon = gohelper.findChildSingleImage(self.viewGO, "iconbg/#go_playericon/#simage_headicon")
	self._goupgrade = gohelper.findChild(self.viewGO, "iconbg/#go_upgrade")
	self._goframe = gohelper.findChild(self.viewGO, "iconbg/#go_playericon/#go_frame")
	self._goframenode = gohelper.findChild(self.viewGO, "iconbg/#go_playericon/#go_framenode")
	self._goSummonsimulationtips = gohelper.findChild(self.viewGO, "#go_summonpicktips")
	self._btnsummonsimulation = gohelper.findChildButton(self.viewGO, "#btn_summonSiumlationTips")

	if self._editableInitView then
		self:_editableInitView()
	end

	self._loader = MultiAbLoader.New()
end

function MaterialTipView:addEvents()
	if self._btnone then
		self._btnone:AddClickListener(self._btnoneOnClick, self)
	end

	if self._btnten then
		self._btnten:AddClickListener(self._btntenOnClick, self)
	end

	if self._btnhundred then
		self._btnhundred:AddClickListener(self._btnhundredOnClick, self)
	end

	if self._btnthousand then
		self._btnthousand:AddClickListener(self._btnthousandOnClick, self)
	end

	if self._btntenthousand then
		self._btntenthousand:AddClickListener(self._btntenthousandOnClick, self)
	end

	if self._btntenmillion then
		self._btntenmillion:AddClickListener(self._btntenmillionOnClick, self)
	end

	if self._btninput then
		self._btninput:AddClickListener(self._btninputOnClick, self)
	end

	if self._btnplayerbg then
		self._btnplayerbg:AddClickListener(self._btnplayerbgOnClick, self)
	end

	if self._btnsummonsimulation then
		self._btnsummonsimulation:AddClickListener(self._btnsummonsimulationOnClick, self)
	end

	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._inputvalue:AddOnEndEdit(self._onEndEdit, self)
end

function MaterialTipView:removeEvents()
	if self._btnone then
		self._btnone:RemoveClickListener()
	end

	if self._btnten then
		self._btnten:RemoveClickListener()
	end

	if self._btnhundred then
		self._btnhundred:RemoveClickListener()
	end

	if self._btnthousand then
		self._btnthousand:RemoveClickListener()
	end

	if self._btntenthousand then
		self._btntenthousand:RemoveClickListener()
	end

	if self._btntenmillion then
		self._btntenmillion:RemoveClickListener()
	end

	if self._btninput then
		self._btninput:RemoveClickListener()
	end

	if self._btnplayerbg then
		self._btnplayerbg:RemoveClickListener()
	end

	if self._btnsummonsimulation then
		self._btnsummonsimulation:RemoveClickListener()
	end

	self._btndetail:RemoveClickListener()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btnuse:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._inputvalue:RemoveOnEndEdit()
end

local math_floor = math.floor
local sf = string.format
local ti = table.insert
local FakeIconTab = {
	[MaterialEnum.MaterialType.Item] = {
		[BpEnum.ScoreItemId] = true,
		[Anniversary3ActBpEnum.ScoreItemId] = true,
		[MaterialEnum.PowerMakerItemId] = true
	},
	[MaterialEnum.MaterialType.Currency] = {
		[CurrencyEnum.CurrencyType.V1a6CachotCoin] = true,
		[CurrencyEnum.CurrencyType.V1a6CachotCurrency] = true
	}
}
local HideHadnumberSubType = {
	[ItemEnum.SubType.Portrait] = true,
	[ItemEnum.SubType.Badge] = true
}

function MaterialTipView:_btndetailOnClick()
	if not self._canJump then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return
	end

	JumpController.instance:jumpByParamWithCondition(sf("51#%d", self.viewParam.id), self._onJumpFinish, self)
end

function MaterialTipView:_btnplayerbgOnClick()
	ViewMgr.instance:openView(ViewName.PlayerChangeBgView, {
		itemMo = self.viewParam
	})
end

function MaterialTipView:_btnsummonsimulationOnClick()
	if not self._config then
		return
	end

	if self:_isPackageSkin() then
		if self._config.id == V3a7_SkinGiftEnum.ItemId then
			local param = {}

			param.itemId = self.viewParam.id
			param.type = self.viewParam.type

			ViewMgr.instance:openView(ViewName.V3a7_SkinGiftCheckView, param)
		else
			HelpController.instance:openBpRuleTipsView(luaLang("ruledetail"), "Rule Details", V3a7_SkinGiftHelper.getSkinGiftRareDesc(self._config.id, "material_packageskin_rate_desc_3_7", "MaterialTipViewPackageSkinDescFmt_3_7"))
		end
	elseif self._config.activityId then
		SummonSimulationPickController.instance:openSummonTips(self._config.activityId)
	end
end

function MaterialTipView:_onEndEdit(inputStr)
	self._valueChanged = false
	self._value = tonumber(inputStr)

	if self._value > self:_getMaxValue() then
		self._value = self:_getMaxValue()

		self._inputvalue:SetText(tostring(self._value))

		self._valueChanged = true

		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	if self._value < 1 then
		self._value = 1

		self._inputvalue:SetText(tostring(self._value))

		self._valueChanged = true

		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end
end

function MaterialTipView:_btncloseOnClick()
	if self._originData.isReturnLastTipView and (self.viewParam.type ~= self._originData.type or self.viewParam.id ~= self._originData.id) then
		self.viewParam = self._originData

		self:_refreshUI()

		return
	end

	self:closeThis()
end

function MaterialTipView:_btninputOnClick()
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

function MaterialTipView:_btntenmillionOnClick()
	self:sendGMRequest(10000000)
end

function MaterialTipView:_btnoneOnClick()
	self:sendGMRequest(1)
end

function MaterialTipView:_btntenOnClick()
	self:sendGMRequest(10)
end

function MaterialTipView:_btnhundredOnClick()
	self:sendGMRequest(100)
end

function MaterialTipView:_btnthousandOnClick()
	self:sendGMRequest(1000)
end

function MaterialTipView:_btntenthousandOnClick()
	self:sendGMRequest(10000)
end

function MaterialTipView:sendGMRequest(val)
	GameFacade.showToast(ToastEnum.GMTool5, self.viewParam.id)

	if self.viewParam.type == MaterialEnum.MaterialType.Item and self.viewParam.id == 510001 then
		GMRpc.instance:sendGMRequest(sf("add heroStoryTicket %d", val))
	else
		GMRpc.instance:sendGMRequest(sf("add material %d#%d#%d", self.viewParam.type, self.viewParam.id, val))
	end
end

function MaterialTipView:_editableInitView()
	if self._gogm then
		gohelper.setActive(self._gogm, GMController.instance:isOpenGM())
	end

	self._txtdesc = SLFramework.GameObjectHelper.FindChildComponent(self.viewGO, "#scroll_desc/viewport/content/desc", typeof(TMPro.TextMeshProUGUI))
	self._txtusedesc = SLFramework.GameObjectHelper.FindChildComponent(self.viewGO, "#scroll_desc/viewport/content/usedesc", typeof(TMPro.TextMeshProUGUI))

	gohelper.setActive(self._gojumpItem, false)
	gohelper.setActive(self._gojumptxt, false)

	self.jumpItemGos = {}
	self._boxItemGos = {}
	self._iconItemList = {}
	self._value = 1
	self._goincludeScroll = gohelper.findChild(self._goinclude, "#scroll_product")
	self._goincludeContent = gohelper.findChild(self._goinclude, "#scroll_product/viewport/content")
	self._contentHorizontal = self._goincludeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))

	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._txtsource.text = luaLang("materialview_source")
	self._txtSummonsimulationtips = gohelper.findChildText(self._goSummonsimulationtips, "txt_tips")
	self._goboxtip = gohelper.findChild(self.viewGO, "buy_tip")
	self._txtboxtipnum = gohelper.findChildText(self.viewGO, "buy_tip/bg/#txt_num")
	self._txtboxkeyname = gohelper.findChildText(self.viewGO, "buy_tip/bg/txt")
	self._imageboxtipicon = gohelper.findChildImage(self.viewGO, "buy_tip/bg/icon")
end

function MaterialTipView:_cloneJumpItem()
	local jumpParentGo = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content")

	self._scrolldesc.verticalNormalizedPosition = 1

	local boxTables = {}
	local choiceViewHasOpen = ViewMgr.instance:isOpen(ViewName.GiftMultipleChoiceView)
	local optionalGiftOpen = ItemModel.instance:getOptionalGiftBySubTypeAndRare(self._config.subType, self._config.rare, self._config.id)

	if optionalGiftOpen then
		for _, boxData in pairs(optionalGiftOpen) do
			local boxTable = {}

			boxTable.sourceId = 1
			boxTable.sourceParam = boxData.id

			table.insert(boxTables, boxTable)
		end
	end

	if not string.nilorempty(self._config.boxOpen) and not choiceViewHasOpen then
		local boxs = string.split(self._config.boxOpen, "|")

		for i, box in ipairs(boxs) do
			local boxParam = string.splitToNumber(box, "#")
			local boxTable = {}

			boxTable.sourceId = boxParam[1]
			boxTable.sourceParam = boxParam[2]

			table.insert(boxTables, boxTable)
		end
	end

	if boxTables then
		for i, boxTable in ipairs(boxTables) do
			local sourceQuantity = ItemModel.instance:getItemCount(boxTable.sourceParam)

			if sourceQuantity > 0 then
				if not self._boxItemGos[i] then
					local itemGo = gohelper.clone(self._gojumpItem, jumpParentGo, "boxitem" .. i)
					local itemTempTab = self:getUserDataTb_()

					itemTempTab.go = itemGo
					itemTempTab.layout = gohelper.findChild(itemGo, "layout"):GetComponent(typeof(ZProj.LimitedScrollRect))
					itemTempTab.originText = gohelper.findChildText(itemGo, "layout/Viewport/Content/originText")
					itemTempTab.indexText = gohelper.findChildText(itemGo, "indexText")
					itemTempTab.jumpBtn = gohelper.findChildButtonWithAudio(itemGo, "jump/jumpBtn")
					itemTempTab.hasjump = gohelper.findChild(itemGo, "jump")
					itemTempTab.jumpText = gohelper.findChildText(itemGo, "jump/jumpBtn/jumpText")
					itemTempTab.jumpHardTagGO = gohelper.findChild(itemGo, "layout/Viewport/Content/hardtag")
					itemTempTab.jumpBgGO = gohelper.findChild(itemGo, "jump/bg")
					itemTempTab.probalityBg = gohelper.findChild(itemGo, "layout/Viewport/Content/bg")
					itemTempTab.txtProbality = gohelper.findChildText(itemGo, "layout/Viewport/Content/bg/probality")

					local var_19_0 = boxTables.episodeId

					if boxTables.episodeId then
						var_19_0 = boxTables.probability

						if boxTables.probability then
							local showProbality = MaterialEnum.JumpProbabilityDisplay[boxTables.probability]

							itemTempTab.txtProbality.text = showProbality and string.format("%s", luaLang(MaterialEnum.JumpProbabilityDisplay[boxTables.probability])) or ""

							gohelper.setActive(itemTempTab.probalityBg, showProbality and true or false)
							gohelper.setActive(itemTempTab.jumpHardTagGO, false)

							local itemName = ItemConfig.instance:getItemCo(tonumber(boxTable.sourceParam)).name

							itemTempTab.jumpText.text = sf(luaLang("level_limit_unlock"), "")
							itemTempTab.originText.text = sf("<color=#3f485f><size=32>%s</size></color>", sf(luaLang("material_storage"), itemName))
							itemTempTab.indexText.text = ""

							table.insert(self._boxItemGos, itemTempTab)
							itemTempTab.jumpBtn:AddClickListener(function(itemTempTab)
								local quantity = ItemModel.instance:getItemCount(self._config.id)
								local sourceQuantity = ItemModel.instance:getItemCount(boxTable.sourceParam)

								GiftModel.instance:reset()

								if self.viewParam.needQuantity then
									if quantity > self.viewParam.needQuantity or not self.viewParam.isConsume then
										self._value = 1
									else
										self._value = sourceQuantity > self.viewParam.needQuantity - quantity and (self.viewParam.needQuantity - quantity == 0 and 1 or self.viewParam.needQuantity - quantity) or sourceQuantity

										if quantity < self.viewParam.needQuantity then
											GiftModel.instance:setNeedGift(self.viewParam.id)
										end
									end
								else
									self._value = 1
								end

								MaterialTipController.instance:showMaterialInfo(boxTable.sourceId, boxTable.sourceParam, true)
							end, itemTempTab)
						end
					end
				end

				gohelper.setActive(self._boxItemGos[i].go, true)
			elseif self._boxItemGos[i] then
				gohelper.setActive(self._boxItemGos[i].go, false)
			end
		end
	end

	local sourcesConfig = self._config.sources
	local sourceTables = {}

	if not string.nilorempty(sourcesConfig) then
		local sources = string.split(sourcesConfig, "|")

		for i, source in ipairs(sources) do
			local sourceParam = string.splitToNumber(source, "#")
			local sourceTable = {}

			sourceTable.sourceId = sourceParam[1]
			sourceTable.probability = sourceParam[2]
			sourceTable.episodeId = JumpConfig.instance:getJumpEpisodeId(sourceTable.sourceId)

			local isOpen = JumpConfig.instance:isOpenJumpId(sourceTable.sourceId)

			if isOpen and (sourceTable.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(sourceTable.episodeId)) then
				table.insert(sourceTables, sourceTable)
			end
		end
	end

	local sourceExList = DungeonConfig.instance:getMaterialSource(self.viewParam.type, self.viewParam.id)

	if sourceExList then
		for _, v in ipairs(sourceExList) do
			local sourceTable = {}

			sourceTable.sourceId = -1
			sourceTable.probability = v.probability
			sourceTable.episodeId = v.episodeId
			sourceTable.jumpParam = sf("4#%s", v.episodeId)

			if v.episodeId then
				local episodeConfig = DungeonConfig.instance:getEpisodeCO(v.episodeId)

				if episodeConfig then
					sourceTable.isOpen = ResSplitConfig.instance:isSaveChapter(episodeConfig.chapterId)
				end

				table.insert(sourceTables, sourceTable)
			end
		end
	end

	for i = 1, #sourceTables do
		local jumpItemTempTab = self.jumpItemGos[i]

		if not jumpItemTempTab then
			local jumpItemGo = gohelper.clone(self._gojumpItem, jumpParentGo, "item" .. i)

			jumpItemTempTab = self:getUserDataTb_()
			jumpItemTempTab.go = jumpItemGo
			jumpItemTempTab.layout = gohelper.findChild(jumpItemGo, "layout"):GetComponent(typeof(ZProj.LimitedScrollRect))
			jumpItemTempTab.originText = gohelper.findChildText(jumpItemGo, "layout/Viewport/Content/originText")
			jumpItemTempTab.indexText = gohelper.findChildText(jumpItemGo, "indexText")
			jumpItemTempTab.jumpBtn = gohelper.findChildButtonWithAudio(jumpItemGo, "jump/jumpBtn")
			jumpItemTempTab.hasjump = gohelper.findChild(jumpItemGo, "jump")
			jumpItemTempTab.jumpText = gohelper.findChildText(jumpItemGo, "jump/jumpBtn/jumpText")
			jumpItemTempTab.jumpHardTagGO = gohelper.findChild(jumpItemGo, "layout/Viewport/Content/hardtag")
			jumpItemTempTab.jumpBgGO = gohelper.findChild(jumpItemGo, "jump/bg")
			jumpItemTempTab.probalityBg = gohelper.findChild(jumpItemGo, "layout/Viewport/Content/bg")
			jumpItemTempTab.txtProbality = gohelper.findChildText(jumpItemGo, "layout/Viewport/Content/bg/probality")

			table.insert(self.jumpItemGos, jumpItemTempTab)

			jumpItemTempTab.layout.parentGameObject = self._scrolldesc.gameObject

			jumpItemTempTab.jumpBtn:AddClickListener(function(jumpItemTempTab)
				if jumpItemTempTab.cantJumpTips then
					GameFacade.showToastWithTableParam(jumpItemTempTab.cantJumpTips, jumpItemTempTab.cantJumpParam)
				elseif jumpItemTempTab.canJump then
					if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
						NavigateButtonsView.homeClick()

						return
					end

					if jumpItemTempTab.jumpParam then
						ViewMgr.instance:closeView(ViewName.RoomInitBuildingView)
						JumpController.instance:jumpTo(jumpItemTempTab.jumpParam, self._onJumpFinish, self, self.viewParam.recordFarmItem)
					else
						JumpController.instance:dispatchEvent(JumpEvent.JumpBtnClick, jumpItemTempTab.jumpId)
						GameFacade.jump(jumpItemTempTab.jumpId, self._onJumpFinish, self, self.viewParam.recordFarmItem)
						self:statJump(jumpItemTempTab.jumpId)
					end
				else
					GameFacade.showToast(ToastEnum.MaterialTipJump)
				end
			end, jumpItemTempTab)
		end

		local sourceTable = sourceTables[i]

		jumpItemTempTab.canJump = self._canJump
		jumpItemTempTab.jumpId = sourceTable.sourceId
		jumpItemTempTab.jumpParam = sourceTable.jumpParam

		local jumpConfig = sourceTable.sourceId ~= -1 and JumpConfig.instance:getJumpConfig(sourceTable.sourceId)
		local name = ""
		local index = ""

		if sourceTable.sourceId == -1 then
			name, index = JumpConfig.instance:getEpisodeNameAndIndex(sourceTable.episodeId)
		elseif string.nilorempty(jumpConfig.param) then
			name = jumpConfig.name
		else
			name, index = JumpConfig.instance:getJumpName(sourceTable.sourceId)
		end

		jumpItemTempTab.originText.text = name or ""
		jumpItemTempTab.indexText.text = index or ""

		local var_19_3 = sourceTable.episodeId

		if sourceTable.episodeId then
			var_19_3 = sourceTable.probability

			if sourceTable.probability then
				local showProbality = MaterialEnum.JumpProbabilityDisplay[sourceTable.probability]

				jumpItemTempTab.txtProbality.text = showProbality and sf("%s", luaLang(MaterialEnum.JumpProbabilityDisplay[sourceTable.probability])) or ""
				jumpItemTempTab.jumpText.text = luaLang("p_materialtip_jump")

				gohelper.setActive(jumpItemTempTab.probalityBg, showProbality and true or false)

				if jumpConfig then
					if not jumpConfig.param then
						local jumpParam = sourceTable.jumpParam
						local open = sourceTable.sourceId == -1 and sourceTable.isOpen or sourceTable.sourceId == JumpEnum.BPChargeView and not BpModel.instance:isEnd() and JumpController.instance:isJumpOpen(sourceTable.sourceId) or JumpController.instance:isJumpOpen(sourceTable.sourceId)
						local cantJumpTips, toastParamList

						if not open and sourceTable.sourceId ~= -1 then
							cantJumpTips, toastParamList = OpenHelper.getToastIdAndParam(jumpConfig.openId)
						else
							cantJumpTips, toastParamList = JumpController.instance:cantJump(jumpParam)
						end

						local jumps = string.split(jumpParam, "#")
						local jumpView = tonumber(jumps[1])

						if jumpView == JumpEnum.JumpView.RoomProductLineView and not cantJumpTips then
							local isUnLock, unLockParam, unlockTips
							local var_19_6, var_19_7, var_19_8 = RoomProductionHelper.isChangeFormulaUnlock(self.viewParam.type, self.viewParam.id)

							unLockParam = var_19_8
							unlockTips = var_19_7

							if not var_19_6 then
								cantJumpTips = var_19_7
								toastParamList = var_19_8 and {
									var_19_8
								} or nil
							end
						end

						local isOnlyShowJump = sourceTable.sourceId ~= -1 and JumpController.instance:isOnlyShowJump(sourceTable.sourceId)

						gohelper.setActive(jumpItemTempTab.hasjump, not isOnlyShowJump)
						ZProj.UGUIHelper.SetGrayscale(jumpItemTempTab.jumpText.gameObject, cantJumpTips ~= nil)
						ZProj.UGUIHelper.SetGrayscale(jumpItemTempTab.jumpBgGO, cantJumpTips ~= nil)

						jumpItemTempTab.cantJumpTips = cantJumpTips
						jumpItemTempTab.cantJumpParam = toastParamList

						gohelper.setActive(jumpItemTempTab.jumpHardTagGO, JumpConfig.instance:isJumpHardDungeon(sourceTable.episodeId))
						gohelper.setActive(jumpItemTempTab.go, true)
					end
				end
			end
		end
	end

	gohelper.setActive(self._gosource, #sourceTables > 0 or #boxTables > 0)

	for i = #boxTables + 1, #self._boxItemGos do
		gohelper.setActive(self._boxItemGos[i].go, false)
	end

	for i = #sourceTables + 1, #self.jumpItemGos do
		gohelper.setActive(self.jumpItemGos[i].go, false)
	end
end

function MaterialTipView:_setJumpMaxIndexWidth(count)
	local maxIndexWidth = 0

	for i = 1, count do
		local jumpItemTempTab = self.jumpItemGos[i]

		if jumpItemTempTab then
			local indexWidth = jumpItemTempTab.indexText.preferredWidth

			if maxIndexWidth < indexWidth then
				maxIndexWidth = indexWidth
			end
		end
	end

	for i = 1, count do
		local jumpItemTempTab = self.jumpItemGos[i]

		if jumpItemTempTab then
			recthelper.setAnchorX(jumpItemTempTab.originText.transform, (maxIndexWidth > 0 or nil) and (maxIndexWidth + 15 or -4))
		end
	end
end

function MaterialTipView:_onJumpFinish()
	ViewMgr.instance:closeView(ViewName.MaterialPackageTipView)
	self:closeThis()

	if self.viewParam.jumpFinishCallback then
		self.viewParam.jumpFinishCallback(self.viewParam.jumpFinishCallbackObj, self.viewParam.jumpFinishCallbackParam)
	end
end

function MaterialTipView:_btnuseOnClick()
	if self._valueChanged then
		self._valueChanged = false

		return
	end

	self._value = tonumber(self._inputvalue:GetText())

	if self._value > self:_getMaxValue() then
		self._value = self:_getMaxValue()

		self._inputvalue:SetText(tostring(self._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	if self._value < 1 then
		self._value = 1

		self._inputvalue:SetText(tostring(self._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	local materialId = self._config.id
	local quantity = self._value

	if self.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
		CurrencyController.instance:openPowerView()

		return
	elseif self.viewParam.type == MaterialEnum.MaterialType.TalentItem then
		local param = {}

		param.itemId = self.viewParam.id
		param.itemUid = self.viewParam.uid

		ItemTalentController.instance:openTalentChooseView(param)
		self:closeThis()

		return
	elseif self.viewParam.type == MaterialEnum.MaterialType.NewInsight then
		self:closeThis()
		GiftController.instance:openGiftInsightHeroChoiceView(self.viewParam)

		return
	end

	if self:_isSummonSkin() then
		MaterialTipController.instance:_openView_LifeCirclePickChoice(self._config, quantity)
	elseif self:_isPackageSkin() then
		CharacterModel.instance:setGainHeroViewShowState(false)
		CharacterModel.instance:setGainHeroViewNewShowState(false)
		ItemRpc.instance:simpleSendUseItemRequest(materialId, quantity)
	elseif self:_isGoldenMilletPresentSkin() then
		local jumpId = self._config.effect

		GameFacade.jump(jumpId)
	elseif MaterialTipController.instance:isSpecifiedGift(self._config) then
		local o = {}

		o.param = self.viewParam
		o.quantity = quantity
		o.subType = self._config.subType

		GiftController.instance:openGiftMultipleChoiceView(o)
	elseif MaterialTipController.instance:isBpCustomSelect(self._config) then
		local o = {}

		o.param = self.viewParam
		o.quantity = quantity
		o.subType = self._config.subType

		GiftController.instance:openGiftMultipleChoiceView(o)
	elseif MaterialTipController.instance:isHeroSelect(self._config) then
		local o = {}

		o.param = self.viewParam
		o.quantity = quantity
		o.subType = self._config.subType
		o.itemId = self._config.id
		o.type = SkinDiscountCompensateEnum.SelectDisplayType.Select

		GiftController.instance:openGiftMultipleHeroChoiceView(o)
	elseif self._config.subType == ItemEnum.SubType.OptionalGift then
		local o = {}

		o.param = self.viewParam
		o.quantity = quantity
		o.subType = self._config.subType

		GiftController.instance:openOptionalGiftMultipleChoiceView(o)
	elseif self._config.subType == ItemEnum.SubType.OptionalHeroGift then
		if string.nilorempty(self._config.effect) then
			return
		end

		local effectArr = string.splitToNumber(self._config.effect, "#")
		local styleId = CustomPickChoiceEnum.style.OptionalHeroGift
		local viewParam = {
			id = self._config.id,
			quantity = quantity,
			styleId = styleId
		}

		if self._config.id == ItemEnum.NewbiePackGiftId then
			CustomPickChoiceController.instance:openNewBiePickChoiceView(effectArr, MaterialTipController.onUseOptionalHeroGift, MaterialTipController, viewParam)
		else
			CustomPickChoiceController.instance:openCustomPickChoiceView(effectArr, MaterialTipController.onUseOptionalHeroGift, MaterialTipController, viewParam)
		end
	elseif self._config.subType == ItemEnum.SubType.SkinTicket then
		StoreController.instance:openStoreView(500)
	elseif self._config.subType == ItemEnum.SubType.DecorateDiscountTicket then
		StoreController.instance:openStoreView(801)
	elseif self._config.subType == ItemEnum.SubType.RoomTicket then
		GameFacade.showMessageBox(MessageBoxIdDefine.GoToUseRoomTicket, MsgBoxEnum.BoxType.Yes_No, self._useRoomTicket, nil, nil, self, nil, nil)
	elseif self._config.subType == ItemEnum.SubType.SummonSimulationPick then
		local activityId = self._config.activityId

		self:_tryUseSummonSimulation(activityId)

		return
	elseif self._config.subType == ItemEnum.SubType.SelfSelectSix then
		if string.nilorempty(self._config.effect) then
			return
		end

		local effectArr = string.split(self._config.effect, "|")
		local viewParam = {
			quantity = 1,
			id = self._config.id
		}

		V2a7_SelfSelectSix_PickChoiceController.instance:openCustomPickChoiceView(effectArr, MaterialTipController.onUseSelfSelectSixHeroGift, MaterialTipController, viewParam)
	elseif self._config.subType == ItemEnum.SubType.DestinyStoneUp then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DestinyStone) then
			local openEpisodeId = lua_open.configDict[OpenEnum.UnlockFunc.DestinyStone].episodeId

			if not DungeonModel.instance:hasPassLevel(openEpisodeId) then
				local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(openEpisodeId)

				GameFacade.showToast(ToastEnum.DungeonMapLevel, episodeDisplay)
			end

			return
		end

		local itemId = DestinyStoneGiftPickChoiceEnum.V2a7ItemId

		DestinyStoneGiftPickChoiceController.instance:openHeroChoiceView(itemId)
	elseif self:_isRoomBlockGift() then
		local function cb()
			RoomBlockGiftController.instance:openBlockView(self._config.rare, materialId, self.closeThis, self)
		end

		RoomRpc.instance:sendGetRoomInfoRequest(cb, self)

		return
	elseif self._config.subType == ItemEnum.SubType.RoomBlockColorGift then
		local result = RoomWaterReformModel.instance:isUnlockAllBlockColor()

		if result then
			GameFacade.showToast(ToastEnum.HaveUnlockedAllBlockColor)

			return
		else
			ItemRpc.instance:simpleSendUseItemRequest(materialId, quantity)
		end
	elseif self._config.subType == ItemEnum.SubType.EquipSelectGift then
		if string.nilorempty(self._config.effect) then
			return
		end

		local effectArr = string.split(self._config.effect, "|")
		local viewParam = {
			quantity = 1,
			id = self._config.id
		}

		TurnbackPickEquipController.instance:openTurnbackPickEquipView(effectArr, MaterialTipController.onUseOptionalTurnbackEquipGift, MaterialTipController, viewParam)
	elseif self._config.subType == ItemEnum.SubType.SkinSelelctGift then
		CharacterController.instance:useSkinGiftItem(self._config.id)
	elseif self._config.subType == ItemEnum.SubType.HeroExpBox then
		if HeroExpBoxModel.instance:getKeyCount() >= HeroExpBoxModel.instance:getNeedKeyCount(self._config.id) then
			HeroExpBoxController.instance:openHeroExpBoxView(self._config.id)
		else
			local keyCo = HeroExpBoxModel.instance:getKeyCo()

			GameFacade.showToast(ToastEnum.NoEnoughItem, keyCo.name)

			return
		end
	elseif self._config.subType == ItemEnum.SubType.DestinySummonPackage then
		local poolId = self._config.effect
		local param = string.format("%s#%s", JumpEnum.JumpView.SummonView, poolId)

		JumpController.instance:jumpByParam(param)
	elseif self._config.subType == ItemEnum.SubType.NewDestinyStoneUp then
		local itemId = DestinyStoneGiftPickChoiceEnum.V3a8ItemId

		DestinyStoneGiftPickChoiceController.instance:openHeroChoiceView(itemId)
	elseif self._config.subType == ItemEnum.SubType.EquipLvUp then
		local itemId = self._config.id

		EquipLvUpController.instance:checkOpenEquipLvUpChooseView(itemId)
	else
		ItemRpc.instance:simpleSendUseItemRequest(materialId, quantity)
	end

	if materialId == V3a4GiftRecommendEnum.OffItemId and ViewMgr.instance:isOpen(ViewName.V3a4GiftRecommendPanelview) then
		ViewMgr.instance:closeView(ViewName.V3a4GiftRecommendPanelview)
	end

	self:closeThis()
end

function MaterialTipView:_useRoomTicket()
	GameFacade.jump(JumpEnum.JumpId.RoomStore, self._onJumpFinish, self)
end

function MaterialTipView:_tryUseSummonSimulation(activityId)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onGetSummonInfo, self._realUseSummonSimulation, self)
	SummonSimulationPickController.instance:getActivityInfo(activityId)
end

function MaterialTipView:_realUseSummonSimulation(activityId)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onGetSummonInfo, self._realUseSummonSimulation, self)
	SummonSimulationPickController.instance:trySummonSimulation(activityId)
	self:closeThis()
end

function MaterialTipView:_btnaddOnClick()
	if self._valueChanged then
		self._valueChanged = false

		return
	end

	self._value = tonumber(self._inputvalue:GetText())

	if self._value >= self:_getMaxValue() then
		self._value = self:_getMaxValue()

		self._inputvalue:SetText(tostring(self._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	self._value = self._value + 1

	self:_refreshValue()
end

function MaterialTipView:_btnsubOnClick()
	if self._valueChanged then
		self._valueChanged = false

		return
	end

	self._value = tonumber(self._inputvalue:GetText())

	if self._value <= 1 then
		self._value = 1

		self._inputvalue:SetText(tostring(self._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	self._value = self._value - 1

	self:_refreshValue()
end

function MaterialTipView:_btnmaxOnClick()
	self._value = self:_getMaxValue()

	self:_refreshValue()
end

function MaterialTipView:_btnminOnClick()
	self._value = 1

	self:_refreshValue()
end

function MaterialTipView:onDestroyView()
	return
end

function MaterialTipView:_refreshValue()
	self._inputvalue:SetText(tostring(self._value))
end

function MaterialTipView:_getMaxValue()
	if self._config.isStackable == 1 then
		local quantity = ItemModel.instance:getItemCount(self._config.id)
		local useCo = ItemConfig.instance:getItemUseCo(self._config.subType)

		if useCo.useType == 2 then
			return 1
		elseif useCo.useType == 6 then
			return (quantity > useCo.use_max or nil) and (useCo.use_max or quantity)
		end
	end

	return 1
end

function MaterialTipView:onOpen()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshItemQuantity, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshItemQuantity, self)
	self:addGmBtnAudio()

	self._originData = self.viewParam

	self:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function MaterialTipView:onUpdateParam()
	self:_refreshUI()
end

function MaterialTipView:addGmBtnAudio()
	if self._btnone then
		gohelper.addUIClickAudio(self._btnone.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if self._btnten then
		gohelper.addUIClickAudio(self._btnten.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if self._btnhundred then
		gohelper.addUIClickAudio(self._btnhundred.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if self._btnthousand then
		gohelper.addUIClickAudio(self._btnthousand.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if self._btntenthousand then
		gohelper.addUIClickAudio(self._btntenthousand.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if self._btntenmillion then
		gohelper.addUIClickAudio(self._btntenmillion.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if self._btninput then
		gohelper.addUIClickAudio(self._btninput.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end
end

function MaterialTipView:_refreshUI()
	self._canJump = self.viewParam.canJump

	if self._txtmattip then
		self._txtmattip.text = tostring(self.viewParam.type) .. "#" .. tostring(self.viewParam.id)
	end

	self._config, self._icon = ItemModel.instance:getItemConfigAndIcon(self.viewParam.type, self.viewParam.id)

	if self.viewParam.type == MaterialEnum.MaterialType.Equip then
		self._icon = ResUrl.getEquipIcon(self._config.icon)
	elseif self._config.subType == ItemEnum.SubType.Portrait then
		self._icon = ResUrl.getPlayerHeadIcon(self._config.icon)
	end

	gohelper.setActive(self._simagepropicon.gameObject, false)

	local _isUseBtnShow = self:_isUseBtnShow()

	if _isUseBtnShow then
		gohelper.setActive(self._gouse, true)

		local showDetail = true

		if self.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
			showDetail = false
		elseif self.viewParam.type == MaterialEnum.MaterialType.TalentItem then
			showDetail = false
		elseif self._config.subType == ItemEnum.SubType.RoomTicket then
			showDetail = false
		elseif self._config.subType == ItemEnum.SubType.SkinTicket then
			showDetail = false
		elseif self._config.subType == ItemEnum.SubType.DecorateDiscountTicket then
			showDetail = false
		elseif self.viewParam.type == MaterialEnum.MaterialType.NewInsight then
			showDetail = false
		elseif self._config.subType == ItemEnum.SubType.SelfSelectSix then
			showDetail = false

			recthelper.setAnchorY(self._btnuse.transform, -190)
		elseif self._config.subType == ItemEnum.SubType.NewDestinyStoneUp then
			showDetail = false

			recthelper.setAnchorY(self._btnuse.transform, -200)
		elseif self._config.subType == ItemEnum.SubType.EquipSelectGift then
			showDetail = false

			recthelper.setAnchorY(self._btnuse.transform, -190)
			recthelper.setAnchorY(self._goincludeScroll.transform, 42)
		elseif self._config.subType == ItemEnum.SubType.SkinSelelctGift or self._config.subType == ItemEnum.SubType.HeroExpBox then
			showDetail = false

			recthelper.setAnchorY(self._btnuse.transform, -190)
			recthelper.setAnchorY(self._goincludeScroll.transform, 52)
		elseif self:_isRoomBlockGift() then
			showDetail = false

			recthelper.setAnchorY(self._btnuse.transform, -190)
			recthelper.setAnchorY(self._goincludeScroll.transform, 52)
		elseif self._config.subType == ItemEnum.SubType.SkinSelelctGift then
			showDetail = false
		elseif self._config.subType == ItemEnum.SubType.DestinySummonPackage then
			showDetail = false
		elseif MaterialTipController.instance:isBpCustomSelect(self._config) then
			showDetail = false

			recthelper.setAnchorY(self._btnuse.transform, -190)
		end

		gohelper.setActive(self._gouseDetail, showDetail)
	else
		gohelper.setActive(self._gouse, false)
	end

	if self._config.subType ~= ItemEnum.SubType.Portrait then
		self._simageequipicon:LoadImage(self._icon)
	end

	self._txtproptip.text = ""
	self._txtexpire.text = ""
	self._txtpropname.text = self._config.name

	TaskDispatcher.cancelTask(self._onRefreshPowerPotionDeadline, self)
	TaskDispatcher.cancelTask(self._onRefreshItemDeadline, self)
	TaskDispatcher.cancelTask(self._onRefreshTalentItemDeadline, self)

	local isPortrait = self._config.subType == ItemEnum.SubType.Portrait

	gohelper.setActive(self._goequipicon, false)

	if self.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
		self:_onRefreshPowerPotionDeadline()
		gohelper.setActive(self._simagepropicon.gameObject, true)
		self._simagepropicon:LoadImage(self._icon)
		TaskDispatcher.runRepeat(self._onRefreshPowerPotionDeadline, self, 1)
	elseif self.viewParam.type == MaterialEnum.MaterialType.TalentItem then
		self:_onRefreshTalentItemDeadline()
		gohelper.setActive(self._simagepropicon.gameObject, true)
		self._simagepropicon:LoadImage(self._icon)
		TaskDispatcher.runRepeat(self._onRefreshTalentItemDeadline, self, 1)
	elseif self.viewParam.type == MaterialEnum.MaterialType.NewInsight then
		self:_onRefreshNewInsightDeadline()
		gohelper.setActive(self._simagepropicon.gameObject, true)
		self._simagepropicon:LoadImage(self._icon)
		TaskDispatcher.runRepeat(self._onRefreshNewInsightDeadline, self, 1)
	elseif self.viewParam.type == MaterialEnum.MaterialType.SpecialExpiredItem then
		self:_onRefreshSpecialExpiredItemDeadline()
		gohelper.setActive(self._simagepropicon.gameObject, true)
		self._simagepropicon:LoadImage(self._icon)
		TaskDispatcher.runRepeat(self._onRefreshSpecialExpiredItemDeadline, self, 1)
	elseif self.viewParam.type == MaterialEnum.MaterialType.Equip then
		gohelper.setActive(self._goequipicon, true)
	else
		self:_onRefreshItemDeadline()

		if isPortrait then
			self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageheadicon)

			self._liveHeadIcon:setLiveHead(self._config.id, true)
		else
			if self._liveHeadIcon then
				self._liveHeadIcon:setVisible(false)
			end

			self._simagepropicon:LoadImage(self._icon, self._setIconNativeSize, self)
		end

		gohelper.setActive(self._simagepropicon.gameObject, not isPortrait)
		TaskDispatcher.runRepeat(self._onRefreshItemDeadline, self, 1)
	end

	self._txtdesc.text = self._config.desc
	self._txtusedesc.text = self._config.useDesc

	self:_refreshItemQuantity()
	self:_refreshItemQuantityVisible()
	gohelper.setActive(self._btndetail.gameObject, self.viewParam.type == MaterialEnum.MaterialType.Equip)
	gohelper.setActive(self._btnplayerbg, false)
	gohelper.setActive(self._goplayericon, self._config.subType == ItemEnum.SubType.Portrait)

	local isSummonSimulation = self._config.subType == ItemEnum.SubType.SummonSimulationPick
	local isShowLefTopBtnTips = isSummonSimulation or self:_isPackageSkin()

	gohelper.setActive(self._goSummonsimulationtips, isShowLefTopBtnTips)
	gohelper.setActive(self._btnsummonsimulation, isShowLefTopBtnTips)

	local isExp = self.viewParam.type == MaterialEnum.MaterialType.Exp

	gohelper.setActive(self._gohadnumber, not isExp and not self:_checkHideHadNum() and not self:_checkIsFakeIcon())
	gohelper.setActive(self._goupgrade, self._config.subType == ItemEnum.SubType.Portrait and not string.nilorempty(self._config.effect))

	local effectArr = string.split(self._config.effect, "#")

	if self._config.subType == ItemEnum.SubType.Portrait then
		if #effectArr > 1 then
			if self._config.id == tonumber(effectArr[#effectArr]) then
				gohelper.setActive(self._goupgrade, false)
				gohelper.setActive(self._goframe, false)
				gohelper.setActive(self._goframenode, true)

				local framePath = "ui/viewres/common/effect/frame.prefab"

				self._loader:addPath(framePath)
				self._loader:startLoad(self._onLoadCallback, self)
			end
		else
			gohelper.setActive(self._goframe, true)
			gohelper.setActive(self._goframenode, false)
		end
	end

	self:_refreshValue()
	self:_refreshInclude()

	if _isUseBtnShow then
		gohelper.setActive(self._gosource, false)

		for _, item in ipairs(self._boxItemGos or {}) do
			if item then
				gohelper.setActive(item.go, false)
			end
		end

		for _, item in ipairs(self.jumpItemGos or {}) do
			if item then
				gohelper.setActive(item.go, false)
			end
		end
	else
		self:_cloneJumpItem()
	end

	if _isUseBtnShow then
		recthelper.setHeight(self._scrolldesc.transform, 180)
	elseif self._goinclude.activeInHierarchy then
		recthelper.setHeight(self._scrolldesc.transform, 162)
	else
		recthelper.setHeight(self._scrolldesc.transform, 415)
	end

	if isShowLefTopBtnTips then
		if isSummonSimulation then
			self._txtSummonsimulationtips.text = luaLang("p_normalstoregoodsview_txt_summonpicktips")
		end

		if self:_isPackageSkin() then
			self._txtSummonsimulationtips.text = luaLang("ruledetail")
		end
	end

	local currency = {}

	gohelper.setActive(self._goboxtip, self._config.subType == ItemEnum.SubType.HeroExpBox)

	if self._config.subType == ItemEnum.SubType.HeroExpBox then
		local quantity = HeroExpBoxModel.instance:getKeyCount()
		local needKeyCount = HeroExpBoxModel.instance:getNeedKeyCount(self._config.id)
		local icon = HeroExpBoxModel.instance:getKeyIcon()

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageboxtipicon, icon .. "_1", true)

		self._txtboxtipnum.text = needKeyCount <= quantity and string.format("%d/%d", quantity, needKeyCount) or string.format("<color=%s>%d</color>/%d", "#FF0000", quantity, needKeyCount)
		self._txtboxkeyname.text = HeroExpBoxModel.instance:getKeyName()

		local effect = HeroExpBoxModel.instance:getBoxEffect(self._config.id)
		local needKey = effect.needKeyCount
		local gray = quantity < needKey

		ZProj.UGUIHelper.SetGrayscale(self._btnuse.gameObject, gray)

		currency = {
			{
				isCurrencySprite = true,
				type = MaterialEnum.MaterialType.Item,
				id = HeroExpBoxModel.instance:getKeyId()
			}
		}
	else
		ZProj.UGUIHelper.SetGrayscale(self._btnuse.gameObject, false)
	end

	if self.viewContainer.refreshCurrencyView then
		self.viewContainer:refreshCurrencyView(currency)
	end
end

function MaterialTipView:_checkHideHadNum()
	if HideHadnumberSubType[self._config.subType] then
		return true
	end

	return false
end

function MaterialTipView:_checkIsFakeIcon()
	if not FakeIconTab[self.viewParam.type] then
		return false
	end

	return FakeIconTab[self.viewParam.type][self.viewParam.id] or false
end

function MaterialTipView:_onRefreshPowerPotionDeadline()
	local ts = ItemPowerModel.instance:getPowerItemDeadline(self.viewParam.uid)

	if self._config.expireType ~= 0 and self.viewParam.uid then
		local hasExpire = ts <= ServerTime.now()

		if hasExpire then
			self._txtproptip.text = ""
			self._txtexpire.text = luaLang("hasExpire")
		else
			local offsetSecond = math.floor(ts - ServerTime.now())

			self._txtproptip.text = self:getRemainTimeStr(offsetSecond)
		end
	else
		self._txtproptip.text = ""
		self._txtexpire.text = ""

		TaskDispatcher.cancelTask(self._onRefreshPowerPotionDeadline, self)
	end
end

function MaterialTipView:_onRefreshTalentItemDeadline()
	local ts = ItemTalentModel.instance:getTalentItemDeadline(self.viewParam.uid)

	if self.viewParam.uid then
		local hasExpire = ts <= ServerTime.now()

		if hasExpire then
			self._txtproptip.text = ""
			self._txtexpire.text = luaLang("hasExpire")
		else
			local offsetSecond = math.floor(ts - ServerTime.now())

			self._txtproptip.text = self:getRemainTimeStr(offsetSecond)
		end
	else
		self._txtproptip.text = ""
		self._txtexpire.text = ""

		TaskDispatcher.cancelTask(self._onRefreshTalentItemDeadline, self)
	end
end

function MaterialTipView:_onRefreshNewInsightDeadline()
	local ts = ItemInsightModel.instance:getInsightItemDeadline(self.viewParam.uid)

	if self._config.expireHours == ItemEnum.NoExpiredNum then
		self._txtproptip.text = ""
		self._txtexpire.text = ""
	elseif self._config.expireType ~= 0 and self.viewParam.uid then
		local hasExpire = ts <= ServerTime.now()

		if hasExpire then
			self._txtproptip.text = ""
			self._txtexpire.text = luaLang("hasExpire")
		else
			local offsetSecond = math.floor(ts - ServerTime.now())

			self._txtproptip.text = self:getRemainTimeStr(offsetSecond)
		end
	else
		local itemCfg = ItemConfig.instance:getInsightItemCo(self.viewParam.id)
		local expireTime = itemCfg.expireHours

		self._txtproptip.text = self:getInsightItemRemainTimeStr(expireTime)
		self._txtexpire.text = ""

		TaskDispatcher.cancelTask(self._onRefreshNewInsightDeadline, self)
	end
end

function MaterialTipView:_onRefreshSpecialExpiredItemDeadline()
	local ts = ItemExpireModel.instance:getSpecialExpireItemEarliestExpireTime(self.viewParam.id)

	if ts and ts > 0 then
		local hasExpire = ts <= ServerTime.now()

		if hasExpire then
			self._txtproptip.text = ""
			self._txtexpire.text = luaLang("hasExpire")
		else
			local offsetSecond = math.floor(ts - ServerTime.now())

			self._txtproptip.text = self:getRemainTimeStr(offsetSecond)
		end
	else
		self._txtproptip.text = ""
		self._txtexpire.text = ""

		TaskDispatcher.cancelTask(self._onRefreshSpecialExpiredItemDeadline, self)
	end
end

function MaterialTipView:getRemainTimeStr(ts)
	local date = TimeUtil.secondToRoughTime3(ts, false)

	return date and sf(luaLang("remain"), " " .. date) or ""
end

function MaterialTipView:getInsightItemRemainTimeStr(hour)
	local timeStr = TimeUtil.secondToRoughTime2(hour * 3600, false)

	return timeStr and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("newinsight_item_detail_remain_time"), timeStr) or ""
end

function MaterialTipView:_onRefreshItemDeadline()
	if self._config.isShow == 1 and self._config.isTimeShow == 1 and self._config.expireTime and self._config.expireTime ~= "" then
		local ts = TimeUtil.stringToTimestamp(self._config.expireTime)
		local serverTsInLocal = ServerTime.now()
		local hasExpire = ts <= serverTsInLocal

		if hasExpire then
			self._txtproptip.text = ""
			self._txtexpire.text = luaLang("hasExpire")
		else
			local offsetSecond = math.floor(ts - ServerTime.now())

			self._txtproptip.text = self:getRemainTimeStr(offsetSecond)
		end
	else
		self._txtproptip.text = ""
		self._txtexpire.text = ""

		TaskDispatcher.cancelTask(self._onRefreshItemDeadline, self)
	end
end

function MaterialTipView:_onLoadCallback()
	local framePrefab = self._loader:getFirstAssetItem():GetResource()

	gohelper.clone(framePrefab, self._goframenode, "frame")
end

function MaterialTipView:_refreshItemQuantity()
	local var_50_0

	if self.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
		do
			local count

			if self.viewParam.id == MaterialEnum.PowerId.SmallPower_Expire or self.viewParam.id == MaterialEnum.PowerId.SmallPower then
				count = ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower_Expire) + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower)
			elseif self.viewParam.id == MaterialEnum.PowerId.BigPower_Expire or self.viewParam.id == MaterialEnum.PowerId.BigPower then
				count = ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower_Expire) + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower)
			elseif self.viewParam.id == MaterialEnum.PowerId.OverflowPowerId then
				local ofMakerInfo = ItemPowerModel.instance:getPowerMakerInfo()

				count = ofMakerInfo and ofMakerInfo.itemTotalCount
			end

			count = count or ItemPowerModel.instance:getPowerCount(self.viewParam.id)
			self._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", count)

			return
		end

		var_50_0 = GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(self.viewParam.type, self.viewParam.id, self.viewParam.uid, self.viewParam.fakeQuantity)) or 0
	end

	local numStr = tostring(var_50_0)

	self._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", numStr)
end

function MaterialTipView:_refreshItemQuantityVisible()
	local isShow = self.viewParam.id ~= BpEnum.ScoreItemId and self.viewParam.id ~= Anniversary3ActBpEnum.ScoreItemId
	local isExp = self.viewParam.type == MaterialEnum.MaterialType.Exp

	gohelper.setActive(self._gohadnumber, isShow and not isExp and not self:_checkHideHadNum())
	gohelper.setActive(self._txthadnumber, isShow)
end

function MaterialTipView:_setIconNativeSize()
	self._simagepropicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function MaterialTipView:_refreshInclude()
	MaterialTipListModel.instance:clear()

	local showInclude = MaterialEnum.SubTypePackages[self._config.subType] == true or MaterialTipController.instance:isSpecifiedGift(self._config)

	showInclude = showInclude or self:_isPackageSkin()
	showInclude = showInclude and self.viewParam.inpack ~= true
	showInclude = (MaterialEnum.SubTypeInPack[self._config.subType] or MaterialTipController.instance:isBpCustomSelect(self._config)) and true

	gohelper.setActive(self._goinclude, showInclude)

	if showInclude then
		gohelper.setActive(self._goincludetxt, true)
	end

	local count = 0
	local includetype

	if showInclude then
		local includeItems

		if self:_isPackageSkin() then
			includeItems = self:_getPackageSkinIncludeItems()
		elseif self._config.subType == ItemEnum.SubType.OptionalGift then
			includeItems = GiftMultipleChoiceListModel.instance:getOptionalGiftInfo(self._config.id)
		elseif self._config.subType == ItemEnum.SubType.OptionalHeroGift then
			includeItems = {}

			local heroIds = string.splitToNumber(self._config.effect, "#")

			for i, id in ipairs(heroIds) do
				includeItems[i] = {
					4,
					id,
					1
				}
			end
		elseif self._config.subType == ItemEnum.SubType.SelfSelectSix then
			local effectArr = string.split(self._config.effect, "|")

			includeItems = {}

			for _, value in ipairs(effectArr) do
				local temp = string.split(value, ":")
				local heroIdList = {}

				if temp[2] and #temp[2] > 0 then
					heroIdList = string.splitToNumber(temp[2], ",")

					if #heroIdList > 0 then
						for _, heroId in ipairs(heroIdList) do
							local co = {}

							co[1] = MaterialEnum.MaterialType.Hero
							co[2] = heroId
							co[3] = 1

							table.insert(includeItems, co)
						end
					end
				end
			end
		elseif self._config.subType == ItemEnum.SubType.SkinSelelctGift then
			local effectArr = GameUtil.splitString2(self._config.effect, true)[1]

			includeItems = {}

			for _, heroSkinId in ipairs(effectArr) do
				local co = {}

				co[1] = MaterialEnum.MaterialType.HeroSkin
				co[2] = heroSkinId
				co[3] = 1

				table.insert(includeItems, co)
			end
		elseif self._config.subType == ItemEnum.SubType.NewDestinyStoneUp then
			gohelper.setActive(self._goincludetxt, false)
			gohelper.setActive(self._gofilterherotxt, true)

			local effectArr = GameUtil.splitString2(self._config.effect, true)[3]

			includeItems = {}

			for _, heroId in ipairs(effectArr) do
				local co = {}

				co[1] = MaterialEnum.MaterialType.Hero
				co[2] = heroId
				co[3] = 1
				co[4] = ItemEnum.SubType.NewDestinyStoneUp

				table.insert(includeItems, co)
			end
		elseif self:_isRoomBlockGift() then
			self._contentHorizontal.enabled = false
			self._content = self._content or self._goincludeContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
			self._content.enabled = false
			includeItems = RoomBlockBuildingGiftModel.instance:getGiftBlockMos(self._config.id)

			MaterialTipListModel.instance:setData(includeItems)

			return
		elseif self:checkShowHeroExpBox() then
			self._contentHorizontal.enabled = false
			self._content = self._content or self._goincludeContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
			self._content.enabled = false
			includeItems = HeroExpBoxModel.instance:getBoxEffectIncludeItems(self._config.id)

			MaterialTipListModel.instance:setData(includeItems)

			return
		elseif self._config.subType == ItemEnum.SubType.RandomNewItemBox then
			local rewardParam = string.split(self._config.effect, "|")

			includeItems = GameUtil.splitString2(rewardParam[2], true, "&", "#")
		else
			includeItems = GameUtil.splitString2(self._config.effect, true)
		end

		count = #includeItems

		if self:checkOnlyShowEquip() then
			local list = {}

			for index, itemco in ipairs(includeItems) do
				if itemco[1] == MaterialEnum.MaterialType.Equip then
					table.insert(list, itemco)
				end
			end

			includeItems = list
		end

		for i, itemco in ipairs(includeItems) do
			local itemIcon = self._iconItemList[i]

			if itemIcon == nil then
				local type = itemco[1]
				local id = itemco[2]
				local num = itemco[3]
				local subType = itemco[4]

				includetype = type

				if type == MaterialEnum.MaterialType.Equip then
					itemIcon = IconMgr.instance:getCommonEquipIcon(self._goincludeContent)

					itemIcon:setMOValue(type, id, num, nil, true)
					itemIcon:hideLv(true)

					local function callback()
						MaterialTipController.instance:showMaterialInfo(type, id)
					end

					itemIcon:customClick(callback)
				elseif type == MaterialEnum.MaterialType.Hero then
					itemIcon = IconMgr.instance:getCommonItemIcon(self._goincludeContent)

					itemIcon:setMOValue(type, id, num, nil, true)
					itemIcon:isShowCount(false)

					if subType == ItemEnum.SubType.NewDestinyStoneUp then
						itemIcon:customOnClickCallback(self._onNewDestinyPreveiew, self, id)
					end
				elseif type == MaterialEnum.MaterialType.HeroSkin then
					itemIcon = IconMgr.instance:getCommonItemIcon(self._goincludeContent)

					itemIcon:setMOValue(type, id, num, nil, true)
					itemIcon:isShowCount(false)
				else
					itemIcon = IconMgr.instance:getCommonItemIcon(self._goincludeContent)

					itemIcon:setMOValue(type, id, num, nil, true)
					itemIcon:isShowCount(true)
				end

				table.insert(self._iconItemList, itemIcon)
			end

			itemIcon:setCountFontSize(37.142857142857146)
			gohelper.setActive(itemIcon.go, true)
		end
	end

	if includetype == MaterialEnum.MaterialType.Equip then
		self._contentHorizontal.spacing = 6.62
		self._contentHorizontal.padding.left = 36
		self._contentHorizontal.padding.top = 10
	end

	for i = count + 1, #self._iconItemList do
		gohelper.setActive(self._iconItemList[i].go, false)
	end
end

function MaterialTipView:_onNewDestinyPreveiew(heroId)
	local itemId = DestinyStoneGiftPickChoiceEnum.V3a8ItemId

	DestinyStoneGiftPickChoiceController.instance:openHeroChoicePreview(heroId, itemId)
end

function MaterialTipView:checkOnlyShowEquip()
	if self._config.subType == ItemEnum.SubType.EquipSelectGift then
		return true
	end

	return false
end

function MaterialTipView:checkShowHeroExpBox()
	return self._config.subType == ItemEnum.SubType.HeroExpBox
end

function MaterialTipView:checkIncludeEquip(includeItems)
	for i, itemco in ipairs(includeItems) do
		if itemco then
			local type = itemco[1]

			if type == MaterialEnum.MaterialType.Equip then
				return true
			end
		end
	end

	return false
end

function MaterialTipView:_isUseBtnShow()
	local useCo = ItemConfig.instance:getItemUseCo(self._config.subType)

	if self.viewParam.inpack and useCo then
		::label_59_0::

		local defaultResult = useCo.useType ~= 1

		if self.viewParam.type == MaterialEnum.MaterialType.PowerPotion and self.viewParam.inpack and self:_isFromBackpackView() then
			return true
		end

		if self.viewParam.type == MaterialEnum.MaterialType.TalentItem and self.viewParam.inpack and self:_isFromBackpackView() then
			return true
		end

		if self.viewParam.type == MaterialEnum.MaterialType.NewInsight and self.viewParam.inpack and self:_isFromBackpackView() then
			return true
		end

		if self._config.subType == ItemEnum.SubType.RoomTicket then
			if ViewMgr.instance:isOpen(ViewName.StoreView) then
				return false
			end

			return defaultResult
		end

		if self._config.subType == ItemEnum.SubType.SkinTicket then
			if ViewMgr.instance:isOpen(ViewName.StoreView) then
				return false
			end

			local itemQuantity = ItemModel.instance:getItemQuantity(self.viewParam.type, self.viewParam.id, self.viewParam.uid, self.viewParam.fakeQuantity)

			return itemQuantity > 0
		end

		if self._config.subType == ItemEnum.SubType.DecorateDiscountTicket then
			if ViewMgr.instance:isOpen(ViewName.StoreView) then
				return false
			end

			local itemQuantity = ItemModel.instance:getItemQuantity(self.viewParam.type, self.viewParam.id, self.viewParam.uid, self.viewParam.fakeQuantity)

			return itemQuantity > 0
		end

		if self._config.subType == ItemEnum.SubType.SkinSelelctGift then
			if self.viewParam.inpack == false or ViewMgr.instance:isOpen(ViewName.StoreView) then
				return false
			end

			local itemQuantity = ItemModel.instance:getItemQuantity(self.viewParam.type, self.viewParam.id, self.viewParam.uid, self.viewParam.fakeQuantity)

			return itemQuantity > 0
		end

		if self:_isRoomBlockGift() then
			return self.viewParam.inpack
		end

		return defaultResult
	end
end

function MaterialTipView:_isFromBackpackView()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for k, v in pairs(openViewNameList) do
		if v == ViewName.BackpackView then
			return true
		end
	end

	return false
end

function MaterialTipView:statJump(jumpId)
	local isSmallPower = self.viewParam.id == MaterialEnum.PowerId.SmallPower_Expire
	local isBigPower = self.viewParam.id == MaterialEnum.PowerId.BigPower_Expire

	if isSmallPower or isBigPower then
		local jumpconfig

		if jumpId then
			jumpconfig = JumpConfig.instance:getJumpConfig(jumpId)
		end

		if isSmallPower then
			StoreController.instance:statOnClickPowerPotionJump(StatEnum.PowerType.Small, jumpconfig.name)
		elseif isBigPower then
			StoreController.instance:statOnClickPowerPotionJump(StatEnum.PowerType.Big, jumpconfig.name)
		end
	end
end

function MaterialTipView:onClose()
	TaskDispatcher.cancelTask(self._onRefreshPowerPotionDeadline, self)
	TaskDispatcher.cancelTask(self._onRefreshTalentItemDeadline, self)
	TaskDispatcher.cancelTask(self._onRefreshNewInsightDeadline, self)
	TaskDispatcher.cancelTask(self._onRefreshSpecialExpiredItemDeadline, self)
	TaskDispatcher.cancelTask(self._onRefreshItemDeadline, self)

	self.viewContainer._isCloseImmediate = true

	for i = 1, #self.jumpItemGos do
		self.jumpItemGos[i].jumpBtn:RemoveClickListener()
	end

	for i = 1, #self._boxItemGos do
		self._boxItemGos[i].jumpBtn:RemoveClickListener()
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._simagepropicon:UnLoadImage()
	self._simageheadicon:UnLoadImage()
	self._simageequipicon:UnLoadImage()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

function MaterialTipView:_isPackageSkin()
	return self._config.clienttag == ItemEnum.Tag.PackageSkin
end

function MaterialTipView:_getPackageSkinDesc()
	local rateInfoList = ItemConfig.instance:getRewardGroupRateInfoList(self._config.effect)
	local skinsS = {}

	for _, info in ipairs(rateInfoList) do
		local rate = info.rate * 100
		local intNum = math_floor(rate)
		local decimalNum = rate - intNum

		if decimalNum ~= 0 then
			decimalNum = math_floor(decimalNum * 1000 / 100)
			rate = sf("%s.%s", intNum, decimalNum)
		end

		local skinId = info.materialId
		local skinCO = lua_skin.configDict[skinId]
		local characterId = skinCO.characterId
		local characterCO = lua_character.configDict[characterId]
		local fillParams = {
			characterCO.name,
			skinCO.characterSkin,
			rate
		}
		local desc = GameUtil.getSubPlaceholderLuaLang(luaLang("material_packageskin_rate_desc"), fillParams)

		ti(skinsS, desc)
	end

	return formatLuaLang("MaterialTipViewPackageSkinDescFmt", table.concat(skinsS, "\n"))
end

function MaterialTipView:_getPackageSkinIncludeItems()
	local rateInfoList = ItemConfig.instance:getRewardGroupRateInfoList(self._config.effect)
	local list = {}

	for _, info in ipairs(rateInfoList) do
		ti(list, {
			info.materialType,
			info.materialId,
			[3] = 1
		})
	end

	return list
end

function MaterialTipView:_isSummonSkin()
	return self._config.clienttag == ItemEnum.Tag.SummonSkin
end

function MaterialTipView:_isRoomBlockGift()
	return self._config.subType == ItemEnum.SubType.RoomBlockGiftNew or self._config.subType == ItemEnum.SubType.RoomBlockGift
end

function MaterialTipView:_isGoldenMilletPresentSkin()
	return self._config.clienttag == ItemEnum.Tag.GoldenMilletPresentSkin
end

return MaterialTipView
