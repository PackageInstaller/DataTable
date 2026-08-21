local M = BaseClass("OtakuManufacturingCabinCtrl", BaseUICtrl)
local tabCtrl = require("UI.Ctrl.Create.OtakuManufacturingTabItemCtrl")
local fmtImgPath = "UI/SpritePics/common/RomanNum/ui_formation_text_%d.png"
local roomType = OtakuType.OtakuRoomType.EST_Produce

function M:Init()
    local view = require("UI.View.Create.OtakuManufacturingItemView")
    local ctrl = require("UI.Ctrl.Create.OtakuManufacturingItemCtrl")

    self.m_tabIndex = 0 -- 页签索引
    self.m_selectNum = 0 -- 选中的数量
    self.m_roomData = nil
    self.m_selectData = nil
    self.m_isNotify = false
    self.m_roomItems = {} -- ui数组
    self.m_roomDatas = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(roomType) -- 数据数组
    self.m_maxRoomNum = OtakuRoomDataMgr:GetInstance():GetMaxRoomBuildNumByType(roomType)
    self.m_costList = { self._view.costItem1, self._view.costItem2, self._view.costItem3 }
    self._view.makeList:Init(ctrl, view)
    self._view.btn_make:onClick(Bind(self, self.OnClickStartMake))
    self._view.makeList:SetCreateItemCallback(Bind(self, self.OnCreatMakeItem))
    self._view.numberBar:SetNumChangedCallback(Bind(self, self.OnMakeNumChanged))
    for _, item in ipairs(self.m_costList) do
        item:EnablePopItem(true)
        item:OnNumChanged(Bind(self, self.OnNotifyMakeChanged))
    end
    self.m_onTabSelect = Bind(self, self.OnTabSelected)
    self.m_onBridgeUpgrade = EventMgr:AddListener(UIMessageNames.OTAKU_UPGRADE, Bind(self, self.OnBridgeUpgradeEvent))
    self.m_onMakeChanged = EventMgr:AddListener(UIMessageNames.CREATE_UPDATE_ROOM, Bind(self, self.OnNotifyMakeChanged))
end

function M:OnEnter(roomData)
    local tabView = self._view.tabItem
    local roomId = roomData:RoomId()
    local str = ConfigHelper.GetLocalString(5551) -- 制造舱%02d
    for i = 1, self.m_maxRoomNum, 1 do
        local rmData = self.m_roomDatas[i]
        local tabItem = self.m_roomItems[i]
        if not tabItem then
            tabItem = tabCtrl.New(tabView:Instantiate())
            self.m_roomItems[i] = tabItem
        end
        local title = string.format(str, i)
        local path = string.format(fmtImgPath, i)
        tabItem:InitTabItems(i, rmData, title, path, self.m_onTabSelect)
        if rmData and (roomId == rmData:RoomId()) then self.m_tabIndex = i end
    end
    tabView:SetActive(false)
    self:_SetTabIndex(self.m_tabIndex)
end

--点击设置退出键【关闭带顶栏的Normal窗口】
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true 
end

function M:OnDispose()
    for _, item in pairs(self.m_roomItems) do
        item:OnDispose()
    end
    for _, item in ipairs(self.m_costList) do
        item:DoDispose()
    end
    self.m_roomItems = nil
    self.m_costList = nil
    EventMgr:RemoveListener(UIMessageNames.OTAKU_UPGRADE, self.m_onBridgeUpgrade)
    EventMgr:RemoveListener(UIMessageNames.CREATE_UPDATE_ROOM, self.m_onMakeChanged)
    self.m_roomData = nil
    self.m_roomDatas = nil
    self.m_selectData = nil
    M.super.OnDispose(self)
end

function M:OnCreatMakeItem(ctrl)
    ctrl:SetSelectCallback(
        Bind(self, self.OnSelectItem),
        Bind(self, self.OnSetItemTime)
    )
end

-- 点击制造道具
function M:OnSelectItem(data)
    self:_UpdateSelectData(data)
    self:_UpdateMakeBlock()
    self._view.makeList:UpdateList()
end

function M:OnTabSelected(index)
    self.m_tabIndex = index
    self.m_roomData = self.m_roomDatas[self.m_tabIndex]
    self._view.ctrlTitle:Init(self.m_roomData)
    self._view.ctrlSettle:Init(self.m_roomData)
    for i = 1, self.m_maxRoomNum, 1 do
        self.m_roomItems[i]:UpdateState(i == self.m_tabIndex)
    end
    self:_UpdateMakeList()
end

function M:OnMakeNumChanged(num)
    self.m_selectNum = num
    local makeItem = self.m_selectData.Config
    local isMaking = self.m_selectData.RoomData ~= nil
    local costItem, costNum = makeItem.costItem, makeItem.costNum
    for i, item in ipairs(self.m_costList) do
        local itemId = costItem[i]
        if itemId and (itemId > 0) then
            item:SetActive(true)
            local totalNum = costNum[i] * self.m_selectNum
            if isMaking then
                item:SetInfo(itemId, ItemNumberType.FRACTION, costNum[i], totalNum)
            else
                item:SetInfo(itemId, ItemNumberType.BALANCE, totalNum)
            end
        else
            item:SetActive(false)
        end
    end

    local makeItemNum = self.m_selectNum * makeItem.itemNum
    self._view.txt_num:SetText(tostring(makeItemNum))
    local makeItemTime = makeItem.costTime * self.m_selectNum
    local fmtTime = TimeUtil.SecToStringFormat(makeItemTime)
    self._view.txt_time:SetText(fmtTime)
