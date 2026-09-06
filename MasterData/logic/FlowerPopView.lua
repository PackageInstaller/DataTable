-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flowergoddess/view/FlowerPopView.lua

module("logic.extensions.flowergoddess.view.FlowerPopView", package.seeall)

local FlowerPopView = class("FlowerPopView", ViewComponent)

function FlowerPopView:ctor()
	FlowerPopView.super.ctor(self)
end

function FlowerPopView:buildUI()
	FlowerPopView.super.buildUI(self)

	self._flowerScrollerview = goutil.findChild(self.mainGO, "flowerCol/flowerScrollerview")
	self._flowerScrollercell = goutil.findChild(self.mainGO, "flowerCol/flowerScrollercell")
	self._btnLessTen = goutil.findChild(self.mainGO, "controlCol/btnLessTen")
	self._btnLess = goutil.findChild(self.mainGO, "controlCol/btnLess")
	self._btnAdd = goutil.findChild(self.mainGO, "controlCol/btnAdd")
	self._btnAddTen = goutil.findChild(self.mainGO, "controlCol/btnAddTen")
	self._btnMax = goutil.findChild(self.mainGO, "controlCol/btnMax")
	self._inputField = self:getInput("controlCol/inputField")
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._flowerScrollList = ScrollerList.create(self._flowerScrollerview, self._flowerScrollercell, GameUtil.handler(self._updateFlowerCell, self), GameUtil.handler(self._clearFlowerCell, self))
end

function FlowerPopView:bindEvents()
	FlowerPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnLessTen, function()
		self:_calcValue(-10)
	end, self)
	GameUtil.addClickHandler(self._btnLess, function()
		self:_calcValue(-1)
	end, self)
	GameUtil.addClickHandler(self._btnAdd, function()
		self:_calcValue(1)
	end, self)
	GameUtil.addClickHandler(self._btnAddTen, function()
		self:_calcValue(10)
	end, self)
	GameUtil.addClickHandler(self._btnMax, function()
		self:_calcValue(self._curMaxNum)
	end, self)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
end

function FlowerPopView:unbindEvents()
	FlowerPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnLessTen)
	GameUtil.rmClickHandler(self._btnLess)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnAddTen)
	GameUtil.rmClickHandler(self._btnMax)
	self._inputField:RemoveOnValueChanged()
end

function FlowerPopView:destroyUI()
	FlowerPopView.super.destroyUI(self)
end

function FlowerPopView:onEnter()
	FlowerPopView.super.onEnter(self)

	self._activityId = FlowerGoddessModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FlowerGoddess, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._gfPlanCfg = FlowerGoddessConfig.instance:getGfPlanCfg(self._activityId)
	self._curNum = 0
	self._curMaxNum = 0
	self._selectFlowerId = 0

	self:_onSetUI()
	self:_onUpdate()
end

function FlowerPopView:onExit()
	FlowerPopView.super.onExit(self)
	self._flowerScrollList:dispose()
end

function FlowerPopView:_onSetUI()
	self:_onValueChanged(0)
end

function FlowerPopView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function FlowerPopView:_onUpdateData()
	self:_onUpdateDataMo()
end

function FlowerPopView:_onUpdateUI()
	self:_onUpdateFlowerScrollerList()
end

function FlowerPopView:_onUpdateDataMo()
	return
end

function FlowerPopView:_onValueChanged(numStr)
	local num = checkint(numStr)

	num = Mathf.Clamp(num, 0, self._curMaxNum)
	self._curNum = num

	self._inputField:SetText(tostring(self._curNum))
end

function FlowerPopView:_calcValue(delta)
	local num = self._curNum + checkint(delta)

	self:_onValueChanged(num)
end

function FlowerPopView:_onUpdateFlowerScrollerList()
	self._flowerScrollList:reloadData(self._gfPlanCfg)
end

function FlowerPopView:_updateFlowerCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")
	local mark = goutil.findChild(mainGo, "mark")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local txtIntimacy = goutil.findChildTextComponent(mainGo, "txtIntimacy")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local matStrArr = string.split(data.flowerItem, ":")
	local matType, matId, matNum = matStrArr[1], matStrArr[2], matStrArr[#matStrArr]
	local itemCfg = MaterialMgr.getMatCfg(matType, matId)

	if itemCfg == nil then
		return
	end

	if not string.nilorempty(data.flowerItem) then
		MaterialMgr.setCellByCfg(data.flowerItem, itemGo, urlOrGo, luaCls, isOne)
	end

	if txtCount then
		local ownNum = MaterialMgr.getMatCount(data.flowerItem)

		txtCount.text = string.format("数量：%d 朵", ownNum)
	end

	if txtIntimacy then
		txtIntimacy.text = data.intimacy
	end

	if txtName and not string.nilorempty(itemCfg.name) then
		txtName.text = itemCfg.name
	end

	local isMarked = self._selectFlowerId == data.flowerId

	GameUtil.SetActive(mark, isMarked)

	local function handler()
		local isMarked = self._selectFlowerId == data.flowerId

		if isMarked then
			self._selectFlowerId = 0
			self._curMaxNum = 0
			self._curNum = 0

			self:_calcValue(0)
		else
			self._selectFlowerId = data.flowerId

			local ownNum = MaterialMgr.getMatCount(data.flowerItem)

			self._curMaxNum = math.floor(ownNum / matNum)
			self._curNum = 0

			self:_calcValue(1)
		end

		self:_onUpdateFlowerScrollerList()
	end

	GameUtil.addClickHandler(mainGo, handler)
end

function FlowerPopView:_clearFlowerCell(cell)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(itemGo)
	GameUtil.rmClickHandler(mainGo)
end

function FlowerPopView:_onClickBtnSure()
	if self._selectFlowerId == 0 then
		FloatWordMgr.instance:show("你没有选中要送的鲜花哦~")

		return
	end

	if self._curNum == 0 then
		FloatWordMgr.instance:show("没有选中足够的鲜花哦~")

		return
	end

	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.FlowerGoddessSendFlower, self._activityId, self._selectFlowerId, self._curNum)
end

return FlowerPopView
