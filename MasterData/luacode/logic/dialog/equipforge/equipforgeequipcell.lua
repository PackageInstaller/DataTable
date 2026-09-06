local EquipForgeEquipCell = class("EquipForgeEquipCell", Dialog)
EquipForgeEquipCell.AssetBundleName = "ui/layouts.equip"
EquipForgeEquipCell.AssetName = "EquipForgeEquipCell"

function EquipForgeEquipCell:Ctor(...)
  self._canClick = true
  EquipForgeEquipCell.super.Ctor(self, ...)
end

function EquipForgeEquipCell:OnCreate()
  self._panel = self:GetChild("Frame/Panel")
  self._frame = self:GetChild("Frame/Panel/Frame")
  self._icon = self:GetChild("Frame/Panel/Icon")
  self._strengthenLv = self:GetChild("Frame/Panel/Level")
  self._strengthenLvNum = self:GetChild("Frame/Panel/Level/Num")
  self._strengthenLvMax = self:GetChild("Frame/Panel/Level/NumMax")
  self._strengthenLvMax:SetActive(false)
  self._levelTxt = self:GetChild("Frame/Panel/Level/Txt")
  self._levelTxt:SetActive(false)
  self._grey = self:GetChild("Frame/Panel/Grey")
  self._select = self:GetChild("Frame/Panel/Select")
  self._charPhoto = self:GetChild("Frame/Panel/CharPhoto")
  self._charBack = self:GetChild("Frame/Panel/CharBack")
  self._reduceBtn = self:GetChild("Frame/Panel/Reduce")
  self._breakPoint = self:GetChild("Frame/Panel/BreakPoint")
  self._grey:SetActive(false)
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnCellLongPress, self)
end

function EquipForgeEquipCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function EquipForgeEquipCell:RefreshCell(data)
  self._reduceBtn:SetActive(false)
  if not data then
    self._panel:SetActive(false)
  else
    if self._delegate.GetSelectEquipKey and data:GetKey() == self._delegate:GetSelectEquipKey() then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
    self._panel:SetActive(true)
    local record
    self._frame:SetActive(true)
    self._strengthenLv:SetActive(true)
    record = data.value:GetPinJiImage()
    self._frame:SetSprite(record.assetBundle, record.assetName)
    self._strengthenLvNum:SetText(data.value:GetStrengthenLevel())
    record = data.value:GetIcon()
    self._icon:SetSprite(record.assetBundle, record.assetName)
    self._breakPoint:SetText(data.value:GetEquipStarStr())
    local roleKey = data.value:GetRoleKey()
    if roleKey ~= 0 then
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
      self._charPhoto:SetActive(true)
      self._charBack:SetActive(true)
      local imageRecord = role:GetSkillHeadImageRecord()
      self._charPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      self._charPhoto:SetActive(false)
      self._charBack:SetActive(false)
    end
    if self._delegate._tab == 1 then
      self._canClick = not self._delegate:IsEquipStrengthenItemEnough()
      if self._canClick then
        self._grey:SetActive(false)
      else
        self._grey:SetActive(true)
      end
      local idemIndex, num
      for i, value in ipairs(self._delegate._strengthenSelectItemData) do
        if self._delegate._strengthenSelectItemData[i].key == self._cellData.value:GetKey() then
          idemIndex = i
        end
      end
      if idemIndex then
        self._select:SetActive(true)
        self._reduceBtn:SetActive(true)
      else
        self._select:SetActive(false)
        self._reduceBtn:SetActive(false)
      end
    else
      self._canClick = self._delegate:IsEquipBreakFull()
      self._grey:SetActive(false)
      local key = data.value:GetKey()
      local exist
      for i, v in ipairs(self._delegate._selectedItems) do
        if v == key then
          exist = true
          break
        end
      end
      if exist then
        self._select:SetActive(true)
        self._reduceBtn:SetActive(true)
      else
        self._select:SetActive(false)
        self._reduceBtn:SetActive(false)
      end
    end
  end
end

function EquipForgeEquipCell:OnCellClicked()
  if self._canClick then
    local kind, num, idemIndex
    for i, value in ipairs(self._delegate._strengthenSelectItemData) do
      if self._delegate._strengthenSelectItemData[i].key == self._cellData.value:GetKey() then
        idemIndex = i
      end
    end
    if self._delegate._tab == 1 then
      if idemIndex then
        num = self._delegate._strengthenSelectItemData[idemIndex].count
      end
      kind = table.nums(self._delegate._strengthenSelectItemData)
    else
      if idemIndex then
        num = self._delegate._selectedItems[idemIndex].count
      end
      kind = table.nums(self._delegate._selectedItems)
    end
    if not num and kind < 5 or num and num < self._cellData.value:GetCount() then
      self._delegate:SelectItems(self._cellData.value:GetKey(), self._cellData.tag)
    end
  end
end

function EquipForgeEquipCell:OnCellLongPress()
  local tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
  if tipsDialog then
    tipsDialog:Init(self._cellData.value:GetKey())
    tipsDialog:SetTipsParmFunc(function()
      local width, height = self:GetRootWindow():GetRectSize()
      local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
      return {
        width = width,
        height = height,
        posX = pos.x,
        posY = pos.y
      }
    end)
  end
end

function EquipForgeEquipCell:OnReduceBtnClicked()
  self._delegate:ReduceItems(self._cellData.value:GetKey())
end

function EquipForgeEquipCell:OnEvent(eventName, arg)
  local id = self._cellData.value:GetKey()
  if self._cellData then
    if self._delegate._tab == 1 then
      if eventName == "ChangeSelectedItemNum" then
        local idemIndex
        for i, value in ipairs(self._delegate._strengthenSelectItemData) do
          if self._delegate._strengthenSelectItemData[i].key == self._cellData.value:GetKey() and self._delegate._strengthenSelectItemData[i].tag == "equip" then
            idemIndex = i
            break
          end
        end
        if arg then
          if arg == id then
            local num
            if self._delegate._strengthenSelectItemData[idemIndex] then
              num = self._delegate._strengthenSelectItemData[idemIndex].count
            end
            if num then
              self._select:SetActive(true)
              self._reduceBtn:SetActive(true)
            else
              self._select:SetActive(false)
              self._reduceBtn:SetActive(false)
            end
          end
        else
          local num
          if self._delegate._strengthenSelectItemData[idemIndex] and self._delegate._strengthenSelectItemData[idemIndex].tag == "equip" then
            num = self._delegate._strengthenSelectItemData[idemIndex].count
          end
          if num then
            self._select:SetActive(true)
            self._reduceBtn:SetActive(true)
          else
            self._select:SetActive(false)
            self._reduceBtn:SetActive(false)
          end
        end
      end
      if eventName == "ItemEnough" then
        self._canClick = arg
        self._grey:SetActive(not arg)
      end
    else
      if eventName == "ChangeSelectedItemNum" then
        if self:IsSelectedItem() then
          self._select:SetActive(true)
          self._reduceBtn:SetActive(true)
        else
          self._select:SetActive(false)
          self._reduceBtn:SetActive(false)
        end
      end
      if eventName == "EquipBreakFull" then
        self._canClick = false
      end
      if eventName == "EquipBreakNotFull" then
        self._canClick = true
      end
    end
  end
end

function EquipForgeEquipCell:IsSelectedItem()
  local isSelectedItem = false
  local id = self._cellData.value:GetKey()
  for i, v in ipairs(self._delegate._selectedItems) do
    if v == id then
      isSelectedItem = true
      break
    end
  end
  return isSelectedItem
end

return EquipForgeEquipCell
