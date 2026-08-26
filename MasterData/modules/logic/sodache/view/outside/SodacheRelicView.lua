-- chunkname: @modules/logic/sodache/view/outside/SodacheRelicView.lua

module("modules.logic.sodache.view.outside.SodacheRelicView", package.seeall)

local SodacheRelicView = class("SodacheRelicView", BaseView)

function SodacheRelicView:onInitView()
	self._scrollCard = gohelper.findChildScrollRect(self.viewGO, "#scroll_Card")
	self._goRelicItem = gohelper.findChild(self.viewGO, "#scroll_Card/Viewport/Content/#go_RelicItem")
	self._goRareBtns = gohelper.findChild(self.viewGO, "#go_RareBtns")
	self._btnViewAll = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ViewAll")
	self._btnOneKeyUp = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_OneKeyUp")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheRelicView:addEvents()
	self._btnViewAll:AddClickListener(self._btnViewAllOnClick, self)
	self._btnOneKeyUp:AddClickListener(self._btnOneKeyUpOnClick, self)
end

function SodacheRelicView:removeEvents()
	self._btnViewAll:RemoveClickListener()
	self._btnOneKeyUp:RemoveClickListener()
end

local OneKeyUpBlock = "SodacheRelicViewBlock"

function SodacheRelicView:_btnOneKeyUpOnClick()
	if self.firstUpMo then
		if self.quality ~= 0 then
			self:_btnQualityOnClick(0)
		end

		GameUtil.setActiveUIBlock(OneKeyUpBlock, true, false)

		local upIndex = SodacheRelicMoListModel.instance:getIndex(self.firstUpMo) or 1

		self._listExtend:moveTo(upIndex, true, -self.scrollWidth / 2)
		TaskDispatcher.runDelay(self.delayOneKeyUp, self, 0.2)
	end
end

function SodacheRelicView:delayOneKeyUp()
	SodacheOutsideRpc.instance:sendSodacheRelicOneKeyUpgrade()
	GameUtil.setActiveUIBlock(OneKeyUpBlock, false, true)
end

function SodacheRelicView:_btnViewAllOnClick()
	ViewMgr.instance:openView(ViewName.SodacheRelicOverView)
end

function SodacheRelicView:_btnQualityOnClick(quality)
	if self.quality == quality then
		return
	end

	self.quality = quality

	for key, item in pairs(self.tabItemMap) do
		gohelper.setActive(item.goUnSelecte, key ~= self.quality)
		gohelper.setActive(item.goSelect, key == self.quality)
	end

	SodacheRelicMoListModel.instance:setData(self.quality)
end

function SodacheRelicView:_editableInitView()
	self._listExtend = self.viewContainer.scrollView
	self.tabItemMap = {}

	local qualityTbl = {
		0,
		4,
		5,
		6
	}

	for _, quality in ipairs(qualityTbl) do
		local item = self:getUserDataTb_()
		local go = gohelper.findChild(self._goRareBtns, "Tab" .. quality)

		item.goUnSelecte = gohelper.findChild(go, "unselect")
		item.goSelect = gohelper.findChild(go, "selected")

		local btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

		self.addClickCb(self, btnClick, self._btnQualityOnClick, self, quality)

		self.tabItemMap[quality] = item
	end

	self.scrollWidth = recthelper.getWidth(self._scrollCard.transform)

	local goCoin = gohelper.findChild(self.viewGO, "#go_topright/currencyview")

	MonoHelper.addNoUpdateLuaComOnceToGo(goCoin, SodacheCurrencyComp, {
		bagType = SodacheEnum.BagType.Outside
	})
end

function SodacheRelicView:onOpen()
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnRelicUpgradeOneKey, self.refreshOneKeyUp, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnRelicUpgrade, self.refreshOneKeyUp, self)
	self:_btnQualityOnClick(0)
	self._scrollCard:AddOnValueChanged(self.onScrollMove, self)
	self:refreshOneKeyUp()

	if self.firstUpMo and (GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(37018)) then
		local upIndex = SodacheRelicMoListModel.instance:getIndex(self.firstUpMo) or 1

		self._listExtend:moveTo(upIndex, false, -self.scrollWidth / 2)
	end
end

function SodacheRelicView:onDestroyView()
	self._scrollCard:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self.delayOneKeyUp, self)

	if UIBlockMgr.instance:isKeyBlock(OneKeyUpBlock) then
		GameUtil.setActiveUIBlock(OneKeyUpBlock, false, true)
	end
end

function SodacheRelicView:onScrollMove()
	SodacheController.instance:dispatchEvent(SodacheEvent.OnRelicScrollMove)
end

function SodacheRelicView:refreshOneKeyUp()
	self.firstUpMo = SodacheUtil.checkOneKeyUpRelic()

	gohelper.setActive(self._btnOneKeyUp, self.firstUpMo)
end

return SodacheRelicView
