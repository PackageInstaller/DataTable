-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballRecordCell.lua

module("logic.extensions.football.view.FootballRecordCell", package.seeall)

local M = class("FootballRecordCell", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._name1Txt = goutil.findChildTextComponent(self._go, "normalType/txtPlayerName1")
	self._name2Txt = goutil.findChildTextComponent(self._go, "normalType/txtPlayerName2")
	self._finalScoreTxt = goutil.findChildTextComponent(self._go, "normalType/txtHint2")
	self._scoreTxt = goutil.findChildTextComponent(self._go, "normalType/txtScore")
	self._winGo = goutil.findChild(self._go, "normalType/win")
	self._loseGo = goutil.findChild(self._go, "normalType/lose")
	self._drawGo = goutil.findChild(self._go, "normalType/tie")
	self._img1HeadIcon = goutil.findChildImageComponent(self._go, "normalType/cell1/head_item/mask/headIcon")
	self._img2HeadIcon = goutil.findChildImageComponent(self._go, "normalType/cell2/head_item/mask/headIcon")
end

function M:setData(recordNO)
	self._recordNO = recordNO

	self:_refreshCell()
end

function M:_refreshCell()
	self._play1Info = PlayerModel.instance:getPlayerCardInfo()
	self._name1Txt.text = self._play1Info.nickname
	self._name2Txt.text = self._recordNO.opponent.nickname
	self._finalScoreTxt.text = string.format("%d:%d", self._recordNO.myPoint, self._recordNO.opponentPoint)
	self._scoreTxt.text = string.format("积分：%d <color=#5fff4f>+%d</color>", self._recordNO.oldScore, self._recordNO.newScore - self._recordNO.oldScore)

	goutil.setActive(self._winGo, false)
	goutil.setActive(self._loseGo, false)
	goutil.setActive(self._drawGo, false)

	if self._recordNO.gameResult == GameEnum.GameResultEnum.WIN then
		goutil.setActive(self._winGo, true)
	elseif self._recordNO.gameResult == GameEnum.GameResultEnum.DRAW then
		goutil.setActive(self._drawGo, true)
	else
		goutil.setActive(self._loseGo, true)
	end

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(self._play1Info.portrait)

	if portraitCO then
		IconLoader.setSprite(self._img1HeadIcon, IconType.Portrait, portraitCO.icon)
	end

	portraitCO = BackpackConfig.instance:getItemInfoByItemId(self._recordNO.opponent.portrait)

	if portraitCO then
		IconLoader.setSprite(self._img2HeadIcon, IconType.Portrait, portraitCO.icon)
	end
end

GameEnum.GameResultEnum = {
	LOSE = 3,
	DRAW = 2,
	WIN = 1
}

function M:OnDestroy()
	return
end

return M
