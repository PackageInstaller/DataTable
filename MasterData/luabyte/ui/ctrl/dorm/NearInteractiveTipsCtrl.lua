local NearInteractiveTipsCtrl = BaseClass("NearInteractiveTipsCtrl", BaseUICtrl)
local M = NearInteractiveTipsCtrl

function M:Init()
    self._tips = {}
    
    for i = 1, 5 do
        self._tips[i] = self._view["Tips" .. i]
    end
    
    self._view.Btn_exit.transform:onClick(Bind(self, self.OnExit))
    
    self._doomInteractiveBack = EventMgr:AddListener(UIMessageNames.DORM_INTERACTIVE_BACK, Bind(self, self.OnDoomInteractiveBack))
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
end

function M:OnEnter(datas)
    self.data = datas
    
    for i = 1, 5 do
        if self.data[i] then
            self._tips[i]:Enable(true)
            self._tips[i]:SetData(self.data[i])
        else
            self._tips[i]:Enable(false)
        end
    end
    
    self:Enable(true)
    self.dormAction.state = DormConst.RoleState.Command
end

function M:OnDoomInteractiveBack()
    self:Close()
end

function M:OnExit(go)
    self.dormAction.state = DormConst.RoleState.None
    UIContextMgr:GetInstance():Show("Dorm", self.module.roleStudio)
    self.dormAction:OnExitCommonder()
    self:Close()
end

function M:OnClose(...)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.DORM_INTERACTIVE_BACK, self._doomInteractiveBack)
    self._doomInteractiveBack = nil
    self._dormConcealNearInteractive = nil
    M.super.OnDispose(self)
end

function M:Enable(v)
    self._view:SetActive(v)
end

return NearInteractiveTipsCtrl
