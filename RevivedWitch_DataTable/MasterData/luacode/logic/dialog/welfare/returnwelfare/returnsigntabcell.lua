-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnsigntabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local CBackActivity = (BeanManager.GetTableByName)("welfare.cbackactivity")
local ReturnSignTabCell = class("ReturnSignTabCell", Dialog)
ReturnSignTabCell.AssetBundleName = "ui/layouts.welfare"
ReturnSignTabCell.AssetName = "ReturnWelfareDay"
ReturnSignTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnSignTabCell
  ((ReturnSignTabCell.super).Ctor)(self, ...)
  self._init = false
  self._itemList = {}
  self._totalSignTimes = nil
  self._endTime = nil
  self._effectList = {}
end

ReturnSignTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._backImg = self:GetChild("BackImage")
  self._title = self:GetChild("BackImage/Title")
  self._timeTxt = self:GetChild("BackImage/Time")
  self._itemPanel = self:GetChild("BackImage/Frame")
  self._itemFrame = (GridFrame.Create)(self._itemPanel, self, false, 1, true)
end

local PlayEnableReceiveEffect = function(self)
  -- function num : 0_2
  self._effectList = {}
  ;
  (self._itemFrame):FireEvent("ReceiveEffect")
end

ReturnSignTabCell.RefreshTabCell = function(self, activityId, refresh, refreshByProtocol)
  -- function num : 0_3 , upvalues : _ENV, PlayEnableReceiveEffect, CBackActivity, CImagePathTable
  local tag = nil
  if not self._init or not refresh then
    self._delaytimeTask = (GameTimer.AddTask)(0.1, -1, function()
    -- function num : 0_3_0 , upvalues : PlayEnableReceiveEffect, self
    PlayEnableReceiveEffect(self)
  end
)
    tag = true
  end
  self._activityId = activityId
  if ((NekoData.BehaviorManager).BM_Activity):HasActivity(activityId) then
    if not self._init or refresh then
      local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetSignActivityById(activityId)
      if not self._init then
        self._init = true
        local activityRecord = CBackActivity:GetRecorder(activityId)
        if not CImagePathTable:GetRecorder(activityRecord.bgImage) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
      end
      do
        do
          self._totalSignTimes = data.totalSignNum
          self._itemList = data.awards
          for i,v in ipairs(self._itemList) do
            v.cell = ((CBackActivity:GetRecorder(activityId)).cell)[i]
            if not v.receive or v.index <= self._totalSignTimes then
              if not tag and refreshByProtocol then
                (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
                PlayEnableReceiveEffect(self)
              else
                if tag and (self._delegate)._selectedTab == self._activityId then
                  (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
                end
              end
            end
          end
          self._endTime = ((NekoData.BehaviorManager).BM_Activity):GetEndTime(self._activityId)
          self:RefreshTime()
          if not self._activityTask then
            self._activityTask = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_3_1 , upvalues : self
    self:RefreshTime()
  end
)
          end
          ;
          (self._itemFrame):ReloadAllCell()
          do
            if not refresh then
              local index = self:GetCanGetFirstIndex()
              if index then
                (self._itemFrame):MoveLeftToIndex(index)
              else
                ;
                (self._itemFrame):MoveToLeft()
              end
            end
            if self._activityTask then
              (GameTimer.RemoveTask)(self._activityTask)
              self._activityTask = nil
            end
          end
        end
      end
    end
  end
end

ReturnSignTabCell.GetCanGetFirstIndex = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for i,v in ipairs(self._itemList) do
    if not v.receive and v.index <= self._totalSignTimes then
      return i
    end
  end
end

ReturnSignTabCell.OnDestroy = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._itemFrame):Destroy()
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
  if self._delaytimeTask then
    (GameTimer.RemoveTask)(self._delaytimeTask)
    self._delaytimeTask = nil
  end
end

ReturnSignTabCell.OnCellClick = function(self, index)
  -- function num : 0_6 , upvalues : _ENV
  local data = (self._itemList)[index]
  if index == roleDay then
    self:OnRoleDetailBtnClick()
  else
    local width, height = (self:GetRootWindow()):GetRectSize()
    local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if dialog then
      dialog:Init({item = (Item.Create)(data.itemId)})
      dialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
    end
  end
end

ReturnSignTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._itemList
end

ReturnSignTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "welfare.returnwelfare.returnsignactivityitemcell"
end

ReturnSignTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemList)[index]
end

ReturnSignTabCell.RefreshTime = function(self)
  -- function num : 0_10 , upvalues : _ENV, CStringRes
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
      (self._timeTxt):SetText(str .. day .. str1)
    else
      do
        if hour > 0 then
          local str2 = (TextManager.GetText)((CStringRes:GetRecorder(1044)).msgTextID)
          ;
          (self._timeTxt):SetText(str .. hour .. str2)
        else
          do
            local str3 = (TextManager.GetText)((CStringRes:GetRecorder(1045)).msgTextID)
            ;
            (self._timeTxt):SetText(str .. min .. str3)
          end
        end
      end
    end
  end
end

ReturnSignTabCell.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_11 , upvalues : PlayEnableReceiveEffect
  if stateName == "SignActivty" then
    PlayEnableReceiveEffect(self)
  end
end

ReturnSignTabCell.OnEffectEnd = function(self, index)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if (self._effectList)[index] then
    (self._effectList)[index] = nil
  end
  local allEffectsEnd = true
  for i,v in pairs(self._effectList) do
    if v then
      allEffectsEnd = false
      break
    end
  end
  do
    if allEffectsEnd then
      (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
      local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceiveaward")
      protocol.actId = self._activityId
      protocol:Send()
    end
  end
end

return ReturnSignTabCell

