-- 活动管理
local ActivityInfo = require "ActivityInfo"
local ActivityData = require "ActivityData"
local this = MgrRegister("ActivityMgr")

function this:GetBaseUrl()
    return self.url .. "/php"
end

-- 基础下载地址
function this:GetBaseDownAddress()
    local curServer = GetCurrentServer()
    return self.url .. "/php/res/" .. curServer.resDir .. "/"
    -- return "https://cdn.megagamelog.com/cross/release/web/";--改CDN
end

-- 活动、广告文件下载地址
function this:GetActivityDownAddress(type)
    -- local curServer = GetCurrentServer()
    local currPlatform = CSAPI.GetPlatform()
    local str1 = "pc"
    if (currPlatform == 8) then
        str1 = "ios"
    elseif (currPlatform == 11) then
        str1 = "android"
    elseif(currPlatform == 51) then 
        str1 = "harmony"
    end
    local str2 = "text"
    if (CSAPI.GetChannelType() == ChannelType.BliBli) then
        str2 = "bilibili"
    elseif (CSAPI.GetChannelType() == ChannelType.Normal or CSAPI.GetChannelType() == ChannelType.TapTap) then
        str2 = "official"
    elseif (CSAPI.GetChannelType() == ChannelType.QOO) then
        str2 = "qoo"
    elseif (CSAPI.GetChannelType() == ChannelType.ZiLong or CSAPI.GetChannelType() == ChannelType.ZiLongKR or
        CSAPI.GetChannelType() == ChannelType.ZiLongJP) then
        str2 = "zilong"
    end
    local fileName = ""
    if (type == BackstageFlushType.Board) then
        fileName = string.format("boardNotice/%s/%s/boardNotice", str1, str2)
    else
        fileName = "activitySkip" -- string.format("activitySkip/%s/%s/activitySkip", str1, str2)
    end
    return self:GetBaseDownAddress() .. fileName
end

-- 宿舍图片下载地址
function this:GetDormDownAddress()
    return self:GetBaseDownAddress() .. "dorm/"
end

-- 宿舍图片上传地址
function this:GetDormUploadAddress()
    -- local curServer = GetCurrentServer()
    return self.url .. "/php/OpFile.php"
end

function this:Clear()
    -- self.isOpen = false
    self.datas = {}
    self.listDatas = {}
    self.listView = nil
    self.nextViewIds = {}
    self.savePanel = {}
    self.isFirst = nil
    -- self.redInfos = nil
    self.operateActive = {}
    self.ALDatas = nil
    self.isCloseWindow = false
    self.windowInfos = {}
end

function this:Init1(webIp, webPort, time)
    self:Clear()
    self.url = string.format("%s", webIp)
    self.isIn = 0
    self.datas = {}
    -- for i, v in pairs(BackstageFlushType) do
    --     self:InitData(v)
    -- end
    self:InitData(BackstageFlushType.Board, time)
    self:InitData(BackstageFlushType.ActiveSkip, time)
    self:InitActivityListData()
end

function this:InitData(type, time)
    if (type ~= nil) then
        local _url = self:GetActivityDownAddress(type)
        local url = _url .. ".json"
        self:RequestData(type, url, time)
    end
end

