-- 格子一个个生成
local this = {}

local animTotalTime = 0.7 -- 动画总时长

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
    local limit = self.layout:GetLimit() -- 行、列个数
    local indexs = self.layout:GetIndexs()
    local len = indexs.Length
    local delay = 125 -- (animTotalTime / rows * 1000)

    for i = 0, len - 1 do
        local index = indexs[i]
        local lua = self.layout:GetItemLua(index)
        if (lua and lua.gameObject) then
            local row = math.floor(i / limit)
            local fade = ComUtil.GetOrAddCom(lua.gameObject, "ActionFade")
            fade:Play(0, 1, 300, math.modf(delay * row + 1), nil)
        end
    end
end

function this:AnimAgain()
    --self.layout.animTotalTime = animTotalTime -- 重设时间，调用IEShowList会重新播放一次动画
    self.layout:AnimAgain()
end

return this
