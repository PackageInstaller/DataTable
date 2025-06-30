-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasfoodstallsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local CChrisFoodStallsConfig = (BeanManager.GetTableByName)("dungeonselect.cchrisfoodstallsconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local timeofword = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(88)).Value)
local ChristmasFoodStallsDialog = class("ChristmasFoodStallsDialog", Dialog)
ChristmasFoodStallsDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasFoodStallsDialog.AssetName = "ActivityChristmasStalls"
ChristmasFoodStallsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasFoodStallsDialog
  ((ChristmasFoodStallsDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

ChristmasFoodStallsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._text = self:GetChild("UI/MenuToday/Text")
  ;
  (self._text):SetActive(false)
  self._eatbtn = self:GetChild("UI/MenuToday/Checkbtn")
  self._stateTip = self:GetChild("UI/MenuToday/Text2")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._eatbtn):Subscribe_PointerClickEvent(self.OnEatBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShow, Common.n_OnRefreshChristmasFoodStallsStatus, nil)
  self._image1 = self:GetChild("Image1")
  self._image2 = self:GetChild("Image2")
end

ChristmasFoodStallsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChristmasFoodStallsDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetSnackData()
  self._open = data.isOpen
  self._used = data.used
  self:RefreshShow()
end

ChristmasFoodStallsDialog.RefreshShow = function(self)
  -- function num : 0_4 , upvalues : _ENV, CChrisFoodStallsConfig, CstringCfg
  local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetSnackData()
  local hasData = next(data) ~= nil
  ;
  (self._stateTip):SetActive(false)
  self._data = {}
  if hasData then
    local snack = CChrisFoodStallsConfig:GetRecorder(data.snack)
    if not snack then
      (self._eatbtn):SetActive(false)
      ;
      (self._stateTip):SetActive(true)
      local str = (TextManager.GetText)((CstringCfg:GetRecorder(1601)).msgTextID)
      ;
      (self._stateTip):SetText(str)
      ;
      (self._image1):SetActive(false)
      ;
      (self._image2):SetActive(true)
      LogErrorFormat("ChristmasFoodStallsDialog", "Error ID In  CChrisFoodStallsConfig%s", data.snack)
      return 
    end
    local type = snack.itemId
    ;
    (self._image1):SetActive(type == 1)
    ;
    (self._image2):SetActive(type == 2)
    local str = (CstringCfg:GetRecorder(1599)).msgTextID
    str = (TextManager.GetText)(str)
    if snack.apNums == -1 then
      str = (string.gsub)(str, "%$parameter1%$", ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull())
      -- DECOMPILER ERROR at PC109: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._data).addnum = ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull()
    elseif snack.apNums == -2 then
      str = (string.gsub)(str, "%$parameter1%$", (math.ceil)(((NekoData.BehaviorManager).BM_Currency):GetSpiritFull() / 2))
      -- DECOMPILER ERROR at PC139: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._data).addnum = (math.ceil)(((NekoData.BehaviorManager).BM_Currency):GetSpiritFull() / 2)
    else
      str = (string.gsub)(str, "%$parameter1%$", snack.apNums)
      -- DECOMPILER ERROR at PC150: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._data).addnum = snack.apNums
    end
    if data.isOpen == 1 then
      if data.used == 0 then
        (self._eatbtn):SetActive(true)
        ;
        (self._stateTip):SetActive(true)
        ;
        (self._stateTip):SetText(str)
      else
        (self._eatbtn):SetActive(false)
        ;
        (self._stateTip):SetActive(true)
        local str = (TextManager.GetText)((CstringCfg:GetRecorder(1602)).msgTextID)
        ;
        (self._stateTip):SetText(str)
      end
    else
      (self._eatbtn):SetActive(false)
      ;
      (self._stateTip):SetActive(true)
      local str = (TextManager.GetText)((CstringCfg:GetRecorder(1601)).msgTextID)
      ;
      (self._stateTip):SetText(str)
    end
    self._open = data.isOpen
    self._used = data.used
  else
    (self._eatbtn):SetActive(false)
    ;
    (self._stateTip):SetActive(true)
    local str = (TextManager.GetText)((CstringCfg:GetRecorder(1601)).msgTextID)
    ;
    (self._stateTip):SetText(str)
    ;
    (self._image1):SetActive(false)
    ;
    (self._image2):SetActive(true)
  end
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

ChristmasFoodStallsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

ChristmasFoodStallsDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ChristmasFoodStallsDialog.OnEatBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self._data or next(self._data) == nil then
    LogError("ChristmasFoodStallsDialog", "No Exist Snack Data")
    return 
  end
  local addnum = (self._data).addnum
  local totalNum = ((NekoData.BehaviorManager).BM_Currency):GetSpirit() + (self._data).addnum
  local fullnum = ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull()
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(127, {addnum, totalNum, fullnum}, function()
    -- function num : 0_7_0 , upvalues : _ENV
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cchristmasactivityevent")
    csend.eventID = ((DataCommon.Christmas).Function).Eat
    csend:Send()
  end
, {}, nil, {})
end

return ChristmasFoodStallsDialog

