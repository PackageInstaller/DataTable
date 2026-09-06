local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CGemSuitTable = BeanManager.GetTableByName("equip.cbaoshisuit")
local GemSettingEquipTabCell = class("GemSettingEquipTabCell", Dialog)
GemSettingEquipTabCell.AssetBundleName = "ui/layouts.equip"
GemSettingEquipTabCell.AssetName = "EquipXQ"

function GemSettingEquipTabCell:Ctor(...)
  GemSettingEquipTabCell.super.Ctor(self, ...)
  self._equip = nil
end

function GemSettingEquipTabCell:OnCreate()
  self._equipIcon = self:GetChild("Frame/EquipCell/BackGround/Icon")
  self._frame = self:GetChild("Frame/EquipCell/BackGround/Frame")
  self._curSuitTip = self:GetChild("Frame/Tip/Txt1")
  self._nextSuitTip = self:GetChild("Frame/Tip/Txt2")
  self._effect = self:GetChild("Frame/CostBack/Effect")
  self._ibtn = self:GetChild("Ibtn")
  self._ibtn:Subscribe_PointerClickEvent(self.OnIBtnClick, self)
  self._gemSettingCells = {}
  for i = 1, 3 do
    self._gemSettingCells[i] = {}
    self._gemSettingCells[i].icon = self:GetChild("Frame/Empty" .. i .. "/Item/Item")
    self._gemSettingCells[i].select = self:GetChild("Frame/Empty" .. i .. "/Item/RankBack")
    self._gemSettingCells[i].reduceBtn = self:GetChild("Frame/Empty" .. i .. "/Reduce")
    self._gemSettingCells[i].reduceBtn:Subscribe_PointerClickEvent(function()
      self:OnRemoveGem(i)
    end)
    self._gemSettingCells[i].icon:Subscribe_PointerClickEvent(function()
      self:OnCellClick(i)
    end)
    self._gemSettingCells[i].select:SetActive(false)
  end
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipGemSetting, nil)
end

function GemSettingEquipTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

function GemSettingEquipTabCell:OnHidden()
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

function GemSettingEquipTabCell:OnRefresh(notification)
  local equipKey = notification.userInfo.equipKey
  if equipKey == self._equip:GetKey() then
    self:RefreshGemInfo()
  end
end

function GemSettingEquipTabCell:RefreshTabCell()
end

function GemSettingEquipTabCell:GetSelectPos()
  return self._selectPos
end

function GemSettingEquipTabCell:Init(equipKey)
  self._equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipKey)
  local record = self._equip:GetIcon()
  self._equipIcon:SetSprite(record.assetBundle, record.assetName)
  record = self._equip:GetPinJiImage()
  self._frame:SetSprite(record.assetBundle, record.assetName)
  self._selectPos = 0
  self:RefreshGemInfo()
end

function GemSettingEquipTabCell:RefreshGemInfo()
  local gems = self._equip:GetSettingGems()
  local emptyImageRecord = DataCommon.NullImageAsset
  for i = 1, 3 do
    local gemID = gems[i]
    if gemID and 0 < gemID then
      local itemRecord = CItemAttrTable:GetRecorder(gemID)
      local imageRecord = CImagePathTable:GetRecorder(itemRecord.icon) or DataCommon.DefaultImageAsset
      self._gemSettingCells[i].icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._gemSettingCells[i].reduceBtn:SetActive(true)
    else
      self._gemSettingCells[i].icon:SetSprite(emptyImageRecord.assetBundle, emptyImageRecord.assetName)
      self._gemSettingCells[i].reduceBtn:SetActive(false)
      if self._selectPos == 0 then
        self._selectPos = i
      end
    end
  end
  if self._selectPos == 0 then
    self._selectPos = 1
  end
  for i = 1, 3 do
    self._gemSettingCells[i].select:SetActive(self._selectPos == i)
  end
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  local suitId = self._equip:GetGemSuitId()
  if 0 < suitId then
    local curSuitRecord = CGemSuitTable:GetRecorder(suitId)
    local nextSuitRecord = CGemSuitTable:GetRecorder(suitId + 1)
    local suitName = TextManager.GetText(curSuitRecord.nameid)
    local suitEffect = TextManager.GetText(curSuitRecord.txtid)
    self._curSuitTip:SetText(NekoData.BehaviorManager.BM_Message:GetString(2289, {suitName, suitEffect}))
    if nextSuitRecord then
      self._nextSuitTip:SetText(NekoData.BehaviorManager.BM_Message:GetString(2290, {
        TextManager.GetText(nextSuitRecord.txtid)
      }))
      self._nextSuitTip:SetActive(true)
    else
      self._nextSuitTip:SetActive(false)
    end
    self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(curSuitRecord.effectid))
  else
    self._curSuitTip:SetText(NekoData.BehaviorManager.BM_Message:GetString(2281))
    self._nextSuitTip:SetActive(false)
  end
end

function GemSettingEquipTabCell:OnCellClick(index)
  if self._selectPos ~= index then
    self._gemSettingCells[self._selectPos].select:SetActive(false)
    self._selectPos = index
    self._gemSettingCells[self._selectPos].select:SetActive(true)
  end
  local gems = self._equip:GetSettingGems()
  local gemID = gems[index]
  if gemID and 0 < gemID then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.gemtipsdialog")
    if tipsDialog then
      tipsDialog:Init(gemID, self._equip:GetKey(), index)
      tipsDialog:SetTipsParmFunc(function()
        local width, height = self._gemSettingCells[index].icon:GetRectSize()
        local pos = self._gemSettingCells[index].icon:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  end
end

function GemSettingEquipTabCell:OnRemoveGem(index)
  if self._selectPos ~= index then
    self._gemSettingCells[self._selectPos].select:SetActive(false)
    self._selectPos = index
    self._gemSettingCells[self._selectPos].select:SetActive(true)
  end
  local gems = self._equip:GetSettingGems()
  local gemID = gems[index]
  local p = LuaNetManager.CreateProtocol("protocol.item.cequipgeminlay")
  p.operate = 2
  p.equipKey = self._equip:GetKey()
  p.pos = index
  p.gemId = gemID
  p:Send()
end

function GemSettingEquipTabCell:OnCellLongPress()
  local tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
  if tipsDialog then
    tipsDialog:Init(self._equip:GetKey())
    tipsDialog:SetTipsParmFunc(function()
      local width, height = self._itemFrame:GetRectSize()
      local pos = self._itemFrame:GetLocalPointInUiRootPanel()
      return {
        width = width,
        height = height,
        posX = pos.x,
        posY = pos.y
      }
    end)
  end
end

function GemSettingEquipTabCell:OnIBtnClick()
  DialogManager.CreateSingletonDialog("equipforge.equipqhtips"):Init(2287, 2280)
end

return GemSettingEquipTabCell
