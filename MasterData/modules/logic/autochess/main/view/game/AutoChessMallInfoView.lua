-- chunkname: @modules/logic/autochess/main/view/game/AutoChessMallInfoView.lua

module("modules.logic.autochess.main.view.game.AutoChessMallInfoView", package.seeall)

local AutoChessMallInfoView = class("AutoChessMallInfoView", BaseView)

function AutoChessMallInfoView:onInitView()
	self._goTopRight = gohelper.findChild(self.viewGO, "#go_TopRight")
	self._txtCoin = gohelper.findChildText(self.viewGO, "#go_TopRight/price/#txt_Coin")
	self._goCardRoot = gohelper.findChild(self.viewGO, "#go_CardRoot")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._txtPage = gohelper.findChildText(self.viewGO, "#txt_Page")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessMallInfoView:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function AutoChessMallInfoView:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function AutoChessMallInfoView:onClickModalMask()
	self:closeThis()
end

function AutoChessMallInfoView:_btnLeftOnClick()
	self.curIndex = self.curIndex - 1

	self:refreshMallUI()
end

function AutoChessMallInfoView:_btnRightOnClick()
	self.curIndex = self.curIndex + 1

	self:refreshMallUI()
end

function AutoChessMallInfoView:_editableInitView()
	local go = self:getResInst(AutoChessStrEnum.ResPath.ChessCard, self._goCardRoot)

	self.card = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessCard, self)
end

function AutoChessMallInfoView:onUpdateParam()
	return
end

function AutoChessMallInfoView:onOpen()
	if not self.viewParam then
		return
	end

	local chessMo = AutoChessModel.instance:getChessMo()

	self._txtCoin.text = chessMo.svrMall.coin

	if self.viewParam.mall then
		self.mall = self.viewParam.mall
		self.mallItems = self.mall.items
		self.itemUId = self.viewParam.itemUId

		for index, item in ipairs(self.mallItems) do
			if item.uid == self.itemUId then
				self.curIndex = index
			end
		end

		self.maxCnt = #self.mallItems

		self:refreshMallUI()
	else
		self:refreshChessUI()
	end

	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.BuyChessReply, self.closeThis, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.BuildReply, self.closeThis, self)
end

function AutoChessMallInfoView:onClose()
	return
end

function AutoChessMallInfoView:onDestroyView()
	return
end

function AutoChessMallInfoView:refreshChessUI()
	gohelper.setActive(self._btnLeft, false)
	gohelper.setActive(self._btnRight, false)
	gohelper.setActive(self._txtPage, false)

	local entity = self.viewParam.chessEntity

	gohelper.setActive(self._goTopRight, entity.teamType == AutoChessEnum.TeamType.Player)

	local param = {
		type = AutoChessCard.ShowType.Sell,
		entity = entity
	}

	self.card:setData(param)
end

function AutoChessMallInfoView:refreshMallUI()
	gohelper.setActive(self._btnLeft, self.curIndex > 1)
	gohelper.setActive(self._btnRight, self.curIndex < self.maxCnt)

	self._txtPage.text = string.format("%d/%d", self.curIndex, self.maxCnt)

	local mallItemData = self.mallItems[self.curIndex]
	local param = {
		type = AutoChessCard.ShowType.Buy,
		mallId = self.mall.mallId,
		data = mallItemData
	}

	self.card:setData(param)
end

return AutoChessMallInfoView
