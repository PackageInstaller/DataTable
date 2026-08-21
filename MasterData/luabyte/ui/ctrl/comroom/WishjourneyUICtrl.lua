local M = BaseClass("WishjourneyUICtrl", BaseUICtrl)

function M:Init()
    self.m_tipStr = ""      -- 消耗提示
    self.m_roomData = nil
    self.m_itemCtrls = {}   -- 坐标Ctrl字典
    self.m_isEnough = false -- 消耗是否足够
    self.m_refreshItem = GameHelper.GetParamters(340)
    local clickHandler = Bind(self, self.OnClickItem)
    local itemChanged = Bind(self, self.OnRefreshConsume)
    self.m_refreshHandler = Bind(self, self.OnRefreshExpMission)
    self._view.refreshBtn:onClick(Bind(self, self.OnClickRefresh)) -- 刷新按钮
    self.m_itemTag = ItemDataMgr:GetInstance():AddItemChange(self.m_refreshItem[0], itemChanged)
    self.m_onRefreshEvent = EventMgr:AddListener(UIMessageNames.EXPMISSION_REFRESH, self.m_refreshHandler)
    self.m_onBeginEvent = EventMgr:AddListener(UIMessageNames.EXPMISSION_UPDATE, Bind(self, self.OnUpdateExpMission))

    for i = 0, 15 do
        local ctrl = self._view["coordinate" .. i]
        ctrl:SetClickCallback(clickHandler)
        self.m_itemCtrls[i] = ctrl
    end
end

function M:OnEnter(roomData)
    self.m_roomData = roomData
    self._view.ctrlTitle:Init(self.m_roomData)
    self._view.consumeIcon:SetItemIcon(self.m_refreshItem[0])
    for _, taskData in pairs(self.m_roomData:GetExtraData()) do
        self:OnUpdateExpMission(taskData)
    end
    self:OnRefreshConsume()
end

function M:OnBack()
    if UIContextMgr:GetInstance():IsShow("WishjourneyEquip") then
        UIContextMgr:GetInstance():Close("WishjourneyEquip")
        return false
    else
        return true
    end
end

--点击设置退出键【关闭带顶栏的Normal窗口】
function M:OnDeviceBack()
    if UIContextMgr:GetInstance():isVisible("ComChooseHero") then
        UIContextMgr:GetInstance():Close("ComChooseHero")
        return true
    end
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnDispose()
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
    EventMgr:RemoveListener(UIMessageNames.EXPMISSION_UPDATE, self.m_onBeginEvent)
    EventMgr:RemoveListener(UIMessageNames.EXPMISSION_REFRESH, self.m_onRefreshEvent)
    self.m_itemTag = nil
    self.m_roomData = nil
    self.m_itemCtrls = nil
    self.m_onBeginEvent = nil
    self.m_onRefreshEvent = nil
    M.super.OnDispose(self)
end

-- 点击刷新按钮
function M:OnClickRefresh(go)
    -- 是否有可刷新任务
    if not self.m_roomData:IsRefreshNormal() then
        GameHelper.TipsById(4145)
        return
    end

    -- 不使用道具刷新提示
    if not self.m_isEnough then
        -- GameHelper.TipsById(4146)
        GameHelper.PopItem(self.m_refreshItem[0], 0, self._view)
        return
    end

    -- 没有高品质任务 或 不弹提示 直接刷新
    local stamp = PlayerPrefTools.GetPlayerPrefsString("ExpNoTipsToday", "0")
    local isNoTips = TimeUtil.IsToday(tonumber(stamp))
    local has4Star = self:_Check4StarTask() -- 非英雄的高品质任务
    local isQuick = isNoTips or not has4Star
    if isQuick and self.m_isEnough then
        self.m_roomData:RsRefreshExpMission(1)
        return
    end

    local tipStr = not has4Star and "" or ("\n" .. ConfigHelper.GetLocalString(824))
    -- 二次确认弹窗中玩家钻石不足时，钻石数量文字显示为红色
    GameHelper.Confirm(self.m_tipStr .. tipStr, function(ok)
        if ok then
            if self.m_isEnough then
                -- 刷新远征任务
                self.m_roomData:RsRefreshExpMission(1)
            else
                GameHelper.TipsById(4147)
            end
        end
    end, "ExpNoTipsToday")
end

function M:OnClickItem(isOver, data, selectCallback)
    if isOver then
        -- 远征完成，领取奖励
        self.m_roomData:RqAwardExpMission(data.Id, self.m_refreshHandler)
    else
        if selectCallback then selectCallback(1) end
        local parent = self._view.transform
        UIContextMgr:GetInstance():Show("WishjourneyEquip", self.m_roomData, data, selectCallback, parent)
    end
end

-- 刷新任务
function M:OnUpdateExpMission(data)
    if not data then return end

    local expMissionId = data.ConfigId or 0
    if expMissionId > 0 then
        local missionCfg = self.m_roomData:GetExpMission(expMissionId)
        self.m_itemCtrls[data.Pos]:SetData(data, missionCfg)
    else
        Logger.Log("没有新任务,关闭此槽位。 ConfigId == 0, TaskId = " .. data.Id)
    end
end

-- 移除任务
function M:RemoveTaskItem(pos)
    if self.m_itemCtrls[pos] then
        self.m_itemCtrls[pos]:ClearData()
    end
end

function M:OnRefreshConsume(_, _, _)
    local numStr, costNum = "", self.m_refreshItem[1]
    local itemData = ItemDataMgr:GetInstance():GetItemById(self.m_refreshItem[0])
    if itemData and itemData.Num >= costNum then
        self.m_isEnough = true
        numStr = tostring(costNum)
        local formatStr = ConfigHelper.GetLocalString(545)
        self.m_tipStr = string.format(formatStr, costNum)
    else
        self.m_isEnough = false
        numStr = "<color=red>" .. costNum .. "</color>"
        local formatStr = ConfigHelper.GetLocalString(546)
        self.m_tipStr = string.format(formatStr, numStr)
    end
    self._view.consumeNum:SetText(numStr)
end

-- 更新调查任务
function M:OnRefreshExpMission(oldPos, newTask)
    if oldPos then
        local isSame = self.m_itemCtrls[oldPos]:IsSameTask(newTask.Id)
        if isSame and ((oldPos ~= newTask.Pos) or newTask.ConfigId <= 0) then
            self:RemoveTaskItem(oldPos)
        end
    end
    self:OnUpdateExpMission(newTask)
end

function M:_Check4StarTask()
    for _, ctrl in pairs(self.m_itemCtrls) do
        if ctrl:Is4StarAndNoStart() then return true end
    end
    return false
end

return M
