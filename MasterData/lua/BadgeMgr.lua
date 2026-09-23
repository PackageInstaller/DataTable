BadgeMgr = MgrRegister("BadgeMgr")
local this = BadgeMgr;

function this:Init()
    self:Clear()
    self:InitDatas()
    BadgedProto:GetBadgedInfo()
    BadgedProto:GetSortBadgedInfo()
end

function this:InitDatas()
    local cfgs = Cfgs.CfgBadge:GetAll()
    if cfgs then
        for _, cfg in pairs(cfgs) do
            local data = BadgeData.New()
            data:Init(cfg)
            if not data:IsHide() then
                self.datas[cfg.id] = data
            end
        end
    end
end

function this:SetDatas(proto)
    if proto then
        if proto.infos and #proto.infos > 0 then
            self:UpdateDatas(proto.infos)
        end
        if proto.is_finish then
            self.isFirst = true
            self:CheckRedPointData()
            EventMgr.Dispatch(EventType.Badge_Data_Update)
        end
    end
end

function this:UpdateBadgedInfo(proto)
    if proto then
        if proto.infos and #proto.infos > 0 then
            self:UpdateDatas(proto.infos)
        end
        if proto.is_finish then
            if self.isFirst then
                MissionMgr:ApplyShowMisionTips()
            end
            self:CheckRedPointData()
            EventMgr.Dispatch(EventType.Badge_Data_Update)
        end
    end
end

function this:UpdateDatas(infos)
    local newInfos = FileUtil.LoadByPath("Badge_new_info.txt") or {} -- 记录new
    self.hasNew = false
    for i, v in ipairs(infos) do
        if self.datas[v.id] then
            self.datas[v.id]:SetFinishTime(v.finish_time)
            self.datas[v.id]:SetIsNew(v.is_new)
            if v.is_new then
                self.hasNew = true
                newInfos[v.id] = 1
                if self.isFirst then
                    self:UpdateChangeData(self.datas[v.id])
                end
            end
        end
    end
    FileUtil.SaveToFile("Badge_new_info.txt", newInfos)
end

function this:GetDatas()
    return self.datas
end

function this:GetData(id)
    return self.datas[id]
end

function this:GetArr(group)
    local datas = {}
    local typeDatas = {}
    local typeInfos = FileUtil.LoadByPath("Badge_type_info.txt") or {}
    for _, v in pairs(self.datas) do
        if not group or v:GetGroup() == group then
            if TimeUtil:GetTime() >= v:GetStartTime() then
                if v:GetType() then
                    typeDatas[v:GetType()] = typeDatas[v:GetType()] or {}
                    table.insert(typeDatas[v:GetType()], v)
                else
                    table.insert(datas, v)
                end
            end
        end
    end
    for _, list in pairs(typeDatas) do
        if #list > 0 then
            table.sort(list, function(a, b)
                if typeInfos[a:GetType()] then -- 上次选中记录
                    return typeInfos[a:GetType()] == a:GetID()
                elseif (a:IsGet() and b:IsGet()) then
                    return a:GetTypeSort() < b:GetTypeSort()
                elseif (not a:IsGet() and not b:IsGet()) then
                    return a:GetTypeSort() > b:GetTypeSort()
                else
                    return a:IsGet()
                end
            end)
            table.insert(datas, list[1])
        end
    end

    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetSort() < b:GetSort()
        end)
    end
    return datas
end

-- 获取系列徽章
function this:GetArrByType(_type)
    local datas = {}
    if _type then
        for _, v in pairs(self.datas) do
            if v:GetType() == _type then
                table.insert(datas, v)
            end
        end
    end
    if #datas > 0 then
        local typeInfos = FileUtil.LoadByPath("Badge_type_info.txt") or {}
        table.sort(datas, function(a, b)
            if typeInfos[a:GetType()] then -- 上次选中记录
                return typeInfos[a:GetType()] == a:GetID()
            elseif (a:IsGet() and b:IsGet()) or (not a:IsGet() and not b:IsGet()) then
                return a:GetTypeSort() < b:GetTypeSort()
            else
                return a:IsGet()
            end
        end)
    end
    return datas
