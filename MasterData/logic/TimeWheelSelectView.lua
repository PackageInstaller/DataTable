-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelSelectView.lua

module("logic.extensions.timewheel.view.TimeWheelSelectView", package.seeall)

local TimeWheelSelectView = class("TimeWheelSelectView", TableViewComponent)

function TimeWheelSelectView:buildUI()
	TimeWheelSelectView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
end

function TimeWheelSelectView:bindEvents()
	TimeWheelSelectView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function TimeWheelSelectView:unbindEvents()
	TimeWheelSelectView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function TimeWheelSelectView:onEnter()
	TimeWheelSelectView.super.onEnter(self)

	local params = self:getOpenParam()
	local petIdList = params[1]
	local itemIdList = params[2]

	self._callback = params[3]
	self._isPet = nil
	self._selectId = nil

	local showList = {}

	for i, v in ipairs(petIdList) do
		local element = {}

		element.isPet = true
		element.id = v
		element.isSelect = false

		table.insert(showList, element)
	end

	for i, v in ipairs(itemIdList) do
		local num = checknumber(MaterialModel.instance:getMaterialsNumber(MatType.Item, v))

		if num >= 1 then
			for k = 1, num do
				local element = {}

				element.isPet = false
				element.id = v
				element.isSelect = false

				table.insert(showList, element)
			end
		end
	end

	if #showList > 0 then
		self:_setSelect(showList[1].isPet, showList[1].id)

		showList[1].isSelect = true
	end

	self:updateListData(showList)
end

function TimeWheelSelectView:onExit()
	TimeWheelSelectView.super.onExit(self)
end

function TimeWheelSelectView:_onClickClose()
	self:close()
end

function TimeWheelSelectView:_getPath()
	return {
		cellPath = "scrollList/item",
		viewPath = "scrollList"
	}
end

function TimeWheelSelectView:_cellSize(view, index)
	return 100, 100
end

function TimeWheelSelectView:_updateCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btnClick = Framework.ButtonAdapter.Get(cell.gameObject)

	goutil.setActive(select, data.isSelect)

	local proxy

	if data.isPet then
		local bagPetMo = BagModel.instance:getPet(data.id)

		proxy = MaterialMgr.setCellByMo(bagPetMo, node)
		txtName.text = bagPetMo.name
	else
		proxy = MaterialMgr.setCell(MatType.Item, data.id, node)
		txtName.text = MaterialMgr.getMaterialsName(MatType.Item, data.id)
	end

	local function func()
		printInfo("test 点击进来了", self._isPet, data.isPet, self._selectId, data.id)

		data.isSelect = true
		self._isPet = data.isPet
		self._selectId = data.id

		if not goutil.isNil(select) then
			goutil.setActive(select, true)
		end

		self:_updateSelectCell(cell.data)
	end

	btnClick:AddClickListener(func)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(func)
	end
end

function TimeWheelSelectView:_clearTableview(cell)
	local node = goutil.findChild(cell, "node")
	local btnClick = Framework.ButtonAdapter.Get(cell.gameObject)

	MaterialMgr.resetAll(node)
	btnClick:RemoveClickListener()
end

function TimeWheelSelectView:_onClickSure()
	if self._isPet ~= nil and self._selectId ~= nil then
		GameUtil.callBack(self._callback, self._isPet, self._selectId)
		self:_onClickClose()
	else
		FloatWordMgr.instance:show("请先选择一个精灵或道具")
	end
end

function TimeWheelSelectView:_setSelect(isPet, id)
	self._isPet = isPet
	self._selectId = id
end

function TimeWheelSelectView:_updateSelectCell(selectIndex)
	for i, v in ipairs(self._curViewDatas) do
		if i ~= selectIndex and v.isSelect then
			v.isSelect = false

			self._tableview:UpdateCellAtIndex(i - 1)
		end
	end
end

return TimeWheelSelectView
