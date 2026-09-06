local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local BagCell = class("BagCell", Dialog)
BagCell.AssetBundleName = "ui/layouts.bag"
BagCell.AssetName = "BagItemCell"

function BagCell:Ctor(...)
  BagCell.super.Ctor(self, ...)
end

function BagCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._Select = self:GetChild("ItemCell/_BackGround/Select")
  self._grayIcon = self:GetChild("Grey")
  self._Select:SetActive(false)
  self._grayIcon:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BagCell:OnDestroy()
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function BagCell:RefreshCell(data)
  if not data.item then
    local imageRecord = DataCommon.NullImageAsset
    self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._count:SetText("")
    self._grayIcon:SetActive(false)
    local defaultCellVarRecord = CVarconfig:GetRecorder(28)
    imageRecord = CImagePathTable:GetRecorder(tonumber(defaultCellVarRecord.Value))
    self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    return
  end
  local imageRecord = data.item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    self._count:SetNumber(data.num)
  else
    self._count:SetNumber(data.item:GetCount())
  end
  if self._delegate.IfInResolveMode and self._delegate:IfInResolveMode() and data.item then
    self._grayIcon:SetActive(not data.item:CanResolve())
  else
    self._grayIcon:SetActive(false)
  end
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  if data.item:GetTermTime() and data.item:GetTermTime() > 0 then
    self._task = ServerGameTimer.AddTask(0, 1, function()
      self:CountDown()
    end, nil)
  end
end

function BagCell:CountDown()
  local time = self._cellData.item:GetDelTime() - ServerGameTimer.GetServerTime()
  if time < 0 then
    local CUpdateLimitedItems = LuaNetManager.CreateProtocol("protocol.item.cupdatelimiteditems")
    if CUpdateLimitedItems then
      CUpdateLimitedItems.itemKey = self._cellData.item:GetKey()
      CUpdateLimitedItems.itemId = self._cellData.item:GetID()
      CUpdateLimitedItems:Send()
    end
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function BagCell:SetResoveModelState(bResove)
  if bResove and self._cellData.item then
    self._grayIcon:SetActive(not self._cellData.item:CanResolve())
  else
    self._grayIcon:SetActive(false)
  end
end

function BagCell:OnCellClicked(args, luawindow)
  if not self._cellData.item then
    return
  end
  if self._delegate.IfInResolveMode and self._delegate:IfInResolveMode() then
    if self._cellData.item:CanResolve() then
      self:OnResolve()
    end
    return
  end
  self._Select:SetActive(true)
  self._delegate:SetSelectedID(self._cellData.item:GetKey())
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
      tipsDialog:Init(self._cellData, self._delegate.IsBag and self._delegate.IsBag())
      tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

function BagCell:OnEvent(eventName, arg)
  if not self._cellData.item then
    return
  end
  if eventName == "ChangedSelected" then
    self._Select:SetActive(self._cellData.item:GetKey() == arg)
  elseif eventName == "RefreshCell" then
    if not arg.item or self._cellData.item:GetKey() == arg.item:GetKey() then
      self:RefreshCell(arg)
    end
  elseif eventName == "SetResoveModelState" then
    self:SetResoveModelState(arg)
  end
end

function BagCell:OnResolve()
  DialogManager.CreateSingletonDialog("bag.itemresolvedialog"):Init(self._cellData.item)
end

return BagCell
