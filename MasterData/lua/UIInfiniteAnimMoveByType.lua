-- 按参数缩进格子
local this = {}

local animTotalTime = 0.7 -- 动画总时长
local animTotalTime2 = 0.5 -- 实际时长
local dis = 50

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_layout, _params)
    self.layout = _layout
    self.layout.animTotalTime = animTotalTime
    self.moveType = _params[1] or "DTU"
    -- self.count = _params[2] or 1
end

function this:AnimPlay()
    if (not self.layout) then
        return
    end

    local xyInvert = self.layout:GetXYInvert() or false
    local realXY = self.layout:GetRealLimitXY()
    local limit = self.layout:GetLimit() -- 左右滚动时 表示行数

    local indexs = self.layout:GetIndexs()
    local len = indexs.Length
    local delay = (animTotalTime2 / (len / limit) * 1000)
    for i = 0, len - 1 do
        local index = indexs[i]
        local lua = self.layout:GetItemLua(index)
        if (lua and lua.gameObject) then
            if (xyInvert) then
                local delayTime = math.modf(delay * (math.fmod(i, realXY) + 1))
                -- fade
                UIUtil:SetObjFade(lua.node, 0, 1, nil, 300, delayTime)
                -- move
                local x1, y1 = 0, 0
                if (self.moveType == "DTU") then
                    y1 = -math.fmod(i, realXY) * dis - dis
                elseif (self.moveType == "RTL") then
                    x1 = math.fmod(i, realXY) * dis + dis
                elseif (self.moveType == "TTD") then
                    y1 = math.fmod(i, realXY) * dis + dis
                end
                UIUtil:SetPObjMove(lua.node, x1, 0, y1, 0, 0, 0, nil, 200, delayTime)
            else
                local delayTime = math.modf(delay * (math.modf(i / limit) + 1))
                -- fade
                UIUtil:SetObjFade(lua.node, 0, 1, nil, 300, delayTime)
                -- move
                local x1, y1 = 0, 0
                if (self.moveType == "DTU") then
                    y1 = -math.modf(i / limit) * dis - dis
                elseif (self.moveType == "RTL") then
                    x1 = math.modf(i / limit) * dis + dis
                elseif (self.moveType == "TTD") then
                    y1 = math.modf(i / limit) * dis + dis
                end
                UIUtil:SetPObjMove(lua.node, x1, 0, y1, 0, 0, 0, nil, 200, delayTime)
            end

        end
    end
end

function this:AnimAgain()
    -- self.layout.animTotalTime = animTotalTime  --重设时间，调用IEShowList会重新播放一次动画
    self.layout:AnimAgain()
end

return this
