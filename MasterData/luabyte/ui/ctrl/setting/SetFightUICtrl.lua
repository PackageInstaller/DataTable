local SetFightUICtrl = BaseClass("SetFightUICtrl")

local M = SetFightUICtrl

function M:__init(view)
    self._view = view

    self._view.tg_operationView:OnToggleClick(Bind(self, self.OnSwitchOperationView))
    self._view.tg_shakeCamera:OnToggleClick(Bind(self, self.OnSwitchShakeCamera))
    self._view.tg_skillShow:OnToggleClick(Bind(self, self.OnSwitchSkillShow))
    self._view.tg_cameraFocus:OnToggleClick(Bind(self, self.OnSwitchCameraFocus))
    self._view.tg_showMonsterHp:OnToggleClick(Bind(self, self.OnEnableShowMonsterHp))
    self._view.tg_hideMonsterHp:OnToggleClick(Bind(self, self.OnDisableShowMonsterHp))
    self._view.tg_deployGridShowAllways:OnToggleClick(Bind(self, self.OnSwitchShowRecommandDeployAllways))
end

function M:Open()
    self._view.toggleGroup_showMonsterHp:SetAllTogglesOff()
    self._view.tg_operationView:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Battle.OperationView,SettingDefault.Battle.OperationView)==1)
    self._view.tg_shakeCamera:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Battle.ShakeCamera,SettingDefault.Battle.ShakeCamera)==1)
    self._view.tg_skillShow:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Battle.SkillShow,SettingDefault.Battle.SkillShow)==1)
    self._view.tg_cameraFocus:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Battle.CameraFocus,SettingDefault.Battle.CameraFocus)==1)
    self._view.tg_showMonsterHp:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Battle.MonsterSpawnShowHpBar,SettingDefault.Battle.MonsterSpawnShowHpBar)==1)
    self._view.tg_hideMonsterHp:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Battle.MonsterSpawnShowHpBar,SettingDefault.Battle.MonsterSpawnShowHpBar)==0)
    self._view.tg_deployGridShowAllways:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Battle.ShowDeployAllways,SettingDefault.Battle.ShowDeployAllways)==1)
end


function M:OnDispose()
    self._view.tg_operationView:RemoveToggleAllClicks()
    self._view.tg_shakeCamera:RemoveToggleAllClicks()
    self._view.tg_skillShow:RemoveToggleAllClicks()
    self._view.tg_cameraFocus:RemoveToggleAllClicks()
    self._view.tg_showMonsterHp:RemoveToggleAllClicks()
    self._view.tg_hideMonsterHp:RemoveToggleAllClicks()
    self._view.tg_deployGridShowAllways:RemoveToggleAllClicks()
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end


function M:OnSwitchOperationView(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Battle.OperationView,isOn and 1 or 0)
end

function M:OnSwitchShakeCamera(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Battle.ShakeCamera,isOn and 1 or 0)
end

function M:OnSwitchSkillShow(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Battle.SkillShow,isOn and 1 or 0)
end

function M:OnSwitchCameraFocus(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Battle.CameraFocus,isOn and 1 or 0)
end

function M:OnSwitchShowRecommandDeployAllways(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Battle.ShowDeployAllways,isOn and 1 or 0)
end

function M:OnEnableShowMonsterHp(isOn)
    if isOn then 
        GameHelper.SetPlayerPrefsInt(SettingConst.Battle.MonsterSpawnShowHpBar,1)
    end
end

function M:OnDisableShowMonsterHp(isOn)
    if isOn then 
        GameHelper.SetPlayerPrefsInt(SettingConst.Battle.MonsterSpawnShowHpBar,0)
    end
end

function M:RevertAll(active)
    if  active then
        self._view.tg_operationView:SetIsOn(SettingDefault.Battle.OperationView==1)
        self._view.tg_shakeCamera:SetIsOn(SettingDefault.Battle.ShakeCamera==1)
        self._view.tg_skillShow:SetIsOn(SettingDefault.Battle.SkillShow==1)
        self._view.tg_cameraFocus:SetIsOn(SettingDefault.Battle.CameraFocus==1)
        self._view.tg_showMonsterHp:SetIsOn(SettingDefault.Battle.MonsterSpawnShowHpBar==1)
        self._view.tg_hideMonsterHp:SetIsOn(SettingDefault.Battle.MonsterSpawnShowHpBar==0)
        self._view.tg_deployGridShowAllways:SetIsOn(SettingDefault.Battle.ShowDeployAllways==1)
    else
        self:OnSwitchOperationView(SettingDefault.Battle.OperationView==1)
        self:OnSwitchShakeCamera(SettingDefault.Battle.ShakeCamera==1)
        self:OnSwitchSkillShow(SettingDefault.Battle.SkillShow==1)
        self:OnSwitchCameraFocus(SettingDefault.Battle.CameraFocus==1)
        self:OnEnableShowMonsterHp(SettingDefault.Battle.MonsterSpawnShowHpBar==1)
        self:OnDisableShowMonsterHp(SettingDefault.Battle.MonsterSpawnShowHpBar==0)
        self:OnSwitchShowRecommandDeployAllways(SettingDefault.Battle.ShowDeployAllways==1)
    end  
end

return SetFightUICtrl
