local M = BaseClass("StoryNextCtrl")
local StoryMgr = StoryDataMgr:GetInstance()

function M:__init(view)
    self._view = view
    self:Init()
end

function M:OnDispose()
    self.m_roleDurTime = nil
    self.m_backDurTime = nil
    self.m_minSpineTime = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:Init()
    -- body
end

-- 剧情立绘淡入淡出效果时长
function M:GetRoleFadeTime()
    if not self.m_roleDurTime then
        self.m_roleDurTime = ConfigHelper.GetSystemParam(186)
    end
    return self.m_roleDurTime
end

-- 剧情背景淡入淡出效果时长
function M:GetBackFadeTime()
    if not self.m_backDurTime then
        self.m_backDurTime = ConfigHelper.GetSystemParam(185)
    end
    return self.m_backDurTime
end

-- spine动画最小播放时长（万分数/10000）
function M:GetMinSpineTime()
    if not self.m_minSpineTime then
        self.m_minSpineTime = GameHelper.GetParamter(362) / 10000
    end
    return self.m_minSpineTime
end

-- spine 播放时长
function M:GetSpineTime(roleTalk)
    return math.max(StoryHelper.GetStoryDialogueTime(roleTalk), self:GetMinSpineTime())
end

function M:SelectMagnifier(index)
    local storyCfg = StoryMgr:GetStory()
    if storyCfg.commanderType == StoryConst.ResponseType.RoleMagnifier then
        StoryMgr:CmdResponseEffect(storyCfg, index)
    end
end

function M:SelectDialogue(index)
    local storyCfg = StoryMgr:GetStory()
    if storyCfg.commanderType == StoryConst.ResponseType.Selection then
        StoryMgr:CmdResponseDialogue(storyCfg, index)
    end
end

function M:SelectRoleEffect(index)
    local storyCfg = StoryMgr:GetStory()
    if storyCfg.commanderType == StoryConst.ResponseType.RoleEffect then
        StoryMgr:CmdResponseEffect(storyCfg, index)
    end
end

function M:SelectBgEffect(index)
    local storyCfg = StoryMgr:GetStory()
    if storyCfg.commanderType == StoryConst.ResponseType.BgEffect then
        StoryMgr:CmdResponseEffect(storyCfg, index)
    end
end

function M:CheckVoice()
    if StoryMgr:IsAsideOrNoVoice() then
        StoryMgr:SetVoiceComplete(true)
        if StoryMgr:IsAuto() then
            StoryMgr:NextStoryDelay(1.2)
        end
    end
end

return M
