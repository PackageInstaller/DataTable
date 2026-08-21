local M = BaseClass("BagUICtrl", BaseUICtrl)
local sfmt = string.format
local ONEDAYM = 86400

function M:Init()
    local ESubType = BagConst.ItemPlotType
    self._filterTabConst = { ESubType.MAIN, ESubType.MASK, ESubType.BRANCH }
    local filterLabels = {
        ConfigHelper.GetLocalString(ESubType.MAIN[2]),
        ConfigHelper.GetLocalString(ESubType.MASK[2]),
        ConfigHelper.GetLocalString(ESubType.BRANCH[2]),
    }
    local filterIcons = {
        "UI/SpritePics/warehouse/ui_warehouse_tog_01", -- 主线
        "UI/SpritePics/warehouse/ui_warehouse_tog_02", -- 假面舞会
        "UI/SpritePics/warehouse/ui_warehouse_tog_03", -- 支线
    }

    self.m_subTabIdx = 0
    self.m_allItems = nil
    self.m_selectData = nil    -- 当前选中itemData
    self.m_isDecompose = false -- 是否分解模式
    self.m_loopList = self._view.gridScroll
    self.m_curTabType = BagConst.TabType.ITEM
    self.m_bottomBarCtrl = self._view.normalState -- 道具页签
    self.m_decomposeCtrl = self._view.selectState -- 分解面板
    self.m_subTabNode = self._view.gridScroll.transform.parent

    self._view.btn_get:onClick(Bind(self, self.OnClickGetWay))  -- 获取路径
    self._view.btn_use:onClick(Bind(self, self.OnClickUseItem)) -- 使用道具
    self._view.btn_decomp:onClick(Bind(self, self.OnClickDecompose))
    self.m_loopList:SetCreateItemCallback(Bind(self, self.OnCreatBagItem))
    self.m_decomposeCtrl:SetDisableCallback(Bind(self, self.OnDisableDecompose))
    self.m_loopList:Init(require("UI.Ctrl.Bag.BagItemCtrl"), require("UI.View.Bag.BagItemView"))
    self._view.filter:InitIconItems(self.m_subTabIdx, filterLabels, filterIcons, Bind(self, self._OnChangeFilter))
    self._selectItemCallback = EventMgr:AddListener(UIMessageNames.BAG_SELECT_ITEM, Bind(self, self._OnSelectItem))
    self._useItemSucCallback = EventMgr:AddListener(UIMessageNames.BAG_USE_ITEM_SUC, Bind(self, self._OnUseItemSuc))
    self._bagTabChangeCallback = EventMgr:AddListener(UIMessageNames.BAG_TYPE_TABLE_CHANGE, Bind(self, self._OnTagChange))
end

--initTab 默认显示页签
function M:OnEnter(initTab, allItems)
    self.m_allItems = allItems
    self.m_curTabType = initTab
    self.m_bottomBarCtrl:SetTab(self.m_curTabType, true)
    GameHelper.DoPlayerAction(PlayerAction.OpenBag)
end

function M:OnBack()
    if self.m_isDecompose then
        self:OnDisableDecompose()
        return self.m_isDecompose
    end
    return true
end

function M:OnDispose()
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
    self.m_subTabIdx = 0
    self.m_allItems = nil
    self.m_isDecompose = false
    self.m_selectData = nil
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_renameTag)
    EventMgr:RemoveListener(UIMessageNames.BAG_TYPE_TABLE_CHANGE, self._bagTabChangeCallback)
    EventMgr:RemoveListener(UIMessageNames.BAG_SELECT_ITEM, self._selectItemCallback)
    EventMgr:RemoveListener(UIMessageNames.BAG_USE_ITEM_SUC, self._useItemSucCallback)
    M.super.OnDispose(self)
end

function M:OnCreatBagItem(ctrl)
    ctrl:SetCallBack(function(itemId, packageId)
        if self.m_selectData then
            local id = self.m_selectData.Id
            local PackageId = self.m_selectData.PackageId
            return (itemId == id) and (packageId == PackageId)
        end
        return false
    end, function()
        return self.m_isDecompose
    end)
end

-- 路径按钮
function M:OnClickGetWay(go)
    UIContextMgr:GetInstance():Show("ComPopupItemTips",
        self.m_selectData:GetItemCfg(),
        self.m_selectData.Num,
        Vector2.right,
        self._view.btn_get,
        2
    )
end

