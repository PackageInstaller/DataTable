-- OPENDEBUG(true)

-- 获取卡牌的站格
function GetCardGrids(cid, row, col)
	local config = CardData[cid] or MonsterData[cid]
	ASSERT(config)
	if config.grids then
		local grids = {}
		
		-- 占多个格子
		local formation = MonsterFormation[config.grids]
		ASSERT(formation)
		-- LogTable(formation, "config"..config.grids)

		-- relative 相对坐标
		for i, pos in ipairs(formation.coordinate) do
			local r = row + pos[1]
			local c = col + pos[2]
			table.insert(grids, {r, c})
		end
		return grids
	end
	-- LogTable(config, "config"..cid)
	-- if cid == 30120 then ASSERT() end
end


----------------------------------------------
-- 光环计算器 
Halo = {}

function Halo:InitMap(map, row, col)
	for i=1,row do
		map[i] = {}
		for j=1,col do
			map[i][j] = {}
		end
	end
end

-- 内部函数, 给某个格子加buff
function Halo:AddBuff(id, map, row, col, buff)
	-- if row < 1 or row > 3 or col < 1 or col > 3 then return end
	if not map[row] or not map[row][col]  then return end -- 越界

	-- LogTable(buff.percents)
	local data = map[row][col]
	buff.nClass = buff.nClass or {0}
	buff.id = id -- 标记这是谁加的光环
	table.insert(data, buff)
end

-- function Halo:GetBuff(mapItem, nClass)
-- 	local data = {}
-- 	for i,buff in ipairs(mapItem) do
-- 		for i,v in ipairs(buff.nClass) do
-- 			if v == 0 or v == nClass then
-- 				for k,v in pairs(buff.percents) do
-- 					data[k] = data[k] or 0
-- 					data[k] = data[k] + v
-- 				end
-- 				break
-- 			end
-- 		end
-- 	end

-- 	-- LogTable(data, "Halo:GetBuff")
-- 	return data
-- end

-- 考虑多格站位
function Halo:GetBuffEx(cid, map, row, col, nClass)

	-- LogDebugEx("Halo:GetBuffEx",cid, row, col, nClass)
	local data = {}
	local fixedBuff = {}
	local mapItem = map[row][col]
	local grids = GetCardGrids(cid, row, col)

	if grids then
		-- LogTable(grids, "grids =")
		local item = {}
		-- 合并&过滤重复buff
		for i,pos in ipairs(grids) do
			local m = map[pos[1]][pos[2]]
			for i,v in ipairs(m) do
				item[v] = v
			end
		end

		mapItem = {}
		local its = {}
		for k,v in pairs(item) do
			table.insert(mapItem, v)
		end
		-- return data
		-- LogTable(mapItem, "mapItem_"..row.."_"..col)
	end

	for i,buff in ipairs(mapItem) do
		-- + 4.4光环养成改动，新增光环特效，特殊情况下也需要加在自己身上，需要判断光环特效nType~=2的情况
		--   非特效只需判断是否是自己的BUFF，特效需要判断nType，nType=2时需走else里的逻辑
		-- if buff.id == cid and (not buff.isEffect or (buff.isEffect and buff.nType ~= 2))  then
		if (buff.id == cid and not buff.isEffect) or (buff.id ~= cid and buff.isEffect) then
			-- 自己的buff不用加
			-- 4.4 关环再改动，特效只在自己身上生效
		else
			for i,v in ipairs(buff.nClass) do
				if v == 0 or v == nClass then
					for k,v in pairs(buff.percents) do
						data[k] = data[k] or 0
						data[k] = data[k] + v
					end

					-- 4.4光环改动，还有固定值的加成，先加百分比再加固定值
					if buff.fixedAttr and next(buff.fixedAttr) then
						for kk,vv in pairs(buff.fixedAttr) do
							fixedBuff[kk] = fixedBuff[kk] or 0
							fixedBuff[kk] = fixedBuff[kk] + vv
						end
					end
					break
				end
			end
		end
	end

	-- LogTable(data, "Halo:GetBuff")
	return data, fixedBuff
