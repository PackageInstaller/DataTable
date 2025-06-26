-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/birthday/sharedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ShareDialog = class("ShareDialog", Dialog)
ShareDialog.AssetBundleName = "ui/layouts.activitylogin"
ShareDialog.AssetName = "ActivityLoginShareShot"
ShareDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShareDialog
  ((ShareDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ShareDialog.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Panel/Image")
  self._shareBtn = self:GetChild("ShareBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  self._shareBtnText = self:GetChild("ShareBtn/_Text")
  ;
  (self._shareBtn):Subscribe_PointerClickEvent(self.OnShareClick, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:SetData()
end

ShareDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._texture then
    (((CS.UnityEngine).Object).Destroy)(self._texture)
    self._texture = nil
  end
end

ShareDialog.SetData = function(self, texture)
  -- function num : 0_3 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  ;
  (self._shareBtnText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2096))
  self._texture = texture
  if self._texture then
    ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).LoadTexture)((self._image):GetUIObject(), self._texture)
  end
end

ShareDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

ShareDialog.OnShareClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._texture then
    ((((CS.PixelNeko).Tools).ScreenShotHelper).WriteAndShare)((os.time)() .. ".png", self._texture)
  end
  if (self._bm):GetShareRecord() == 0 then
    (self._bm):SendCBirthShare()
  end
end

return ShareDialog

