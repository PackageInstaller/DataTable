local ManaEffectCell = class("ManaEffectCell", Dialog)
ManaEffectCell.AssetBundleName = "ui/layouts.dungeon"
ManaEffectCell.AssetName = "ManaEffect"

function ManaEffectCell:Ctor(...)
  ManaEffectCell.super.Ctor(self, ...)
  self._key = nil
  self._effect_x_task, self._effect_y_task = nil, nil
end

function ManaEffectCell:OnCreate()
  self._effect = self:GetChild("ManaEffectCell")
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function ManaEffectCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ManaEffectCell:PlayEffect(key, xx, yy, px, py, actor)
  self._actor = actor
  self._key = key
  self._effect_des_x = px
  self._effect_des_y = py
  self._effect_x_task = Tween.new(0.75, {pos = xx}, {
    pos = self._effect_des_x
  }, "linear")
  self._effect_y_task = Tween.new(0.75, {pos = yy}, {
    pos = self._effect_des_y
  }, "linear")
end

function ManaEffectCell:OnUpdate(notification)
  if self._effect_x_task or self._effect_y_task then
    if not self._playing then
      self._playing = true
      self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1034))
    end
    if self._effect_x_task then
      if self._effect_x_task:update(notification.userInfo.deltaTime) then
        self._effect_x = self._effect_des_x
        self._effect_x_task = nil
      else
        self._effect_x = self._effect_x_task.subject.pos
      end
    end
    if self._effect_y_task then
      if self._effect_y_task:update(notification.userInfo.deltaTime) then
        self._effect_y = self._effect_des_y
        self._effect_y_task = nil
      else
        self._effect_y = self._effect_y_task.subject.pos
      end
    end
    local x1, y1 = CS.PixelNeko.UI.UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow()._uiObject, self._effect_x, self._effect_y)
    self._effect:SetAnchoredPosition(x1, y1)
    if not self._effect_x_task and not self._effect_y_task then
      CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._actor, "Sence_TX_Prefab_Mana_ren"):SetActive(false)
      if self._playing then
        self._effect:ReleaseEffect(self._effectHandler)
        self._effectHandler = nil
        self._playing = false
        local dialog = DialogManager.GetDialog("dungeon.dungeonhud")
        if dialog then
          dialog:DestroyManaEffectCell(self._key)
        end
        self:RootWindowDestroy()
      end
    end
  end
end

return ManaEffectCell
