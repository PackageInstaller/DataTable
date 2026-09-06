local EquipForgeItemCell = class("EquipForgeItemCell", Dialog)
EquipForgeItemCell.AssetBundleName = "ui/layouts.equip"
EquipForgeItemCell.AssetName = "EquipForgeItemCell"

function EquipForgeItemCell:Ctor(...)
  self._canClick = true
  EquipForgeItemCell.super.Ctor(self, ...)
end

function EquipForgeItemCell:OnCreate()
  self._backImg = self:GetChild("BackGround")
  self._itemCell = self:GetChild("ItemCell")
  self._frame = self:GetChild("ItemCell/Frame")
  self._icon = self:GetChild("ItemCell/Icon")
  self._select = self:GetChild("ItemCell/Select")
  self._count = self:GetChild("ItemCell/Count")
  self._countNone = self:GetChild("ItemCell/Count0")
  self._chooseNum = self:GetChild("ItemCell/CountChoose")
  self._reduceBtn = self:GetChild("ItemCell/Reduce")
  self._grey = self:GetChild("ItemCell/Grey")
  self._grey:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnCellLongPress, self)
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
end

function EquipForgeItemCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function EquipForgeItemCell:RefreshCell(data)
  if not data then
    self._itemCell:SetActive(false)
    self._backImg:SetActive(true)
  else
    self._itemCell:SetActive(true)
    self._backImg:SetActive(false)
    local imageRecord = data.value:GetIcon()
    self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = data.value:GetPinJiImage()
    self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._count:SetNumber(data.value:GetCount())
    if self._delegate._tab == 1 then
      self._canClick = not self._delegate:IsEquipStrengthenItemEnough()
      if self._canClick then
        self._grey:SetActive(false)
      else
        self._grey:SetActive(true)
      end
      local idemIndex, num
      for i, value in ipairs(self._delegate._strengthenSelectItemData) do
        if self._delegate._strengthenSelectItemData[i].key == self._cellData.value:GetID() then
          idemIndex = i
        end
      end
      if idemIndex then
        num = self._delegate._strengthenSelectItemData[idemIndex].count
      end
      if num then
        self._select:SetActive(true)
        self._chooseNum:SetActive(true)
        self._reduceBtn:SetActive(true)
        self._chooseNum:SetNumber(num)
      else
        self._select:SetActive(false)
        self._chooseNum:SetActive(false)
        self._reduceBtn:SetActive(false)
      end
    elseif self._delegate._tab == 4 then
      self._select:SetActive(false)
      self._reduceBtn:SetActive(false)
      self._chooseNum:SetActive(false)
    else
      self._grey:SetActive(false)
      local num = self._delegate._selectedItems[data.value:GetID()]
      if num then
        self._select:SetActive(true)
        self._chooseNum:SetActive(true)
        self._reduceBtn:SetActive(true)
        self._chooseNum:SetNumber(num)
      else
        self._select:SetActive(false)
        self._chooseNum:SetActive(false)
        self._reduceBtn:SetActive(false)
      end
    end
    if self._delegate._tab == 3 and data.value:GetCount() == 0 then
      self._countNone:SetActive(true)
      self._count:SetActive(false)
    else
      self._countNone:SetActive(false)
      self._count:SetActive(true)
    end
  end
end

function EquipForgeItemCell:OnCellClicked()
  if self._canClick then
    if self._delegate._tab == 3 and self._cellData.value:GetCount() == 0 then
      return
    end
    if self._delegate._tab == 4 then
      local gemId = self._cellData.value:GetID()
      self._delegate:SelectItems(gemId, self._cellData.tag)
      self._delegate:OpenGemTips(gemId, function()
        local width, height = self:GetRootWindow():GetRectSize()
        local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
      return
    end
    local kind, num, idemIndex
    for i, value in ipairs(self._delegate._strengthenSelectItemData) do
      if self._delegate._strengthenSelectItemData[i].key == self._cellData.value:GetID() then
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
      self._delegate:SelectItems(self._cellData.value:GetID(), self._cellData.tag)
    end
  end
end

function EquipForgeItemCell:OnCellLongPress()
  if not NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(53) then
    local width, height = self._itemCell:GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      local temp = {
        item = self._cellData.value
      }
      tipsDialog:Init(temp)
      tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
    end
  end
end

function EquipForgeItemCell:OnReduceBtnClicked()
  self._delegate:ReduceItems(self._cellData.value:GetID())
end

function EquipForgeItemCell:OnEvent(eventName, arg)
  local id = self._cellData.value:GetID()
  if self._cellData then
    if self._delegate._tab == 1 then
      if eventName == "ChangeSelectedItemNum" then
        local idemIndex
        for i, value in ipairs(self._delegate._strengthenSelectItemData) do
          if self._delegate._strengthenSelectItemData[i].key == self._cellData.value:GetID() and self._delegate._strengthenSelectItemData[i].tag == "item" then
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
              self._chooseNum:SetActive(true)
              self._reduceBtn:SetActive(true)
              self._chooseNum:SetNumber(num)
            else
              self._select:SetActive(false)
              self._chooseNum:SetActive(false)
              self._reduceBtn:SetActive(false)
            end
          end
        else
          local num
          if self._delegate._strengthenSelectItemData[idemIndex] and self._delegate._strengthenSelectItemData[idemIndex].tag == "item" then
            num = self._delegate._strengthenSelectItemData[idemIndex].count
          end
          if num then
            self._select:SetActive(true)
            self._chooseNum:SetActive(true)
            self._reduceBtn:SetActive(true)
            self._chooseNum:SetNumber(num)
          else
            self._select:SetActive(false)
            self._chooseNum:SetActive(false)
            self._reduceBtn:SetActive(false)
          end
        end
      end
      if eventName == "ItemEnough" then
        self._canClick = arg
        self._grey:SetActive(not arg)
      end
    elseif self._delegate._tab == 4 then
      if eventName == "ChangeSelectedItemNum" then
        self._select:SetActive(self._delegate._selectedItems[id] or false)
      end
    elseif eventName == "ChangeSelectedItemNum" then
      if arg then
        if arg == id then
          local num
          if self._delegate._selectedItems[arg] then
            num = self._delegate._selectedItems[arg].count
          end
          if num then
            self._select:SetActive(true)
            self._chooseNum:SetActive(true)
            self._reduceBtn:SetActive(true)
            self._chooseNum:SetNumber(num)
          else
            self._select:SetActive(false)
            self._chooseNum:SetActive(false)
            self._reduceBtn:SetActive(false)
          end
        end
      else
        local isSelect, num
        if self._delegate._selectedItems[id] then
          isSelect = true
          num = 1
        end
        if isSelect then
          self._select:SetActive(true)
          self._chooseNum:SetActive(true)
          self._reduceBtn:SetActive(true)
          self._chooseNum:SetNumber(num)
        else
          self._select:SetActive(false)
          self._chooseNum:SetActive(false)
          self._reduceBtn:SetActive(false)
        end
      end
    end
  end
end

return EquipForgeItemCell
