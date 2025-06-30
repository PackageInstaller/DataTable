-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/cardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local Role = require("logic.manager.experimental.types.role")
local CardInfoTypeEnum = (LuaNetManager.GetBeanDef)("protocol.card.cardinfo")
local CEffectResTable = (BeanManager.GetTableByName)("skill.ceffectres")
local CardCell = class("CardCell", Dialog)
CardCell.AssetBundleName = "ui/layouts.gacha"
CardCell.AssetName = "GachaCardCell"
CardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CardCell
  ((CardCell.super).Ctor)(self, ...)
  self._backEffectHandler = nil
end

CardCell.OnCreate = function(self)
  -- function num : 0_1
  self._backEffect = self:GetChild("CharacterCellNoInfo/Effect")
  self._back = self:GetChild("CharacterCellNoInfo/Frame/Back")
  self._photo = self:GetChild("CharacterCellNoInfo/Frame/_Photo")
  self._frame = self:GetChild("CharacterCellNoInfo/Frame/_Frame")
  self._rank = self:GetChild("CharacterCellNoInfo/Frame/_Rank")
  self._job = self:GetChild("CharacterCellNoInfo/Frame/_Job")
  self._same = self:GetChild("CharacterCellNoInfo/Frame/Same")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

CardCell.OnDestroy = function(self)
  -- function num : 0_2
end

CardCell.RefreshCell = function(self, card)
  -- function num : 0_3 , upvalues : Role, CardInfoTypeEnum, _ENV
  if (self._delegate)._guideTenDraw then
    self._role = (Role.Create)(card)
  else
    -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

    if card.cardtype ~= CardInfoTypeEnum.ITEM or card.cardtype == CardInfoTypeEnum.ROLE then
      self._role = (Role.Create)(card.cardId)
      if not self._role then
        LogErrorFormat("CardCell", "role id %s received from server is wrong", card.cardId)
      end
    end
  end
  if self._backEffectHandler and self._backEffectHandler ~= 0 then
    (self._backEffect):ReleaseEffect(self._backEffectHandler)
    self._backEffectHandler = nil
  end
  if self._role then
    local rarityId = (self._role):GetRarityId()
    if rarityId == 1 then
      self._backEffectHandler = (self._backEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1003))
    else
      if rarityId == 2 then
        self._backEffectHandler = (self._backEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1004))
      else
        if rarityId == 3 then
          self._backEffectHandler = (self._backEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1005))
        else
          if rarityId == 4 then
            self._backEffectHandler = (self._backEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1063))
          else
            if rarityId == 5 then
              self._backEffectHandler = (self._backEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1089))
            end
          end
        end
      end
    end
    local image = (self._role):GetShapeBustImageRecord()
    ;
    (self._photo):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetRarityBackRecord()
    ;
    (self._back):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetRarityFrameRecord()
    ;
    (self._frame):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetRarityImageRecord()
    ;
    (self._rank):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetVocationImageRecord()
    ;
    (self._job):SetSprite(image.assetBundle, image.assetName)
  end
  do
    if card.isNew == 0 then
      (self._same):SetActive(true)
    else
      ;
      (self._same):SetActive(false)
    end
  end
end

CardCell.OnCellClick = function(self, args)
  -- function num : 0_4 , upvalues : _ENV
  LogInfo("展示角色详情界面")
end

return CardCell

