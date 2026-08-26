-- chunkname: @modules/logic/fight/view/rouge/FightViewRougeMgr.lua

module("modules.logic.fight.view.rouge.FightViewRougeMgr", package.seeall)

local FightViewRougeMgr = class("FightViewRougeMgr", BaseViewExtended)

function FightViewRougeMgr:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewRougeMgr:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.ResonanceLevel, self._onResonanceLevel, self)
	self.addEventCb(self, FightController.instance, FightEvent.PolarizationLevel, self._onPolarizationLevel, self)
	self.addEventCb(self, FightController.instance, FightEvent.RougeCoinChange, self._onRougeCoinChange, self)
end

function FightViewRougeMgr:removeEvents()
	return
end

function FightViewRougeMgr:_editableInitView()
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	self._isRouge = episode_config and episode_config.type == DungeonEnum.EpisodeType.Rouge

	if self._isRouge then
		self:_addCollectionBtn()
	end
end

function FightViewRougeMgr:_addCollectionBtn()
	local topRightBtnRoot = gohelper.findChild(self.viewGO, "root/btns")
	local url = "ui/viewres/rouge/fight/rougebtnview.prefab"

	self._loader = PrefabInstantiate.Create(topRightBtnRoot)

	self._loader:startLoad(url, self._onLoaded, self)
end

function FightViewRougeMgr:_onLoaded()
	local btnGo = self._loader:getInstGO()

	gohelper.setAsFirstSibling(btnGo)

	self._btnCollection = gohelper.findChildButtonWithAudio(btnGo, "")

	self._btnCollection:AddClickListener(self._onClickCollection, self)
end

function FightViewRougeMgr:_onClickCollection()
	RougeController.instance:openRougeCollectionOverView()
end

function FightViewRougeMgr:onRefreshViewParam()
	return
end

function FightViewRougeMgr:openRougeCoinView()
	if self.rougeCoinView then
		return
	end

	local goContainer = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.RougeCoin)

	self.rougeCoinView = self:openSubView(FightViewRougeCoin, "ui/viewres/rouge/fight/rougecoin.prefab", goContainer)
end

function FightViewRougeMgr:openRougeGongMingView()
	if self.rougeGongMingView then
		return
	end

	local goContainer = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.RougeGongMing)

	self.rougeGongMingView = self:openSubView(FightViewRougeGongMing, "ui/viewres/rouge/fight/rougegongming.prefab", goContainer)
end

function FightViewRougeMgr:openRougeTongPinView()
	if self.rougeTongPinView then
		return
	end

	local goContainer = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.RougeTongPin)

	self.rougeTongPinView = self:openSubView(FightViewRougeTongPin, "ui/viewres/rouge/fight/rougetongpin.prefab", goContainer)
end

function FightViewRougeMgr:openRougeTipDescView()
	if self.rougeTipDescView then
		return
	end

	self.rougeTipDescView = self:openSubView(FightViewRougeDescTip, "ui/viewres/rouge/fight/rougedesctip.prefab", self.viewGO)
end

function FightViewRougeMgr:_onResonanceLevel(resonancelLevel)
	self:_openSubViewRight()
end

function FightViewRougeMgr:_onPolarizationLevel(polarizationLevel)
	self:_openSubViewRight()
end

function FightViewRougeMgr:_onRougeCoinChange()
	self:_openSubViewRight()
end

function FightViewRougeMgr:_openSubViewRight()
	self:openRougeCoinView()
	self:openRougeTongPinView()
	self:openRougeGongMingView()
	self:openRougeTipDescView()
end

function FightViewRougeMgr:onOpen()
	if self._isRouge then
		self:_openSubViewRight()
	end
end

function FightViewRougeMgr:onClose()
	ViewMgr.instance:closeView(ViewName.RougeCollectionOverView)
end

function FightViewRougeMgr:onDestroyView()
	if self._btnCollection then
		self._btnCollection:RemoveClickListener()
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return FightViewRougeMgr
