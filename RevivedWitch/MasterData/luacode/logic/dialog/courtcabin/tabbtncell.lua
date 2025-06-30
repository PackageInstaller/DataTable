-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/tabbtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DressUpCabinDialog = require("logic.dialog.courtcabin.dressupcabindialog")
local TabBtnCell = class("TabBtnCell", Dialog)
TabBtnCell.AssetBundleName = "ui/layouts.yard"
TabBtnCell.AssetName = "HouseDecorateBtnCell"
TabBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TabBtnCell
  ((TabBtnCell.super).Ctor)(self, ...)
end

TabBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("Btn")
  self._normalTxt = self:GetChild("Btn/Txt")
  self._selectTxt = self:GetChild("Btn/TxtNum")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClicked, self)
end

TabBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

TabBtnCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, DressUpCabinDialog
  self._recorder = data.recorder
  self._special = false
  for k,v in pairs(DressUpCabinDialog.SpecialTabType) do
    if v == (self._recorder).id then
      self._special = true
      break
    end
  end
  do
    if self._special then
      (self._normalTxt):SetActive(false)
      ;
      (self._selectTxt):SetActive(true)
      local str = nil
      if (self._recorder).id == (DressUpCabinDialog.SpecialTabType).Theme then
        str = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1218)).msgTextID)
      else
        if (self._recorder).id == (DressUpCabinDialog.SpecialTabType).All then
          str = (TextManager.GetText)(800324)
        end
      end
      ;
      (self._selectTxt):SetText(str)
    else
      do
        if not self._special then
          (self._normalTxt):SetText((self._recorder).name)
          ;
          (self._selectTxt):SetText((self._recorder).name .. data.usedNum .. "/" .. (self._recorder).num)
        end
        if (self._recorder).id == (self._delegate)._selectTabId then
          (self._btn):SetSelected(true)
          if not self._special then
            (self._normalTxt):SetActive(false)
            ;
            (self._selectTxt):SetActive(true)
          end
        else
          ;
          (self._btn):SetSelected(false)
          if not self._special then
            (self._normalTxt):SetActive(true)
            ;
            (self._selectTxt):SetActive(false)
          end
        end
      end
    end
  end
end

TabBtnCell.OnBtnClicked = function(self)
  -- function num : 0_4
  (self._delegate):SetSelectTab((self._recorder).id)
end

TabBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "SetSelectTab" then
    if (self._recorder).id == arg then
      (self._btn):SetSelected(true)
      if not self._special then
        (self._normalTxt):SetActive(false)
        ;
        (self._selectTxt):SetActive(true)
      end
    else
      ;
      (self._btn):SetSelected(false)
      if not self._special then
        (self._normalTxt):SetActive(true)
        ;
        (self._selectTxt):SetActive(false)
      end
    end
  end
end

return TabBtnCell

