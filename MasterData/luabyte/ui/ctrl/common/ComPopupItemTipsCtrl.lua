local M = BaseClass("ComPopupItemTipsCtrl", BaseUICtrl)

local itemCtrl = require("UI.Ctrl.UIItemEquip.UIItemGetCtrl")
local m_insert = table.insert

function M:Init()
    self.m_itemCfg = nil
    self.m_callback = nil
    self.m_itemList = {}
    self.m_itemHandler = Bind(self, self.OnItemCallback)
    self._view.btn_mask:onClick(Bind(self, self.OnClickMask))
end

function M:OnEnter(itemCfg, itemNum, pivot, rectTrans, place, action)
    self.m_itemCfg = itemCfg
    self.m_callback = action
    self:_ShowGetWay()
    --坐标的顺序:左下、左上、右上、右下
    local worldPos = rectTrans:WorldCorners()[place]
    self._view.node_lessItem:SetActive(false)
    self._view.node_moreItem:SetActive(false)
    self._view.txt_name:SetText(itemCfg.name)
    self._view.txt_holdNum:SetText(tostring(itemNum))
    self._view.node_n:SetActive(itemCfg.quality == 1)
    self._view.node_r:SetActive(itemCfg.quality == 2)
    self._view.node_sr:SetActive(itemCfg.quality == 3)
    self._view.node_ssr:SetActive(itemCfg.quality == 4)
    self._view.node_content.pivot = pivot
    self._view.node_content.position = worldPos

    if itemNum > 0 then
        local descStr = ConfigHelper.GetLocalStringByPlayerName(itemCfg.desc)
        self._view.txt_desc:SetText(descStr)
    else
        self._view.txt_desc:SetText(itemCfg.wayValue1)
    end
end

function M:OnClickMask(go)
    self:Close()
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

-- 显示获取途径
function M:_ShowGetWay()
    local wayVal = self.m_itemCfg.wayValue2
    local wayNum = wayVal and wayVal.Length or 0
    self._view.node_more:SetActive(wayNum > 3)
    self._view.node_line:SetActive(wayNum <= 0)
    self._view.node_less:SetActive(wayNum >= 1 and wayNum <= 3)
    local itemView
    if wayNum > 3 then
        itemView = self._view.node_moreItem
    else
        itemView = self._view.node_lessItem
    end

    local openIds, lockIds = {}, {}
    local inst = JumpMgr:GetInstance()
    local labels = self.m_itemCfg.wayLabel
    local len = labels and labels.Length or 0
    for i = 0, wayNum - 1 do
        local jId = wayVal[i]
        if inst:CheckShowLimitById(jId) == 0 then --判断是否显示
            if inst:CheckLockByJumpId(jId) > 0 then
                m_insert(lockIds, { jumpId = jId, wayLabel = len > i and labels[i] or 1 })
            else
                m_insert(openIds, { jumpId = jId, wayLabel = len > i and labels[i] or 1 })
            end
        end
    end

    for _, v in ipairs(lockIds) do m_insert(openIds, v) end

    local itemId = self.m_itemCfg.id
    for _, jumpId in ipairs(openIds) do
        local cloneItem = itemCtrl.New(itemView:Instantiate())
        -- clone.transform:SetActive(true)
        cloneItem:UpdateItem(jumpId)
        cloneItem:SetCallBack(self.m_itemHandler, itemId)
        m_insert(self.m_itemList, cloneItem)
    end
end

function M:OnItemCallback()
    if self.m_callback then
        self.m_callback()
    end
    self:Close()
end

function M:OnDispose()
    for _, item in ipairs(self.m_itemList) do
        item:OnDispose()
    end
    self.m_itemCfg = nil
    self.m_callback = nil
    self.m_itemList = nil
    self.m_itemHandler = nil
    M.super.OnDispose(self)
end

return M
