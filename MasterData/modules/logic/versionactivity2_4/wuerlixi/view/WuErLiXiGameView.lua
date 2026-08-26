-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiGameView.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameView", package.seeall)

local WuErLiXiGameView = class("WuErLiXiGameView", BaseView)

function WuErLiXiGameView:onInitView()
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._goimgbg1 = gohelper.findChild(self.viewGO, "#simage_FullBG1")
	self._bgClick = gohelper.getClick(self._goimgbg1)
	self._goimgbg2 = gohelper.findChild(self.viewGO, "#simage_FullBG2")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gotarget = gohelper.findChild(self.viewGO, "#go_Target")
	self._goright = gohelper.findChild(self.viewGO, "#go_Right")
	self._gosuccessright = gohelper.findChild(self.viewGO, "#go_SuccessRight")
	self._goclick = gohelper.findChild(self.viewGO, "#go_SuccessRight/Click")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_Success")
	self._closeClick = gohelper.getClick(self._goclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WuErLiXiGameView:addEvents()
	self._bgClick:AddClickListener(self._onBgClick, self)
	self._closeClick:AddClickListener(self._onCloseClick, self)
end

function WuErLiXiGameView:removeEvents()
	self._bgClick:RemoveClickListener()
	self._closeClick:RemoveClickListener()
end

function WuErLiXiGameView:_editableInitView()
	self:_addEvents()
end

function WuErLiXiGameView:_onBgClick()
	WuErLiXiMapModel.instance:clearSelectUnit()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeClicked)
end

function WuErLiXiGameView:_onCloseClick()
	if self._gameSuccess then
		if self.viewParam.callback then
			self.viewParam.callback(self.viewParam.callbackObj)
		end

		WuErLiXiMapModel.instance:resetMap(self._mapId)
	end

	TaskDispatcher.runDelay(self.closeThis, self, 0.5)
end

function WuErLiXiGameView:_addEvents()
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.MapConnectSuccess, self._onGameSuccess, self)
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, self._onMapReset, self)
end

function WuErLiXiGameView:_removeEvents()
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.MapConnectSuccess, self._onGameSuccess, self)
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, self._onMapReset, self)
end

function WuErLiXiGameView:_onGameSuccess()
	self._gameSuccess = true

	gohelper.setActive(self._gotopleft, false)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_success)
	self._anim:Play("success", 0, 0)
	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(self._mapId),
		[StatEnum.EventProperties.OperationType] = "success",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "success",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
end

function WuErLiXiGameView:_onMapReset()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)
	self._anim:Play("reset", 0, 0)
end

function WuErLiXiGameView:onOpen()
	WuErLiXiMapModel.instance:setMapStartTime()
	WuErLiXiMapModel.instance:clearOperations()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)

	self._actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	self._mapId = WuErLiXiConfig.instance:getEpisodeCo(self._actId, self.viewParam.episodeId).mapId

	WuErLiXiMapModel.instance:setCurMapId(self._mapId)

	self._mapMo = WuErLiXiMapModel.instance:getMap(self._mapId)
end

function WuErLiXiGameView:onClose()
	WuErLiXiMapModel.instance:clearSelectUnit()
end

function WuErLiXiGameView:onDestroyView()
	TaskDispatcher.cancelTask(self._successShowEnd, self)
	self:_removeEvents()
end

return WuErLiXiGameView
