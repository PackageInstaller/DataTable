-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/RewardselectcommonView.lua

module("logic.extensions.itembag.view.RewardselectcommonView", package.seeall)

local RewardselectcommonView = class("RewardselectcommonView", ViewComponent)

function RewardselectcommonView:ctor()
	RewardselectcommonView.super.ctor(self)
end

function RewardselectcommonView:buildUI()
	RewardselectcommonView.super.buildUI(self)

	self._txtTip = self:getTxt("txtTip")
	self.txtTitle = self:getTxt("txtTitle")
	self.btnClose = self:getGo("btnClose")
	self.btnSure = self:getGo("btnSure")

	local cell = self:getGo("cell")
	local scroll = self:getGo("ScrollView")

	self.scrollGo = goutil.findChildComponent(self.mainGO, "ScrollView", "ScrollRect")
	self.scrollList = ScrollerList.create(scroll, cell, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearCell, self))
end

function RewardselectcommonView:bindEvents()
	RewardselectcommonView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self._onClickSure, self)
end

function RewardselectcommonView:unbindEvents()
	RewardselectcommonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
end

function RewardselectcommonView:destroyUI()
	RewardselectcommonView.super.destroyUI(self)
end

function RewardselectcommonView:onEnter()
	RewardselectcommonView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._itemStrList = params[1] or {}
	self._callBack = params[2]

	local content = params[3]
	local title = params[4]

	self.selectIndex = 0
	self._txtTip.text = ""
	self.txtTitle.text = lang("奖励选择")

	if not string.nilorempty(content) then
		self._txtTip.text = content
	end

	if not string.nilorempty(title) then
		self.txtTitle.text = title
	end

	self.scrollList:regReloadFinish(GameUtil.handler(self.reloadEnd, self))
	self:refreshUI()
end

function RewardselectcommonView:onEnterFinished()
	RewardselectcommonView.super.onEnterFinished(self)
end

function RewardselectcommonView:onExit()
	RewardselectcommonView.super.onExit(self)
	self.scrollList:dispose()
end

function RewardselectcommonView:onExitFinished()
	RewardselectcommonView.super.onExitFinished(self)
end

function RewardselectcommonView:refreshUI()
	self.scrollList:reloadData(self._itemStrList)

	local len = #self._itemStrList

	self.scrollGo:GetComponent("RectTransform").sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)
	self.scrollGo.viewport.sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)

	GameUtil.setAnchoredPos(self.scrollGo, 0, 0)
end

function RewardselectcommonView:reloadEnd()
	return
end

function RewardselectcommonView:clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(cell)
end

function RewardselectcommonView:updateCell(view, cell, data)
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local txtHaveCount = goutil.findChildTextComponent(cell, "txtHaveCount")
	local item = goutil.findChild(cell, "item")
	local imgHasGet = goutil.findChild(cell, "imgHasGet")

	GameUtil.SetActive(imgHasGet, false)
	GameUtil.SetActive(imgSelect, self.selectIndex == cell.data)
	MaterialMgr.setCellByCfg(data, item)

	local matType, cfgId, num = MaterialMgr.getMatParams(data)

	txtName.text = MaterialMgr.getMaterialsName(matType, cfgId)
	txtCount.text = ""

	if checknumber(num) > 0 then
		txtCount.text = "x" .. num
	end

	txtHaveCount.text = langPara("item_have", MaterialMgr.getMatCount(data))

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onItemClick, self, cell.data))
end

function RewardselectcommonView:onItemClick(data)
	self.selectIndex = data

	self.scrollList:refresh()
end

function RewardselectcommonView:_onClickSure()
	if self.selectIndex > 0 then
		local selectItem = self._itemStrList[self.selectIndex]
		local boo = ItemBagController.instance:checkItemChangeWhenGet(selectItem, GameUtil.handler(self.sendMsg, self, self.selectIndex))

		if boo then
			return
		end

		local matType, cfgId, num = MaterialMgr.getMatParams(selectItem)
		local name = MaterialMgr.getMaterialsName(matType, cfgId)

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("确定要选择%s个%s吗?", num, name), GameUtil.handler(self.sendMsg, self, self.selectIndex))
	else
		TipsFacade.instance:openCommonTips(lang("请先选择一项物品"))
	end
end

function RewardselectcommonView:sendMsg(selectIndex)
	GameUtil.callBack(self._callBack, selectIndex)
	self:close()
end

return RewardselectcommonView
