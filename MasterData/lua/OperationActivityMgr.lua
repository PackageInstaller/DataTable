OperationActivityMgr = MgrRegister("OperationActivityMgr")
local this = OperationActivityMgr;

function this:Init()
    self:Clear()
    self:InitSkinPassDatas()
    self:InitOldSkinRebateDatas()
    OperateActiveProto:GetActiveTimeList()
    OperateActiveProto:GetSkinRebateInfo()
    ShopProto:GetSkinRebateRecord()
    OperateActiveProto:GetDragonBoatFestivalInfo() --端午签到
    OperateActiveProto:GetBreakfastCardData() --早餐卡
    OperateActiveProto:GetOldSkinRebateInfo() -- 旧皮肤返利
end

function this:Clear()
    self.skinRebateInfos = {}
    self.finishRecords = {}
    self.getRecords = {}
    self.duanWuInfos ={}
    self.duanWuSelType = nil
    self.duanWuRewardIndex = 0
    self.bfcInfo = nil
    self.skinPassDatas = {}
    self.oldSkinRebateDatas = {}
    self.oldSkinRebateInfo = nil
end

---------------------------------------------皮肤返利---------------------------------------------
function this:SetSkinRebateInfos(proto)
    if proto and proto.skinIdList and #proto.skinIdList > 0 then
        for i, v in ipairs(proto.skinIdList) do
            self.skinRebateInfos[v.skinId] = {
                id = v.skinId,
                time = v.nEndTime
            }
        end
    end
    if MenuMgr.isInit then --等待主界面初始化
        EventMgr.Dispatch(EventType.Activity_SkinRebate_Refresh)
    end
end

function this:GetSkinRebateInfo(id)
    return self.skinRebateInfos[id]
end

--获取皮肤返利主界面按钮状态
function this:GetSkinRebateState()
    local _,id = ActivityMgr:IsOpenByType(ActivityListType.SkinRebate)
    local alData = ActivityMgr:GetALData(id)
    if not alData or not alData:GetInfo() or not alData:GetInfo().skinId then
        return
    end
    local type = SkinRebateType.Normal
    local eTime = alData:GetEndTime()
    local rTime = 0
    if eTime > 0 then
        local timeTab = TimeUtil:GetTimeTab(eTime - TimeUtil:GetTime())
        if timeTab[1] < 3 then
            type = SkinRebateType.LimitTime
        else
            rTime = eTime - 259200 --减去三天
        end
    end
    local info = self.skinRebateInfos[alData:GetInfo().skinId]
    if not info or TimeUtil:GetTime() > info.time then
        type = SkinRebateType.Lock
    end
    return type,eTime,rTime
end

--记录可领取奖励
function this:SetSkinRebateFinishRecords(proto)
    if proto and proto.skinRebateRecordList then
        for i, v in ipairs(proto.skinRebateRecordList) do
            self.finishRecords[v.skinId] = self.finishRecords[v.skinId] or {}
            if v.infos and #v.infos > 0 then
                for k, m in ipairs(v.infos) do
                    self.finishRecords[v.skinId][m] = 1
                end
            end
        end
    end
    EventMgr.Dispatch(EventType.Shop_SkinRebate_Finish_Record)
    EventMgr.Dispatch(EventType.Activity_SkinRebate_Refresh)
end

function this:IsSkinRebateFinish(skinId,shopId)
    if self:IsSkinRebateGet(skinId,shopId) then
        return false  
    end
    return self.finishRecords and self.finishRecords[skinId] and self.finishRecords[skinId][shopId] ~= nil
end

--记录已完成奖励
function this:SetSkinRebateGetRecords(proto)
    if proto and proto.skinRebateRecordList then
        for i, v in ipairs(proto.skinRebateRecordList) do
            self.getRecords[v.skinId] = self.getRecords[v.skinId] or {}
            if v.infos and #v.infos > 0 then
                for k, m in ipairs(v.infos) do
                    self.getRecords[v.skinId][m] = 1
                end
            end
        end
    end
    EventMgr.Dispatch(EventType.Shop_SkinRebate_Get_Record)
end

function this:IsSkinRebateGet(skinId,shopId)
    return self.getRecords and self.getRecords[skinId] and self.getRecords[skinId][shopId] ~= nil
end
---------------------------------------------端午签到---------------------------------------------
function this:SetDuanWuInfos(proto)
    if proto then
        if proto.infos and #proto.infos > 0 then
            for i, v in ipairs(proto.infos) do
                self.duanWuInfos[v.type] = v
            end
        end
        self.duanWuSelType = proto.type
        self.duanWuRewardIndex = proto.isTake
    end
    self:CheckRedDuanWuPointData()
    EventMgr.Dispatch(EventType.Activity_DuanWu_Refresh)
end

function this:GetDuanWuInfo(type)
    return self.duanWuInfos[type]
end

function this:GetDuanWuCurSel()
    return self.duanWuSelType
end

--已领取的端午奖励，1-甜 2-咸 
function this:GetDuanWuRewardIndex()
    return self.duanWuRewardIndex
end

