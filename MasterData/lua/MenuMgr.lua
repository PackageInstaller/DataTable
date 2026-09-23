-- 记录在本地的模块开启信息，防止服务器数据过慢导致数据错误 
-- 格式：{[OpenViewType] = {id,id,id},[OpenViewType] = {id,id,id},[OpenViewType] = {id,id,id}}
-- 功能开启大类分类（按表分）
OpenViewType = {}
OpenViewType.main = 1 -- CfgOpenCondition
OpenViewType.special = 2 -- CfgOpenConditionMore
OpenViewType.section = 3 -- Section

-- 功能开启表与 OpenViewType 对应
OpenViewCfgs = {"CfgOpenCondition", "CfgOpenConditionMore", "Section"}

-- 开启条件类型
OpenConditionType = {}
OpenConditionType.lv = 1
OpenConditionType.section = 2
OpenConditionType.guide = 3

-- 功能开启特殊类型子分类
SpecialOpenViewType = {}
-- SpecialOpenViewType.RoleUp = "special1"
-- SpecialOpenViewType.RoleBreak = "special2"
-- SpecialOpenViewType.RoleEquip = "special3"
-- SpecialOpenViewType.RoleSkill = "special4"
-- SpecialOpenViewType.PVPMirror = "special5"
-- SpecialOpenViewType.PVP = "special6"
SpecialOpenViewType.AutoFight = "special7"
SpecialOpenViewType.SpecialSkill = "special8"
SpecialOpenViewType.SpeedFight = "special9"

local MenuConditionInfo = require "MenuConditionInfo"

-- 主界面(功能开放)
local this = MgrRegister("MenuMgr")

function this:Init()
    self:Clear()

    self.weekIndex = CSAPI.GetWeekIndex()
    self.datas = {} -- 未开启的数据
    self.waitDatas = {} -- 等待解锁的数据（动画）
    self.saveDatas = {} -- 记录已开启的数据
    self.noNeedOpenWaitDatas = {} -- 不需要等待可立即解锁的数据
    self.openFuncs = {}
    self.closeFuncs = {}
    self.ActiveEntryNews = {}
    EventMgr.AddListener(EventType.View_Lua_Opened, this.OnViewOpened)
    EventMgr.AddListener(EventType.View_Lua_Closed, this.OnViewClosed)

    --首次打开客户端上报设置事件
    SettingMgr:TrackEventsByFirst()
end

function this:Clear()
    self.weekIndex = nil
    -- self.datas = {}
    -- self.waitDatas = nil
    -- self.openFuncs = nil
    -- self.closeFuncs = nil
    -- self.noNeedOpenWaitDatas = nil
    -- self.saveDatas = nil
    -- self.ActiveEntryNews = nil
    self.isInit = nil
    self.isShowSpineUI = false
    EventMgr.RemoveListener(EventType.View_Lua_Opened, this.OnViewOpened)
    EventMgr.RemoveListener(EventType.View_Lua_Closed, this.OnViewClosed)
    -- self:MenuBuyClear()
end

function this.OnViewOpened(viewKey) -- 当界面开启时，执行一次方法，然后清除引用
    this.OnMenuViewOpened(viewKey);
    if this.openFuncs and this.openFuncs[viewKey] then
        for k, v in ipairs(this.openFuncs[viewKey]) do
            v();
        end
        this.openFuncs[viewKey] = nil;
    end
end

function this.OnViewClosed(viewKey) -- 当界面关闭时，执行一次方法，然后清除引用
    if this.closeFuncs and this.closeFuncs[viewKey] then
        for k, v in ipairs(this.closeFuncs[viewKey]) do
            v();
        end
        this.closeFuncs[viewKey] = nil;
    end
end

function this.OnMenuViewOpened(viewKey)
    -- if(MenuMgr.fatherNames and MenuMgr.fatherNames[viewKey] and not CSAPI.IsViewOpen("MenuOpen")) then
    -- 	if(MenuMgr:CheckOpenList(viewKey)) then
    -- 		CSAPI.OpenView("MenuOpen", MenuMgr:GetPost(viewKey), nil, nil, true)
    -- 		return
    -- 	end
    -- end
    if (not CSAPI.IsViewOpen("MenuOpen")) then
        if (MenuMgr:CheckOpenList(viewKey)) then
            CSAPI.OpenView("MenuOpen", MenuMgr:GetPost(viewKey), nil, nil, true)
            return
        end
    end
