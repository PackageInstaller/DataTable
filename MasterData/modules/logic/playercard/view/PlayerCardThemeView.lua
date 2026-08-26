-- chunkname: @modules/logic/playercard/view/PlayerCardThemeView.lua

module("modules.logic.playercard.view.PlayerCardThemeView", package.seeall)

local PlayerCardThemeView = class("PlayerCardThemeView", BaseView)

function PlayerCardThemeView:init(go)
	self.viewGO = go

	self:onInitView()
end

function PlayerCardThemeView:onInitView()
	self.goBottom = gohelper.findChild(self.viewGO, "bottom")
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.goBottom, "#btn_confirm")
	self.goLocked = gohelper.findChild(self.goBottom, "#go_locked")
	self.goUsing = gohelper.findChild(self.goBottom, "#go_using")
	self.golimitsale = gohelper.findChild(self.goBottom, "#go_limitsale")
	self.btnSource = gohelper.findChildButtonWithAudio(self.goBottom, "#btn_get")
	self.txtSourceTitle = gohelper.findChildTextMesh(self.goBottom, "source/layout/#txt_title")
	self.txtSourceDesc = gohelper.findChildTextMesh(self.goBottom, "source/layout/#txt_dec")
	self._goSourceLock = gohelper.findChild(self.goBottom, "source/locked")
end

function PlayerCardThemeView:canOpen()
	self:addEvents()
end

function PlayerCardThemeView:addEvents()
	self.addClickCb(self, self.btnConfirm, self.onClickConfirm, self)
	self.addClickCb(self, self.btnSource, self.onClickSource, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.ShowTheme, self.refreshView, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SwitchTheme, self.onSwitchView, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.ChangeSkin, self.onSwitchView, self)
end

function PlayerCardThemeView:removeEvents()
	self.removeClickCb(self, self.btnConfirm, self.onClickConfirm, self)
	self.removeClickCb(self, self.btnSource, self.onClickSource, self)
end

function PlayerCardThemeView:onClickConfirm()
	local selectSkinMO = PlayerCardModel.instance:getSelectSkinMO()

	PlayerCardRpc.instance:sendSetPlayerCardThemeRequest(selectSkinMO.id)
end

function PlayerCardThemeView:onClickSource()
	local selectSkinMO = PlayerCardModel.instance:getSelectSkinMO()

	GameFacade.jump(selectSkinMO:getSources())
end

function PlayerCardThemeView:onUpdateParam()
	return
end

function PlayerCardThemeView:refreshView(userId)
	local info = PlayerCardModel.instance:getCardInfo(userId)

	if not info then
		return
	end

	PlayerCardThemeListModel.instance:init()
	self:onSwitchView()
end

function PlayerCardThemeView:onSwitchView()
	local selectSkinMO = PlayerCardModel.instance:getSelectSkinMO()
	local isUnLock = selectSkinMO:isUnLock()
	local canBuy = selectSkinMO:canBuyInStore()
	local isVaild = selectSkinMO:isStoreDecorateGoodsValid()

	if not isUnLock then
		local jumpId = selectSkinMO:getSources()
		local canJump = JumpController.instance:isJumpOpen(jumpId)

		if canBuy then
			gohelper.setActive(self.goLocked, false)
			gohelper.setActive(self.golimitsale, not isVaild)
			gohelper.setActive(self.btnSource.gameObject, isVaild)
		else
			gohelper.setActive(self.golimitsale, false)
			gohelper.setActive(self.btnSource.gameObject, canJump)
			gohelper.setActive(self.goLocked, not canJump)
		end

		gohelper.setActive(self._goSourceLock, true)
	else
		gohelper.setActive(self.goLocked, false)
		gohelper.setActive(self.golimitsale, false)
		gohelper.setActive(self.btnSource.gameObject, false)
		gohelper.setActive(self._goSourceLock, false)
	end

	local isUsing = selectSkinMO:checkIsUse()

	gohelper.setActive(self.goUsing, isUsing)
	gohelper.setActive(self.btnConfirm, not isUsing and isUnLock)

	if selectSkinMO:isEmpty() then
		self.txtSourceTitle.text = luaLang("talent_style_special_tag_998")
		self.txtSourceDesc.text = luaLang("playercard_skin_default")
	else
		local config = selectSkinMO:getConfig()

		self.txtSourceTitle.text = config.name
		self.txtSourceDesc.text = config.desc
	end
end

function PlayerCardThemeView:onDestroy()
	return
end

return PlayerCardThemeView
