-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/anniversaryshare/shareresultdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local ShareResultDialog = class("ShareResultDialog", Dialog)
ShareResultDialog.AssetBundleName = "ui/layouts.welfare"
ShareResultDialog.AssetName = "ActivityShareWelfareMain"
ShareResultDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShareResultDialog
  ((ShareResultDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ShareResultDialog.OnCreate = function(self)
  -- function num : 0_1
  self._shareBtnTxt = self:GetChild("Back/Btn/Text")
  self._image = self:GetChild("Back/BackImage")
  self._shareBtn = self:GetChild("Back/Btn")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._shareBtn):Subscribe_PointerClickEvent(self.OnShareClick, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

ShareResultDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._texture then
    (((CS.UnityEngine).Object).Destroy)(self._texture)
    self._texture = nil
  end
end

ShareResultDialog.SetData = function(self, texture)
  -- function num : 0_3 , upvalues : _ENV, CStringres
  self._dm = (NekoData.DataManager).DM_AnniversaryShare
  self._bm = (NekoData.BehaviorManager).BM_AnniversaryShare
  ;
  (self._shareBtnTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(2042)).msgTextID))
  self._texture = texture
  if self._texture then
    ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).LoadTexture)((self._image):GetUIObject(), self._texture)
  end
end

ShareResultDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

ShareResultDialog.OnShareClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._texture then
    ((((CS.PixelNeko).Tools).ScreenShotHelper).WriteAndShare)((os.time)() .. ".png", self._texture)
  end
  ;
  (self._bm):SendCAnniversaryShare()
  self:Destroy()
end

return ShareResultDialog

