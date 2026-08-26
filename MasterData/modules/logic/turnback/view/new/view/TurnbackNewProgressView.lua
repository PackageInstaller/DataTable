-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewProgressView.lua

module("modules.logic.turnback.view.new.view.TurnbackNewProgressView", package.seeall)

local TurnbackNewProgressView = class("TurnbackNewProgressView", BaseView)

function TurnbackNewProgressView:onInitView()
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "bg/content/#btn_refresh")
	self._txtrefresh = gohelper.findChildText(self.viewGO, "bg/content/#btn_refresh/txt_refresh")
	self._gocontent = gohelper.findChild(self.viewGO, "bg/content")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "bg/content/item1/#simage_pic")
	self._canRefresh = true
	self._refreshCd = TurnbackEnum.RefreshCd
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackNewProgressView:addEvents()
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.refreshItemBySelf, self)
end

function TurnbackNewProgressView:removeEvents()
	self._btnrefresh:RemoveClickListener()
end

function TurnbackNewProgressView:_btnrefreshOnClick()
	if not self._taskcd and self._canRefresh then
		self._animator:Update(0)
		self._animator:Play("update")
		TaskDispatcher.runDelay(self._afteranim, self, 0.16)
	else
		GameFacade.showToast(ToastEnum.TurnbackNewProgressViewRefresh)
	end
end

function TurnbackNewProgressView:_afteranim()
	TaskDispatcher.cancelTask(self._afteranim, self)

	self._canRefresh = false

	self:refreshProgressItem()

	self._txtrefresh.text = self._refreshCd .. "s"
	self._taskcd = TaskDispatcher.runRepeat(self._ontimeout, self, 1)
end

function TurnbackNewProgressView:_ontimeout()
	self._refreshCd = self._refreshCd - 1

	if self._refreshCd > 0 then
		self._txtrefresh.text = self._refreshCd .. "s"
	else
		TaskDispatcher.cancelTask(self._ontimeout, self)

		self._txtrefresh.text = luaLang("p_turnbacknewprogressview_txt_refresh")
		self._canRefresh = true
		self._taskcd = nil
		self._refreshCd = TurnbackEnum.RefreshCd
	end
end

function TurnbackNewProgressView:_editableInitView()
	self._txtrefresh.text = luaLang("p_turnbacknewprogressview_txt_refresh")
end

function TurnbackNewProgressView:onUpdateParam()
	return
end

function TurnbackNewProgressView:onCurrencyChange()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	self:refreshItemBySelf()
end

function TurnbackNewProgressView:refreshItemBySelf()
	for _, item in ipairs(self._progressItems) do
		item.cls:refreshItemBySelf()
	end
end

function TurnbackNewProgressView:refreshProgressItem()
	local level2list, level3list = TurnbackModel.instance:getDropInfoList()
	local mainepisodemo = TurnbackModel.instance:getDropInfoByType(TurnbackEnum.DropInfoEnum.MainEpisode)
	local mainepisodeitem = self._progressItems[TurnbackEnum.DropInfoEnum.MainEpisode]

	mainepisodeitem.cls:refreshItem(mainepisodemo)

	for index, mo in ipairs(level2list) do
		local itemIndex = index + 2
		local item = self._progressItems[itemIndex]

		if item then
			item.cls:refreshItem(mo)
		end
	end

	local lastitem = self._progressItems[6]

	lastitem.cls:refreshItem(level3list[1])
end

function TurnbackNewProgressView:onOpen()
	local parentGO = self.viewParam.parent

	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	gohelper.addChild(parentGO, self.viewGO)

	self._progressItems = {}

	for index = 1, 6 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self._gocontent, "item" .. index)
		item.cls = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, TurnbackNewProgressItem)

		table.insert(self._progressItems, item)
		item.cls:initItem(index)
	end

	self:refreshProgressItem()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_03)
end

function TurnbackNewProgressView:onClose()
	TaskDispatcher.cancelTask(self._afteranim, self)
	TaskDispatcher.cancelTask(self._ontimeout, self)
end

function TurnbackNewProgressView:onDestroyView()
	TaskDispatcher.cancelTask(self._ontimeout, self)
end

return TurnbackNewProgressView
