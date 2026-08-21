local CommonItemCtrl = BaseClass("CommonItemCtrl")
local M = CommonItemCtrl

function M:__init(view)
    self._view = view
    self._itemPfbUI = self._view.item
    self._onClick = nil
    self:Init()
end

function M:Init()
end

function M:GetName()
    return self._view:GetName()
end

function M:SetInfo(itemId, numberType, num, num1)
    if num == nil then
        num = 0
    end
    if num1 == nil then
        num1 = 0
    end
    self._itemPfbUI:SetInfo(itemId, numberType, num, num1)
end

function M:SetRedPoint(isV)
    self._itemPfbUI.m_isCheckRedPoint = isV
end

function M:SetRedPointParam(index, param)
    self._itemPfbUI:SetRedPoint(index, param)
end

function M:RedPointCheck()
    self._itemPfbUI:RedPointCheck()
end

function M:NoScruplesCheck()
    self._itemPfbUI:NoScruplesCheck()
end

--用于作为循环滚动列表中的元素  此方法需要重写
function M:UpdateItem(data)
    if not data then return end
    if data.State then self:SetState(data:State()) end
    self:SetInfo(data.itemId, data.numType, data.itemNum)
    if data.isPopItem == nil then self:EnablePopItem(true) end
end

--是否显示名字
function M:SetItemNameActive(v)
    self._itemPfbUI:SetItemNameActive(v)
end

--icon是否检测鼠标
function M:SetRaycast(v)
    self._itemPfbUI:SetRaycast(v)
end

-- 数量变化回调
function M:OnNumChanged(action)
    self._itemPfbUI:OnNumChanged(action)
end

--开启弹出通用弹窗
function M:EnablePopItem(v)
    self._itemPfbUI:EnablePopItem(v)

    if v then
        self._itemPfbUI.onClick = nil
    end
end

--点击之后的回调
function M:SetClickCallback(onclick)
    self._onClick = onclick
    self._itemPfbUI.onClick = Bind(self, self._OnClickItemFrame)
end

--选中
function M:Select(v)
    self._itemPfbUI:Select(v)
end

function M:SetLock(v)
    self._itemPfbUI:SetLock(v)
end

function M:EnableClick(v)
    self._itemPfbUI:EnableClick(v)
end

function M:EnablePress(v, onPress)
    self._itemPfbUI:EnablePress(v, onPress)
end

function M:Dispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._itemPfbUI then
        self._itemPfbUI:DoDispose()
    end
    self._onClick = nil
    self._itemPfbUI = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:_OnClickItemFrame(go)
    if self._onClick then
        self._onClick(go)
    end
end

function M:SetActive(v)
    self._view:SetActive(v)
end

function M:CheckItemNum(itemId, num)
    self._itemPfbUI:CheckItemNum(itemId, num)
end

function M:SetFinish(b)
    self._itemPfbUI:SetFinish(b)
end

function M:IsEqualRedPointParam(idx, param)
    return self._itemPfbUI:IsEqualRedPointParam(idx, param)
end

function M:SetMarkActive(value)
    self._itemPfbUI:SetMarkActive(value)
end

function M:SetState(v)
    self._itemPfbUI:SetState(v)
end

function M:SetQualityActive(v)
    self._itemPfbUI:SetQualityActive(v)
end

return CommonItemCtrl
