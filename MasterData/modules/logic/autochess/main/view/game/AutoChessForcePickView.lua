-- chunkname: @modules/logic/autochess/main/view/game/AutoChessForcePickView.lua

module("modules.logic.autochess.main.view.game.AutoChessForcePickView", package.seeall)

local AutoChessForcePickView = class("AutoChessForcePickView", BaseView)

function AutoChessForcePickView:onInitView()
	self._goView = gohelper.findChild(self.viewGO, "#go_View")
	self._btnGiveUp = gohelper.findChildButtonWithAudio(self.viewGO, "#go_View/#btn_GiveUp")
	self._btnView = gohelper.findChildButtonWithAudio(self.viewGO, "#go_View/#btn_View")
	self._txtTip = gohelper.findChildText(self.viewGO, "#go_View/panelbg/#txt_Tip")
	self._txtWarningTip = gohelper.findChildText(self.viewGO, "#go_View/panelbg/#txt_WarningTip")
	self._goCardRoot = gohelper.findChild(self.viewGO, "#go_View/Card/Viewport/#go_CardRoot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessForcePickView:addEvents()
	self._btnGiveUp:AddClickListener(self._btnGiveUpOnClick, self)
	self._btnView:AddClickListener(self._btnViewOnClick, self)
end

function AutoChessForcePickView:removeEvents()
	self._btnGiveUp:RemoveClickListener()
	self._btnView:RemoveClickListener()
end

function AutoChessForcePickView:onClickModalMask()
	return
end

function AutoChessForcePickView:_btnGiveUpOnClick()
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpForcePick, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self._yesCallback, nil, nil, self)
end

function AutoChessForcePickView:_yesCallback()
	local moduleId = AutoChessModel.instance.moduleId

	if moduleId then
		AutoChessRpc.instance:sendAutoChessMallRegionSelectItemRequest(moduleId, 0)
	end

	self:closeThis()
end

function AutoChessForcePickView:_btnViewOnClick()
	AutoChessController.instance:dispatchEvent(AutoChessEvent.ForcePickViewBoard)
	self:closeThis()
end

function AutoChessForcePickView:_editableInitView()
	self.contentSizeFitter = self._goCardRoot:GetComponent(gohelper.Type_ContentSizeFitter)
	self.layoutGroup = self._goCardRoot:GetComponent(gohelper.Type_HorizontalLayoutGroup)
end

function AutoChessForcePickView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_qishou_confirm)

	if self.viewParam then
		self.addEventCb(self, AutoChessController.instance, AutoChessEvent.ForcePickReply, self.closeThis, self)

		self.freeMall = self.viewParam

		self:refreshUI()
		TaskDispatcher.runDelay(self.delayDisabled, self, 0.1)
	end
end

function AutoChessForcePickView:delayDisabled()
	self.contentSizeFitter.enabled = false
	self.layoutGroup.enabled = false
end

function AutoChessForcePickView:onClose()
	return
end

function AutoChessForcePickView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayDisabled, self)
end

function AutoChessForcePickView:refreshUI()
	local freeMallCnt = #self.freeMall.items

	self._txtTip.text = luaLang("autochess_forcepick_tip")

	if freeMallCnt ~= 0 then
		local mallItem = self.freeMall.items[1]
		local chessCo = AutoChessConfig.instance:getChessCfgById(mallItem.chess.id, mallItem.chess.star)
		local txt = luaLang("autochess_forcepick_warningtip")

		self._txtWarningTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, chessCo.name)
	end

	local itemIds = self.freeMall.selectItems

	for _, itemId in ipairs(itemIds) do
		local go = self:getResInst(AutoChessStrEnum.ResPath.ChessCard, self._goCardRoot, "card" .. itemId)
		local cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessCard)
		local param = {
			type = AutoChessCard.ShowType.ForcePick,
			itemId = itemId
		}

		cardItem:setData(param)
	end

	gohelper.setActive(self._txtTip, freeMallCnt == 0)
	gohelper.setActive(self._txtWarningTip, freeMallCnt ~= 0)
end

return AutoChessForcePickView
