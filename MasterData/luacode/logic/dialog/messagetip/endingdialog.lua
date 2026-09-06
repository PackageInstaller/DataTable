local EndingDialog = class("EndingDialog", Dialog)
EndingDialog.AssetBundleName = "ui/layouts.secondconfirm"
EndingDialog.AssetName = "EndingDialog"

function EndingDialog:Ctor(...)
  EndingDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function EndingDialog:OnCreate()
  self._close = self:GetChild("CloseButton")
  self._join = self:GetChild("AddBtn")
  self._contents = {}
  for i = 1, 2 do
    self._contents[i] = {
      back = self:GetChild("Group" .. i),
      userID = self:GetChild("Group" .. i .. "/UserID")
    }
  end
  self._close:Subscribe_PointerClickEvent(self.OnCloseClick, self)
  self._join:Subscribe_PointerClickEvent(self.OnJoinClick, self)
  local show = SdkManager.GetChannel() == "leit" and not SdkManager.GetAgent():IsChannelPackage()
  self._join:SetActive(show)
  self._contents[1].back:SetActive(show)
  self._contents[1].userID:SetText(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._contents[2].back:SetActive(not show)
  self._contents[2].userID:SetText(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
end

function EndingDialog:OnDestroy()
end

function EndingDialog:OnCloseClick()
  self:Destroy()
  EffectFactory.CreateJumpBackEffect():Run()
end

function EndingDialog:OnJoinClick()
  local cvarconfig = BeanManager.GetTableByName("var.cvarconfig")
  local plat = CS.PixelNeko.LuaManager.GetSystemType()
  local systemType = require("protocols.bean.protocol.common.systemtype")
  if plat == systemType.IOS then
    CS.PixelNeko.Tools.ShareHelper.OpenURL(cvarconfig:GetRecorder(20).Value)
  elseif plat == systemType.ANDROID then
    CS.PixelNeko.Tools.ShareHelper.OpenURL(cvarconfig:GetRecorder(19).Value)
  end
end

return EndingDialog
