-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversarypackage/skincell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SkinCell = class("SkinCell", Dialog)
local Item = require("logic.manager.experimental.types.item")
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
SkinCell.AssetBundleName = "ui/layouts.activity1yearanniversary"
SkinCell.AssetName = "Activity1YearOtherShopFashionCell"
SkinCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkinCell
  ((SkinCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

SkinCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetChild("GoBack/GoBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2069))
  self._goBtn = self:GetChild("GoBack/GoBtn")
  self._nameTxt = self:GetChild("TextFrame/NameTxt")
  self._timeTxt = self:GetChild("TextFrame/TimeTxt")
  self._itemCell = {}
  self._itemCell = {}
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).cell = self:GetChild("TaskCellItem/Panel/ItemCell")
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).icon = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).frame = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).count = self:GetChild("TaskCellItem/Panel/ItemCell/_Count")
  ;
  ((self._itemCell).icon):Subscribe_PointerClickEvent(self.OnItemClicked, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
end

SkinCell.OnDestroy = function(self)
  -- function num : 0_2
end

SkinCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  local item = (Item.Create)(data.skinID)
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._itemCell).item = item
  ;
  ((self._itemCell).icon):SetSprite(item:GetIconAB())
  ;
  ((self._itemCell).frame):SetSprite(item:GetPinJiImageAB())
  ;
  ((self._itemCell).count):SetText(item:GetCount())
  ;
  (self._nameTxt):SetText(item:GetName())
  ;
  (self._timeTxt):SetText((TextManager.GetText)(data.openTime))
end

SkinCell.OnGoBtnClicked = function(self)
  -- function num : 0_4 , upvalues : CSkinItem, _ENV
  local cfg = CSkinItem:GetRecorder(((self._itemCell).item):GetID())
  local dlg = (DialogManager.CreateSingletonDialog)("shop.fashionbuydialog")
  local data = {}
  ;
  (table.insert)(data, {itemId = cfg.Skinid})
  dlg:SetData((dlg.TargetType).OnlyShow, data)
end

SkinCell.OnItemClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local width, height = ((self._itemCell).cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._itemCell).item})
    tipsDialog:SetTipsPosition(width, height, ((self._itemCell).cell):GetLocalPointInUiRootPanel())
  end
end

return SkinCell

