local M = BaseClass("BossWarReadyUICtrl", BaseUICtrl)
local EventName = UIMessageNames.BOSS_WORDS_REFRESH

function M:Init()
    self.m_onWordsHandler = Bind(self, self.OnRefreshWordsState)
    self._view.btn_map:onClick(Bind(self, self.OnClickMap))
    self._view.btn_words:onClick(Bind(self, self.OnClickWords))
    self._view.btn_battle:onClick(Bind(self, self.OnClickBattle))
    self._view.btn_monster:onClick(Bind(self, self.OnClickMonster))
    self.m_onRefreshWords = EventMgr:AddListener(EventName, self.m_onWordsHandler)
end

function M:OnEnter(data, idx)
    self.m_data = data -- BossWarData
    self.m_index = idx
    self.m_mission = data:MissionCfg()
    self._view.img_head:SetPic(data:BossIcon())
    self._view.txt_name:SetText(data:BossName())
    self._view.img_map:SetPic(self.m_mission.map)
    self._view.txt_tips:SetText(data:MissionDesc())
    self._view.lvState:SetState(data:BattleLevel())
    self._view.txt_index:SetText(string.format("%02d", idx))
    self._view.txt_times:SetText(tostring(data:RemainBattleTimes()))
    self._view.txt_recLevel:SetText(tostring(self.m_mission.showLv))

    self:OnRefreshWordsState()
    local curStage, stageNum, percent = data:BloodStage()
    local bloodStr = string.format("%d<size=24>%%</size>", percent)
    MissionHelper.SetBossBloodBar(self._view.img_hpBar, curStage + 1)
    MissionHelper.SetBossBloodBar(self._view.img_barFill, curStage)
    self._view.img_barFill:SetFillAmount(percent / 100)
    self._view.txt_lNum:SetText(tostring(stageNum - curStage))
    self._view.txt_rNum:SetText(tostring(stageNum))
    self._view.txt_blood:SetText(bloodStr)
end

function M:OnDispose()
    EventMgr:RemoveListener(EventName, self.m_onRefreshWords)
    self.m_data = nil
    self.m_index = nil
    self.m_mission = nil
    self.m_onRefreshWords = nil
    self.m_onWordsHandler = nil
    M.super.OnDispose(self)
end

function M:OnClickMap(go)
    if not self.m_mission then return end
    UIContextMgr:GetInstance():Show("MissionMapUI", self.m_mission.map)
end

function M:OnClickWords(go)
    UIContextMgr:GetInstance():Show("BossWarWordsUI", self.m_data, self.m_onWordsHandler)
end

function M:OnClickBattle(go)
    if self.m_data:RemainBattleTimes() <= 0 then
        GameHelper.TipsById(1309) -- 今日战斗次数已用完，请明日再来！
        return
    end
    BossWarTeamMgr:GetInstance():SetBossData(self.m_data)
    UIContextMgr:GetInstance():Show(
        UIDefine.UITeamConfig,
        false,
        self.m_mission.id,
        EnumConst.TeamConfigStyle.Battle,
        0,
        EnumConst.EBattleStyle.Boss
    )
end

function M:OnClickMonster(go)
    if not self.m_mission then return end
    UIContextMgr:GetInstance():Show("MonsterInfoUI", self.m_mission.Stage)
end

function M:OnRefreshWordsState()
    self._view.wordsState:SetState(self.m_data:TakeWordSize() + 1)
end

return M
