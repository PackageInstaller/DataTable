-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotrecall/model/PlotRecallModel.lua

module("logic.extensions.plotcopy.model.PlotRecallModel", package.seeall)

local PlotRecallModel = class("PlotRecallModel", BaseModel)

function PlotRecallModel:ctor()
	self.selectCGId = nil
end

function PlotRecallModel:onInit()
	self:onReset()
end

function PlotRecallModel:onReset()
	return
end

function PlotRecallModel:getAllUnlockCG()
	local allCG = PlotRecallConfig.instance:getAllCG()
	local ret = {}

	for k, v in ipairs(allCG) do
		if FuncOpenModel.instance:getFuncIsOpen(v.funcId) then
			table.insert(ret, v)
		end
	end

	return ret
end

function PlotRecallModel:getSelectCGId()
	self.selectCGId = self.selectCGId or 1

	return self.selectCGId
end

function PlotRecallModel:setSelectCGId(idx)
	self.selectCGId = idx
end

PlotRecallModel.instance = PlotRecallModel.New()

return PlotRecallModel
