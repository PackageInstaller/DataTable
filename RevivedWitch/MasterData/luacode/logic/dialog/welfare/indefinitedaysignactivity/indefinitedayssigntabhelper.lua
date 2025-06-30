-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/indefinitedaysignactivity/indefinitedayssigntabhelper.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CTotalLoginActivity = (BeanManager.GetTableByName)("welfare.ctotalloginactivity")
local CWelfareTabCfg = (BeanManager.GetTableByName)("welfare.cwelfaretabconfig")
local CTotalLoginActivityShow = (BeanManager.GetTableByName)("welfare.ctotalloginactivityshow")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local IndefiniteDaysSignTabHelper = class("IndefiniteDaysSignTabHelper")
local BottomToTop = 3
local RoleTypeId = 27
IndefiniteDaysSignTabHelper.Ctor = function(self, father, rootElement, colsOrRows, canSlide)
  -- function num : 0_0 , upvalues : _ENV, CStringRes, GridFrame, BottomToTop
  self._init = false
  self._endTime = nil
  self._totalSignTimes = nil
  self._itemList = {}
  self._effectList = {}
  self._toShowRoleID = nil
  self._father = father
  self._rootElement = rootElement
  self._colsOrRows = colsOrRows
  self._canSlide = canSlide
  self._titleImage = (self._rootElement):FindChild("Name")
  self._backImage = (self._rootElement):FindChild("BackImage")
  self._tipsTxt = (self._rootElement):FindChild("BackImage/Tips")
  self._timeLimit = (self._rootElement):FindChild("BackImage/TimeLimit")
  self._timeLimitTxt = (self._rootElement):FindChild("BackImage/TimeLimit/Time")
  self._roleDetailBtn = (self._rootElement):FindChild("BackImage/DetailBtn")
  ;
  (self._roleDetailBtn):Subscribe_PointerClickEvent(self.OnRoleDetailBtnClick, self)
  self._roleDetailBtnTxt = (self._rootElement):FindChild("BackImage/DetailBtn/Txt")
  ;
  (self._roleDetailBtnTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1777)).msgTextID))
  self._cellPanel = (self._rootElement):FindChild("BackImage/CellFrame")
  self._cellFrame = (GridFrame.Create)(self._cellPanel, self, true, self._colsOrRows, self._canSlide)
  self._scrollBar = (self._rootElement):FindChild("BackImage/Scrollbar")
  if self._scrollBar then
    (self._scrollBar):SetScrollDirection(BottomToTop)
  end
end

IndefiniteDaysSignTabHelper.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._cellFrame then
    (self._cellFrame):Destroy()
  end
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
  if self._delaytimeTask then
    (GameTimer.RemoveTask)(self._delaytimeTask)
    self._delaytimeTask = nil
  end
end

