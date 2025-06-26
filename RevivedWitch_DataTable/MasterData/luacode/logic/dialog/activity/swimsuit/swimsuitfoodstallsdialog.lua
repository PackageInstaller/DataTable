-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitfoodstallsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CFoodStallsPosterGirl = (BeanManager.GetTableByName)("activity.cfoodstallspostergirl")
local CFoodStallsConfig = (BeanManager.GetTableByName)("activity.cfoodstallsconfig")
local CFoodStallsLines = (BeanManager.GetTableByName)("activity.cfoodstallslines")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CHexagonFunction = (BeanManager.GetTableByName)("activity.chexagonfunction")
local Chexagonchatconfig = (BeanManager.GetTableByName)("dialog.chexagonchatconfig")
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local timeofword = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(88)).Value)
local SwimSuitFoodStallsDialog = class("SwimSuitFoodStallsDialog", Dialog)
SwimSuitFoodStallsDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitFoodStallsDialog.AssetName = "ActivitySummerStalls"
SwimSuitFoodStallsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitFoodStallsDialog
  ((SwimSuitFoodStallsDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SwimSuitFoodStallsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._topGroup = self:GetChild("UI/TopGroup")
  self._title = self:GetChild("UI/MenuToday/Title")
  self._icon = self:GetChild("UI/MenuToday/ItemCell/ItemCell/_BackGround/Icon")
  self._itemName = self:GetChild("UI/MenuToday/ItemName")
  self._text = self:GetChild("UI/MenuToday/Text")
  self._describe = self:GetChild("UI/MenuToday/Describe")
  self._eatbtn = self:GetChild("UI/MenuToday/Checkbtn")
  self._stateTip = self:GetChild("UI/MenuToday/Text2")
  self._dialogPanel = self:GetChild("Dialog")
  self._dialogTxt = self:GetChild("Dialog/Text")
  ;
  (self._dialogPanel):SetActive(false)
  self._dialogPanel_width = (self._dialogPanel):GetDeltaSize()
  self._dialogPanel_txt_width = (self._dialogTxt):GetDeltaSize()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._eatbtn):Subscribe_PointerClickEvent(self.OnEatBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShow, Common.n_RefreshFoodStallsStatus, nil)
end

SwimSuitFoodStallsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SwimSuitFoodStallsDialog.Init = function(self)
  -- function num : 0_3 , upvalues : CstringCfg, _ENV
  local str = (CstringCfg:GetRecorder(1600)).msgTextID
  ;
  (self._title):SetText((TextManager.GetText)(str))
  local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):GetSnackData()
  self._open = data.isOpen
  self._used = data.used
  if next(data) ~= nil and data.isOpen == 1 then
    self:PlayVoiceText(1)
  end
  self:RefreshShow()
end

SwimSuitFoodStallsDialog.RefreshShow = function(self)
  -- function num : 0_4 , upvalues : _ENV, CFoodStallsConfig, Item, CstringCfg
  local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):GetSnackData()
  local hasData = next(data) ~= nil
  ;
  (self._text):SetActive(hasData)
  ;
  (self._describe):SetActive(hasData)
  ;
  (self._itemName):SetActive(hasData)
  ;
  (self._icon):SetActive(hasData)
  ;
  (self._stateTip):SetActive(false)
  self._data = {}
  if hasData then
    local snack = CFoodStallsConfig:GetRecorder(data.snack)
    local item = (Item.Create)(snack.itemId)
    ;
    (self._itemName):SetText(item:GetName())
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._data).name = item:GetName()
    local imageRecord = item:GetIcon()
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    local str = (CstringCfg:GetRecorder(1599)).msgTextID
    str = (TextManager.GetText)(str)
    if snack.apNums == -1 then
      str = (string.gsub)(str, "%$parameter1%$", ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull())
      -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self._data).addnum = ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull()
    elseif snack.apNums == -2 then
      str = (string.gsub)(str, "%$parameter1%$", (math.ceil)(((NekoData.BehaviorManager).BM_Currency):GetSpiritFull() / 2))
      -- DECOMPILER ERROR at PC123: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self._data).addnum = (math.ceil)(((NekoData.BehaviorManager).BM_Currency):GetSpiritFull() / 2)
    else
      str = (string.gsub)(str, "%$parameter2%$", snack.apNums)
      -- DECOMPILER ERROR at PC134: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self._data).addnum = snack.apNums
    end
    ;
    (self._text):SetText(str)
    ;
    (self._describe):SetText(item:GetDestribe())
    if data.isOpen == 1 then
      if data.used == 0 then
        (self._eatbtn):SetActive(true)
        ;
        (self._stateTip):SetActive(false)
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
    if data.isOpen == 0 and self._open == 1 then
      self:PlayVoiceText(2)
    end
    if data.used == 1 and self._used == 0 then
      self:PlayVoiceText(3)
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
  end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

SwimSuitFoodStallsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

SwimSuitFoodStallsDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

SwimSuitFoodStallsDialog.OnEatBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self._data or next(self._data) == nil then
    return 
  end
  local addnum = (self._data).addnum
  local totalNum = ((NekoData.BehaviorManager).BM_Currency):GetSpirit() + (self._data).addnum
  local fullnum = ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull()
  local temp = {(self._data).name, addnum, totalNum, fullnum}
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(122, temp, function()
    -- function num : 0_7_0 , upvalues : _ENV
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.chavingsnack")
    if csend then
      csend:Send()
    end
  end
, {}, nil, {})
end

SwimSuitFoodStallsDialog.PlayVoiceText = function(self, type)
  -- function num : 0_8 , upvalues : CFoodStallsLines, _ENV, timeofword
  local temp = {}
  local allIds = CFoodStallsLines:GetAllIds()
  for k,v in ipairs(allIds) do
    local record = CFoodStallsLines:GetRecorder(v)
    if type == record.type then
      (table.insert)(temp, record.textId)
    end
  end
  if next(temp) == nil then
    return 
  end
  local id = (math.random)(1, #temp)
  self._linesText = (TextManager.GetText)(temp[id])
  ;
  (self._dialogTxt):SetActive(true)
  ;
  (self._dialogPanel):SetActive(true)
  ;
  (self._dialogTxt):SetText(self._linesText)
  local _, textheight = (self._dialogTxt):GetPreferredSize()
  if self._dialogPanel_txt_height < textheight then
    (self._dialogTxt):SetDeltaSize(self._dialogPanel_txt_width, textheight)
    ;
    (self._dialogPanel):SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height + textheight - self._dialogPanel_txt_height)
  else
    ;
    (self._dialogTxt):SetDeltaSize(self._dialogPanel_txt_width, self._dialogPanel_txt_height)
    ;
    (self._dialogPanel):SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height)
  end
  local text = (string.trim)(self._linesText)
  if self._contentTimer then
    (GameTimer.RemoveTask)(self._contentTimer)
    self._contentTimer = nil
  end
  self._contentTimer = (GameTimer.AddTask)((utf8.len)(text) * timeofword / 1000, -1, function()
    -- function num : 0_8_0 , upvalues : self, _ENV
    if self._contentTimer then
      (GameTimer.RemoveTask)(self._contentTimer)
      self._contentTimer = nil
      ;
      (self._dialogTxt):SetActive(false)
      ;
      (self._dialogPanel):SetActive(false)
    end
  end
)
end

return SwimSuitFoodStallsDialog

