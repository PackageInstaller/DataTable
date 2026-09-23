-- 格子一个个生成
local this = {}

local animTotalTime = 0.7 -- 动画总时长

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

--param:funcName=子物体上自定义调用动画的名称 delay:单个延迟时间,毫秒
function this:InitData(_layout,_params)
    self.layout = _layout
    self.layout.animTotalTime = animTotalTime
	self.customFuncName=_params and _params.funcName or nil;--动画方法名
	self.delayTime=_params and _params.delay or 125
end

function this:AnimPlay()
    if (not self.layout or self.customFuncName==nil) then
        return
    end
    local limit = self.layout:GetLimit() -- 行、列个数
    local indexs = self.layout:GetIndexs()
    local len = indexs.Length
    for i = 0, len - 1 do
        local index = indexs[i]
        local lua = self.layout:GetItemLua(index)
        if (lua and lua.gameObject) then
            local row = math.floor(i / limit)
            if self.customFuncName and lua[self.customFuncName] then
				lua[self.customFuncName]((row-1)*self.delayTime);
			end
        end
    end
end

function this:AnimAgain()
    self.layout:AnimAgain()
end

return this
