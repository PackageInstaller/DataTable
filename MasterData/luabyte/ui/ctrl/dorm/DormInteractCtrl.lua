local DormInteractCtrl = BaseClass("DormInteractCtrl", BaseUICtrl)
local M = DormInteractCtrl

function M:Init()
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.InteractClickCallback=EventMgr:AddListener(UIMessageNames.DORM_INTERACT_CLICK, Bind(self, self.OnInteractClick))
    self.favorPanelCtrl = require("UI.Ctrl.Dorm.FavorPanelCtrl").New(self._view.FavorPanel)
end

function M:OnEnter(heroId)
    if heroId == 0 then
        return
    end

    self.dormAction.state = DormConst.RoleState.Interact
    self.heroId = heroId
    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.heroId)
    self._view.slider:SetMax(self.dormAction.maxLoveValue)
    self.smallValue = self.dormAction.maxLoveValue * 0.4
    self.middleValue = self.dormAction.maxLoveValue * 0.7
    self:UpdateUI()
    
end

function M:UpdateUI()
    local loveValue = self.rshd:GetLoveValue()
    local percent = (loveValue / self.dormAction.maxLoveValue) * 100
    self._view.slider:SetValue(loveValue)
    self._view.value:SetText(tostring(math.ceil(percent)))
    if loveValue >= 0 and loveValue < self.smallValue then
        self._view.icon:SetState(1)
    end

    if loveValue > self.smallValue and loveValue < self.middleValue then
        self._view.icon:SetState(2)
     end

    if loveValue > self.middleValue and loveValue <= self.dormAction.maxLoveValue then
        self._view.icon:SetState(3)
     end

     self.favorLevel = 0
     local curFavor = 0
     local nextFavor = 0
     local favorProgress = 0
     local stage = 0
     self._roomStory = 0
     self._roomStoryLevel = 0
     local favor = 0
 
     if not IsNull(self.rshd) then
         favor = self.rshd:GetFavor()
     end
 
     self.favorLevel, curFavor, nextFavor, favorProgress, stage, self._roomStory, self._roomStoryLevel = OtakuHelper.GetHeroFeeling(self.heroId, favor)
     self.favorPanelCtrl:Enable(true)
     self.favorPanelCtrl:UpdateData(self.heroId, self.favorLevel, curFavor, nextFavor, stage)
end

function M:InstantiateEffect()
    local parent = DormHelper.GetBoneRootTransform()
    if self.effect then
        self.effect.transform:SetActive(false)
        self.effect.transform:SetActive(true)
    else
        self.effect = ResourceManager:GetInstance():InstanceGameObject("Effects1/Scene/effect_home_favorabilitylevelup")
        self.effect.transform:SetParent(parent)
        self.effect.transform.localPosition = Vector3.zero
        self.effect.transform:SetActive(true)
    end
end

function M:ResetEffect()
    self.effect.transform:SetActive(false)
end

function M:OnInteractClick()
    self:UpdateUI()
    self:InstantiateEffect()
end

function M:OnBack()
    UIContextMgr:GetInstance():Show("Dorm", self.module.roleStudio, self.module.dormData)
    self:Close()
end

function M:OnClose()
    if DormHelper.GetCurrentWatchPointFurnitureName() == "Main" then
        DormHelper.MoveCamera("MainBlend")
    else
        DormHelper.SetZoomInOut(false)
    end
    DormHelper.RoleAfk(true)
    if self.dormAction.commandAction then
        if self.dormAction.commandAction.ExitInteract then
            self.dormAction.commandAction:ExitInteract()
        end
    end
    self.dormAction.state = DormConst.RoleState.Command
    DormHelper.SetFreeLookCamera(true)
end

function M:OnDispose()
    self.favorPanelCtrl:OnDispose()
    M.super.OnDispose(self)
    EventMgr:RemoveListener(UIMessageNames.DORM_INTERACT_CLICK, self.InteractClickCallback)
    GameUtil.DestroyGo(self.effect)
    self.module = nil
    self.dormAction = nil
    self.effect = nil
end

return DormInteractCtrl
