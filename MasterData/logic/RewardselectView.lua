-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/RewardselectView.lua

module("logic.extensions.itembag.view.RewardselectView", package.seeall)

local RewardselectView = class("RewardselectView", ViewComponent)

function RewardselectView:ctor()
	RewardselectView.super.ctor(self)
end

function RewardselectView:buildUI()
	RewardselectView.super.buildUI(self)

	self.txtTitle = self:getTxt("txtTitle")
	self.btnClose = self:getGo("btnClose")
	self.btnSure = self:getGo("btnSure")
	self.btnLessTen = self:getGo("chooseCount/btnLessTen")
	self.btnAddTen = self:getGo("chooseCount/btnAddTen")
	self.btnLess = self:getGo("chooseCount/btnLess")
	self.btnAdd = self:getGo("chooseCount/btnAdd")
	self.btnMax = self:getGo("chooseCount/btnMax")
	self.InputField = self:getInput("chooseCount/InputField")
	self.txtRemain = self:getTxt("chooseCount/txtRemain")

	local cell = self:getGo("cell")
	local scroll = self:getGo("ScrollView")

	self.scrollGo = goutil.findChildComponent(self.mainGO, "ScrollView", "ScrollRect")
	self.scrollList = ScrollerList.create(scroll, cell, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearCell, self))
	self.SearchInputField = self:getInput("SearchInputField")
	self._empty = self:getGo("empty")
end

function RewardselectView:bindEvents()
	RewardselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self.btnAddTen, self._onClickA10, self)
	GameUtil.addClickHandler(self.btnLess, self._onClickMinus, self)
	GameUtil.addClickHandler(self.btnLessTen, self._onClickM10, self)
	GameUtil.addClickHandler(self.btnMax, self._onClickMax, self)
	GameUtil.addClickHandler(self.btnSure, self._onClickSure, self)
	self.InputField:AddOnValueChanged(self._onValueChanged, self)
	self.SearchInputField:AddOnValueChanged(self._onSearchValueChanged, self)
end

function RewardselectView:unbindEvents()
	RewardselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnAdd)
	GameUtil.rmClickHandler(self.btnAddTen)
	GameUtil.rmClickHandler(self.btnLess)
	GameUtil.rmClickHandler(self.btnLessTen)
	GameUtil.rmClickHandler(self.btnMax)
	GameUtil.rmClickHandler(self.btnSure)
	self.InputField:RemoveOnValueChanged()
	self.SearchInputField:RemoveOnValueChanged()
end

function RewardselectView:destroyUI()
	RewardselectView.super.destroyUI(self)
end

function RewardselectView:onEnter()
	RewardselectView.super.onEnter(self)

	self.selectItem = nil
	self._itemData = self._viewPresentor._openParam[1]

	self.scrollList:regReloadFinish(GameUtil.handler(self.reloadEnd, self))
	self:refreshUI()

	local cfg = self._viewPresentor._openParam[2]

	self.txtTitle.text = lang("奖励选择")

	if cfg and not string.nilorempty(cfg.title) then
		self.txtTitle.text = cfg.title
	end
end

function RewardselectView:onEnterFinished()
	RewardselectView.super.onEnterFinished(self)
end

function RewardselectView:onExit()
	RewardselectView.super.onExit(self)
	self.scrollList:dispose()
end

function RewardselectView:onExitFinished()
	RewardselectView.super.onExitFinished(self)
end

function RewardselectView:refreshUI()
	local cfg = MaterialConfig.instance:getCfgByMatAndId(self._itemData.type, self._itemData.id)
	local content = cfg.content
	local arr = string.split(content, ";")
	local searchStr = self.SearchInputField:GetText()

	if not string.nilorempty(searchStr) then
		local result = {}

		for i, v in ipairs(arr) do
			if not string.nilorempty(v) then
				local matType, matId, matNum = MaterialMgr.getMatParams(v)
				local matName = MaterialMgr.getMaterialsName(matType, matId)
				local cfg = MaterialMgr.getMatCfg(matType, matId)

				if string.find(matName, searchStr) or not string.nilorempty(cfg.searchKey) and string.find(cfg.searchKey, searchStr) then
					table.insert(result, v)
				end
			end
		end

		arr = result
	end

	self.scrollList:reloadData(arr)

	local len = #arr

	self.scrollGo:GetComponent("RectTransform").sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)
	self.scrollGo.viewport.sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)

	GameUtil.setAnchoredPos(self.scrollGo, 0, 50)
	GameUtil.SetActive(self._empty, len <= 0)

	local cfg = MaterialMgr.getMatCfg(self._itemData.type, self._itemData.id)

	self.txtRemain.text = langPara("item_have", self._itemData.num)

	self.InputField:SetText(math.min(1, self._itemData.num))
