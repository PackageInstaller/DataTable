local M = BaseClass("ChapterSelectionContext", BaseContext)

function M:Init()
    self.m_backType = nil
    self.m_battleStyle = EnumConst.EBattleStyle.Normal
    self.m_chapterType = ChapterConst.EChapterType.ECT_Main
end

function M:Open(_type, battleStyle, isWin)
    if self.m_backType then _type = self.m_backType end
    self.m_chapterType = _type or ChapterConst.EChapterType.ECT_Main
    self.m_battleStyle = battleStyle
    self.m_backType = nil

    MissionDataMgr:GetInstance():LoadChapter(0, function()
        ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.TIME_LIMIT_PVE, function(datas)
            self.m_timeLimitDatas = datas
            self:_Show(self.m_chapterType, self.m_battleStyle, isWin)
        end)
    end)
end

function M:CanShowTopBar()
    if not IGuideMgr.IsGuiding then return true end

    if not self.m_newbieId then self.m_newbieId = GameHelper.GetParamter(171) end
    return MissionDataMgr:GetInstance():IsMissionPassById(self.m_newbieId)
end

function M:SetBackType(mType)
    if mType == ChapterConst.EChapterType.ECT_Activity then
        self.m_backType = nil
    else
        self.m_backType = mType
    end
end

-- 限时副本活动数据
function M:GetTimeLimitData()
    return self.m_timeLimitDatas
end

function M:OnClose()
    self.m_timeLimitDatas = nil
    M.super.OnClose(self)
end

return M
