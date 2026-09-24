-- chunkname: @modules/logic/decorate/view/DecorateMaterialTipView.lua

module("modules.logic.decorate.view.DecorateMaterialTipView", package.seeall)

local DecorateMaterialTipView = class("DecorateMaterialTipView", BaseView)

function DecorateMaterialTipView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
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

function DecorateMaterialTipView:addEvents()
	self._btninsight:AddClickListener(self._btninsightOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function DecorateMaterialTipView:removeEvents()
	self._btninsight:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function DecorateMaterialTipView:onClickModalMask()
	self:closeThis()
end

function DecorateMaterialTipView:_btninsightOnClick()
	return
end

function DecorateMaterialTipView:_btncloseOnClick()
	self:closeThis()
end

function DecorateMaterialTipView:_editableInitView()
	gohelper.setActive(self._gojumpItem, false)
	gohelper.setActive(self._gobuyContent, false)
	gohelper.setActive(self._gosource, true)
	gohelper.setActive(self._gotime, false)

	self._jumpParentGo = gohelper.findChild(self.viewGO, "right/#go_source/#scroll_jump/Viewport/Content")
	self.jumpItemGos = {}

	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function DecorateMaterialTipView:_refreshUI()
	self._canJump = self.viewParam.canJump
	self._config = ItemModel.instance:getItemConfig(self.viewParam.type, self.viewParam.id)

	self:_refreshJumpItem()
end

function DecorateMaterialTipView:_onClickJump(item)
	if not item or not self._canJump or self._canJump == false then
		return
	end

	if item.canJump then
		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
			NavigateButtonsView.homeClick()

			return
		end

		self:checkViewOpenAndClose()
		GameFacade.jump(item.jumpId)
	elseif item.cantJumpTips and item.cantJumpTips ~= 0 then
		GameFacade.showToastWithTableParam(item.cantJumpTips, item.cantJumpParam)
	else
		GameFacade.showToast(ToastEnum.MaterialTipJump)
	end
end

function DecorateMaterialTipView:_getJumpItem(i)
	local item = self.jumpItemGos[i]

	if not item then
		local jumpItemGo = gohelper.clone(self._gojumpItem, self._jumpParentGo, "item" .. i)

		item = self:getUserDataTb_()
		item.go = jumpItemGo
		item.originText = gohelper.findChildText(jumpItemGo, "frame/txt_chapter")
		item.indexText = gohelper.findChildText(jumpItemGo, "frame/txt_name")
		item.jumpBtn = gohelper.findChildButtonWithAudio(jumpItemGo, "frame/btn_jump")
		item.jumpBgGO = gohelper.findChild(jumpItemGo, "frame/btn_jump/jumpbg")
		item.goempty = gohelper.findChild(jumpItemGo, "frame/txt_empty")

		item.jumpBtn:AddClickListener(self._onClickJump, self, item)

		self.jumpItemGos[i] = item
	end

	return item
end

function DecorateMaterialTipView:_isCurMaterial()
	return DecorateModel.instance:isCurMaterial(self._config)
end

function DecorateMaterialTipView:_refreshJumpItem()
	self._scrolljump.verticalNormalizedPosition = 1

	local sourceTables = {}

	if self._config then
		sourceTables = self:_sourcesStrToTables(self._config.sources)
	end

	local count = 1

	if #sourceTables == 0 or not self:_isCurMaterial() then
		local item = self:_getJumpItem(1)

		gohelper.setActive(item.goempty, true)
		gohelper.setActive(item.indexText, false)
		gohelper.setActive(item.originText, false)
		gohelper.setActive(item.jumpBtn, false)
	else
		for i, source in ipairs(sourceTables) do
			local item = self:_getJumpItem(i)

			item.jumpId = source.sourceId

			local name, index = JumpConfig.instance:getJumpName(source.sourceId)

			item.originText.text = name or ""
			item.indexText.text = index or ""

			local cantJumpTips, toastParamList = DecorateModel.instance:getCantJump(source)
			local canJump = cantJumpTips == nil

			item.canJump = canJump

			ZProj.UGUIHelper.SetGrayscale(item.jumpBgGO, not canJump or not self._canJump)
			gohelper.setActive(item.goempty, not canJump)
			gohelper.setActive(item.indexText, canJump)
			gohelper.setActive(item.originText, canJump)

			item.cantJumpTips = cantJumpTips
			item.cantJumpParam = toastParamList

			gohelper.setActive(item.go, true)
			gohelper.setActive(item.jumpBtn, canJump)
		end

		count = #sourceTables
	end

	for i, item in pairs(self.jumpItemGos) do
		gohelper.setActive(item.go, i <= count)
	end
end

function DecorateMaterialTipView:_sourcesStrToTables(sourcesStr)
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

DecorateMaterialTipView.NeedCloseView = {
	ViewName.PackageStoreGoodsView
}

function DecorateMaterialTipView:checkViewOpenAndClose()
	for _, viewName in pairs(DecorateMaterialTipView.NeedCloseView) do
		if ViewMgr.instance:isOpen(viewName) then
			ViewMgr.instance:closeView(viewName)
		end
	end
end

function DecorateMaterialTipView:onUpdateParam()
	self:_refreshUI()
end

function DecorateMaterialTipView:onOpen()
	self:_refreshUI()
end

function DecorateMaterialTipView:onClose()
	for i = 1, #self.jumpItemGos do
		self.jumpItemGos[i].jumpBtn:RemoveClickListener()
	end
end

function DecorateMaterialTipView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return DecorateMaterialTipView