end

function this:GetNewArr()
    local datas = {}
    for k, v in pairs(self.datas) do
        if v:GetIsNew() then
            table.insert(datas, v)
        end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetQuality() < b:GetQuality()
        end)
    end
    return datas
end

-- 更新new状态
function this:UpdateNewDatas()
    local ids = {}
    for k, v in pairs(self.datas) do
        if v:GetIsNew() then
            table.insert(ids, v:GetID())
        end
    end
    if #ids > 0 then
        BadgedProto:UpdateBadged(ids)
    end
end

function this:HasNew()
    return self.hasNew
end

-- 装备栏徽章
function this:SetSorts(proto)
    self.sortBadges = {}
    self.sortCache = {}
    if proto and proto.pos and #proto.pos > 0 then
        for i, v in ipairs(proto.pos) do
            self.sortBadges[v.num] = v.sid 
            self.sortCache[v.num] = v.sid 
        end
        EventMgr.Dispatch(EventType.Badge_Sort_Update)
    end
end

function this:GetSorts()
    return self.sortBadges
end

function this:GetSort(index)
    return self.sortBadges[index]
end

-- 获取装备栏数据
function this:GetSortArr()
    local datas = {}
    local max = g_BadgeMax or 6
    for i = 1, max do
        datas[i] = self.datas[self.sortBadges[i]]
    end
    return datas
end

-- id为空表示当前无徽章装备
function this:UpdateSort(index, id)
    index = index or 0
    if index > 0 then
        self.sortBadges[index] = id
    end
end

function this:UpdateSorts(infos)
    if infos == nil then
        return
    end
    local max = g_BadgeMax or 6
    for i = 1, max do
        self.sortBadges[i] = infos[i]
    end
end

-- 当前id是否装备中
function this:IsEquip(id)
    for k, _id in pairs(self.sortBadges) do
        if _id == id then
            return true, k
        end
    end
    return false, 0
end

function this:SendSorts()
    if not self:IsChange() then
        return
    end
    local datas = {}
    local max = g_BadgeMax or 6
    for i = 1, max do
        datas[i] = {
            sid = self.sortBadges[i],
            num = i
        }
    end
    BadgedProto:UpdateSortBadged(datas,function ()
        LanguageMgr:ShowTips(36005)
        EventMgr.Dispatch(EventType.Badge_Sort_Update)
    end)
end

--有无改变
function this:IsChange()
    local max = g_BadgeMax or 6
    for i = 1, max do
        if self.sortBadges[i] ~= self.sortCache[i] then
            return true
        end
    end
    return false
end

--还原
function this:Restore()
    local max = g_BadgeMax or 6
    for i = 1, max do
        self.sortBadges[i] = self.sortCache[i]
    end
end

function this:Clear()
    self.datas = {}
    self.sortBadges = {}
    self.sortCache = {}
    self.hasNew = false

    self.changeDatas={}
    self.isFirst = false
end

----------------------------------------------------red----------------------------------------------------
function this:CheckRedPointData()
    local redData = nil
    redData = self.hasNew and 1 or nil
    RedPointMgr:UpdateData(RedPointType.Badge, redData)
end
----------------------------------------------------tips----------------------------------------------------
function this:UpdateChangeData(v)
    self.changeDatas = self.changeDatas or {}
    local data = BadgeChangeInfo.New()
    data:Init(v)
    self.changeDatas[v:GetID()] = data
end

-- 弹提示数据
function this:GetChangeDatas()
    if not MenuMgr:CheckModelOpen(OpenViewType.main,"BadgeView") then
        return {}
    end
    local arr = {}
    for i, v in pairs(self.changeDatas) do
        table.insert(arr, v)
    end
    if (#arr > 1) then
        table.sort(arr, function(a, b)
            return a:GetCfgID() < b:GetCfgID()
        end)
    end
    self.changeDatas = {}
    return arr
end

return this
