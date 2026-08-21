-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/skillbanner/skillbannerdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local SkillBannerDialog = class("SkillBannerDialog", Dialog)
SkillBannerDialog.AssetBundleName = "ui/layouts.battle"
SkillBannerDialog.AssetName = "SkillBanner"
SkillBannerDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillBannerDialog
  ((SkillBannerDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._bannerDialogKey = {}
  self._cells = {}
end

SkillBannerDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

SkillBannerDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  for k,dialog in pairs(self._cells) do
    dialog:Destroy()
    dialog:RootWindowDestroy()
  end
end

SkillBannerDialog.SkillBegin = function(self, skillId, shapeId, entityId)
  -- function num : 0_3 , upvalues : _ENV
  local cell = (DialogManager.CreateDialog)("battle.skillbanner.skillbannercell", (self:GetRootWindow()):GetUIObject())
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._cells)[cell._dialogKey] = cell
  cell:SkillBegin(skillId, shapeId, entityId)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  if not (self._bannerDialogKey)[entityId] then
    (self._bannerDialogKey)[entityId] = {}
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  if not ((self._bannerDialogKey)[entityId])[skillId] then
    ((self._bannerDialogKey)[entityId])[skillId] = {}
  end
  ;
  (table.insert)(((self._bannerDialogKey)[entityId])[skillId], cell._dialogKey)
end

SkillBannerDialog.SkillEnd = function(self, skillId, shapeId, entityId)
  -- function num : 0_4
  local dialogKey = nil
  if (self._bannerDialogKey)[entityId] and ((self._bannerDialogKey)[entityId])[skillId] then
    dialogKey = (((self._bannerDialogKey)[entityId])[skillId])[#((self._bannerDialogKey)[entityId])[skillId]]
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (((self._bannerDialogKey)[entityId])[skillId])[#((self._bannerDialogKey)[entityId])[skillId]] = nil
  end
  if dialogKey and (self._cells)[dialogKey] then
    ((self._cells)[dialogKey]):SkillEnd()
  end
end

SkillBannerDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_5
  local dialog = notification.userInfo
  if (self._cells)[dialog._dialogKey] then
    dialog:RootWindowDestroy()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._cells)[dialog._dialogKey] = nil
  end
end

return SkillBannerDialog

