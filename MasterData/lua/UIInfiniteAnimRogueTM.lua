-- 商店buff
local this = {}
local animTotalTime = 1 -- 动画总时长
local animTotalTime2 = 1 -- 实际时长

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_layout)
    self.layout = _layout
    self.layout.animTotalTime = animTotalTime
end

function this:AnimPlay()
    if (not self.layout) then
        return
    end
    local indexs = self.layout:GetIndexs()
    local len = indexs.Length
    local delay = 32
    local limit = self.layout:GetLimit() -- 行、列个数
    for i = 0, len - 1 do
        local index = indexs[i]
        local lua = self.layout:GetItemLua(index)
        if (lua and lua.clickNode) then
            -- 移动动画
            local row = math.floor(i / limit)
            UIUtil:SetPObjMove(lua.clickNode, 0, 0, -50, 0, 0, 0, nil, 720, delay * row)
            UIUtil:SetObjFade(lua.clickNode, 0, 1, nil, 320, delay * row, 0)
        end
    end
end

function this:AnimAgain()
    -- self.layout.animTotalTime = animTotalTime  --重设时间，调用IEShowList会重新播放一次动画
    self.layout:AnimAgain()
end

return this
