local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local RoleSkinListMainCellCell = class("RoleSkinListMainCellCell", Dialog)
RoleSkinListMainCellCell.AssetBundleName = "ui/layouts.baseshop"
RoleSkinListMainCellCell.AssetName = "FashionShopListClothesCell"

function RoleSkinListMainCellCell:Ctor(...)
  RoleSkinListMainCellCell.super.Ctor(self, ...)
end

function RoleSkinListMainCellCell:OnCreate()
  self._charName = self:GetChild("Cell/CharName/CharName")
  self._nameTxt = self:GetChild("Cell/Name")
  self._charImg = self:GetChild("Cell/Char")
  self._notGetBtn_Txt = self:GetChild("Cell/NotGet/Txt")
  self._notGetBtn = self:GetChild("Cell/NotGet")
  self._limit = self:GetChild("Cell/Limit")
  self._limit_Txt = self:GetChild("Cell/Limit/Txt")
  self._getBtn = self:GetChild("Cell/Get")
  self._getBtn_Txt = self:GetChild("Cell/Get/Txt")
  self._limit:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._notGetBtn_Txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1907))
  self._getBtn_Txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1906))
end

function RoleSkinListMainCellCell:OnDestroy()
end

function RoleSkinListMainCellCell:RefreshCell(data)
  self._data = data
  local imgRecord = self._data:GetBigBustImg()
  self._charImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._nameTxt:SetText(self._data:GetSkinName())
  self._role = Role.Create(self._data:GetRoleIdBySkin())
  self._charName:SetText(self._role:GetRoleName())
  self._isGet = NekoData.BehaviorManager.BM_SkinList:IsUnLockSkin(self._data:GetSkinId())
  self._notGetBtn:SetActive(not self._isGet)
  self._getBtn:SetActive(self._isGet)
end

function RoleSkinListMainCellCell:OnCellClicked()
  local roleUnlock = NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(self._role:GetRoleId())
  if self._isGet and roleUnlock then
    self:JumpToRoleSkin()
  else
    self._shopGoodInfo = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(6) or {}
    for i, v in ipairs(self._shopGoodInfo) do
      if v.itemId == self._data:GetSkinId() then
        local dialog = DialogManager.CreateSingletonDialog("shop.fashionbuydialog")
        if dialog then
          local data = {}
          table.insert(data, self._shopGoodInfo[i])
          dialog:SetData(dialog.TargetType.Shop, data, nil, 6)
        end
        return
      end
    end
    local dialog = DialogManager.CreateSingletonDialog("shop.fashionbuydialog")
    if dialog then
      local data = {}
      table.insert(data, {
        itemId = self._data:GetSkinId()
      })
      dialog:SetData(dialog.TargetType.SkinList, data)
    end
  end
end

function RoleSkinListMainCellCell:JumpToRoleSkin()
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._role:GetRoleId())
  local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  if not dialog and role then
    dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
    dialog:JumpAndSetSelectFashion(role, self._data:GetSkinId())
  end
end

function RoleSkinListMainCellCell:OnEvent(name, args)
  if name == "UnLock" and self._cellData:GetSkinId() == tonumber(args) then
    self._notGetBtn:SetActive(false)
    self._getBtn:SetActive(true)
  end
end

return RoleSkinListMainCellCell
