-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/messagetip/msgtipframedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MsgTipFrameDialog = class("MsgTipFrameDialog", Dialog)
MsgTipFrameDialog.AssetBundleName = "ui/layouts.toast"
MsgTipFrameDialog.AssetName = "ToastMain"
local INTERVAL = 0.2
local MAXTIME = 1
MsgTipFrameDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MsgTipFrameDialog
  ((MsgTipFrameDialog.super).Ctor)(self, ...)
  self._groupName = "Message"
  self._msgTipList = {}
  self._taskList = {}
  self._height = 0
  self._width = 0
end

MsgTipFrameDialog.OnCreate = function(self)
  -- function num : 0_1
  self._width = (self:GetRootWindow()):GetRectSize()
end

MsgTipFrameDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for i,v in ipairs(self._taskList) do
    (GameTimer.RemoveTask)(v)
    v = nil
  end
  for i,v in ipairs(self._msgTipList) do
    if v.cell then
      (v.cell):Destroy()
      ;
      (v.cell):RootWindowDestroy()
      v.cell = nil
    end
  end
end

MsgTipFrameDialog.OnRefresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if #self._msgTipList == 0 then
    (DialogManager.DestroySingletonDialog)("messagetip.msgtipframedialog")
    return 
  end
  local _, height = ((((self._msgTipList)[1]).cell):GetRootWindow()):GetRectSize()
  local deltaHeight = 0
  local deleteMsgList = {}
  for index = 2, #self._msgTipList do
    local w, h = ((((self._msgTipList)[index - 1]).cell):GetRootWindow()):GetRectSize()
    deltaHeight = deltaHeight + h
    ;
    ((((self._msgTipList)[index]).cell):GetRootWindow()):SetYPosition(0, deltaHeight)
    if self._height < deltaHeight + h then
      (table.insert)(deleteMsgList, index)
    end
  end
  do
    while deleteMsgList[#deleteMsgList] do
      local index = #deleteMsgList
      if (self._msgTipList)[index] and ((self._msgTipList)[index]).cell then
        (((self._msgTipList)[index]).cell):Destroy()
        if (((self._msgTipList)[index]).cell):GetRootWindow() then
          (((self._msgTipList)[index]).cell):RootWindowDestroy()
        end
        -- DECOMPILER ERROR at PC84: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self._msgTipList)[index]).cell = nil
        ;
        (table.remove)(self._msgTipList, index)
      end
      ;
      (table.remove)(deleteMsgList, #deleteMsgList)
    end
  end
end

MsgTipFrameDialog.AddMessageTip = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  local msgCell = {}
  msgCell.cell = (DialogManager.CreateDialog)("messagetip.msgtipcell", (self:GetRootWindow())._uiObject)
  ;
  (msgCell.cell):Refresh(msg)
  msgCell.str = msg
  local _, height = ((msgCell.cell):GetRootWindow()):GetRectSize()
  ;
  ((msgCell.cell):GetRootWindow()):SetYPosition(0, 0)
  ;
  (table.insert)(self._msgTipList, 1, msgCell)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._taskList)[#self._msgTipList] = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    if #self._msgTipList > 0 and (self._msgTipList)[#self._msgTipList] and ((self._msgTipList)[#self._msgTipList]).cell then
      (((self._msgTipList)[#self._msgTipList]).cell):Destroy()
      if (((self._msgTipList)[#self._msgTipList]).cell):GetRootWindow() then
        (((self._msgTipList)[#self._msgTipList]).cell):RootWindowDestroy()
      end
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((self._msgTipList)[#self._msgTipList]).cell = nil
      ;
      (table.remove)(self._msgTipList, #self._msgTipList)
    end
    if #self._msgTipList <= 0 then
      self:OnRefresh()
    end
  end
, nil)
  self:OnRefresh()
end

MsgTipFrameDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return MsgTipFrameDialog

