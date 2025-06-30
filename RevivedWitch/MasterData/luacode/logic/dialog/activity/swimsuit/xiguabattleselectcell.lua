-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/xiguabattleselectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local XiGuaBattleSelectCell = class("XiGuaBattleSelectCell", Dialog)
XiGuaBattleSelectCell.AssetBundleName = "ui/layouts.activitysummer"
XiGuaBattleSelectCell.AssetName = "ActivitySummerXiGuaBossCell"
XiGuaBattleSelectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : XiGuaBattleSelectCell
  ((XiGuaBattleSelectCell.super).Ctor)(self, ...)
end

XiGuaBattleSelectCell.OnCreate = function(self)
  -- function num : 0_1
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
  ;
  (self._startBtn):Subscribe_PointerClickEvent(self.OnStartBtnClicked, self)
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

XiGuaBattleSelectCell.OnDestroy = function(self)
  -- function num : 0_2
end

XiGuaBattleSelectCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, Item
  self._index = data.index
  self._data = data.data
  if not (self._data).isUnlock then
    (self._lockBack):SetActive(true)
    ;
    (self._unlockLevelTxt):SetText(((self._data).cfg).unlockLevel)
  else
    ;
    (self._lockBack):SetActive(false)
    if not CImagePathTable:GetRecorder(((self._data).cfg).bgImage) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._name):SetText((TextManager.GetText)(((self._data).cfg).name))
    if ((self._data).info).status == 0 then
      (self._damage):SetActive(false)
      ;
      (self._damageNoRecord):SetActive(true)
      ;
      (self._rank):SetActive(false)
      ;
      (self._rankNoRank):SetActive(true)
    else
      if ((self._data).info).status == 1 then
        (self._damage):SetActive(true)
        ;
        (self._damageNoRecord):SetActive(false)
        ;
        (self._damage):SetText((NumberManager.GetShowNumber)(((self._data).info).damage))
        if ((self._data).info).rank <= 0 then
          (self._rank):SetActive(false)
          ;
          (self._rankNoRank):SetActive(true)
        else
          ;
          (self._rank):SetActive(true)
          ;
          (self._rankNoRank):SetActive(false)
          ;
          (self._rank):SetText(((self._data).info).rank)
        end
      end
    end
    ;
    (self._rewardNum):SetText((NumberManager.GetShowNumber)(((self._data).cfg).targetDamage))
    ;
    (self._redDot):SetActive(((self._data).info).awardStatue == 1)
    ;
    (self._getBack):SetActive(((self._data).info).awardStatue == 2)
    ;
    (self._itemCount):SetNumber(((self._data).cfg).itemNum)
    local item = (Item.Create)(((self._data).cfg).itemId)
    imageRecord = item:GetIcon()
    ;
    (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = item:GetPinJiImage()
    ;
    (self._itemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

XiGuaBattleSelectCell.OnStartBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo("SwimSuit", ((self._data).cfg).id, (self._delegate)._constructionId)
  end
end

XiGuaBattleSelectCell.OnItemCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if ((self._data).info).awardStatue == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100394)
  else
    if ((self._data).info).awardStatue == 1 then
      local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.creceivewatermelonreward")
      if protocol then
        protocol.id = ((self._data).cfg).id
        protocol:Send()
      end
    end
  end
end

return XiGuaBattleSelectCell

