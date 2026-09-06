local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CItemTable = BeanManager.GetTableByName("item.citemattr")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CLoverStoreCfg = BeanManager.GetTableByName("activity.cvalentinestore")
local CLinesCfg = BeanManager.GetTableByName("activity.cfoodstallslines")
local timeofword = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(88).Value)
local LoverStoreDialog = class("LoverStoreDialog", Dialog)
LoverStoreDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverStoreDialog.AssetName = "ActivityValentinesStore"

local function CheckFormula(self, id)
  local recorder = CLoverStoreCfg:GetRecorder(id)
  if recorder then
    local consumablesNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(recorder.itemId1)
    if consumablesNum >= recorder.itemNum1 * recorder.buyNum then
      return true
    end
  end
end

function LoverStoreDialog:Ctor(...)
  LoverStoreDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._moneyList = {
    DataCommon.LoveFlowers,
    DataCommon.LoveChocolate,
    DataCommon.LoveTownCurrency
  }
  self._messageBM = NekoData.BehaviorManager.BM_Message
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.LoverActivityManagerID)
end

function LoverStoreDialog:OnCreate()
  self._backImage = self:GetChild("BackImage")
  self._background = self:GetChild("Background")
  self._back1 = self:GetChild("Back1")
  self._title = self:GetChild("Title")
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1700))
  self._back1:Subscribe_PointerClickEvent(function()
    self:PlayVoiceText(1)
  end)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._dialogPanel = self:GetChild("Talk")
  self._dialogTxt = self:GetChild("Talk/Text")
  self._dialogPanel:SetActive(false)
  self._dialogPanel_width, self._dialogPanel_height = self._dialogPanel:GetDeltaSize()
  self._dialogPanel_txt_width, self._dialogPanel_txt_height = self._dialogTxt:GetDeltaSize()
  self._exchangeArea = {}
  local tempStr = "ChocolateBuy"
  for i = 1, 2 do
    local name = tempStr .. i
    local id = (i - 1) * 2 + 1
    self._exchangeArea[i] = {}
    self._exchangeArea[i].cell = self:GetChild(name)
    self._exchangeArea[i].onebtn = self:GetChild(name .. "/Onebtn")
    self._exchangeArea[i].tenbtn = self:GetChild(name .. "/Tenkbtn")
    self._exchangeArea[i].onebtn_text = self:GetChild(name .. "/Onebtn/Text")
    self._exchangeArea[i].tenbtn_text = self:GetChild(name .. "/Tenkbtn/Text")
    self._exchangeArea[i].directionText = self:GetChild(name .. "/Direction/Text")
    self._exchangeArea[i].onebtn:Subscribe_PointerClickEvent(function()
      self:OnGetBtnClicked(id)
    end)
    self._exchangeArea[i].tenbtn:Subscribe_PointerClickEvent(function()
      self:OnGetBtnClicked(id + 1)
    end)
    self._exchangeArea[i].onebtn_text:SetText(self._messageBM:GetString(1706, {
      CLoverStoreCfg:GetRecorder(id).buyNum
    }))
    self._exchangeArea[i].tenbtn_text:SetText(self._messageBM:GetString(1706, {
      CLoverStoreCfg:GetRecorder(id + 1).buyNum
    }))
    self._exchangeArea[i].directionText:SetText(self._messageBM:GetString(1723))
    self._exchangeArea[i].consumablesImg = self:GetChild(name .. "/Item1")
    self._exchangeArea[i].consumablesNumTxt = self:GetChild(name .. "/Item1/Num")
    self._exchangeArea[i].consumablesText = self:GetChild(name .. "/Item1/Text")
    self._exchangeArea[i].productImag = self:GetChild(name .. "/Item2")
    self._exchangeArea[i].productNumTxt = self:GetChild(name .. "/Item2/Num")
    self._exchangeArea[i].productText = self:GetChild(name .. "/Item2/Text")
    self._exchangeArea[i].unexpectedExplanationTxt = self:GetChild(name .. "/ImageBack/Num")
    self._exchangeArea[i].unexpectedProductImag = self:GetChild(name .. "/ImageBack/Item")
    self._exchangeArea[i].unexpectedProductNumTxt = self:GetChild(name .. "/ImageBack/Item/Num")
    local recorder = CLoverStoreCfg:GetRecorder(id)
    if recorder then
      do
        local consumablesItem = Item.Create(recorder.itemId1)
        local imageRecord = consumablesItem:GetIcon()
        self._exchangeArea[i].consumablesImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._exchangeArea[i].consumablesNumTxt:SetText(recorder.itemNum1)
        self._exchangeArea[i].consumablesText:SetText(consumablesItem:GetName())
        local productItem = Item.Create(recorder.itemId2)
        local imageRecord = productItem:GetIcon()
        self._exchangeArea[i].productImag:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._exchangeArea[i].productNumTxt:SetText(recorder.itemNum2)
        self._exchangeArea[i].productText:SetText(productItem:GetName())
        local unexpectedProductItem = Item.Create(recorder.itemId3)
        local imageRecord = unexpectedProductItem:GetIcon()
        self._exchangeArea[i].unexpectedProductImag:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._exchangeArea[i].unexpectedExplanationTxt:SetText(self._messageBM:GetString(1705, {
          recorder.item3Probability
        }))
        self._exchangeArea[i].unexpectedProductNumTxt:SetText(recorder.itemNum3)
        self._exchangeArea[i].consumablesImg:Subscribe_PointerClickEvent(function()
          self:OnItemCellClick(consumablesItem)
        end, self)
        self._exchangeArea[i].productImag:Subscribe_PointerClickEvent(function()
          self:OnItemCellClick(productItem)
        end, self)
        self._exchangeArea[i].unexpectedProductImag:Subscribe_PointerClickEvent(function()
          self:OnItemCellClick(unexpectedProductItem)
        end, self)
      end
    end
  end
  self._topGroup = self:GetChild("TopGroup")
  self._moneyFrame = TableFrame.Create(self._topGroup, self, false, false, true)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMoney, Common.n_RefreshCurrency, nil)
  self:Init()
