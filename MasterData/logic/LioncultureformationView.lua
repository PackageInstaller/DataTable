-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureformationView.lua

module("logic.extensions.lionculture.view.LioncultureformationView", package.seeall)

local LioncultureformationView = class("LioncultureformationView", ViewComponent)

function LioncultureformationView:ctor()
	LioncultureformationView.super.ctor(self)
end

function LioncultureformationView:unbindEvents()
	LioncultureformationView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnIntroduce)
	self._btnTip:RemoveClickListener()
end

function LioncultureformationView:bindEvents()
	LioncultureformationView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._openGameOnClick, self)
	GameUtil.addClickHandler(self._btnClose, self._closeView, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._btnIntroduceOnClick, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule5")
	end, self)
end

function LioncultureformationView:buildUI()
	LioncultureformationView.super.buildUI(self)

	self._btnChallenge = goutil.findChild(self.mainGO, "challengeCol/btnChallenge")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnIntroduce = goutil.findChild(self.mainGO, "challengeCol/btnIntroduce")
	self._con = goutil.findChild(self.mainGO, "challengeCol/role")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnTxt = self:getTxt("challengeCol/btnChallenge/Text")
end

function LioncultureformationView:onExit()
	LioncultureformationView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleModel)
end

function LioncultureformationView:onEnter()
	LioncultureformationView.super.onEnter(self)

	self._activityId = LioncultureController.instance:getActivityId()
	self._gameId = 4
	self._isOver = LioncultureModel.instance.gameLevels[self._gameId]
	self.typeConfig = LioncultureConfig.instance:getGameData(LioncultureModel.instance.activityId, self._gameId)

	if not GameUtil.getUserData(ViewName.LioncultureformationView) then
		UIStateManager.instance:push(ViewName.LionculturetipView, self.typeConfig.desc)
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule5")
		GameUtil.saveUserData(ViewName.LioncultureformationView, true)
	end

	self:_init()
end

function LioncultureformationView:_init()
	self._btnTxt.text = self._isOver == 2 and "挑战成功" or "开始布阵"

	self:_showSpriteRawInfo()
end

function LioncultureformationView:_onClickBtnEnterChallenge()
	LioncultureController.instance:enterBattleAsCorPr(self._activityId, self._gameId)
end

function LioncultureformationView:_openGameOnClick()
	if self._isOver == 0 then
		LioncultureController.instance:sendPM_WakingLionGameStartGameReq(self._gameId)
		UIStateManager.instance:push(ViewName.LioncultureFormationGameView, self._gameId)
	elseif self._isOver == 1 then
		LioncultureController.instance:enterBattleAsCorPr(self._activityId, self._gameId)
	elseif self._isOver == 2 then
		FloatWordMgr.instance:show("恭喜你，已战胜渊魔!")
	else
		printError("lbc=====奇怪的id:", self._isOver)
	end
end

function LioncultureformationView:_closeView()
	self:close()
end

function LioncultureformationView:_btnIntroduceOnClick()
	UIStateManager.instance:push(ViewName.LionculturefmtintroduceView)
end

function LioncultureformationView:_showSpriteRawInfo()
	local x, y, scale = 0, 0, 0.5

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, 10369, self._con, scale, function(obj)
		return
	end, true, x, y)
end

return LioncultureformationView