end
---------------------------------------------------------------------------
-- data格式
-- {
--     [ 1 ]n = 
--     {
--         [ "data" ]s = 
--         {
--             [ "id" ]s = [ 60010 ]f
--             [ "name" ]s = [ "格拉姆" ]s
--             [ "attack" ]s = [ 201 ]f
--             [ "maxhp" ]s = [ 1273 ]f
--             [ "defense" ]s = [ 97 ]f
--             [ "speed" ]s = [ 110 ]f
--             [ "crit_rate" ]s = [ 0.1 ]f
--             [ "crit" ]s = [ 1.5 ]f
--             [ "hit" ]s = [ 0 ]f
--             [ "damage" ]s = [ 1.1 ]f
--             [ "resist" ]s = [ 0 ]f
--         }
--         [ "col" ]s = [ 1 ]f
--         [ "row" ]s = [ 1 ]f
--     }
--     [ 2 ]n = 
--     {
--         [ "data" ]s = 
--         {
--             [ "id" ]s = [ 40010 ]f
--             [ "name" ]s = [ "飓风" ]s
--             [ "attack" ]s = [ 201 ]f
--             [ "maxhp" ]s = [ 1273 ]f
--             [ "defense" ]s = [ 97 ]f
--             [ "speed" ]s = [ 110 ]f
--             [ "crit_rate" ]s = [ 0.1 ]f
--             [ "crit" ]s = [ 1.5 ]f
--             [ "hit" ]s = [ 0 ]f
--             [ "damage" ]s = [ 1.1 ]f
--             [ "resist" ]s = [ 0 ]f
--         }
--         [ "col" ]s = [ 2 ]f
--         [ "row" ]s = [ 1 ]f
--     }
-- }
local needFloor = {attack = true, maxhp = true, defense = true}
local fixedAttr = {attack_fixed = 'attack', maxhp_fixed = 'maxhp', defense_fixed = 'defense'}
function Halo:CalcAttr(data, key, add)
	-- LogTable(data)

	-- attack	maxhp	defense	speed
	-- 整数取整, 浮点保留, 比率改为相加(0-1)
	if needFloor[key] then
		local calRet = GCardCalculator:CalLvlPropertys(data.id, data.level, data.intensify_level, data.break_level,data.isMonster)
		if calRet and calRet[key] then
			LogDebug("CalcAttr name[%s] key[%s] val[%s] cfg[%s] src[%s] des[%s]", data.name, key, add, calRet[key], data[key], data[key] + math.floor(calRet[key]*add))
			data[key] = data[key] + math.floor(calRet[key]*add)
		else
			data[key] = math.floor(data[key]*(1 + add))
		end
	else
		data[key] = data[key] + add
	end
end

-- 计算光环后属性值
function Halo:Calc(data)

	--LogTable(data)
	local ret = table.copy(data)
	local map = {}
	Halo:InitMap(map, ret.row or 3, ret.col or 3)

	-- local row = ret.row or 3
	-- local col = ret.col or 3

	for i,carddata in ipairs(ret) do
		-- LogTable(carddata)
		-- LogDebug("--------"..i)
		local row, col = carddata.row, carddata.col
		local id = carddata.data.id				--卡牌ID
		local config = CardData[id] or MonsterData[id]
		ASSERT(config, "没有找到配置"..id)
		carddata.data.nClass = config.nClass or 0
		if config.halo and next(config.halo) then
			-- 遍历加buff的格子 并记录buff


			local haloid = config.halo[1]
			ASSERT(haloid, "NOT haloid"..id)

			local haloLv = 1
			local curCoor = haloid

			if carddata.data.haloInfo then
				haloLv = carddata.data.haloInfo.level or 1
				curCoor = carddata.data.haloInfo.curCoor or haloid
			end

			local cfgH = cfgHalo[haloid]
			ASSERT(cfgH, "没有找到光环配置"..haloid)
			ASSERT(cfgH.infos[haloLv], "没有找到光环等级配置"..haloid.."等级"..haloLv)

			local cfgHLv = self:CalHaloEquipAttr(carddata.data.haloInfo)
			if not cfgHLv or not next(cfgHLv) then
				cfgHLv = table.copy(cfgHalo[haloid].infos[haloLv])
			end
			
			cfgHLv.nClass = cfgH.nClass

			local coorHalo =  cfgH.newCoorHalo[curCoor]
			if not coorHalo then
				-- 找不到光环站位的话用默认站位
				local infos = cfgH.infos[1]
				ASSERT(infos.coorId, "该光环1级没有默认的光环站位")
				local coorCfg = cfgHaloCoordinate[infos.coorId]
				ASSERT(coorCfg, "cfgHaloCoordinate表没有配置对应的ID"..infos.coorId)
				local coor = coorCfg.coordinate
				coorHalo = {}
				for j = 2, #coor do
					table.insert(coorHalo, {coor[j][1] - coor[1][1], coor[j][2] - coor[1][2]})
				end

			end

			ASSERT(coorHalo and next(coorHalo), string.format("卡牌:%s，关环站位Id:%s, 关环等级:%s, 没有对应的关环站位", id, curCoor, haloLv))

			for index=1,#coorHalo do -- 相对坐标
				Halo:AddBuff(id, map, row+coorHalo[index][1], col+coorHalo[index][2], cfgHLv)
			end

			-- 光环特效，不在这里加，计算光环前就加好了
			-- if cfgHLv.haloEffect then
			-- 	ASSERT(cfgHaloEffect[cfgHLv.haloEffect], string.format("关环ID:%s,等级:%s,没有找到光环特效配置",coorHalo,haloLv ,cfgHLv.haloEffect))
			-- 	local effectCfg = table.copy(cfgHaloEffect[cfgHLv.haloEffect])
			-- 	effectCfg.isEffect = true
			-- 	--  关环特效，只对自己生效，只加在自己的坐标上
			-- 	Halo:AddBuff(id, map, row, col, effectCfg)
			-- end

		-- 	for i,haloid in ipairs(config.halo) do
		-- 		local cfgH = cfgHalo[haloid]
		-- 		ASSERT(cfgH, "没有找到光环配置"..haloid)
		-- 		cfgH = table.copy(cfgHalo[haloid])
		-- 		for index=1,#cfgH.coorHalo do -- 相对坐标
		-- 			Halo:AddBuff(id, map, row+cfgH.coorHalo[index][1], col+cfgH.coorHalo[index][2], cfgH)
		-- 		end

		-- 		-- 4.4改动，光环养成-装备版。先加关环基础百分比的BUFF，再加关环装备的数值，有百分比有固定值

		-- 	end
		end
	end

	-- LogTable(map, "Halo:Calc map = ")

	for i,carddata in ipairs(ret) do
		local row, col = carddata.row, carddata.col  -- 需要处理多格站位的角色
		-- local buffs = Halo:GetBuff(map[row][col], carddata.data.nClass) 

		local buffs, fixedBuffs = Halo:GetBuffEx(carddata.data.id, map, row, col, carddata.data.nClass)
		if not table.empty(buffs) then
			carddata.bInHalo = true -- 是否受到光环
			for key,val in pairs(buffs) do
				LogDebugEx("光环加成",carddata.data.name, key, val, carddata.data[key], carddata.data[key] *(1 + val))
				self:CalcAttr(carddata.data, key, val)
			end
		end

		-- 4.4光环改动，还有固定值的加成，先加百分比再加固定值
		if not table.empty(fixedBuffs) then
			carddata.bInHalo = true -- 是否受到光环
			for key,val in pairs(fixedBuffs) do
			 -- local fixedAttr = {attack_fixed = 'attack', maxhp_fixed = 'maxhp', defense_fixed = 'defense'}
				local attrname = fixedAttr[key]
				LogDebugEx("光环固定值加成",carddata.data.name, key, val, carddata.data[attrname], carddata.data[attrname] + val)
				carddata.data[attrname] = carddata.data[attrname] + val
				-- self:CalcAttr(carddata.data, key, val)
			end
		end

	end

	-- LogTable(ret, "Halo:Calc ret = ")
	return ret
