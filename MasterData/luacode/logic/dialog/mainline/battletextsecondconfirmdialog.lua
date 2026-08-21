-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/battletextsecondconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local BattleTextSecondConfirmDialog = class("BattleTextSecondConfirmDialog", Dialog)
BattleTextSecondConfirmDialog.AssetBundleName = "ui/layouts.battlenew"
BattleTextSecondConfirmDialog.AssetName = "BattleTextSecondConfirm"
BattleTextSecondConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleTextSecondConfirmDialog
  ((BattleTextSecondConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

BattleTextSecondConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._input = self:GetChild("InputField")
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._inputSceneId = self:GetChild("InputField2")
  self._arenaToggle = self:GetChild("PVP")
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
  ;
  (self._input):ActivateInputField()
end

BattleTextSecondConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BattleTextSecondConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("debug.gmorderdialog")
  if dialog then
    dialog:SetActive(true)
  end
  self:Destroy()
  local dialog = (DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog")
  if dialog then
    dialog:OnTypeThreeBtnCancelClicked()
  end
end

BattleTextSecondConfirmDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV, CSceneInfoStatic
  local battleid = (self._input):GetText()
  local sceneid = tonumber((self._inputSceneId):GetText()) or 20012
  if not CSceneInfoStatic:GetRecorder(sceneid) or sceneid // 10000 ~= 2 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100128)
    return 
  end
  if global_var_debug then
    ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(sceneid, "xiaofu", "BattleTextSecondConfirmDialog", (string.format)("you can see this message because you have clicked battle text button battleid %s sceneid %s", battleid, sceneid), 10, "BattleTest")
  end
  battleid = (string.trim)(battleid)
  local battleId = tonumber(battleid)
  if (self._arenaToggle):GetIsOnType() then
    if battleId and ((BeanManager.GetTableByName)("battle.cbattleinfo")):GetRecorder(battleId) then
      local dialog = (DialogManager.CreateSingletonDialog)("teamedit.offlineteameditdialog")
      dialog:SetData(battleId)
      ;
      (DialogManager.DestroySingletonDialog)("debug.gmorderdialog")
      self:Destroy()
    else
      do
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100052)
        if battleId and ((BeanManager.GetTableByName)("battle.cbattleinfo")):GetRecorder(battleId) then
          local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
          dialog:SetTestBattleInfo({battleId = battleId, battleSceneId = sceneid})
          ;
          (DialogManager.DestroySingletonDialog)("debug.gmorderdialog")
          self:Destroy()
        else
          do
            ;
            ((NekoData.BehaviorManager).BM_Message):SendMessageById(100052)
          end
        end
      end
    end
  end
end

return BattleTextSecondConfirmDialog

