-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipforgeequipcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipForgeEquipCell = class("EquipForgeEquipCell", Dialog)
EquipForgeEquipCell.AssetBundleName = "ui/layouts.equip"
EquipForgeEquipCell.AssetName = "EquipForgeEquipCell"
EquipForgeEquipCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipForgeEquipCell
  self._canClick = true
  ;
  ((EquipForgeEquipCell.super).Ctor)(self, ...)
end

EquipForgeEquipCell.OnCreate = function(self)
  -- function num : 0_1
  self._panel = self:GetChild("Frame/Panel")
  self._frame = self:GetChild("Frame/Panel/Frame")
  self._icon = self:GetChild("Frame/Panel/Icon")
  self._strengthenLv = self:GetChild("Frame/Panel/Level")
  self._strengthenLvNum = self:GetChild("Frame/Panel/Level/Num")
  self._strengthenLvMax = self:GetChild("Frame/Panel/Level/NumMax")
  ;
  (self._strengthenLvMax):SetActive(false)
  self._levelTxt = self:GetChild("Frame/Panel/Level/Txt")
  ;
  (self._levelTxt):SetActive(false)
  self._grey = self:GetChild("Frame/Panel/Grey")
  self._select = self:GetChild("Frame/Panel/Select")
  self._charPhoto = self:GetChild("Frame/Panel/CharPhoto")
  self._charBack = self:GetChild("Frame/Panel/CharBack")
  self._reduceBtn = self:GetChild("Frame/Panel/Reduce")
  self._breakPoint = self:GetChild("Frame/Panel/BreakPoint")
  ;
  (self._grey):SetActive(false)
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
end

EquipForgeEquipCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

EquipForgeEquipCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._reduceBtn):SetActive(false)
  if not data then
    (self._panel):SetActive(false)
  else
    if (self._delegate).GetSelectEquipKey and data:GetKey() == (self._delegate):GetSelectEquipKey() then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
    ;
    (self._panel):SetActive(true)
    local record = nil
    ;
    (self._frame):SetActive(true)
    ;
    (self._strengthenLv):SetActive(true)
    record = (data.value):GetPinJiImage()
    ;
    (self._frame):SetSprite(record.assetBundle, record.assetName)
    ;
    (self._strengthenLvNum):SetText((data.value):GetStrengthenLevel())
    record = (data.value):GetIcon()
    ;
    (self._icon):SetSprite(record.assetBundle, record.assetName)
    ;
    (self._breakPoint):SetText((data.value):GetEquipStarStr())
    local roleKey = (data.value):GetRoleKey()
    if roleKey ~= 0 then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
      ;
      (self._charPhoto):SetActive(true)
      ;
      (self._charBack):SetActive(true)
      local imageRecord = role:GetSkillHeadImageRecord()
      ;
      (self._charPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      do
        ;
        (self._charPhoto):SetActive(false)
        ;
        (self._charBack):SetActive(false)
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
            if (((self._delegate)._strengthenSelectItemData)[i]).key == ((self._cellData).value):GetKey() then
              idemIndex = i
            end
          end
          if idemIndex then
            (self._select):SetActive(true)
            ;
            (self._reduceBtn):SetActive(true)
          else
            ;
            (self._select):SetActive(false)
            ;
            (self._reduceBtn):SetActive(false)
          end
        else
          do
            self._canClick = (self._delegate):IsEquipBreakFull()
            ;
            (self._grey):SetActive(false)
            local key = ((data.value):GetKey())
            local exist = nil
            for i,v in ipairs((self._delegate)._selectedItems) do
              if v == key then
                exist = true
                break
              end
            end
            do
              if exist then
                (self._select):SetActive(true)
                ;
                (self._reduceBtn):SetActive(true)
              else
                ;
                (self._select):SetActive(false)
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

EquipForgeEquipCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._canClick then
    local kind, num, idemIndex = nil, nil, nil
    for i,value in ipairs((self._delegate)._strengthenSelectItemData) do
      if (((self._delegate)._strengthenSelectItemData)[i]).key == ((self._cellData).value):GetKey() then
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
      (self._delegate):SelectItems(((self._cellData).value):GetKey(), (self._cellData).tag)
    end
  end
end

EquipForgeEquipCell.OnCellLongPress = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
  if tipsDialog then
    tipsDialog:Init(((self._cellData).value):GetKey())
    tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_5_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
  end
end

EquipForgeEquipCell.OnReduceBtnClicked = function(self)
  -- function num : 0_6
  (self._delegate):ReduceItems(((self._cellData).value):GetKey())
end

EquipForgeEquipCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7 , upvalues : _ENV
  local id = ((self._cellData).value):GetKey()
  if self._cellData then
    if (self._delegate)._tab == 1 then
      if eventName == "ChangeSelectedItemNum" then
        local idemIndex = nil
        for i,value in ipairs((self._delegate)._strengthenSelectItemData) do
          if (((self._delegate)._strengthenSelectItemData)[i]).key == ((self._cellData).value):GetKey() and (((self._delegate)._strengthenSelectItemData)[i]).tag == "equip" then
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
                (self._reduceBtn):SetActive(true)
              else
                ;
                (self._select):SetActive(false)
                ;
                (self._reduceBtn):SetActive(false)
              end
            end
            do
              local num = nil
              if ((self._delegate)._strengthenSelectItemData)[idemIndex] and (((self._delegate)._strengthenSelectItemData)[idemIndex]).tag == "equip" then
                num = (((self._delegate)._strengthenSelectItemData)[idemIndex]).count
              end
              if num then
                (self._select):SetActive(true)
                ;
                (self._reduceBtn):SetActive(true)
              else
                ;
                (self._select):SetActive(false)
                ;
                (self._reduceBtn):SetActive(false)
              end
              if eventName == "ItemEnough" then
                self._canClick = arg
                ;
                (self._grey):SetActive(not arg)
              end
              if eventName == "ChangeSelectedItemNum" then
                if self:IsSelectedItem() then
                  (self._select):SetActive(true)
                  ;
                  (self._reduceBtn):SetActive(true)
                else
                  ;
                  (self._select):SetActive(false)
                  ;
                  (self._reduceBtn):SetActive(false)
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
      end
    end
  end
end

EquipForgeEquipCell.IsSelectedItem = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local isSelectedItem = false
  local id = ((self._cellData).value):GetKey()
  for i,v in ipairs((self._delegate)._selectedItems) do
    if v == id then
      isSelectedItem = true
      break
    end
  end
  do
    return isSelectedItem
  end
end

return EquipForgeEquipCell

