local ItemCtrl = require("UI.Ctrl.Battle.BattleResultItemCtrl")
local M = BaseClass("BattleResultCtrl", BaseUICtrl)

function M:OnEnter(isWin, loseGuide, loseDesc)
    self._view.victory:SetActive(isWin)
    self._view.fail:SetActive(not isWin)
    self._view.failText:SetText(loseDesc)

    if isWin then
        self:_RefreshWin()
        return
    end

    self:_RefreshJumpItems(loseGuide)

    self._view.LevelItem.BgPress:onClick(Bind(self, self._OnClickJumpLevelUpPage))
    self._view.SkillLevelItem.BgPress:onClick(Bind(self, self._OnClickJumpSkillLevelUpPage))
    self._view.AiLevelItem.BgPress:onClick(Bind(self, self._OnClickJumpAiLevelUpPage))
end

function M:_OnClickJumpLevelUpPage()
    GameHelper.Jump(61)
end

function M:_OnClickJumpSkillLevelUpPage()
    GameHelper.Jump(63)
end

function M:_OnClickJumpAiLevelUpPage()
    GameHelper.Jump(65)
end

function M:_RefreshWin()
    local clip = self._view.victoryAnim.runtimeAnimatorController.animationClips[0]
    self.m_timer = TimerManager:GetInstance():GetTimer(clip.length, Bind(self, self._EndTime), self, true)
    self.m_timer:Start()
end

function M:_EndTime()
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end

    self:_OnCloseClick()
end

function M:_RefreshJumpItems(loseGuide)
    local length = loseGuide.Length

    for i = 1, length do
        local item = self.m_items[i]

        if not item then
            item = self._view.jumpItem:Instantiate(self._view.jumpContent)
            item = ItemCtrl.New(item)
            self.m_items[#self.m_items + 1] = item
        end

        local index = i - 1
        item:Update(loseGuide[index])
        item:SetActive(true)
    end

    if length < #self.m_items then
        local sub = #self.m_items - length
        for i = 1, sub do
            local item = self.m_items[i + length]
            if item then
                item:SetActive(false)
            end
        end
    end
    self:SelectOpenAttributeSuggest()
end

--打开属性建议面板
function M:SelectOpenAttributeSuggest()
    local missionId = IBattle.context.missionId
    local missionCfg = ConfigHelper.GetCfg("mission", missionId)
    if not missionCfg then
        --mission表异常不显示建议等级提示
        self._view.failUiState:SetState(3)
        return
    end

    --遭遇战不显示建议等级提示
    if IBattle.context.battleStyle == CS.GameX.Battle.Battle.EbattleStyle.Reward then
        if missionCfg.loseDesc > 0 then
            self._view.failUiState:SetState(2)
        else
            self._view.failUiState:SetState(3)
        end
        return
    end

    local suggestLevel = missionCfg.showLv
    local suggestSkillLevel = missionCfg.showSkillLevel
    local suggestAiStarLevel = missionCfg.showAIStar
    local curLevel = IBattle.context.battleData:GetHeroAverageLevel()
    local curSkillLevel = IBattle.context.battleData:GetHeroSkillAverageLevel()
    local curAiStarLevel = IBattle.context.battleData:GetHeroAiAverageLevel()
    local enoughLevel = suggestLevel <= curLevel
    local enoughSkillLevel = suggestSkillLevel <= curSkillLevel
    local enoughAiStarLevel = suggestAiStarLevel <= curAiStarLevel
    local allEnough = enoughLevel and enoughSkillLevel and enoughAiStarLevel
    if suggestLevel == 0 then
        self._view.LevelItem:SetActive(false)
    else
        self._view.LevelItem:SetActive(true)
        if enoughLevel then
            self._view.LevelItem.uiState:SetState(1)
        else
            self._view.LevelItem.uiState:SetState(2)
        end
        self._view.LevelItem.txt_recommadNum:SetText(tostring(suggestLevel))
        self._view.LevelItem.txt_currentNum:SetText(tostring(curLevel))
    end


    if suggestSkillLevel == 0 then
        self._view.SkillLevelItem:SetActive(false)
    else
        self._view.SkillLevelItem:SetActive(true)
        if enoughSkillLevel then
            self._view.SkillLevelItem.uiState:SetState(1)
        else
            self._view.SkillLevelItem.uiState:SetState(2)
        end
        self._view.SkillLevelItem.txt_recommadNum:SetText(tostring(suggestSkillLevel))
        self._view.SkillLevelItem.txt_currentNum:SetText(tostring(curSkillLevel))
    end

    if suggestAiStarLevel == 0 then
        self._view.AiLevelItem:SetActive(false)
    else
        self._view.AiLevelItem:SetActive(true)
        if enoughAiStarLevel then
            self._view.AiLevelItem.uiState:SetState(1)
        else
            self._view.AiLevelItem.uiState:SetState(2)
        end
        self._view.AiLevelItem.txt_recommadNum:SetText(tostring(suggestAiStarLevel))
        self._view.AiLevelItem.txt_currentNum:SetText(tostring(curAiStarLevel))
    end
    if allEnough then
        if missionCfg.loseDesc > 0 then
            self._view.failUiState:SetState(2)
        else
            self._view.failUiState:SetState(3)
        end
    else
        self._view.failUiState:SetState(1)
    end
end

function M:Init()
    self.m_items = {}
    self._view.closeBtn:onClick(Bind(self, self._OnCloseClick))
end

function M:_OnCloseClick()
    self:Close()
end

function M:OnDispose()
    self._view.closeBtn:onClick(nil)
    self._view.LevelItem.BgPress:onClick(nil)
    self._view.SkillLevelItem.BgPress:onClick(nil)
    self._view.AiLevelItem.BgPress:onClick(nil)
    M.super.OnDispose(self)
end

return M
