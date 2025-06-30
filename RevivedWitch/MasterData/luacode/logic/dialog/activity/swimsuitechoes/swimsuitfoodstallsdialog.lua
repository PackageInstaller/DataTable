-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/swimsuitfoodstallsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CSRAPConfig = (BeanManager.GetTableByName)("activity.csrap")
local CStringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local SwimSuitFoodStallsDialog = class("SwimSuitFoodStallsDialog", Dialog)
SwimSuitFoodStallsDialog.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitFoodStallsDialog.AssetName = "ActivitySummer2Stalls"
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
  self._eatbtnText = self:GetChild("UI/MenuToday/Checkbtn/_Text")
  self._totalTitle = self:GetChild("Title")
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
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShow, Common.n_OnSOpenEchoSnack, nil)
  ;
  (self._totalTitle):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2146))
end

SwimSuitFoodStallsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SwimSuitFoodStallsDialog.Init = function(self)
  -- function num : 0_3 , upvalues : CStringCfg, _ENV
  local str = (CStringCfg:GetRecorder(2149)).msgTextID
  ;
  (self._title):SetText((TextManager.GetText)(str))
  ;
  (self._eatbtnText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2150))
  local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):GetSnackData()
  self._open = data.isOpen
  self._used = data.used
  self:RefreshShow()
end

SwimSuitFoodStallsDialog.RefreshShow = function(self)
  -- function num : 0_4 , upvalues : _ENV, CSRAPConfig, Item, CStringCfg
  local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):GetSnackData()
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
    local snack = CSRAPConfig:GetRecorder(data.snack)
    local item = (Item.Create)(snack.iconID)
    ;
    (self._itemName):SetText(item:GetName())
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._data).name = item:GetName()
    local imageRecord = item:GetIcon()
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    local str = (CStringCfg:GetRecorder(1599)).msgTextID
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
      str = (string.gsub)(str, "%$parameter1%$", snack.apNums)
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
        local str = (TextManager.GetText)((CStringCfg:GetRecorder(2182)).msgTextID)
        ;
        (self._stateTip):SetText(str)
      end
    else
      (self._eatbtn):SetActive(false)
      ;
      (self._stateTip):SetActive(true)
      local str = (TextManager.GetText)((CStringCfg:GetRecorder(2183)).msgTextID)
      ;
      (self._stateTip):SetText(str)
    end
    self._open = data.isOpen
    self._used = data.used
  else
    (self._eatbtn):SetActive(false)
    ;
    (self._stateTip):SetActive(true)
    local str = (TextManager.GetText)((CStringCfg:GetRecorder(2183)).msgTextID)
    ;
    (self._stateTip):SetText(str)
  end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
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
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.chavingechosnack")
    if csend then
      csend:Send()
    end
  end
, {}, nil, {})
end

return SwimSuitFoodStallsDialog

