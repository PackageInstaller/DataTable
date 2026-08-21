--- 全局编队管理器，通过SetMissionType来获得继承自BaseTeamDataGetter的类对象
local M = BaseClass("GlobalTeamConfMgr", Singleton)
local EBattleStyle = EnumConst.EBattleStyle

function M:SetBattleType(battlType)
    if battlType == EBattleStyle.Encount then
        self.Mgr = EncounterConfMgr:GetInstance()
    elseif battlType == EBattleStyle.Boss then
        self.Mgr = BossWarTeamMgr:GetInstance()
    else
        self.Mgr = TeamConfMgr:GetInstance()
    end
end

return M
