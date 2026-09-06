-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/IdleWarehouseView.lua

module("logic.extensions.idlegame.view.IdleWarehouseView", package.seeall)

local IdleWarehouseView = class("IdleWarehouseView", ViewComponent)

function IdleWarehouseView:ctor()
	IdleWarehouseView.super.ctor(self)
end

function IdleWarehouseView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function IdleWarehouseView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function IdleWarehouseView:buildUI()
	self._closeButton = self:getBtn("main/btnClose")
	self._tableview = goutil.findChildComponent(self.mainGO, "main/tableview", "UITableview")
	self._tablecell = goutil.findChild(self.mainGO, "main/tablecell")

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:SetOffsetWithoutRefresh(0)
	goutil.setActive(self._tablecell, false)

	self._txtCurMoney = goutil.findChildComponent(self.mainGO, "main/money/txtCurMoney", "Text")
end

function IdleWarehouseView:destroyUI()
	return
end

function IdleWarehouseView:onEnter()
	IdleGameController.instance:registerLocalNotify("AddNewNuo", self._refresh, self)
	IdleGameController.instance:registerLocalNotify("refreshMoneyInfo", self._updateMoneyUI, self)
	IdleGameController.instance:registerLocalNotify("onAddMoney", self._updateMoneyUI, self)
	self:_refresh()
end

function IdleWarehouseView:onEnterFinished()
	return
end

function IdleWarehouseView:onExit()
	IdleGameController.instance:unregisterLocalNotify("AddNewNuo", self._refresh, self)
	IdleGameController.instance:unregisterLocalNotify("refreshMoneyInfo", self._updateMoneyUI, self)
	IdleGameController.instance:unregisterLocalNotify("onAddMoney", self._updateMoneyUI, self)
end

function IdleWarehouseView:onExitFinished()
	return
end

function IdleWarehouseView:_numInView()
	return #self._curViewDatas
end

function IdleWarehouseView:_cellSize()
	return 623, 100
end

function IdleWarehouseView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tablecell)

	local data = self._curViewDatas[idx + 1]
	local txtName = goutil.findChildComponent(cell.gameObject, "txtName", "Text")
	local txtLevel = goutil.findChildComponent(cell.gameObject, "txtLevel", "Text")
	local txtPrice = goutil.findChildComponent(cell.gameObject, "btnBuy/txtPrice", "Text")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnBuy")
	local imgIcon = goutil.findChildComponent(cell.gameObject, "icon/imgIcon", "Image")

	btn:AddClickListener(function()
		IdleGameController.instance:buyNuo(data.level)
	end)

	txtName.text = data.name
	txtLevel.text = string.format("等级%d", data.level)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.modelId))

	if modelCo ~= nil then
		uGuiUtil.setSpriteToImage(imgIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	end

	local val = IdleGameModel.instance:getBuyPrice(data.level)

	txtPrice.text = StringUtil.numberToString(val)

	uGuiUtil.setGoGrayState(cell.gameObject, data.level > IdleGameModel.instance:getMaxBuyLevel())

	return cell
end

function IdleWarehouseView:_onClickClose()
	self:close()
end

function IdleWarehouseView:_refresh()
	self._curViewDatas = IdleGameConfig.instance:getXiaoNuoPlaceCfgs()

	self._tableview:ReloadData()

	self._txtCurMoney.text = StringUtil.numberToString((IdleGameModel.instance:getCurMoney()))
end

function IdleWarehouseView:_updateMoneyUI()
	self._txtCurMoney.text = StringUtil.numberToString((IdleGameModel.instance:getCurMoney()))
end

return IdleWarehouseView
