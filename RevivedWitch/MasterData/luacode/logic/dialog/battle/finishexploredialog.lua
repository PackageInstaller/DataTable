-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/finishexploredialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local FinishExploreDialog = class("FinishExploreDialog", Dialog)
FinishExploreDialog.AssetBundleName = "ui/layouts.dungeon"
FinishExploreDialog.AssetName = "FinishExplore"
FinishExploreDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FinishExploreDialog
  ((FinishExploreDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._callBackFunc = nil
end

FinishExploreDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._spiritGive = self:GetChild("Frame/SpiritGive")
  self._text = self:GetChild("Frame/SpiritGive/Txt")
  self._itemCell = self:GetChild("Frame/SpiritGive/ItemCell")
  self._itemIcon = self:GetChild("Frame/SpiritGive/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("Frame/SpiritGive/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("Frame/SpiritGive/ItemCell/_Count")
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnWindowClicked, self)
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.hint.dungeonhintdialog")
end

FinishExploreDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._callBackFunc then
    (self._callBackFunc)()
  end
end

FinishExploreDialog.OnWindowClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("battle.finishexploredialog")
end

FinishExploreDialog.SetCallBackFunc = function(self, callbackFunc)
  -- function num : 0_4
  self._callBackFunc = callbackFunc
end

FinishExploreDialog.SetSpiritGiveData = function(self, moneyInfo)
  -- function num : 0_5 , upvalues : _ENV, Item, CStringRes
  if moneyInfo and next(moneyInfo) ~= nil and moneyInfo[35003] ~= nil and moneyInfo[35003] > 0 then
    (self._spiritGive):SetActive(true)
    self._itemId = 35003
    self._itemNum = moneyInfo[35003]
    self._item = (Item.Create)(self._itemId)
    ;
    (self._itemCount):SetText((NumberManager.GetShowNumber)(self._itemNum))
    ;
    (self._itemIcon):SetSprite(((self._item):GetIcon()).assetBundle, ((self._item):GetIcon()).assetName)
    ;
    (self._itemFrame):SetSprite(((self._item):GetPinJiImage()).assetBundle, ((self._item):GetPinJiImage()).assetName)
    ;
    (self._text):SetText((string.gsub)((TextManager.GetText)((CStringRes:GetRecorder(1440)).msgTextID), "%$parameter1%$", self._itemNum))
  else
    ;
    (self._spiritGive):SetActive(false)
  end
end

FinishExploreDialog.OnItemCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._item})
  end
end

return FinishExploreDialog