function this:CheckRedDuanWuPointData()
    local isOpen,id = ActivityMgr:IsOpenByType(ActivityListType.SignInDuanWu)
    if isOpen then
        local key = SignInMgr:GetDataKeyById(id)
        local signInfo = SignInMgr:GetDataByKey(key)
        local redData = (signInfo and not signInfo:CheckIsDone()) and 1 or nil
        RedPointMgr:UpdateData(RedPointType.SignInDuanWu,redData)
    end
end

---------------------------------------------早餐卡---------------------------------------------
function this:SetBCInfo(proto)
    if proto and proto.data then
        self.bfcInfo = self.bfcInfo or {}
        for i, v in ipairs(proto.data) do
            self.bfcInfo[v.id] = {
                id = v.id,
                sTime = v.startTime,
                eTime = v.endTime,
                curDay = v.nextBuyDay
            }
        end
    end
    self:CheckRedBCPointData()
    EventMgr.Dispatch(EventType.BreakfastCard_Update)
end

function this:GetBCInfo(id)
    return self.bfcInfo and self.bfcInfo[id]
end

--已开启的早餐卡活动
function this:IsBCOpen()
    local isOpen,id = false,0
    if self.bfcInfo then
        for k, v in pairs(self.bfcInfo) do
            if TimeUtil:GetTime() >= v.sTime and TimeUtil:GetTime() < v.eTime then
                isOpen,id = true,v.id
            end
        end
    end
    if isOpen and id > 0 then
        local cfg1 = Cfgs.CfgBreakfastCard:GetByID(id)
        if cfg1 and cfg1.itemid then
            local comm = ShopMgr:GetFixedCommodity(cfg1.itemid)
            if comm and comm:IsOver() and cfg1.rewardgroup then
                local cfg2 = Cfgs.CfgBreakfastReward:GetByID(cfg1.rewardgroup)
                if cfg2 and cfg2.infos then
                    local buyCount = 0
                    for i, v in ipairs(cfg2.infos) do
                        if v.goodsId then
                            comm = ShopMgr:GetFixedCommodity(v.goodsId)
                            if comm and comm:IsOver() then
                                buyCount = buyCount + 1
                            end
                        end
                    end
                    if buyCount == #cfg2.infos then --全部都购买完
                        isOpen,id = false,0
                    end
                end
            end
        end
    end
    return isOpen,id
end

--获取下次刷新时间
function this:GetBCRefreshTime()
    local isOpen, id = self:IsBCOpen()
    local time = nil
    if isOpen then
        time = self:GetBCInfo(id).eTime
    else
        if self.bfcInfo then
            for k, v in pairs(self.bfcInfo) do
                if TimeUtil:GetTime() < v.sTime and (not time or time > v.sTime) then
                    time = v.sTime
                end
            end
        end
    end
    return time
end

function this:CheckRedBCPointData()
    local isOpen,id = self:IsBCOpen()
    local isRed =false
    if isOpen then
        local cfg = Cfgs.CfgBreakfastCard:GetByID(id)
        if cfg and cfg.itemid then
            local comm = ShopMgr:GetFixedCommodity(cfg.itemid)
            if comm and comm:IsOver() then
                local cfgReward = Cfgs.CfgBreakfastReward:GetByID(cfg.rewardgroup)
                if cfgReward and cfgReward.infos and cfgReward.infos[self.bfcInfo[id].curDay] then
                    local _comm = ShopMgr:GetFixedCommodity(cfgReward.infos[self.bfcInfo[id].curDay].goodsId)
                    if _comm and not _comm:IsOver() then
                        isRed = true
                    end
                end
            end
        end
    end
    if isRed then
        local info = FileUtil.LoadByPath("operateActiveTimeInfos") or {}
        if info.time and not TimeUtil:CheckRefreshByDay(info.time) then
            isRed = false
        end
    end
    RedPointMgr:UpdateData(RedPointType.BreakfastCard,isRed and 1 or nil)
end

function this:CheckBCIsPopUp()
    return self:IsBCOpen() and MenuMgr:CheckModelOpen(OpenViewType.main, "Breakfast")
end
---------------------------------------------皮肤通行证---------------------------------------------
function this:InitSkinPassDatas()
    local cfgs = Cfgs.CfgSkinPass:GetAll()
    if cfgs then
        for k, v in pairs(cfgs) do
            local data = SkinPassData.New()
            data:Init(v)
            self.skinPassDatas[v.id] = data
        end
    end
end

function this:SetSkinPassDatas(proto)
    if proto and proto.data then
        for i, v in ipairs(proto.data) do
            if self.skinPassDatas[v.id] then
                self.skinPassDatas[v.id]:SetData(v)
            end
        end
    end
    self:CheckRedSkinPassPointData()
    EventMgr.Dispatch(EventType.SkinPass_Update)
end

function this:GetSkinPassData(id)
    return self.skinPassDatas and self.skinPassDatas[id]
end

function this:GetSkinPassArr()
    local datas = {}
    if self.skinPassDatas then
        for k, v in pairs(self.skinPassDatas) do
            if v:IsOpen() then
                table.insert(datas,v)
            end
        end
    end
    if #datas > 0 then
        table.sort(datas,function (a,b)
            if a:IsFinish() == b:IsFinish() then
                return a:GetSortIndex() > b:GetSortIndex()
            else
                return not a:IsFinish()
            end
        end)
    end
    return datas
