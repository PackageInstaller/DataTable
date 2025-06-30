-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/fitstrechargedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local CFirstRechargeReward = (BeanManager.GetTableByName)("welfare.cfirstrechargereward")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local Item = require("logic.manager.experimental.types.item")
local FitstRechargeDialog = class("FitstRechargeDialog", Dialog)
FitstRechargeDialog.AssetBundleName = "ui/layouts.welfare"
FitstRechargeDialog.AssetName = "FirstRecharge"
local ItemIdType = {Role = 27, Equip = 299}
local State = {NoRecharge = 1, RewardOneLock = 2, RewardOneUnlock = 3, RewardTwoLock = 4, RewardTwoUnLock = 5, Finishi = 6}
FitstRechargeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FitstRechargeDialog
  ((FitstRechargeDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._state = -1
end

FitstRechargeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._model = self:GetChild("BackImage/Frame2/Model")
  ;
  (self._model):Subscribe_PointerClickEvent(self.ModelClick, self)
  self._frame1FinishBtn = self:GetChild("BackImage/Frame1/FinishBtn")
  self._frame2FinishBtn = self:GetChild("BackImage/Frame2/FinishBtn")
  self._iBtn = self:GetChild("BackImage/Frame2/Ibtn")
  self._goBtn = self:GetChild("BackImage/Up/GoBtn")
  self._goBtnText = self:GetChild("BackImage/Up/GoBtn/Text")
  self._goBtnDone = self:GetChild("BackImage/Up/GoBtn/Done")
  self._closeBtn = self:GetChild("CloseBtn")
  self._itemCells = {}
  self._itemBacks = {}
  self._itemIcons = {}
  self._itemCounts = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      (self._itemCells)[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_BackGround")
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemBacks)[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_BackGround/Frame")
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemIcons)[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_BackGround/Icon")
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

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
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.IButtonClick, self)
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetButtonState, Common.n_FirstRechargeGiftState, nil)
end

FitstRechargeDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

FitstRechargeDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CFirstRechargeReward, Item, Role
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
  local roleIdData = (Role.Create)(59)
  local record = roleIdData:GetShapeLive2DRecord()
  if self._handler then
    (self._live2D):Release(self._handler)
    self._handler = nil
  end
  if (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DPrefabName then
    (self._photo):SetActive(false)
    self._handler = (self._live2D):AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
  else
    ;
    (self._photo):SetActive(true)
    ;
    (self._photo):SetSprite((roleIdData:GetShapeLiHuiImageRecord()).assetBundle, (roleIdData:GetShapeLiHuiImageRecord()).assetName)
    local scale = roleIdData:GetPhotoScale()
    ;
    (self._photo):SetLocalScale(scale, scale, scale)
    local photoPos = roleIdData:GetPhotoPosition()
    ;
    (self._photo):SetAnchoredPosition(photoPos[1], photoPos[2])
  end
end

FitstRechargeDialog.SetButtonState = function(self)
  -- function num : 0_4 , upvalues : _ENV, CStringRes, State
  (((NekoData.BehaviorManager).BM_Welfare):GetFirstRechargeGiftState())
  local state = nil
  local str = nil
  if state.statue == 0 then
    str = (CStringRes:GetRecorder(1429)).msgTextID
    str = (TextManager.GetText)(str)
    ;
    (self._goBtnText):SetText(str)
    ;
    (self._goBtnText):SetActive(true)
    ;
    (self._goBtnDone):SetActive(false)
    self._state = State.NoRecharge
  else
    if state.statue == 1 and (state.giftsState)[1] and (state.giftsState)[1] == 0 then
      str = (CStringRes:GetRecorder(1430)).msgTextID
      str = (TextManager.GetText)(str)
      ;
      (self._goBtnText):SetText(str)
      ;
      (self._goBtnText):SetActive(true)
      ;
      (self._goBtnDone):SetActive(false)
      self._state = State.RewardOneUnlock
    else
      if state.statue == 1 and not (state.giftsState)[2] then
        str = (CStringRes:GetRecorder(1431)).msgTextID
        str = (TextManager.GetText)(str)
        ;
        (self._goBtnText):SetText(str)
        ;
        (self._goBtnText):SetActive(true)
        ;
        (self._goBtnDone):SetActive(false)
        self._state = State.RewardTwoLock
      else
        if state.statue == 1 and (state.giftsState)[2] and (state.giftsState)[2] == 0 then
          str = (CStringRes:GetRecorder(1431)).msgTextID
          str = (TextManager.GetText)(str)
          ;
          (self._goBtnText):SetText(str)
          ;
          (self._goBtnText):SetActive(true)
          ;
          (self._goBtnDone):SetActive(false)
          self._state = State.RewardTwoUnLock
        else
          if (state.giftsState)[1] == 1 and (state.giftsState)[2] == 1 then
            str = (CStringRes:GetRecorder(1431)).msgTextID
            ;
            (self._goBtnText):SetActive(false)
            ;
            (self._goBtnDone):SetActive(true)
            ;
            (self._goBtn):SetInteractable(false)
            self._state = State.Finishi
          end
        end
      end
    end
  end
  ;
  (self._frame1FinishBtn):SetActive(state.statue == 1 and not (state.giftsState)[1] or (state.giftsState)[1] == 1)
  ;
  (self._frame2FinishBtn):SetActive(state.statue == 1 and not (state.giftsState)[2] or (state.giftsState)[2] == 1)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

FitstRechargeDialog.ModelClick = function(self)
  -- function num : 0_5 , upvalues : AnimatorStaticFunctions
  local animator = (AnimatorStaticFunctions.Get)((self._model)._uiObject)
  animator:SetTrigger("onClick")
end

FitstRechargeDialog.IButtonClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("welfare.firtstrechargetip")
end

FitstRechargeDialog.OnGoBtnClick = function(self)
  -- function num : 0_7 , upvalues : State, _ENV
  if self._state == State.NoRecharge then
    ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(4)
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
    self:Destroy()
  else
    do
      if self._state == State.RewardOneUnlock then
        self:GetFirstRechargeGift(1)
      else
        if self._state == State.RewardTwoLock then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100239)
        else
          if self._state == State.RewardTwoUnLock then
            self:GetFirstRechargeGift(2)
          end
        end
      end
    end
  end
end

FitstRechargeDialog.GetFirstRechargeGift = function(self, id)
  -- function num : 0_8 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.shop.cgetfirstrechargegift")
  csend.gainGiftID = id
  csend:Send()
end

FitstRechargeDialog.ShowMessage = function(self, id)
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

FitstRechargeDialog.OnCellClick = function(self, index)
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
cfgIdList = {4}
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

FitstRechargeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11
  self:Destroy()
end

return FitstRechargeDialog

