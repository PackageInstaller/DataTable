local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local SkillBannerDialog = class("SkillBannerDialog", Dialog)
SkillBannerDialog.AssetBundleName = "ui/layouts.battle"
SkillBannerDialog.AssetName = "SkillBanner"

function SkillBannerDialog:Ctor(...)
  SkillBannerDialog.super.Ctor(self, ...)
  self._groupName = "Default"
  self._bannerDialogKey = {}
  self._cells = {}
end

function SkillBannerDialog:OnCreate()
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

function SkillBannerDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  for k, dialog in pairs(self._cells) do
    dialog:Destroy()
    dialog:RootWindowDestroy()
  end
end

function SkillBannerDialog:SkillBegin(skillId, shapeId, entityId)
  local cell = DialogManager.CreateDialog("battle.skillbanner.skillbannercell", self:GetRootWindow():GetUIObject())
  self._cells[cell._dialogKey] = cell
  cell:SkillBegin(skillId, shapeId, entityId)
  if not self._bannerDialogKey[entityId] then
    self._bannerDialogKey[entityId] = {}
  end
  if not self._bannerDialogKey[entityId][skillId] then
    self._bannerDialogKey[entityId][skillId] = {}
  end
  table.insert(self._bannerDialogKey[entityId][skillId], cell._dialogKey)
end

function SkillBannerDialog:SkillEnd(skillId, shapeId, entityId)
  local dialogKey
  if self._bannerDialogKey[entityId] and self._bannerDialogKey[entityId][skillId] then
    dialogKey = self._bannerDialogKey[entityId][skillId][#self._bannerDialogKey[entityId][skillId]]
    self._bannerDialogKey[entityId][skillId][#self._bannerDialogKey[entityId][skillId]] = nil
  end
  if dialogKey and self._cells[dialogKey] then
    self._cells[dialogKey]:SkillEnd()
  end
end

function SkillBannerDialog:OnDialogDestroy(notification)
  local dialog = notification.userInfo
  if self._cells[dialog._dialogKey] then
    dialog:RootWindowDestroy()
    self._cells[dialog._dialogKey] = nil
  end
end

return SkillBannerDialog
