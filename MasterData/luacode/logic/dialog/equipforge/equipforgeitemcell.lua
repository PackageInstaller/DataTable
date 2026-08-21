-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipforgeitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipForgeItemCell = class("EquipForgeItemCell", Dialog)
EquipForgeItemCell.AssetBundleName = "ui/layouts.equip"
EquipForgeItemCell.AssetName = "EquipForgeItemCell"
EquipForgeItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipForgeItemCell
  self._canClick = true
  ;
  ((EquipForgeItemCell.super).Ctor)(self, ...)
end

EquipForgeItemCell.OnCreate = function(self)
  -- function num : 0_1
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
  ;
  (self._grey):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
end

EquipForgeItemCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

EquipForgeItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  if not data then
    (self._itemCell):SetActive(false)
    ;
    (self._backImg):SetActive(true)
  else
    ;
    (self._itemCell):SetActive(true)
    ;
    (self._backImg):SetActive(false)
    local imageRecord = (data.value):GetIcon()
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = (data.value):GetPinJiImage()
    ;
    (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._count):SetNumber((data.value):GetCount())
    if (self._delegate)._tab == 1 then
      self._canClick = not (self._delegate):IsEquipStrengthenItemEnough()
      if self._canClick then
        (self._grey):SetActive(false)
      else
        ;
        (self._grey):SetActive(true)
      end
      local idemIndex, num = nil, nil
      for i,value in ipairs((self._delegate)._strengthenSelectItemData) do
        if (((self._delegate)._strengthenSelectItemData)[i]).key == ((self._cellData).value):GetID() then
          idemIndex = i
        end
      end
      if idemIndex then
        num = (((self._delegate)._strengthenSelectItemData)[idemIndex]).count
      end
      if num then
        (self._select):SetActive(true)
        ;
        (self._chooseNum):SetActive(true)
        ;
        (self._reduceBtn):SetActive(true)
        ;
        (self._chooseNum):SetNumber(num)
      else
        ;
        (self._select):SetActive(false)
        ;
        (self._chooseNum):SetActive(false)
        ;
        (self._reduceBtn):SetActive(false)
      end
    else
      do
        ;
        (self._grey):SetActive(false)
        do
          local num = ((self._delegate)._selectedItems)[(data.value):GetID()]
          if num then
            (self._select):SetActive(true)
            ;
            (self._chooseNum):SetActive(true)
            ;
            (self._reduceBtn):SetActive(true)
            ;
            (self._chooseNum):SetNumber(num)
          else
            ;
            (self._select):SetActive(false)
            ;
            (self._chooseNum):SetActive(false)
            ;
            (self._reduceBtn):SetActive(false)
          end
          if (self._delegate)._tab == 3 and (data.value):GetCount() == 0 then
            (self._countNone):SetActive(true)
            ;
            (self._count):SetActive(false)
          else
            ;
            (self._countNone):SetActive(false)
            ;
            (self._count):SetActive(true)
          end
        end
      end
    end
  end
end

EquipForgeItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._canClick then
    if (self._delegate)._tab == 3 and ((self._cellData).value):GetCount() == 0 then
      return 
    end
    local kind, num, idemIndex = nil, nil, nil
    for i,value in ipairs((self._delegate)._strengthenSelectItemData) do
      if (((self._delegate)._strengthenSelectItemData)[i]).key == ((self._cellData).value):GetID() then
        idemIndex = i
      end
    end
    if (self._delegate)._tab == 1 then
      if idemIndex then
        num = (((self._delegate)._strengthenSelectItemData)[idemIndex]).count
      end
      kind = (table.nums)((self._delegate)._strengthenSelectItemData)
    else
      if idemIndex then
        num = (((self._delegate)._selectedItems)[idemIndex]).count
      end
      kind = (table.nums)((self._delegate)._selectedItems)
    end
    if (not num and kind < 5) or num and num < ((self._cellData).value):GetCount() then
      (self._delegate):SelectItems(((self._cellData).value):GetID(), (self._cellData).tag)
    end
  end
