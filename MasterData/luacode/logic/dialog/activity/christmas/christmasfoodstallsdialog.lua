local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local CChrisFoodStallsConfig = BeanManager.GetTableByName("dungeonselect.cchrisfoodstallsconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local timeofword = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(88).Value)
local ChristmasFoodStallsDialog = class("ChristmasFoodStallsDialog", Dialog)
ChristmasFoodStallsDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasFoodStallsDialog.AssetName = "ActivityChristmasStalls"

function ChristmasFoodStallsDialog:Ctor(...)
  ChristmasFoodStallsDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function ChristmasFoodStallsDialog:OnCreate()
  self._text = self:GetChild("UI/MenuToday/Text")
  self._text:SetActive(false)
  self._eatbtn = self:GetChild("UI/MenuToday/Checkbtn")
  self._stateTip = self:GetChild("UI/MenuToday/Text2")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._eatbtn:Subscribe_PointerClickEvent(self.OnEatBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshShow, Common.n_OnRefreshChristmasFoodStallsStatus, nil)
  self._image1 = self:GetChild("Image1")
  self._image2 = self:GetChild("Image2")
end

function ChristmasFoodStallsDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ChristmasFoodStallsDialog:Init()
  local data = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetSnackData()
  self._open = data.isOpen
  self._used = data.used
  self:RefreshShow()
end

function ChristmasFoodStallsDialog:RefreshShow()
  local data = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetSnackData()
  local hasData = next(data) ~= nil
  self._stateTip:SetActive(false)
  self._data = {}
  if hasData then
    local snack = CChrisFoodStallsConfig:GetRecorder(data.snack)
    if not snack then
      self._eatbtn:SetActive(false)
      self._stateTip:SetActive(true)
      local str = TextManager.GetText(CstringCfg:GetRecorder(1601).msgTextID)
      self._stateTip:SetText(str)
      self._image1:SetActive(false)
      self._image2:SetActive(true)
      LogErrorFormat("ChristmasFoodStallsDialog", "Error ID In  CChrisFoodStallsConfig%s", data.snack)
      return
    end
    local type = snack.itemId
    self._image1:SetActive(type == 1)
    self._image2:SetActive(type == 2)
    local str = CstringCfg:GetRecorder(1599).msgTextID
    str = TextManager.GetText(str)
    if snack.apNums == -1 then
      str = string.gsub(str, "%$parameter1%$", NekoData.BehaviorManager.BM_Currency:GetSpiritFull())
      self._data.addnum = NekoData.BehaviorManager.BM_Currency:GetSpiritFull()
    elseif snack.apNums == -2 then
      str = string.gsub(str, "%$parameter1%$", math.ceil(NekoData.BehaviorManager.BM_Currency:GetSpiritFull() / 2))
      self._data.addnum = math.ceil(NekoData.BehaviorManager.BM_Currency:GetSpiritFull() / 2)
    else
      str = string.gsub(str, "%$parameter1%$", snack.apNums)
      self._data.addnum = snack.apNums
    end
    if data.isOpen == 1 then
      if data.used == 0 then
        self._eatbtn:SetActive(true)
        self._stateTip:SetActive(true)
        self._stateTip:SetText(str)
      else
        self._eatbtn:SetActive(false)
        self._stateTip:SetActive(true)
        local str = TextManager.GetText(CstringCfg:GetRecorder(1602).msgTextID)
        self._stateTip:SetText(str)
      end
    else
      self._eatbtn:SetActive(false)
      self._stateTip:SetActive(true)
      local str = TextManager.GetText(CstringCfg:GetRecorder(1601).msgTextID)
      self._stateTip:SetText(str)
    end
    self._open = data.isOpen
    self._used = data.used
  else
    self._eatbtn:SetActive(false)
    self._stateTip:SetActive(true)
    local str = TextManager.GetText(CstringCfg:GetRecorder(1601).msgTextID)
    self._stateTip:SetText(str)
    self._image1:SetActive(false)
    self._image2:SetActive(true)
  end
end

function ChristmasFoodStallsDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChristmasFoodStallsDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ChristmasFoodStallsDialog:OnEatBtnClicked()
  if not self._data or next(self._data) == nil then
    LogError("ChristmasFoodStallsDialog", "No Exist Snack Data")
    return
  end
  local addnum = self._data.addnum
  local totalNum = NekoData.BehaviorManager.BM_Currency:GetSpirit() + self._data.addnum
  local fullnum = NekoData.BehaviorManager.BM_Currency:GetSpiritFull()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(127, {
    addnum,
    totalNum,
    fullnum
  }, function()
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cchristmasactivityevent")
    csend.eventID = DataCommon.Christmas.Function.Eat
    csend:Send()
  end, {}, nil, {})
end

return ChristmasFoodStallsDialog
