-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/formation/SRFmtRightView.lua

module("logic.extensions.sunranbattle.view.formation.SRFmtRightView", package.seeall)

local SRFmtRightView = class("SRFmtRightView", FormationRightView)

function SRFmtRightView:_setJobLabelStr()
	self._jobLabelStr = nil

	local params = self._viewPresentor:getFirstParam()

	if params and params.conList and #params.conList > 0 then
		for i = 1, #params.conList do
			local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(checknumber(params.conList[i]))

			if cfg then
				self._jobLabelStr = cfg.label

				return
			end
		end
	end
end

return SRFmtRightView
