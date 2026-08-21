local M = BaseClass("LimitBreakLimitSkillUICtrl",BaseUICtrl)

function M:__init()
    self._allItems = {}
    self._limitData = nil
    self._maskResetTimes = 2
    self.view.txt_back:onClick(Bind(self,self._OnClickClose))
    self.view.resetState:onClick(Bind(self,self._OnClickReset))
end

function M:_OnClickClose(go)
    self:Close()
end

function M:_OnClickReset(go)
    if self.view.resetState:GetState() == 2 then 
        return
    end
    if self._limitData:GetSkillResetTimes() >= self._maskResetTimes then
        GameHelper.Tips("已超过重置上限")
        return
    end
    LimitDataMgr:GetInstance():RequestResetExtremeBattleSkills(Bind(self,self._OnResetExtremeBattleSkills))
end

function M:_OnResetExtremeBattleSkills()
    self:OnEnter(self._limitData)
end

function M:OnEnter(limitData)
    local skillDatas = limitData:GetLimitSkills()
    for _, item in ipairs(self._allItems) do
        item:OnDestroy()
    end
    self._limitData = limitData
    self._allItems = {}
    self.view.Item:SetActive(false)
    for idx, skillData in ipairs(skillDatas) do
        -- body
        local item = self.view.Item:Instantiate()
        item:SetActive(true)
        table.insert(self._allItems,item)
        item:SetGroupInfo(skillData,idx-1)
    end
    self.view.empty:SetActive(#skillDatas==0)
    self.view.resetState:SetActive(#skillDatas>0)
    self.view.txt_resetLabel:SetText( "重置破限技:".. self._limitData:GetSkillResetTimes().."/"..self._maskResetTimes)
end

return M