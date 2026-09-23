local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_data)
    self.data = _data
end

function this:GetCfgID()
    return self.data and self.data.cfgid
end

-- 如果返回nil,说明还没有展示
function this:GetFinishTime()
    if (self.data.finishTime and self.data.finishTime > 0) then
        return self.data.finishTime
    end
    return nil
end

-- 弹出时间
function this:GetPopupTime()
    if (self.data.popupTime and self.data.popupTime > 0) then
        return self.data.popupTime
    end
    return nil
end

-- cfgPopupPackCondition
function this:GetCfg()
    if (not self.cfg) then
        self.cfg = Cfgs.cfgPopupPackCondition:GetByID(self:GetCfgID())
    end
    return self.cfg
end
-- cfgPopupPack
function this:GetChildCfg()
    if (not self.childCfg) then
        self.childCfg = Cfgs.cfgPopupPack:GetByID(self:GetCfg().popupPack)
    end
    return self.childCfg
end

-- 当前商品（有序系列） cfgPopupPack的某条item
function this:GetCurShowItemCfg()
    local cfg = nil
    local arr = self:GetChildCfg().item
    for k, v in ipairs(arr) do
        local comm = ShopMgr:GetFixedCommodity(v.shopItem)
        if (comm and not comm:IsOver()) then
            cfg = v
            break
        end
    end
    return cfg
end

function this:SetPopupTime(time)
    self.data.popupTime = time
    self.data.finishTime = time + self:GetCfg().nCountdown * 60
end

-- 是否已过期
function this:IsExpired()
    if (self:GetFinishTime()) then
        return TimeUtil:GetTime() > self:GetFinishTime()
    end
    return false
end

-- 是否已全部购买
function this:IsGet()
    local _cfg = self:GetCurShowItemCfg()
    return _cfg == nil
end

-- 是否已弹出
function this:IsShow()
    if (self.data.popupTime and self.data.popupTime > 0) then
        return true
    end
    return false
end

-- 冷启动原因
function this:SetErrorStr(eStr)
    if (not self.data.eStr and eStr ~= nil) then
        self.data.isCold = true
        self.data.eStr = eStr
    end
end
function this:GetErrorStr()
    if (self.source ~= "自动弹窗" and self.data.isCold == nil) then
        self.data.isCold = true
        self.data.eStr = "重登"
    end
    if (self.data.isCold == nil) then
        self.data.isCold = false
    end
    if (self.data.eStr == nil) then
        self.data.eStr = "无"
    end
    return self.data.isCold, self.data.eStr
end

function this:SetSource(source)
    self.source = source
end
function this:GetSource()
    return self.source or "未知"
end

-- 设置首次弹出
function this:SetFirst(b)
    self.isFirst = b
end
function this:GetFirst()
    if (self.isFirst == nil) then
        return false
    end
    return self.isFirst
end

return this
