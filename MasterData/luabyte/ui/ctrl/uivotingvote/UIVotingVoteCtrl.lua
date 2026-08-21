-- baoruichang
-- 2021/12/10 15:05:34
local UIVotingVoteCtrl = BaseClass("UIVotingVoteCtrl", BaseUICtrl)
local M = UIVotingVoteCtrl
local heroIconPath = "UI/SpritePics/portrait/portrait_body/"

function M:Init()
    self._view.btnOk:onClick(Bind(self, self.OnClickVote))
    self._view.btnCancel:onClick(Bind(self, self.Close))
    self._view.btnClose:onClick(Bind(self, self.Close))
    self._view.ComNumSliderCtrl:SetChangedCallback(Bind(self, self.UpdateSelectNum))
end

-- 进入UI，可传参数
function M:OnEnter(heroId, Ticket)
    self.heroId = heroId
    self.Ticket = Ticket
    self.selectNum = 0

    self:UpdateHeroInfo()
end

function M:UpdateHeroInfo()
    self._view.textName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    
    self._view.IconHero:SetPic(heroIconPath .. self.heroId)
    self.itemID = ConfigHelper.GetCfgPropByLua("activityGirl", VotingDataMgr:GetInstance():GetActivityGirlId(), "support")
    self.num = ItemDataMgr:GetInstance():GetItemNumById(self.itemID)
    self._view.ComNumSliderCtrl:SetSliderInfo(0, self.num, 0)
    self._view.PropertyBar:Action(self.itemID)
    self._view.textTicket:SetText(tostring(self.num))
end

function M:UpdateSelectNum(num)
    self.selectNum = num
end

function M:OnClickVote()
    if self.selectNum <= 0 then
        Logger.Log("选中数量为0")
        GameHelper.TipsById(847)
        return
    end

    local data = {heroId=self.heroId, num=self.selectNum}
    EventMgr:Broadcast(UIMessageNames.VOTING_HEROVOTE, data)
end

return UIVotingVoteCtrl
