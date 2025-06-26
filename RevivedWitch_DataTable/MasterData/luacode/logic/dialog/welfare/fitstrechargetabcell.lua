-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/fitstrechargetabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local CFirstRechargeReward = (BeanManager.GetTableByName)("welfare.cfirstrechargereward")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local Item = require("logic.manager.experimental.types.item")
local FitstRechargeTabCell = class("FitstRechargeTabCell", Dialog)
FitstRechargeTabCell.AssetBundleName = "ui/layouts.welfare"
FitstRechargeTabCell.AssetName = "FirstRecharge"
local ItemIdType = {Role = 27, Equip = 299}
FitstRechargeTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FitstRechargeTabCell
  ((FitstRechargeTabCell.super).Ctor)(self, ...)
end

FitstRechargeTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._model = self:GetChild("BackImage/Frame2/Model")
  ;
  (self._model):Subscribe_PointerClickEvent(self.ModelClick, self)
  self._frame1GetBtn = self:GetChild("BackImage/Frame1/GetBtn")
  self._frame1GetBtnGrey = self:GetChild("BackImage/Frame1/GetBtnGrey")
  self._frame1FinishBtn = self:GetChild("BackImage/Frame1/FinishBtn")
  self._frame2GetBtn = self:GetChild("BackImage/Frame2/GetBtn")
  self._frame2GetBtnGrey = self:GetChild("BackImage/Frame2/GetBtnGrey")
  self._frame2FinishBtn = self:GetChild("BackImage/Frame2/FinishBtn")
  self._iBtn = self:GetChild("BackImage/Frame2/Ibtn")
  self._toShopBtn = self:GetChild("BackImage/GoBtn")
  self._itemCells = {}
  self._itemBacks = {}
  self._itemIcons = {}
  self._itemCounts = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R5 in 'UnsetPending'

      (self._itemCells)[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_BackGround")
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemBacks)[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_BackGround/Frame")
      -- DECOMPILER ERROR at PC76: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemIcons)[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_BackGround/Icon")
      -- DECOMPILER ERROR at PC84: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemCounts)[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_Count")
      ;
      ((self._itemCells)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCellClick(i)
  end
, self)
    end
  end
  ;
  (self._toShopBtn):Subscribe_PointerClickEvent(self.ToShop, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.IButtonClick, self)
  ;
  (self._frame1GetBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:GetFirstRechargeGift(1)
  end
, self)
  ;
  (self._frame2GetBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self
    self:GetFirstRechargeGift(2)
  end
, self)
  ;
  (self._frame1GetBtnGrey):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self
    self:ShowMessage(1)
  end
, self)
  ;
  (self._frame2GetBtnGrey):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_4 , upvalues : self
    self:ShowMessage(2)
  end
, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetButtonState, Common.n_FirstRechargeGiftState, nil)
end

FitstRechargeTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

FitstRechargeTabCell.RefreshTabCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, CFirstRechargeReward, Item
  local csend = (LuaNetManager.CreateProtocol)("protocol.shop.cgetfirstrechargegiftstate")
  csend:Send()
  local itemsId = (CFirstRechargeReward:GetRecorder(1)).itemID
  local itemscount = (CFirstRechargeReward:GetRecorder(1)).ItemNum
  self._items = {}
  for _,id in ipairs(itemsId) do
    local itemTemp = (Item.Create)(id)
    ;
    (table.insert)(self._items, itemTemp)
  end
  for i,item in ipairs(self._items) do
    local imageRecord = item:GetPinJiImage()
    ;
    ((self._itemBacks)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = item:GetIcon()
    ;
    ((self._itemIcons)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    ((self._itemCounts)[i]):SetText((NumberManager.GetShowNumber)(itemscount[i]))
  end
end

FitstRechargeTabCell.SetButtonState = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local state = ((NekoData.BehaviorManager).BM_Welfare):GetFirstRechargeGiftState()
  ;
  (self._frame1GetBtn):SetActive(state.statue == 1 and not (state.giftsState)[1] or (state.giftsState)[1] == 0)
  ;
  (self._frame1GetBtnGrey):SetActive(state.statue ~= 0 and not (state.giftsState)[1])
  ;
  (self._frame1FinishBtn):SetActive(state.statue == 1 and not (state.giftsState)[1] or (state.giftsState)[1] == 1)
  ;
  (self._frame2GetBtn):SetActive(state.statue == 1 and not (state.giftsState)[2] or (state.giftsState)[2] == 0)
  ;
  (self._frame2GetBtnGrey):SetActive(state.statue ~= 0 and not (state.giftsState)[2])
  ;
  (self._frame2FinishBtn):SetActive(state.statue == 1 and not (state.giftsState)[2] or (state.giftsState)[2] == 1)
  -- DECOMPILER ERROR: 15 unprocessed JMP targets
end

FitstRechargeTabCell.ModelClick = function(self)
  -- function num : 0_5 , upvalues : AnimatorStaticFunctions
  local animator = (AnimatorStaticFunctions.Get)((self._model)._uiObject)
  animator:SetTrigger("onClick")
end

FitstRechargeTabCell.IButtonClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("welfare.firtstrechargetip")
end

FitstRechargeTabCell.ToShop = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(4)
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
  ;
  (DialogManager.DestroySingletonDialog)("welfare.welfaremaindialog")
end

FitstRechargeTabCell.GetFirstRechargeGift = function(self, id)
  -- function num : 0_8 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.shop.cgetfirstrechargegift")
  csend.gainGiftID = id
  csend:Send()
end

FitstRechargeTabCell.ShowMessage = function(self, id)
  -- function num : 0_9 , upvalues : _ENV
  if id == 1 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100238)
  else
    local state = ((NekoData.BehaviorManager).BM_Welfare):GetFirstRechargeGiftState()
    if state.statue == 0 then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100238)
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100239)
    end
  end
end

FitstRechargeTabCell.OnCellClick = function(self, index)
  -- function num : 0_10 , upvalues : ItemIdType, CRoleItem, _ENV
  local item = (self._items)[index]
  local dialog = nil
  if item:GetItemTypeId() == ItemIdType.Role then
    local roleID = (CRoleItem:GetRecorder(item:GetID())).roleid
    dialog = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
    if dialog then
      dialog:Init({
roleIdList = {roleID}
, 
cfgIdList = {1}
, index = 1}, (dialog.ShowType).BaseLevelInfo)
    end
  else
    do
      if item:GetItemTypeId() == ItemIdType.Equip then
        dialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
        if dialog then
          dialog:Init(item:GetID())
          dialog:SetTipsParmFunc(function()
    -- function num : 0_10_0 , upvalues : self, index
    local width, height = ((self._itemBacks)[index]):GetRectSize()
    local pos = ((self._itemBacks)[index]):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
        end
      else
        dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
        if dialog then
          dialog:Init({item = item})
        end
      end
    end
  end
end

return FitstRechargeTabCell