-- 使用道具按钮
function M:OnClickUseItem(go)
    local itemCfg = self.m_selectData:GetItemCfg()
    if itemCfg == nil then return end

    local effectType = itemCfg.effectType
    local EEffectType = BagConst.ItemEffectType
    local packageId = self.m_selectData.PackageId
    if effectType == EEffectType.FreeChooseItem then
        local useItemNum = ItemDataMgr:GetInstance():GetItemNumById(packageId)
        UIContextMgr:GetInstance():Show("FreeChoose", itemCfg.id, packageId, useItemNum)
    elseif effectType == EEffectType.FreeChooseHero then
        local FreeChooseHeroSceneCtrl = require "UI.Ctrl.Bag.FreeChooseHeroSceneCtrl"
        FreeChooseHeroSceneCtrl:GetInstance():OnDispose()
        FreeChooseHeroSceneCtrl:GetInstance():LoadScene("Scene/FreeChoose/FreeChooseHeroRoom", function()
            UIContextMgr:GetInstance():Show("FreeChooseHero", itemCfg.id, packageId, 1)
        end)
    elseif effectType == EEffectType.ChangeNick then
        ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_renameTag)
        self.m_renameTag = ItemDataMgr:GetInstance():AddItemChange(itemCfg.id, ItemHelper.RefreshBag)
        UIContextMgr:GetInstance():Show("CreateAccountUI", true)
    else
        if (effectType == EEffectType.Frag) or (effectType == EEffectType.Combine) then
            local batch = itemCfg.effectArgs[0]
            if math.floor(self.m_selectData.Num / batch) <= 0 then
                local tips = ConfigHelper.GetLocalString(5164)
                local name = ConfigHelper.GetLocalString(itemCfg.name)
                GameHelper.Tips(sfmt(tips, tostring(batch), name))
                return
            end
        end
        UIContextMgr:GetInstance():Show("ComPopupItemUse", self.m_selectData)
    end
end

-- 分解按钮
function M:OnClickDecompose(go)
    local itemCfg = self.m_selectData:GetItemCfg() or {}
    if IsNull(itemCfg.decomposeItem) then
        GameHelper.TipsById(5165)
        return
    end
    self.m_isDecompose = true
    self._view.descState:SetActive(false)
    self._view.btn_decomp:SetActive(false)
    self.m_decomposeCtrl:Enable(self.m_selectData)
    self.m_loopList:UpdateList()
end

function M:OnDisableDecompose()
    self.m_isDecompose = false
    self.m_decomposeCtrl:SetActive(self.m_isDecompose)
    if self.m_selectData then self:_ShowItemDesc() end
    self.m_loopList:UpdateList()
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

-- 子页签回调
function M:_OnChangeFilter(idx)
    self._view.group:SetActive(false)
    self.m_subTabIdx = idx
    local list = self:_GetDataList(self.m_curTabType)
    self.m_loopList:SetDataList(list)
    local count = #list
    self:_EmptyState(count == 0)
    self._view.group:SetActive(count > 0)
end

