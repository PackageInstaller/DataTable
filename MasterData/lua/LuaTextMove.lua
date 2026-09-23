-- text满框后左右移动 
-- 要考虑无限滚动的item，不满足滚动的要还原初始位置
-- 只考虑Text的Anchors为左中右情况
LuaTextMove = {}
local this = LuaTextMove
function this.New(o)
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins
end

function this:Init(txt)
    if (not self.isInit) then
        local rect = ComUtil.GetCom(txt, "RectTransform")
        self.oldPos = rect.anchoredPosition
        self.oldPivot = rect.pivot
        self.oldAnchorMin = rect.anchorMin
        self.oldAnchorMax = rect.anchorMax
        self.parentWidth = CSAPI.GetRealRTSize(rect.parent.gameObject)[0]
        self.isInit = true
    end
end

function this:CheckMove(txt)
    local width = CSAPI.GetRealRTSize(txt)[0]
    if (width > self.parentWidth) then
        local rect = ComUtil.GetCom(txt, "RectTransform")
        rect.pivot = UnityEngine.Vector2(0.5, 0.5) -- 默认居中，那么只计算3种情况即可，否则有9种
        self:SetMovePos(width)
        if (self.action) then
            self.action.enabled = true
        end
        self.action = UIUtil:SetPObjMove(txt, self.startPos, self.endPos, self.oldPos.y, self.oldPos.y, 0, 0, nil, 6000,
            1)
    else
        if (self.action) then
            self.action.enabled = false
        end
        local rect = ComUtil.GetCom(txt, "RectTransform")
        rect.pivot = self.oldPivot
        CSAPI.SetAnchor(txt, self.oldPos.x, self.oldPos.y)
    end
end

function this:SetMovePos(width)
    if (self.oldAnchorMin.x == 0 and self.oldAnchorMax.x == 0) then
        self.startPos = width / 2 + self.parentWidth
        self.endPos = -width / 2
    elseif (self.oldAnchorMin.x == 1 and self.oldAnchorMax.x == 1) then
        self.startPos = width / 2
        self.endPos = -width / 2 - self.parentWidth
    else
        self.startPos = width / 2 + self.parentWidth / 2
        self.endPos = -width / 2 - self.parentWidth / 2
    end
end

return this
