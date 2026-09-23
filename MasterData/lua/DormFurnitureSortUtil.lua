--角色排序工具
DormFurnitureSortUtil = {}

local this = DormFurnitureSortUtil
local funcs = {}

function this:Init()
	local newList = {1, 2, 3, 4}
	local list = {}
	list[1] = self.ByComfort
	list[2] = self.ByPrice
	list[3] = self.ByScale
	list[4] = self.ByID
	funcs = {}
	for i, v in ipairs(newList) do
		if(i <= #list) then
			table.insert(funcs, {v, list[v]})
		end
	end
end

function this:SortByCondition(_datas, _sortType)
	if(_datas == nil or #_datas <= 1) then
		return _datas
	end
	self.newDatas = _datas
	self.sortType = _sortType
	self.sortDatas = DormMgr:GetFurnitureSortTab(self.sortType)
	self:SelectBy1()
	self:MSort()
	return self.newDatas
end

--主题筛选
function this:SelectBy1()
	local rule = self.sortDatas.Theme
	if(rule[1] == 0) then
		return
	end
	local newRule = {}
	for i, v in ipairs(rule) do
		local cfg = Cfgs.CfgThemeEnum:GetByID(v)
		newRule[cfg.themeID] = 1
	end
	local len = #self.newDatas
	for i = len, 1, - 1 do
		if(self.newDatas[i].theme ~= nil and newRule[self.newDatas[i].theme] == nil) then
			table.remove(self.newDatas, i)
		end
	end
end

function this:MSort()
	firstIndex = 1
	for i, v in ipairs(funcs) do
		if(v[1] == self.sortDatas.Sort[1]) then
			firstIndex = i
		end
	end
	table.sort(self.newDatas, function(a, b)
		return self:SortFunc(a, b)
	end)
end

function this:SortFunc(a, b)
	local result = nil
	
	if(self.sortType == DormFurnitrueSortType.layout) then
		result = self.Buy_m_sortType(a, b)
	end
	
	local firstFunc = funcs[firstIndex]
	if(result == nil) then
		result = firstFunc[2](a, b)
	end
	if(result == nil) then
		for i, v in ipairs(funcs) do
			if(i ~= firstIndex) then
				if(result == nil) then
					result = v[2](a, b)
				else
					break
				end
			end
		end
	end
	return result or false
end

--未使用/达上限，已使用
function this.Buy_m_sortType(a, b)
	if(a.m_sortType == b.m_sortType) then
		return nil
	else
		return a.m_sortType < b.m_sortType
	end
end

--舒适度
function this.ByComfort(a, b)
	local aComfort = a.comfort or 0
	local bComfort = b.comfort or 0
	if(aComfort == bComfort) then
		return nil
	else
		return aComfort > bComfort
	end
end

--价格  
function this.ByPrice(a, b)
	if(a.priceIndex == b.priceIndex) then
		return nil
	else
		return a.priceIndex < b.priceIndex
	end
end
--面积
function this.ByScale(a, b)
	local aScale = a.scale and a.scale[1] * a.scale[2] or 0
	local bScale = b.scale and b.scale[1] * b.scale[2] or 0
	if(aScale == bScale) then
		return nil
	else
		return aScale > bScale
	end
end
--id
function this.ByID(a, b)
	if(a.id == b.id) then
		return nil
	else
		return a.id < b.id
	end
end

this:Init()

return this
