-- OtakuemployeeOverviewItemGroup_Special
-- 餐厅专用
local OtakuOverviewItem2Ctrl = BaseClass("OtakuOverviewItem2Ctrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = OtakuOverviewItem2Ctrl
local tInsert = table.insert
local ETableState = EnumConst.ETableState
local EATPOSNUM = 8

function M:Init()
    self.m_CurIndex = 1
    self.m_LiveSpace = {}
    self._view.clickBtn:onClick(Bind(self, self._OnItemClick))
end

function M:Select()
    self._view.selectState:SetState(2)
end

function M:UnSelect()
    self._view.selectState:SetState(1)
end

function M:OpenPanel(index, data, clickCallBack)
    self.m_Index = index
    self.roomData = data
    self.m_CallBack = clickCallBack
    self:_SetRoomInfo()
    -- self:_SetLiveSpace()
    self:_SetEatSpace()
    self:UnSelect()
    self:ShowPanel()
end

function M:Refresh()
    self.roomData = OtakuRoomDataMgr:GetInstance():RoomDataByRoomId(self.roomData:RoomId())
    -- self:_SetLiveSpace()
end

function M:_SetRoomInfo()
    local name = ConfigHelper.GetLocalString(self.roomData:Name())
    name = name .. string.format("%02d", self.roomData:RoomIndex())
    self._view.nameText:SetText(name)
    self._view.numText:SetText(tostring(self.roomData:CurRoleLiveNum()))
    self._view.maxText:SetText("/" .. tostring(self.roomData:RoleLiveMaxNum() + self.roomData:GetSeatLimit() + 1))
    self._view.icon:SetPic(self.roomData:Icon())
end

-- -- 入驻信息
-- function M:_SetLiveSpace()
--     local data = self.roomData:LiveSpace()
--     data[1].curSettleType = self.roomData:SettleType()
--     self._view.OtakuemployeeOverviewItem:Update(1, data[1])
--     self._view.OtakuemployeeOverviewItem:ShowPanel()
-- end

-- 吃饭信息
function M:_SetEatSpace()
    self.dinings = self.roomData:GetDinings()

    if not self.tabRestaurantItems then
        self.tabRestaurantItems = {}
        self._view.OtakuCookHeroItemCtrl:SetActive(false)

        for i = 1, EATPOSNUM do
            local OtakuCookHeroItemCtrl = self._view.OtakuCookHeroItemCtrl:Instantiate()
            OtakuCookHeroItemCtrl:SetActive(true)
            tInsert(self.tabRestaurantItems, OtakuCookHeroItemCtrl)
        end
    end

    for i = 1, EATPOSNUM do
        local diningData = self.dinings[i]
        local nowTimer = TimeUtil.GetNowTimeStamp()
        local data = {id=i, roomIndex=self.m_Index}
        local heroId
        if self.tabRestaurantItems[i] then
            heroId = self.tabRestaurantItems[i]:GetUserId()
        end

        if diningData.state == ETableState.Cleaning then
            if diningData.EndTick <= nowTimer then
                diningData.state = ETableState.None
            end
        end
        data.state = diningData.state
        if heroId then
            data.state = ETableState.Use
            data.heroId = heroId
            data.value = 0
        end
        data.lockTips = diningData.lockTips
        data.EndTick = diningData.EndTick - nowTimer
        data.nullNum = self.roomData:GetNullPosNum()
        data.callBack = Bind(self, self._SelectHero)
        self.tabRestaurantItems[i]:UpdateData(data)
    end
end

function M:_SelectHero(heroIds)
    local nums = #heroIds
    self.heroIds = heroIds
    self.post = self.roomData:GetPos(nums)
    if nums ~= #self.post then
        Logger.Log("位置不够")
        return
    end
    RestaurantDataMgr:GetInstance():RequestInviteHeroEat(heroIds, self.post, self.roomData:RoomId(), Bind(self, self._eatCallback))
end

-- 邀请英雄Ack
function M:_eatCallback(diningTables)
    self:UpdateDinings(diningTables)
    for key, heroId in pairs(self.heroIds) do
        local pos = self.post[key] + 1
        local data = {}
        -- 使用状态
        data.state = ETableState.Use
        data.heroId = heroId
        local nowTimer = TimeUtil.GetNowTimeStamp()
        data.EndTick = self.dinings[pos].EndTick - nowTimer
        data.value = 0
        self.tabRestaurantItems[pos]:UpdateData(data)
    end
end

-- 邀请吃饭成功 更新餐桌冷却时间
function M:UpdateDinings(DiningTables)
    self.roomData:UpdateDining(DiningTables)
    self.dinings = self.roomData:GetDinings()
end

function M:_OnItemSelectClick(index)
    self.m_CurIndex = index
end

function M:_OnItemClick()
    RestaurantDataMgr:GetInstance():UpdateData(self.roomData)
    self.m_CallBack(self.roomData:RoomId(), self.roomData.m_RoomData.Type, self.roomData.m_LiveSpace)
end

function M:OnDispose()
    self.clickCallBack = nil
    self.m_Index = nil
    self.roomData = nil
    if self.tabRestaurantItems then
        for k, value in ipairs(self.tabRestaurantItems) do
            CS.UnityEngine.GameObject.Destroy(value.gameObject)
            value:OnDestroy()
        end

        self.tabRestaurantItems = nil
    end

    M.super.OnDispose(self)
end

return OtakuOverviewItem2Ctrl
