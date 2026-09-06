local MaxWordCount, MinWordCount = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.DIYThemeName)
local AddDiyThemeDialog = class("AddDiyThemeDialog", Dialog)
AddDiyThemeDialog.AssetBundleName = "ui/layouts.yard"
AddDiyThemeDialog.AssetName = "HouseAddTheme"

function AddDiyThemeDialog:Ctor(...)
  AddDiyThemeDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function AddDiyThemeDialog:OnCreate()
  self._addThemeTxt = self:GetChild("Back/Title")
  self._changeThemeTxt = self:GetChild("Back/Title2")
  self._name = self:GetChild("Back/InputField")
  self._inputTextNum = self:GetChild("Back/Textnew1")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self:GetChild("Back/Txt1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1573, {MinWordCount, MaxWordCount}))
  self._name:Subscribe_ValueChangedEvent(self.OnNameUpdate, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._addThemeTxt:SetActive(true)
  self._changeThemeTxt:SetActive(false)
  self._name:SetText("")
  self:OnNameUpdate()
end

function AddDiyThemeDialog:OnDestroy()
end

function AddDiyThemeDialog:OnNameUpdate()
  local name = self._name:GetText()
  name = string.trim(name)
  self._changeName = name
  local count = utf8.len(name)
  if count > MaxWordCount then
    self._inputTextNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1570, {count, MaxWordCount}))
  else
    self._inputTextNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1569, {count, MaxWordCount}))
  end
end

function AddDiyThemeDialog:OnBackBtnClicked()
  self:Destroy()
end

function AddDiyThemeDialog:OnConfirmBtnClicked()
  local list = {}
  local interactModalDialog = DialogManager.GetDialog("courtcabin.interactmodaldialog")
  if interactModalDialog then
    local map = interactModalDialog._cabinSceneController._furnitures[interactModalDialog._selectRoomId]
    local overlap = false
    for k, v in pairs(map) do
      if interactModalDialog._cabinSceneController:CheckOverlap(k) then
        overlap = true
        break
      end
    end
    if overlap then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100169)
    else
      for k, v in pairs(map) do
        for key, furniture in pairs(v) do
          local pos = furniture:GetLeftDownGridPos()
          local furnitureBean = LuaNetManager.CreateBean("protocol.yard.furnitureposition")
          furnitureBean.itemId = furniture:GetItem():GetID()
          local pointBean = LuaNetManager.CreateBean("protocol.yard.point")
          pointBean.x = pos.x
          pointBean.y = pos.y
          furnitureBean.point = pointBean
          table.insert(list, furnitureBean)
        end
      end
      local caddTheme = LuaNetManager.CreateProtocol("protocol.yard.caddtheme")
      caddTheme.name = self._changeName
      caddTheme.furniture = list
      caddTheme:Send()
    end
  end
end

return AddDiyThemeDialog