IndefiniteDaysSignTabHelper.RefreshTabCell = function(self, delegate, activityId, refresh, refreshByProtocol)
  -- function num : 0_2 , upvalues : CTotalLoginActivityShow, _ENV, CTotalLoginActivity, CImagePathTable, Item, RoleTypeId
  self._delegate = delegate
  self._totalCellShow = CTotalLoginActivityShow:GetRecorder(activityId)
  local tag = nil
  if not self._init or not refresh then
    self:PlayEnableReceiveEffect()
    tag = true
  end
  self._activityId = activityId
  if ((NekoData.BehaviorManager).BM_Activity):HasActivity(activityId) then
    if not self._init or refresh then
      local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetSignActivityById(activityId)
      if not self._init then
        self._init = true
        local activityRecord = CTotalLoginActivity:GetRecorder(activityId)
        ;
        (self._tipsTxt):SetText((TextManager.GetText)(activityRecord.description))
        if not CImagePathTable:GetRecorder(activityRecord.bgImage) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._backImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        if not CImagePathTable:GetRecorder(activityRecord.titleImage) then
          imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._titleImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      do
        if self._activityTask then
          (GameTimer.RemoveTask)(self._activityTask)
          self._activityTask = nil
        end
        self._endTime = ((NekoData.BehaviorManager).BM_Activity):GetEndTime(self._activityId)
        self._activityTask = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_2_0 , upvalues : self
    self:RefreshTime()
  end
)
        self._totalSignTimes = data.totalSignNum
        self._itemList = data.awards
        self._toShowRoleID = nil
        for index,value in ipairs(self._itemList) do
          value.extraCfg = (string.split)(((self._totalCellShow).reward)[index], ";")
          if self._toShowRoleID == nil and ((Item.Create)(value.itemId)):GetItemTypeId() == RoleTypeId then
            self._toShowRoleID = value.itemId
          end
        end
        ;
        (self._roleDetailBtn):SetActive(self._toShowRoleID ~= nil)
        ;
        (self._cellFrame):ReloadAllCell()
        if self._canSlide then
          local canGetFirstIndex = self:GetCanGetFirstIndex()
          local haveGetLastIndex = self:GetHaveGetLastIndex()
          if canGetFirstIndex then
            (self._cellFrame):MoveTopToIndex(canGetFirstIndex)
          elseif haveGetLastIndex and refreshByProtocol then
            (self._cellFrame):MoveTopToIndex(haveGetLastIndex)
          else
            (self._cellFrame):MoveToTop()
          end
        end
        for _,value in ipairs(self._itemList) do
          if not value.receive and value.index <= self._totalSignTimes then
            if not tag and refreshByProtocol then
              (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
              self:PlayEnableReceiveEffect()
            elseif tag and (self._delegate)._selectedTab == self._activityId then
              (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
            end
          end
        end
        if not refresh then
          local canGetFirstIndex = self:GetCanGetFirstIndex()
          local haveGetLastIndex = self:GetHaveGetLastIndex()
          if canGetFirstIndex then
            (self._cellFrame):MoveTopToIndex(canGetFirstIndex)
          elseif haveGetLastIndex and refreshByProtocol then
            (self._cellFrame):MoveTopToIndex(haveGetLastIndex)
          else
            (self._cellFrame):MoveToTop()
          end
        end
        if self._activityTask then
          (GameTimer.RemoveTask)(self._activityTask)
          self._activityTask = nil
        end
        -- DECOMPILER ERROR: 11 unprocessed JMP targets
      end
    end
  end
end

IndefiniteDaysSignTabHelper.GetCanGetFirstIndex = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in ipairs(self._itemList) do
    if not v.receive and v.index <= self._totalSignTimes then
      return i
    end
  end
end

IndefiniteDaysSignTabHelper.GetHaveGetLastIndex = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local lastHaveGet = nil
  for i,v in ipairs(self._itemList) do
    if v.receive then
      lastHaveGet = i
    end
  end
  return lastHaveGet
end

IndefiniteDaysSignTabHelper.PlayEnableReceiveEffect = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._delaytimeTask then
    (GameTimer.RemoveTask)(self._delaytimeTask)
    self._delaytimeTask = nil
  end
  self._delaytimeTask = (GameTimer.AddTask)(0.1, -1, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    for key,_ in pairs(self._effectList) do
      -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

      (self._effectList)[key] = nil
    end
    ;
    (self._cellFrame):FireEvent("ReceiveEffect")
  end
)
end

IndefiniteDaysSignTabHelper.RefreshTime = function(self)
  -- function num : 0_6 , upvalues : _ENV, CStringRes
  if self._endTime then
    local time = (self._endTime - (ServerGameTimer.GetServerTimeForecast)()) / 1000
    local day = (math.floor)(time / 86400)
    local hour = (math.floor)((time - day * 24 * 60 * 60) / 3600)
    local min = (math.floor)((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = (math.floor)(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1042)).msgTextID)
    if day > 0 then
      local str1 = (TextManager.GetText)((CStringRes:GetRecorder(1043)).msgTextID)
      ;
      (self._timeLimitTxt):SetText(str .. day .. str1)
    else
      do
        if hour > 0 then
          local str2 = (TextManager.GetText)((CStringRes:GetRecorder(1044)).msgTextID)
          ;
          (self._timeLimitTxt):SetText(str .. hour .. str2)
        else
          do
            local str3 = (TextManager.GetText)((CStringRes:GetRecorder(1045)).msgTextID)
            ;
            (self._timeLimitTxt):SetText(str .. min .. str3)
          end
        end
      end
    end
  end
end

IndefiniteDaysSignTabHelper.OnEffectEnd = function(self, index, window, effectHandler)
  -- function num : 0_7 , upvalues : _ENV
  local allEffectsEnd = next(self._effectList) == nil
  if allEffectsEnd then
    (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceiveaward")
    if protocol then
      protocol.actId = self._activityId
      protocol:Send()
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

IndefiniteDaysSignTabHelper.CellAtIndex = function(self, frame, index)
  -- function num : 0_8 , upvalues : _ENV
  if (self._father).CellAtIndex then
    return (self._father):CellAtIndex(frame, index)
  else
    LogError("IndefiniteDaysSignTabHelper", "Need CellAtIndex Func In Father!")
  end
end

IndefiniteDaysSignTabHelper.NumberOfCell = function(self, frame, index)
  -- function num : 0_9
  return #self._itemList
end

IndefiniteDaysSignTabHelper.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._itemList)[index]
end

IndefiniteDaysSignTabHelper.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_11
  if (self._father).OnCurPosChange then
    (self._father):OnCurPosChange(frame, proportion)
  end
  if self._scrollBar then
    local width, height = (self._cellPanel):GetRectSize()
    local total = (self._cellFrame):GetTotalLength()
    if height < total then
      (self._scrollBar):SetActive(true)
      ;
      (self._scrollBar):SetScrollSize(height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      ;
      (self._scrollBar):SetActive(false)
    end
  end
end

IndefiniteDaysSignTabHelper.OnRoleDetailBtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV, CRoleItemTable
  if self._toShowRoleID == nil then
    LogError("IndefiniteDaysSignTabHelper:OnRoleDetailBtnClick", "self._toShowRoleID is nil!")
    return 
  end
  local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
  local roleInfoDialog = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
  local roleIDList = {(CRoleItemTable:GetRecorder(self._toShowRoleID)).roleid}
  local cfgIDList = {4}
  roleInfoDialog:Init({roleIdList = roleIDList, cfgIdList = cfgIDList, index = 1}, (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo)
end

return IndefiniteDaysSignTabHelper

