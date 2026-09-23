AchievementMgr = MgrRegister("AchievementMgr")
local this = AchievementMgr;

function this:Init()
    self:Clear()
    self:InitListDatas()
    self:InitDatas()
    AchievementProto:GetFinishInfo()
    AchievementProto:GetRewardInfo()
end

function this:InitListDatas()
    local cfgs = Cfgs.CfgAchieveType:GetAll()
    for _, cfg in pairs(cfgs) do
        if cfg.infos then
            for _, info in ipairs(cfg.infos) do
                 local data = AchievementListData.New()
                 data:Init(info)
                 self.listDatas[info.typeNum] = data
            end
        end
    end
end

function this:GetListDatas()
    return self.listDatas
end

function this:GetListArr()
    local datas = {}
    if self.listDatas then
        for k, v in pairs(self.listDatas) do
            if v:IsShow() then
                table.insert(datas,v)
            end
        end
    end
    if #datas>0 then
        table.sort(datas,function (a,b)
            return a:GetID() < b:GetID()
        end)
    end
    return datas
end

--CfgAchieveType.id
function this:GetListArr2(cfgId)
    local datas = {}
    local cfg = Cfgs.CfgAchieveType:GetByID(cfgId)
    if cfg and cfg.infos and #cfg.infos >0 then
        for i, v in ipairs(cfg.infos) do
            if self.listDatas[v.typeNum] and self.listDatas[v.typeNum]:IsShow() then
                table.insert(datas,self.listDatas[v.typeNum])
            end
        end
    end
    if #datas>0 then
        table.sort(datas,function (a,b)
            return a:GetIndex()< b:GetIndex()
        end)
    end
    return datas
end

function this:GetListData(id)
    return self.listDatas[id]
end

function this:InitDatas()
    local cfgs = Cfgs.CfgAchieve:GetAll()
    for _, cfg in pairs(cfgs) do
        local data = AchievementData.New()
        data:Init(cfg)
        self.datas[cfg.id] = data
    end
end

function this:SetDatas(proto)
    if proto then
        if proto.finish_list then
            self.finishes = self.finishes or {}
            for k, v in pairs(proto.finish_list) do
                self.finishes[v.sid] = v.num
            end
            self.datas = self.datas or {}
            for k, v in pairs(self.datas) do
                v:SetFinish(self.finishes)
            end
        end
        if proto.is_finish then
            EventMgr.Dispatch(EventType.Achievement_Data_Update)
        end
    end
end

--更新成就领取详情
function this:SetRewardInfos(proto)
    if proto then
        self:UpdateDatas(proto.infos)
        if proto.is_finish then
            self.isFirst = true
            self:CheckRedPointData()
            EventMgr.Dispatch(EventType.Achievement_Data_Update)
        end
    end
end

--更新成就领取详情
function this:UpdateFinishInfo(proto)
    if proto then
        -- self:UpdateDatas(proto.infos)
        if proto.finish_list then
            self.finishes = self.finishes or {}
            for k, v in pairs(proto.finish_list) do
                self.finishes[v.sid] = v.num
            end
        end
        if proto.is_finish then
            self.datas = self.datas or {}
            for k, v in pairs(self.datas) do
                v:SetFinish(self.finishes)
            end
            self:CheckRedPointData()
            MissionMgr:ApplyShowMisionTips()
            EventMgr.Dispatch(EventType.Achievement_Data_Update)
        end
    end
end

--更新成就数据 info:sAchievementRewardDetail
function this:UpdateDatas(infos)
    if infos and #infos > 0 then
        for i, v in ipairs(infos) do
            if self.datas[v.id] then
                self.datas[v.id]:SetIsGet(v.time ~= nil)
                self.datas[v.id]:SetRewardTime(v.time)
                self.datas[v.id]:SetFinishTime(v.finish_time)
                if self.isFirst and not v.time then
                    self:UpdateChangeData(self.datas[v.id])
                end
            else
                -- LogError("存在不在配置表上的成就数据！！！id：" .. v.id)
            end
        end
    end
end

function this:GetDatas()
    return self.datas
end

function this:GetData(id)
    return self.datas[id]
end

function this:GetArr(type)
    local _datas = {}
    if self.datas then
        for k, v in pairs(self.datas) do
            if not type or v:GetType() == type then
                if v:IsShow() then
                    if v:GetPreposition() then
                        local prep = self.datas[v:GetPreposition()]
                        if prep and prep:IsGet() then
                            table.insert(_datas,v)
                        end
                    else
                        table.insert(_datas,v)
                    end
                end
            end
        end
    end
    if #_datas > 0 then
        table.sort(_datas,function (a,b)
            return a:GetID() < b:GetID()
        end)
    end
    return _datas
end

