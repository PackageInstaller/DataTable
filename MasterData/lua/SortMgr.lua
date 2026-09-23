local this = MgrRegister("SortMgr")

function this:Init()
    self:Clear()

end

function this:Clear()
    self.datas = {}

end

-- 创建顶头入口item
function this:CreteSortTop(id, parent, cb)
    CSAPI.CreateGOAsync("Sort/SortTop", 0, 0, 0, parent, function(go)
        local lua = ComUtil.GetLuaTable(go)
        lua.Init(id, cb)
    end)
end

-- 获取排序筛选数据,没设置过时按照表默认设置一次
-- id：CfgSortFilter的id 
-- data:  {Sort = {id列表},SortId =排序弹窗中的某一个，Filter = { 表名1 = {0},表名2 = {0}...},UD =1：小到大 2：大到小，RolePro = 属性id}
function this:GetData(id)
    if (not self.datas[id]) then
        local data = {}
        local cfg = Cfgs.CfgSortFilter:GetByID(id)
        data.Sort = cfg.sort
        data.SortId = cfg.sort_default
        data.UD = 1
        data.Filter = nil -- 筛选
        data.RolePro = nil
        if (cfg.filter) then
            data.Filter = {}
            if (cfg.filter_default) then
                for k, v in pairs(cfg.filter_default) do -- 默认 
                    data.Filter[v[1]] = v[2]
                end
            else
                for k, v in pairs(cfg.filter) do
                    data.Filter[v[2]] = {0} -- 用表名 
                end
            end
        end
        self.datas[id] = data
    end
    return self.datas[id]
end

-- 设置数据
function this:SetData(id, data)
    self.datas[id] = data
end

-- 清除数据
function this:ClearData(id)
    self.datas[id] = nil
end

-- 是否筛选中
function this:CheckIsFilter(id)
    local data = self:GetData(id)
    if (data.Filter) then
        for k, v in pairs(data.Filter) do
            if (v[1] ~= 0) then
                return true
            end
        end
    end
    return false
end

-- 更新排序
function this:SelectSort(id, sortId, roleProId)
    local data = self:GetData(id)

    local cfg = Cfgs.CfgSortFilter:GetByID(id)
    local dic = {}
    for k, v in pairs(cfg.sort_view) do
        dic[v] = 1
    end

    local newSort = {}
    local sort = cfg.sort
    local isAdd = false
    for k, v in pairs(cfg.sort) do
        if (not dic[v]) then
            table.insert(newSort, v)
        else
            if (not isAdd) then
                isAdd = true
                table.insert(newSort, sortId)
            end
            if (v ~= SortId) then
                table.insert(newSort, v)
            end
        end
    end
    data.Sort = newSort
    data.SortId = sortId
    data.RolePro = roleProId
end

-- 排序总表 id ； datas : 需要排序筛选的数据  elseData:辅助排序的自定义参数
function this:Sort(id, datas, elseData)
    local newDatas = {}
    for k, v in pairs(datas) do
        table.insert(newDatas, v)
    end
    local sortData = self:GetData(id)
    -- 筛选 
    local filter = sortData.Filter
    if (filter) then
        for k, v in pairs(filter) do
            if (v[1] ~= 0) then
                local func = this["Filter_" .. k]
                -- local dic = self.ToDic(v)
                local dic=self:EnumCovertToDic(k,v)
                newDatas = func(newDatas, dic)
            end
        end
    end
    -- 排序方法
    local sortFuncs = {}
    local ids = sortData.Sort
    for k, v in ipairs(ids) do
        table.insert(sortFuncs, this["SortFunc_" .. v])
    end
    table.sort(newDatas, function(a, b)
        local result = nil
        for k, v in ipairs(sortFuncs) do
            if (result == nil) then
                result = v(a, b, sortData, elseData) -- 传值
            else
                break
            end
        end
        if (result == nil) then
            return false
        end
        return result
    end)
    -- 上下
    if (sortData.UD == 1) then
        return newDatas
    else
        return FuncUtil.Reverse(newDatas)
    end
end

--将筛选枚举转换为字典
function this:EnumCovertToDic(k,arr)
    local dic=nil;
    if k=="CfgGoodsSortEnum" then
        dic={};
        for k, v in ipairs(arr) do
            local cfg=Cfgs.CfgGoodsSortEnum:GetByID(v);
            if cfg then
                dic[cfg.tagId]=1;
            end
        end
    else
        dic = self.ToDic(arr)
    end
    return dic;