function M:_OnUseItemSuc(allItems)
    self.m_allItems = allItems
    local list = self:_GetDataList(self.m_curTabType)
    --当前选中物品已经过期
    if self.m_selectData.ExpireTime > 0 and self.m_selectData.ExpireTime - TimeUtil.GetNowTimeStamp() <= 0 then
        local item = self.m_loopList:GetItemByIdx(0)
        self.m_selectData = item:GetItemData()
    end
    self.m_loopList:SetDataList(list)
    if self.m_selectData.Num > 0 then
        self:_ShowRightPanel()
    else
        self:_EmptyState(#list == 0)
    end
    self.m_bottomBarCtrl:CheckRedPoint(self.m_curTabType)
end

-- 主页签回调
function M:_OnTagChange(tabType)
    self._view.group:SetActive(false)
    self.m_curTabType = tabType
    local list = self:_GetDataList(self.m_curTabType)
    self.m_loopList:SetDataList(list)
    self:_SetSubTypeState()
    local count = #list
    self:_EmptyState(count == 0)
    self._view.group:SetActive(count > 0)
end

-- 点击道具
function M:_OnSelectItem(data)
    self.m_selectData = data
    self.m_loopList:UpdateList()
    self:_ShowRightPanel()
end

--用于道具页签时，分类筛选
function M:_GetDataList(tabType)
    local rtnList = {}
    if tabType == BagConst.TabType.PLOT then
        local filterTypeConfig = self._filterTabConst[self.m_subTabIdx + 1]
        local filterType = filterTypeConfig[1]

        for _, data in ipairs(self.m_allItems[tabType]) do
            local itemCfg = data.data:GetItemCfg()
            if table.indexof(filterType, itemCfg.subType) then
                table.insert(rtnList, data)
            end
        end
    else
        rtnList = self.m_allItems[tabType]
    end

    return rtnList
end

-- 显示道具详情
function M:_ShowItemDesc()
    self._view.descState:SetActive(true)
    local itemData = self.m_selectData
    local itemCfg = itemData:GetItemCfg() or {}
    local isUse = itemCfg.operate > 0 and itemCfg.operate < 5
    local isGetWay = itemCfg.getWay == 1 and itemCfg.type ~= BagConst.ItemType.EIT_Show
    self._view.txt_name:SetText(itemCfg.name)
    self._view.img_icon:SetItemIcon(itemCfg.id)
    self._view.txt_num:SetText(tostring(itemData.Num))
    self._view.btn_use:SetActive(isUse)
    self._view.btn_get:SetActive(isGetWay)
    self._view.node_n:SetActive(itemCfg.quality == 1)
    self._view.node_r:SetActive(itemCfg.quality == 2)
    self._view.node_sr:SetActive(itemCfg.quality == 3)
    self._view.node_ssr:SetActive(itemCfg.quality == 4)
    self._view.btn_decomp:SetActive(itemCfg.decompose == 1)
    if itemData.Num > 0 then
        local desc = ConfigHelper.GetLocalStringByPlayerName(itemCfg.desc)
        self._view.txt_desc:SetText(desc)
    else
        local hideStr = ConfigHelper.GetLocalString(5144)
        local wayStr1 = ConfigHelper.GetLocalString(itemCfg.wayValue1)
        self._view.txt_desc:SetText(hideStr .. "\n\n" .. wayStr1)
    end
    self.remainTime = itemData.ExpireTime - TimeUtil.GetNowTimeStamp()
    self._view.tfTimer:SetActive(itemData.ExpireTime > 0)
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
    if itemData.ExpireTime > 0 then
        local days = 0
        if self.remainTime > 0 then
            days = math.modf(self.remainTime / ONEDAYM)
            if days < 1 then
                self:OnTimerCallback()
                self.m_timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.OnTimerCallback))
                self.m_timer:Start()
            else
                local str = ConfigHelper.GetLocalString(5769)
                self._view.labTimer:SetText(sfmt(str, days))
            end
        end
    end
    if itemCfg.type == BagConst.ItemType.EIT_Furniture then
        self._view.Atmosphere.gameObject:SetActive(true)
        local cfg = ConfigHelper.GetCfgByLua("houseFurniture", itemCfg.id)
        self._view.AtmosphereNum:SetText(tostring(cfg.atmosphere))
    else
        self._view.Atmosphere.gameObject:SetActive(false)
    end
end

function M:OnTimerCallback()
    self.remainTime = self.remainTime - 1
    if self.remainTime <= 0 then
        if self.m_timer then
            self.m_timer:Stop()
            self.m_timer = nil
        end
        return
    end
    local str = ConfigHelper.GetLocalString(5770)
    self._view.labTimer:SetText(sfmt(str, self:_TimeFormat(self.remainTime)))
end

function M:_EmptyState(isEmpty)
    self._view.empty:SetActive(false)

    local allItem = self.m_loopList:GetItems()
    for i, v in pairs(allItem) do
        v:SetSelect(false)
    end


    local item = self.m_loopList:GetItemByIdx(0)
    if not isEmpty and not IsNull(item) then
        self.m_selectData = item:GetItemData()
        self:_ShowRightPanel()
        item:SetSelect(true)
    else
        self.m_selectData = nil
        self.m_decomposeCtrl:Enable(nil)
        self._view.descState:SetActive(false)
        self._view.btn_decomp:SetActive(false)
    end

    self._view.empty:SetActive(isEmpty)
end

function M:_ShowRightPanel()
    if self.m_isDecompose then
        self._view.descState:SetActive(false)
        self.m_decomposeCtrl:Enable(self.m_selectData)
    else
        self.m_decomposeCtrl:Enable(nil)
        self:_ShowItemDesc()
    end
end

function M:_SetSubTypeState()
    local state = self.m_curTabType == BagConst.TabType.PLOT
    self._view.filter:SetActive(state)
    local offset = self.m_subTabNode.offsetMax
    if state then
        offset.y = -208
    else
        offset.y = -148
    end
    self.m_subTabNode.offsetMax = offset
end

function M:_TimeFormat(timer)
    local hours = math.modf(timer / 3600)
    timer = timer % 3600
    local minute = math.modf(timer / 60)
    timer = timer % 60
    return sfmt("%02d:%02d:%02d", hours, minute, timer)
end

return M