end

function this:UpdateSkinPassReward(proto)
    if proto and proto.id and proto.gets then
        if self.skinPassDatas[proto.id] and self.skinPassDatas[proto.id].data then
            self.skinPassDatas[proto.id].data.gets = proto.gets
        end
    end
    self:CheckRedSkinPassPointData()
    EventMgr.Dispatch(EventType.SkinPass_Update)
end

function this:CheckRedSkinPassPointData()
    local isRed = false
    if self.skinPassDatas then
        for k, v in pairs(self.skinPassDatas) do
            if v:IsRed() then
                isRed = true
                break
            end
        end
    end
    RedPointMgr:UpdateData(RedPointType.SkinPass,isRed and 1 or nil)
end

function this:SaveSkinPassNew()
    local info = FileUtil.LoadByPath("SkinPass_New.txt") or {}
    info.time = TimeUtil:GetTime()
    FileUtil.SaveToFile("SkinPass_New.txt",info)
end

function this:IsSkinPassNew()
    local info = FileUtil.LoadByPath("SkinPass_New.txt") or {}
    if not info.time then
        return true
    end
    if self:GetSkinPassOpenTime() > info.time then
        return true
    end
    return false
end

--获取最近开启的皮肤活动
function this:GetSkinPassOpenTime()
    local time = 0
    if self.skinPassDatas then
        for k, v in pairs(self.skinPassDatas) do
            if v:GetStartTime() > 0 and v:IsOpen() and time < v:GetStartTime() then
                time = v:GetStartTime()
            end
        end
    end
    return time
end

--更新等级
function this:UpdateSkinPassLevel(proto)
    if proto and proto.id and self.skinPassDatas and self.skinPassDatas[proto.id] and proto.lv then
        self.skinPassDatas[proto.id].data = self.skinPassDatas[proto.id].data or {}
        self.skinPassDatas[proto.id].data.lv = proto.lv or 0
    end
    self:CheckRedSkinPassPointData()
    EventMgr.Dispatch(EventType.SkinPass_Update)
end
---------------------------------------------旧皮肤返利---------------------------------------------

function this:InitOldSkinRebateDatas()
    local cfgs = Cfgs.CfgRebater:GetAll()
    if cfgs then
        self.oldSkinRebateDatas = {}
        for k, v in pairs(cfgs) do
            local data = SkinRebate2Data.New()
            data:Init(v)
            self.oldSkinRebateDatas[v.phase] = data
        end
    end
end

function this:SetOldSkinRebateDatas(proto)
    if proto then
        if proto.info then
            self.oldSkinRebateInfo = self.oldSkinRebateInfo or {}
            self.oldSkinRebateInfo.isBuy = proto.info.isActive and proto.info.isActive == 1
            self.oldSkinRebateInfo.getRebate = proto.info.totalRebate or 0 --已领粲晶数量
        end

        if self.oldSkinRebateDatas then
            for k, v in pairs(self.oldSkinRebateDatas) do
                v:SetData()
            end
        end

        if proto.buyInfos then
            for i, v in ipairs(proto.buyInfos) do
                if self.oldSkinRebateDatas[i] then
                    self.oldSkinRebateDatas[i]:SetData(v)
                end
            end
        end
    end
    self:CheckRedOldSkinRebatePointData()
    EventMgr.Dispatch(EventType.Activity_OldSkinRebate_Refresh)
end

function this:GetOldSkinRebateInfo()
    return self.oldSkinRebateInfo
end

function this:GetOldSkinRebateArr()
    local datas = {}
    if self.oldSkinRebateDatas then
        for k, v in pairs(self.oldSkinRebateDatas) do
            table.insert(datas,v)
        end
    end
    if #datas>0 then
        table.sort(datas,function (a,b)
            return a:GetIndex() < b:GetIndex()
        end)
    end
    return datas
end

function this:CheckRedOldSkinRebatePointData()
    local isOpen,id = ActivityMgr:IsOpenByType(ActivityListType.SkinRabate2)
    local isRed = false
    if isOpen then
        if RedPointMgr:GetDayRedState(RedPointDayOnceType.SkinRebate2) then
            local alData = ActivityMgr:GetALData(id)
            local day = TimeUtil:GetActivyIntervalDay(alData:GetStartTime(),TimeUtil:GetTime())
            if day < 3 then
                isRed = true
            elseif self.oldSkinRebateInfo.getRebate > 0 and not self.oldSkinRebateInfo.isBuy then
                isRed = true
            end
        end
        if not isRed then
            if self.oldSkinRebateDatas and self.oldSkinRebateInfo.isBuy then
                local comm = nil
                for k, v in pairs(self.oldSkinRebateDatas) do
                    if v:HasCommodity() and v:GetState() == 0 then
                        isRed = true
                        break
                    end
                end
            end
        end
    end
    RedPointMgr:UpdateData(RedPointType.SkinRebate2,isRed and 1 or nil)
end

return this