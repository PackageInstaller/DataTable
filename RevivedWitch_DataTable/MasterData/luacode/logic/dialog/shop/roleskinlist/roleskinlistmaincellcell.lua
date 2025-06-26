-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/roleskinlist/roleskinlistmaincellcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local RoleSkinListMainCellCell = class("RoleSkinListMainCellCell", Dialog)
RoleSkinListMainCellCell.AssetBundleName = "ui/layouts.baseshop"
RoleSkinListMainCellCell.AssetName = "FashionShopListClothesCell"
RoleSkinListMainCellCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleSkinListMainCellCell
  ((RoleSkinListMainCellCell.super).Ctor)(self, ...)
end

RoleSkinListMainCellCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._charName = self:GetChild("Cell/CharName/CharName")
  self._nameTxt = self:GetChild("Cell/Name")
  self._charImg = self:GetChild("Cell/Char")
  self._notGetBtn_Txt = self:GetChild("Cell/NotGet/Txt")
  self._notGetBtn = self:GetChild("Cell/NotGet")
  self._limit = self:GetChild("Cell/Limit")
  self._limit_Txt = self:GetChild("Cell/Limit/Txt")
  self._getBtn = self:GetChild("Cell/Get")
  self._getBtn_Txt = self:GetChild("Cell/Get/Txt")
  ;
  (self._limit):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._notGetBtn_Txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1907))
  ;
  (self._getBtn_Txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1906))
end

RoleSkinListMainCellCell.OnDestroy = function(self)
  -- function num : 0_2
end

RoleSkinListMainCellCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Role, _ENV
  self._data = data
  local imgRecord = (self._data):GetBigBustImg()
  ;
  (self._charImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._nameTxt):SetText((self._data):GetSkinName())
  self._role = (Role.Create)((self._data):GetRoleIdBySkin())
  ;
  (self._charName):SetText((self._role):GetRoleName())
  self._isGet = ((NekoData.BehaviorManager).BM_SkinList):IsUnLockSkin((self._data):GetSkinId())
  ;
  (self._notGetBtn):SetActive(not self._isGet)
  ;
  (self._getBtn):SetActive(self._isGet)
end

RoleSkinListMainCellCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local roleUnlock = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock((self._role):GetRoleId())
  if self._isGet and roleUnlock then
    self:JumpToRoleSkin()
  else
    if not ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(6) then
      self._shopGoodInfo = {}
      for i,v in ipairs(self._shopGoodInfo) do
        if v.itemId == (self._data):GetSkinId() then
          local dialog = (DialogManager.CreateSingletonDialog)("shop.fashionbuydialog")
          do
            do
              if dialog then
                local data = {}
                ;
                (table.insert)(data, (self._shopGoodInfo)[i])
                dialog:SetData((dialog.TargetType).Shop, data, nil, 6)
              end
              do return  end
              -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      local dialog = (DialogManager.CreateSingletonDialog)("shop.fashionbuydialog")
      if dialog then
        local data = {}
        ;
        (table.insert)(data, {itemId = (self._data):GetSkinId()})
        dialog:SetData((dialog.TargetType).SkinList, data)
      end
    end
  end
end

RoleSkinListMainCellCell.JumpToRoleSkin = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._role):GetRoleId())
  local dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
  if not dialog and role then
    dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
    dialog:JumpAndSetSelectFashion(role, (self._data):GetSkinId())
  end
end

RoleSkinListMainCellCell.OnEvent = function(self, name, args)
  -- function num : 0_6 , upvalues : _ENV
  if name == "UnLock" and (self._cellData):GetSkinId() == tonumber(args) then
    (self._notGetBtn):SetActive(false)
    ;
    (self._getBtn):SetActive(true)
  end
end

return RoleSkinListMainCellCell

