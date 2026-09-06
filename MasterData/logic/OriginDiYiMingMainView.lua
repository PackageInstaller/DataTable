-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindiyiming/view/OriginDiYiMingMainView.lua

module("logic.extensions.origindiyiming.view.OriginDiYiMingMainView", package.seeall)

local OriginDiYiMingMainView = class("OriginDiYiMingMainView", InfinitefutureView)

function OriginDiYiMingMainView:_onClickTab(index)
	self:showTabAt(self._container, ViewName.OriginDiYiMingChallengeView)

	for i = 1, 3 do
		self._tabs[i].selected:SetActive(i == 1)
	end

	InfinitefutureView.PageIndex = 1
end

function OriginDiYiMingMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "origin_diyiming_clg_rule")
end

function OriginDiYiMingMainView:setIds()
	local activityId = checknumber(self:getFirstParam())
	local petId = 11008

	if not activityId then
		activityId = 123012
	else
		local actCfg = InfinitefutureConfig.instance:getPlanCfg(activityId)

		if actCfg and checknumber(actCfg.skinId) ~= 0 then
			petId = actCfg.skinId
		end
	end

	InfinitefutureModel.instance.curActId = activityId
	InfinitefutureModel.instance.curPetId = petId
end

return OriginDiYiMingMainView
