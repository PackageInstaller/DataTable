-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/YishiChallengeMainView.lua

module("logic.extensions.yishichallenge.view.YishiChallengeMainView", package.seeall)

local YishiChallengeMainView = class("YishiChallengeMainView", ViewComponent)

function YishiChallengeMainView:ctor()
	YishiChallengeMainView.super.ctor(self)

	self._challengeId = 99
end

function YishiChallengeMainView:unbindEvents()
	YishiChallengeMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnCall:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
end

function YishiChallengeMainView:bindEvents()
	YishiChallengeMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._closeView, self)
	self._btnTip:AddClickListener(self._tipsOnClick, self)
	self._btnShop:AddClickListener(self._shopOnClick, self)
	self._btnRank:AddClickListener(self._rankOnClick, self)
	self._btnCall:AddClickListener(self._callOnClick, self)
	self._btnEnter:AddClickListener(self._enterOnClick, self)
	self._btnSkill:AddClickListener(self._skillOnClick, self)
	self._btnIntroduce:AddClickListener(self._introduceOnClick, self)
end

function YishiChallengeMainView:onExit()
	YishiChallengeMainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	MaterialMgr.resetAll(self._pointRare)
	RedPointController.instance:unregRedPoint(self._enterRedPoint)
end

function YishiChallengeMainView:buildUI()
	YishiChallengeMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnShop = self:getBtn("jumpButton/btnShop")
	self._btnRank = self:getBtn("jumpButton/btnRank")
	self._btnCall = self:getBtn("jumpButton/btnCall")
	self._btnEnter = self:getBtn("btnEnter")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnIntroduce = self:getBtn("petInfo/btnIntroduce")
	self._txtTime = self:getTxt("time/txt")
	self._petCon = self:getGo("petCon")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._enterRedPoint = self:getGo("btnEnter/redPoint")
	self._shopRedPoint = self:getGo("jumpButton/btnShop/redpoint")
	self._rankRedPoint = self:getGo("jumpButton/btnRank/redpoint")
	self._callRedPoint = self:getGo("jumpButton/btnCall/redpoint")
	self._pass = self:getGo("pass")
end

function YishiChallengeMainView:onEnter()
	YishiChallengeMainView.super.onEnter(self)
	YishiChallengeModel.instance:setChallengeId(self._challengeId)

	self._cfg = YishiChallengeConfig.instance:getCfgById(self._challengeId)
	self._txtTime.text = TimeGateController.instance:getActTimeShowByChallengeId(self._challengeId)

	self:_roleCon()
	self:_getRedPointState()
	self.addGEvent(self, GlobalNotify.YishiChallengeInfoReq, self._handleGetInfo, self)
	YiShiChallengeAgent.instance:sendPM_YiShiChallengeInfoReq(self._challengeId)
end

function YishiChallengeMainView:_closeView()
	self:close()
end

function YishiChallengeMainView:_tipsOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "YishiChallengeRule_1")
end

function YishiChallengeMainView:_enterOnClick()
	if self._isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.YishiChallengeLevelView)
end

function YishiChallengeMainView:_shopOnClick()
	self:_setRedPointState(self._cfg.jump_shop)
	GotoMgr.gotoByString(self._cfg.jump_shop)
end

function YishiChallengeMainView:_rankOnClick()
	self:_setRedPointState(self._cfg.jump_rank)
	GotoMgr.gotoByString(self._cfg.jump_rank)
end

function YishiChallengeMainView:_callOnClick()
	self:_setRedPointState(self._cfg.jump_lotery)
	GotoMgr.gotoByString(self._cfg.jump_lotery)
end

function YishiChallengeMainView:_setRedPointState(name)
	if not GameUtil.getUserDayData("yishichallengemainview_" .. name) then
		GameUtil.saveUserDayData("yishichallengemainview_" .. name, true)
	end
end

function YishiChallengeMainView:_getRedPointState()
	RedPointController.instance:regRedPoint(self._enterRedPoint, RedPointModel.ID_YISHI)
	goutil.setActive(self._shopRedPoint, not GameUtil.getUserDayData("yishichallengemainview_" .. self._cfg.jump_shop))
	goutil.setActive(self._rankRedPoint, not GameUtil.getUserDayData("yishichallengemainview_" .. self._cfg.jump_rank))
	goutil.setActive(self._callRedPoint, not GameUtil.getUserDayData("yishichallengemainview_" .. self._cfg.jump_lotery))
end

function YishiChallengeMainView:_skillOnClick()
	local skinId = checknumber(self._cfg.raceId)

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

function YishiChallengeMainView:_introduceOnClick()
	PetbookController.instance:openPetinfoView(checknumber(self._cfg.raceId))
end

function YishiChallengeMainView:_roleCon()
	local modelCfg = YishiChallengeConfig.instance:getPetPos(self._challengeId)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._cfg.raceId, self._petCon, modelCfg[3], nil, true, modelCfg[1], modelCfg[2])

	MaterialMgr.setCell(MatType.Rare, self._cfg.raceId, self._pointRare)
end

function YishiChallengeMainView:_handleGetInfo()
	self._isPass = YishiChallengeModel.instance:getStageUnlock()

	goutil.setActive(self._pass, self._isPass)
end

return YishiChallengeMainView
