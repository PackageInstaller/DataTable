-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battlewinaccountcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local BattleWinAccountCell = class("BattleWinAccountCell", Dialog)
BattleWinAccountCell.AssetBundleName = "ui/layouts.battlewin"
BattleWinAccountCell.AssetName = "BattleWinItemCell"
BattleWinAccountCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleWinAccountCell
  ((BattleWinAccountCell.super).Ctor)(self, ...)
end

BattleWinAccountCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  ;
  (self._select):SetActive(false)
  self._count = self:GetChild("ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
  ;
  (self:GetRootWindow()):SetUserData(self)
end

BattleWinAccountCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._timeTask then
    (GameTimer.RemoveTask)(self._timeTask)
    self._timeTask = nil
  end
end

BattleWinAccountCell.RefreshCell = function(self, data)
  -- function num : 0_3
  if not (self._cellData).hasShow then
    (self:GetRootWindow()):SetActive(false)
  end
  local image = (data.item):GetIcon()
  ;
  (self._image):SetSprite(image.assetBundle, image.assetName)
  image = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._count):SetNumber(data.num)
end

BattleWinAccountCell.OnCellClick = function(self, args)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV
  (self._select):SetActive(true)
  ;
  (self._delegate):SetSelectedID((self:GetRootWindow()):GetUserData())
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  if ((self._cellData).item):GetItemType() == ItemTypeEnum.EQUIP then
    if ((self._cellData).item):IsGained() then
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init(((self._cellData).item):GetKey())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    else
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
      if tipsDialog then
        tipsDialog:Init(((self._cellData).item):GetID())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_1 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    end
  else
    tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init(self._cellData)
      tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
    end
  end
end

BattleWinAccountCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV
  if (self:GetRootWindow()):GetUserData() ~= arg then
    (self._select):SetActive(eventName ~= "SetItemSelectedState")
    ;
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

    if eventName == "PlayItemCellAnimation" and arg == (self._cellData).index then
      (self._cellData).hasShow = true
      ;
      (self:GetRootWindow()):SetActive(true)
      ;
      (self._delegate):OnItemCellShowTaskOver(self._cellData)
      if self._timeTask then
        (GameTimer.RemoveTask)(self._timeTask)
        self._timeTask = nil
      end
      self._timeTask = (GameTimer.AddTask)(0.2, -1, function()
    -- function num : 0_5_0 , upvalues : self
    self:OnTimeTaskEnd(true)
  end
)
    else
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R3 in 'UnsetPending'

      if eventName == "PlayAllItemAnimation" then
        if not (self._cellData).hasShow then
          (self._cellData).hasShow = true
          ;
          (self:GetRootWindow()):SetActive(true)
          ;
          (self._delegate):OnItemCellShowTaskOver(self._cellData)
        end
        if self._timeTask then
          (GameTimer.RemoveTask)(self._timeTask)
          self._timeTask = nil
        end
      end
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

BattleWinAccountCell.ChangeCellSelected = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  if (self:GetRootWindow()):GetUserData() ~= (notification.userInfo).arg then
    (self._select):SetActive((notification.userInfo).eventName ~= "SetItemSelectedState")
    ;
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BattleWinAccountCell.OnTimeTaskEnd = function(self, playNext)
  -- function num : 0_7
  if playNext then
    (self._delegate):OnItemCellAnimationEnd((self._cellData).index + 1)
  end
end

return BattleWinAccountCell

