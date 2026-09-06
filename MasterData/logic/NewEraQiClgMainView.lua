-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/newerachallenge/NewEraQiClgMainView.lua

module("logic.extensions.wuwenchallenge.view.newerachallenge.NewEraQiClgMainView", package.seeall)

local NewEraQiClgMainView = class("NewEraQiClgMainView", AnmoyanchallengemainView)

function NewEraQiClgMainView:ctor()
	NewEraQiClgMainView.super.ctor(self)
end

function NewEraQiClgMainView:unbindEvents()
	NewEraQiClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnShop)
end

function NewEraQiClgMainView:bindEvents()
	NewEraQiClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
end

function NewEraQiClgMainView:buildUI()
	NewEraQiClgMainView.super.buildUI(self)

	self._btnShop = self:getGo("btnShop")
end

function NewEraQiClgMainView:onExit()
	NewEraQiClgMainView.super.onExit(self)
end

function NewEraQiClgMainView:onEnter()
	NewEraQiClgMainView.super.onEnter(self)
end

function NewEraQiClgMainView:_onClickShop()
	GotoMgr.gotoByString(self._actCfg.jumpTo[4])
end

function NewEraQiClgMainView:_onClickRule()
	TipsFacade.instance:openRulesView("neweraqi_clgmainview_rule")
end

function NewEraQiClgMainView:_onClickChallenge()
	local levelCfgs = WuWenChallengeConfig.instance:getPhaseCfgs(self._activityId)

	if WuWenChallengeModel.instance:getCurLevel(self._activityId) > #levelCfgs then
		FloatWordMgr.instance:show(lang("您已通关"))

		return
	else
		UIStateManager.instance:push(ViewName.NewEraQiClgLevelView, self._activityId)
	end
end

return NewEraQiClgMainView
