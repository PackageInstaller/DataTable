-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gachagetequipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MaterialStaticFunctions = ((CS.PixelNeko).Lua).MaterialStaticFunctions
local GameObjectHelper = ((CS.PixelNeko).Common).GameObjectHelper
local CardInfoTypeEnum = (LuaNetManager.GetBeanDef)("protocol.card.cardinfo")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local Role = require("logic.manager.experimental.types.role")
local GachaGetEquipDialog = class("GachaGetEquipDialog", Dialog)
GachaGetEquipDialog.AssetBundleName = "ui/layouts.gacha"
GachaGetEquipDialog.AssetName = "GachaGetEquip"
GachaGetEquipDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaGetEquipDialog
  ((GachaGetEquipDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._effects = nil
  self._cardList = {}
  self._tag = false
end

GachaGetEquipDialog.OnCreate = function(self)
  -- function num : 0_1
  self._photo = self:GetChild("Role/Photo")
  self._title = self:GetChild("UI/ShortInfo/ShortName")
  self._name = self:GetChild("UI/ShortInfo/Name")
  self._job = self:GetChild("UI/Job")
  self._roleName = self:GetChild("UI/JobTxt")
  self._effect = self:GetChild("Effect")
  self._skipBtn = self:GetChild("UI/SkipBtn")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMouseClick, self)
  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.OnSkipBtnClick, self)
  ;
  (self:GetRootWindow()):Subscribe_StateEnterEvent(self.OnAnimationEnter, self)
  self:SetEffect()
end

GachaGetEquipDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : GameObjectHelper, _ENV
  if self._effects then
    for i = 0, (self._effects).Length - 1 do
      local effect = (self._effects)[i]
      ;
      (GameObjectHelper.DestroyObject)(effect)
    end
    self._effects = nil
  end
  local gachaMovieDialog = (DialogManager.GetDialog)("gacha.gachamoviedialog")
  if gachaMovieDialog then
    gachaMovieDialog:VideoFadeOut()
  end
end

GachaGetEquipDialog.SetData = function(self, cardList)
  -- function num : 0_3 , upvalues : _ENV, ItemTypeEnum, Item
  self._list = cardList
  for i,v in ipairs(cardList) do
    local itemtype = (v.item).itemtype
    local id = (v.item).id
    if itemtype == ItemTypeEnum.BASEITEM then
      local item = (Item.Create)(id)
      if item:IsUniqueEquip() then
        (table.insert)(self._cardList, v)
      end
    end
  end
  if #self._cardList >= 1 and (self._cardList)[1] then
    self:Refresh((self._cardList)[1], true)
  end
end

GachaGetEquipDialog.Refresh = function(self, card, isFirst)
  -- function num : 0_4 , upvalues : _ENV, UniqueEquip, Role
  do
    if not isFirst then
      local gachaMovieDialog = (DialogManager.GetDialog)("gacha.gachamoviedialog")
      if gachaMovieDialog then
        gachaMovieDialog:PlayEnd()
      end
    end
    self._tag = false
    ;
    (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1567))
    local uniqueEquipItem = (UniqueEquip.Create)((card.item).id)
    local imageRecord = uniqueEquipItem:GetIcon()
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._name):SetText(uniqueEquipItem:GetName())
    local roleId = uniqueEquipItem:GetRoleId()
    local role = (Role.Create)(roleId)
    if roleId == DataCommon.LeaderId then
      (self._roleName):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1433))
    else
      ;
      (self._roleName):SetText(role:GetRoleName())
    end
    imageRecord = role:GetVocationImgDrawRecord()
    ;
    (self._job):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self:GetRootWindow()):PlayAnimation("UR")
  end
end

GachaGetEquipDialog.SetEffect = function(self)
  -- function num : 0_5 , upvalues : MaterialStaticFunctions
  self._effects = (MaterialStaticFunctions.CopyAndUseMaterialsInChildren)((self._effect)._uiObject, true)
  if self._effects ~= nil then
    for i = 0, (self._effects).Length - 1 do
      local effect = (self._effects)[i]
      effect:SetFloat("_ZTest", 8)
    end
  end
end

local ShowResult = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local resultDialog = (DialogManager.CreateSingletonDialog)("gacha.gacharesultdialog")
  resultDialog:SetDrawCardType((DataCommon.DrawCardType).Equip)
  resultDialog:SetData(self._list)
  self:Destroy()
end

GachaGetEquipDialog.OnMouseClick = function(self)
  -- function num : 0_7 , upvalues : _ENV, ShowResult
  if self._tag then
    if #self._cardList > 1 then
      (table.remove)(self._cardList, 1)
      self:Refresh((self._cardList)[1], false)
    else
      ShowResult(self)
    end
  else
    if not self._tag then
      (self:GetRootWindow()):PlayAnimation("GachaUR")
    end
  end
end

GachaGetEquipDialog.OnSkipBtnClick = function(self)
  -- function num : 0_8 , upvalues : ShowResult
  ShowResult(self)
end

GachaGetEquipDialog.OnAnimationEnter = function(self, handle, statename, normalizedTime)
  -- function num : 0_9
  if #self._cardList > 0 and statename == "GachaUR" then
    self._tag = true
  end
end

return GachaGetEquipDialog

