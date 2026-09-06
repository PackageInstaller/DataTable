-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilSelectView.lua

module("logic.extensions.destroyevil.view.DestroyEvilSelectView", package.seeall)

local DestroyEvilSelectView = class("DestroyEvilSelectView", ViewComponent)

function DestroyEvilSelectView:ctor()
	DestroyEvilSelectView.super.ctor(self)
end

function DestroyEvilSelectView:buildUI()
	DestroyEvilSelectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")

	local cell = self:getGo("cell")
	local scroll = self:getGo("ScrollView")

	self.scrollGo = goutil.findChildComponent(self.mainGO, "ScrollView", "ScrollRect")
	self.scrollList = ScrollerList.create(scroll, cell, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearCell, self))
	self._empty = self:getGo("empty")
	self._txtTip = self:getTxt("txtTip")
	self._btnToggle = self:getBtn("btnToggle")
	self._toggleMark = self:getGo("btnToggle/Background/Checkmark")
end

function DestroyEvilSelectView:bindEvents()
	DestroyEvilSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickToggle, self)
end

function DestroyEvilSelectView:unbindEvents()
	DestroyEvilSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnToggle)
end

function DestroyEvilSelectView:onEnter()
	DestroyEvilSelectView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local ticketId = DestroyEvilController.instance:getSelectTicketId(self._activityId)

	ticketId = ticketId > 0 and ticketId or 1
	self.selectItem = DestroyEvilConfig.instance:getTicket(self._activityId, ticketId)

	self:refreshUI()

	self._isToggleAutoCost = DestroyEvilController.instance:getAutoCostTicket(self._activityId)

	self:_updateBtnToggle()
	self:_setTips()
end

function DestroyEvilSelectView:onExit()
	DestroyEvilSelectView.super.onExit(self)
	self.scrollList:dispose()
	DestroyEvilController.instance:saveSelectTicketId(self._activityId, self.selectItem.ticketId)
	DestroyEvilController.instance:saveAutoCostTicket(self._activityId, self._isToggleAutoCost)
end

function DestroyEvilSelectView:refreshUI()
	local cfgs = DestroyEvilConfig.instance:getTicketsList(self._activityId)
	local list = {}

	for i, v in ipairs(cfgs) do
		local count = MaterialMgr.getMatCount(v.itemKey)

		table.insert(list, v)
	end

	self.scrollList:reloadData(list)

	local len = #list

	self.scrollGo:GetComponent("RectTransform").sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)
	self.scrollGo.viewport.sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)

	GameUtil.setAnchoredPos(self.scrollGo, 0, 50)
	GameUtil.SetActive(self._empty, len <= 0)
end

function DestroyEvilSelectView:updateCell(view, cell, data)
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local txtHaveCount = goutil.findChildTextComponent(cell, "txtHaveCount")
	local item = goutil.findChild(cell, "item")

	GameUtil.SetActive(imgSelect, self.selectItem == data)
	MaterialMgr.setCellByCfg(data.itemKey, item)

	local arr = string.split(data.itemKey, ":")
	local matType = checknumber(arr[1])
	local cfgId = checknumber(arr[2])

	txtName.text = MaterialMgr.getMaterialsName(matType, cfgId)

	local arr = string.split(data.itemKey, ":")
	local len = math.max(3, #arr)
	local num = checknumber(arr[len])

	txtCount.text = ""

	local mountId = MountConfig.instance:getMountInMap(matType, cfgId)

	txtHaveCount.text = mountId ~= nil and MountModel.instance:getLockmountsById(mountId) ~= false and langPara("item_have", MaterialMgr.getMatCount(data.itemKey) + 1) or langPara("item_have", MaterialMgr.getMatCount(data.itemKey))

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onItemClick, self, data))
end

function DestroyEvilSelectView:clearCell(cell)
	local con = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(cell)
end

function DestroyEvilSelectView:onItemClick(data)
	self.selectItem = data

	self.scrollList:refresh()
end

function DestroyEvilSelectView:_onClickSure()
	if self.selectItem then
		local count = MaterialMgr.getMatCount(self.selectItem.itemKey)

		if count <= 0 then
			TipsFacade.instance:openCommonTips(lang("当前物品数量不足"))

			return
		end

		local key = "destroyevilselectview_select"

		if not GameUtil.getUserDayData(key) then
			local function funcTog()
				GameUtil.saveUserDayData(key, true)
			end

			local togText = lang("今日不再提示")

			TipsFacade.instance:openPopupWindowWithTog(lang("tip"), lang("使用道具后将刷新当前恶敌信息 是否继续"), function()
				DestroyEvilAgent.instance:sendPM_DestroyEvilRefreshMonsterReq(self._activityId, self.selectItem.ticketId)
				self:close()
			end, function()
				return
			end, funcTog, nil, nil, togText)
		else
			DestroyEvilAgent.instance:sendPM_DestroyEvilRefreshMonsterReq(self._activityId, self.selectItem.ticketId)
			self:close()
		end
	else
		TipsFacade.instance:openCommonTips(lang("请先选择一项物品"))
	end
end

function DestroyEvilSelectView:_onClickToggle()
	self._isToggleAutoCost = not self._isToggleAutoCost

	printInfo("test DestroyEvilSelectView:_onClickToggle", self._isToggleAutoCost)
	self:_updateBtnToggle()
end

function DestroyEvilSelectView:_updateBtnToggle()
	goutil.setActive(self._toggleMark, self._isToggleAutoCost)
end

function DestroyEvilSelectView:_setTips()
	local cfgs = DestroyEvilConfig.instance:getTicketsList(self._activityId)
	local strLow = ""
	local strHigh = ""

	for i, v in ipairs(cfgs) do
		if v.ticketId == 1 then
			strLow = table.concat(v.difficultStar, "、")
		elseif v.ticketId == 2 then
			strHigh = table.concat(v.difficultStar, "、")
		end
	end

	self._txtTip.text = string.format("低级搜查令将刷新出%s星的恶敌，高级搜查令将刷新出%s星的恶敌", strLow, strHigh)
end

return DestroyEvilSelectView