end

-- 开始制造
function M:OnClickStartMake(go)
    if not self.m_selectData.Unlock then
        GameHelper.TipsById(5548) -- 未解锁！
        return
    end

    local makeItem = self.m_selectData.Config
    local maxMakeNum = OtakuHelper.GetMaxMakeNum(makeItem, 0)
    if maxMakeNum <= 0 then
        GameHelper.TipsById(5550) --制造数量为0！
        return
    end

    if self.m_roomData:CurRoleLiveNum() == 0 then
        GameHelper.TipsById(468) --请先入驻战员
        return
    end

    local request = {
        StudioId = self.m_roomData:RoomId(),
        MakeItemId = self.m_selectData.ItemId,
        MakeNum = self.m_selectNum,
    }
    if self.m_roomData:IsRoomMaking() then
        GameHelper.Confirm(ConfigHelper.GetLocalString(5562), function(ok)
            if ok then OtakuRoomDataMgr:GetInstance():RqStudioProduce(request) end
        end)
    else
        OtakuRoomDataMgr:GetInstance():RqStudioProduce(request)
    end
end

-- 制造数据变化，刷新UI
function M:OnNotifyMakeChanged(_, _, _)
    self.m_isNotify = true
    self:_SetTabIndex(self.m_tabIndex)
end

function M:OnSetItemTime(fmtTime, isStop)
    self._view.txt_stop:SetActive(isStop)
    self._view.txt_makeTime:SetText(fmtTime)
    self._view.txt_normal:SetActive(not isStop)
end

function M:OnBridgeUpgradeEvent(roomId)
    if self.m_roomData:RoomId() == roomId then
        self.m_isNotify = true
        self:_SetTabIndex(self.m_tabIndex)
    end
end

function M:_UpdateMakeList()
    local datalist, roomLv = {}, self.m_roomData:Level()
    local makeItemId = self.m_roomData:MakeItemId()
    local list = OtakuRoomDataMgr:GetInstance():GetMakeItemList()
    if not self.m_isNotify then self.m_selectData = nil end
    for _, cfg in ipairs(list) do
        local makeId = cfg.id
        local isCurMake = makeItemId == makeId
        local data = {
            Config = cfg,
            IsSelect = false,
            ItemId = makeId,
            Unlock = roomLv >= cfg.houseLimit,
            RoomData = isCurMake and self.m_roomData or nil,
        }

        if self.m_selectData then
            if (self.m_selectData.ItemId == makeId) and self.m_isNotify then
                self:_UpdateSelectData(data)
            end
        else
            if isCurMake then self:_UpdateSelectData(data) end
        end
        table.insert(datalist, data)
    end

    -- 已解锁 ＞ 未解锁，相同状态按照order字段由小到大排
    table.sort(datalist, function(a, b)
        if a.Unlock == b.Unlock then return a.Config.order < b.Config.order end
        return a.Unlock
    end)

    self.m_isNotify = false
    self._view.makeList:SetDataList(datalist)
    self:_UpdateMakeBlock()

    if self.m_roomData:IsRoomMaking() then
        local makeItem = ConfigHelper.GetCfgByLua("makeItem", makeItemId) or {}
        local itemCfg = ConfigHelper.GetCfgByLua("item", makeItem.item) or {}
        local makeItemNum = self.m_roomData:MakeItemNum() * makeItem.itemNum
        self._view.img_makeIcon:SetPic(itemCfg.icon)
        self._view.txt_makeName:SetText(itemCfg.name)
        self._view.txt_makeNum:SetText(tostring(makeItemNum))
    end
end

function M:_SetTabIndex(idx)
    for _, item in pairs(self.m_roomItems) do
        item:UpdateTab(idx)
    end
end

-- 更新选中数据
function M:_UpdateSelectData(data)
    if self.m_selectData then
        self.m_selectData.IsSelect = false
    end

    self.m_selectData = data

    if self.m_selectData then
        self.m_selectData.IsSelect = true
    end
end

-- 更新制造区域
function M:_UpdateMakeBlock()
    if not self.m_selectData then
        self._view.uiState:SetState(1) -- 空闲中
        return
    end

    local makeItem = self.m_selectData.Config
    local itemCfg = ConfigHelper.GetCfgByLua("item", makeItem.item) or {}
    self._view.img_icon:SetPic(itemCfg.icon)
    self._view.txt_name:SetText(itemCfg.name)
    if self.m_selectData.RoomData then -- 只显示自己房间
        self._view.uiState:SetState(2) -- 制作中
        local makingNum = self.m_roomData:MakeItemNum()
        self._view.numberBar:SetNumBarInfo(makingNum, makingNum, makingNum)
    else
        if self.m_roomData:IsRoomMaking() then
            self._view.uiState:SetState(3) -- 替换
        else
            self._view.uiState:SetState(4) -- 准备制作
        end
        -- 非制造中必然制造数量为0
        local maxMakeNum = OtakuHelper.GetMaxMakeNum(makeItem, 0)
        self._view.numberBar:SetNumBarInfo(1, maxMakeNum, 1)
    end
end

return M
