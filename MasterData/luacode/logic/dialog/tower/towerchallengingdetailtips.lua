local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CTowerDungeonType = BeanManager.GetTableByName("dungeonselect.ctowerdungeontype")
local cfloorname = BeanManager.GetTableByName("dungeonselect.cfloorname")
local TowerChallengingDetailTips = class("TowerChallengingDetailTips", Dialog)
TowerChallengingDetailTips.AssetBundleName = "ui/layouts.mainline"
TowerChallengingDetailTips.AssetName = "TowerDetailChallenge"

function TowerChallengingDetailTips:Ctor(...)
  TowerChallengingDetailTips.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function TowerChallengingDetailTips:OnCreate()
  self._title = self:GetChild("Back/Title")
  self._name = self:GetChild("Back/Text2")
  self._cancelBtn = self:GetChild("Back/CancelButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn = self:GetChild("Back/ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function TowerChallengingDetailTips:OnDestroy()
end

function TowerChallengingDetailTips:SetData(id)
  self._id = id
  local record = CTowerDungeonType:GetRecorder(id)
  self._title:SetText(TextManager.GetText(record.nameTextID))
  local floorname = TextManager.GetText(cfloorname:GetRecorder(NekoData.BehaviorManager.BM_Tower:GetDialogFloors()).floorName)
  self._name:SetText(TextManager.GetText(record.nameTextID) .. floorname)
end

function TowerChallengingDetailTips:OnConfirmBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.battle.cstarttowerexplore")
  if protocol then
    protocol.tower = self._id
    protocol:Send()
  end
  DialogManager.DestroySingletonDialog("tower.towerchallengingdetailtips")
end

function TowerChallengingDetailTips:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("tower.towerchallengingdetailtips")
end

return TowerChallengingDetailTips