end

function this:AddOpenFunc(viewKey, func)
    if viewKey and func then
        self.openFuncs[viewKey] = self.openFuncs[viewKey] or {};
        table.insert(self.openFuncs[viewKey], func);
    end
end

function this:AddCloseFunc(viewKey, func)
    if viewKey and func then
        self.closeFuncs[viewKey] = self.closeFuncs[viewKey] or {};
        table.insert(self.closeFuncs[viewKey], func);
    end
end

-- 立绘自定义位置
function this:GetImgPosValue(key)
    return PlayerPrefs.GetString(key)
end

function this:SetImgPosValue(isLive2D, key, value)
    -- 删除上一个记录
    local imgKey = isLive2D and "live2d" or "normal"
    local _key = string.format("%s_%s_%s", PlayerClient:GetID(), imgKey, "cache")
    local str = PlayerPrefs.GetString(_key)
    if (str ~= nil and str ~= "") then
        PlayerPrefs.SetString(str, "")
    end
    PlayerPrefs.SetString(_key, key)

    return PlayerPrefs.SetString(key, value)
end

-- 清除之前的位置
function this:ClearPerImgPosCache(isLive2D)
    local imgKey = isLive2D and "live2d" or "normal"
    local _key = string.format("%s_%s_%s", PlayerClient:GetID(), imgKey, "cache")
    local str = PlayerPrefs.GetString(_key)
    if (str ~= nil and str ~= "") then
        PlayerPrefs.SetString(str, "")
    end
end

-- 选择的是模型还是立绘 key:modelid
function this:GetImgSelect(key)
    return PlayerPrefs.GetInt(key)
end
function this:SetImgSelect(key, value)
    return PlayerPrefs.SetInt(key, value)
end

-- 当前登录第一次打开主界面 
function this:GetIsPlay()
    return self.isPlayNum or 0
end
function this:SetIsPlay(n)
    self.isPlayNum = n
end

function this:GetDownloadRewardState()
    return self.isGetDownloadReward or false
end

function this:SetDownloadRewardState(n)
    self.isGetDownloadReward = n
end

------------------------------------------------------------------模块开启(记录未开启的数据)
local fileName = "opencondition13.txt"

-- 主界面动画结束后都检测一次
-- 触发条件：等级，关卡通关，天数改变
function this:InitDatas()
    if (self.isInit) then
        self:UpdateDatas()
        return
    end
    self.isInit = true -- 不能重复初始化

    local curFileName = PlayerClient:GetID() .. fileName -- txt名称   --没开启的数据
    local oldDatas = FileUtil.LoadByPath(curFileName) -- 获取数据
    local newDatas = {}
    for i, v in ipairs(OpenViewCfgs) do
        -- 封装成字典，已开启的数据
        local _oldData = {}
        if (oldDatas and oldDatas[i]) then
            for p, q in ipairs(oldDatas[i]) do
                _oldData[q] = 1
            end
        end
        local cfgs = Cfgs[v]:GetAll()
        newDatas[i] = {}
        for k, m in pairs(cfgs) do
            if (m.conditions ~= nil) then
                if (_oldData[m.id]) then
                    -- 已开启
                    table.insert(newDatas[i], m.id)
                else
                    -- 查看是否已开启
                    local isOpen = true
                    -- 如果是是章节表，需要判断是否在活动开放时间内
                    if (v == "Section" and m.openTime) then
                        isOpen = m.openTime[self.weekIndex] == 1
                    end
                    -- if(isOpen) then
                    local data = MenuConditionInfo.New()
                    data:InitData(i, m)
                    local isOK = data:GetIsOpen()
                    if (not isOpen or not isOK) then
                        table.insert(self.datas, data)
                    else
                        -- 已开启，但没记录
                        table.insert(newDatas[i], m.id)

                        -- rui数数 系统开启
                        local _datas = {}
                        _datas.system_name = (v == "Section") and m.name or m.sName
                        _datas.system_id = m.id .. ""
                        if CSAPI.IsADV() == false then
                            BuryingPointMgr:TrackEvents("open_system", _datas)
                        end
                    end
                    -- end
                end
            else
                -- 默认开启的系统自动加上
                if (v == "CfgOpenCondition") then
                    table.insert(newDatas[i], m.id)
                end
            end
        end
    end
    self:SaveDatas(curFileName, newDatas)
    --任务弹窗推送 
    MissionMgr:ApplyShowMisionTips()
