-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/gardenpartypage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local GardenPartyPage = class("GardenPartyPage", Dialog)
GardenPartyPage.AssetBundleName = "ui/layouts.activityaprilfools"
GardenPartyPage.AssetName = "ActivityAprilFoolsInto"
GardenPartyPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GardenPartyPage
  ((GardenPartyPage.super).Ctor)(self, ...)
end

GardenPartyPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CStringres
  self._activeTimeTxt = self:GetChild("ActiveTime")
  self._goBtn = self:GetChild("GotoBtn")
  self._goBtnTxt = self:GetChild("GotoBtn/_Text2")
  self._redDot = self:GetChild("GotoBtn/Dot")
  ;
  (self._redDot):SetActive(false)
  self._tipsBtn = self:GetChild("Tips")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (self._activeTimeTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(1792)).msgTextID))
  ;
  (self._goBtnTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(1718)).msgTextID))
end

GardenPartyPage.OnDestroy = function(self)
  -- function num : 0_2
end

GardenPartyPage.OnGoBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolstowermaindialog")
end

GardenPartyPage.OnTipsBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, CStringres
  ((DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolsdaytipsdialog")):SetData((CStringres:GetRecorder(1760)).msgTextID)
end

return GardenPartyPage

