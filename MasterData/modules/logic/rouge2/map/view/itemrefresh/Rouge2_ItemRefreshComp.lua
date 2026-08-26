-- chunkname: @modules/logic/rouge2/map/view/itemrefresh/Rouge2_ItemRefreshComp.lua

module("modules.logic.rouge2.map.view.itemrefresh.Rouge2_ItemRefreshComp", package.seeall)

local Rouge2_ItemRefreshComp = class("Rouge2_ItemRefreshComp", LuaCompBase)

function Rouge2_ItemRefreshComp:init(go)
	self.go = go
	self._btnRefresh = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#btn_Refresh", AudioEnum.Rouge2.RefreshDropItem)
	self._goActive = gohelper.findChild(self.go, "#go_Root/#btn_Refresh/#go_Active")
	self._goDisactive = gohelper.findChild(self.go, "#go_Root/#btn_Refresh/#go_Disactive")
	self._txtRefreshCost = gohelper.findChildText(self.go, "#go_Root/#txt_RefreshCost")
	self._txtCurRevivalCoin = gohelper.findChildText(self.go, "#go_Root/#txt_CurRevivalCoin")

	gohelper.setActive(self.go, false)
end

function Rouge2_ItemRefreshComp:addEventListeners()
	self._btnRefresh:AddClickListener(self._btnRefreshOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRevivalCoin, self._onUpdateMapInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateMapInfo, self)
end

function Rouge2_ItemRefreshComp:removeEventListeners()
	self._btnRefresh:RemoveClickListener()
end

function Rouge2_ItemRefreshComp:_btnRefreshOnClick()
	if not self._visible then
		return
	end

	if not self._canRefresh then
		GameFacade.showToast(ToastEnum.Rouge2CantRefreshDrop)

		return
	end

	self._recordDropType, self._recordItemList = self:getDropItemList()
	self._cbId = Rouge2_Rpc.instance:sendRouge2RefreshDropRequest(self._sendRpcCallback, self)
end

function Rouge2_ItemRefreshComp:_sendRpcCallback(_, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if self._refreshCb then
		local dropType, dropList = self:getDropItemList()

		Rouge2_StatController.instance:statDropRefresh(dropType, Rouge2_Enum.ItemDataType.Config, self._recordItemList, dropList)
		self._refreshCb(self._refreshCbObj, dropList, self)
	end
end

function Rouge2_ItemRefreshComp:getDropItemList()
	local curInteract = Rouge2_MapModel.instance:getCurInteractiveJson()
	local dropList = curInteract and curInteract.dropCollectList
	local dropType = curInteract and curInteract.dropType

	return dropType, dropList
end

function Rouge2_ItemRefreshComp:removeRpcCb()
	if self._cbId then
		Rouge2_Rpc.instance:removeCallbackById(self._cbId)

		self._cbId = nil
	end
end

function Rouge2_ItemRefreshComp:initRefreshCallback(callback, callbackObj)
	self._refreshCb = callback
	self._refreshCbObj = callbackObj
end

function Rouge2_ItemRefreshComp:refresh()
	gohelper.setActive(self.go, self._visible)

	if not self._visible then
		self:removeRpcCb()

		return
	end

	local curInteract = Rouge2_MapModel.instance:getCurInteractiveJson()
	local dropType = curInteract and curInteract.dropType

	if curInteract then
		if not curInteract.refreshDropNum then
			local refreshNum = 0
			local refreshCost = Rouge2_MapConfig.instance:getItemRefreshCost(dropType, refreshNum + 1)
			local showRefreshOp = refreshCost and refreshCost >= 0

			gohelper.setActive(self.go, showRefreshOp)

			if not showRefreshOp then
				return
			end

			local revivalCoin = Rouge2_Model.instance:getRevivalCoin() or 0

			self._canRefresh = refreshCost <= revivalCoin
			self._txtRefreshCost.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_itemrefreshview_refreshcost"), refreshCost)
			self._txtCurRevivalCoin.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_iremrefreshcomp_currevivalcoin"), revivalCoin)

			gohelper.setActive(self._goActive, self._canRefresh)
			gohelper.setActive(self._goDisactive, not self._canRefresh)
		end
	end
end

function Rouge2_ItemRefreshComp:show(visible)
	self._visible = visible

	self:refresh()
end

function Rouge2_ItemRefreshComp:_onUpdateMapInfo()
	self:refresh()
end

function Rouge2_ItemRefreshComp:onDestroy()
	self._refreshCb = nil
	self._refreshCbObj = nil

	self:removeRpcCb()
end

return Rouge2_ItemRefreshComp
