-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/messagetip/endingdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EndingDialog = class("EndingDialog", Dialog)
EndingDialog.AssetBundleName = "ui/layouts.secondconfirm"
EndingDialog.AssetName = "EndingDialog"
EndingDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EndingDialog
  ((EndingDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

EndingDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._close = self:GetChild("CloseButton")
  self._join = self:GetChild("AddBtn")
  self._contents = {}
  for i = 1, 2 do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

    (self._contents)[i] = {back = self:GetChild("Group" .. i), userID = self:GetChild("Group" .. i .. "/UserID")}
  end
  ;
  (self._close):Subscribe_PointerClickEvent(self.OnCloseClick, self)
  ;
  (self._join):Subscribe_PointerClickEvent(self.OnJoinClick, self)
  local show = ((SdkManager.GetChannel)() == "leit" and not ((SdkManager.GetAgent)()):IsChannelPackage())
  ;
  (self._join):SetActive(show)
  ;
  (((self._contents)[1]).back):SetActive(show)
  ;
  (((self._contents)[1]).userID):SetText((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid)
  ;
  (((self._contents)[2]).back):SetActive(not show)
  ;
  (((self._contents)[2]).userID):SetText((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EndingDialog.OnDestroy = function(self)
  -- function num : 0_2
end

EndingDialog.OnCloseClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:Destroy()
  ;
  ((EffectFactory.CreateJumpBackEffect)()):Run()
end

EndingDialog.OnJoinClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local cvarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
  local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
  local systemType = require("protocols.bean.protocol.common.systemtype")
  if plat == systemType.IOS then
    ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((cvarconfig:GetRecorder(20)).Value)
  else
    if plat == systemType.ANDROID then
      ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((cvarconfig:GetRecorder(19)).Value)
    end
  end
end

return EndingDialog

