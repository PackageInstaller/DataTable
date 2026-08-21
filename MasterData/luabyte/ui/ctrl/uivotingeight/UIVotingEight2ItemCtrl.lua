local UIVotingEight2ItemCtrl = BaseClass("UIVotingEight2ItemCtrl", UIBaseComponent)
local M = UIVotingEight2ItemCtrl

function M:__init()
    self._view.imageIcon:onClick(Bind(self, self.OnBtnClick))
    self._view.btnVote:onClick(Bind(self, self.OnBtnHeroClick))
end

function M:UpdateData(data)
    self.data = data
    self.heroId = data.HeroId
    self._view.textName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    self._view.textTicket:SetText(tostring(data.Ticket))
    self._view.imageIcon:SetShowHalf(self.heroId, RoleType.ERT_Hero, 1)
end

function M:OnBtnClick()
    if self.heroId > 0 then
        EventMgr:Broadcast(UIMessageNames.VOTING_SELECTHERO2, self.heroId)
    end
end

function M:OnBtnHeroClick()
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingVote, self.heroId, self.data.Ticket)
end

return UIVotingEight2ItemCtrl
