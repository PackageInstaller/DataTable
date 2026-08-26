-- chunkname: @modules/logic/battlepass/view/BpSPMainBtnItem.lua

module("modules.logic.battlepass.view.BpSPMainBtnItem", package.seeall)

local BpSPMainBtnItem = class("BpSPMainBtnItem", ActCenterItemBase)

function BpSPMainBtnItem:init(go)
	BpSPMainBtnItem.super.init(self, gohelper.cloneInPlace(go))
end

function BpSPMainBtnItem:onInit(go)
	self._btnitem = gohelper.getClickWithAudio(self._imgGo, AudioEnum.UI.play_ui_role_pieces_open)

	self:_refreshItem()
end

function BpSPMainBtnItem:onClick()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.BP))

		return
	end

	BpController.instance:openBattlePassView(true)
end

function BpSPMainBtnItem:_refreshItem()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_6")

	UISpriteSetMgr.instance:setMainSprite(self._imgitem, spriteName, true)
	self:setFestival(isShow)

	self._redDot = RedDotController.instance:addRedDot(self._goactivityreddot, RedDotEnum.DotNode.BattlePassSPMain)
end

function BpSPMainBtnItem:isShowRedDot()
	return self._redDot and self._redDot.isShowRedDot
end

return BpSPMainBtnItem
