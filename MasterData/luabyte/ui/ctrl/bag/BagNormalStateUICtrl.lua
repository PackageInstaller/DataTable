local BagNormalStateUICtrl = BaseClass("BagNormalStateUICtrl")
local M = BagNormalStateUICtrl

function M:__init(view)
    self._view = view
    self._tabLabel = {
        ConfigHelper.GetLocalString(BagConst.Tab.ITEM.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.NURTURE.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.Nameplate.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.FOODS.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.PLOT.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.FURNITURE.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.CHIPS.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.FAVOR.labels),
    }
    self._tabLabelEn = {
        ConfigHelper.GetLocalString(BagConst.Tab.ITEM.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.NURTURE.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.Nameplate.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.FOODS.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.PLOT.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.FURNITURE.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.CHIPS.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.FAVOR.labelsEn),
    }
    self._tabTypes = {
        BagConst.TabType.ITEM,
        BagConst.TabType.NURTURE,
        BagConst.TabType.Nameplate,
        BagConst.TabType.FOODS,
        BagConst.TabType.PLOT,
        BagConst.TabType.FURNITURE,
        BagConst.TabType.CHIPS,
        BagConst.TabType.FAVOR
    }
    self._tabIcons = {
        "UI/SpritePics/warehouse/ui_warehouse_icon_01", -- 道具
        "UI/SpritePics/warehouse/ui_warehouse_icon_02", -- 养成
        "UI/SpritePics/warehouse/ui_warehouse_icon_08", -- 铭牌
        "UI/SpritePics/warehouse/ui_warehouse_icon_03", -- 料理
        "UI/SpritePics/warehouse/ui_warehouse_icon_04", -- 剧情
        "UI/SpritePics/warehouse/ui_warehouse_icon_05", -- 家具
        "UI/SpritePics/warehouse/ui_warehouse_icon_06", -- 碎片
        "UI/SpritePics/warehouse/ui_warehouse_icon_07", -- 好感
    }

    self._curTabType = 0
    self._tab = self._view.tab
end

--initTab 默认显示页签
--列表变化时回调
function M:SetTab(initTab, initCallback)
    self._curTabType = initTab
    self._tab:InitIconItems(
        initTab - 1,
        self._tabLabel,
        self._tabLabelEn,
        self._tabIcons,
        function(idx)
            local tabIdx = idx + 1
            local tabType = self._tabTypes[tabIdx]
            self._curTabType = tabType
            EventMgr:Broadcast(UIMessageNames.BAG_TYPE_TABLE_CHANGE, self._curTabType)
        end
    )

    if initCallback == nil then initCallback = true end
    self._tab:SetIndex(initTab - 1, initCallback)

    for i = 0, #self._tabLabel - 1 do
        local item = self._tab:GetTabItem(i)
        item:SetRedPointParam(0, (i + 1))
        item:RedPointCheck()
    end
end

function M:CheckRedPoint(tabIndex)
    local idx = tabIndex - 1
    self._tab:SetRedPointCheck(idx)
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return BagNormalStateUICtrl
