-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleactions/model/RoleActionsModel.lua

module("logic.extensions.roleactions.model.RoleActionsModel", package.seeall)

local RoleActionsModel = class("RoleActionsModel", BaseModel)

function RoleActionsModel:onInit()
	self:onReset()
end

function RoleActionsModel:onReset()
	self._newActions = nil
end

function RoleActionsModel:hasNewActions()
	if not self._newActions then
		return false
	end

	if not MonthCardModel.instance:isCardActive(2) then
		return false
	end

	return table.nums(self._newActions) > 0
end

function RoleActionsModel:loadNewActionsConfig()
	local userId = LoginModel.instance.userId

	if userId then
		local actions = RoleActionsConfig.instance:getRoleActions()

		for i = 1, #actions do
			if actions[i].access == 1 then
				local hasSel = UnityEngine.PlayerPrefs.GetInt("roleactions_" .. userId .. "_" .. actions[i].id, 0) > 0

				if not hasSel then
					self._newActions = self._newActions or {}
					self._newActions[actions[i].id] = true
				end
			end
		end
	end
end

function RoleActionsModel:setNotNewAction(id)
	if not self._newActions then
		return
	end

	local acCo = RoleActionsConfig.instance:getRoleActionCo(id)

	if acCo.access == 1 then
		self._newActions[acCo.id] = nil

		local userId = LoginModel.instance.userId

		if userId then
			UnityEngine.PlayerPrefs.SetInt("roleactions_" .. userId .. "_" .. acCo.id, 1)
		end
	end
end

function RoleActionsModel:isNewAction(id)
	if not self:hasNewActions() then
		return false
	end

	return self._newActions[id] or false
end

function RoleActionsModel:_onNotifyMonthCardBuySucRes(id)
	if not MonthCardModel.instance:isCardActive(2) then
		return false
	end
end

RoleActionsModel.instance = RoleActionsModel.New()

return RoleActionsModel
