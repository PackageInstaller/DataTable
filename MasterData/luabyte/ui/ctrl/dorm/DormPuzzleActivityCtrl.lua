local DormPuzzleActivityCtrl = BaseClass("DormPuzzleActivityCtrl", BaseUICtrl)
local M = DormPuzzleActivityCtrl

function M:Init()
    self.cardCtls = {}
    self.rewardCtls = {}
    for i = 1, 9 do
        local ctrl = require("UI.Ctrl.Dorm.DormPuzzleItemCtrl").New(self._view["Puzzle"..i])
        table.insert(self.cardCtls, ctrl)
    end
    for i = 1, 6 do
        local ctrl = require("UI.Ctrl.Dorm.DormPuzzleRewardItemCtrl").New(self._view["Btn"..i])
        table.insert(self.rewardCtls, ctrl)
    end
    self._view.EnvelopeBtn.transform:onClick(Bind(self, self.OnClickEnvelope))
    self._view.ShopBtn.transform:onClick(Bind(self, self.OnClickShop))
    self.updateRedPointCallback = EventMgr:AddListener(UIMessageNames.DORM_PUZZLE_ACTIVE, Bind(self, self.FlipCardActiveCallback))
    self.activityId = DormPuzzleActivityDataMgr:GetInstance().activityId
    self.envelopeBtnRect = self._view.EnvelopeBtn.transform:rectTransform()
end

function M:OnClickShop(go)
    UIContextMgr:GetInstance():Show("DormPuzzleShop",Bind(self,self.OnEnter))
end

function M:OnClickEnvelope(go)
    if not self.envelopeData.canReward and not self.envelopeData.isReward then
        if self.envelopeBtnTween then
            return
        end
        self.envelopeBtnTween = self.envelopeBtnRect:SetDoShakePosition(1.5, 5, 4)
        self.envelopeBtnTween:OnTweenComplete(function() self.envelopeBtnTween = nil end)
        GameHelper.TipsById(1316)
        return
    end

    if self.envelopeData.canReward and not self.envelopeData.isReward then
        ActivityDataMgr:GetInstance():SendCommonReward(self.activityId, {self.envelopeData.cfg.rewardChildId}, Bind(self, self.RewardCallback))
    end
end

function M:RewardCallback(data)
    GameHelper.ShowGetItems(data)
    self.envelopeData.canReward = false
    self.envelopeData.isReward = true
    EventMgr:Broadcast(UIMessageNames.ACTIVITY_COMMON_REWARD, data)
    self._view.EnvelopeBtnAnimator:Play("Normal")
    self._view.EnvelopeImage.gameObject:SetActive(true)
    IRedPointMgr:ForceCheck(RedPointConst.DormPuzzleRedPointChecker)
end

function M:OnEnter()
    for key, value in pairs(self.cardCtls) do
        local data = DormPuzzleActivityDataMgr:GetInstance():GetCardByGroupChildId(value._view.groupChildId)
        value:UpdateData(data)
    end
    for key, value in pairs(self.rewardCtls) do
        local data = DormPuzzleActivityDataMgr:GetInstance():GetRewardByRewardChildId(value._view.rewardChildId)
        value:UpdateData(data)
    end
    self:SetEnvelope()
end

function M:SetEnvelope()
    self.envelopeData = DormPuzzleActivityDataMgr:GetInstance():GetRewardByRewardChildId(7)
    self.activeNum = DormPuzzleActivityDataMgr:GetInstance():GetActiveNum()
    self._view.EnvelopeText:SetText(self.activeNum.."")
    if self.envelopeData.canReward and not self.envelopeData.isReward then
        self._view.EnvelopeBtnAnimator:Play("Reward")
    end

    if self.envelopeData.isReward then
        self._view.EnvelopeImage.gameObject:SetActive(true)
    end
end 

function M:FlipCardActiveCallback()
    self.activeNum = DormPuzzleActivityDataMgr:GetInstance():GetActiveNum()
    for key, value in pairs(self.rewardCtls) do
        local data = DormPuzzleActivityDataMgr:GetInstance():GetRewardByRewardChildId(value._view.rewardChildId)
        value:UpdateData(data)
    end
    if self.activeNum == 9 then
        --播放获得动画
        local res = DormPuzzleActivityDataMgr:GetInstance():GetActivityRoomFlipCfg().image
        UIContextMgr:GetInstance():Show("DormShowGirlUI", res, Bind(self, self.SetEnvelope))
    else
        self:SetEnvelope()
    end
end 

function M:OnClose()
end

function M:OnBack()
    self:Close()
    UIContextMgr:GetInstance():Show("Dorm")
end

function M:OnDispose()
    for key, value in pairs(self.rewardCtls) do
        value:OnDispose()
    end
    for key, value in pairs(self.cardCtls) do
        value:OnDispose()
    end
    self.cardCtls = {}
    self.rewardCtls = {}
    EventMgr:RemoveListener(UIMessageNames.DORM_PUZZLE_ACTIVE, self.updateRedPointCallback)
    M.super.OnDispose(self)
end

return DormPuzzleActivityCtrl