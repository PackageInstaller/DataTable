-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paystrengthen/view/PayStrengthenSelectView.lua

module("logic.extensions.paystrengthen.view.PayStrengthenSelectView", package.seeall)

local PayStrengthenSelectView = class("PayStrengthenSelectView", ViewComponent)

function PayStrengthenSelectView:buildUI()
	PayStrengthenSelectView.super.buildUI(self)

	self._container = self:getGo("container")
	self._cell = self:getGo("cell")

	goutil.setActive(self._cell, false)

	self._items = {}

	for i = 1, 10 do
		local go = goutil.cloneAndSetParent(self._cell, self._container.transform, "item" .. i)

		goutil.setActive(go, true)

		self._items[i] = {}
		self._items[i].node = self:getGo(string.format("container/item%d/node", i))
		self._items[i].nameText = self:getTxt(string.format("container/item%d/nameText", i))
		self._items[i].select = self:getGo(string.format("container/item%d/select", i))
		self._items[i].btn = self:getBtn(string.format("container/item%d/btn", i))
	end

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("btnClose")
	self._txtNum = self:getTxt("txtNum")
	self._txtAttrName = goutil.findChildTextComponent(self.mainGO, "txtAttrName")
	self._attrCol = goutil.findChild(self.mainGO, "attrCol")
	self._attrCell = goutil.findChild(self.mainGO, "attrCol/attrCell")
end

function PayStrengthenSelectView:bindEvents()
	PayStrengthenSelectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)

	for i = 1, 10 do
		self._items[i].btn:AddClickListener(function()
			self:_onClickItem(i)
		end)
	end
end

function PayStrengthenSelectView:unbindEvents()
	PayStrengthenSelectView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()

	for i = 1, 10 do
		self._items[i].btn:RemoveClickListener()
	end
end

function PayStrengthenSelectView:_onClickClose()
	self:close()
end

function PayStrengthenSelectView:_onClickSure()
	if #self._selectIds ~= 4 then
		FloatWordMgr.instance:show("请选择4个星神")

		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.PayStrengthenSelectStarGodSuc, self._selectIds)
	self:_onClickClose()
end

function PayStrengthenSelectView:_onClickItem(index)
	if self._items[index].select.activeSelf then
		table.removebyvalue(self._selectIds, self._cfgs[index].defineId)
		goutil.setActive(self._items[index].select, false)
	elseif #self._selectIds < 4 then
		goutil.setActive(self._items[index].select, true)
		table.insert(self._selectIds, self._cfgs[index].defineId)
	else
		FloatWordMgr.instance:show("已达到最大选择数量")
	end

	self:_setTxt(#self._selectIds)
	self:_printList()
	self:_onUpdateAttrCol(index)
end

function PayStrengthenSelectView:onEnter()
	PayStrengthenSelectView.super.onEnter(self)

	self._bagPetMo = self:getFirstParam() or {}
	self._raceId = checknumber(self._bagPetMo.raceId)
	self._selectIds = {}
	self._cfgs = PayStrengthenConfig.instance:getStarGodList()

	self:_initItems()
	self:_onUpdateAttrCol(nil)
end

function PayStrengthenSelectView:onExit()
	PayStrengthenSelectView.super.onExit(self)
	self:_clearAttrCol()
	self:_removeItems()
end

function PayStrengthenSelectView:_initItems()
	self:_setTxt(0)

	for i, v in ipairs(self._items) do
		local prize = self._cfgs[i].prize
		local matType, id, matNum = MaterialMgr.getMatParams(prize)
		local racePrize = MaterialMgr.createSerName(matType, id, self._raceId, matNum)
		local proxy = MaterialMgr.setCellByCfg(racePrize, v.node)

		if proxy then
			proxy.binder:setNum(0)
			proxy.binder:setAutoTips(false)
		end

		v.nameText.text = MaterialMgr.getMaterialsNameByCfg(racePrize)

		local nameTextColorChange = v.nameText.gameObject:GetComponent(ComponentType.UITextColorChange)
		local tem = MaterialMgr.getMatCfgByStr(racePrize)
		local quality = tem.quality

		nameTextColorChange:SetState(quality)
		goutil.setActive(v.select, false)
	end
end

function PayStrengthenSelectView:_removeItems()
	for i, v in ipairs(self._items) do
		MaterialMgr.resetAll(v.node)
	end
end

function PayStrengthenSelectView:_printList()
	local str = ""

	for i, v in ipairs(self._selectIds) do
		str = str .. v .. ","
	end

	printInfo("test 最新的选择id列表 = ", str)
end

function PayStrengthenSelectView:_setTxt(num)
	self._txtNum.text = string.format("已选中星神：%d/4", num)
end

function PayStrengthenSelectView:_onUpdateAttrCol(i)
	local prize = ""

	if self._cfgs and self._cfgs[i] and self._cfgs[i].prize then
		prize = self._cfgs[i].prize
	end

	self._txtAttrName.text = ""

	local childList = GameUtil.getChildren(self._attrCol)

	for _, go in ipairs(childList) do
		GameUtil.SetActive(go, false)
	end

	if string.nilorempty(prize) then
		self:_clearAttrCol()

		return
	end

	local type, matId, num = MaterialMgr.getMatParams(prize)
	local matName = MaterialMgr.getMaterialsName(type, matId)

	self._txtAttrName.text = matName or ""

	local nameTextColorChange = self._txtAttrName.gameObject:GetComponent(ComponentType.UITextColorChange)
	local tem = MaterialMgr.getMatCfgByStr(prize)
	local quality = tem.quality

	nameTextColorChange:SetState(quality)

	self._attrCellList = {}

	local sgPropData = StargodplusConfig.instance:getPropCfg(matId, 1)
	local attrList = self:_parseAttr(sgPropData.propertyApp)

	if attrList ~= nil then
		for idx, data in ipairs(attrList) do
			local cell = {}

			cell._mainGo = childList[idx] or goutil.cloneAndSetParent(self._attrCell, self._attrCol.transform)
			cell._icon = goutil.findChild(cell._mainGo, "icon")
			cell._txtAttr = goutil.findChildTextComponent(cell._mainGo, "txtAttr")
			cell._change = cell._icon:GetComponent(ComponentType.UIImageSpriteChange)

			table.insert(self._attrCellList, cell)
			GameUtil.SetActive(cell._mainGo, true)

			cell._mainGo.name = string.format("attrCell_%d", idx)
			cell._txtAttr.text = data.attrName .. " +" .. data.attrValue

			cell._change:SetState(data.attrIconState)
		end
	end
end

function PayStrengthenSelectView:_clearAttrCol()
	local childList = GameUtil.getChildren(self._attrCol)

	for _, go in ipairs(childList) do
		local icon = goutil.findChild(go, "icon")

		uGuiUtil.clearImage(icon)
	end
end

function PayStrengthenSelectView:_parseAttr(attrStr)
	local attrList = {}
	local attrArray = string.split(attrStr, "#")

	for _, v in ipairs(attrArray) do
		local arr = string.split(v, "+")
		local t = {
			attrName = arr[1],
			attrValue = arr[2],
			attrIconState = self:_getAttrIconState(arr[1])
		}

		table.insert(attrList, t)
	end

	return attrList
end

function PayStrengthenSelectView:_getAttrIconState(attrName)
	for state, name in ipairs(GameEnum.AttrTypeName) do
		if name == attrName then
			return state - 1
		end
	end
end

return PayStrengthenSelectView
