local OtakuOverviewItemHeroCtrl = BaseClass("OtakuOverviewItemHeroCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = OtakuOverviewItemHeroCtrl

function M:Update(index, data, selectCallBack, hideHead)
    self._index = index
    self._data = data
    self._callBack = selectCallBack
    self._hideHead = hideHead
    self:_SetNormalInfo()
end

function M:_SetNormalInfo()
    local state = self._data:State()
    self._view.state:SetState(state)
    self._view.food:SetActive(not self._hideHead)

    if state == OtakuType.DeployState.Lock then
        local format = ConfigHelper.GetLocalString(5650)
        local content = string.format(format, self._data:LockLevel())
        self._view.lockText:SetText(content)
        return
    end

    if state == OtakuType.DeployState.Plus then
        self._view.headImg:SetAvatarIcon(self._data:HeroId(), 1)
        self._view.professionImg:SetProfessional(self._data:HeroId())
    
        local maxSatiety = OtakuHelper.MaxSatiety(self._data:HeroId())
        local heroData = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self._data:HeroId())
        local eater = heroData:GetEater()
        local satietyRatio = eater / maxSatiety
        satietyRatio = satietyRatio > 1 and 1 or satietyRatio
        satietyRatio = MathUtil.GetPreciseDecimal(satietyRatio, 2)
        if satietyRatio == 0 then
            self._view.barState:SetState(1)
        elseif satietyRatio < 0.2 then
            self._view.barState:SetState(2)
        elseif satietyRatio <= 0.8 then
            self._view.barState:SetState(3)
        else
            self._view.barState:SetState(4)
        end

        if self._hideHead then
            self._view.barState:SetState(4)
        end
        self._view.bar.size = satietyRatio
    end
end

function M:Init()
    self._view.addClick:onClick(Bind(self, self._OnItemClick))
    self._TempOnRefHeroEatNum = EventMgr:AddListener(UIMessageNames.COOKING_EATSUCCESS,Bind(self, self._OnRefHeroEatNum))
end

function M:_OnRefHeroEatNum(heroId)
    if not self._data or self._data:HeroId() ~= heroId then
        return
    end
    self:_SetNormalInfo()
end

function M:_OnItemClick()
    if self._data:State() == OtakuType.DeployState.Normal or self._data:State() == OtakuType.DeployState.Plus then
        if self._callBack then 
            self._callBack(self._index)
        end
        OtakuRoomDataMgr:GetInstance():UpdateSettleSelectByRoomId(self._data:RoomId(), self._data:Position())
        UIContextMgr:GetInstance():Show("OtakuChooseHeroUI", self._data:RoomId(), self._data.curSettleType, self._data:Position())
    end
end

function M:OnDispose()
    self.clickCallBack = nil
    self.m_Index = nil
    self.m_Data = nil
    EventMgr:RemoveListener(UIMessageNames.COOKING_EATSUCCESS, self._TempOnRefHeroEatNum)
    M.super.OnDispose(self)
end


return OtakuOverviewItemHeroCtrl
