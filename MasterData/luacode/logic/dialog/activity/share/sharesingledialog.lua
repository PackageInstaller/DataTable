-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/share/sharesingledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BannerId = 6
local ShareSingleDialog = class("ShareSingleDialog", Dialog)
ShareSingleDialog.AssetBundleName = "ui/layouts.share"
ShareSingleDialog.AssetName = "ActivityShareShot"
ShareSingleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShareSingleDialog
  ((ShareSingleDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

ShareSingleDialog.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Panel/Image")
  self._share = self:GetChild("ShareBtn")
  self._back = self:GetChild("CloseBtn")
  ;
  (self._share):Subscribe_PointerClickEvent(self.OnShareClick, self)
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

ShareSingleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._texture then
    (((CS.UnityEngine).Object).Destroy)(self._texture)
    self._texture = nil
  end
end

ShareSingleDialog.SetData = function(self, texture)
  -- function num : 0_3
  self._texture = texture
  self:Refresh()
end

ShareSingleDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._texture then
    ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).LoadTexture)((self._img):GetUIObject(), self._texture)
  end
end

ShareSingleDialog.OnShareClick = function(self, args)
  -- function num : 0_5 , upvalues : _ENV, BannerId
  if self._texture then
    ((((CS.PixelNeko).Tools).ScreenShotHelper).WriteAndShare)((os.time)() .. ".png", self._texture)
  end
  local value = ((NekoData.BehaviorManager).BM_Activity):GetShareActivity(BannerId)
  if value == 0 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cshareactivity")
    protocol.bannerId = BannerId
    protocol:Send()
  end
end

ShareSingleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

return ShareSingleDialog

