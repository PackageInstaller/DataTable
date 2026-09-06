-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/EquipSelectView.lua

module("logic.extensions.starequipment.view.EquipSelectView", package.seeall)

local EquipSelectView = class("EquipSelectView", TableViewComponent)

function EquipSelectView:ctor()
	EquipSelectView.super.ctor(self)
end

function EquipSelectView:destroyUI()
	EquipSelectView.super.destroyUI(self)
end

function EquipSelectView:onExitFinished()
	EquipSelectView.super.onExitFinished(self)
end

function EquipSelectView:onEnterFinished()
	EquipSelectView.super.onEnterFinished(self)
end

function EquipSelectView:unbindEvents()
	EquipSelectView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnPutOn:RemoveClickListener()
end

function EquipSelectView:bindEvents()
	EquipSelectView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnPutOn:AddClickListener(self._onClickPuton, self)
end

function EquipSelectView:onExit()
	EquipSelectView.super.onExit(self)

	if self._closeCall ~= nil then
		self._closeCall()
	end
end

function EquipSelectView:buildUI()
	EquipSelectView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnPutOn = self:getBtn("btnPutOn")
	self._empty = self:getGo("empty")

	local filters = self:getGo("qualityFilter/bg")

	self._filters = {}

	for i = GameEnum.StarEquipmentQua.Golden, GameEnum.StarEquipmentQua.Red do
		local filter = {}
		local go = goutil.findChild(filters, i)

		filter.mainGO = go
		filter.imgGou = goutil.findChild(go, "Mark")
		filter.btn = Framework.ButtonAdapter.Get(go)

		filter.btn:AddClickListener(function()
			self:_onClickFilter(i)
		end)

		self._filters[i] = filter

		goutil.setActive(filter.imgGou, true)
	end
end

function EquipSelectView:onEnter()
	EquipSelectView.super.onEnter(self)

	self._selectedEquipId = nil

	local params = self:getOpenParam()

	self._petMo = params[1]
	self._slotIndex = params[2]
	self._closeCall = params[3]

	self:_updateList()
	uGuiUtil.setGoGrayState(self._btnPutOn.gameObject, true)
end

function EquipSelectView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function EquipSelectView:_updateCell(view, cell, data)
	local go = goutil.findChild(cell.gameObject, "container")
	local itemPoint = goutil.findChild(go, "itemPoint")
	local txtName = goutil.findChildComponent(go, "txtName", "Text")
	local btn = Framework.ButtonAdapter.Get(go)
	local selected = goutil.findChild(go, "selected")
	local equipId = data
	local equipCfg = StarEquipmentConfig.instance:getEquipCfg(equipId)
	local equipNum = MaterialFacade.instance:getMatNumber(MatType.StarEquipment, equipId)

	MaterialMgr.setCellByCfg(string.format("%s:%s:%s", MatType.StarEquipment, equipId, equipNum), itemPoint)

	txtName.text = equipCfg.name

	btn:AddClickListener(function()
		self:_onClickEquip(equipId)
	end)
	goutil.setActive(selected, equipId == self._selectedEquipId)
	uGuiUtil.setGoGrayState(itemPoint, equipNum <= 0)
end

function EquipSelectView:_updateEquipItem(equipId)
	for k, id in ipairs(self._curViewDatas) do
		if id == equipId then
			self._tableview:UpdateCellAtIndex(k - 1)
		end
	end
end

function EquipSelectView:_onClickEquip(equipId)
	local num = MaterialFacade.instance:getMatNumber(MatType.StarEquipment, equipId)

	if num <= 0 then
		FloatWordMgr.instance:show("星辉材料不足")
	elseif self._petMo:isUseEquipId(equipId, self._slotIndex) then
		FloatWordMgr.instance:show("不能同时装备相同id的星辉")
	else
		self:_clearCurSelectedEquip()

		self._selectedEquipId = equipId

		self:_updateEquipItem(equipId)
		uGuiUtil.setGoGrayState(self._btnPutOn.gameObject, false)
	end
end

function EquipSelectView:_clearCurSelectedEquip()
	local preEquipId = self._selectedEquipId

	self._selectedEquipId = nil

	if preEquipId ~= nil then
		self:_updateEquipItem(preEquipId)
	end

	uGuiUtil.setGoGrayState(self._btnPutOn.gameObject, true)
end

function EquipSelectView:_onClickClose()
	self:close()
end

function EquipSelectView:_onClickPuton()
	if self._selectedEquipId ~= nil then
		local text = "装备后该位置星辉不可进行更改，是否确定星辉？"

		TipsFacade.instance:openPopupWindow("提示", text, function()
			StarEquipmentAgent:sendSE_EquipReq(self._petMo.petId, self._slotIndex - 1, self._selectedEquipId, self._onPutonEquip, self)
		end)
	else
		FloatWordMgr.instance:show("请选择一个星辉进行安装")
	end
end

function EquipSelectView:_onPutonEquip()
	FloatWordMgr.instance:show("装备成功")
	self:close()
end

function EquipSelectView:_updateList()
	local t = CharacterConfig.instance:getRecommendEquipIds(self._petMo.raceId, self._petMo._starLevel, self._slotIndex)

	self._curViewDatas = {}

	for _, v in ipairs(t) do
		local equipCfg = StarEquipmentConfig.instance:getEquipCfg(v)

		if equipCfg ~= nil and self._filters[equipCfg.quality] ~= nil and self._filters[equipCfg.quality].imgGou.activeSelf then
			table.insert(self._curViewDatas, v)
		end
	end

	self:reloadData()
end

function EquipSelectView:_onClickFilter(qua)
	local filter = self._filters[qua]

	goutil.setActive(filter.imgGou, not filter.imgGou.activeSelf)
	self:_updateList()
end

return EquipSelectView
