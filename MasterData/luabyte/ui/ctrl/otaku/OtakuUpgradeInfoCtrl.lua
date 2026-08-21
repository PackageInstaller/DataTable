local M = BaseClass("OtakuUpgradeInfoCtrl")
local addPath = "UI/SpritePics/common/RomanNum/ui_formation_text_%d.png"
local OtakuRoomType = OtakuType.OtakuRoomType

function M:__init(view)
    self._view = view
    self.m_callback = nil
    self.m_roomData = nil
    self.m_bridgeLevel = 0
    self._view.btn_upgrade:onClick(Bind(self, self.OnUpgradeClick))
    self._view.currency:SetChangeState(true, Bind(self, self.OnItemChanged))
    self._view.cabinList:Init(require("UI.Ctrl.Bridge.BridgeUpgradeItemCtrl"), require("UI.View.Bridge.BridgeUpgradeItemView"))
    self._view.costList:Init(require("UI.Ctrl.Common.CommonItemCtrl"), require("UI.View.Common.ItemPfbView"))
    self._view.itemBigList:Init(require("UI.Ctrl.Common.CommonItemCtrl"), require("UI.View.Common.ItemPfbView"))
    self._view.gridKitChen:Init(require("UI.Ctrl.Bridge.KitChenItemCtrl"), require("UI.View.Bridge.KitChenItemView"))
end

function M:OnDispose()
    self.m_roomData = nil
    self.m_callback = nil
    self.m_bridgeLevel = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:ShowUpgradeInfo(roomData, callback)
    self.m_roomData = roomData
    self.m_callback = callback
    local level = self.m_roomData:Level()
    local roomType = self.m_roomData:Type()
    local maxLevel = self.m_roomData:MaxLevel()
    local lvTips = ConfigHelper.GetLocalString(5627)
    local upState = OtakuHelper.CheckRoomUpState(self.m_roomData)
    local itemInfos, coinInfo = self.m_roomData:GetUpgradeConsumeData(level)
    self.m_bridgeLevel = OtakuRoomDataMgr:GetInstance():GetBridgeCenterLevel(roomType, level + 1)
    self._view.txt_lvTips:SetText(string.format(lvTips, self.m_bridgeLevel))
    self._view.currency:SetItemById(coinInfo.itemId, coinInfo.itemNum)
    self._view.barDots:Update(level, maxLevel, true)
    self._view.costList:SetDataList(itemInfos)
    self._view.roomUiState:SetState(roomType)
    self._view.btn_upgrade:SetState(upState)
    self:_SetUpgradeContent(roomType)
end

function M:OnItemChanged()
    if not self.m_roomData then
        return
    end
    self._view.btn_upgrade:SetState(OtakuHelper.CheckRoomUpState(self.m_roomData))
end

function M:OnUpgradeClick()
    local upState = self._view.btn_upgrade:GetState()
    if upState == OtakuType.UpgradeState.Available then
        OtakuRoomDataMgr:GetInstance():RequestStudioUpgrade(self.m_roomData:RoomId(), self.m_callback)
    elseif upState == OtakuType.UpgradeState.LessConsume then
        GameHelper.TipsById(5445) -- 材料不足
    elseif upState == OtakuType.UpgradeState.LessBridgeLv then
        local lvTips = ConfigHelper.GetLocalString(5627)
        GameHelper.Tips(string.format(lvTips, self.m_bridgeLevel))
    end
end

function M:_SetUpgradeContent(roomType)
    if roomType == OtakuRoomType.EST_Bridge then
        self:_BridgeCabinContent()
    elseif roomType == OtakuRoomType.EST_Produce then
        self:_ProduceCabinContent()
    elseif roomType == OtakuRoomType.EST_Communication then
        self:_CommunicationCabinContent()
    elseif roomType == OtakuRoomType.EST_Dormitory then
        self:_DormitoryCabinContent()
    elseif roomType == OtakuRoomType.EST_Canteen then
        self:_CanteenCabinContent()
    elseif roomType == OtakuRoomType.EST_Compose then
        self:_ComposeCabinContent(OtakuType.MakeType.ComposeCabin)
    elseif roomType == OtakuRoomType.EST_Survey then
        self:_SurveyCabinContent()
    elseif roomType == OtakuRoomType.EST_Kitchen then
        self:_KitChenContent()
    end
end

-- 舰桥主界面
function M:_BridgeCabinContent()
    local level = self.m_roomData:Level()
    local index = self.m_roomData:RoomIndex() == 0 and 1 or self.m_roomData:RoomIndex()
    local data = self:_GetUnlockAssignSlotData()
    local cabinsData = OtakuRoomDataMgr:GetInstance():GetBridgeUpUnlockList(level, index)
    if data then
        table.insert(cabinsData, data)
    end
    self._view.cabinList:SetDataList(cabinsData)
    -- self._view.upItem.txt_label:SetText(5596) -- 其他舱室等级上限增加
    -- self._view.upItem.img_number:SetPic(string.format(addPath, 1))
