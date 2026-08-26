-- chunkname: @modules/logic/rouge2/start/model/Rouge2_CareerSelectListModel.lua

module("modules.logic.rouge2.start.model.Rouge2_CareerSelectListModel", package.seeall)

local Rouge2_CareerSelectListModel = class("Rouge2_CareerSelectListModel", ListScrollModel)

function Rouge2_CareerSelectListModel:init()
	self._curSelectCellIndex = nil

	local careerCoList = Rouge2_CareerConfig.instance:getAllCareerConfigs()

	self:setList(careerCoList)
	self:selectCell(1, true)
end

function Rouge2_CareerSelectListModel:selectCell(index, isSelect)
	if self._curSelectCellIndex == index and isSelect then
		return
	end

	Rouge2_CareerSelectListModel.super.selectCell(self, index, isSelect)

	self._curSelectCellIndex = index

	local careerCo = self:getByIndex(index)
	local careerId = careerCo and careerCo.id

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectCareer, careerId)
end

function Rouge2_CareerSelectListModel:switch2Next(isNext)
	local canSwitch = self:canSwitch(isNext)

	if canSwitch then
		if isNext then
			self:selectCell(self._curSelectCellIndex + 1, true)
		else
			self:selectCell(self._curSelectCellIndex - 1, true)
		end
	end
end

function Rouge2_CareerSelectListModel:canSwitch(isNext)
	if isNext then
		if not (self._curSelectCellIndex + 1) then
			local targetCareerIndex = self._curSelectCellIndex - 1
			local careerCo = self:getByIndex(targetCareerIndex)

			if not careerCo then
				return
			end

			local isUnlock, toastId = Rouge2_OutsideModel.instance:isUnlockCareer(careerCo.id)

			return isUnlock, toastId
		end
	end
end

Rouge2_CareerSelectListModel.instance = Rouge2_CareerSelectListModel.New()

return Rouge2_CareerSelectListModel