end

-- -- 排序总表 id ； datas : 需要排序筛选的数据  elseData:辅助排序的自定义参数
-- function this:Sort2(id, datas, elseData)
--     local newDatas = {}
--     for k, v in pairs(datas) do
--         table.insert(newDatas, v)
--     end
--     local sortData = self:GetData(id)
--     -- 筛选 
--     local filter = sortData.Filter
--     if (filter) then
--         for k, v in pairs(filter) do
--             if (v[1] ~= 0) then
--                 local func = this["Filter_" .. k]
--                 local dic = self.ToDic(v)
--                 newDatas = func(newDatas, dic)
--             end
--         end
--     end
--     -- 排序方法
--     local sortFuncs = {}
--     local ids = sortData.Sort
--     if id==4 and elseData and (elseData.isTower==true or elseData.isTotalBattle or elseData.isRogueT) then
--         table.insert(sortFuncs,function(a,b)
--             local aNum=a.canDrag and 1 or 0;
--             local bNum=b.canDrag and 1 or 0;
--             if aNum~=bNum then
--                 return aNum>bNum;
--             end
--         end);
--     end
--     for k, v in ipairs(ids) do
--         table.insert(sortFuncs, this["SortFunc_" .. v])
--     end
--     table.sort(newDatas, function(a, b)
--         local result = nil
--         for k, v in ipairs(sortFuncs) do
--             if (result == nil) then
--                 result = v(a, b, sortData, elseData) -- 传值
--             else
--                 break
--             end
--         end
--         if (result == nil) then
--             return false
--         end
--         return result
--     end)
--     -- 上下
--     if (sortData.UD == 1) then
--         return newDatas
--     else
--         return FuncUtil.Reverse(newDatas)
--     end
-- end

-- 筛选数据转成字典
function this.ToDic(arr)
    local dic = {}
    for k, v in ipairs(arr) do
        dic[v] = 1
    end
    return dic
end

--------------------------------------------------筛选-----------------------------------------------------

