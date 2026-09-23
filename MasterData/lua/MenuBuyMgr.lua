-- ID对应=>1首充礼包;2新手构建包;3星贸凭证;4首轮特价构建包;5新春奖励;6充值签到
-- 所有条件检测后都可以不用推送，在商店界面关闭回到主界面就会自动触发，时间的在时间倒计时完自动检测一次
local MenuBuyBase = require "MenuBuyBase"
local this = MgrRegister("MenuBuyMgr")

function this:Init()
    self:Clear()
    -- 初始化表数据
    local cfgs = Cfgs.CfgPayNoticeWindow:GetAll()
    for i, v in ipairs(cfgs) do
        local _data = MenuBuyBase.New()
        _data:InitData(v)
        self.datas[v.id] = _data
        table.insert(self.arr, _data)
    end
    if (#self.arr > 1) then
        table.sort(self.arr, function(a, b)
            return a:GetCfg().index < b:GetCfg().index
        end)
    end
end

function this:Clear()
    self.datas = {}
    self.arr = {}
end

-- 付费弹窗是否已开启
function this:CheckMenuBuyIsOpen()
    return MenuMgr:CheckModelOpen(OpenViewType.special, "special16")
end
-- id:5、9是新年
-- 设置等待弹出的数据
-- 弹出销毁条件
-- 1、全部    【登录+未勾】
-- 2、ID:178   【不可领取变可领取（强制)；不可领取时首次从商店出来；不可领取时30连后返回主界面】
-- 3、ID:234 【在线期间进入，后进行了2场任意战斗】
-- 4：ID:5  【到点弹出和销毁（强制）】
-- 5、ID:6  【到点弹出和销毁（强制）；不可领取变可领取（强制)】
-- (结束时间检测都用ConditionCheck2，充值检测用ConditionCheck3)
function this:ConditionCheck(type, elseData)
    if (type == 1) then
        if (not self.loginCheck) then
            self.loginCheck = 1
            local curData = self:GetCurData()
            if (curData) then
                curData:LoginCheck()
            end
        end
    elseif (type == 2) then
        local curID = self:GetCurID()
        if (curID ~= nil and (curID == 1 or curID == 7 or curID == 8)) then
            local curData = self:GetCurData()
            if (not curData:GetPush()) then
                if (elseData == "shopOpen" and not curData:GetShopOpen() and not curData:IsTick()) then -- 从商店出来
                    curData:SetShopOpen()
                    curData:SetPush()
                elseif (elseData == "create30Finish" and not curData:IsTick()) then -- 30连返回
                    curData:SetPush()
                end
            end
        end
    elseif (type == 3) then
        local curID = self:GetCurID()
        if (curID ~= nil and (curID == 2 or curID == 3 or curID == 4)) then
            local curData = self:GetCurData()
            if (curData:GetOnlineIn() and not curData:GetPush() and not curData:IsTick()) then
                curData:SetFightNum()
            end
        end
    end
end

-- 结束时间检测 --id: 5、6  时间：GetOpenEndTimeInfo
function this:ConditionCheck2(id)
    local data = self.datas[id]
    if (data:IsEnd()) then
        data:SetPush(false)
    else
        data:SetPush()
    end
end
-- 充值检测 --id: 1、6 的 登录/充值成功 推送 (分)
function this:ConditionCheck3(id, num)
    local data = self.datas[id]
    if (data) then
        data:SetAmount(math.floor(num / 100))
        -- EventMgr.Dispatch(EventType.MenuBuy_RechargeCB)
    end
end
-- 充值检测（7，8）
function this:ConditionCheck4(id, proto)
    local data = self.datas[id]
    if (data) then
        local payRate = proto.payRate or 0
        data:SetState(proto.state)
        data:SetTimes(proto.openTime, proto.closeTime)
        data:SetAmount(math.floor(payRate / 100))
        -- EventMgr.Dispatch(EventType.MenuBuy_RechargeCB)
    end
end

--在线期间进入检测 6 
function this:ConditionCheck5(id)
    local data = self.datas[id]
    if (id == 6 and data) then
       data:SetPush() 
    end
end

-- 开放、结束时间检测 
function this:GetOpenEndTimeInfo()
    local curTime = TimeUtil:GetTime()
    local time, id = nil, nil
    for n = 1, 2 do
        if (time ~= nil) then
            break
        end
        for k, v in pairs(self.datas) do
            -- local timeStr = n == 1 and v:GetCfg().startTime or v:GetCfg().endTime
            local _time = n == 1 and v:GetStartTime() or v:GetEndTime() -- TimeUtil:GetTimeStampBySplit(timeStr)
            if (_time and _time > curTime and (time == nil or _time < time)) then
                time = _time
                id = v:GetID()
            end
        end
    end
    if (time ~= nil) then
        return {time, id}
    end
    return nil
end

function this:GetCurID()
    local data = self:GetCurData()
    if (data) then
        return data:GetID()
    end
    return nil
end

-- 当前展示的(同时检测新进入的)
function this:GetCurData()
    local data = nil
    for k, v in ipairs(self.arr) do
        if (v:GetPush() or not v:IsEnd()) then
            data = v
            break
        end
    end
    if (data) then
        if (self.oldID and self.oldID ~= data:GetID()) then
            data:SetOnlineIn()
            self:ConditionCheck5(data:GetID())
        end
        self.oldID = data:GetID()
    end
    return data
end

function this:CheckIsNeedShow()
    local data = self:GetCurData()
    if (data) then
        return data:GetPush()
    end
    return false
end

function this:GetData(id)
    return self.datas[id]
end

-- 活动是否已关闭
function this:CheckIsEnd(id)
    local data = self.datas[id]
    if (data and not data:IsEnd()) then
        return false
    end
    return true
end

-- 活动是否在开发时间内
function this:CheckIsInTime(id)
    local data = self.datas[id]
    if (data and data:IsInTime()) then
        return true
    end
    return false
end

return this