end

function M:_ProduceCabinContent()
    local data = self:_GetUnlockAssignSlotData()
    if data then
        self._view.cabinList:SetDataList({data})
    else
        self._view.cabinParent:SetActive(false)
    end

    -- 制造效率 start   (向下取整)
    local curScale = self.m_roomData:CurMakeScale()
    local nextScale = self.m_roomData:NextMakeScale()
    self._view.makeScale:SetActive(curScale < nextScale)
    self._view.makeScale.txt_left:SetText(math.floor(curScale / 100) .. '%')
    self._view.makeScale.txt_right:SetText(math.floor(nextScale / 100) .. '%')
    -- 制造效率 end

    self:_ComposeCabinContent(OtakuType.MakeType.MakeCabin)
end

function M:_CommunicationCabinContent()
    -- body
end

function M:_DormitoryCabinContent()
    -- body
end

-- 餐厅
function M:_CanteenCabinContent()
    local level = self.m_roomData:Level()
    local houseLevels = ConfigHelper.GetCfgsByLua("houseLevel", {type=OtakuRoomType.EST_Canteen, level=level})
    local houseNextLevels = ConfigHelper.GetCfgsByLua("houseLevel", {type=OtakuRoomType.EST_Canteen, level=level + 1})

    if not houseLevels or #houseLevels <= 0 then
        Logger.LogError("houseLevel 餐厅配置错误")
        return
    end

    if not houseNextLevels or #houseNextLevels <= 0 then
        Logger.LogError("houseLevel 餐厅配置错误")
        return
    end

    local data, index = {}, 1

    if houseLevels[1].seatLimit < houseNextLevels[1].seatLimit then
        data[index] = {roomName=5622, curMaxNum=houseLevels[1].seatLimit, nextMaxNum=houseNextLevels[1].seatLimit}
        index = index + 1
    end

    self._view.cabinList:SetDataList(data)

    local cleanTime = houseNextLevels[1].cleanTime
    local strCleanTimer = TimeUtil.SecToStringFormat(cleanTime)
    self._view.labCookTimer:SetText(strCleanTimer)
    self._view.layGroupCook.enabled = true
end

function M:_ComposeCabinContent(makeType)
    local level = self.m_roomData:Level()
    local makeItems = OtakuRoomDataMgr:GetInstance():GetMakeItemsByLv(level + 1, makeType)
    local listDatas = {}

    for _, makeItem in ipairs(makeItems) do
        table.insert(listDatas, {itemId=makeItem.item, numType=ItemNumberType.NONE, itemNum=makeItem.itemNum})
    end

    self._view.itemBigList:SetDataList(listDatas)
end

function M:_SurveyCabinContent()
    local curLevel = self.m_roomData:Level()
    local curNum = OtakuRoomDataMgr:GetInstance():GetSurveyNumLimit(curLevel)
    local nextNum = OtakuRoomDataMgr:GetInstance():GetSurveyNumLimit(curLevel + 1)
    if curNum < nextNum then
        local num = nextNum - curNum
        self._view.upNode:SetActive(true)
        self._view.upItem.txt_label:SetText(5666) -- 任务上限增加
        self._view.upItem.img_number:SetPic(string.format(addPath, num))
    else
        self._view.upNode:SetActive(false)
    end
    local listDatas = self.m_roomData:GetShowRewardData()
    self._view.itemBigList:SetDataList(listDatas)
end

function M:_KitChenContent()
    local curLevel = self.m_roomData:Level()
    local menus = ConfigHelper.GetCfgs("menu")
    local listDatas = {}
    local index = 1
    for _, menu in pairs(menus) do
        if menu.houseLevel == curLevel + 1 then
            local tempData = {}
            tempData.id = menu.id
            tempData.name = menu.name
            listDatas[index] = tempData
            index = index + 1
        end
    end

    self._view.gridKitChen:SetDataList(listDatas)
end

-- 解锁指派槽位数据
function M:_GetUnlockAssignSlotData()
    local nowSlotNum = self.m_roomData:RoleDeployMaxNum()
    local nextSlotNum = self.m_roomData:NextRoleDeployMaxNum()
    if nowSlotNum < nextSlotNum then
        return { -- roomIcon,
        roomName=5560, -- 入驻位增加
        curMaxNum=nowSlotNum, nextMaxNum=nextSlotNum}
    end
    return nil
end

return M
