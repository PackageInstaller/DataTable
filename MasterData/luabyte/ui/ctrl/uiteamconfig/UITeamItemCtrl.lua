local UITeamItemCtrl = BaseClass("UITeamItemCtrl", BaseUICtrl)
local M = UITeamItemCtrl

function M:__init(view)
    self._view = view
    self._view.inputField:onEndEdit(Bind(self, self._OnTeamNameChange))
end

function M:UpdateData(data)
    self._index = data
    self:UpdataName()
end


function M:UpdataName()
    local teamName = GlobalTeamConfMgr:GetInstance().Mgr:GetTeamName(self._index)
    self._view.inputField:SetText(teamName)
    self._view.labOff:SetText(teamName)
    self._view.labOn:SetText(teamName)

end

function M:_OnTeamNameChange(name)
    if not name or #name <= 0 then
        GameHelper.TipsById(4164)
        self:UpdataName()
        return
    end
    if ConfigHelper.CheckBlockWord(name) then
        GameHelper.TipsById(666)
        self:UpdataName()
        return
    end
    local teamData = GlobalTeamConfMgr:GetInstance().Mgr:GetTeamById(self._index)
    teamData.Name = name
    GlobalTeamConfMgr:GetInstance().Mgr:RequestUpdateTeam(teamData)
end

return UITeamItemCtrl
