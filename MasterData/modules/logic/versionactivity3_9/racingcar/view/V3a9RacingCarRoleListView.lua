-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarRoleListView.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarRoleListView", package.seeall)

local V3a9RacingCarRoleListView = class("V3a9RacingCarRoleListView", BaseView)

function V3a9RacingCarRoleListView:onInitView()
	self._gofull = gohelper.findChild(self.viewGO, "root/#go_full")
	self._govideo = gohelper.findChild(self.viewGO, "root/#go_full/#go_video")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/#txt_title")
	self._scrollroleList = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_roleList")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/Bottom/#txt_desc")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "root/Bottom/#btn_enter")
	self._golefttop = gohelper.findChild(self.viewGO, "root/#go_lefttop")
	self._gocurrency = gohelper.findChild(self.viewGO, "root/#go_currency")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#go_currency/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarRoleListView:addEvents()
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
end

function V3a9RacingCarRoleListView:removeEvents()
	self._btnenter:RemoveClickListener()
end

function V3a9RacingCarRoleListView:_btnenterOnClick()
	if self._isEnterGame then
		logError("V3a9RacingCarRoleListView the game is already enter")

		return
	end

	self._isEnterGame = true

	UIBlockHelper.instance:startBlock("V3a9RacingCarRoleListView enterGame", 0.2)
	V3a9RacingCarModel.instance:setMainPlayerRacer(V3a9RacingCarRoleListModel.instance:getSelectedConfig())
	self._animatorPlayer:Play("close", self._onCloseAnimDone, self)
end

function V3a9RacingCarRoleListView:_onCloseAnimDone()
	V3a9RacingCarController.instance:enterRacingCarGame()
end

function V3a9RacingCarRoleListView:_editableInitView()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._goCurrency = gohelper.findChild(self.viewGO, "root/#go_currency/CurrencyIcon")

	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.onUnlockRole, self._onUnlockRole, self)
end

function V3a9RacingCarRoleListView:_onCurrencyClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, self._currencyMO.currencyId, false, nil, true)
end

function V3a9RacingCarRoleListView:_onUnlockRole()
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayCikexiaLinkReceiveAward)
	V3a9RacingCarRoleListModel.instance:onModelUpdate()
	self:_refershCurrency()
end

function V3a9RacingCarRoleListView:onOpen()
	self._actId = self.viewParam.actId

	local currencyID = V3a9RacingTalentModel.instance:getCurrencyId(self._actId)

	self._currencyMO = CurrencyModel.instance:getCurrency(currencyID)

	self:_refershCurrency()

	local playerInfo = PlayerModel.instance:getPlayinfo()
	local playerName = playerInfo and playerInfo.name

	self._txttitle.text = string.format(luaLang("v3a9Racing_car_selectdesc"), playerName)

	local episodeConfig = V3a9RacingCarSectionListModel.instance:getSelectedConfig()
	local gameLevelConfig = lua_racing_game_level.configDict[episodeConfig.gameId]

	self._txtdesc.text = gameLevelConfig.desc
end

function V3a9RacingCarRoleListView:_refershCurrency()
	if self._currencyMO then
		if not self._currencyMO.quantity then
			local quantity = 0

			self._txtnum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function V3a9RacingCarRoleListView:onClose()
	return
end

function V3a9RacingCarRoleListView:onDestroyView()
	return
end

return V3a9RacingCarRoleListView
