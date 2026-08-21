local M = BaseClass("LimitStageInfoItemCtrl",UIBaseComponent)

function M:__init(view)
    self._view = view
    self._view.clickArea:onClick(Bind(self,self._OnClick))
end

function M:SetWord(wordId,state,callback)
    self._callBack = callback 
    self._wordId = wordId
    local wordConditionCfg = ConfigHelper.GetCfg("mapCondition",wordId)
    if wordConditionCfg == nil then 
        Logger.LogError("mapCondition id error , " .. tostring(wordId))
    end
    self._view.desc:SetText(wordConditionCfg.name)
    self:SetState(state)
end

function M:GetState()
    return self._view.state:GetState()
end

function M:SetState(state)
    self._view.state:SetState(state)
end

function M:_OnClick(go)
    if self._callBack then 
        self._callBack(self._wordId,self:GetState())
    end
end

return M