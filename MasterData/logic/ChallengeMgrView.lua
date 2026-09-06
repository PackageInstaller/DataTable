-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/ChallengeMgrView.lua

module("logic.extensions.challenge.view.ChallengeMgrView", package.seeall)

local ChallengeMgrView = class("ChallengeMgrView", ViewComponent)

ChallengeMgrView.CurClass = nil

function ChallengeMgrView:ctor()
	ChallengeMgrView.super.ctor(self)
end

function ChallengeMgrView:bindEvents()
	GlobalDispatcher:addListener(GlobalNotify.ChallengeExtParamUpdate, self._onChallengeExtParamUpdate, self)
	ChallengeController.instance:registerLocalNotify("PrizeGot", self._prizeGot, self)
	ChallengeController.instance:registerLocalNotify("TeamFightEnd", self._teamFightEnd, self)
end

function ChallengeMgrView:unbindEvents()
	ChallengeController.instance:unregisterLocalNotify("PrizeGot", self._prizeGot, self)
	ChallengeController.instance:unregisterLocalNotify("TeamFightEnd", self._teamFightEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.ChallengeExtParamUpdate, self._onChallengeExtParamUpdate, self)
end

function ChallengeMgrView:buildUI()
	self._closeButton = self:getBtn("Btn_Close")

	local chooseRoot = self:getGo("ChooseRoot")

	self._prefabLoader = PrefabLoader.Get(chooseRoot)
end

function ChallengeMgrView:destroyUI()
	ChallengeMgrView.CurClass = nil
end

function ChallengeMgrView:onEnter()
	self._openByJumper = self._viewPresentor._openParam and self._viewPresentor._openParam[1] or false
	self._challengeId = ChallengeModel.instance:getCurId()
	self._cfg = ChallengeConfig.instance:getChallengeCfg(self._challengeId)

	if self._cfg and self._cfg.choosePrefab ~= "" then
		local url = "ui/views/challenge/choose/" .. self._cfg.choosePrefab .. ".prefab"

		self._prefabLoader:load(url, self._onMissionChoosePrefabLoaded, self, true)
	else
		ChallengeMgrView.CurClass = ChallengeMini.New()

		ChallengeMgrView.CurClass:onEnter(self._cGo, self._cfg, self._openByJumper)
	end
end

function ChallengeMgrView:onEnterFinished()
	return
end

function ChallengeMgrView:onExit()
	if ChallengeMgrView.CurClass then
		ChallengeMgrView.CurClass:onExit()
	end

	self._prefabLoader:clear()

	self._cGo = nil
end

function ChallengeMgrView:onExitFinished()
	return
end

function ChallengeMgrView:_prizeGot()
	if ChallengeMgrView.CurClass then
		ChallengeMgrView.CurClass:_prizeGot()
	end
end

function ChallengeMgrView:_teamFightEnd(params)
	if ChallengeMgrView.CurClass then
		ChallengeMgrView.CurClass:teamFightEnd(params)
	end
end

function ChallengeMgrView:_onChallengeExtParamUpdate()
	printInfo("进来了")

	if ChallengeMgrView.CurClass and ChallengeMgrView.CurClass._onChallengeExtParamUpdate then
		ChallengeMgrView.CurClass:_onChallengeExtParamUpdate()
	end
end

function ChallengeMgrView:_onMissionChoosePrefabLoaded(loader)
	self._cGo = self._prefabLoader:getInst()
	ChallengeMgrView.CurClass = Framework.LuaComponentContainer.Add(self._cGo, self:_getCls())

	ChallengeMgrView.CurClass:setView(self)
	self:SetCurClassParent()

	if self._viewPresentor._openParam then
		ChallengeMgrView.CurClass:onEnter(self._cGo, self._cfg, self._viewPresentor._openParam[1])
	else
		ChallengeMgrView.CurClass:onEnter(self._cGo, self._cfg)
	end
end

function ChallengeMgrView:_getCls()
	return ChallengeTables[self._challengeId] or ChallengeViewBase
end

function ChallengeMgrView:SetCurClassParent()
	if ChallengeMgrView.CurClass and ChallengeMgrView.CurClass.SetCurClassParent then
		ChallengeMgrView.CurClass:SetCurClassParent(self)
	end
end

return ChallengeMgrView
