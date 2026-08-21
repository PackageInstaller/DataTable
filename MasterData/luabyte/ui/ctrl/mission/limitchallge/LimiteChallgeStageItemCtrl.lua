local M = BaseClass("LimiteChallgeStageItemCtrl",UIBaseComponent)

function M:__init(view)
    self._view = view
    self._view:onClick(Bind(self,self._OnClick))
    self.m_trans = self._view.transform
end

function M:_OnClick(go)
    if self.m_callback then 
        self.m_callback(self.m_missionId)
    end
end

function M:GetMissionId()
    return self.m_missionId
end

function M:SetSelect(isSelect)
    local state = 0
    if isSelect then 
        state = 3
    elseif self.m_isCur then 
        state = 2
    else
        state = 1 
    end
    self._view.state:SetState(state)
end

function M:SetInfo( missionId,isSelect,isCur,alreadyStar,callback,isLastOne)
    self.m_trans.gameObject.name = "item" .. missionId
    local lineTrans = self._view.line
    self.m_callback = callback
    self.m_missionId = missionId
    self.m_isCur = isCur
    alreadyStar = alreadyStar and alreadyStar or 0
    self.m_mission = ConfigHelper.GetCfg("mission",missionId)
    if self.m_mission == nil then 
        Logger.LogError("mission is error ,id = " .. tostring(missionId) )
    end
    self:SetSelect(isSelect)
    self._view.label:SetText(self.m_mission.chapterLabel)
    self._view.starLabel:SetText("<color=#ffe999>".. alreadyStar .."</color>".."/9")
    self._view.starOn:SetActive(alreadyStar>0)
    self._view.starOff:SetActive(alreadyStar==0)
    lineTrans:SetActive( not isLastOne )
end

return M 