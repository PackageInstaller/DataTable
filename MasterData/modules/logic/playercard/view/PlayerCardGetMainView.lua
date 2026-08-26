-- chunkname: @modules/logic/playercard/view/PlayerCardGetMainView.lua

module("modules.logic.playercard.view.PlayerCardGetMainView", package.seeall)

local PlayerCardGetMainView = class("PlayerCardGetMainView", NewPlayerCardView)

function PlayerCardGetMainView:onOpen(tempSkinId)
	self._achievementCls = self._achievementCls or MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, PlayerCardAchievement)
	self._achievementCls.viewParam = self.viewParam
	self._achievementCls.viewContainer = self.viewContainer

	self._achievementCls:onOpen()

	self._infoCls = self._infoCls or MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, PlayerCardPlayerInfo)
	self._infoCls.viewParam = self.viewParam

	self._infoCls:onOpen()

	self.viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_onOpen(tempSkinId)
end

function PlayerCardGetMainView:_onOpen(tempSkinId)
	self._animator.enabled = true

	if self.viewParam and self.viewParam.userId then
		self.userId = self.viewParam.userId
	end

	self.playercardinfo = PlayerCardModel.instance:getCardInfo(self.userId)

	if self.playercardinfo:isSelf() then
		PlayerCardController.instance:statStart()
	end

	if not tempSkinId then
		::label_2_0::

		local themeId = self.playercardinfo:getThemeId()

		if themeId == 0 or string.nilorempty(themeId) then
			themeId = nil
		end

		self.themeId = themeId

		self:_creatBgEffect()

		local heroId, skinId, _, isL2d = self.playercardinfo:getMainHero()

		self:_updateHero(heroId, skinId)
		self:_refreshProgress()
		self:_refreshBaseInfo()
		self:_initCritter()
		AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_1)

		self.progressopen = false
		self.baseinfoopen = false
	end
end

return PlayerCardGetMainView
