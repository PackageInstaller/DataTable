-- 基地建筑信息 sBuildInfo
MatrixData = {}
local this = MatrixData

this.data = {}

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins;
end

function this:SetData(sBuildInfo)
    self.data = sBuildInfo
    self:SetBaseCfg()
    self:SetCfg()

    -- 记录加速时间获取时的服务器时间
    self.oldTime = TimeUtil:GetTime()
end

-- 刷新数据
function this:UpdateData(sBuildInfo)
    -- 更新前是否是建造中 
    local isBuild1 = self.data.tBuild ~= 0

    for k, v in pairs(sBuildInfo) do
        if (k == "lv") then
            if (v > self.data[k]) then
                -- 升级
                -- EventMgr.Dispatch(EventType.Matrix_Building_Upgrade, self:GetBuildingName())
                MatrixMgr:SetCreateUpTips(self, 1)
            end
        end
        self.data[k] = v
    end
    if (not sBuildInfo.otherInfo) then
        self.data.otherInfo = nil
    end

    self:SetCfg()

    -- 记录加速时间获取时的服务器时间
    self.oldTime = TimeUtil:GetTime()

    -- 更新后是否是建造中 
    local isBuild2 = self.data.tBuild ~= 0

    if (isBuild1 and not isBuild2) then
        -- 建造完成
        MatrixMgr:SetCreateUpTips(self, 2)
    end
end

function this:GetOldTime()
    return self.oldTime
end

function this:GetData()
    return self.data
end
function this:GetId()
    return self.data.id
end
function this:GetID()
    return self.data.id
end

function this:GetCfgId()
    return self.data.cfgId
end
function this:GetType()
    return self.baseCfg and self.baseCfg.type or 1
end

function this:CheckRunning()
    return self.data.running or false
end

-- --所有驻员的能力id
-- function this:GetAbilityIds()
-- 	local abilityIds = nil
-- 	local sAddRole = self:GetRoles()
-- 	abilityIds = {}
-- 	for i, v in ipairs(sAddRole) do
-- 		local cRoleInfo = CRoleMgr:GetData(v.id)
-- 		if(cRoleInfo) then
-- 			local abilitysId = cRoleInfo:GetAbilityId()
-- 			if(abilitysId) then
-- 				table.insert(abilityIds, abilitysId)
-- 			end
-- 		end
-- 	end
-- 	return abilityIds
-- end
-- 所需角色能力
function this:GetNeedAbilityTypes()
    return self.baseCfg.needAbilitys
end

-- 基础配置表
function this:SetBaseCfg()
    if (not self.baseCfg) then
        self.baseCfg = Cfgs.CfgBuidingBase:GetByID(self.data.cfgId)
    end
    return self.baseCfg
end

-- 当前配置表
function this:SetCfg()
    self.cfg = nil
    local cfgName = self:SetBaseCfg().upCfg
    if (cfgName) then
        self.cfg = Cfgs[cfgName]:GetByID(self.data.lv)
    end
end
function this:GetCfg()
    return self.cfg
end

-- 下一级表
function this:GetNextCfg()
    local nextCfg = nil
    local nextLv = self.data.lv + 1
    local cfgName = self:SetBaseCfg().upCfg
    if (cfgName) then
        nextCfg = Cfgs[cfgName]:GetByID(nextLv)
    end
    return nextCfg
end

function this:GetBuildingCfg()
    return Cfgs.CfgBuilding:GetByID(self.baseCfg.modelId)
end