-- 请求数据
function this:RequestData(key, url, time)
    self.datas[key] = {}
    CSAPI.GetServerInfo(url, function(str)
        if str then
            local count = 0
            local json = Json.decode(str)
            if (json) then
                if (key == BackstageFlushType.Board) then
                    for i, v in ipairs(json.arr) do
                        if (type(v) == "table") then
                            if (tonumber(v["id"]) ~= 0) then
                                local activityInfo = ActivityInfo.New()
                                activityInfo:InitData(v, key)
                                if (activityInfo:CheckIsInTime(time)) then
                                    table.insert(self.datas[key], activityInfo)
                                    count = count + 1
                                end
                            end
                        end
                    end
                else
                    for i, v in pairs(json) do
                        if (type(v) == "table") then
                            if (tonumber(json[i]["id"]) ~= 0) then
                                local activityInfo = ActivityInfo.New()
                                activityInfo:InitData(json[i], key)
                                if (activityInfo:CheckIsInTime(time)) then
                                    -- 玩家已完成则会隐藏
                                    -- if(json[i]["panel_id"] and self:CheckIsOpen(tonumber(json[i]["panel_id"]))) then 
                                    table.insert(self.datas[key], activityInfo)
                                    -- end 
                                end
                            end
                        end
                    end
                    self:CheckOpenDatas()
                end
                if (key == BackstageFlushType.Board) then
                    if (self.isIn == 0) then
                        -- 第1次获取到数据
                        -- self.isIn = 1
                        self.isIn = count > 0 and 2 or 1 -- 2 需要弹出面板
                    else
                        -- 第x+1次获取到数据
                        -- if(self.isIn == 1) then
                        self.isIn = count > 0 and 3 or 1 -- 3 需要强制弹出面板
                        -- end
                    end
                end
                EventMgr.Dispatch(EventType.Main_Activity, key)
            end
        end
    end)
end