end

function RewardselectView:reloadEnd()
	return
end

function RewardselectView:_onValueChanged(strNum)
	local num = checknumber(strNum)

	num = Mathf.Clamp(num, 1, self._itemData.num)

	self.InputField:SetText(tostring(num))
end

function RewardselectView:_onSearchValueChanged(searchStr)
	self:refreshUI()
end

function RewardselectView:clearCell(cell)
	local con = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(cell)
end

function RewardselectView:updateCell(view, cell, data)
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local txtHaveCount = goutil.findChildTextComponent(cell, "txtHaveCount")
	local item = goutil.findChild(cell, "item")

	GameUtil.SetActive(imgSelect, self.selectItem == data)
	MaterialMgr.setCellByCfg(data, item)

	local arr = string.split(data, ":")
	local matType = checknumber(arr[1])
	local cfgId = checknumber(arr[2])

	txtName.text = MaterialMgr.getMaterialsName(matType, cfgId)

	local arr = string.split(data, ":")
	local len = math.max(3, #arr)
	local num = checknumber(arr[len])

	txtCount.text = "x" .. num

	local mountId = MountConfig.instance:getMountInMap(matType, cfgId)

	txtHaveCount.text = mountId ~= nil and MountModel.instance:getLockmountsById(mountId) ~= false and langPara("item_have", MaterialMgr.getMatCount(data) + 1) or langPara("item_have", MaterialMgr.getMatCount(data))

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onItemClick, self, data))
end

function RewardselectView:onItemClick(data)
	self.selectItem = data

	self.scrollList:refresh()
end

function RewardselectView:_onClickM10()
	self:_changeNumText(-10)
end

function RewardselectView:_onClickMinus()
	self:_changeNumText(-1)
end

function RewardselectView:_onClickAdd()
	self:_changeNumText(1)
end

function RewardselectView:_onClickA10()
	self:_changeNumText(10)
end

function RewardselectView:_onClickMax()
	self:_changeNumText(self._itemData.num)
end

function RewardselectView:_changeNumText(delta)
	local num = checknumber(self.InputField:GetText()) + delta

	num = Mathf.Clamp(num, 1, self._itemData.num)

	self.InputField:SetText(tostring(num))
end

function RewardselectView:_onClickSure()
	if not string.nilorempty(self.selectItem) then
		local boo = ItemBagController.instance:checkItemChangeWhenGet(self.selectItem, GameUtil.handler(self.sendMsg, self))

		if boo then
			return
		end

		local name1 = MaterialMgr.getMaterialsName(self._itemData.type, self._itemData.id)
		local num1 = checknumber(self.InputField:GetText())
		local arr = string.split(self.selectItem, ":")
		local matType = checknumber(arr[1])
		local cfgId = checknumber(arr[2])
		local num2 = checknumber(arr[#arr])

		num2 = num2 * num1

		local name2 = MaterialMgr.getMaterialsName(matType, cfgId)
		local itemStr = MaterialMgr.createSerName(self._itemData.type, self._itemData.id)
		local itemStr = MaterialMgr.createSerName(matType, cfgId)

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("消耗%s个%s兑换成%s个%s?", num1, name1, num2, name2), GameUtil.handler(self.sendMsg, self))
	else
		TipsFacade.instance:openCommonTips(lang("请先选择一项物品"))
	end
end

function RewardselectView:sendMsg()
	if not string.nilorempty(self.selectItem) then
		local obj = {
			item = self.selectItem
		}
		local num = checknumber(self.InputField:GetText())

		MaterialFacade.instance:useItem(self._itemData.type, self._itemData.id, num, GameUtil.jsonToString(obj), GameUtil.handler(self.close, self))
	end
end

return RewardselectView