--获取特定的数据 完成或未完成
function this:GetArr2(isFinish,isLimit)
    local _datas = {}
    local closeTypes = self:GetCloseTypes()
    if self.datas then
        for k, v in pairs(self.datas) do
            if closeTypes[v:GetType()] == nil then
                if (isFinish and v:IsFinish()) or (not isFinish and not v:IsFinish()) then
                    if v:IsShow() then
                        if v:GetPreposition() then
                            local prep = self.datas[v:GetPreposition()]
                            if prep and prep:IsGet() then
                                table.insert(_datas,v)
                            end
                        else
                            table.insert(_datas,v)
                        end
                    end
                end
            end
        end
    end
    if #_datas > 0 then
        table.sort(_datas,function (a,b)
            if isFinish then
                if a:GetFinishTime() == b:GetFinishTime() then
                    return a:GetID() < b:GetID()
                else
                    return a:GetFinishTime() > b:GetFinishTime()
                end
            else
                if a:GetPercent() == b:GetPercent() then
                    return a:GetID() < b:GetID()
                else
                    return a:GetPercent() > b:GetPercent()
                end
            end
        end)
    end
    if isLimit and g_AchieveMenuListNum and g_AchieveMenuListNum > 0 then --显示限制
        local arr = {}
        if #_datas > 0 then
            for i, v in ipairs(_datas) do
                if i <= g_AchieveMenuListNum then
                    table.insert(arr,v)
                end
            end
        end
        _datas = arr
    end
    return _datas
end

--获取还未开始显示的类型
function this:GetCloseTypes()
    local types = {}
    local cfgs = Cfgs.CfgAchieveType:GetAll()
    if cfgs then
        for k, m in pairs(cfgs) do
            if m.infos and #m.infos> 0 then
                for i, v in ipairs(m.infos) do
                    if v.showTime then
                        local sTime = TimeUtil:GetTimeStampBySplit(v.showTime)
                        if sTime and TimeUtil:GetTime() < sTime then
                            types[v.typeNum] = 1
                        end
                    end
                end
            end
        end
    end
    return types
end

function this:GetArr3(type)
    local _datas = {}
    if self.datas then
        for k, v in pairs(self.datas) do
            if not type or v:GetType() == type then
                if v:IsShow() then
                    table.insert(_datas,v)
                end
            end
        end
    end
    if #_datas > 0 then
        table.sort(_datas,function (a,b)
            return a:GetID() < b:GetID()
        end)
    end
    return _datas
end

--获取总收集数量
function this:GetCount()
    local cur,max = 0,0
    local _datas = self:GetArr3()
    if #_datas> 0 then
        for i, v in ipairs(_datas) do
            if v:IsFinish() then
                cur = cur + 1
            end
        end
        max = #_datas
    end
    return cur,max
end

--展示
function this:ShowReward(infos,rewards,cb)
    if infos and #infos> 0 then
        table.sort(infos,function (a,b)
            local data1 = self.datas[a.id]
            local data2 = self.datas[b.id]
            if data1 and data2 then
                if data1:GetQuality() == data2:GetQuality() then
                    return data1:GetID() < data2:GetID()
                else
                    return data1:GetQuality() > data2:GetQuality()
                end
            else
                return a.id > b.id
            end
        end)
    end
    self:UpdateDatas(infos)
    self:CheckRedPointData()
    if self.isShow then
        UIUtil:OpenAchieveReward(infos,rewards)
        self.isShow = false
    else
        UIUtil:OpenReward({rewards})
    end
    if cb then
        cb()
    else
        EventMgr.Dispatch(EventType.Achievement_Data_Update)
    end
end

function this:SetIsShow(b)
    self.isShow = b
end

function this:CheckRedPointData()
    local isRed = self:CheckRed()
    RedPointMgr:UpdateData(RedPointType.Achievement, isRed and 1 or nil)
end

--红点检测
function this:CheckRed(type)
    local arr = self:GetArr(type)
    if arr and #arr > 0 then
        for i, v in ipairs(arr) do
            if v:IsFinish() and not v:IsGet() then
                return true
            end
        end
    end
    return false
end

--红点检测
function this:CheckRed2(id)
    local arr = self:GetListArr2(id)
    if arr and #arr> 0 then
        for i, v in ipairs(arr) do
            if self:CheckRed(v:GetID()) then
                return true
            end
        end
    end
    return false
end

function this:Clear()
    self.datas = {}
    self.listDatas= {}
    self.finishes = {}
    self.isShow = false
    self.isFirst = false
    self.changeDatas = {}
end
-------------------------------------------tips-------------------------------------------
function this:UpdateChangeData(v)
    self.changeDatas = self.changeDatas or {}
    local data = AchievementChangeInfo.New()
    data:Init(v)
    self.changeDatas[v:GetID()] = data
end

-- 弹提示数据
function this:GetChangeDatas()
    if not MenuMgr:CheckModelOpen(OpenViewType.main,"Achievement") then
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