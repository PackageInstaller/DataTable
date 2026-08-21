local UISceneBallCtrl = BaseClass("UISceneBallCtrl")
local M = UISceneBallCtrl


-- 是否加载过基因球
function M:IsLoad()
    return self.m_IsLoad
end

-- 选中状态设置
function M:Select()
    if self.m_IsSelect then
        return
    end

    self.m_IsSelect = true
    self._view.transform:SetLocalScale(self.m_NewGeneScale, self.m_NewGeneScale, self.m_NewGeneScale)
    self._view.selectEffect:SetParticleStartSize(self.m_NewEffectScale)
    self._view.changeEffect:SetParticleStartSize(0.32)
    self._view.selectEffect:SetActive(true)
    self._view.changeEffect:SetActive(true)
    self.m_Timer = TimerManager:GetInstance():GetTimer(0.5, Bind(self, self._HideEffect), self, true)
    self.m_Timer:Start()
end

-- 解除选中状态设置
function M:UnSelect()
    self.m_IsSelect = false
    self._view.selectEffect:SetParticleStartSize(self.m_OldEffectScale)
    self._view.transform:SetLocalScale(self.m_OldGeneScale, self.m_OldGeneScale, self.m_OldGeneScale)
    self._view.selectEffect:SetActive(false)
end

-- 升级状态设置
function M:Up()
    self._view.upEffect:SetActive(true)
    self.m_Timer = TimerManager:GetInstance():GetTimer(1.5, Bind(self, self._HideEffect), self, true)
    self.m_Timer:Start()
end

-- 设置基因球内容
function M:SetGeneBallInfo(isUnlock, name, lv, fill)
    self.m_Ball:SetGeneBallInfo(isUnlock, name, lv, fill)
end

-- 创建基因球
function M:CreateBall(path)
    if self.m_IsLoad then
        return
    end

    self.m_Ball = ResourceManager:GetInstance():InstanceCtrl(path)

    if self.m_Ball == nil then
        Logger.LogError("effect 路径错误 :" .. tostring(path))
        return
    end

    self.m_Ball.transform:SetParent(self._view.Ball)
    self.m_Ball.transform:SetLocalPos(0, 0, 0)
    self.m_Ball.transform:SetLocalScale(1.1, 1.1, 1.1)
    self.m_IsLoad = true
    self:UnSelect()
end

-- 删除基因球
function M:RemoveBall()
    if not self.m_IsLoad then
        return
    end

    self.m_IsLoad = false
    self.m_Ball.gameObject:SetActive(false)
    GameUtil.DestroyGo(self.m_Ball.gameObject)
end

-- 隐藏特效
function M:_HideEffect()
    self.m_Timer:Stop()
    self._view.changeEffect:SetParticleStartSize(0.15)
    self._view.changeEffect:SetActive(false)
    self._view.upEffect:SetActive(false)
end

function M:__init(view)
    self._view = view
    self.m_IsLoad = false
    self.m_IsSelect = false
    self.m_OldGeneScale = 1       -- 默认大小
    self.m_NewGeneScale = 1.4     -- 选中的大小
    self.m_OldEffectScale = 0.27  -- 默认特效大小
    self.m_NewEffectScale = 0.357 -- 选中的特效大小
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UISceneBallCtrl