end

function LoverStoreDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._moneyFrame then
    self._moneyFrame:Destroy()
    self._moneyFrame = nil
  end
  if self._contentTimer then
    GameTimer.RemoveTask(self._contentTimer)
    self._contentTimer = nil
  end
end

function LoverStoreDialog:Init()
  self:OnRefreshMoney()
  self:PlayVoiceText(1)
end

function LoverStoreDialog:NumberOfCell(frame)
  if frame == self._moneyFrame then
    return #self._moneyList
  end
end

function LoverStoreDialog:CellAtIndex(frame, index)
  if frame == self._moneyFrame then
    return "activity.lover.lovermoneynumcell"
  end
end

function LoverStoreDialog:DataAtIndex(frame, index)
  if frame == self._moneyFrame then
    return self._moneyList[index]
  end
end

function LoverStoreDialog:OnBackBtnClicked()
  self:Destroy()
end

function LoverStoreDialog:OnGetBtnClicked(id)
  if CheckFormula(self, id) then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.cdialoguebuy")
    if protocol then
      protocol.id = id
      protocol:Send()
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100453)
  end
end

function LoverStoreDialog:OnRefreshMoney()
  self._moneyFrame:ReloadAllCell()
end

function LoverStoreDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function LoverStoreDialog:PlayVoiceText(id)
  self._linesText = TextManager.GetText(self._bm:GetRandomLine(self._bm.LineFuncitionType.Store, id))
  self._linesText = string.gsub(self._linesText, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username or "")
  self._dialogTxt:SetActive(true)
  self._dialogPanel:SetActive(true)
  self._dialogTxt:SetText(self._linesText)
  local _, textheight = self._dialogTxt:GetPreferredSize()
  if textheight > self._dialogPanel_txt_height then
    self._dialogTxt:SetDeltaSize(self._dialogPanel_txt_width, textheight)
    self._dialogPanel:SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height + textheight - self._dialogPanel_txt_height)
  else
    self._dialogTxt:SetDeltaSize(self._dialogPanel_txt_width, self._dialogPanel_txt_height)
    self._dialogPanel:SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height)
  end
  local text = string.trim(self._linesText)
  if self._contentTimer then
    GameTimer.RemoveTask(self._contentTimer)
    self._contentTimer = nil
  end
  self._contentTimer = GameTimer.AddTask(utf8.len(text) * timeofword / 1000, -1, function()
    if self._contentTimer then
      GameTimer.RemoveTask(self._contentTimer)
      self._contentTimer = nil
      self._dialogTxt:SetActive(false)
      self._dialogPanel:SetActive(false)
    end
  end)
end

function LoverStoreDialog:OnItemCellClick(item)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = item})
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return LoverStoreDialog
