local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local Role = require("logic.manager.experimental.types.role")
local CardInfoTypeEnum = LuaNetManager.GetBeanDef("protocol.card.cardinfo")
local CEffectResTable = BeanManager.GetTableByName("skill.ceffectres")
local CardCell = class("CardCell", Dialog)
CardCell.AssetBundleName = "ui/layouts.gacha"
CardCell.AssetName = "GachaCardCell"

function CardCell:Ctor(...)
  CardCell.super.Ctor(self, ...)
  self._backEffectHandler = nil
end

function CardCell:OnCreate()
  self._backEffect = self:GetChild("CharacterCellNoInfo/Effect")
  self._back = self:GetChild("CharacterCellNoInfo/Frame/Back")
  self._photo = self:GetChild("CharacterCellNoInfo/Frame/_Photo")
  self._frame = self:GetChild("CharacterCellNoInfo/Frame/_Frame")
  self._rank = self:GetChild("CharacterCellNoInfo/Frame/_Rank")
  self._job = self:GetChild("CharacterCellNoInfo/Frame/_Job")
  self._same = self:GetChild("CharacterCellNoInfo/Frame/Same")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function CardCell:OnDestroy()
end

function CardCell:RefreshCell(card)
  if self._delegate._guideTenDraw then
    self._role = Role.Create(card)
  else
    if card.cardtype == CardInfoTypeEnum.ITEM then
    end
    if card.cardtype == CardInfoTypeEnum.ROLE then
      self._role = Role.Create(card.cardId)
      if not self._role then
        LogErrorFormat("CardCell", "role id %s received from server is wrong", card.cardId)
      end
    end
  end
  if self._backEffectHandler and self._backEffectHandler ~= 0 then
    self._backEffect:ReleaseEffect(self._backEffectHandler)
    self._backEffectHandler = nil
  end
  if self._role then
    local rarityId = self._role:GetRarityId()
    if rarityId == 1 then
      self._backEffectHandler = self._backEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1003))
    elseif rarityId == 2 then
      self._backEffectHandler = self._backEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1004))
    elseif rarityId == 3 then
      self._backEffectHandler = self._backEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1005))
    elseif rarityId == 4 then
      self._backEffectHandler = self._backEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1063))
    elseif rarityId == 5 then
      self._backEffectHandler = self._backEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1089))
    end
    local image = self._role:GetShapeBustImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetRarityBackRecord()
    self._back:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetRarityFrameRecord()
    self._frame:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetRarityImageRecord()
    self._rank:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetVocationImageRecord()
    self._job:SetSprite(image.assetBundle, image.assetName)
  end
  if card.isNew == 0 then
    self._same:SetActive(true)
  else
    self._same:SetActive(false)
  end
end

function CardCell:OnCellClick(args)
  LogInfo("展示角色详情界面")
end

return CardCell
