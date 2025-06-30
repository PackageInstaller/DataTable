-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/manaeffectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ManaEffectCell = class("ManaEffectCell", Dialog)
ManaEffectCell.AssetBundleName = "ui/layouts.dungeon"
ManaEffectCell.AssetName = "ManaEffect"
ManaEffectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ManaEffectCell
  ((ManaEffectCell.super).Ctor)(self, ...)
  self._key = nil
  self._effect_x_task = nil
end

ManaEffectCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._effect = self:GetChild("ManaEffectCell")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

ManaEffectCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ManaEffectCell.PlayEffect = function(self, key, xx, yy, px, py, actor)
  -- function num : 0_3 , upvalues : _ENV
  self._actor = actor
  self._key = key
  self._effect_des_x = px
  self._effect_des_y = py
  self._effect_x_task = (Tween.new)(0.75, {pos = xx}, {pos = self._effect_des_x}, "linear")
  self._effect_y_task = (Tween.new)(0.75, {pos = yy}, {pos = self._effect_des_y}, "linear")
end

ManaEffectCell.OnUpdate = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  if self._effect_x_task or self._effect_y_task then
    if not self._playing then
      self._playing = true
      self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1034))
    end
    if self._effect_x_task then
      if (self._effect_x_task):update((notification.userInfo).deltaTime) then
        self._effect_x = self._effect_des_x
        self._effect_x_task = nil
      else
        self._effect_x = ((self._effect_x_task).subject).pos
      end
    end
    if self._effect_y_task then
      if (self._effect_y_task):update((notification.userInfo).deltaTime) then
        self._effect_y = self._effect_des_y
        self._effect_y_task = nil
      else
        self._effect_y = ((self._effect_y_task).subject).pos
      end
    end
    local x1, y1 = ((((CS.PixelNeko).UI).UIManager).ScreenPointToLocalPointInRectangle)((self:GetRootWindow())._uiObject, self._effect_x, self._effect_y)
    ;
    (self._effect):SetAnchoredPosition(x1, y1)
    if not self._effect_x_task and not self._effect_y_task then
      (((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._actor, "Sence_TX_Prefab_Mana_ren")):SetActive(false)
      if self._playing then
        (self._effect):ReleaseEffect(self._effectHandler)
        self._effectHandler = nil
        self._playing = false
        local dialog = (DialogManager.GetDialog)("dungeon.dungeonhud")
        if dialog then
          dialog:DestroyManaEffectCell(self._key)
        end
        self:RootWindowDestroy()
      end
    end
  end
end

return ManaEffectCell

