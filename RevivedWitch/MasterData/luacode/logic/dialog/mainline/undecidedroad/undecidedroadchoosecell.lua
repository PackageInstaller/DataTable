-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadchoosecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CWeidingTestBattleConfig = (BeanManager.GetTableByName)("dungeonselect.cweidingtestbattleconfig")
local BattleType = (LuaNetManager.CreateBean)("protocol.activity.challengerecord")
local UndecidedRoadChooseCell = class("UndecidedRoadChooseCell", Dialog)
UndecidedRoadChooseCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadChooseCell.AssetName = "ActivityRoadChooseCell"
UndecidedRoadChooseCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadChooseCell
  ((UndecidedRoadChooseCell.super).Ctor)(self, ...)
end

UndecidedRoadChooseCell.OnCreate = function(self)
  -- function num : 0_1
  self._bossImg = self:GetChild("Cell/Boss")
  self._indexTxt = self:GetChild("Cell/TitleBack/Txt")
  self._name = self:GetChild("Cell/Name")
  self._scoreTxt = self:GetChild("Cell/Num1")
  self._recommendScore = self:GetChild("Cell/Num2")
  self._RecordBtn = self:GetChild("Cell/RecordBtn")
  self._StartBtn = self:GetChild("Cell/StartBtn")
  ;
  (self._RecordBtn):Subscribe_PointerClickEvent(self.OnRecordBtnClicked, self)
  ;
  (self._StartBtn):Subscribe_PointerClickEvent(self.OnStartBtnClicked, self)
end

UndecidedRoadChooseCell.OnDestroy = function(self)
  -- function num : 0_2
end

UndecidedRoadChooseCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : BattleType, CWeidingTestBattleConfig, _ENV, CImagePathTable
  self._battleData = {battletype = BattleType.TRAIN, battleId = data.battleId, score = data.score}
  ;
  (self._indexTxt):SetText(data.id)
  ;
  (self._scoreTxt):SetText(data.score)
  local battleRecorder = CWeidingTestBattleConfig:GetRecorder(data.battleId)
  if not battleRecorder then
    LogErrorFormat("UndecidedRoadChooseCell", "CWeidingTestBattleConfig:%s", data.battleId)
    return 
  end
  if not CImagePathTable:GetRecorder(battleRecorder.image) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._bossImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(battleRecorder.nameTextID))
  ;
  (self._recommendScore):SetText(battleRecorder.recommendpoints)
end

UndecidedRoadChooseCell.OnRecordBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, BattleType
  ((NekoData.BehaviorManager).BM_UndecidedRoad):CheckChallengeRecord(BattleType.TRAIN, (self._battleData).battleId)
end

UndecidedRoadChooseCell.OnStartBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadeditdialog")):Init(self._battleData)
end

return UndecidedRoadChooseCell

