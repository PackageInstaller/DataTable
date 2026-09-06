-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolRenZhengView.lua

module("logic.extensions.magicschool.view.MagicSchoolRenZhengView", package.seeall)

local MagicSchoolRenZhengView = class("MagicSchoolRenZhengView", ViewComponent)
local BLACK_CAMP_ID = 1
local WHITE_CAMP_ID = 2

function MagicSchoolRenZhengView:ctor()
	MagicSchoolRenZhengView.super.ctor(self)
end

function MagicSchoolRenZhengView:unbindEvents()
	MagicSchoolRenZhengView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallengeBlack)
	GameUtil.rmClickHandler(self._lockBlack)
	GameUtil.rmClickHandler(self._btnChallengeWhite)
	GameUtil.rmClickHandler(self._lockWhite)
end

function MagicSchoolRenZhengView:bindEvents()
	MagicSchoolRenZhengView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallengeBlack, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._lockBlack, GameUtil.handler(self._onClickBtnLock, self, BLACK_CAMP_ID))
	GameUtil.addClickHandler(self._btnChallengeWhite, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._lockWhite, GameUtil.handler(self._onClickBtnLock, self, WHITE_CAMP_ID))
end

function MagicSchoolRenZhengView:buildUI()
	MagicSchoolRenZhengView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnChallengeBlack = self:getGo("black/btnChallenge")
	self._lockBlack = self:getGo("black/lock")
	self._btnChallengeWhite = self:getGo("white/btnChallenge")
	self._lockWhite = self:getGo("white/lock")
	self._txtBlack = self:getTxt("ScrollViewBlack/Viewport/Content")
	self._txtWhite = self:getTxt("ScrollViewWhite/Viewport/Content")
end

function MagicSchoolRenZhengView:onExit()
	MagicSchoolRenZhengView.super.onExit(self)
end

function MagicSchoolRenZhengView:onEnter()
	MagicSchoolRenZhengView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 514001
	end

	self._campId = checknumber(params[2])
	self._actCfg = MagicSchoolConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
end

function MagicSchoolRenZhengView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._txtBlack.text = self._actCfg.blackCampDesc
	self._txtWhite.text = self._actCfg.whiteCampDesc

	GameUtil.SetActive(self._btnChallengeBlack, self._campId == BLACK_CAMP_ID)
	GameUtil.SetActive(self._lockBlack, self._campId ~= BLACK_CAMP_ID)
	GameUtil.SetActive(self._btnChallengeWhite, self._campId == WHITE_CAMP_ID)
	GameUtil.SetActive(self._lockWhite, self._campId ~= WHITE_CAMP_ID)
end

function MagicSchoolRenZhengView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function MagicSchoolRenZhengView:_onClickBtnChallenge()
	UIStateManager.instance:push(ViewName.MagicSchoolChallengeView, self._activityId, self._campId)
end

function MagicSchoolRenZhengView:_onClickBtnLock(campId)
	if campId == BLACK_CAMP_ID then
		FloatWordMgr.instance:show("需成为黑魔法师后才可挑战")
	else
		FloatWordMgr.instance:show("需成为白魔法师后才可挑战")
	end
end

return MagicSchoolRenZhengView
