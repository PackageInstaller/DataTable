-- 地图翻译器:将新格式的map数据翻译成旧版本的map数据

MapTranslator = {}

-- 重置
function MapTranslator:Reset()
end

function MapTranslator:Get(mapData)
	LogTable(mapData, "mapData=")
	local result = {}

	for layerID, submapex in ipairs(mapData) do
		local submap = submapex.data
		local noneGrids = self:GetNoneGrids(submap.datas)

		-- 默认数据
		local subdata = self:CreateMap(layerID, submap.w, submap.h, noneGrids, self:GetWalls(submap.datas))
		-- LogTable(subdata, "CreateMap")
		-- 特殊数据
		if submap.datas then
			self:DealMapData(subdata, submap.datas)
		end

		for k, v in pairs(subdata) do
			result[k] = v
		end
	end

	return result
end


local function AddGrid(item, id, key, noneGrids, walls)
	if noneGrids[id] then return end

	if walls and walls[item.id] and walls[item.id][key] then return end -- 有墙非出口

	item[key] = id
	-- table.insert(item.exits, id)
end

-- 创建默认数据
function MapTranslator:CreateMap(layerID, w, h, noneGrids, walls)
	local data = {}
	for i = 1, h do -- y轴
		for j = 1, w do -- x轴
			local id = layerID * 10000 + i * 100 + j
			local item = {id = id, exits = {}}

			-- 上 +100
			if i + 1 <= h then
				AddGrid(item, id + 100, "up", noneGrids, walls)
			end
			-- 右 +1
			if j + 1 <= w then
				AddGrid(item, id + 1, "right", noneGrids, walls)
			end
			-- 下 -100
			if i - 1 > 0 then
				AddGrid(item, id - 100, "down", noneGrids, walls)
			end
			-- 左 -1
			if j - 1 > 0 then
				AddGrid(item, id - 1, "left", noneGrids, walls)
			end

			data[id] = item
		end
	end
	return data
end

-- 处理地图特殊数据
function MapTranslator:DealMapData(data, grids)
	-- LogTable(grids,"grids")
	-- LogTable(data,"data")
	for id, grid in pairs(grids) do
		-- 高度
		if grid.height then
			data[id].height = grid.height
		end
		-- LogDebugEx("----", id, grid.type)
		-- 特殊地形
		if grid.type then
			if grid.type == eMapGridType.None then -- 不存在
				data[id] = nil
			elseif grid.type == eMapGridType.Hide then -- 隐藏(逻辑上存在只是不显示,当成障碍,恢复显示时,能够恢复联通路径)
				data[id].hide = true
			elseif grid.type == eMapGridType.Sand then -- 流沙
				data[id].sand = true
				data[id].dir = eMapGridDir[grid.dir]
			elseif grid.type == eMapGridType.Water then -- 水面
				data[id].water = true
			elseif grid.type == eMapGridType.Ice then -- 冰(需要对怪物阻挡)
				data[id].ice = true
			elseif grid.type == eMapGridType.Slide then -- 指向滑动(需要对怪物阻挡)
				data[id].slide = true
				data[id].dir = eMapGridDir[grid.dir]
			elseif grid.type == eMapGridType.Gravity then -- 重力区
				data[id].gravity = true
				data[id].nGravity = 1-grid.nGravity -- 重力减少的距离(加1原来那个格子权重)负数 -- 反重力增加距离填正数 -- 0时与普通格子无异
			-- elseif grid.type == eMapGridType.OnceWay then -- 一次性道路
			-- 	data[id].bOnceWay = true
			else
				ASSERT(nil, "错误的格子类型" .. grid.type)
			end
		elseif grid.hole_type then -- 坑洞
			data[id].hole_type = grid.hole_type -- 坑洞类型
			if grid.hole_type == eMapGridHoleType.Fall then
				data[id].hole_fall_pos = grid.hole_fall_pos -- 坑洞掉落点
				table.insert(data[id].exits, grid.hole_fall_pos)
			end
		end
	end
end

-- 
function MapTranslator:GetNoneGrids(grids)
	local result = {}
	for id, grid in pairs(grids) do
		if grid.type and grid.type == eMapGridType.None then
			result[id] = true
		end
	end
	return result
end


function MapTranslator:GetWalls(grids)
	local key = {"up", "right", "down", "left"}
	local result = {}
	for id, grid in pairs(grids) do
		if grid.walls then
			result[id] = {}
			for k,v in pairs(grid.walls) do
				result[id][key[k]] = true
			end
			-- result[id] = true
		end
	end
	-- LogTable(result)
	return result
end

-- LogTable(MapTranslator:Get(2121)[10505], "map1000")
-- LogTable(MapTranslator:Get(2121)[10404], "map1000")
-- ASSERT()