end

EquipForgeItemCell.OnCellLongPress = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(53) then
    local width, height = (self._itemCell):GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      local temp = {item = (self._cellData).value}
      tipsDialog:Init(temp)
      tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
    end
  end
end

EquipForgeItemCell.OnReduceBtnClicked = function(self)
  -- function num : 0_6
  (self._delegate):ReduceItems(((self._cellData).value):GetID())
end

EquipForgeItemCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7 , upvalues : _ENV
  local id = ((self._cellData).value):GetID()
  if self._cellData then
    if (self._delegate)._tab == 1 then
      if eventName == "ChangeSelectedItemNum" then
        local idemIndex = nil
        for i,value in ipairs((self._delegate)._strengthenSelectItemData) do
          if (((self._delegate)._strengthenSelectItemData)[i]).key == ((self._cellData).value):GetID() and (((self._delegate)._strengthenSelectItemData)[i]).tag == "item" then
            idemIndex = i
            break
          end
        end
        do
          do
            -- DECOMPILER ERROR at PC44: Unhandled construct in 'MakeBoolean' P1

            if arg and arg == id then
              local num = nil
              if ((self._delegate)._strengthenSelectItemData)[idemIndex] then
                num = (((self._delegate)._strengthenSelectItemData)[idemIndex]).count
              end
              if num then
                (self._select):SetActive(true)
                ;
                (self._chooseNum):SetActive(true)
                ;
                (self._reduceBtn):SetActive(true)
                ;
                (self._chooseNum):SetNumber(num)
              else
                ;
                (self._select):SetActive(false)
                ;
                (self._chooseNum):SetActive(false)
                ;
                (self._reduceBtn):SetActive(false)
              end
            end
            do
              local num = nil
              if ((self._delegate)._strengthenSelectItemData)[idemIndex] and (((self._delegate)._strengthenSelectItemData)[idemIndex]).tag == "item" then
                num = (((self._delegate)._strengthenSelectItemData)[idemIndex]).count
              end
              if num then
                (self._select):SetActive(true)
                ;
                (self._chooseNum):SetActive(true)
                ;
                (self._reduceBtn):SetActive(true)
                ;
                (self._chooseNum):SetNumber(num)
              else
                ;
                (self._select):SetActive(false)
                ;
                (self._chooseNum):SetActive(false)
                ;
                (self._reduceBtn):SetActive(false)
              end
              if eventName == "ItemEnough" then
                self._canClick = arg
                ;
                (self._grey):SetActive(not arg)
              end
              do
                -- DECOMPILER ERROR at PC147: Unhandled construct in 'MakeBoolean' P1

                if eventName == "ChangeSelectedItemNum" and arg and arg == id then
                  local num = nil
                  if ((self._delegate)._selectedItems)[arg] then
                    num = (((self._delegate)._selectedItems)[arg]).count
                  end
                  if num then
                    (self._select):SetActive(true)
                    ;
                    (self._chooseNum):SetActive(true)
                    ;
                    (self._reduceBtn):SetActive(true)
                    ;
                    (self._chooseNum):SetNumber(num)
                  else
                    ;
                    (self._select):SetActive(false)
                    ;
                    (self._chooseNum):SetActive(false)
                    ;
                    (self._reduceBtn):SetActive(false)
                  end
                end
                local isSelect, num = nil, nil
                if ((self._delegate)._selectedItems)[id] then
                  isSelect = true
                  num = 1
                end
                if isSelect then
                  (self._select):SetActive(true)
                  ;
                  (self._chooseNum):SetActive(true)
                  ;
                  (self._reduceBtn):SetActive(true)
                  ;
                  (self._chooseNum):SetNumber(num)
                else
                  ;
                  (self._select):SetActive(false)
                  ;
                  (self._chooseNum):SetActive(false)
                  ;
                  (self._reduceBtn):SetActive(false)
                end
              end
            end
          end
        end
      end
    end
  end
end

return EquipForgeItemCell

