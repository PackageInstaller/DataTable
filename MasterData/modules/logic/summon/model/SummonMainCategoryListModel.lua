-- chunkname: @modules/logic/summon/model/SummonMainCategoryListModel.lua

module("modules.logic.summon.model.SummonMainCategoryListModel", package.seeall)

local SummonMainCategoryListModel = class("SummonMainCategoryListModel", ListScrollModel)

function SummonMainCategoryListModel:initCategory()
	local data = {}
	local list = SummonMainModel.getValidPools()

	for i, co in ipairs(list) do
		local mo = self:createMO(co, i)

		table.insert(data, mo)
	end

	self:setList(data)
end

function SummonMainCategoryListModel:createMO(co, index)
	local mo = {}

	mo.originConf = co
	mo.index = index

	return mo
end

function SummonMainCategoryListModel:saveEnterTime()
	self._enterTime = Time.realtimeSinceStartup
end

function SummonMainCategoryListModel:canPlayEnterAnim()
	if Time.realtimeSinceStartup - self._enterTime < 0.334 then
		return true
	end

	return false
end

SummonMainCategoryListModel.instance = SummonMainCategoryListModel.New()

return SummonMainCategoryListModel
