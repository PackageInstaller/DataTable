-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/view/DivineKingShiKongLongZunFmtView.lua

module("logic.extensions.divinekingshikongllongzun.view.DivineKingShiKongLongZunFmtView", package.seeall)

local DivineKingShiKongLongZunFmtView = class("DivineKingShiKongLongZunFmtView", ViewComponent)

function DivineKingShiKongLongZunFmtView:ctor()
	DivineKingShiKongLongZunFmtView.super.ctor(self)
end

function DivineKingShiKongLongZunFmtView:unbindEvents()
	DivineKingShiKongLongZunFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBlood)
end

function DivineKingShiKongLongZunFmtView:bindEvents()
	DivineKingShiKongLongZunFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBlood, self._onClickBtnBlood, self)
end

function DivineKingShiKongLongZunFmtView:buildUI()
	DivineKingShiKongLongZunFmtView.super.buildUI(self)

	self._btnBlood = self:getGo("btnBlood")
	self._bloodview = self:getGo("bloodview")
	self._bloodCellGoList = {}

	for i = 1, 9 do
		local cell = self:getGo("bloodview/blood/cell" .. i)

		table.insert(self._bloodCellGoList, cell)
	end
end

function DivineKingShiKongLongZunFmtView:onExit()
	DivineKingShiKongLongZunFmtView.super.onExit(self)
end

function DivineKingShiKongLongZunFmtView:onEnter()
	DivineKingShiKongLongZunFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormationPosChanged, self._onUpdate, self)

	self._isOpeningBloodView = true
	self._fmtMo = self:getFirstParam()
	self._samePosMap = {}
	self._activityId = self._fmtMo:getActivityId()
	self._floorId = self._fmtMo:getFloorId()
	self._stageId = self._fmtMo:getStageId()
	self._info = DivineKingShiKongLongZunModel.instance:getInfo(self._activityId)
	self._finalHpMap = {}
	self._floorInfo = self._info.floorInfos[self._floorId]

	self:_initUI()

	local hasPetOnFormation = self._fmtMo:hasPetOnFormation()

	if hasPetOnFormation then
		self:_onUpdate()
	else
		self:_onSetUI()
	end
end

function DivineKingShiKongLongZunFmtView:_initUI()
	for i, cellGo in ipairs(self._bloodCellGoList) do
		local txtBlood = goutil.findChildTextComponent(cellGo, "txtBlood")
		local img = goutil.findChildComponent(cellGo, "img", "Image")

		img.fillAmount = 0

		GameUtil.SetActive(txtBlood.gameObject, false)
	end
end

function DivineKingShiKongLongZunFmtView:_onSetUI()
	for i, posAndHpPair in ipairs(self._floorInfo.positionAndHpRatio) do
		local pos = posAndHpPair.left
		local hp = posAndHpPair.right
		local cellGo = self._bloodCellGoList[pos + 1]
		local txtBlood = goutil.findChildTextComponent(cellGo, "txtBlood")
		local img = goutil.findChildComponent(cellGo, "img", "Image")
		local hpRate = math.ceil(hp / 100)

		txtBlood.text = string.format("%d%%", hpRate)
		img.fillAmount = hpRate / 100

		GameUtil.SetActive(txtBlood.gameObject, true)
	end
end

function DivineKingShiKongLongZunFmtView:_onUpdate()
	self:_initUI()

	local hasPetOnFormation = self._fmtMo:hasPetOnFormation()

	if hasPetOnFormation then
		self._finalHpMap = self._fmtMo:getHpMap()

		for pos, hp in pairs(self._finalHpMap) do
			local cellGo = self._bloodCellGoList[pos]
			local txtBlood = goutil.findChildTextComponent(cellGo, "txtBlood")
			local img = goutil.findChildComponent(cellGo, "img", "Image")
			local hpRate = math.ceil(hp / 100)

			txtBlood.text = string.format("%d%%", hpRate)
			img.fillAmount = hpRate / 100

			GameUtil.SetActive(txtBlood.gameObject, true)
		end
	else
		self:_onSetUI()
	end
end

function DivineKingShiKongLongZunFmtView:_onClickBtnBlood()
	self._isOpeningBloodView = not self._isOpeningBloodView

	GameUtil.SetActive(self._bloodview, self._isOpeningBloodView)

	if self._isOpeningBloodView then
		local isTableEmpty = TableUtil.isTableEmpty(self._finalHpMap)

		if isTableEmpty then
			self:_onSetUI()
		else
			self:_onUpdate()
		end
	end
end

return DivineKingShiKongLongZunFmtView
