-- chunkname: @modules/logic/room/view/common/RoomMaterialTipView.lua

module("modules.logic.room.view.common.RoomMaterialTipView", package.seeall)

local RoomMaterialTipView = class("RoomMaterialTipView", BaseView)

function RoomMaterialTipView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._gobannerContent = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent")
	self._goroominfoItem = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	self._goslider = gohelper.findChild(self.viewGO, "left/banner/#go_slider")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "left/banner/#go_bannerscroll")
	self._goact = gohelper.findChild(self.viewGO, "left/#go_actname")
	self._txtactname = gohelper.findChildText(self.viewGO, "left/#go_actname/#txt_actname")
	self._btntheme = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_theme")
	self._txttheme = gohelper.findChildText(self.viewGO, "left/#btn_theme/txt")
	self._gocobrand = gohelper.findChild(self.viewGO, "left/#go_cobrand")
	self._gobuyContent = gohelper.findChild(self.viewGO, "right/#go_buyContent")
	self._goblockInfoItem = gohelper.findChild(self.viewGO, "right/#go_buyContent/scroll_blockpackage/viewport/content/#go_blockInfoItem")
	self._gopay = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay")
	self._gopayitem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	self._btninsight = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_buyContent/buy/#btn_insight")
	self._txtcostnum = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	self._simagecosticon = gohelper.findChildSingleImage(self.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	self._gosource = gohelper.findChild(self.viewGO, "right/#go_source")
	self._gotime = gohelper.findChild(self.viewGO, "right/#go_source/title/#txt_time")
	self._txttime = gohelper.findChildText(self.viewGO, "right/#go_source/title/#txt_time")
	self._scrolljump = gohelper.findChildScrollRect(self.viewGO, "right/#go_source/#scroll_jump")
	self._gojumpItem = gohelper.findChild(self.viewGO, "right/#go_source/#scroll_jump/Viewport/Content/#go_jumpItem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomMaterialTipView:addEvents()
	self._btntheme:AddClickListener(self._btnthemeOnClick, self)
	self._btninsight:AddClickListener(self._btninsightOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomMaterialTipView:removeEvents()
	self._btntheme:RemoveClickListener()
	self._btninsight:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RoomMaterialTipView:_btnthemeOnClick()
	ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
		type = self.viewParam.type,
		id = self.viewParam.id
	})
end

function RoomMaterialTipView:_btninsightOnClick()
	return
end

function RoomMaterialTipView:_btncloseOnClick()
	self:closeThis()
end

function RoomMaterialTipView:_editableInitView()
	gohelper.setActive(self._gojumpItem, false)
	gohelper.setActive(self._gobuyContent, false)
	gohelper.setActive(self._gosource, true)

	self._jumpParentGo = gohelper.findChild(self.viewGO, "right/#go_source/#scroll_jump/Viewport/Content")
	self.jumpItemGos = {}

	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gocobrand, RoomSourcesCobrandLogoItem, self)
end

function RoomMaterialTipView:_refreshUI()
	self._roomSkinId = self.viewParam.roomSkinId
	self._canJump = self.viewParam.canJump

	local hasActId = false
	local showTheme = false
	local sourcesTypeStr

	if self._roomSkinId then
		local actId = RoomConfig.instance:getRoomSkinActId(self._roomSkinId)

		hasActId = actId and actId ~= 0

		local actName = ""

		if hasActId then
			local actCfg = ActivityConfig.instance:getActivityCo(actId)

			actName = actCfg and actCfg.name or ""
		end

		self._txtactname.text = actName

		local actInfoMo = ActivityModel.instance:getActMO(actId)

		self._txttime.text = actInfoMo and actInfoMo:getRemainTimeStr3(false, true) or ""
	else
		self._config = ItemModel.instance:getItemConfig(self.viewParam.type, self.viewParam.id)

		local themeId = RoomConfig.instance:getThemeIdByItem(self.viewParam.id, self.viewParam.type)
		local themeCO = themeId and lua_room_theme.configDict[themeId]

		if themeCO then
			self._txttheme.text = themeCO.name or ""
		end

		showTheme = themeId ~= nil
		sourcesTypeStr = self._config.sourcesType
	end

	self.cobrandLogoItem:setSourcesTypeStr(sourcesTypeStr)
	gohelper.setActive(self._goact, hasActId)
	gohelper.setActive(self._gotime, hasActId)
	gohelper.setActive(self._btntheme.gameObject, showTheme and not self.cobrandLogoItem:getIsShow())
	self:_cloneJumpItem()
end

function RoomMaterialTipView:_cloneJumpItem()
	self._scrolljump.verticalNormalizedPosition = 1

	local sourceTables = {}

	if self._config then
		sourceTables = self:_sourcesStrToTables(self._config.sources)
	elseif self._roomSkinId then
		local strSources = RoomConfig.instance:getRoomSkinSources(self._roomSkinId)

		sourceTables = self:_sourcesStrToTables(strSources)
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

function RoomMaterialTipView:_sourcesStrToTables(sourcesStr)
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

function RoomMaterialTipView:_getCantJump(sourceTable)
	local open = JumpController.instance:isJumpOpen(sourceTable.sourceId)
	local cantJumpTips, toastParamList
	local jumpConfig = JumpConfig.instance:getJumpConfig(sourceTable.sourceId)

	if not open then
		cantJumpTips, toastParamList = OpenHelper.getToastIdAndParam(jumpConfig.openId)
	else
		cantJumpTips, toastParamList = JumpController.instance:cantJump(jumpConfig.param)
	end

	local jumps = string.split(jumpConfig.param, "#")
	local jumpView = tonumber(jumps[1])

	if jumpView == JumpEnum.JumpView.RoomProductLineView and not cantJumpTips then
		local isUnLock, unLockParam, unlockTips
		local var_12_0, var_12_1, var_12_2 = RoomProductionHelper.isChangeFormulaUnlock(self.viewParam.type, self.viewParam.id)

		unLockParam = var_12_2
		unlockTips = var_12_1

		if not var_12_0 then
			cantJumpTips = var_12_1
			toastParamList = var_12_2 and {
				var_12_2
			} or nil
		end
	end

	return cantJumpTips, toastParamList
end

function RoomMaterialTipView:onUpdateParam()
	self:_refreshUI()
end

function RoomMaterialTipView:onOpen()
	self:_refreshUI()
end

function RoomMaterialTipView:onClose()
	for i = 1, #self.jumpItemGos do
		self.jumpItemGos[i].jumpBtn:RemoveClickListener()
	end
end

function RoomMaterialTipView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self.cobrandLogoItem:onDestroy()
end

return RoomMaterialTipView
