local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local BattleWinAccountCell = class("BattleWinAccountCell", Dialog)
BattleWinAccountCell.AssetBundleName = "ui/layouts.battlewin"
BattleWinAccountCell.AssetName = "BattleWinItemCell"

function BattleWinAccountCell:Ctor(...)
  BattleWinAccountCell.super.Ctor(self, ...)
end

function BattleWinAccountCell:OnCreate()
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self._count = self:GetChild("ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  self:GetRootWindow():SetUserData(self)
end

function BattleWinAccountCell:OnDestroy()
  if self._timeTask then
    GameTimer.RemoveTask(self._timeTask)
    self._timeTask = nil
  end
end

function BattleWinAccountCell:RefreshCell(data)
  if not self._cellData.hasShow then
    self:GetRootWindow():SetActive(false)
  end
  local image = data.item:GetIcon()
  self._image:SetSprite(image.assetBundle, image.assetName)
  image = data.item:GetPinJiImage()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  self._count:SetNumber(data.num)
end

function BattleWinAccountCell:OnCellClick(args)
  self._select:SetActive(true)
  self._delegate:SetSelectedID(self:GetRootWindow():GetUserData())
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
  if self._cellData.item:GetItemType() == ItemTypeEnum.EQUIP then
    if self._cellData.item:IsGained() then
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData.item:GetKey())
        tipsDialog:SetTipsParmFunc(function()
          local width, height = self:GetRootWindow():GetRectSize()
          local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
          return {
            width = width,
            height = height,
            posX = pos.x,
            posY = pos.y
          }
        end)
      end
    else
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData.item:GetID())
        tipsDialog:SetTipsParmFunc(function()
          local width, height = self:GetRootWindow():GetRectSize()
          local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
          return {
            width = width,
            height = height,
            posX = pos.x,
            posY = pos.y
          }
        end)
      end
    end
  else
    tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init(self._cellData)
      tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

function BattleWinAccountCell:OnEvent(eventName, arg)
  if eventName == "SetItemSelectedState" then
    self._select:SetActive(self:GetRootWindow():GetUserData() == arg)
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  elseif eventName == "PlayItemCellAnimation" and arg == self._cellData.index then
    self._cellData.hasShow = true
    self:GetRootWindow():SetActive(true)
    self._delegate:OnItemCellShowTaskOver(self._cellData)
    if self._timeTask then
      GameTimer.RemoveTask(self._timeTask)
      self._timeTask = nil
    end
    self._timeTask = GameTimer.AddTask(0.2, -1, function()
      self:OnTimeTaskEnd(true)
    end)
  elseif eventName == "PlayAllItemAnimation" then
    if not self._cellData.hasShow then
      self._cellData.hasShow = true
      self:GetRootWindow():SetActive(true)
      self._delegate:OnItemCellShowTaskOver(self._cellData)
    end
    if self._timeTask then
      GameTimer.RemoveTask(self._timeTask)
      self._timeTask = nil
    end
  end
end

function BattleWinAccountCell:ChangeCellSelected(notification)
  if notification.userInfo.eventName == "SetItemSelectedState" then
    self._select:SetActive(self:GetRootWindow():GetUserData() == notification.userInfo.arg)
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
end

function BattleWinAccountCell:OnTimeTaskEnd(playNext)
  if playNext then
    self._delegate:OnItemCellAnimationEnd(self._cellData.index + 1)
  end
end

return BattleWinAccountCell
