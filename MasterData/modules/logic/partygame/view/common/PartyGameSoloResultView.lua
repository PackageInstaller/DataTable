-- chunkname: @modules/logic/partygame/view/common/PartyGameSoloResultView.lua

module("modules.logic.partygame.view.common.PartyGameSoloResultView", package.seeall)

local PartyGameSoloResultView = class("PartyGameSoloResultView", BaseView)

function PartyGameSoloResultView:onInitView()
	self._gofullbgwin = gohelper.findChild(self.viewGO, "#go_fullbg_win")
	self._gofullbgfail = gohelper.findChild(self.viewGO, "#go_fullbg_fail")
	self._gosolo = gohelper.findChild(self.viewGO, "root/#go_solo")
	self._txtrank = gohelper.findChildText(self.viewGO, "root/#go_solo/left/#txt_rank")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#go_solo/left/#txt_desc")
	self._txtgametitle = gohelper.findChildText(self.viewGO, "root/#go_solo/left/#txt_gametitle")
	self._goPlayers = gohelper.findChild(self.viewGO, "root/#go_solo/#go_Players")
	self._goperson = gohelper.findChild(self.viewGO, "root/#go_solo/#go_person")
	self._gohpPos = gohelper.findChild(self.viewGO, "root/#go_solo/#go_hpPos")
	self._txtcountdown = gohelper.findChildText(self.viewGO, "root/#txt_countdown")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._gosolocomplete = gohelper.findChild(self.viewGO, "root/#go_solocomplete")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameSoloResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function PartyGameSoloResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function PartyGameSoloResultView:_btncloseOnClick()
	if not self._canExit then
		return
	end

	local partyGame = PartyGameController.instance:getCurPartyGame()

	if partyGame ~= nil and partyGame:getIsLocal() and not partyGame:getIsTrial() then
		PartyGameController.instance:exitGame()
	end

	self:closeThis()
end

function PartyGameSoloResultView:onClickModalMask()
	self:_btncloseOnClick()
end

function PartyGameSoloResultView:_editableInitView()
	local itemRes = self.viewContainer:getSetting().otherRes.playerInfo
	local go = self.viewContainer:getResInst(itemRes, self._goPlayers)

	self._playerInfoComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PlayerInfoComp)
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function PartyGameSoloResultView:onUpdateParam()
	return
end

function PartyGameSoloResultView:onOpen()
	gohelper.setActive(self._gosolo, false)
	gohelper.setActive(self._gosolocomplete, true)
	gohelper.setActive(self._txtcountdown.gameObject, false)

	self._canExit = false

	self:initView()
	self:_showSolo()
	self:checkAndHp()
end

function PartyGameSoloResultView:checkAndHp()
	local rewardMo = PartyGameModel.instance:getCurBattleRewardInfo()

	if rewardMo == nil or rewardMo.rewardHp <= 0 then
		return
	end

	local itemRes = self.viewContainer:getSetting().otherRes.rewardHp
	local go = self.viewContainer:getResInst(itemRes, self._gohpPos)

	self._resultHp = MonoHelper.addNoUpdateLuaComOnceToGo(go, CommonPartyGameResultHp)

	self._resultHp:init(go)
	self._resultHp:refreshHp(self._curGame:getRank(self._mainPlayerUid), rewardMo.rewardHp)
end

function PartyGameSoloResultView:initView()
	if self._playerInfoComp then
		self._playerInfoComp:Init()
		self._playerInfoComp:viewDataUpdate()
	end

	self._curGame = PartyGameController.instance:getCurPartyGame()
	self._gameConfig = self._curGame:getGameConfig()
	self._mainPlayerUid = self._curGame:getMainPlayerUid()
	self._mainPlayerRank = self._curGame:getRank(self._mainPlayerUid)
	self._playerIsWin = self._mainPlayerRank == 1
	self._txtgametitle.text = self._gameConfig.name
	self._txtrank.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_gamerank"), self._curGame:getRank(self._mainPlayerUid))
	self._txtdesc.text = luaLang("knockout_result_solo_" .. self._mainPlayerRank)
end

function PartyGameSoloResultView:_showSolo()
	self._canExit = true

	gohelper.setActive(self._gosolo, true)
	gohelper.setActive(self._gofullbg, true)
	gohelper.setActive(self._gosolocomplete, false)
	gohelper.setActive(self._txtcountdown.gameObject, true)

	self._spineComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goperson, CommonPartyGamePlayerSpineComp)

	self._spineComp:initSpine(self._mainPlayerUid)

	if self._playerIsWin then
		self._spineComp:playAnim("happyLoop", true, false)
	end

	self._countDownTime = PartyGameEnum.resultCountDownTime + 1

	TaskDispatcher.runRepeat(self._refreshCountDown, self, 1)
	self:_refreshCountDown()

	local key = self._playerIsWin and "win_open" or "lose_open"

	if self._anim then
		self._anim:Play(key, 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum3_4.PartyGameCommon.play_ui_mln_day_night)
end

function PartyGameSoloResultView:_refreshCountDown()
	self._countDownTime = self._countDownTime - 1
	self._txtcountdown.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_resultViewCount"), self._countDownTime)

	if self._countDownTime <= 0 then
		self:_btncloseOnClick()
	end
end

function PartyGameSoloResultView:onClose()
	TaskDispatcher.cancelTask(self._showSolo, self)
	TaskDispatcher.cancelTask(self._refreshCountDown, self)
end

function PartyGameSoloResultView:onDestroyView()
	if self._spineComp ~= nil then
		self._spineComp:onDestroy()

		self._spineComp = nil
	end

	if self._resultHp then
		self._resultHp:onDestroy()

		self._resultHp = nil
	end
end

return PartyGameSoloResultView
