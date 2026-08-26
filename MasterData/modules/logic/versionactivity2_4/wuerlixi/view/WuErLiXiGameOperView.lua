-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiGameOperView.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameOperView", package.seeall)

local WuErLiXiGameOperView = class("WuErLiXiGameOperView", BaseView)

function WuErLiXiGameOperView:onInitView()
	self._gotarget = gohelper.findChild(self.viewGO, "#go_Target")
	self._goright = gohelper.findChild(self.viewGO, "#go_Right")
	self._goactunitroot = gohelper.findChild(self.viewGO, "#go_Right/ActUnits")
	self._goactunits = gohelper.findChild(self.viewGO, "#go_Right/ActUnits/#go_actunits")
	self._goactunititem = gohelper.findChild(self.viewGO, "#go_Right/ActUnits/#go_actunits/#go_actunititem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_Right/Btns")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Right/Btns/#btn_reset")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Right/Btns/#btn_skip")
	self._btnunittips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Right/Btns/#btn_unittips")
	self._gounittipnew = gohelper.findChild(self.viewGO, "#go_Right/Btns/#btn_unittips/#go_new")
	self._godragitem = gohelper.findChild(self.viewGO, "#go_dragitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WuErLiXiGameOperView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btnunittips:AddClickListener(self._btnunittipsOnClick, self)
end

function WuErLiXiGameOperView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btnskip:RemoveClickListener()
	self._btnunittips:RemoveClickListener()
end

function WuErLiXiGameOperView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.WuErLiXiResetConfirm, MsgBoxEnum.BoxType.Yes_No, self._onChooseReset, nil, nil, self)
end

function WuErLiXiGameOperView:_onChooseReset()
	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(self._mapId),
		[StatEnum.EventProperties.OperationType] = "reset",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "unsuccess",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
	WuErLiXiMapModel.instance:resetMap(self._mapId)
	WuErLiXiMapModel.instance:clearSelectUnit()
	self:_onMapReset()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.MapResetClicked)
end

function WuErLiXiGameOperView:_btnskipOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.WuErLiXiSkipConfirm, MsgBoxEnum.BoxType.Yes_No, self._onChooseClose, nil, nil, self)
end

function WuErLiXiGameOperView:_onChooseClose()
	if self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end

	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(self._mapId),
		[StatEnum.EventProperties.OperationType] = "skip",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "unsuccess",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
	self:closeThis()
end

function WuErLiXiGameOperView:_btnunittipsOnClick()
	WuErLiXiMapModel.instance:setReadNewElement()
	ViewMgr.instance:openView(ViewName.WuErLiXiUnitTipView)
	self:_refreshBtns()
end

function WuErLiXiGameOperView:_editableInitView()
	self:_addEvents()
end

function WuErLiXiGameOperView:_addEvents()
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaced, self._onNodeChange, self)
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaceBack, self._onNodeChange, self)
end

function WuErLiXiGameOperView:_removeEvents()
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaced, self._onNodeChange, self)
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaceBack, self._onNodeChange, self)
end

function WuErLiXiGameOperView:_onNodeChange()
	self:_refreshActUnits()
end

function WuErLiXiGameOperView:_onMapReset()
	self:_refreshActUnits()
end

function WuErLiXiGameOperView:onOpen()
	self._actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	self._mapId = WuErLiXiConfig.instance:getEpisodeCo(self._actId, self.viewParam.episodeId).mapId
	self._mapMo = WuErLiXiMapModel.instance:getMap(self._mapId)
	self._actUnitItems = {}

	self:_refreshBtns()
	self:_refreshActUnits()
end

function WuErLiXiGameOperView:_refreshBtns()
	local isPass = WuErLiXiModel.instance:isEpisodePass(self.viewParam.episodeId)
	local status = WuErLiXiModel.instance:getEpisodeStatus(self.viewParam.episodeId)
	local skipUnlock = isPass or status == WuErLiXiEnum.EpisodeStatus.AfterStory or status == WuErLiXiEnum.EpisodeStatus.Finished

	gohelper.setActive(self._btnskip.gameObject, skipUnlock)

	local hasNew = WuErLiXiMapModel.instance:hasElementNew()

	gohelper.setActive(self._gounittipnew, hasNew)
end

function WuErLiXiGameOperView:_refreshActUnits()
	local existItems = {}
	local limitUnits = WuErLiXiMapModel.instance:getMapLimitActUnits(self._mapId)

	for _, unit in ipairs(limitUnits) do
		if not self._actUnitItems[unit.id] then
			local go = gohelper.cloneInPlace(self._goactunititem)

			self._actUnitItems[unit.id] = WuErLiXiGameActUnitItem.New()

			self._actUnitItems[unit.id]:init(go, self._godragitem)
			self._actUnitItems[unit.id]:setItem(unit)
		else
			self._actUnitItems[unit.id]:resetItem()
		end

		existItems[unit.id] = true
	end

	for unitId, item in pairs(self._actUnitItems) do
		if not existItems[unitId] then
			item:hide()
		end
	end
end

function WuErLiXiGameOperView:onClose()
	return
end

function WuErLiXiGameOperView:onDestroyView()
	self:_removeEvents()

	for _, v in pairs(self._actUnitItems) do
		v:destroy()
	end
end

return WuErLiXiGameOperView