end

-- 检测当前数据是否有已符合开启添加的系统
function this:UpdateDatas()
    if (self.weekIndex ~= CSAPI.GetWeekIndex()) then
        self.weekIndex = CSAPI.GetWeekIndex()
        self:InitDatas()
    end
    local deleteData = {}
    local len = self.datas and #self.datas or 0
    for i = len, 1, -1 do
        local data = self.datas[i]
        local isOK = data:CheckConditionIsOK()
        if (isOK) then
            -- 需要弹窗
            if (data:NeedOpenTips()) then
                self.waitDatas[data:GetID()] = data
            else
                self.noNeedOpenWaitDatas[data:GetID()] = data
            end
            table.remove(self.datas, i)
            -- 更新本地数据
            table.insert(deleteData, {
                type = data:GetOpenViewType(),
                id = data:GetID()
            })
            --教程开启有红点
            if(data:GetOpenViewType() == OpenViewType.main)then 
                RedPointMgr:UpdateData(RedPointType.CourseView, 1)
            end
        end
    end
    if (#deleteData > 0) then
        local curFileName = PlayerClient:GetID() .. fileName -- txt名称    
        local oldDatas = FileUtil.LoadByPath(curFileName) or {} -- 获取数据
        for i, v in ipairs(deleteData) do
            oldDatas[v.type] = oldDatas[v.type] or {}
            table.insert(oldDatas[v.type], v.id)
        end
        self:SaveDatas(curFileName, oldDatas)
    end
end

-- 记录已开启的数据
function this:SaveDatas(curFileName, datas)
    FileUtil.SaveToFile(curFileName, datas) -- 保存数据
    self.saveDatas = {}
    for i, v in ipairs(datas) do
        self.saveDatas[i] = {}
        for p, q in ipairs(v) do
            self.saveDatas[i][q] = 1
        end
    end
end

-- 等待解锁的数据(顺便清除数据)
function this:GetWaitDatas()
    local datas = {}
    for k, v in pairs(self.waitDatas) do
        table.insert(datas, v)
    end
    self.waitDatas = {}
    return datas
end

-- ==============================--
-- desc:获取等待解锁的数据(推出一条数据)
-- time:2020-10-19 09:59:22
-- @return 
-- ==============================--
function this:GetPost(fatherView)
    if (self.waitDatas) then
        for k, v in pairs(self.waitDatas) do
            if (fatherView == nil) then
                if (not v.fatherView) then
                    local data = v
                    self.waitDatas[k] = nil
                    return data
                end
            else
                if (v.fatherView and v.fatherView == fatherView) then
                    local data = v
                    self.waitDatas[k] = nil
                    return data
                end
            end
        end
    end
    return nil
end

-- 不需要弹窗的数据   OpenViewType：所在表类型   fatherView：父界面
function this:GetNoNeedOpenWaitDatas(openViewType, fatherView)
    openViewType = openViewType == nil and OpenViewType.main or openViewType
    local datas = {}
    if (self.noNeedOpenWaitDatas) then
        local arr = {}
        for k, v in pairs(self.noNeedOpenWaitDatas) do
            table.insert(arr, v)
        end
        local len = #arr
        for i = len, 1, -1 do
            local v = arr[i]
            if (openViewType == v:GetOpenViewType()) then
                if (fatherView == nil) then
                    if (not v.fatherView) then
                        table.insert(datas, v)
                    end
                else
                    if (v.fatherView and v.fatherView == fatherView) then
                        table.insert(datas, v)
                    end
                end
                table.remove(arr, i)
            end
        end
    end
    return datas
end

-- 是否有等待解锁的数据
function this:CheckOpenList(fatherView)
    if (self.waitDatas) then
        for k, v in pairs(self.waitDatas) do
            if (fatherView == nil) then
                if (not v.fatherView) then
                    return true
                end
            else
                if (v.fatherView and v.fatherView == fatherView) then
                    return true
                end
            end
        end
    end
    return false
end

-- 判断跳转id所在模块是否已开启  bool,string
function this:CheckSystemIsOpenByJumpID(jumpID)
    local cfg = Cfgs.CfgJump:GetByID(jumpID)
    if (not cfg) then
        Log("跳转id不存在：" .. jumpID)
        return false, "该系统尚未开放,敬请期待。"
    end
    -- 判断模块是否已开启
    -- 判断关卡是否开启
    local type, id = nil, nil
    local sName = cfg.sName
    if (sName == "Section") then
        type = OpenViewType.section
        id = cfg.val1
    elseif (sName == "Dungeon" or sName == "DungeonDaily") then
        type = OpenViewType.section
        id = cfg.val3
    else
        type = OpenViewType.main
        id = sName
    end
    return self:CheckModelOpen(type, id)
end

-- 系统是否已开启（快速查看）
function this:CheckSystemIsOpen(id, type)
    type = type == nil and OpenViewType.main or type
    if (self.saveDatas) then
        local data = self.saveDatas[type]
        return data and data[id] ~= nil and true or false
    end
    return true
end

-- 系统是否已开启
function this:CheckModelOpen(type, id)

    -- 公会默认未开放
    if (id == "GuildMenu") then
        return false, ""
    end
    -- -- 宿舍的开启和基地一样
    -- if (id == "Dorm") then
    --     return self:CheckModelOpen(type, "Matrix")
    -- end

    local isOpen, lockStr = true, ""
    -- 在等待列表也算解锁了
    if (self.waitDatas) then
        for k, v in pairs(self.waitDatas) do
            if (v:GetOpenViewType() == type and v:GetID() == id) then
                return isOpen, lockStr
            end
        end
    end
    if (self.datas) then
        for i, v in ipairs(self.datas) do
            if (v:GetOpenViewType() == type and v:GetID() == id) then
                isOpen = v:GetIsOpen()
                lockStr = v:GetLockStr()
                break
            end
        end
    end

    -- 演习是否在休赛期
    if (id == "ExerciseLView" and ExerciseMgr:CheckIsInit() and ExerciseMgr:IsLeisureTime()) then
        return false, LanguageMgr:GetTips(33018)
    end

    return isOpen, lockStr
end

-- 检测所有邀请tips
function this:CheckInviteTips()
    if(not GuideMgr:IsGuiding() and not self:IsSpineUI())then 
        -- pvp
        ExerciseFriendTool:CheckInvite()
        -- 组队boss
        --TeamBossMgr:CheckInvite()
    end 
end

-- --当次登录界面是否打开过
-- function this:OpenViewCache(_viewName)
-- 	self.viewCaches = self.viewCaches or {}
-- 	local isOpen = self.viewCaches[_viewName] ~= nil
-- 	self.viewCaches[_viewName] = 1
-- 	return isOpen
-- end
-- 某条件集合是否已达成 conditions是int[]
function this:CheckConditionIsOK(conditions, mainLineLanID)
    if (conditions == nil) then
        return true, ""
    else
        local b = true
        local lockStr = ""
        for i, v in ipairs(conditions) do
            local _cfg = Cfgs.CfgOpenRules:GetByID(v)
            if (_cfg.type == OpenConditionType.lv) then
                b = PlayerClient:GetLv() >= _cfg.val
                -- if (not b) then
                local str = LanguageMgr:GetTips(1001)
                lockStr = string.format(str, _cfg.val)
                -- end
            elseif (_cfg.type == OpenConditionType.section) then
                if (_cfg.openTime) then
                    local weekIndex = CSAPI.GetWeekIndex()
                    b = m.openTime[weekIndex] == 1
                    -- if (not b) then
                    lockStr = _cfg.lock_desc
                    -- end
                end
                if (b) then
                    b = DungeonMgr:CheckDungeonPass(_cfg.val)
                    -- if (not b) then
                    local sectionCfg = Cfgs.MainLine:GetByID(_cfg.val)
                    local str = LanguageMgr:GetTips(1010)
                    local hardStr = sectionCfg.type == 2 and LanguageMgr:GetByID(mainLineLanID or 15016) or ""
                    local _s = hardStr .. sectionCfg.chapterID
                    if (not mainLineLanID) then
                        _s = _s .. "" .. sectionCfg.name
                    end
                    lockStr = string.format(str, _s)
                    -- end
                end
            elseif (_cfg.type == OpenConditionType.guide) then
                b = GuideMgr:IsComplete(_cfg.val)
                -- if (not b) then
                lockStr = _cfg.guide_tips
                -- end
            end
            -- 有一个条件不符合，则为false
            if (not b) then
                return b, lockStr
            end
        end
        return b, lockStr
    end
end

-- function this:SetPlayInID(_id)
--     self.oldPlayInID = _id
-- end
-- -- 是否与上一次播放的l2d相同
-- function this:CheckIsPlayIn(_id)
--     return self.oldPlayInID ~= nil and self.oldPlayInID == _id
-- end

-- function this:IsFirst()
--     if (not self.isFirst) then
--         self.isFirst = 1
--         return true
--     end
--     return false
-- end

-- 活动入口是否为new (如果之前是)
function this:CheckIsNew(key, isOpen)
    if (not self.ActiveEntryNews) then
        return false
    end

    if (self.ActiveEntryNews[key] ~= nil) then
        if (self.ActiveEntryNews[key] == false and isOpen) then
            return true
        end
    else
        if (not isOpen) then
            self.ActiveEntryNews[key] = false
        end
    end
    return false
end
function this:SetIsNew(key, isOpen)
    self.ActiveEntryNews = self.ActiveEntryNews or {}
    self.ActiveEntryNews[key] = isOpen
end

--[[
--------------------------------------------------付费弹窗相关----------------------------------------------------

function this:MenuBuyClear()
    self.isCheckMenuBuyFirst = nil
    self.isShopFirstOpen = nil
    self.isCrate30Finish = nil
    self.isCheckNeedToShowMenuBuy = nil
    self.curMenyBuyID = nil
    self.menuBuyChangeNum = nil
    self.isCheckSpringGift = nil
end

-- 未勾选，当次运行第一次打开主界面，
-- 1 首充可领取时强制弹出
-- 未勾选，首次从商店出来、首次在30连抽后返回主界面时弹出 首充
-- 活动图已切换，并且进行了2场任意战斗，并且未勾选
function this:CheckNeedToShowMenuBuy()
    -- 付费系统是否已开启
    local isOpen = self:CheckMenuBuyIsOpen()
    if (not isOpen) then
        return false
    end
    -- 是否已勾 
    local isTick = self:CheckMenuBuyIsTick()

    -- 是否第一次打开主界面 
    if (not self.isCheckNeedToShowMenuBuy) then
        self.isCheckNeedToShowMenuBuy = true
        self:CheckSpringGift()
        self:CheckMenuBuyFirst() -- 首充可领时标记为已检测
        if (not isTick) then
            return true
        end
    end

    -- 新春活动
    if (not isTick and self:CheckSpringGift()) then
        return true
    end

    -- 首充是否可领
    if (self:CheckMenuBuyFirst()) then
        return true
    end

    -- 是否 首次从商店出来、首充在30连抽后返回主界面并且首充未完成
    if (not isTick) then
        -- 首充未达成 
        local amount = PlayerClient:GetPayAmount()
        if (amount / 100 < 6) then
            if (self.isShopFirstOpen) then
                self.isShopFirstOpen = false
                return true
            end
            if (self.isCrate30Finish) then
                self.isCrate30Finish = false
                return true
            end
        end
    end

    -- 活动图已切换，并且进行了2场任意战斗，并且未勾选
    if (not isTick) then
        if (self.menuBuyChangeNum and self.menuBuyChangeNum <= 0) then
            self.menuBuyChangeNum = nil
            return true
        end
    end

    return false
end

-- 弹窗每天勾选的记录
function this:GetMenuBuySaveStr(id)
    return PlayerClient:GetUid() .. "MenuBuy_" .. id
end

-- 付费弹窗是否已开启
function this:CheckMenuBuyIsOpen()
    return MenuMgr:CheckModelOpen(OpenViewType.special, "special16")
end

-- 首充是否可领(只弹出一次)
function this:CheckMenuBuyFirst()
    if (not self.isCheckMenuBuyFirst) then
        local cfgs = Cfgs.CfgPayNoticeWindow:GetAll()
        for k, v in pairs(cfgs) do
            if (v.nType == MenuBuyState.First) then
                local amount = PlayerClient:GetPayAmount()
                if (amount / 100 >= 6) then
                    self.isCheckMenuBuyFirst = true
                    local comm = ShopMgr:GetFixedCommodity(v.shopItem)
                    if (comm and not comm:IsOver()) then
                        return true
                    end
                end
                break
            end
        end
    end
    return false
end

-- 新春礼包可领取（只弹出一次）
function this:CheckSpringGift()
    if (not self.isCheckSpringGift) then
        local cfgs = Cfgs.CfgPayNoticeWindow:GetAll()
        for k, v in pairs(cfgs) do
            if (v.nType == 5) then
                self.isCheckSpringGift = true
                local comm = ShopMgr:GetFixedCommodity(v.shopItem)
                if (comm and comm:IsOver()) then
                    return false -- 已领取 
                end
                local curTime = TimeUtil:GetTime()
                local startTime = TimeUtil:GetTimeStampBySplit(v.startTime)
                local endTime = TimeUtil:GetTimeStampBySplit(v.endTime)
                if (curTime >= startTime and curTime < endTime) then
                    return true
                end
                break
            end
        end
    end
    return false
end

-- 当前付费弹窗是否已勾  ===当前的
function this:CheckMenuBuyIsTick()
    local arr = self:GetMenyBuyList()
    local cfg = arr[1]
    local day = TimeUtil:GetTime3("day")
    local dayRecord = cfg and PlayerPrefs.GetString(self:GetMenuBuySaveStr(cfg.id), "0") or "0"
    if (dayRecord ~= "0" and dayRecord == tostring(day)) then
        return true
    end
    return false
end

-- 商店第一次打开 
function this:ShopFirstOpen()
    if (self.isShopFirstOpen == nil) then
        self.isShopFirstOpen = true
    end
end

-- 30连抽首次完成
function this:Crate30Finish()
    if (self.isCrate30Finish == nil) then
        self.isCrate30Finish = true
    end
end

-- 当前付费弹窗活动id更新
function this:SetMenuBuyID(id)
    if (not self.curMenyBuyID or self.curMenyBuyID ~= id) then
        self.menuBuyChangeNum = 2
    end
    self.curMenyBuyID = id
end

-- 任意关卡结束、次数减1，为0时在主界面会弹出活动
function this:ReduceMenuBuyChangeNum()
    if (self.menuBuyChangeNum) then
        self.menuBuyChangeNum = self.menuBuyChangeNum - 1
        self.menuBuyChangeNum = self.menuBuyChangeNum < 0 and 0 or self.menuBuyChangeNum
    end
end

-- 该付费类型是否需要弹出 CfgPayNoticeWindow
function this:CheckMenuBuy(cfg)
    if (cfg.nType == MenuBuyState.First) then
        -- 未充值满足或者未领取都要弹出
        local amount = PlayerClient:GetPayAmount()
        if (amount / 100 < 6) then
            return true
        end
        local comm = ShopMgr:GetFixedCommodity(cfg.shopItem)
        if (comm and comm:IsOver()) then
            return false
        end
        return true
    elseif (cfg.nType == MenuBuyState.CrateLittle or cfg.nType == MenuBuyState.CrateMove) then
        local comm = ShopMgr:GetFixedCommodity(cfg.shopItem)
        if (comm and comm:IsOver()) then
            return false
        end
        return true
    elseif (cfg.nType == MenuBuyState.Commodity) then
        local num = ShopMgr:GetMonthCardDays()
        if (num <= 7) then
            return true
        end
        return false
    elseif (cfg.nType == 5) then
        local comm = ShopMgr:GetFixedCommodity(cfg.shopItem)
        if (comm and comm:IsOver()) then
            return false -- 已领取 
        end
        local curTime = TimeUtil:GetTime()
        local startTime = TimeUtil:GetTimeStampBySplit(cfg.startTime)
        local endTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
        if (curTime >= startTime and curTime < endTime) then
            return true
        end
    end
    return false
end

-- 当前未完成的弹窗
function this:GetMenyBuyList()
    local arr = {}
    local cfgs = Cfgs.CfgPayNoticeWindow:GetAll()
    local _cfgs = table.copy(cfgs)
    table.sort(_cfgs, function(a, b)
        return a.index < b.index
    end)
    for k, v in ipairs(_cfgs) do
        local b = MenuMgr:CheckMenuBuy(v)
        if (b) then
            table.insert(arr, v)
            break
        end
    end
    return arr
end

-- 新春活动是否需要计算刷新，刷新时间
function this:CheckSpringTime()
    local cfgs = Cfgs.CfgPayNoticeWindow:GetAll()
    for k, v in pairs(cfgs) do
        if (v.nType == 5) then
            local comm = ShopMgr:GetFixedCommodity(v.shopItem)
            if (comm and comm:IsOver()) then
                return false -- 已领取 
            end
            local curTime = TimeUtil:GetTime()
            local startTime = TimeUtil:GetTimeStampBySplit(v.startTime)
            local endTime = TimeUtil:GetTimeStampBySplit(v.endTime)
            if (curTime < startTime) then
                return true, startTime, true
            end
            if (curTime < endTime) then
                return true, endTime
            end
            break
        end
    end
    return false
end

--------------------------------------------------付费弹窗相关----------------------------------------------------

]]
-- 是否有l2d
function this:CheckHadL2dIn(isRole, id, isl2d)
    if (id == nil or not isl2d) then
        return false
    end
    local cfg = isRole and Cfgs.CfgSpineAction:GetByID(id) or Cfgs.CfgSpineMultiImageAction:GetByID(id)
    if (cfg and cfg.item) then
        for k, v in ipairs(cfg.item) do
            if (v.sName == "in") then
                return true
            end
        end
    end
    return false
end

-- 有一次战斗结束
function this:SetFightOver(b)
    self.isFightOver = b
end
function this:CheckIsFightVier()
    if (self.isFightOver) then
        return true
    end
    return false
end

function this:GetTopIndex()
    self.topIndex = self.topIndex or 1
    self.topIndex = self.topIndex + 1
    return self.topIndex
end

function this:GetNextStandbyTimer()
    local num = SettingMgr:GetValue(s_wait_scale.waitTime) or 0
    local min = g_HoldOnTime[num + 1]
    if (min == -1) then
        return nil
    end
    return (Time.time + min * 60)
end

function this:GetMenuRDType()
    return self.menuRDType or 1 -- 1：展开 2：收缩
end
function this:SetMenuRDType(type)
    self.menuRDType = type
end

--是否已初始化
function this:CheckIsInit()
    return self.isInit
end

function this:SpineUI(b)
    self.isShowSpineUI = b
end
function this:IsSpineUI()
    return self.isShowSpineUI
end

----------------------------------------看板状态保存----------------------------------------------
--创建主界面记录
function this:AddMenu(b)
    if(self:GetKBCache()==0)then 
        return --不启用
    end 
    self.isAddMenuAgain = b 
end
function this:IsAddMenu()
    return self.isAddMenuAgain
end

function this:GetKBCache()
    if(not self.kbCache)then 
        local key = PlayerClient:GetUid().."_kbcache"
        self.kbCache = PlayerPrefs.GetInt(key) or 0
    end 
    return self.kbCache
end
function this:SetKBCache(num)
    self.kbCache = self:GetKBCache()
    if(self.kbCache == num )then 
        return
    end 
    self.kbCache = num 
    local key = PlayerClient:GetUid().."_kbcache"
    PlayerPrefs.SetInt(key,self.kbCache)
    if(self.kbCache==0)then 
       self.isAddMenuAgain = false 
       --移除记录
       RoleTool.SaveSpineState(nil)
    end
    EventMgr.Dispatch(EventType.Player_KBCache_Change)
end
--------------------------------------------------------------------------------------
return this
