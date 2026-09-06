-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/RewardselectOnceView.lua

module("logic.extensions.itembag.view.RewardselectOnceView", package.seeall)

local RewardselectOnceView = class("RewardselectOnceView", ViewComponent)

function RewardselectOnceView:ctor()
	RewardselectOnceView.super.ctor(self)
end

function RewardselectOnceView:buildUI()
	RewardselectOnceView.super.buildUI(self)

	self._txtTip = self:getTxt("txtTip")
	self.txtTitle = self:getTxt("txtTitle")
	self.btnClose = self:getGo("btnClose")
	self.btnSure = self:getGo("btnSure")

	local cell = self:getGo("cell")
	local scroll = self:getGo("ScrollView")

	self.scrollGo = goutil.findChildComponent(self.mainGO, "ScrollView", "ScrollRect")
	self.scrollList = ScrollerList.create(scroll, cell, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearCell, self))
end

function RewardselectOnceView:bindEvents()
	RewardselectOnceView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self._onClickSure, self)
end

function RewardselectOnceView:unbindEvents()
	RewardselectOnceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
end

function RewardselectOnceView:destroyUI()
	RewardselectOnceView.super.destroyUI(self)
end

function RewardselectOnceView:onEnter()
	RewardselectOnceView.super.onEnter(self)

	self.selectItem = nil
	self._itemData = self._viewPresentor._openParam[1]

	local cfg = self._viewPresentor._openParam[2]

	self.txtTitle.text = lang("奖励选择")

	if cfg and not string.nilorempty(cfg.title) then
		self.txtTitle.text = cfg.title
	end

	self._txtTip.text = ""

	self.scrollList:regReloadFinish(GameUtil.handler(self.reloadEnd, self))
	GlobalDispatcher:addListener(GlobalNotify.OnMixOnceInfo, self.refreshUI, self)
	MaterialAgent.instance:sendGetMixSelectOnceInfoReq(self._itemData.type, self._itemData.id)
	self:refreshUI()
end

function RewardselectOnceView:onEnterFinished()
	RewardselectOnceView.super.onEnterFinished(self)
end

function RewardselectOnceView:onExit()
	RewardselectOnceView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.OnMixOnceInfo, self.refreshUI, self)
end

function RewardselectOnceView:onExitFinished()
	RewardselectOnceView.super.onExitFinished(self)
end

function RewardselectOnceView:refreshUI()
	local cfg = MaterialConfig.instance:getCfgByMatAndId(self._itemData.type, self._itemData.id)
	local content = cfg.content
	local arr = string.split(content, ";")

	self.scrollList:reloadData(arr)

	local len = #arr

	self.scrollGo:GetComponent("RectTransform").sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)
	self.scrollGo.viewport.sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)

	GameUtil.setAnchoredPos(self.scrollGo, 0, 0)
end

function RewardselectOnceView:reloadEnd()
	return
end

function RewardselectOnceView:_onValueChanged(strNum)
	local num = checknumber(strNum)

	num = Mathf.Clamp(num, 1, self._itemData.num)

	self.InputField:SetText(tostring(num))
end

function RewardselectOnceView:clearCell(cell)
	local con = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(cell)
end

function RewardselectOnceView:updateCell(view, cell, data)
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local txtHaveCount = goutil.findChildTextComponent(cell, "txtHaveCount")
	local item = goutil.findChild(cell, "item")
	local imgHasGet = goutil.findChild(cell, "imgHasGet")
	local isHasGet = MaterialModel.instance:checkHasMixSelectContent(self._itemData.type, self._itemData.id, data)

	GameUtil.SetActive(imgHasGet, isHasGet)
	GameUtil.SetActive(imgSelect, self.selectItem == data)
	MaterialMgr.setCellByCfg(data, item)

	local arr = string.split(data, ":")
	local matType = checknumber(arr[1])
	local cfgId = checknumber(arr[2])

	txtName.text = MaterialMgr.getMaterialsName(matType, cfgId)

	local len = math.max(3, #arr)
	local num = checknumber(arr[len])

	txtCount.text = "x" .. num
	txtHaveCount.text = langPara("item_have", MaterialMgr.getMatCount(data))

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onItemClick, self, data))
end

function RewardselectOnceView:onItemClick(data)
	local isHasGet = MaterialModel.instance:checkHasMixSelectContent(self._itemData.type, self._itemData.id, data)

	if isHasGet then
		TipsFacade.instance:openCommonTips(lang("当前物品已经获得"))
	else
		self.selectItem = data

		self.scrollList:refresh()
	end
end

function RewardselectOnceView:_onClickM10()
	self:_changeNumText(-10)
end

function RewardselectOnceView:_onClickMinus()
	self:_changeNumText(-1)
end

function RewardselectOnceView:_onClickAdd()
	self:_changeNumText(1)
end

function RewardselectOnceView:_onClickA10()
	self:_changeNumText(10)
end

function RewardselectOnceView:_onClickMax()
	self:_changeNumText(self._itemData.num)
end

function RewardselectOnceView:_changeNumText(delta)
	local num = checknumber(self.InputField:GetText()) + delta

	num = Mathf.Clamp(num, 1, self._itemData.num)

	self.InputField:SetText(tostring(num))
end

function RewardselectOnceView:_onClickSure()
	if not string.nilorempty(self.selectItem) then
		local boo = ItemBagController.instance:checkItemChangeWhenGet(self.selectItem, GameUtil.handler(self.sendMsg, self))

		if boo then
			return
		end

		local name1 = MaterialMgr.getMaterialsName(self._itemData.type, self._itemData.id)
		local num1 = 1
		local arr = string.split(self.selectItem, ":")
		local matType = checknumber(arr[1])
		local cfgId = checknumber(arr[2])
		local num2 = checknumber(arr[#arr])
		local name2 = MaterialMgr.getMaterialsName(matType, cfgId)
		local itemStr = MaterialMgr.createSerName(self._itemData.type, self._itemData.id)
		local itemStr = MaterialMgr.createSerName(matType, cfgId)

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("消耗%s个%s兑换成%s个%s?", num1, name1, num2, name2), GameUtil.handler(self.sendMsg, self))
	else
		TipsFacade.instance:openCommonTips(lang("请先选择一项物品"))
	end
end

function RewardselectOnceView:sendMsg()
	if not string.nilorempty(self.selectItem) then
		local num = 1
		local obj = {}

		obj.itemMap = {}
		obj.itemMap[self.selectItem] = num

		MaterialFacade.instance:useItem(self._itemData.type, self._itemData.id, num, GameUtil.jsonToString(obj), GameUtil.handler(self.close, self))
	end
end

return RewardselectOnceView
