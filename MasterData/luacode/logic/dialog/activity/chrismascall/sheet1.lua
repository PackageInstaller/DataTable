local CTimedActivitySwitch = BeanManager.GetTableByName("activity.ctimedactivityswitch")
local ChristmasUnlockRecord = CTimedActivitySwitch:GetRecorder(DataCommon.Activities.Christmas)
local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local Sheet1 = class("Sheet1", Dialog)
Sheet1.AssetBundleName = "ui/layouts.activitychristmascall"
Sheet1.AssetName = "ActivityChristmasStart"

function Sheet1:Ctor(...)
  Sheet1.super.Ctor(self, ...)
end

function Sheet1:OnCreate()
  self._goBtn = self:GetChild("GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self:SetData()
end

function Sheet1:OnDestroy()
end

function Sheet1:SetData()
  self._goBtn:SetActive(NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Christmas))
end

function Sheet1:OnGoBtnClicked()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Christmas) then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetchristmasactivityinfo")
    if protocol then
      protocol:Send()
    end
    DialogManager.DestroySingletonDialog("activity.chrismascall.maindialog")
  end
end

return Sheet1
