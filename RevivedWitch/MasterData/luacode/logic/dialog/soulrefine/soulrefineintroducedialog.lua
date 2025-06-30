-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/soulrefine/soulrefineintroducedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SoulRefineIntroduceDialog = class("SoulRefineIntroduceDialog", Dialog)
SoulRefineIntroduceDialog.AssetBundleName = "ui/layouts.baseskill"
SoulRefineIntroduceDialog.AssetName = "BaseSkillChangeSecondConfirm"
local HandleHandleStage = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

  if userInfo.guideID == 7 and (userInfo.stageRefCountTable)[2] > 0 and self._guideEffectHandler == nil then
    self._guideEffectHandler = ((NekoData.BehaviorManager).BM_Guide):CreateGuide(self._guideEffect)
  end
  ;
  ((NekoData.BehaviorManager).BM_Guide):DestroyGuide(self._guideEffect, self._guideEffectHandler)
  self._guideEffectHandler = nil
end

SoulRefineIntroduceDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : SoulRefineIntroduceDialog
  ((SoulRefineIntroduceDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._guideEffectHandler = nil
end

SoulRefineIntroduceDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV, HandleHandleStage
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._guideEffect = self:GetChild("ConfirmButton/Effect")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleHandleStage, Common.n_HandleStage, nil)
  local stargGuideInfo = {[7] = 2}
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_StartGuideStage, self, stargGuideInfo)
end

SoulRefineIntroduceDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local stopGuideInfo = {[7] = 2}
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_StopGuideStage, self, stopGuideInfo)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_StartGuideStage, self, {[7] = 3})
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SoulRefineIntroduceDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return SoulRefineIntroduceDialog

