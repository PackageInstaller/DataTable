-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/view/DivineKingShiKongLongZunFightEndView.lua

module("logic.extensions.divinekingshikongllongzun.view.DivineKingShiKongLongZunFightEndView", package.seeall)

local DivineKingShiKongLongZunFightEndView = class("DivineKingShiKongLongZunFightEndView", ViewComponent)

function DivineKingShiKongLongZunFightEndView:ctor()
	DivineKingShiKongLongZunFightEndView.super.ctor(self)
end

function DivineKingShiKongLongZunFightEndView:unbindEvents()
	DivineKingShiKongLongZunFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
end

function DivineKingShiKongLongZunFightEndView:bindEvents()
	DivineKingShiKongLongZunFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onBtnGet, self)
end

function DivineKingShiKongLongZunFightEndView:buildUI()
	DivineKingShiKongLongZunFightEndView.super.buildUI(self)

	self._btnGet = self:getGo("btnGet")
	self._cellGoList = {}

	for i = 1, 9 do
		local cell = self:getGo("blood/cell" .. i)

		table.insert(self._cellGoList, cell)
	end
end

function DivineKingShiKongLongZunFightEndView:onExit()
	DivineKingShiKongLongZunFightEndView.super.onExit(self)
end

function DivineKingShiKongLongZunFightEndView:onEnter()
	DivineKingShiKongLongZunFightEndView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = GameUtil.pbToTable(params[1])

	self._posAndHpPairs = msg.positionAndHpRatio

	self:_initUI()
	self:_onSetUI()
end

function DivineKingShiKongLongZunFightEndView:_initUI()
	for i, cellGo in ipairs(self._cellGoList) do
		local txtBlood = goutil.findChildTextComponent(cellGo, "txtBlood")

		GameUtil.SetActive(txtBlood.gameObject, false)
	end
end

function DivineKingShiKongLongZunFightEndView:_onSetUI()
	for i, pair in ipairs(self._posAndHpPairs) do
		local pos = pair.left
		local hp = pair.right
		local curCellGo = self._cellGoList[pos + 1]
		local txtBlood = goutil.findChildTextComponent(curCellGo, "txtBlood")
		local img = goutil.findChildComponent(curCellGo, "bg", "Image")
		local hpRate = math.ceil(hp / 100)

		txtBlood.text = string.format("%d%%", hpRate)

		GameUtil.SetActive(txtBlood.gameObject, true)

		img.fillAmount = hpRate / 100
	end
end

function DivineKingShiKongLongZunFightEndView:_onBtnGet()
	BattleController.instance:endBattle()
	self:close()
end

return DivineKingShiKongLongZunFightEndView
