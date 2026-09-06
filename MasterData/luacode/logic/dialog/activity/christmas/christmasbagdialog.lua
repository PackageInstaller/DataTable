local ChrisFrameCfg = BeanManager.GetTableByName("dungeonselect.cchrisframeconfig")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local MaxColumnNums = 4
local ChristmasBagDialog = class("ChristmasBagDialog", Dialog)
ChristmasBagDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBagDialog.AssetName = "ActivityChristmasBag"

local function RefreshCell(self, id)
  local data = self._dataList[id]
  self._cell[id].text:SetText(data.item:GetName())
  local imageRecord
  if data.unlock then
    imageRecord = CImagePathTable:GetRecorder(data.record.imagex) or DataCommon.DefaultImageAsset
  else
    imageRecord = CImagePathTable:GetRecorder(data.record.imagey) or DataCommon.DefaultImageAsset
  end
  self._cell[id].image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

local function RefreshAllCell(self)
  for i, v in ipairs(self._cell) do
    if self._dataList[i] then
      self._cell[i].cell:SetActive(true)
      RefreshCell(self, i)
    else
      self._cell[i].cell:SetActive(false)
    end
  end
end

function ChristmasBagDialog:Ctor(...)
  ChristmasBagDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._dataList = {}
  self._selectBuffItemId = nil
end

function ChristmasBagDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._title = self:GetChild("Title")
  self._tip = self:GetChild("Text")
  self._title:SetText(TextManager.GetText(1901204))
  self._tip:SetText(TextManager.GetText(1901452))
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._cell = {}
  for i = 1, 9 do
    self._cell[i] = {}
    self._cell[i].cell = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i)
    self._cell[i].text = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i .. "/Text")
    self._cell[i].mask = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i .. "/Mask")
    self._cell[i].image = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i .. "/Image")
    self._cell[i].imageBack = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i .. "/ImageBack")
    self._cell[i].image:SetActive(true)
    self._cell[i].imageBack:SetActive(false)
    self._cell[i].mask:Subscribe_PointerClickEvent(function()
      local index = i
      self:OnCellClicked(index)
    end, self)
  end
  LuaNotificationCenter.AddObserver(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
end

function ChristmasBagDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ChristmasBagDialog:SetData(data)
  while self._dataList[#self._dataList] do
    table.remove(self._dataList, #self._dataList)
  end
  for k, v in pairs(data) do
    local record = ChrisFrameCfg:GetRecorder(k)
    if record then
      local item = Item.Create(k)
      if item then
        local unlock = v == 1
        table.insert(self._dataList, {
          itemId = k,
          unlock = unlock,
          record = record,
          item = item
        })
      end
    else
      LogErrorFormat("ChristmasBagDialog", "buff with id %s is not exist in cchrisframeconfig.", k)
    end
  end
  table.sort(self._dataList, function(a, b)
    return a.record.sort < b.record.sort
  end)
  RefreshAllCell(self)
end

function ChristmasBagDialog:SelectedCell(itemId)
  if itemId ~= self._selectBuffItemId then
    self._selectBuffItemId = itemId
  end
end

function ChristmasBagDialog:OnTipsDestroy(notification)
  if notification.userInfo._dialogName == "bag.itemtipsdialog" then
    self:SelectedCell(nil)
  end
end

function ChristmasBagDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChristmasBagDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ChristmasBagDialog:OnCellClicked(index)
  local itemId = self._dataList[index].item
  self:SelectedCell(itemId)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = itemId})
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return ChristmasBagDialog
