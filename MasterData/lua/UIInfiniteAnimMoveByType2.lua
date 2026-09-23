-- 按参数缩进格子
local this = {}

local singleAnimTime = 0.25 -- 单个动画时长,毫秒
local fixedDelayTime=0.05 --固定延迟时长，毫秒
local animTotalTime=0.5
local dis = 50

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

--_params:[1]=动画方向 [2]=单个动画时间长度，不传按默认值算，秒 [3]=动画之间固定延迟时间，不传按默认值算，秒 ,[4]=动画总时长，秒，不传按默认值算
function this:InitData(_layout, _params)
    self.layout = _layout
    self.moveType = _params[1] or "DTU"
    self.singleAnimTime = (_params[2] or singleAnimTime)*1000;
    self.singleMoveAnimTime=self.singleAnimTime*0.6;
    self.fixedDelayTime=(_params[3] or fixedDelayTime)*1000;
    self.layout.animTotalTime =(_params[4] or animTotalTime);
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
    local delay = self.fixedDelayTime and self.fixedDelayTime or (self.singleAnimTime/2 * (len / limit))
    for i = 0, len - 1 do
        local index = indexs[i]
        local lua = self.layout:GetItemLua(index)
        if (lua and lua.gameObject) then
            if (xyInvert) then
                local delayTime = math.modf(delay * (math.fmod(i, realXY) + 1))
                -- fade
                UIUtil:SetObjFade(lua.node, 0, 1, nil, self.singleAnimTime, delayTime)
                -- move
                local x1, y1 = 0, 0
                if (self.moveType == "DTU") then
                    y1 = -math.fmod(i, realXY) * dis - dis
                elseif (self.moveType == "RTL") then
                    x1 = math.fmod(i, realXY) * dis + dis
                elseif (self.moveType == "TTD") then
                    y1 = math.fmod(i, realXY) * dis + dis
                end
                UIUtil:SetPObjMove(lua.node, x1, 0, y1, 0, 0, 0, nil, self.singleMoveAnimTime, delayTime)
            else
                local delayTime = math.modf(delay * (math.modf(i / limit) + 1))
                -- fade
                UIUtil:SetObjFade(lua.node, 0, 1, nil, self.singleAnimTime, delayTime)
                -- move
                local x1, y1 = 0, 0
                if (self.moveType == "DTU") then
                    y1 = -math.modf(i / limit) * dis - dis
                elseif (self.moveType == "RTL") then
                    x1 = math.modf(i / limit) * dis + dis
                elseif (self.moveType == "TTD") then
                    y1 = math.modf(i / limit) * dis + dis
                end
                UIUtil:SetPObjMove(lua.node, x1, 0, y1, 0, 0, 0, nil, self.singleMoveAnimTime, delayTime)
            end

        end
    end
end

function this:AnimAgain()
    -- self.layout.animTotalTime = animTotalTime  --重设时间，调用IEShowList会重新播放一次动画
    self.layout:AnimAgain()
end

return this
