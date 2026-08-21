local M = BaseClass("WishjourneySelectItemCtrl", BaseUICtrl)
local itemCtrl = require("UI.Ctrl.ComRoom.JourneySelectItemCtrl")
local itemView = require("UI.View.Common.ItemPfbView")

function M:Init()
    self.m_foodDic = {} -- 已选食物数据
    self.m_markFoods = {} -- 额外奖励的食物ID
    self.m_curFoodIds = {} -- 当前选择的食物ID
    self.m_looplist = self._view.ScrollView
    self.m_looplist:Init(itemCtrl, itemView)
    self._view.mask:onClick(Bind(self, self.Close))
    self._view.ok:onClick(Bind(self, self.OnClickOk))
    self.m_sortHandler = Bind(self, self.OnSortDatas)
    self.m_looplist:SetCreateItemCallback(Bind(self, self.OnCreateItem))
end

function M:OnEnter(selectIds, markFoods, callback)
    self.m_callbcak = callback
    self.m_markFoods = markFoods
    self.m_curFoodIds = selectIds
    local markDic, selectDic = {}, {}
    for _, id in ipairs(markFoods) do
        if id > 0 then markDic[id] = true end
    end
    for _, id in ipairs(selectIds) do
        if id > 0 then selectDic[id] = true end
    end
    local itemDatas = ItemDataMgr:GetInstance():GetAllItemDatas({ BagConst.ItemType.EIT_Food })
    local luaDatas, insert = {}, table.insert
    for i = 0, itemDatas.Count - 1, 1 do
        local itemData = itemDatas[i]
        local id = itemData.Id
        local isMark = markDic[id] or false
        local isSelect = selectDic[id] or false
        local data = {
            Id = id,
            Cnt = itemData.Num,
            IsMark = isMark, -- 是否显示角标
            IsSelect = isSelect
        }
        insert(luaDatas, data)
        if isSelect then self.m_foodDic[id] = data end
    end

    table.sort(luaDatas, self.m_sortHandler)
    self.m_looplist:SetDataList(luaDatas)
end

function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:OnDispose()
    self.m_foodDic = nil
    self.m_callbcak = nil
    self.m_curFoodIds = nil
    self.m_sortHandler = nil
    M.super.OnDispose(self)
end

function M:OnCreateItem(ctrl)
    ctrl:SetSelectCallback(Bind(self, self.OnSelect))
end

function M:OnSelect(data)
    local foodId = data.Id
    if data.IsSelect then
        for i = 1, #self.m_curFoodIds, 1 do
            if self.m_curFoodIds[i] == foodId then
                self.m_curFoodIds[i] = 0
                break
            end
        end
        data.IsSelect = false
        self.m_foodDic[foodId] = nil
    else
        local full, len = true, #self.m_curFoodIds
        for i = 1, len, 1 do
            if self.m_curFoodIds[i] <= 0 then
                self.m_curFoodIds[i] = foodId
                full = false
                break
            end
        end
        if full then
            local lastId = self.m_curFoodIds[len]
            self.m_curFoodIds[len] = foodId
            local foodData = self.m_foodDic[lastId]
            if foodData then foodData.IsSelect = false end
        end
        data.IsSelect = true
        self.m_foodDic[foodId] = data
    end
    self.m_looplist:UpdateList()
end

-- 确定按钮
function M:OnClickOk(go)
    local items = {}
    for _, foodId in ipairs(self.m_curFoodIds) do
        if foodId > 0 then table.insert(items, foodId) end
    end
    if #items > 0 then
        for _, foodId in ipairs(self.m_markFoods) do
            local foodData = self.m_foodDic[foodId]
            if not foodData then
                GameHelper.TipsById(5678) -- 所选食材不满足要求
                return
            end
        end
    end
    if self.m_callbcak then self.m_callbcak(items) end
    self:Close()
end

-- 列表排序
function M:OnSortDatas(v1, v2)
    local cnt1, cnt2 = v1.Cnt, v2.Cnt
    local hasEmpty = (cnt1 <= 0) or (cnt2 <= 0)
    -- 1. 已拥有大于未拥有
    if hasEmpty and (cnt1 ~= cnt2) then return cnt1 > cnt2 end

    if v1.IsMark == v2.IsMark then
        -- 3.相同状态按照itemid由小到大显示
        return v1.Id < v2.Id
    else
        -- 2.可选中＞不可选择
        return v1.IsMark
    end
end

return M
