-- 系统主题数据
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

-- 通过主题表id来初始化
function this:InitDataByCfgID(_id)
    self.themeType = ThemeType.Sys
    self.id = _id
    self.datas = {}
    self.cfg = self:GetCfg()
    local lvCfg = self:GetMaxLvCfg()
    local buyRecords = DormMgr:GetBuyRecords()
    for i, v in ipairs(lvCfg.infos) do
        local cfgID = v.cfgID
        local hadNum = buyRecords[cfgID]
        self:SetData(v.cfgID, hadNum)
    end
end

-- 通过主题数据来初始化
function this:InitDataBuyThemeData(_themeData)
    self.themeType = nil
    self:InitByFurnitureDatas(_themeData.furnitures)
end

-- 通过家具列表来初始化
function this:InitByFurnitureDatas(furnitures)
    self.themeType = nil
    self.datas = {}
    local buyRecords = DormMgr:GetBuyRecords()
    for i, v in pairs(furnitures) do
        local cfgID = GCalHelp:GetDormFurCfgId(v.id)
        local hadNum = buyRecords[cfgID] or 0
        self:SetData(cfgID, hadNum)
    end
end

function this:SetData(cfgID, hadNum)

    if (self.datas[cfgID]) then
        self.datas[cfgID].needNum = self.datas[cfgID].needNum + 1
    else
        local fCfg = Cfgs.CfgFurniture:GetByID(cfgID)
        self.datas[cfgID] = {}
        self.datas[cfgID].id = cfgID
        self.datas[cfgID].needNum = 1
        self.datas[cfgID].sType = fCfg.sType
        self.datas[cfgID].hadNum = hadNum or 0
        self.datas[cfgID].buyNumLimit = fCfg.buyNumLimit
        --self.datas[cfgID].priceIndex = fCfg.priceIndex
        self.datas[cfgID].price1 = fCfg.price_1[1]
        self.datas[cfgID].price2 = fCfg.price_2[1]
    end
end

function this:GetID()
    return self.id
end
function this:GetCfg()
    return Cfgs.CfgFurnitureTheme:GetByID(self:GetID())
end
function this:GetMaxLvCfg()
    local cfg = self:GetCfg()
    local len = #cfg.infos
    local id = cfg.infos[len].layoutId
    return Cfgs.CfgThemeLayout:GetByID(id)
end

-- 主题家具id列表(已排序)
function this:Arr()
    local arr = {}
    for i, v in pairs(self.datas) do
        table.insert(arr, v)
    end
    -- 排序:是否买满>类型>cfgID 
    if (#arr > 0) then
        table.sort(arr, function(a, b)
            local num1 = a.needNum > a.buyNumLimit and 0 or 1
            local num2 = b.needNum > b.buyNumLimit and 0 or 1
            if (num1 ~= num2) then
                return num1 < num2
            elseif (a.sType ~= b.sType) then
                return a.sType < b.sType
            else
                return a.id < b.id
            end
        end)
    end
    return arr
end

-- 一键购买主题的消耗(当前所需,已买的不计入,不放置的不计入)
function this:GetCost(isPrice1)
    local cost = {}
    for i, v in pairs(self.datas) do
        local price = isPrice1 and v.price1 or v.price2
        cost.id = cost.id and cost.id or price[1]
        local num = price[2] * (v.needNum - v.hadNum)
        cost.num = cost.num and cost.num + num or num
    end
    return cost
end

-- 是否够钱一键够买主题
function this:CheckIsEnough()
    local cost = self:GetCost()
    local num = BagMgr:GetCount(cost.id)
    return num > cost.num, cost
end

function this:GetSpendStr()
    local cost = self:GetCost()
    -- local str = Cfgs.ItemInfo:GetByID(cost.id).name
    -- str = string.format("所需费用：%s %s", str, cost.num)
    return cost.num .. ""
end

function this:CheckIsSys()
    return self.themeType == ThemeType.Sys
end

-- 主题是否已购买完成(忽略钻石家具)
function this:CheckIsBuy()
    if (self:CheckIsSys()) then
        local data = DormMgr:GetThemesByID(ThemeType.Sys, self:GetID())
        return data ~= nil
    else
        -- 别人的主题
        for i, v in pairs(self.datas) do
            if (v.hadNum < v.needNum) then
                return false
            end
        end
        return true
    end
end

-- -- 有钻石部分的未购买
-- function this:CheckTips()
--     for i, v in pairs(self.datas) do
--         if (not v.isNormal and v.hadNum < v.needNum) then
--             return true
--         end
--     end
--     return false
-- end

-- 购买剩余家具
function this:GetBuyList()
    local list = {}
    for i, v in pairs(self.datas) do
        if (v.hadNum < v.needNum) then
            table.insert(list, {
                id = v.id,
                num = v.needNum - v.hadNum
            })
        end
    end
    return list
end

function this:SetInfos(name, icon, desc, sEnName)
    self.name = name
    self.icon = icon
    self.desc = desc or ""
    self.sEnName = sEnName or ""
end

function this:GetName()
    return self.name, self.sEnName
end
function this:GetDesc()

    return self.desc
end

function this:GetIcon()
    return self.icon
end

return this