-- 所属小队 
function this.Filter_CfgTeamEnum(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        if  v.GetClassType~=nil and (v:GetClassType()=="CommodityData" or  v:GetClassType()=="RandCommodityData") then
            local skinInfo=ShopCommFunc.GetSkinInfo(v);
            if skinInfo and (dic[skinInfo:GetCamp()]) then
                table.insert(_newDatas, v)
            end
        else
            if (dic[v:GetCamp()]) then
                table.insert(_newDatas, v)
            end
        end
    end
    return _newDatas
end

-- 皮肤所属
function this.Filter_CfgIsSkin(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        local skinTypeArr = v:GetSkinTypeArr()
        if (skinTypeArr and #skinTypeArr > 0) then
            for n, m in pairs(skinTypeArr) do
                if (dic[m]) then
                    table.insert(_newDatas, v)
                    break
                end
            end
        end
    end
    return _newDatas
end

-- 稀有度
function this.Filter_CfgCardSortQuality(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        if v.GetClassType~=nil and (v:GetClassType()=="CommodityData" or  v:GetClassType()=="RandCommodityData") then
            local skinInfo=ShopCommFunc.GetSkinInfo(v);
            if skinInfo and (dic[skinInfo:GetSortQuality() - 2]) then
                table.insert(_newDatas, v)
            end
        else
            if (dic[v:GetQuality() - 2]) then
                table.insert(_newDatas, v)
            end
        end
    end
    return _newDatas
end

-- 定位
function this.Filter_CfgRolePosEnum(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        local posEnum = v:GetPosEnum() or {}
        for k, m in pairs(posEnum) do
            if (dic[m]) then
                table.insert(_newDatas, v)
                break
            end
        end
    end
    return _newDatas
end

-- 多人插图主题 
function this.Filter_CfgMultiImageThemeType(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        if (dic[v:GetThemeType()]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

-- 物品类型
function this.Filter_CfgGoodsSortEnum(newDatas, dic)
    -- todo 
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        local cfg = v:GetCfg()
        if (dic[cfg.tag]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

-- 芯片品质 
function this.Filter_CfgEquipQualityEnum(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        if (dic[v:GetQuality()]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

-- 芯片类型 
function this.Filter_CfgEquipSlotEnum(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        if (dic[v:GetSlot()]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

-- 佩戴类型 
function this.Filter_CfgIsEquipEnum(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        local key = v:IsEquippedNum() == 1 and 1 or 2;
        if (dic[key]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

-- 芯片技能
function this.Filter_CfgEquipSkillTypeSortEnum(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        for k, _ in pairs(dic) do
            if v:GetSkillInfoByMainType(k,true) then
                table.insert(_newDatas, v)
            end
        end
    end
    return _newDatas
end

-- 芯片副技能
function this.Filter_CfgEquipSkillTypeSortEnumse(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        for k, _ in pairs(dic) do
            if v:GetSkillInfoByMainType(k,false) then
                table.insert(_newDatas, v)
            end
        end
    end
    return _newDatas
end

--筛选主技能等级
function this.Filter_CfgEquipSkillTypeSortEnumlv(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        local lv=v:GetMainSkillLv();
        if dic[lv] then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

--筛选芯片产出途径
function this.Filter_CfgEquipDunGeonRewards(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        local getType=v:GetDungeonRewards();
        if (dic[getType]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

-- 增加订单的角色
function this.Filter_CfgMatrixOrderType(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        for k, val in pairs(dic) do
            if (v:GetAbilityType() and dic[v:GetAbilityType()]) then
                table.insert(_newDatas, v)
                break
            end
        end
    end
    return _newDatas
end
-- 头像框
function this.Filter_CfgIsAvatar(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        for k, val in pairs(dic) do
            if (v:GetClassType() and dic[v:GetClassType()]) then
                table.insert(_newDatas, v)
                break
            end
        end
    end
    return _newDatas
end
-- 成就
function this.Filter_CfgAchieveQualitySort(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        for k, val in pairs(dic) do
            if (v:GetQuality() and dic[v:GetQuality()]) then
                table.insert(_newDatas, v)
                break
            end
        end
    end
    return _newDatas
end

-- 看板 角色，多人插图
function this.Filter_CfgRandomRoleType(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        for k, val in pairs(dic) do
            if (v:GetRoleType() and dic[v:GetRoleType()]) then
                table.insert(_newDatas, v)
                break
            end
        end
    end
    return _newDatas
end

-- 半身像
function this.Filter_CfgHalfBodyType(newDatas, dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        if (dic[v:GetHalfBodyType()]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

function this.Filter_CfgSkinSeriesEnum(newDatas,dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        local skinInfo=ShopCommFunc.GetSkinInfo(v);
        if skinInfo and (dic[skinInfo:GetSetID()]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

function this.Filter_CfgExtraCultivation(newDatas,dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        if (dic[v:GetZWSortNum()] or dic[v:GetHaloSortNum()]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

--皮肤复刻选项
function this.Filter_CfgReplicaSkin(newDatas,dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        local idx=v:IsReplicaSkin() and 1 or 0
        if (dic[idx]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

--是否存在卡牌
function this.Filter_CfgRolealready(newDatas,dic)
    local _newDatas = {}
    for i, v in pairs(newDatas) do
        local currSkin=ShopCommFunc.GetSkinInfo(v);
        local idx=0;
        if currSkin then
            local curModelCfg=currSkin:GetModelCfg();
            if curModelCfg then
                if RoleMgr:GetCardsByCfgID(curModelCfg.role_id)~=nil then    
                    idx=1;        
                else
                    idx=2;
                end
            end
        end     
        if (dic[idx]) then
            table.insert(_newDatas, v)
        end
    end
    return _newDatas
end

--------------------------------------------------筛选end-----------------------------------------------------

--------------------------------------------------排序-----------------------------------------------------

-- 卡牌
function this.SortFunc_1000(a, b)
    if (a:GetCfgID() == b:GetCfgID()) then
        return nil
    else
        return a:GetCfgID() < b:GetCfgID()
    end
end
function this.SortFunc_1001(a, b)
    if (a:GetQuality() == b:GetQuality()) then
        return nil
    else
        return a:GetQuality() > b:GetQuality()
    end
end
function this.SortFunc_1002(a, b)
    if (a:GetLv() == b:GetLv()) then
        return nil
    else
        return a:GetLv() > b:GetLv()
    end
end
function this.SortFunc_1003(a, b)
    if (a:GetFavorability() == b:GetFavorability()) then
        return nil
    else
        return a:GetFavorability() > b:GetFavorability()
    end
end
function this.SortFunc_1004(a, b)
    if (a:GetAcquireTime() == b:GetAcquireTime()) then
        return nil
    else
        return a:GetAcquireTime() > b:GetAcquireTime()
    end
end
function this.SortFunc_1005(a, b)
    if (a:GetProperty() == b:GetProperty()) then
        return nil
    else
        return a:GetProperty() > b:GetProperty()
    end
end
function this.SortFunc_1006(a, b, sortData) -- 属性 
    if (sortData.RolePro) then
        local proName = Cfgs.CfgCardPropertyEnum:GetByID(sortData.RolePro).sFieldName
        if (a:GetCurDataByKey(proName) == b:GetCurDataByKey(proName)) then
            return nil
        else
            return a:GetCurDataByKey(proName) > b:GetCurDataByKey(proName)
        end
    end
    return nil
end
function this.SortFunc_1007(a, b)
    if (a:IsNewNum() == b:IsNewNum()) then
        return nil
    else
        return a:IsNewNum() > b:IsNewNum()
    end
end
function this.SortFunc_1008(a, b)
    local i1 = TeamMgr:GetCardTeamIndex(a:GetID(), eTeamType.DungeonFight, true)
    local i2 = TeamMgr:GetCardTeamIndex(b:GetID(), eTeamType.DungeonFight, true)
    local index1 = (i1 == nil or i1 == -1) and 10000 or tonumber(i1)
    local index2 = (i2 == nil or i2 == -1) and 10000 or tonumber(i2)

    if (index1 == index2) then
        return nil
    else
        -- if (teamID == index1 and teamID ~= index2) then
        --     return true
        -- elseif (teamID ~= index1 and teamID == index2) then
        --     return false
        -- else
        --     return index1 < index2
        -- end
        return index1 < index2
    end
end
function this.SortFunc_1009(a, b) -- 助战中
    if (a:SupportSortNum() == b:SupportSortNum()) then
        return nil
    else
        return a:SupportSortNum() > b:SupportSortNum()
    end
end
function this.SortFunc_1010(a, b) -- 可拖拽
    local n1 = a.canDrag and 1 or 0
    local n2 = b.canDrag and 1 or 0
    if (n1 == n2) then
        return nil
    else
        return n1 > n2
    end
end
function this.SortFunc_1011(a, b) -- 是推荐角色
    local n1 = a.isStar and 1 or 0
    local n2 = b.isStar and 1 or 0
    if (n1 == n2) then
        return nil
    else
        return n1 > n2
    end
end
-- 道具/仓库
function this.SortFunc_2000(a, b)
    if (a:GetCfgID() == b:GetCfgID()) then
        return nil
    else
        return a:GetCfgID() < b:GetCfgID()
    end
end
function this.SortFunc_2001(a, b)
    if (a:GetQuality() == b:GetQuality()) then
        return nil
    else
        return a:GetQuality() > b:GetQuality()
    end
end

-- 芯片 
function this.SortFunc_3000(a, b) -- 用id而不是表id，否则无法穷尽
    if (a:GetID() == b:GetID()) then
        return nil
    else
        return a:GetID() < b:GetID()
    end
end
function this.SortFunc_3001(a, b)
    if (a:GetQuality() == b:GetQuality()) then
        return nil
    else
        return a:GetQuality() > b:GetQuality()
    end
end
function this.SortFunc_3002(a, b)
    if (a:GetLv() == b:GetLv()) then
        return nil
    else
        return a:GetLv() > b:GetLv()
    end
end
function this.SortFunc_3003(a, b)
    if (a:GetSlot() == b:GetSlot()) then
        return nil
    else
        return a:GetSlot() < b:GetSlot()
    end
end
function this.SortFunc_3004(a, b)
    if (a:IsLockNum() == b:IsLockNum()) then
        return nil
    else
        return a:IsLockNum() > b:IsLockNum()
    end
end
function this.SortFunc_3005(a, b)
    if (a:GetOrder() == b:GetOrder()) then
        return nil
    else
        return a:GetOrder() > b:GetOrder()
    end
end
function this.SortFunc_3006(a, b)
    -- 点数
    -- 判断第一个技能点的值大小
    local a1 = a:GetSkillInfo(1)
    local b1 = b:GetSkillInfo(1)
    if a1 and b1 then
        if a1.nLv == b1.nLv then
            if (a:GetTotalSkillValue() == b:GetTotalSkillValue()) then
                return nil
            else
                return a:GetTotalSkillValue() > b:GetTotalSkillValue()
            end
        else
            return a1.nLv > b1.nLv
        end
    else
        if (a:GetTotalSkillValue() == b:GetTotalSkillValue()) then
            return nil
        else
            return a:GetTotalSkillValue() > b:GetTotalSkillValue()
        end
    end
end
function this.SortFunc_3007(a, b)
    -- 新获得 
    if (a:IsNewNum() == b:IsNewNum()) then
        return nil
    else
        return a:IsNewNum() > b:IsNewNum()
    end
end
function this.SortFunc_3008(a, b)
    if (a:IsEquippedNum() == b:IsEquippedNum()) then
        return nil
    else
        return a:IsEquippedNum() > b:IsEquippedNum()
    end
end
function this.SortFunc_3009(a, b)
    if (a:GetQuality() == b:GetQuality()) then
        return nil
    else
        return a:GetQuality() < b:GetQuality()
    end
end
-- 套装技能
function this.SortFunc_3010(a, b)
    if (a:GetSuitID() == b:GetSuitID()) then
        return nil
    else
        return a:GetSuitID() < b:GetSuitID()
    end
end

-- 角色 
function this.SortFunc_4000(a, b)
    if (a:GetCfgID() == b:GetCfgID()) then
        return nil
    else
        return a:GetCfgID() < b:GetCfgID()
    end
end
function this.SortFunc_4001(a, b, sortData, buildId) -- 技能生效
    if (buildId ~= nil) then
        local num1 = a:CheckSkillCanUseByBuildID(buildId) and 1 or 0
        local num2 = b:CheckSkillCanUseByBuildID(buildId) and 1 or 0
        if (num1 ~= num2) then
            return num1 > num2
        end
    end
    return nil
end
function this.SortFunc_4002(a, b)
    if (a:GetCurRealTv() == b:GetCurRealTv()) then
        return nil
    else
        return a:GetCurRealTv() > b:GetCurRealTv()
    end
end
function this.SortFunc_4003(a, b)
    if (a:GetCreateTime() == b:GetCreateTime()) then
        return nil
    else
        return a:GetCreateTime() > b:GetCreateTime()
    end
end
function this.SortFunc_4004(a, b)
    if (a:GetQuality() == b:GetQuality()) then
        return nil
    else
        return a:GetQuality() > b:GetQuality()
    end
end
function this.SortFunc_4005(a, b, sortData, buildId) -- 本建筑已入驻
    if (a:Sort_CheckInBuilding(buildId) == b:Sort_CheckInBuilding(buildId)) then
        return nil
    else
        return a:Sort_CheckInBuilding(buildId) > b:Sort_CheckInBuilding(buildId)
    end
end
function this.SortFunc_4006(a, b) -- 其他建筑未入驻
    if (a:Sort_CheckBuildingIsNil() == b:Sort_CheckBuildingIsNil()) then
        return nil
    else
        return a:Sort_CheckBuildingIsNil() > b:Sort_CheckBuildingIsNil()
    end
end
function this.SortFunc_4007(a, b)
    if (a:GetCurRealTv() == b:GetCurRealTv()) then
        return nil
    else
        return a:GetCurRealTv() < b:GetCurRealTv()
    end
end
function this.SortFunc_4008(a, b)
    if (a:GetLv() == b:GetLv()) then
        return nil
    else
        return a:GetLv() > b:GetLv()
    end
end
function this.SortFunc_4009(a, b) -- 能力类型是13的拍前面，其他的由小到大
    if (a:GetAbilitySortType13() == b:GetAbilitySortType13()) then
        return nil
    else
        return a:GetAbilitySortType13() < b:GetAbilitySortType13()
    end
end
function this.SortFunc_4010(a, b) -- 皮肤获得时间
    if (a:GetSkinsNTime() == b:GetSkinsNTime()) then
        return nil
    else
        return a:GetSkinsNTime() > b:GetSkinsNTime()
    end
end

-- 多人看板 
function this.SortFunc_5000(a, b)
    if (a:GetSort() == b:GetSort()) then
        return nil
    else
        return a:GetSort() < b:GetSort()
    end
end
function this.SortFunc_5001(a, b)
    if (a:GetAcquireTime() == b:GetAcquireTime()) then
        return nil
    else
        return a:GetAcquireTime() > b:GetAcquireTime()
    end
end
function this.SortFunc_5002(a, b)
    if (a:IsHadNum() == b:IsHadNum()) then
        return nil
    else
        return a:IsHadNum() > b:IsHadNum()
    end
end

function this.SortFunc_6000(a, b)
    if (a:GetID() == b:GetID()) then
        return nil
    else
        return a:GetID() < b:GetID()
    end
end
function this.SortFunc_6001(a, b)
    if (a:GetQuality() == b:GetQuality()) then
        return nil
    else
        return a:GetQuality() < b:GetQuality()
    end
end
function this.SortFunc_6002(a, b)
    if (a:GetPriceNum() == b:GetPriceNum()) then
        return nil
    else
        return a:GetPriceNum() < b:GetPriceNum()
    end
end
function this.SortFunc_6003(a, b)
    if (a:GetGroup() == b:GetGroup()) then
        return nil
    else
        return a:GetGroup() < b:GetGroup()
    end
end
function this.SortFunc_6004(a, b)
    if (a:IsOpenSortIndex() == b:IsOpenSortIndex()) then
        return nil
    else
        return a:IsOpenSortIndex() < b:IsOpenSortIndex()
    end
end
function this.SortFunc_7000(a, b)
    if a.id == b.id then
        return nil
    else
        return a.id > b.id
    end
end

function this.SortFunc_7001(a, b)
    if a.type ~= b.type then
        return nil
    end
    local data1, data2 = nil, nil
    data1 = GridFakeData(a)
    data2 = GridFakeData(b)
    if data1:GetQuality() == data2:GetQuality() then
        return nil
    else
        return data1:GetQuality() > data2:GetQuality()
    end
end

function this.SortFunc_7002(a, b)
    local priorities = {4, 2, 1, 3, 5} -- 类型优先度,低的排前面
    if a.type == b.type then
        return nil
    else
        return priorities[a.type] < priorities[b.type]
    end
end

function this.SortFunc_7003(a, b)
    local tag1 = a.tag or 10000
    local tag2 = b.tag or 10000
    if tag1 == tag2 then
        return nil
    else
        return tag1 < tag2
    end
end

function this.SortFunc_8000(a, b)
    return a:GetSortIndex() < b:GetSortIndex()
end

function this.SortFunc_8000(a, b)
    return a:GetSortIndex() < b:GetSortIndex()
end

function this.SortFunc_9000(a, b)
    return a:GetID() > b:GetID()
end

function this.SortFunc_9001(a, b)
    if a:GetQuality() == b:GetQuality() then
        return nil
    else
        return a:GetQuality() > b:GetQuality()
    end
end

function this.SortFunc_9002(a, b)
    local index1 = (a:IsFinish() and not a:IsGet()) and 3 or 2
    local index2 = (b:IsFinish() and not b:IsGet()) and 3 or 2
    index1 = a:IsGet() and 1 or index1
    index2 = b:IsGet() and 1 or index2
    if index1 == index2 then
        return nil
    else
        return index1 > index2
    end
end

function this.SortFunc_9003(a, b)
    if a:GetPercent(true) == b:GetPercent(true) then
        return nil
    else
        return a:GetPercent(true) > b:GetPercent(true)
    end
end

function this.SortFunc_9004(a, b)
    if a:GetFinishTime() == b:GetFinishTime() then
        return nil
    else
        return a:GetFinishTime() > b:GetFinishTime()
    end
end

function this.SortFunc_10001(a, b)
    if a:GetIdx() == b:GetIdx() then
        return nil
    else
        return a:GetIdx() > b:GetIdx()
    end
end

---------------------光环装备排序
function this.SortFunc_11001(a, b)
    if a:IsEquipped() == b:IsEquipped() then
        return nil
    else
        return a:IsEquipped() > b:IsEquipped()
    end
end

function this.SortFunc_11002(a, b)
    if a:GetQuality() == b:GetQuality() then
        return nil
    else
        return a:GetQuality() > b:GetQuality()
    end
end

function this.SortFunc_11003(a, b)
    if a:GetAddtiveNum() == b:GetAddtiveNum() then
        return nil
    else
        return a:GetAddtiveNum() > b:GetAddtiveNum()
    end
end

function this.SortFunc_12001(a,b)
    return ShopCommFunc.SortSkinComm(a,b)
end

--------------------------------------------------排序end-----------------------------------------------------
return this