-- 获取活动数据(活动时间内有效的数据)
function this:GetDatasByType(type, time, page)
    type = type == nil and BackstageFlushType.Board or type
    local datas = self.datas and self.datas[type] or nil
    if (datas) then
        local curDatas = {}
        local nextTime = nil
        local curTime = time or TimeUtil:GetTime()
        for i, v in ipairs(datas) do
            local beginTime = v:GetBeginTime()
            local endTime = v:GetEndTime()
            if (beginTime == nil or curTime > beginTime) then
                if (endTime == nil or endTime > curTime) then
                    if (endTime and (nextTime == nil or nextTime > endTime)) then
                        nextTime = endTime
                    end
                    if (page == nil or (page == v:GetPage())) then
                        table.insert(curDatas, v)
                    end
                end
            end
        end
        if (curDatas and #curDatas > 1) then
            table.sort(curDatas, function(a, b)
                return tonumber(a:GetSortID()) > tonumber(b:GetSortID())
            end)
        end
        return curDatas, nextTime
    else
        return nil, nil
    end
end

-- 是否有公告
function this:IsHaveBoard()
    local datas = self.datas and self.datas[BackstageFlushType.Board] or nil
    if (datas) then
        local curTime = time or TimeUtil:GetTime()
        for k, v in pairs(datas) do
            local beginTime = v:GetBeginTime()
            local endTime = v:GetEndTime()
            if (beginTime == nil or curTime > beginTime) then
                if (endTime == nil or endTime > curTime) then
                   return true
                end
            end
        end
    end
    return false
end

-- 弹出活动公告
function this:ToShowAD()
    if (self:CheckIsNeedShow()) then
        self.isIn = 1
        -- 是否无公告，无则不需要弹 
        if (not self:IsHaveBoard()) then
            return false
        end
        return true
    end
    return false
end

-- 需要弹出活动公告
function this:CheckIsNeedShow()
    if (self.isIn == 3 or (not self:IsSetToSkip() and self.isIn == 2)) then
        return true
    end
    return false
end

-- 当天是否已设置跳过
function this:IsSetToSkip()
    if(not PlayerClient:GetUid())then 
        return false
    end 
    local day = TimeUtil:GetTime3("day")
    local dayRecord = PlayerPrefs.GetString(PlayerClient:GetUid() .. "ActivityTips_Day", "0")
    if (dayRecord ~= "0" and dayRecord == tostring(day)) then
        return true
    end
    return false
end

----------------------------------------活动列表---------------------------------------

function this:InitActivityListData()
    self.ALDatas = {}
    local cfgs = Cfgs.CfgActiveList:GetAll()
    if cfgs then
        for i, v in pairs(cfgs) do
            local data = ActivityData.New()
            data:Init(v)
            if data:GetGroup() ~= nil then
                self.ALDatas[v.id] = data
            end
        end
    end
end

function this:UpdateDatas(proto)
    if proto then
        if proto.operateActiveList and #proto.operateActiveList > 0 then
            for i, v in ipairs(proto.operateActiveList) do
                if self.ALDatas[v.id] then
                    self.ALDatas[v.id]:SetTime(v.openTime, v.closeTime)
                end
            end
        end
        if proto.isFinish then
            self:RefreshOpenState()
            EventMgr.Dispatch(EventType.Activity_List_Cfg_Change)
        end
    end
end

function this:RefreshOpenState()
    self.isFirst = false
    self:InitListOpenState()
end

function this:InitListOpenState()
    if self.isFirst then -- 只执行一次
        return
    end
    self.isFirst = true

    self:CheckOpenDatas()
    self:CheakPopInfos()
end

function this:CheckOpenDatas()
    if (self.isFirst and self.datas) then
        local datas = self.datas[BackstageFlushType.ActiveSkip]
        if (datas) then
            local len = #datas
            for i = len, 1, -1 do
                if (datas[i]:PanelId() and not self:CheckIsOpen(tonumber(datas[i]:PanelId()))) then
                    table.remove(datas, i)
                end
            end
        end
    end
    EventMgr.Dispatch(EventType.Main_Activity, BackstageFlushType.ActiveSkip)
end

function this:CheakPopInfos()
    self.popInfos = {}
end

-- 获取某一组活动的最前开始时间和最后结束时间
function this:GetActivityTime(group)
    local sTime, eTime = nil, nil
    if self.ALDatas then
        for k, v in pairs(self.ALDatas) do
            if group and v:GetGroup() == group and v:IsOpen() then
                if v:GetStartTime() and v:GetEndTime() then
                    local _sTime = v:GetStartTime()
                    local _eTime = v:GetEndTime()
                    if sTime == nil then
                        sTime = _sTime
                    else
                        sTime = sTime > _sTime and _sTime or sTime
                    end
                    if eTime == nil then
                        eTime = _eTime
                    else
                        eTime = eTime < _eTime and _eTime or eTime
                    end
                elseif v:GetType() == ActivityListType.Investment then
                    sTime = PlayerMgr:GetOpenTime(ActivityListType.Investment)
                    eTime = PlayerMgr:GetOpenTime(ActivityListType.Investment) + (g_InvestmentTimes * 86400)
                elseif v:GetType() == ActivityListType.NewPlayerSeven then
                    sTime = PlayerMgr:GetOpenTime(ActivityListType.NewPlayerSeven)
                    eTime = PlayerMgr:GetOpenTime(ActivityListType.NewPlayerSeven) + (g_NewPlayerSevenDayTaskTimes * 86400)
                elseif v:GetType() == ActivityListType.AccuCharge2 then
                    sTime,eTime = AccuChargeMgr:GetOpenTime2()
                end
            end
        end
    end
    return sTime, eTime
end

function this:MenuLTimeX(type)
    if(type==2 or type==3)then
        return self:GetActivityTime(type)
    else
        local begTime,endTime
        local _, id = self:IsOpenByType(type)
        local alData = self:GetALData(id)
        if alData then
            begTime = alData:GetStartTime()
            endTime = alData:GetEndTime()
        end
        return begTime,endTime
    end  
end

-- 获取整个活动表的最小刷新时间
function this:GetRefreshTime(type)
    local timer = nil
    if self.ALDatas then
        local curTime = TimeUtil:GetTime()
        for k, v in pairs(self.ALDatas) do
            if not type or v:GetType() == type then
                if v:GetStartTime() and v:GetStartTime() > curTime then
                    if (timer == nil or timer > v:GetStartTime()) then
                        timer = v:GetStartTime()
                    end
                end
                if v:GetEndTime() and v:GetEndTime() > curTime then
                    if (timer == nil or timer > v:GetEndTime()) then
                        timer = v:GetEndTime()
                    end
                end
            end
        end
    end
    return timer
end

function this:GetALData(id)
    return self.ALDatas and self.ALDatas[id]
end

function this:GetArr(group)
    local datas = {}
    if self.ALDatas then
        for i, v in pairs(self.ALDatas) do
            if v:IsOpen() then
                if not group or group == v:GetGroup() then
                    table.insert(datas, v)
                end
            end
        end

        if #datas > 0 then
            table.sort(datas, function(a, b)
                return a:GetIndex() < b:GetIndex()
            end)
        end
    end
    return datas
end

-- 活动开启
function this:CheckIsOpen(id)
    if self.ALDatas and self.ALDatas[id] then
        return self.ALDatas[id]:IsOpen()
    end
    return false
end

function this:CheckIsPop(id)
    if self.ALDatas and self.ALDatas[id] then
        return self.ALDatas[id]:GetPopIndex() ~= nil
    end
    return false
end

-- 检测红点
function this:CheckRedPointData(type)
    if type then
        if self.ALDatas then
            local redData1, redData2 = nil, nil
            local group = 1
            for i, v in pairs(self.ALDatas) do
                if v:GetType() == type then
                    if redData1 == nil then
                        redData1 = RedPointMgr:GetData(RedPointType["ActivityList" .. v:GetGroup()])
                        group = v:GetGroup()
                    end
                    if self:CheckRed(v:GetID()) then
                        redData2 = 1
                        break
                    end
                end
            end
            if redData1 ~= redData2 then
                if redData2 == nil then -- 如果无红点，检测一遍全组是否都无红点
                    redData2 = self:CheckRedByGroup(group) and 1 or nil
                end
                redData1 = redData2
                RedPointMgr:UpdateData(RedPointType["ActivityList" .. group], redData1)
            end
        end
        return
    end
    local redData1 = RedPointMgr:GetData(RedPointType.ActivityList1)
    local redData2 = RedPointMgr:GetData(RedPointType.ActivityList2)
    local redData3 = RedPointMgr:GetData(RedPointType.ActivityList3)
    local redData4 = nil
    local redData5 = nil
    local redData6 = nil
    if self.ALDatas then
        for k, v in pairs(self.ALDatas) do
            if self:CheckRed(v:GetID()) then
                if v:GetGroup() == 2 and redData5 == nil then
                    redData5 = 1
                elseif v:GetGroup() == 3 and redData6 == nil then
                    redData6 = 1
                elseif v:GetGroup() == 1 and redData4 == nil then
                    redData4 = 1
                end
            end
        end
    end
    if redData1 ~= redData4 then
        RedPointMgr:UpdateData(RedPointType.ActivityList1, redData4)
    end
    if redData2 ~= redData5 then
        RedPointMgr:UpdateData(RedPointType.ActivityList2, redData5)
    end
    if redData3 ~= redData6 then
        RedPointMgr:UpdateData(RedPointType.ActivityList3, redData6)
    end
end

function this:CheckRedByGroup(group)
    if self.ALDatas and group then
        for k, v in pairs(self.ALDatas) do
            if v:GetGroup() == group and self:CheckRed(v:GetID()) then
                return true
            end
        end
    end
    return false
end

function this:CheckRed(id)
    local data = self:GetALData(id)
    if data then
        if not data:IsOpen() then
            return false
        end
        if data:GetType() == ActivityListType.MissionContinue then
            return MissionMgr:CheckGuideRed()
        elseif data:GetType() == ActivityListType.NewYearContinue then
            return MissionMgr:CheckNewYearRed()
        elseif self:IsSignIn(id) then
            local signData = SignInMgr:GetDataByALType(id)
            if signData and not signData:CheckIsDone() then
                return true
            end
            return false
        elseif data:GetType() == ActivityListType.Investment then
            local pageData = ShopMgr:GetPageByID(1001)
            if pageData == nil then
                LogError("找不到对应商店页的商品数据！1001")
                return false
            end

            local comms = pageData:GetCommodityInfos(true)
            if comms and #comms < 1 then
                return false
            end

            local commodity = comms[1]
            if commodity:GetPrice() and #commodity:GetPrice() > 0 then
                if commodity:GetBuyLimitType() == ShopBuyLimitType.FirstRecharge then
                    local amount = PlayerClient:GetPayAmount() / 100
                    local maxAmount = commodity:GetBuyLimitVal()
                    if amount < maxAmount then
                        return false
                    end
                end
                local costCount = commodity:GetPrice()[1].num
                return BagMgr:GetCount(ITEM_ID.DIAMOND) >= costCount
            end
            return false
        elseif data:GetType() == ActivityListType.Exchange then
            local info = data:GetInfo()
            if info and info[1] and info[1].shopId then
                local page = ShopMgr:GetPageByID(info[1].shopId)
                if page then
                    local datas = page:GetCommodityInfos(true)
                    if datas and #datas > 0 then
                        local infos = FileUtil.LoadByPath("Activity_ExChange_Tip") or {}
                        for i, v in ipairs(datas) do
                            if (not infos[v:GetID()] or infos[v:GetID()] == 1) and v:GetNum() ~= 0 and
                                ShopCommFunc.CheckCanPay(v, 1) then
                                return true
                            end
                        end
                    end
                end
            end
            return false
        elseif data:GetType() == ActivityListType.AccuCharge then
            local num = RedPointMgr:GetData(RedPointType.AccuCharge)
            if (num and num == 1) then
                return true
            end
            return false
        elseif data:GetType() == ActivityListType.GachaBall then
            local info = data:GetInfo()
            if info and info[1] then
                local cfgId = info[1].cfgId;
                local info = ItemPoolActivityMgr:CheckPoolHasRedPoint(cfgId);
                local pool = ItemPoolActivityMgr:GetPoolInfo(cfgId);
                local info2 = RedPointMgr:GetDayRedState(RedPointDayOnceType.GachaBall)
                if pool and pool:IsOver() ~= true and (info or info2) then
                    return true;
                end
            end
            return false;
        elseif data:GetType() == ActivityListType.AccuCharge2 then
            local num = RedPointMgr:GetData(RedPointType.AccuCharge2)
            if (num and num == 1) then
                return true
            end
            return false
        elseif data:GetType() == ActivityListType.AccuCharge3 then
            local num = RedPointMgr:GetData(RedPointType.AccuCharge3)
            if (num and num == 1) then
                return true
            end
            return false
        elseif data:GetType() == ActivityListType.Collaboration then
            local num = RedPointMgr:GetData(RedPointType.Collaboration);
            if (num ~= nil) then
                return true
            end
            return false
        elseif data:GetType() == ActivityListType.SkinRebate then
            if data:GetInfo() and data:GetInfo().skinId then
                local skinRebateInfo = OperationActivityMgr:GetSkinRebateInfo(data:GetInfo().skinId)
                if not skinRebateInfo or TimeUtil:GetTime() > skinRebateInfo.time then
                    return false
                end
                local comms = ShopMgr:GetCommodityBySkinID(data:GetInfo().skinId)
                local isGet, isFinish = false, false
                if #comms > 0 then
                    for i, v in ipairs(comms) do
                        isGet = OperationActivityMgr:IsSkinRebateGet(data:GetInfo().skinId, v:GetID())
                        isFinish = OperationActivityMgr:IsSkinRebateFinish(data:GetInfo().skinId, v:GetID())
                        if isFinish and not isGet then
                            return true
                        end
                    end
                end
            end
            return false
        elseif data:GetType() == ActivityListType.AdvBindUsers then
            return AdvBindingRewards.isHadReward
        elseif data:GetType() == ActivityListType.NewPlayerSeven then
            return MissionMgr:CheckRed({eTaskType.NewPlayerSeven})
        else
            local isRed = PlayerPrefs.GetInt(PlayerClient:GetUid() .. "_Activity_Red_" .. id) == 0
            return isRed
        end
    end
    return false
end

function this:IsSignIn(id)
    local data = self:GetALData(id)
    if data then
        if data:GetSpecType() == ALType.SignIn then
            return true
        elseif data:GetType() == ActivityListType.SignInGift then
            return true
        end
    end
    return false
end

----------------------------------------界面弹出---------------------------------------
-- 检测所有活动弹窗
function this:CheckWindowShow()
    for k, v in pairs(eAEShowType) do
        local id = eAEShowIdType[v]
        if DungeonMgr:IsActiveOpen(id) and self:CheckWindowNeedShow("AcitivtyEntryWindow_" .. v) then
            if v == eAEShowType.Anniversary then
                CSAPI.OpenView("AnniversaryWindow")
            end
            return true
        end
    end
    return false
end

-- 检测弹窗是否需要弹出
function this:CheckWindowNeedShow(key)
    if not key or key == "" then
        return false
    end
    self.windowInfos = self.windowInfos or {}
    if self.windowInfos[key] and self.windowInfos[key] == 1 then -- 已经弹过一次
        return false
    end
    self.windowInfos[key] = 1
    local infos = FileUtil.LoadByPath("Menu_Window_Show") or {}
    if infos[key] == nil or infos[key].time == nil then -- 默认弹出
        self:SaveWindowInfos(key, false)
        return true
    end
    local offsetTab = TimeUtil:GetTimeTab(TimeUtil:GetTime() - infos[key].time)
    if offsetTab[1] > 0 then -- 超过一天
        self:SaveWindowInfos(key, false)
        return true
    else
        local timeTab1 = TimeUtil:GetTimeHMS(infos[key].time)
        local timeTab2 = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
        if timeTab1.day == timeTab2.day then -- 同一天
            if timeTab1.hour < g_ActivityDiffDayTime and timeTab2.hour >= g_ActivityDiffDayTime then -- 刷新前后
                self:SaveWindowInfos(key, false)
                return true
            end
        elseif timeTab2.day > timeTab1.day then -- 前后一天
            if timeTab1.hour < g_ActivityDiffDayTime then -- 刷新前
                self:SaveWindowInfos(key, false)
                return true
            elseif timeTab2.hour >= g_ActivityDiffDayTime then -- 刷新后
                self:SaveWindowInfos(key, false)
                return true
            end
        end
    end
    if infos[key].isClose then
        return false
    end
    return true
end

-- 保存弹窗状态
function this:SaveWindowInfos(key, isClose)
    if not key or key == "" then
        return
    end
    local infos = FileUtil.LoadByPath("Menu_Window_Show") or {}
    infos[key] = infos[key] or {}
    infos[key].isClose = isClose
    infos[key].time = TimeUtil:GetTime()
    FileUtil.SaveToFile("Menu_Window_Show", infos)
end

-- 获取弹窗状态
function this:GetWindowInfo(key)
    if not key or key == "" then
        return {}
    end
    local infos = FileUtil.LoadByPath("Menu_Window_Show") or {}
    return infos[key] or {}
end
----------------------------------------运营相关---------------------------------------
function this:SetOperateActive(id, info)
    local data = self:GetALData(tonumber(id))
    if data and data:GetType() == ActivityListType.SignInGift and info.payRate then
        self.operateActive[tonumber(id)] = self.operateActive[tonumber(id)] or {}
        self.operateActive[tonumber(id)].sTime = info.openTime or 0
        self.operateActive[tonumber(id)].eTime = info.closeTime or 0
    end
end

function this:GetOperateActive(id)
    local info = self.operateActive[tonumber(id)]
    if info and info.sTime <= TimeUtil:GetTime() and info.eTime > TimeUtil:GetTime() then
        return info
    end
    return nil
end

-- 根据类型来获取开启状态和id
function this:IsOpenByType(type)
    local isOpen = false
    local id = nil
    if self.ALDatas then
        local sTime = nil
        for k, v in pairs(self.ALDatas) do
            if v:GetType() == type then
                if v:IsOpen() then --已开启
                    id = v:GetID()
                    isOpen = v:IsOpen()
                    sTime = v:GetStartTime()
                    break
                end
                if v:GetStartTime() > TimeUtil:GetTime() and (not sTime or v:GetStartTime() < sTime) then -- 获取最先开启的id
                    id = v:GetID()
                    sTime = v:GetStartTime()
                end
            end
        end
    end
    return isOpen, id
end

return this
