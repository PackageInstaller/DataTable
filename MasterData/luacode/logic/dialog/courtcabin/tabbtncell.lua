local DressUpCabinDialog = require("logic.dialog.courtcabin.dressupcabindialog")
local TabBtnCell = class("TabBtnCell", Dialog)
TabBtnCell.AssetBundleName = "ui/layouts.yard"
TabBtnCell.AssetName = "HouseDecorateBtnCell"

function TabBtnCell:Ctor(...)
  TabBtnCell.super.Ctor(self, ...)
end

function TabBtnCell:OnCreate()
  self._btn = self:GetChild("Btn")
  self._normalTxt = self:GetChild("Btn/Txt")
  self._selectTxt = self:GetChild("Btn/TxtNum")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClicked, self)
end

function TabBtnCell:OnDestroy()
end

function TabBtnCell:RefreshCell(data)
  self._recorder = data.recorder
  self._special = false
  for k, v in pairs(DressUpCabinDialog.SpecialTabType) do
    if v == self._recorder.id then
      self._special = true
      break
    end
  end
  if self._special then
    self._normalTxt:SetActive(false)
    self._selectTxt:SetActive(true)
    local str
    if self._recorder.id == DressUpCabinDialog.SpecialTabType.Theme then
      str = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1218).msgTextID)
    elseif self._recorder.id == DressUpCabinDialog.SpecialTabType.All then
      str = TextManager.GetText(800324)
    end
    self._selectTxt:SetText(str)
  elseif not self._special then
    self._normalTxt:SetText(self._recorder.name)
    self._selectTxt:SetText(self._recorder.name .. data.usedNum .. "/" .. self._recorder.num)
  end
  if self._recorder.id == self._delegate._selectTabId then
    self._btn:SetSelected(true)
    if not self._special then
      self._normalTxt:SetActive(false)
      self._selectTxt:SetActive(true)
    end
  else
    self._btn:SetSelected(false)
    if not self._special then
      self._normalTxt:SetActive(true)
      self._selectTxt:SetActive(false)
    end
  end
end

function TabBtnCell:OnBtnClicked()
  self._delegate:SetSelectTab(self._recorder.id)
end

function TabBtnCell:OnEvent(eventName, arg)
  if eventName == "SetSelectTab" then
    if self._recorder.id == arg then
      self._btn:SetSelected(true)
      if not self._special then
        self._normalTxt:SetActive(false)
        self._selectTxt:SetActive(true)
      end
    else
      self._btn:SetSelected(false)
      if not self._special then
        self._normalTxt:SetActive(true)
        self._selectTxt:SetActive(false)
      end
    end
  end
end

return TabBtnCell