-- 模型
function this:GetModelName()
    local cfg = self:GetBuildingCfg()
    if (self.data.lv >= #cfg.infos) then
        return cfg.infos[#cfg.infos].modelName
    else
        return cfg.infos[self.data.lv].modelName
    end
end
-- function this:GetModelScale()
-- 	return self.cfg and self.cfg.modelScale or 1
-- end  
-- 建筑名
function this:GetBuildingName(isEn)
    if (isEn) then
        return self.baseCfg and self.baseCfg.name_en or ""
    else
        return self.baseCfg and self.baseCfg.name or ""
    end

end

-- 等级
function this:GetLv()
    local curLv = self.data.lv or 1
    local maxLv = 1
    local cfgName = self:SetBaseCfg().upCfg
    if (cfgName) then
        maxLv = #Cfgs[cfgName]:GetAll()
    end
    return curLv, maxLv
end

function this:IsMax()
    local cur, max = self:GetLv()
    return cur >= max
end

-- 装甲类型
function this:GetArmorType()
    return self.cfg and self.cfg.armorType or 1
end

-- /-----------------驻员------------------------------------
-- 驻员位置初始化 {id,id,id,id,id}  -1：不开放 
function this:GetRolePos()
    if (self.RolePos == nil) then
        self.RolePos = {}
        local cfgName = self:SetBaseCfg().upCfg
        if (cfgName) then
            local index = 1
            local oldKey = 0
            self.RolePos = {-1, -1, -1, -1, -1}
            local cfgs = Cfgs[cfgName]:GetAll()
            for i, v in ipairs(cfgs) do
                if (v.roleLimit > oldKey) then
                    oldKey = v.roleLimit
                    for k = index, v.roleLimit do
                        self.RolePos[k] = v.id
                    end
                    index = v.roleLimit + 1
                end
            end

        end
    end
    return self.RolePos
end

function this:GetNum()
    local cur = #self:GetRoles()
    local max = self:GetMaxNum()
    return cur, max
end

-- 驻员  
function this:GetRoles()
    return self.data.roleIds or {}
end

-- 预设驻员
function this:GetPrestRoles(index)
    local roleIds = {}
    local datas = self:GetPresetRoles()
    if (datas[index]) then
        roleIds = datas[index].roleIds or {}
    end
    return roleIds
end

-- 当前房间可以放置的驻员数量
function this:GetMaxNum()
    local cur = self.cfg and self.cfg.roleLimit or 0
    return cur
end

-- 最大等级上阵驻员数量  
function this:GetMaxRoleLimit()
    local rolePos = self:GetRolePos()
    for i = 1, 5 do
        if (rolePos[i] == -1) then
            return i
        end
    end
    return 0
end

-- --获取驻员信息
-- function this:GetRoleInfo(_cRoleId)
-- 	local roles = self:GetRoles()
-- 	if(roles) then
-- 		for i, v in ipairs(roles) do
-- 			if(v.id == _cRoleId) then
-- 				return v
-- 			end
-- 		end
-- 	end
-- 	return nil
-- end
-- 封装驻员数据，5个位置  {data = ,curLv = ,openLv=}   noNil:剔除不开放的
function this:GetRoleInfos(noNil)
    --宿舍 暂时取第一间房的数据 todo 
    if (self:GetType() == BuildsType.Entry) then
        local roomID = GCalHelp:GetDormId(1, 1) -- 默认打开101房
        local roomData = DormMgr:GetRoomData(roomID)
        return roomData:GetRoleInfos()
    end
    noNil = noNil == nil and true or noNil
    local roleInfos = {}
    local roles = self:GetRoles()
    local rolePos = self:GetRolePos()
    local _curLv = self.data.lv
    for i, v in ipairs(rolePos) do
        local _id = i <= #roles and roles[i] or nil
        if (noNil and v == -1) then
            break
        end
        table.insert(roleInfos, {
            data = _id,
            curLv = _curLv,
            openLv = v
        })
    end
    return roleInfos
end

-- /-----------------驻员------------------------------------
-- 当前可获取的素材（生产中心：基础+额外 ； 交易中心：额外 ； 合成中心：基础+额外 ； 改造中心：基础）
-- 合成中心、远征列表、交易中心不使用
-- 仅生产中心、改造中心 使用
function this:GetMaterials()
    local normalCount = 0
    local exCount = 0
    local arrGifts = nil
    -- if(self:GetType() == BuildsType.ProductionCenter) then
    local gifts = self.data and self.data.gifts or {}
    local giftsEx = self.data and self.data.giftsEx or {}
    arrGifts = {}
    for i, v in pairs(gifts) do
        table.insert(arrGifts, v)
        normalCount = normalCount + 1
    end
    for i, v in pairs(giftsEx) do
        table.insert(arrGifts, v)
        exCount = exCount + 1
    end
    -- end
    return arrGifts, normalCount, exCount
end

-- 获取第一件掉落物品来进行显示
function this:GetFirstReward()
    -- 生产中心才有
    local arrGifts = self:GetMaterials()
    if (self:GetType() == BuildsType.ProductionCenter) then
        return arrGifts and arrGifts[1] or nil
    end
    return nil
end

-- --建造信息 bool，time
-- function this:GetCreateInfo()
-- 	local isCreate = false
-- 	if(self.data.tUp and self.data.tUp ~= 0) then
-- 		isCreate = true
-- 	end
-- 	return isCreate, self.data.tUp
-- end
-- --升级信息 bool，time
-- function this:GetUpgradeInfo()
-- 	local isUpgrade = false
-- 	if(self.data.tBuild and self.data.tBuild ~= 0) then
-- 		isUpgrade = true
-- 	end
-- 	return isUpgrade, self.data.tBuild
-- end
-- 血量
function this:GetHP()
    local cur, max = 0, 0
    cur = self.data.hp or 0
    max = (self.cfg and self.cfg.maxHp) and self.cfg.maxHp or 0
    return cur, max
end
-- 是否满血
function this:IsMaxHP()
    local cur, max = self:GetHP()
    return cur >= max
end

-- 电量  lvCfg.powerVal * (build.perHpPower / 100) * (build.perRolePower / 100)
function this:GetPower()
    local add = 0
    local roleAbilitys = self:GetData().roleAbilitys
    if (roleAbilitys and roleAbilitys[RoleAbilityType.PowerOpt] and roleAbilitys[RoleAbilityType.PowerOpt].vals) then
        add = roleAbilitys[RoleAbilityType.PowerOpt].vals[1] or 0
    end

    if (self.cfg) then
        local power = self.cfg.powerVal * (self.data.perHpPower / 100) * (self.data.perRolePower / 100)
        return math.floor(power + add)
    else
        return add
    end
end

-- 订单中心当前生效角色(无论pl是否已满，都会增加订单槽)
function this:GetTradingCurRoleID()
    local id = nil
    local roleAbilitys = self:GetData().roleAbilitys
    if (roleAbilitys and roleAbilitys[RoleAbilityType.Seller] and roleAbilitys[RoleAbilityType.Seller].rids) then
        local rids = roleAbilitys[RoleAbilityType.Seller].rids or {}
        for k, v in pairs(rids) do
            return k
        end
    end
    return id
end

-- 合成订单 副产品额外增加概率  group:合成订单的group
function this:GetCompoundNum(group)
    local add = 0
    local roleAbilitys = self:GetData().roleAbilitys
    if (roleAbilitys and roleAbilitys[RoleAbilityType.CombineGift] and roleAbilitys[RoleAbilityType.CombineGift].rewards) then
        local rewards = roleAbilitys[RoleAbilityType.CombineGift].rewards or {}
        return rewards[group] or 0
    end
    return 0
end

-- 效果
function this:GetEffect()
    return self.cfg and self.cfg.effect or ""
end
-- 恢复总消耗 {名字，数量}
function this:GetHPCosts()
    local cur, max = self:GetHP()
    local needHp = max - cur
    if (needHp <= 0) then
        return nil
    end
    local costs = nil
    local hpCosts = self.baseCfg.hpCosts
    local hpCostUnit = self.baseCfg.hpCostUnit or 1
    if (hpCosts) then
        costs = {}
        for i, v in ipairs(hpCosts) do
            local cfg = Cfgs.ItemInfo:GetByID(v[1])
            local name = cfg and cfg.name or "XXX"
            local number = math.ceil(needHp / hpCostUnit) * v[2]
            table.insert(costs, {name, number})
        end
    end
    return costs, needHp
end

-- 建筑状态
function this:GetState()
    if (self.data.tUp and self.data.tUp ~= 0) then
        return MatrixBuildingType.Upgrage, self.data.tUp
    elseif (self.data.tBuild and self.data.tBuild ~= 0 and TimeUtil:GetTime() < self.data.tBuild) then
        return MatrixBuildingType.Create, self.data.tBuild
    elseif (self.data.running) then
        return MatrixBuildingType.Runing
    else
        return MatrixBuildingType.NotRuning
    end
end

-- --状态时间
-- function this:GetStateTime()
-- 	if(self.data.tUp and self.data.tUp ~= 0) then
-- 		return self.data.tUp
-- 	elseif(self.data.tBuild and self.data.tBuild ~= 0) then
-- 		return self.data.tBuild
-- 	else
-- 		return 0
-- 	end
-- end
-- 损伤程度
function this:GetDamageLv()
    local cur, max = self:GetHP()
    local per = max > 0 and (cur / max) or 1
    per = math.floor(per * 100)
    local cfgs = Cfgs.CfgBHp:GetAll()
    for i, v in ipairs(cfgs) do
        if (per >= v.min and per <= v.max) then
            return i
        end
    end
    return 0
end

-- --[[1:生产中心, {[物品id] = 增加百分比}
-- 	2:交易中心：{ [掉落id] = 增加的权重 }
-- 	3:远征: 增加奖励的数量（百分比）
-- 	4:合成工厂：科学家，提高制作能力（百分比）
-- 	5:防御设置：提高攻击防御（百分比） {[1] = 防御增加 [2] = 攻击增加}
-- 	6:改造中心：缩短改造的时间
-- ]]
-- function this:GetAbilityCount(_index)
-- 	-- local otherInfo = self:GetData().otherInfo
-- 	-- local tab = otherInfo and otherInfo[_index]
-- 	-- return tab
-- 	return self:GetData().otherInfo
-- end
-- 缓存位置
function this:SetCachePos(_pos)
    self.cachePos = _pos
end

function this:GetCachePos()
    return self.cachePos and self.cachePos or self:GetPos()
end

-- 左上起点
function this:GetPos()
    return self.data and self.data.pos or {1, 1}
end

-- 面积
function this:GetArea()
    return self.baseCfg and self.baseCfg.area or {1, 1}
end

-- 点击用的index
function this:GetBoxIndex()
    return self:GetId() + 10000
end

-- 在3D地面，建筑的index（为了区别于地板所以+10000，用于区分点击回调)
function this:GetPosIndex()
    local pos = self:GetPos()
    return pos[1] + g_BuildScale[1] * (pos[2] - 1) + 10000
end

-- 在3D地面，左上角坐标
function this:GetGroundPos()
    local pos = self:GetPos()
    local realIndex = pos[1] + g_BuildScale[1] * (pos[2] - 1)
    -- local realIndex = self:GetPosIndex() - 10000
    local groundPos = MatrixMgr:GetPosByIndex(realIndex)
    return groundPos
end

-- 在3D地面，计算中点位置（左上角坐标为基准点）
function this:GetBuildingPos()
    local pos = self:GetGroundPos()
    local area = self:GetArea()
    local x = area[1] > 1 and (area[1] - 1) / 2 or 0
    local z = area[2] > 1 and -(area[2] - 1) / 2 or 0
    return {pos[1] + x, pos[2], pos[3] + z}
end

-- --新建筑范围是否与其交叉
-- function this:CheckCenSet(x, y, cfgId)
-- 	local isIn = self:CheckIsIn(x, y)
-- 	if(not isIn) then
-- 		local areas = {}
-- 		local newArea = Cfgs.CfgBuidingBase:GetByID(cfgId).area
-- 		for i = x,(x + newArea[1] - 1) do
-- 			for j = y,(y + newArea[2] - 1) do
-- 				if(self:CheckIsIn(i, j)) then
-- 					return false
-- 				end
-- 			end
-- 		end
-- 		return true
-- 	end
-- end
-- 坐标是否属于该建筑
function this:CheckIsIn(x, y)
    local pos = self:GetCachePos()
    local area = self:GetArea()
    if (x >= pos[1] and x <= (pos[1] + area[1] - 1)) then
        if (y >= pos[2] and x <= (pos[2] + area[2] - 1)) then
            return true
        end
    end
    return false
end

-- 能力影响下的数值---------------------------------------------------------------------------------------
-- 制作能力
function this:GetCreateAbilityCount()
    local baseValue = self:GetCfg().ability or 0
    local add = 0
    local roleAbilitys = self:GetData().roleAbilitys
    if (roleAbilitys and roleAbilitys[RoleAbilityType.Scientist]) then
        local per = roleAbilitys[RoleAbilityType.Scientist].vals[1] / 100
        add = math.floor(baseValue * per)
    end
    return baseValue + add
end

-- 订单总长度
function this:GetTradingCount()
    local baseValue = self:GetCfg().orderNumLimit or 0
    local add = 0
    local roleAbilitys = self:GetData().roleAbilitys
    if (roleAbilitys and roleAbilitys[RoleAbilityType.Seller] and roleAbilitys[RoleAbilityType.Seller].rids) then
        local rids = roleAbilitys[RoleAbilityType.Seller].rids or {}
        for k, v in pairs(rids) do
            add = v[2]
            break
        end
    end
    return baseValue + add, add
end

--------------------------------------------------------------------------------------------------------
-- 产出时间
function this:GetBaseTime()
    local tNext = 0
    if (self:GetData().tNexGifs ~= 0) then
        tNext = self:GetData().tNexGifs
    end
    if (self:GetData().tNexGiftsEx ~= 0) then
        if (tNext == 0) then
            tNext = self:GetData().tNexGiftsEx
        else
            tNext = (tNext > self:GetData().tNexGiftsEx) and self:GetData().tNexGiftsEx or tNext
        end
    end
    return tNext
end

function this:GetFlushTime()
    local tFlush = 0
    -- if(self:CheckRunning()) then
    tFlush = self:GetData().tFlush
    -- end
    return tFlush
end

-- 时间加速倍数、界面打开时间、已过去时长
function this:GetTimeMul()
    local abilityType = nil
    -- 能力类型
    if (self:GetType() == BuildsType.TradingCenter) then
        abilityType = RoleAbilityType.Traders
    elseif (self:GetType() == BuildsType.Compound) then
        abilityType = RoleAbilityType.CombineWorker
    elseif (self:GetType() == BuildsType.Expedition) then
        abilityType = RoleAbilityType.Adventurer
    elseif (self:GetType() == BuildsType.Remould) then
        abilityType = RoleAbilityType.Artisan
    end
    --[[ 改为正常显示
    -- 能力值
    local per = 0
    if (self:GetData().roleAbilitys and self:GetData().roleAbilitys[abilityType]) then
        per = self:GetData().roleAbilitys[abilityType].vals[1] or 0
    end
    -- 电力影响的值
    local powerPer = self:GetPowerEffectVal()
    local timeMul = (100 + per) * (100 + powerPer) / 10000 
    ]]
    local timeMul = 1 -- 时间倍率 修改为正常显示
    local openTime = TimeUtil:GetTime()
    local oldLen = (openTime - self:GetOldTime()) * timeMul -- 向下取整
    return timeMul, openTime, oldLen
end
--[[ 改为正常显示
-- 电力影响的值
function this:GetPowerEffectVal()
    local val = 0
    local runingLv = MatrixMgr:GetMatrixInfo().runTypeCfgId or 1
    local cfg = Cfgs.CfgBGobalPower:GetByID(runingLv)
    if (self:GetType() == BuildsType.TradingCenter) then
        val = cfg.tradeOrderPer
    elseif (self:GetType() == BuildsType.Compound) then
        val = cfg.combineOrderPer
    elseif (self:GetType() == BuildsType.Expedition) then
        val = cfg.expeditionPer
    elseif (self:GetType() == BuildsType.Remould) then
        val = cfg.remouldOrderPer
    end
    return val
end
    ]]

-- function this:GetNextRefreshTime()
--     local curTime = TimeUtil:GetTime()
--     local tFlush = self:GetFlushTime()
--     if (self:GetType() == BuildsType.Compound) then
--         -- LogError("tFlush:" .. tFlush)
--         -- LogError("服务器时间:" .. TimeUtil:GetTime())
--         -- LogError("tFlush剩余刷新时长：" .. tFlush - TimeUtil:GetTime())
--         -- local needTime = 0
--         -- local	baseTime = self:GetBaseTime()
--         -- local timeMul, openTime, oldLen = self:GetTimeMul()
--         -- local runLen = oldLen +(TimeUtil:GetTime() - openTime) * timeMul
--         -- LogError("oldLen：" .. oldLen)
--         -- LogError("倍数:" .. timeMul)
--         -- LogError("上次请求到现在过去了多长时间：" .. runLen)
--         -- if(self:GetData().tCur and self:GetData().tCur > 0) then
--         -- 	needTime = baseTime - self:GetData().tCur - runLen
--         -- else
--         -- 	needTime = baseTime - self:GetOldTime() - runLen
--         -- end
--         -- needTime = needTime > 0 and needTime or 0
--         -- LogError("订单完成时长：" .. needTime)
--     end
--     if (curTime <= tFlush) then
--         return tFlush
--     end
--     return 0
-- end

-- --下次刷新时间点
-- function this:GetNextRefreshTime1()
-- 	local baseTime = 0
-- 	if(self:GetType() == BuildsType.ProductionCenter) then  --生产中心
-- 		baseTime = self:GetFlushTime()
-- 	elseif(self:GetType() == BuildsType.TradingCenter) then  -- 交易中心
-- 		--计算加速
-- 		LogError("当前时间：" .. TimeUtil:GetTime())
-- 		LogError("tFlush：" .. self:GetFlushTime())
-- 		LogError("tCur：" .. self.data.tCur)
-- 		baseTime = self:GetCorrectTime(self:GetFlushTime(), self.data.tCur)
-- 		LogError(baseTime)
-- 	elseif(self:GetType() == BuildsType.Expedition or  --远征
-- 	self:GetType() == BuildsType.Compound or --合成工厂
-- 	self:GetType() == BuildsType.Remould) then   --改造工厂
-- 		--获取最快完成的时间点
-- 		--已开始的
-- 		local gifts = self.data and self.data.gifts or {}
-- 		local endTime = 0
-- 		local tCur = 0
-- 		local curTime = TimeUtil:GetTime()
-- 		for i, v in pairs(gifts) do
-- 			if((endTime == 0 or endTime > v.num) and curTime < v.num) then
-- 				endTime = v.num
-- 				tCur = v.tCur
-- 			end
-- 		end
-- 		if(endTime ~= 0) then
-- 			baseTime =	self:GetCorrectTime(endTime, tCur)
-- 		end
-- 	end
-- 	return baseTime
-- end
-- --计算加速后的结算时间点
-- function this:GetCorrectTime(tFlush, tCur)
-- 	if(tFlush <= 0) then
-- 		return 0
-- 	end
-- 	if(tCur == nil or tCur == 0 or tCur >= tFlush) then
-- 		return 0
-- 	elseif(tCur > 0) then
-- 		--需要跑的秒数
-- 		local count = 0
-- 		local timeMul, openTime, oldLen = self:GetTimeMul()
-- 		LogError("上次刷新到现在经过多长时间：" .. oldLen)
-- 		count = tFlush - oldLen - tCur
-- 		count = math.ceil(count / timeMul)
-- 		LogError("到完成需要跑多少秒：" .. count)
-- 		return openTime + count
-- 	end
-- end
function this:GetCurMax()
    local cur, max = 0, 0
    local type = self:GetType()
    if (type == BuildsType.TradingCenter) then
        -- 交易中心
        -- local gifts = self.data.gifts or {}
        -- local giftsEx = self.data.giftsEx or {}
        -- for i, v in pairs(gifts) do
        --     cur = cur + 1
        -- end
        -- for i, v in pairs(giftsEx) do
        --     cur = cur + 1
        -- end
        local giftsEx = self.data.giftsEx or {}
        for i, v in pairs(giftsEx) do
            if (v.bcnt > 0) then
                cur = cur + 1
            end
        end
        max = self:GetTradingCount()
    elseif (type == BuildsType.Expedition) then
        -- 远征 
        local gifts = self.data and self.data.gifts or {}
        for i, m in pairs(gifts) do
            for k, v in pairs(m) do
                if (v.tCur and v.tCur ~= 0) then
                    if (v.tCur >= v.num) then
                        cur = cur + 1
                    end
                else
                    if (TimeUtil:GetTime() >= v.num) then
                        cur = cur + 1
                    end
                end
                max = max + 1
            end
        end
        local giftsEx = self.data and self.data.giftsEx or {}
        for i, m in pairs(giftsEx) do
            max = max + 1
        end
    elseif (type == BuildsType.Remould) then
        -- 改造
        local arrGifts = self:GetMaterials()
        cur = 0
        if (arrGifts and #arrGifts > 0) then
            for i, v in ipairs(arrGifts) do
                if (v.tCur and v.tCur ~= 0) then
                    if (v.tCur >= v.num) then
                        cur = cur + 1
                    end
                else
                    if (TimeUtil:GetTime() >= v.num) then
                        cur = cur + 1
                    end
                end
            end
        end
        max = self:GetCfg().taskNumLimit
    elseif (type == BuildsType.Compound) then
        -- 合成
        local gifts = self.data and self.data.gifts or {}
        for i, v in pairs(gifts) do
            cur = cur + 1
        end
        max = self:GetCfg().failMaxCnt or 0
    end
    return cur, max
end

-- 入驻数量/可入驻数量
function this:GetRoleCnt()
    local cur, max = 0, 0
    local infos = self:GetRoleInfos()
    for i, v in ipairs(infos) do
        if (v.openLv == -1 or v.curLv < v.openLv) then
            break
        end
        if (v.data) then
            cur = cur + 1
        end
        max = max + 1
    end
    return cur, max
end

-- 建筑生产效益百分比    
function this:GetBenefit()
    local vals = {}

    local data = self:GetData()
    table.insert(vals, data.perBenefit)
    table.insert(vals, data.perHpBenefit)
    table.insert(vals, data.perRoleTiredBenefit)
    table.insert(vals, data.perRoleAbilityBenefit)

    local info = MatrixMgr:GetMatrixInfo()
    table.insert(vals, info.power.perBenefit)
    table.insert(vals, info.perRoleAbilityBenefit)

    local infos = self:GetRoleInfos()
    return GCalHelp:GetBuildProductBenefit(vals, #infos)
end

-- 是否有红点： 战斗+xxx
function this:CheckIsRed()
    local isRed = false
    if (MatrixAssualtTool:CheckIsRun()) then
        local monSterIndexs = MatrixAssualtTool:GetMonSterIndexs(self:GetId())
        if (monSterIndexs and #monSterIndexs > 0) then
            isRed = true
        end
    end
    if (not isRed) then
        if (self:GetType() == BuildsType.ProductionCenter or self:GetType() == BuildsType.Remould) then
            local arrGifts = self:GetMaterials()
            isRed = #arrGifts > 0
        end
    end
    return false
end

-- 远征统计： 闲置 进行  完成
function this:GetExpeditionCount()
    local num1, num2, num3 = 0, 0, 0
    local gifts = self.data and self.data.gifts or {}
    local giftsEx = self.data and self.data.giftsEx or {}
    -- 进行/完成
    for i, v in pairs(gifts) do
        for k, m in pairs(v) do
            if (m.num and m.num > TimeUtil:GetTime()) then
                num2 = num2 + 1
            else
                num3 = num3 + 1
            end
        end
    end
    -- 闲置
    for i, v in pairs(giftsEx) do
        for k, m in pairs(v) do
            if (not gifts[i] or not gifts[i][k]) then
                num1 = num1 + 1
            end
        end
    end
    return num1, num2, num3
end

-- 场景key
function this:GetSceneKey()
    return self:SetBaseCfg().sceneKey
end

-- -- 入口ui偏移
-- function this:GetEnterUIPos()
--     return self:SetBaseCfg().enterUIPos or {0, 0, 0}
-- end

-- 是建筑
function this:CheckIsBuilding()
    return self:SetBaseCfg().isShow
end

-- 是否是咨询室
function this:IsPhyRoom()
    return self:GetType() == BuildsType.PhyRoom
end

-- 是否有驻员疲劳为0 
function this:CheckRolesRed()
    local sAddRole = self:GetRoles()
    for i, v in ipairs(sAddRole) do
        local cRoleInfo = CRoleMgr:GetData(v)
        if (cRoleInfo and cRoleInfo:CheckIsRed()) then
            return true
        end
    end
    return false
end

-- 能否升级
function this:CheckCanUp()
    if (self:IsMax()) then
        return false
    end
    local _buildingState = self:GetState()
    if (_buildingState == MatrixBuildingType.Create or _buildingState == MatrixBuildingType.Upgrage) then
        return false
    end

    -- 玩家等级
    if (not self:CheckPlayerLv()) then
        return false
    end

    -- 指挥中心等级需求
    if (not self:CheckUpLv()) then
        return false
    end

    -- 材料是否足够
    local costs = self:GetCfg().upCosts
    if (costs) then
        for k, v in pairs(costs) do
            local num = BagMgr:GetCount(v[1])
            if (v[2] > num) then
                return false
            end
        end
    end
    return true
end

-- 所需玩家等级
function this:CheckPlayerLv()
    local needLv = self:GetCfg().plrlvl
    if (needLv) then
        local curLv = PlayerClient:GetLv()
        if (needLv > curLv) then
            return false, needLv
        end
        return true, needLv
    end
    return true, nil
end

-- 指挥中心等级是否符合
function this:CheckUpLv()
    local needLv = self:GetCfg().centerlvl
    if (needLv) then
        local mainData = MatrixMgr:GetMainBuilding()
        local curLv = mainData and mainData:GetLv() or 0
        if (needLv > curLv) then
            return false, needLv
        end
        return true, needLv
    end
    return true, nil
end

-- 获取能力信息   sBuildRoleAbility
function this:GetAbilityVale(type)
    local roleAbilitys = self:GetData().roleAbilitys
    if (roleAbilitys) then
        return roleAbilitys[type]
    end
    return nil
end

----------------------------------------队伍预设------------------------------------------
-- 预设角色列表
function this:GetPresetRoles()
    return self:GetData().presetRoles or {}
end
-- 当前使用的预设队伍id（默认1）
function this:GetCurPresetId()
    return self:GetData().curPresetId or 1
end

function this:SetPresetRoles(sPresetRoleTeam)
    self:GetData().presetRoles = self:GetData().presetRoles or {}
    self:GetData().presetRoles[sPresetRoleTeam.teamId] = sPresetRoleTeam
    -- local isIn = false
    -- for k, v in pairs(self:GetData().presetRoles) do
    --     if (v.teamId == sPresetRoleTeam.teamId) then
    --         v.roleIds = sPresetRoleTeam.roleIds
    --         isIn = true
    --         break
    --     end
    -- end
    -- if (not isIn) then
    --     table.insert(self:GetData().presetRoles, sPresetRoleTeam.teamId, sPresetRoleTeam)
    -- end
end

function this:SetCurPresetId(id)
    self:GetData().curPresetId = id
end

function this:SetTeamName(sPresetRoleTeam)
    self:GetData().presetRoles = self:GetData().presetRoles or {}
    self:GetData().presetRoles[sPresetRoleTeam.teamId] = sPresetRoleTeam
    -- local isIn = false
    -- for k, v in pairs(self:GetData().presetRoles) do
    --     if (v.teamId == sPresetRoleTeam.teamId) then
    --         v.name = sPresetRoleTeam.name
    --         isIn = true
    --         break
    --     end
    -- end
    -- if (not isIn) then
    --     table.insert(self:GetData().presetRoles, sPresetRoleTeam.teamId, sPresetRoleTeam)
    -- end
end

-- 待机时会更新的时间
function this:StandbyTime()
    if (not self:CheckRunning()) then
        return nil
    end
    local timer = nil
    if (self:GetType() == BuildsType.ProductionCenter) then
        timer = self:GetFlushTime()
    elseif (self:GetType() == BuildsType.TradingCenter) then
        timer = self:GetFlushTime()
    elseif (self:GetType() == BuildsType.Remould) then
        local gifts = self.data and self.data.gifts or {}
        for k, v in pairs(gifts) do
            if (timer == nil or (v.tf > TimeUtil:GetTime() and v.tf < timer)) then
                timer = v.tf
            end
        end
    end
    return timer
end

-- 生产中心资源是否已满
function this:IsGiftMax()
    local arrGifts = self:GetMaterials()
    if (not arrGifts) then
        return false
    end
    local limits = self:GetCfg().rewardLimits
    local limitsDic = {}
    for k, v in pairs(limits) do
        limitsDic[v[1]] = v[2]
    end
    for i, v in ipairs(arrGifts) do
        local max = limitsDic[v.id]
        if (v.num >= max) then
            return true
        end
    end
    return false
end

return this