end

-- 4.4 光环养成改动
-- 光环的属性加成由关环本身与光环装备加成合在一起
-- 获取光环属性加成（包括装备加成）
function Halo:CalHaloEquipAttr(haloInfo)
	if not haloInfo or not next(haloInfo) then
		return {}
	end

	local attr = {'attack', 'maxhp', 'defense', 'speed', 'crit_rate', 'crit', 'hit', 'resist',}
				-- -- 4.4光环改动新增固定属性值加成，攻击防御气血按固定值加成
				-- 	[44] = 'attack_fixed',
				-- 	[45] = 'maxhp_fixed',
				-- 	[46] = 'defense_fixed',

	local fixedAdd = {
		-- 4.4光环改动新增固定属性值加成，攻击防御气血按固定值加成
		[44] = 'attack_fixed',
		[45] = 'maxhp_fixed',
		[46] = 'defense_fixed',
	}	
	local curHaloId = haloInfo.cfgid
	local haloLv = haloInfo.level or 1
	local cfgH = cfgHalo[curHaloId]
	ASSERT(cfgH, "没有找到光环配置"..curHaloId)
	local hLvCfg = cfgH.infos[haloLv]
	ASSERT(hLvCfg, "没有找到光环对应等级的配置 id"..curHaloId.."等级:", haloLv)

	local ret = table.copy(hLvCfg)
	ret.nClass = cfgH.nClass

	-- 总属性加成
	-- ret.attrAdd = {
	-- 	{'maxhp', 0.06},
	-- 	{'defense', 0.02},
	-- }
	-- 光环总属性加成
	ret.attrAdd = {}

	if hLvCfg.use_types and next(hLvCfg.use_types) then
		for _, ty in ipairs(hLvCfg.use_types) do
			local attrName = attr[ty]
			if attrName and ret.percents[attrName] then
				table.insert(ret.attrAdd, { attrName, ret.percents[attrName]})
			end

			local fixedAttrName = fixedAdd[ty]
			if fixedAttrName and ret.fixedAttr[fixedAttrName] then
				table.insert(ret.attrAdd, { fixedAttrName, ret.fixedAttr[fixedAttrName]})
			end
		end
	end

	-- LogTable(ret, "Halo:CalHaloEquipAttr")
	return ret
end

-- function Halo:CalcDuplicate(data)
-- 	LogTable(data, "Halo:CalcDuplicate = ")

-- 	local ret = table.copy(data)
-- 	local newdata = {}
-- 	for i,carddata in ipairs(ret) do
-- 		table.insert(newdata, {data = carddata.carddata.data, row = carddata.row, col = carddata.col})
-- 	end 

-- 	newdata = Halo:Calc(newdata)

-- 	for i,v in ipairs(newdata) do
-- 		ret[i].carddata.data = v.data
-- 		ret[i].maxhp = v.data.maxhp
-- 	end

-- 	-- LogTable(ret, "Halo:Calc ret = ")
-- 	return ret
-- end