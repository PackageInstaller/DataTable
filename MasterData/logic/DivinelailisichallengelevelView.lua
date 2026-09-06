-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelailisi/view/DivinelailisichallengelevelView.lua

module("logic.extensions.divinelailisi.view.DivinelailisichallengelevelView", package.seeall)

local DivinelailisichallengelevelView = class("DivinelailisichallengelevelView", YuHuiChallengeLevelView)

function DivinelailisichallengelevelView:ctor()
	DivinelailisichallengelevelView.super.ctor(self)
end

function DivinelailisichallengelevelView:unbindEvents()
	DivinelailisichallengelevelView.super.unbindEvents(self)
end

function DivinelailisichallengelevelView:bindEvents()
	DivinelailisichallengelevelView.super.bindEvents(self)
end

function DivinelailisichallengelevelView:buildUI()
	DivinelailisichallengelevelView.super.buildUI(self)

	self._txDesc = self:getTxt("desc/txDesc")
end

function DivinelailisichallengelevelView:onExit()
	DivinelailisichallengelevelView.super.onExit(self)
end

function DivinelailisichallengelevelView:onEnter()
	DivinelailisichallengelevelView.super.onEnter(self)

	self._curChallengeId = checknumber(self:getFirstParam())
end

function DivinelailisichallengelevelView:_refreshLevelPart()
	DivinelailisichallengelevelView.super._refreshLevelPart(self)

	if #self._stageCfgs < self._curStageId then
		if not #self._stageCfgs then
			local stageId = self._curStageId

			if not self._stageCfgs[stageId] then
				local stageCfg = {}

				self._txDesc.text = stageCfg.ruleDesc
			end
		end
	end
end

function DivinelailisichallengelevelView:_onClickTip()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(DivinelailisichallengemainView.ChallengeId)

	UIStateManager.instance:push(ViewName.RulesView, challengeCfg.ruleKey)
end

return DivinelailisichallengelevelView
