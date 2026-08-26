-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSkinMaterialTipView.lua

module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipView", package.seeall)

local MainSceneSkinMaterialTipView = class("MainSceneSkinMaterialTipView", BaseView)

function MainSceneSkinMaterialTipView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._gobannerContent = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent")
	self._goroominfoItem = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#simage_pic")
	self._goSceneLogo = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._gotag = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#go_tag")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "left/banner/#go_bannerscroll")
	self._gobuyContent = gohelper.findChild(self.viewGO, "right/#go_buyContent")
	self._goblockInfoItem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	self._gopay = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay")
	self._gopayitem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	self._gochange = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change")
	self._txtdesc = gohelper.findChildText(self.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	self._btninsight = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_buyContent/buy/#btn_insight")
	self._txtcostnum = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	self._simagecosticon = gohelper.findChildSingleImage(self.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	self._gosource = gohelper.findChild(self.viewGO, "right/#go_source")
	self._gotime = gohelper.findChild(self.viewGO, "right/#go_source/title/#txt_time")
	self._txttime = gohelper.findChildText(self.viewGO, "right/#go_source/title/#txt_time")
	self._scrolljump = gohelper.findChildScrollRect(self.viewGO, "right/#go_source/#scroll_jump")
	self._gojumpItem = gohelper.findChild(self.viewGO, "right/#go_source/#scroll_jump/Viewport/Content/#go_jumpItem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSceneSkinMaterialTipView:addEvents()
	self._btninsight:AddClickListener(self._btninsightOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function MainSceneSkinMaterialTipView:removeEvents()
	self._btninsight:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function MainSceneSkinMaterialTipView:onClickModalMask()
	self:closeThis()
end

function MainSceneSkinMaterialTipView:_btninsightOnClick()
	return
end

function MainSceneSkinMaterialTipView:_btncloseOnClick()
	self:closeThis()
end

function MainSceneSkinMaterialTipView:_editableInitView()
	gohelper.setActive(self._gojumpItem, false)
	gohelper.setActive(self._gobuyContent, false)
	gohelper.setActive(self._gosource, true)
	gohelper.setActive(self._gotime, false)

	self._jumpParentGo = gohelper.findChild(self.viewGO, "right/#go_source/#scroll_jump/Viewport/Content")
	self.jumpItemGos = {}

	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function MainSceneSkinMaterialTipView:_refreshUI()
	self._canJump = self.viewParam.canJump
	self._config = ItemModel.instance:getItemConfig(self.viewParam.type, self.viewParam.id)
	self._sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(self.viewParam.id)

	self:_cloneJumpItem()
end

function MainSceneSkinMaterialTipView:_cloneJumpItem()
	self._scrolljump.verticalNormalizedPosition = 1

	local sourceTables = {}

	if self._config then
		sourceTables = self:_sourcesStrToTables(self._config.sources)
	end

	for i = 1, #sourceTables do
		local jumpItemTempTab = self.jumpItemGos[i]

		if not jumpItemTempTab then
			if i == 1 then
				if not self._gojumpItem then
					do
						local jumpItemGo = gohelper.clone(self._gojumpItem, self._jumpParentGo, "item" .. i)

						jumpItemTempTab = self:getUserDataTb_()
						jumpItemTempTab.go = jumpItemGo
						jumpItemTempTab.originText = gohelper.findChildText(jumpItemGo, "frame/txt_chapter")
						jumpItemTempTab.indexText = gohelper.findChildText(jumpItemGo, "frame/txt_name")
						jumpItemTempTab.jumpBtn = gohelper.findChildButtonWithAudio(jumpItemGo, "frame/btn_jump")
						jumpItemTempTab.jumpBgGO = gohelper.findChild(jumpItemGo, "frame/btn_jump/jumpbg")

						table.insert(self.jumpItemGos, jumpItemTempTab)
						jumpItemTempTab.jumpBtn:AddClickListener(function(jumpItemTempTab)
							if jumpItemTempTab.cantJumpTips then
								GameFacade.showToastWithTableParam(jumpItemTempTab.cantJumpTips, jumpItemTempTab.cantJumpParam)
							elseif jumpItemTempTab.canJump then
								if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
									NavigateButtonsView.homeClick()

									return
								end

								self:checkViewOpenAndClose()
								GameFacade.jump(jumpItemTempTab.jumpId, self._onJumpFinish, self, self.viewParam.recordFarmItem)
							else
								GameFacade.showToast(ToastEnum.MaterialTipJump)
							end
						end, jumpItemTempTab)
					end

					local sourceTable = sourceTables[i]

					jumpItemTempTab.canJump = self._canJump
					jumpItemTempTab.jumpId = sourceTable.sourceId

					local name, index = JumpConfig.instance:getJumpName(sourceTable.sourceId)

					jumpItemTempTab.originText.text = name or ""
					jumpItemTempTab.indexText.text = index or ""

					local cantJumpTips, toastParamList = self:_getCantJump(sourceTable)

					ZProj.UGUIHelper.SetGrayscale(jumpItemTempTab.jumpBgGO, cantJumpTips ~= nil)

					jumpItemTempTab.cantJumpTips = cantJumpTips
					jumpItemTempTab.cantJumpParam = toastParamList

					gohelper.setActive(jumpItemTempTab.go, true)

					local isOnlyShowJump = JumpController.instance:isOnlyShowJump(sourceTable.sourceId)

					gohelper.setActive(jumpItemTempTab.jumpBtn, not isOnlyShowJump)
				end
			end
		end
	end

	gohelper.setActive(self._gosource, #sourceTables > 0)

	for i = #sourceTables + 1, #self.jumpItemGos do
		gohelper.setActive(self.jumpItemGos[i].go, false)
	end
end

function MainSceneSkinMaterialTipView:_sourcesStrToTables(sourcesStr)
	local sourceTables = {}

	if not string.nilorempty(sourcesStr) then
		local sources = string.split(sourcesStr, "|")

		for i, source in ipairs(sources) do
			local sourceParam = string.splitToNumber(source, "#")
			local sourceTable = {}

			sourceTable.sourceId = sourceParam[1]
			sourceTable.probability = sourceParam[2]
			sourceTable.episodeId = JumpConfig.instance:getJumpEpisodeId(sourceTable.sourceId)

			if sourceTable.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(sourceTable.episodeId) then
				table.insert(sourceTables, sourceTable)
			end
		end
	end

	return sourceTables
end

function MainSceneSkinMaterialTipView:_getCantJump(sourceTable)
	local open = JumpController.instance:isJumpOpen(sourceTable.sourceId)
	local cantJumpTips, toastParamList
	local jumpConfig = JumpConfig.instance:getJumpConfig(sourceTable.sourceId)

	if not open then
		cantJumpTips, toastParamList = OpenHelper.getToastIdAndParam(jumpConfig.openId)
	else
		cantJumpTips, toastParamList = JumpController.instance:cantJump(jumpConfig.param)
	end

	return cantJumpTips, toastParamList
end

MainSceneSkinMaterialTipView.NeedCloseView = {
	ViewName.PackageStoreGoodsView
}

function MainSceneSkinMaterialTipView:checkViewOpenAndClose()
	for _, viewName in pairs(MainSceneSkinMaterialTipView.NeedCloseView) do
		if ViewMgr.instance:isOpen(viewName) then
			ViewMgr.instance:closeView(viewName)
		end
	end
end

function MainSceneSkinMaterialTipView:onUpdateParam()
	self:_refreshUI()
end

function MainSceneSkinMaterialTipView:onOpen()
	self:_refreshUI()
end

function MainSceneSkinMaterialTipView:onClose()
	for i = 1, #self.jumpItemGos do
		self.jumpItemGos[i].jumpBtn:RemoveClickListener()
	end
end

function MainSceneSkinMaterialTipView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return MainSceneSkinMaterialTipView
