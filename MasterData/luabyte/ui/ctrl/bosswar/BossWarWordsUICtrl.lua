local M = BaseClass("BossWarWordsUICtrl", BaseUICtrl)
local EventName = UIMessageNames.BOSS_WORDS_REFRESH

function M:Init()
    local view = require("UI.View.BossWar.BossWarWordsItemView")
    local ctrl = require("UI.Ctrl.BossWar.BossWarWordsItemCtrl")
    self.m_wordLimit = 4 -- 词条空间限制，写死
    self.m_wordDatas = {}
    self.m_oldDataDic = {}
    self.m_remainLv = self.m_wordLimit
    self._view.looplist:Init(ctrl, view)
    self._view.btn_confirm:onClick(Bind(self, self.Close))
    self._view.btn_back:onClick(Bind(self, self.OnClickBack))
    self._view.looplist:SetCreateItemCallback(Bind(self, self.OnCreateItem))
    self.m_onRefreshWords = EventMgr:AddListener(EventName, Bind(self, self.OnRefreshWords))
end

function M:OnEnter(data, callback)
    self.m_data = data
    self.m_wordDatas = {}
    self.m_callback = callback
    self:_UpdateState()
    for _, cfg in ipairs(BossWarDataMgr:GetInstance():GetWeekWords()) do
        local id, lv = cfg.id, cfg.level
        table.insert(self.m_wordDatas, {
            Id = id,
            Level = lv,
            Config = cfg,
            Desc = ConfigHelper.GetLocalString(cfg.desc),
            GetState = function()
                if self.m_data:HasWord(id) then return 2 end
                return (lv > self.m_remainLv) and 3 or 1
            end --1:Normal 2:Select 3:Cannot Select
        })
    end
    self._view.looplist:SetDataList(self.m_wordDatas)
end

function M:_UpdateState()
    for _, cfg in pairs(self.m_data:GetWordDic()) do
        self.m_oldDataDic[cfg.id] = cfg
        self.m_remainLv = self.m_remainLv - cfg.level --最少为0
    end
    self._view.wordsState:SetState(self.m_wordLimit - self.m_remainLv + 1)
end

function M:OnRefreshWords()
    self:_UpdateState()
    self._view.looplist:UpdateList()
end

function M:OnClickBack(go)
    for _, cfg in pairs(self.m_data:GetWordDic()) do
        self.m_data:UpdateWords(cfg) --取消
    end
    for _, cfg in pairs(self.m_oldDataDic) do
        self.m_data:UpdateWords(cfg) --恢复
    end
    self:Close()
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnDispose()
    EventMgr:RemoveListener(EventName, self.m_onRefreshWords)
    self.m_data = nil
    self.m_remainLv = nil
    self.m_wordDatas = nil
    self.m_oldDataDic = nil
    self.m_onRefreshWords = nil
    if self.m_callback then
        self.m_callback()
        self.m_callback = nil
    end
    M.super.OnDispose(self)
end

function M:OnCreateItem(ctrl)
    ctrl:SetCallback(Bind(self, self.OnClickItem))
end

function M:OnClickItem(data)
    if self.m_data:HasWord(data.Id) then
        self.m_remainLv = self.m_remainLv + data.Level
    else
        local remain = self.m_remainLv - data.Level
        if remain < 0 then return end
        self.m_remainLv = remain
    end
    self.m_data:UpdateWords(data.Config)
    self._view.looplist:UpdateList()
    self._view.wordsState:SetState(self.m_wordLimit - self.m_remainLv + 1)
end

return M
