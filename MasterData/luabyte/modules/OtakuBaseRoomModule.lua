local OtakuBaseRoomModule = BaseClass("OtakuBaseRoomModule", require("Framework.Module.BaseGameModule"))
local M = OtakuBaseRoomModule

function M:OnEnter(roomData)
    M.super.OnEnter(self)
    self._roomData = roomData
    
    if self._OnWindowChangeHandler then
        IGameEventMgr:UnRegisterEventHandleByTypeName("UINormalStateChangeEvent", self._OnWindowChangeHandler)
    end
    
    self._OnWindowChangeHandler = Bind(self, self._OnWindowChangeHangler)
    
    IGameEventMgr:RegisterEventHandleByTypeName("UINormalStateChangeEvent", self._OnWindowChangeHandler)
end

function M:UpdateData(roomData)
    self._roomData = roomData
end

function M:_OnWindowChangeHangler(uiVisbleEvent)
    local normalCtrl = IUIManager:GetTopCtrl(CS.GameX.UIFormsType.Normal)
    
    if normalCtrl == nil then
        -- self:CloseUI("OtakuTopBar")
        self._lastNomarl = nil
        return 
    end
    
    if normalCtrl.config.barType == CS.GameX.ETopBar.Keep then
        return 
    end
    
    if normalCtrl.config.barType ~= CS.GameX.ETopBar.Custom then
        -- self:CloseUI("OtakuTopBar")
        self._lastNomarl = nil
        return 
    end
    
    if self._lastNomarl == normalCtrl.config.name then
        return 
    end
    
    -- self:ShowUI("OtakuTopBar", self._roomData, normalCtrl.config)
    self._lastNomarl = normalCtrl.config.name
end

function M:OnExit()
    if self._OnWindowChangeHandler then
        IGameEventMgr:UnRegisterEventHandleByTypeName("UINormalStateChangeEvent", self._OnWindowChangeHandler)
    end
    
    self._OnWindowChangeHandler = nil
    self._lastNomarl = nil
    M.super.OnExit(self)
end

function M:Ready()
    M.super.Ready(self)
end

return OtakuBaseRoomModule
