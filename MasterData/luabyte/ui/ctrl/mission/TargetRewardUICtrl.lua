local M = BaseClass("TargetRewardUICtrl", BaseUICtrl)

function M:Init()
    self.m_itemList = {}
    self.m_initCount = 1 -- 限制OnEnter重复进入
    self._view.closeBtn:onClick(Bind(self, self.Close))
    local msgId = Proto.MessageId.ResponseChapterAward
    local hander = Bind(self, self.OnResponseChapterAward)
    self.m_rsChapterAward = NetPack:RegistResponse(msgId, hander)
    local msgId2 = Proto.MessageId.ResponseWantedBattleReward
    local handler = Bind(self, self.OnRsWantedBattleReward)
    self.m_rsWantedReward = NetPack:RegistResponse(msgId2, handler)
end

-- {
--     LeftStr = "",        -- 标题左边部分
--     RightStr = "",       -- 标题右边部分
--     IsAccept = false,    -- 是否领取
--     IsAward = false,     -- 是否可领
--     IdArr = nil,         -- 道具ID数组
--     NumArr = nil,        -- 道具数量数组
--     ClickFun = nil,      -- 点击领奖回调函数
-- }
function M:OnEnter(awardDatas)
    if self.m_initCount > 1 then return end
    self.m_initCount = self.m_initCount + 1

    local TOTLE = ItemNumberType.TOTLE
    for i, data in ipairs(awardDatas) do
        local item = self._view.rewardItem:Instantiate()
        if data.IsAccept then
            -- 3.已领取
            item.itemState:SetState(3)
        elseif data.IsAward then
            -- 2.可领取
            item.itemState:SetState(2)
        else
            -- 1.未领取
            item.itemState:SetState(1)
        end

        for j = 1, (data.IdArr and #data.IdArr) or 0, 1 do
            local itemPfb = item.rewardItem:Instantiate()
            local itemId = data.IdArr[j]
            local itemCnt = data.NumArr[j]
            itemPfb:SetInfo(itemId, TOTLE, itemCnt)
            itemPfb:EnablePopItem(true)
        end

        item.rewardItem:SetActive(false)
        item.targetNum:SetText(data.RightStr)
        item.btn_get:onClick(data.ClickFun)
        item.number:SetText(data.LeftStr)
        self.m_itemList[i] = item
    end

    self._view.rewardItem:SetActive(false)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:OnDispose()
    local msgId = Proto.MessageId.ResponseChapterAward
    NetPack:UnRegistResponse(msgId, self.m_rsChapterAward)
    local msgId2 = Proto.MessageId.ResponseWantedBattleReward
    NetPack:UnRegistResponse(msgId2, self.m_rsWantedReward)

    for _, item in pairs(self.m_itemList) do
        item:OnDispose()
    end
    self.m_itemList = nil

    M.super.OnDispose(self)
end

function M:OnResponseChapterAward(_, result, msg)
    if result ~= 0 then return end

    local item = self.m_itemList[msg.Idx + 1]
    if item then item.itemState:SetState(3) end
end

function M:OnRsWantedBattleReward(_, result, msg)
    if result ~= 0 then return end

    for i, item in pairs(self.m_itemList) do
        if ((msg.RewardMask >> i) & 1) == 1 then
            item.itemState:SetState(3)
        end
    end
end

return M
