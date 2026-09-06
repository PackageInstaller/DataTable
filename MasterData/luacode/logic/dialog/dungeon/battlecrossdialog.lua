local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
local CBattleTransferTable = BeanManager.GetTableByName("battle.cbattletransfer")
local CBattleTransferEffectTable = BeanManager.GetTableByName("battle.cbattletransfereffect")
local CBattleGuideLinkConfig = BeanManager.GetTableByName("guide.cbattleguidelinkconfig")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local BattleCrossDialog = class("BattleCrossDialog", Dialog)
BattleCrossDialog.AssetBundleName = "ui/layouts.battle"
BattleCrossDialog.AssetName = "BattleIntro"

function BattleCrossDialog:Ctor(...)
  BattleCrossDialog.super.Ctor(self, ...)
  self._groupName = "Loading"
  self._effectHandler = nil
  self._beginAnimationTime = 0
end

function BattleCrossDialog:OnCreate()
  self._effect = self:GetChild("Effect")
end

function BattleCrossDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

function BattleCrossDialog:SetData(battleid)
  local transferRecord = CBattleTransferTable:GetRecorder(CBattleInfoTable:GetRecorder(battleid).transferID)
  if transferRecord.transferType == 0 then
  elseif transferRecord.transferType == 1 then
  elseif transferRecord.transferType == 2 then
  end
  local transferEffectRecord = CBattleTransferEffectTable:GetRecorder(transferRecord.effectID)
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  self._beginAnimationTime = transferEffectRecord.beginEffectTime
  LuaAudioManager.PlayBGM(transferEffectRecord.soundID)
  self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(transferEffectRecord.effectName))
  self._effect:Subscribe_EffectStateEnterEvent(self._effectHandler, self.OnAnimationStateEnter, self)
  self._effect:Subscribe_EffectStateExitEvent(self._effectHandler, self.OnAnimationEnd, self)
  self._effect:PlayEffectAnimation(self._effectHandler, "begin")
end

function BattleCrossDialog:PlayEndAnimation()
  self._effect:PlayEffectAnimation(self._effectHandler, "end")
end

function BattleCrossDialog:OnAnimationStateEnter(handler, stateName, normalizedTime)
  if stateName == "loop" then
    LuaNotificationCenter.PostNotification(Common.n_LoadBattleBeginEffectEnd, BattleCrossDialog, nil)
  end
  if stateName == "end" then
    LuaNotificationCenter.PostNotification(Common.n_LoadBattleEffectEnd, BattleCrossDialog, nil)
  end
end

function BattleCrossDialog:OnAnimationEnd(handler, stateName, normalizedTime)
  if stateName == "end" then
    self:GetRootWindow():SetActive(false)
    local guideId = 0
    local tag = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.SUPPORT_GUIDE)
    if tag and tag == 0 then
      DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(8, true)
    else
      tag = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.BATTLE_RETREAT)
      if tag and tag == 0 then
        NekoData.BehaviorManager.BM_Game:SetGuideTag(GuidTypes.BATTLE_RETREAT, 1)
      else
        local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
        if protocol.guide ~= 0 then
          local TimeType = {
            None = 0,
            BattleStart = 1,
            BattleWin = 2,
            BattleLose = 3,
            BOSSFirstWeak = 4
          }
          local timetype = CBattleGuideLinkConfig:GetRecorder(protocol.guide).time
          if timetype == TimeType.BattleStart then
            DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(protocol.guide, true)
          end
        end
      end
    end
  end
end

function BattleCrossDialog:OnBackBtnClicked()
  if self:GetRootWindow():IsActive() then
    return DataCommon.BackPressed_NotResponse
  else
    return DataCommon.BackPressed_SkipResponse
  end
end

return BattleCrossDialog
