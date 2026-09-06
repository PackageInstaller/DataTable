local MaterialStaticFunctions = CS.PixelNeko.Lua.MaterialStaticFunctions
local GameObjectHelper = CS.PixelNeko.Common.GameObjectHelper
local CardInfoTypeEnum = LuaNetManager.GetBeanDef("protocol.card.cardinfo")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local Role = require("logic.manager.experimental.types.role")
local GachaGetEquipDialog = class("GachaGetEquipDialog", Dialog)
GachaGetEquipDialog.AssetBundleName = "ui/layouts.gacha"
GachaGetEquipDialog.AssetName = "GachaGetEquip"

function GachaGetEquipDialog:Ctor(...)
  GachaGetEquipDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._effects = nil
  self._cardList = {}
  self._tag = false
end

function GachaGetEquipDialog:OnCreate()
  self._photo = self:GetChild("Role/Photo")
  self._title = self:GetChild("UI/ShortInfo/ShortName")
  self._name = self:GetChild("UI/ShortInfo/Name")
  self._job = self:GetChild("UI/Job")
  self._roleName = self:GetChild("UI/JobTxt")
  self._effect = self:GetChild("Effect")
  self._skipBtn = self:GetChild("UI/SkipBtn")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMouseClick, self)
  self._skipBtn:Subscribe_PointerClickEvent(self.OnSkipBtnClick, self)
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnAnimationEnter, self)
  self:SetEffect()
end

function GachaGetEquipDialog:OnDestroy()
  if self._effects then
    for i = 0, self._effects.Length - 1 do
      local effect = self._effects[i]
      GameObjectHelper.DestroyObject(effect)
    end
    self._effects = nil
  end
  local gachaMovieDialog = DialogManager.GetDialog("gacha.gachamoviedialog")
  if gachaMovieDialog then
    gachaMovieDialog:VideoFadeOut()
  end
end

function GachaGetEquipDialog:SetData(cardList)
  self._list = cardList
  for i, v in ipairs(cardList) do
    local itemtype = v.item.itemtype
    local id = v.item.id
    if itemtype == ItemTypeEnum.BASEITEM then
      local item = Item.Create(id)
      if item:IsUniqueEquip() then
        table.insert(self._cardList, v)
      end
    end
  end
  if #self._cardList >= 1 and self._cardList[1] then
    self:Refresh(self._cardList[1], true)
  end
end

function GachaGetEquipDialog:Refresh(card, isFirst)
  if not isFirst then
    local gachaMovieDialog = DialogManager.GetDialog("gacha.gachamoviedialog")
    if gachaMovieDialog then
      gachaMovieDialog:PlayEnd()
    end
  end
  self._tag = false
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1567))
  local uniqueEquipItem = UniqueEquip.Create(card.item.id)
  local imageRecord = uniqueEquipItem:GetIcon()
  self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(uniqueEquipItem:GetName())
  local roleId = uniqueEquipItem:GetRoleId()
  local role = Role.Create(roleId)
  if roleId == DataCommon.LeaderId then
    self._roleName:SetText(NekoData.BehaviorManager.BM_Message:GetString(1433))
  else
    self._roleName:SetText(role:GetRoleName())
  end
  imageRecord = role:GetVocationImgDrawRecord()
  self._job:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self:GetRootWindow():PlayAnimation("UR")
end

function GachaGetEquipDialog:SetEffect()
  self._effects = MaterialStaticFunctions.CopyAndUseMaterialsInChildren(self._effect._uiObject, true)
  if self._effects ~= nil then
    for i = 0, self._effects.Length - 1 do
      local effect = self._effects[i]
      effect:SetFloat("_ZTest", 8)
    end
  end
end

local function ShowResult(self)
  local resultDialog = DialogManager.CreateSingletonDialog("gacha.gacharesultdialog")
  resultDialog:SetDrawCardType(DataCommon.DrawCardType.Equip)
  resultDialog:SetData(self._list)
  self:Destroy()
end

function GachaGetEquipDialog:OnMouseClick()
  if self._tag then
    if #self._cardList > 1 then
      table.remove(self._cardList, 1)
      self:Refresh(self._cardList[1], false)
    else
      ShowResult(self)
    end
  elseif not self._tag then
    self:GetRootWindow():PlayAnimation("GachaUR")
  end
end

function GachaGetEquipDialog:OnSkipBtnClick()
  ShowResult(self)
end

function GachaGetEquipDialog:OnAnimationEnter(handle, statename, normalizedTime)
  if #self._cardList > 0 and statename == "GachaUR" then
    self._tag = true
  end
end

return GachaGetEquipDialog
