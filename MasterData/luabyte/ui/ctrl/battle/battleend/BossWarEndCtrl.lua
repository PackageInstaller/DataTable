local M = BaseClass("BossWarEndCtrl")

function M:__init(view)
    self._view = view
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:Refresh(bossInfo, bossData)
    local count, curStage = bossData:BloodCount(), bossInfo.bossPlan
    local remain, percent = count - curStage, bossInfo.curPlaneHpPercentage
    MissionHelper.SetBossBloodBar(self._view.img_hpBar, curStage + 1)
    MissionHelper.SetBossBloodBar(self._view.img_hpFill, curStage)
    self._view.txt_blood:SetText(string.format("%d%%", percent))
    self._view.img_hpFill:SetFillAmount(percent / 100)
    self._view.txt_name:SetText(bossData:BossName())
    self._view.txt_lNum:SetText(tostring(remain))
    self._view.txt_rNum:SetText(tostring(count))
    self._view.img_hpBar:SetEnable(remain > 0)
end

return M
