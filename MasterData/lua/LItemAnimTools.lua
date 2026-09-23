LItemAnimTools = {}
local this = LItemAnimTools

local inTimer = 300
local timer = 200
local item2Height = 108.5 --113
function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins
end

function this:Init(_panel)
    self.panel = _panel
end

function this:InitScale(_parentScale)
    self.parentScale = _parentScale
end

-- 进场动画
function this:AnimFirst()
    self.oldIndex1 = self.panel.GetCurIndex1()
    self.oldIndex2 = self.panel.GetCurIndex2()

    -- item设置到正确位置,mask大小
    for i, v in ipairs(self.panel.leftItems) do
        -- pos
        CSAPI.SetAnchor(v.gameObject, 0, self:GetLeftItemPos(i), 0)
        -- mask
        CSAPI.SetRTSize(v.mask, 350, self:GetMaskHeight(i))
        CSAPI.SetGOActive(v.mask, i == self.panel.GetCurIndex1())
    end

    -- 动画
    for i, v in ipairs(self.panel.leftItems) do
        if (i == self.panel.GetCurIndex1()) then
            -- line 
            self:SetlineScale(v.line, 12, 30, inTimer)
        end
        -- node 
        UIUtil:SetPObjMove(v.node, -200, 0, 0, 0, 0, 0, nil, 300, 125 * (i - 1))
        UIUtil:SetObjFade(v.node, 0, 1, nil, 300, 125 * (i - 1), 0)
        -- clickNode		
        UIUtil:SetPObjMove(v.clickNode, -18, 0, 0, 0, 0, 0, nil, inTimer)
    end
    -- 子item出现动画
    self:SetCruChildAnim()
end

function this:Anim()
    if (self.oldIndex1 == self.panel.GetCurIndex1()) then
        -- 未换页签，无动画
        return
    end

    -- 隐藏前一个选择
    local oldItem = self.panel.leftItems[self.oldIndex1]
    if (self:IsChildExit(self.oldIndex1)) then
        UIUtil:SetPObjMove(oldItem.childPoint, 0, 0, 0, self:GetPointHeight(self.oldIndex1), 0, 0, function()
            CSAPI.SetGOActive(oldItem.mask, false)
        end, timer)
    end
    self:SetlineScale(oldItem.line, 30, 12)

    -- 展开当前选择
    local newItem = self.panel.leftItems[self.panel.GetCurIndex1()]
    CSAPI.SetGOActive(newItem.mask, true)
    if (self:IsChildExit(self.panel.GetCurIndex1())) then
        UIUtil:SetPObjMove(newItem.childPoint, 0, 0, self:GetPointHeight(self.panel.GetCurIndex1()), 0, 0, 0, nil, timer)
    end
    self:SetlineScale(newItem.line, 12, 30)
    self:SetCruChildAnim()

    -- fade todo 
    -- 整体移动父亲到合适位置
    for i, v in ipairs(self.panel.leftItems) do
        local x, y1, z = CSAPI.GetAnchor(v.gameObject)
        local y2 = self:GetLeftItemPos(i)
        if (y1 ~= y2) then
            UIUtil:SetPObjMove(v.gameObject, 0, 0, y1, y2, 0, 0, nil, timer)
        end
    end
    --
    self.oldIndex1 = self.panel.GetCurIndex1()
    self.oldIndex2 = self.panel.GetCurIndex2()
end

-- 子items 出现过程
function this:SetCruChildAnim()
    if (not self:IsChildExit(self.panel.GetCurIndex1())) then
        return
    end
    local items = self.panel.leftChildItems[self.panel.GetCurIndex1()]
    local count = #items * 2
    local pTimer = math.ceil(timer / count)
    for k, m in ipairs(items) do
        -- point
        UIUtil:SetObjFade(m.point, 0, 1, nil, pTimer, (k * 2 - 2) * pTimer + timer)
        -- clickNode 
        UIUtil:SetObjFade(m.clickNode, 0, 1, nil, pTimer, (k * 2 - 1) * pTimer + timer)
        -- red
        UIUtil:SetObjFade(m.red, 0, 1, nil, pTimer, (k * 2) * pTimer + timer)
    end
end

-- line长度，正常12,选中30
function this:SetlineScale(obj, width1, width2, _timer)
    local action = ComUtil.GetOrAddCom(obj, "ActionUISize")
    action:SetOrgSizeSize(width1, 4)
    action:SetTargetSize(width2, 4)
    action.time = _timer == nil and timer or _timer
    action:ToPlay()
end

-- 父间隔:167  子间隔：93
function this:GetLeftItemPos(index)
    local y = 0
    if (index > self.panel.GetCurIndex1()) then
        local childCount = 0
        if (self:IsChildExit(self.panel.GetCurIndex1())) then
            childCount = #self.panel.leftChildItems[self.panel.GetCurIndex1()]
        end
        local offsetY = childCount > 0 and 40 or 0
        y = -(self.parentScale * (index - 1) + item2Height * childCount) + offsetY
    else
        y = -(self.parentScale * (index - 1))
    end
    -- if (index <= self.panel.GetCurIndex1()) then
    --     y = -(self.parentScale * (index - 1))
    -- else
    --     if (not self:IsChildExit(index)) then
    --         y = -(self.parentScale * (index - 1))
    --     else
    --         y = -(self.parentScale * (index - 1) + item2Height * #self.panel.leftChildItems[index])
    --     end
    -- end
    return y
end

-- mask height  
function this:GetMaskHeight(index)
    if (not self:IsChildExit(index)) then
        return 0
    end
    local childCount = #self.panel.leftChildItems[index]
    return item2Height * childCount + 20
    -- return self.parentScale + item2Height * childCount - 62
end

-- point 移动高度 41 --GameObject位置的一半
function this:GetPointHeight(index)
    if (not self:IsChildExit(index)) then
        return 0
    end
    local childCount = #self.panel.leftChildItems[index]
    return item2Height * childCount + 50
end

function this:IsChildExit(index)
    if (not self.panel.leftChildItems[index] or #self.panel.leftChildItems[index] <= 0) then
        return false
    end
    return true
end

return this
