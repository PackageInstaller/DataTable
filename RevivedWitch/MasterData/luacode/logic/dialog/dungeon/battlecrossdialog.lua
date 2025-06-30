-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/battlecrossdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CBattleTransferTable = (BeanManager.GetTableByName)("battle.cbattletransfer")
local CBattleTransferEffectTable = (BeanManager.GetTableByName)("battle.cbattletransfereffect")
local CBattleGuideLinkConfig = (BeanManager.GetTableByName)("guide.cbattleguidelinkconfig")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local BattleCrossDialog = class("BattleCrossDialog", Dialog)
BattleCrossDialog.AssetBundleName = "ui/layouts.battle"
BattleCrossDialog.AssetName = "BattleIntro"
BattleCrossDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleCrossDialog
  ((BattleCrossDialog.super).Ctor)(self, ...)
  self._groupName = "Loading"
  self._effectHandler = nil
  self._beginAnimationTime = 0
end

BattleCrossDialog.OnCreate = function(self)
  -- function num : 0_1
  self._effect = self:GetChild("Effect")
end

BattleCrossDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

BattleCrossDialog.SetData = function(self, battleid)
  -- function num : 0_3 , upvalues : CBattleTransferTable, CBattleInfoTable, CBattleTransferEffectTable, _ENV
  local transferRecord = CBattleTransferTable:GetRecorder((CBattleInfoTable:GetRecorder(battleid)).transferID)
  if ((transferRecord.transferType == 0 and transferRecord.transferType ~= 1) or transferRecord.transferType == 2) then
    local transferEffectRecord = CBattleTransferEffectTable:GetRecorder(transferRecord.effectID)
    if self._effectHandler then
      (self._effect):ReleaseEffect(self._effectHandler)
      self._effectHandler = nil
    end
    self._beginAnimationTime = transferEffectRecord.beginEffectTime
    ;
    (LuaAudioManager.PlayBGM)(transferEffectRecord.soundID)
    self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(transferEffectRecord.effectName))
    ;
    (self._effect):Subscribe_EffectStateEnterEvent(self._effectHandler, self.OnAnimationStateEnter, self)
    ;
    (self._effect):Subscribe_EffectStateExitEvent(self._effectHandler, self.OnAnimationEnd, self)
    ;
    (self._effect):PlayEffectAnimation(self._effectHandler, "begin")
  end
end

BattleCrossDialog.PlayEndAnimation = function(self)
  -- function num : 0_4
  (self._effect):PlayEffectAnimation(self._effectHandler, "end")
end

BattleCrossDialog.OnAnimationStateEnter = function(self, handler, stateName, normalizedTime)
  -- function num : 0_5 , upvalues : _ENV, BattleCrossDialog
  if stateName == "loop" then
    (LuaNotificationCenter.PostNotification)(Common.n_LoadBattleBeginEffectEnd, BattleCrossDialog, nil)
  end
  if stateName == "end" then
    (LuaNotificationCenter.PostNotification)(Common.n_LoadBattleEffectEnd, BattleCrossDialog, nil)
  end
end

BattleCrossDialog.OnAnimationEnd = function(self, handler, stateName, normalizedTime)
  -- function num : 0_6 , upvalues : _ENV, GuidTypes, CBattleGuideLinkConfig
  if stateName == "end" then
    (self:GetRootWindow()):SetActive(false)
    local guideId = 0
    local tag = ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuidTypes.SUPPORT_GUIDE)
    if tag and tag == 0 then
      ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(8, true)
    else
      tag = ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuidTypes.BATTLE_RETREAT)
      if tag and tag == 0 then
        ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuidTypes.BATTLE_RETREAT, 1)
      else
        local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
        if protocol.guide ~= 0 then
          local TimeType = {None = 0, BattleStart = 1, BattleWin = 2, BattleLose = 3, BOSSFirstWeak = 4}
          local timetype = (CBattleGuideLinkConfig:GetRecorder(protocol.guide)).time
          if timetype == TimeType.BattleStart then
            ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(protocol.guide, true)
          end
        end
      end
    end
  end
end

BattleCrossDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (self:GetRootWindow()):IsActive() then
    return DataCommon.BackPressed_NotResponse
  else
    return DataCommon.BackPressed_SkipResponse
  end
end

return BattleCrossDialog

