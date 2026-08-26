-- chunkname: @modules/logic/partygame/view/common/PartyGameTeamResultView.lua

module("modules.logic.partygame.view.common.PartyGameTeamResultView", package.seeall)

local PartyGameTeamResultView = class("PartyGameTeamResultView", BaseView)

function PartyGameTeamResultView:onInitView()
	self._gofullbgwin = gohelper.findChild(self.viewGO, "#go_fullbg_win")
	self._gofullbgfail = gohelper.findChild(self.viewGO, "#go_fullbg_fail")
	self._goteam = gohelper.findChild(self.viewGO, "root/#go_team")
	self._txtgametitle = gohelper.findChildText(self.viewGO, "root/#go_team/#txt_gametitle")
	self._gosuccess = gohelper.findChild(self.viewGO, "root/#go_team/#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "root/#go_team/#go_fail")
	self._gogrid = gohelper.findChild(self.viewGO, "root/#go_team/#go_grid")
	self._goplayeritem = gohelper.findChild(self.viewGO, "root/#go_team/#go_grid/#go_playeritem")
	self._txtcountdown = gohelper.findChildText(self.viewGO, "root/#txt_countdown")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._gobluewin = gohelper.findChild(self.viewGO, "root/#go_teamcomplete /#go_bluewin")
	self._goredwin = gohelper.findChild(self.viewGO, "root/#go_teamcomplete /#go_redwin")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameTeamResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function PartyGameTeamResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function PartyGameTeamResultView:_btncloseOnClick()
	if not self._canExit then
		return
	end

	local partyGame = PartyGameController.instance:getCurPartyGame()

	if partyGame ~= nil and partyGame:getIsLocal() and not partyGame:getIsTrial() then
		PartyGameController.instance:exitGame()
	end

	self:closeThis()
end

function PartyGameTeamResultView:_editableInitView()
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function PartyGameTeamResultView:onUpdateParam()
	return
end

function PartyGameTeamResultView:onOpen()
	self._canExit = false

	gohelper.setActive(self._gofullbg, false)
	gohelper.setActive(self._goteam, false)
	gohelper.setActive(self._txtcountdown.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum3_4.PartyGameCommon.play_ui_shengyan_box_songjin_win)
	self:initView()
end

function PartyGameTeamResultView:initView()
	self._curGame = PartyGameController.instance:getCurPartyGame()
	self._gameConfig = self._curGame:getGameConfig()
	self._mainPlayerUid = self._curGame:getMainPlayerUid()

	local playerMo = PartyGameModel.instance:getPlayerMoByUid(self._mainPlayerUid)

	if playerMo == nil then
		return
	end

	self.teamAllPlayers = PartyGameModel.instance:getAllTeamPlayerMoByUid(playerMo.tempType)

	local winTeam = self._curGame:getWinTeam()

	if winTeam == 3 then
		winTeam = playerMo.tempType
	end

	self._curPlayerIsWin = winTeam == playerMo.tempType

	gohelper.setActive(self._gosuccess, self._curPlayerIsWin)
	gohelper.setActive(self._gofail, not self._curPlayerIsWin)
	gohelper.setActive(self._gofullbgwin, self._curPlayerIsWin)
	gohelper.setActive(self._gofullbgfail, not self._curPlayerIsWin)
	gohelper.setActive(self._gobluewin, winTeam == PartyGameEnum.GamePlayerTeamType.Blue)
	gohelper.setActive(self._goredwin, winTeam == PartyGameEnum.GamePlayerTeamType.Red)

	self._txtgametitle.text = self._gameConfig.name

	self:_showTeam()
end

function PartyGameTeamResultView:_showTeam()
	AudioMgr.instance:trigger(AudioEnum3_4.PartyGameCommon.play_ui_yuzhou_ball_fall)

	self._canExit = true

	gohelper.setActive(self._gofullbg, true)
	gohelper.setActive(self._goteam, true)
	gohelper.setActive(self._txtcountdown.gameObject, true)

	if self.teamAllPlayers ~= nil then
		gohelper.CreateObjList(self, self._onItemShow, self.teamAllPlayers, self._gogrid, self._goplayeritem)
	end

	self._countDownTime = PartyGameEnum.resultCountDownTime

	TaskDispatcher.runRepeat(self._refreshCountDown, self, 1)

	local key = self._curPlayerIsWin and "win_open" or "lose_open"

	if self._anim then
		self._anim:Play(key, 0, 0)
	end
end

function PartyGameTeamResultView:_refreshCountDown()
	self._countDownTime = self._countDownTime - 1
	self._txtcountdown.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_resultViewCount"), self._countDownTime)

	if self._countDownTime <= 0 then
		self:_btncloseOnClick()
	end
end

function PartyGameTeamResultView:_onItemShow(obj, data, index)
	local arrow = gohelper.findChild(obj, "#go_arrow")
	local spinePoint = gohelper.findChild(obj, "#go_spinePoint")
	local playerInfo = gohelper.findChild(obj, "#go_playerinfo")
	local hpPosGo = gohelper.findChild(obj, "#go_playerinfo/#go_hpPos")
	local playerInfo = MonoHelper.addNoUpdateLuaComOnceToGo(playerInfo, PlayerInfoItem)

	playerInfo:Init(data)

	local spineComp = MonoHelper.addNoUpdateLuaComOnceToGo(spinePoint, CommonPartyGamePlayerSpineComp)

	spineComp:initSpine(data.uid)

	if data.tempType == self._curGame:getWinTeam() then
		spineComp:playAnim("happyLoop", true, false)
	end

	playerInfo:ShowMainPlayer()

	if playerInfo._isMain then
		self:checkAndHp(hpPosGo, playerInfo:getRank())
	end

	gohelper.setActive(arrow, playerInfo._isMain)
	gohelper.setActive(obj, true)
end

function PartyGameTeamResultView:checkAndHp(parent, rank)
	local rewardMo = PartyGameModel.instance:getCurBattleRewardInfo()

	if rewardMo == nil or rewardMo.rewardHp <= 0 then
		return
	end

	local itemRes = self.viewContainer:getSetting().otherRes.rewardHp
	local go = self.viewContainer:getResInst(itemRes, parent)

	self._resultHp = MonoHelper.addNoUpdateLuaComOnceToGo(go, CommonPartyGameResultHp)

	self._resultHp:init(go)
	self._resultHp:refreshHp(rank, rewardMo.rewardHp)
end

function PartyGameTeamResultView:onClose()
	TaskDispatcher.cancelTask(self._showTeam, self)
	TaskDispatcher.cancelTask(self._refreshCountDown, self)
end

function PartyGameTeamResultView:onDestroyView()
	if self._resultHp then
		self._resultHp:onDestroy()

		self._resultHp = nil
	end
end

return PartyGameTeamResultView
