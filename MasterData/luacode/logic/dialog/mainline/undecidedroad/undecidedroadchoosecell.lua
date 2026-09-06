local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CWeidingTestBattleConfig = BeanManager.GetTableByName("dungeonselect.cweidingtestbattleconfig")
local BattleType = LuaNetManager.CreateBean("protocol.activity.challengerecord")
local UndecidedRoadChooseCell = class("UndecidedRoadChooseCell", Dialog)
UndecidedRoadChooseCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadChooseCell.AssetName = "ActivityRoadChooseCell"

function UndecidedRoadChooseCell:Ctor(...)
  UndecidedRoadChooseCell.super.Ctor(self, ...)
end

function UndecidedRoadChooseCell:OnCreate()
  self._bossImg = self:GetChild("Cell/Boss")
  self._indexTxt = self:GetChild("Cell/TitleBack/Txt")
  self._name = self:GetChild("Cell/Name")
  self._scoreTxt = self:GetChild("Cell/Num1")
  self._recommendScore = self:GetChild("Cell/Num2")
  self._RecordBtn = self:GetChild("Cell/RecordBtn")
  self._StartBtn = self:GetChild("Cell/StartBtn")
  self._RecordBtn:Subscribe_PointerClickEvent(self.OnRecordBtnClicked, self)
  self._StartBtn:Subscribe_PointerClickEvent(self.OnStartBtnClicked, self)
end

function UndecidedRoadChooseCell:OnDestroy()
end

function UndecidedRoadChooseCell:RefreshCell(data)
  self._battleData = {
    battletype = BattleType.TRAIN,
    battleId = data.battleId,
    score = data.score
  }
  self._indexTxt:SetText(data.id)
  self._scoreTxt:SetText(data.score)
  local battleRecorder = CWeidingTestBattleConfig:GetRecorder(data.battleId)
  if not battleRecorder then
    LogErrorFormat("UndecidedRoadChooseCell", "CWeidingTestBattleConfig:%s", data.battleId)
    return
  end
  local imageRecord = CImagePathTable:GetRecorder(battleRecorder.image) or DataCommon.DefaultImageAsset
  self._bossImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(battleRecorder.nameTextID))
  self._recommendScore:SetText(battleRecorder.recommendpoints)
end

function UndecidedRoadChooseCell:OnRecordBtnClicked()
  NekoData.BehaviorManager.BM_UndecidedRoad:CheckChallengeRecord(BattleType.TRAIN, self._battleData.battleId)
end

function UndecidedRoadChooseCell:OnStartBtnClicked()
  DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadeditdialog"):Init(self._battleData)
end

return UndecidedRoadChooseCell
