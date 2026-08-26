-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CollectionTipView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CollectionTipView", package.seeall)

local Act191CollectionTipView = class("Act191CollectionTipView", BaseView)

function Act191CollectionTipView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Root/#simage_Icon")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Root/#txt_Name")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_Root/scroll_desc/Viewport/go_desccontent/#txt_Desc")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Buy")
	self._txtBuyCost = gohelper.findChildText(self.viewGO, "#go_Root/#btn_Buy/#txt_BuyCost")
	self._goTag1 = gohelper.findChild(self.viewGO, "#go_Root/tag/#go_Tag1")
	self._txtTag1 = gohelper.findChildText(self.viewGO, "#go_Root/tag/#go_Tag1/#txt_Tag1")
	self._goTag2 = gohelper.findChild(self.viewGO, "#go_Root/tag/#go_Tag2")
	self._txtTag2 = gohelper.findChildText(self.viewGO, "#go_Root/tag/#go_Tag2/#txt_Tag2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191CollectionTipView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
end

function Act191CollectionTipView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function Act191CollectionTipView:_btnCloseOnClick()
	self:closeThis()
end

function Act191CollectionTipView:_btnBuyOnClick()
	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if gameInfo.coin < self.viewParam.cost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	Activity191Rpc.instance:sendBuyIn191ShopRequest(self.actId, self.viewParam.index, self._buyReply, self)
end

function Act191CollectionTipView:_buyReply(_, resultCode)
	if resultCode == 0 then
		GameFacade.showToast(ToastEnum.Act191BuyTip)
		self:closeThis()
	end
end

function Act191CollectionTipView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()

	SkillHelper.addHyperLinkClick(self._txtDesc, self._onHyperLinkClick, self)
end

function Act191CollectionTipView:_onHyperLinkClick(effectId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(effectId, Vector2(305, -55), CommonBuffTipEnum.Pivot.Left)
end

function Act191CollectionTipView:onUpdateParam()
	self:refreshUI()
end

function Act191CollectionTipView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)
	self:refreshUI()
end

function Act191CollectionTipView:onClose()
	local manual = self.viewContainer:isManualClose()

	if self.config then
		Act191StatController.instance:statViewClose(self.viewName, manual, self.config)
	end
end

function Act191CollectionTipView:refreshUI()
	if self.viewParam then
		if self.viewParam.pos then
			local anchorPos = recthelper.rectToRelativeAnchorPos(self.viewParam.pos, self.viewGO.transform)

			recthelper.setAnchor(self._goRoot.transform, anchorPos.x + 85, 8)
		end

		gohelper.setActive(self._btnClose, not self.viewParam.notShowBg)

		if self.viewParam.showBuy then
			self:refreshCost()
			gohelper.setActive(self._btnBuy, true)
		else
			gohelper.setActive(self._btnBuy, false)
		end

		if self.viewParam.itemId then
			self:refreshCollection(self.viewParam.itemId)
		end
	end
end

function Act191CollectionTipView:refreshCollection(itemId)
	self.config = Activity191Config.instance:getCollectionCo(itemId)

	if self.config then
		self._simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(self.config.icon))

		local rareColor = Activity191Enum.CollectionColor[self.config.rare]

		self._txtName.text = string.format("<#%s>%s</color>", rareColor, self.config.title)
		self._txtDesc.text = self.viewParam and self.viewParam.enhance and SkillHelper.buildDesc(self.config.replaceDesc) or SkillHelper.buildDesc(self.config.desc)

		if string.nilorempty(self.config.label) then
			gohelper.setActive(self._goTag1, false)
			gohelper.setActive(self._goTag2, false)
		else
			local labelList = string.split(self.config.label, "#")

			for i = 1, 2 do
				local str = labelList[i]

				self["_txtTag" .. i].text = str

				gohelper.setActive(self["_goTag" .. i], str)
			end
		end
	end
end

function Act191CollectionTipView:refreshCost()
	local cost = self.viewParam.cost
	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if cost > gameInfo.coin then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtBuyCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtBuyCost, "#211f1f")
	end

	self._txtBuyCost.text = cost
end

return Act191CollectionTipView
