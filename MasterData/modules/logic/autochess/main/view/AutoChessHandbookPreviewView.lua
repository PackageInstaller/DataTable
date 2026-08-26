-- chunkname: @modules/logic/autochess/main/view/AutoChessHandbookPreviewView.lua

module("modules.logic.autochess.main.view.AutoChessHandbookPreviewView", package.seeall)

local AutoChessHandbookPreviewView = class("AutoChessHandbookPreviewView", BaseView)

function AutoChessHandbookPreviewView:onInitView()
	self._scrollCard = gohelper.findChildScrollRect(self.viewGO, "Middle/#scroll_Card")
	self._goCardRoot = gohelper.findChild(self.viewGO, "Middle/#scroll_Card/Viewport/#go_CardRoot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessHandbookPreviewView:onClickModalMask()
	self:closeThis()
end

function AutoChessHandbookPreviewView:_editableInitView()
	self._chessCardItems = self:getUserDataTb_()
end

function AutoChessHandbookPreviewView:onOpen()
	self._chessId = self.viewParam.chessId

	self:createChessCardItems()

	self._scrollCard.horizontalNormalizedPosition = 0
end

function AutoChessHandbookPreviewView:createChessCardItems()
	local chessCfgStarList = AutoChessConfig:getChessCfgById(self._chessId)

	for idx, chessCfg in ipairs(chessCfgStarList) do
		local go = self:getResInst(AutoChessStrEnum.ResPath.ChessCard, self._goCardRoot, "card" .. chessCfg.id)
		local cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessCard)
		local param = {
			type = AutoChessCard.ShowType.HandBook,
			itemId = chessCfg.id,
			star = chessCfg.star,
			arrow = idx < #chessCfgStarList
		}

		self._chessCardItems[#self._chessCardItems + 1] = go

		cardItem:setData(param)
	end
end

function AutoChessHandbookPreviewView:clearChessCardItems()
	if self._chessCardItems then
		for _, v in pairs(self._chessCardItems) do
			gohelper.destroy(v)
		end
	end
end

function AutoChessHandbookPreviewView:onDestroyView()
	self:clearChessCardItems()
end

return AutoChessHandbookPreviewView
