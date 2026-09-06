local SoulRefineIntroduceDialog = class("SoulRefineIntroduceDialog", Dialog)
SoulRefineIntroduceDialog.AssetBundleName = "ui/layouts.baseskill"
SoulRefineIntroduceDialog.AssetName = "BaseSkillChangeSecondConfirm"

local function HandleHandleStage(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  if userInfo.guideID == 7 then
    if userInfo.stageRefCountTable[2] > 0 then
      if self._guideEffectHandler == nil then
        self._guideEffectHandler = NekoData.BehaviorManager.BM_Guide:CreateGuide(self._guideEffect)
      end
    else
      NekoData.BehaviorManager.BM_Guide:DestroyGuide(self._guideEffect, self._guideEffectHandler)
      self._guideEffectHandler = nil
    end
  end
end

function SoulRefineIntroduceDialog:Ctor(...)
  SoulRefineIntroduceDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._guideEffectHandler = nil
end

function SoulRefineIntroduceDialog:OnCreate()
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._guideEffect = self:GetChild("ConfirmButton/Effect")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, HandleHandleStage, Common.n_HandleStage, nil)
  local stargGuideInfo = {
    [7] = 2
  }
  LuaNotificationCenter.PostNotification(Common.n_StartGuideStage, self, stargGuideInfo)
end

function SoulRefineIntroduceDialog:OnDestroy()
  local stopGuideInfo = {
    [7] = 2
  }
  LuaNotificationCenter.PostNotification(Common.n_StopGuideStage, self, stopGuideInfo)
  LuaNotificationCenter.PostNotification(Common.n_StartGuideStage, self, {
    [7] = 3
  })
  LuaNotificationCenter.RemoveObserver(self)
end

function SoulRefineIntroduceDialog:OnConfirmBtnClicked()
  self:Destroy()
end

return SoulRefineIntroduceDialog
