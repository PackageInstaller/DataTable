local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local XiGuaBattleSelectCell = class("XiGuaBattleSelectCell", Dialog)
XiGuaBattleSelectCell.AssetBundleName = "ui/layouts.activitysummer"
XiGuaBattleSelectCell.AssetName = "ActivitySummerXiGuaBossCell"

function XiGuaBattleSelectCell:Ctor(...)
  XiGuaBattleSelectCell.super.Ctor(self, ...)
end

function XiGuaBattleSelectCell:OnCreate()
  self._photo = self:GetChild("Photo")
  self._name = self:GetChild("Name")
  self._damage = self:GetChild("Time")
  self._damageNoRecord = self:GetChild("TxtNoRecord")
  self._rank = self:GetChild("Rank")
  self._rankNoRank = self:GetChild("Txt3NoRank")
  self._startBtn = self:GetChild("StartBtn")
  self._rewardNum = self:GetChild("Reward/Num")
  self._itemCell = self:GetChild("CellItem/Panel/ItemCell")
  self._getBack = self:GetChild("CellItem/Panel/ItemCell/GetBack")
  self._redDot = self:GetChild("CellItem/Panel/Dot")
  self._itemCount = self:GetChild("CellItem/Panel/ItemCell/_Count")
  self._itemIcon = self:GetChild("CellItem/Panel/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("CellItem/Panel/ItemCell/_BackGround/Frame")
  self._lockBack = self:GetChild("LockBack")
  self._unlockLevelTxt = self:GetChild("LockBack/Num")
  self._startBtn:Subscribe_PointerClickEvent(self.OnStartBtnClicked, self)
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

function XiGuaBattleSelectCell:OnDestroy()
end

function XiGuaBattleSelectCell:RefreshCell(data)
  self._index = data.index
  self._data = data.data
  if not self._data.isUnlock then
    self._lockBack:SetActive(true)
    self._unlockLevelTxt:SetText(self._data.cfg.unlockLevel)
  else
    self._lockBack:SetActive(false)
    local imageRecord = CImagePathTable:GetRecorder(self._data.cfg.bgImage) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._name:SetText(TextManager.GetText(self._data.cfg.name))
    if self._data.info.status == 0 then
      self._damage:SetActive(false)
      self._damageNoRecord:SetActive(true)
      self._rank:SetActive(false)
      self._rankNoRank:SetActive(true)
    elseif self._data.info.status == 1 then
      self._damage:SetActive(true)
      self._damageNoRecord:SetActive(false)
      self._damage:SetText(NumberManager.GetShowNumber(self._data.info.damage))
      if 0 >= self._data.info.rank then
        self._rank:SetActive(false)
        self._rankNoRank:SetActive(true)
      else
        self._rank:SetActive(true)
        self._rankNoRank:SetActive(false)
        self._rank:SetText(self._data.info.rank)
      end
    end
    self._rewardNum:SetText(NumberManager.GetShowNumber(self._data.cfg.targetDamage))
    self._redDot:SetActive(self._data.info.awardStatue == 1)
    self._getBack:SetActive(self._data.info.awardStatue == 2)
    self._itemCount:SetNumber(self._data.cfg.itemNum)
    local item = Item.Create(self._data.cfg.itemId)
    imageRecord = item:GetIcon()
    self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = item:GetPinJiImage()
    self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

function XiGuaBattleSelectCell:OnStartBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo("SwimSuit", self._data.cfg.id, self._delegate._constructionId)
  end
end

function XiGuaBattleSelectCell:OnItemCellClicked()
  if self._data.info.awardStatue == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100394)
  elseif self._data.info.awardStatue == 1 then
    local protocol = LuaNetManager.CreateProtocol("protocol.ranking.creceivewatermelonreward")
    if protocol then
      protocol.id = self._data.cfg.id
      protocol:Send()
    end
  end
end

return XiGuaBattleSelectCell
