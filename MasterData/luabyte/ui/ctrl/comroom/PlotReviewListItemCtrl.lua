local M = BaseClass("PlotReviewListItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_lockId = 0
    self.m_nType = nil
    self.m_bookStory = nil
    self._view.btn_enter:onClick(Bind(self, self.OnClickItem))
    self._view.node_lock:onClick(Bind(self, self.OnClickMask))
end

function M:UpdateItem(data)
    if not data then return end

    self.m_nType = data.Type
    self.m_lockId = data.LockId
    self.m_bookStory = data.Config
    self._view.node_lock:SetActive(self.m_lockId > 0)
    self._view.btn_enter:SetActive(self.m_lockId <= 0)
    self._view.txt_name:SetText(self.m_bookStory.storyTitle)
    self._view.btn_enter:SetState((self.m_nType == EnumConst.StoryBookType.Dorm) and 2 or 1)
    self._view.txt_desc:SetText(ConfigHelper.GetLocalStringByPlayerName(self.m_bookStory.storyDesc))

    self._view.redPoint:SetParam(0, self.m_bookStory.id)
    self._view.redPoint:Check()
end

function M:Dispose()
    self.m_nType = nil
    self.m_lockId = nil
    self.m_bookStory = nil
    M.super.Dispose(self)
end

-- 跳转剧情
function M:OnClickItem(go)
    PlayerPrefTools.SetPlayerPrefs("StoryBook" .. tostring(self.m_bookStory.id), 1)
    IRedPointMgr:ForceCheck(RedPointConst.StoryBookMainTypeRedPointChecker)
    self._view.redPoint:Check()
    if self.m_nType == EnumConst.StoryBookType.Dorm then -- 宿舍剧情
        UIContextMgr:GetInstance():Show("PlotDormUnlockUI", self:_GetDormDatas())
    else
        StoryDataMgr:GetInstance():TriggerStoryByGroup(self.m_bookStory.groupId)
    end
end

-- 弹出提示
function M:OnClickMask(go)
    if self.m_lockId > 0 then
        local cfg = ConfigHelper.GetCfgByLua("openCondition", self.m_lockId)
        if cfg then
            GameHelper.TipsById(cfg.tips)
        else
            Logger.LogError("openCondition is nil, 请检查配表, id = " .. self.m_lockId)
        end
    end
end

function M:_GetDormDatas()
    local dormType = self.m_bookStory.dormitoryType
    local datas, isUnlock = {}, function(tbl)
        return PlotAtlasDataMgr:GetInstance():IsUnlockDormBook(tbl.Id)
    end
    local id = self.m_bookStory.id
    for _, cfg in ipairs(PlotAtlasDataMgr:GetInstance():GetDormStorysByType(dormType)) do
        table.insert(datas, {
            Id = cfg.id,
            Config = cfg,
            BookStoryId = id,
            IsUnlock = isUnlock
        })
    end

    return datas
end

return M
