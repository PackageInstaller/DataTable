-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/formation/MoonKingFmtRightView.lua

module("logic.extensions.moonking.view.formation.MoonKingFmtRightView", package.seeall)

local MoonKingFmtRightView = class("MoonKingFmtRightView", FormationRightView)

function MoonKingFmtRightView:_setJobLabelStr()
	self._jobLabelStr = nil

	local params = self._viewPresentor:getFirstParam()

	if params == nil then
		return
	end

	local planCfg = MoonKingConfig.instance:getBattlePlanCfg(MoonKingModel.instance.challengeId, params.groupId)

	if planCfg then
		self._jobLabelStr = "战斗效果：" .. planCfg.buffDesc
	end
end

return MoonKingFmtRightView
