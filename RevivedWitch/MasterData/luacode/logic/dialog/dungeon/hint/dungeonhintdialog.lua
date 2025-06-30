-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/hint/dungeonhintdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonHintDialog = class("DungeonHintDialog", Dialog)
DungeonHintDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonHintDialog.AssetName = "DungeonCharTalk"
local cinteractivetipconfig = (BeanManager.GetTableByName)("sceneinteractive.cinteractivetipconfig")
local csceneinteractivechatlist = (BeanManager.GetTableByName)("dialog.csceneinteractivechatlist")
local cscenerolechatlist = (BeanManager.GetTableByName)("dialog.cscenerolechatlist")
local bm_allroles = (NekoData.BehaviorManager).BM_AllRoles
local bm_team = (NekoData.BehaviorManager).BM_Team
local Role = require("logic.manager.experimental.types.role")
DungeonHintDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonHintDialog
  ((DungeonHintDialog.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
end

DungeonHintDialog.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("CharTalkArea")
  ;
  (self:GetRootWindow()):Subscribe_UpdateEvent(self.OnUpdate, self)
  local _, y = (self._frame):GetRectSize()
  self._downY = y / 2
  self._roles = {}
  self._textids = {}
  self._timeouts = {}
  self._recycled = {}
  self._cells = {}
  self._tweens = {}
  self._seq = {}
  self._currentIndex = 0
end

DungeonHintDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for _,t in pairs({self._recycled, self._cells}) do
    for _,v in pairs(t) do
      (v.cell):Destroy()
    end
  end
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
  end
end

DungeonHintDialog.SetPriority = function(self, priority)
  -- function num : 0_3
  self._priority = priority or 0
end

DungeonHintDialog.GetPriority = function(self)
  -- function num : 0_4
  return self._priority
end

DungeonHintDialog.PlayFixedChat = function(self, groupid)
  -- function num : 0_5 , upvalues : _ENV, cscenerolechatlist, Role, bm_allroles
  self:Clear()
  local records = {}
  for _,i in pairs(cscenerolechatlist:GetAllIds()) do
    local record = cscenerolechatlist:GetRecorder(i)
    if record.Dialogid == groupid then
      records[#records + 1] = record
    end
  end
  ;
  (table.sort)(records, function(lhs, rhs)
    -- function num : 0_5_0
    do return lhs.id < rhs.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local roles = {}
  for i,record in ipairs(records) do
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R9 in 'UnsetPending'

    if record.isRandom == 0 then
      (self._roles)[i] = (Role.Create)(record.Roleid)
    else
      if record.isRandom == 1 then
        local roleid = roles[record.Roleid]
        if not roleid then
          roleid = self:PickRandomRoleID()
        end
        -- DECOMPILER ERROR at PC55: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self._roles)[i] = bm_allroles:GetRole(roleid)
        roles[record.Roleid] = roleid
      end
    end
    do
      do
        -- DECOMPILER ERROR at PC60: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self._textids)[i] = record.Textid
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self._timeouts)[i] = record.SkipTime
        -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self:Refresh()
end

DungeonHintDialog.PickRandomRoleID = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (((NekoData.BehaviorManager).BM_Team):GetCurrentRoleKeys())
  local keys = nil
  local id = nil
  local list = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  if #list == 1 then
    return 3
  end
  local valid_keys = {}
  for _,v in pairs(keys) do
    if v ~= 0 and v ~= 1 then
      valid_keys[#valid_keys + 1] = v
    end
  end
  if #valid_keys < 2 then
    id = (list[(math.random)(#list)]):GetId()
  else
    id = valid_keys[(math.random)(#valid_keys)]
  end
  return id
end

DungeonHintDialog.PlayRandomChat = function(self, typeid)
  -- function num : 0_7 , upvalues : bm_allroles, _ENV, cinteractivetipconfig, csceneinteractivechatlist
  self:Clear()
  local id = self:PickRandomRoleID()
  self._roles = {bm_allroles:GetRole(id)}
  self._textids = {}
  for _,role in ipairs(self._roles) do
    for _,i in pairs(cinteractivetipconfig:GetAllIds()) do
      local record = cinteractivetipconfig:GetRecorder(i)
      if record.Roleid == role:GetId() then
        local candidates = (string.split)(record.Dialogid, ",")
        for _,c in pairs(candidates) do
          local chat_record = csceneinteractivechatlist:GetRecorder(tonumber(c))
          -- DECOMPILER ERROR at PC55: Confused about usage of register: R21 in 'UnsetPending'

          if chat_record.ChatType == typeid then
            (self._textids)[#self._textids + 1] = chat_record.Textid
            -- DECOMPILER ERROR at PC61: Confused about usage of register: R21 in 'UnsetPending'

            ;
            (self._timeouts)[#self._timeouts + 1] = chat_record.SkipTime
            break
          end
        end
        break
      end
    end
  end
  self:Refresh()
end

DungeonHintDialog.Clear = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self._seq = {}
  self._currentIndex = 0
  self._tween = nil
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
  end
  self._timer = nil
  for _,v in pairs(self._cells) do
    (v.cell):Destroy()
  end
  self._cells = {}
  for _,v in pairs(self._recycled) do
    (v.cell):Destroy()
  end
  self._recycled = {}
end

DungeonHintDialog.Refresh = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self._currentIndex = self._currentIndex + 1
  if #self._roles < self._currentIndex then
    (DialogManager.DestroySingletonDialog)("dungeon.hint.dungeonhintdialog")
    return 
  end
  local side = self:CheckSide(self._currentIndex)
  local cell = self:GetCell(side)
  local count = #self._cells
  if count == 0 then
    (table.insert)(self._seq, {type = "appear", index = 1, typeid = side, cell = cell})
  else
    if count == 1 then
      (table.insert)(self._seq, {type = "appear", index = 2, typeid = side, cell = cell})
    else
      if count == 2 then
        (table.insert)(self._seq, {type = "disappear", index = 1})
        ;
        (table.insert)(self._seq, {type = "tween", from = 0, to = self._downY})
        ;
        (table.insert)(self._seq, {type = "appear", index = 2, typeid = side, cell = cell})
      end
    end
  end
  self:NextStep()
end

DungeonHintDialog.CheckSide = function(self, index)
  -- function num : 0_10
  if index == 1 then
    return 1
  end
  if ((self._roles)[index]):GetId() == ((self._roles)[index - 1]):GetId() then
    return self:CheckSide(index - 1)
  else
    return -1 * self:CheckSide(index - 1)
  end
end

DungeonHintDialog.CellToDisappear = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (table.remove)(self._seq, 1)
  self:NextStep()
end

DungeonHintDialog.OnCellDisappear = function(self, cell)
  -- function num : 0_12 , upvalues : _ENV
  if self._currentIndex == #self._roles and #self._seq == 0 then
    (DialogManager.DestroySingletonDialog)("dungeon.hint.dungeonhintdialog")
  else
    ;
    (table.remove)(self._seq, 1)
    self:RecycleCell(1)
    self:NextStep()
  end
end

DungeonHintDialog.OnCellAppear = function(self, textid)
  -- function num : 0_13 , upvalues : _ENV
  (table.remove)(self._seq, 1)
  self:NextStep()
end

DungeonHintDialog.OnUpdate = function(self, deltaTime, unscaledDeltaTime)
  -- function num : 0_14 , upvalues : _ENV
  if self._tween then
    local finished = (self._tween):update(deltaTime)
    ;
    ((((self._cells)[1]).cell):GetRootWindow()):SetYPosition(0, ((self._tween).subject).ypos)
    if finished then
      (table.remove)(self._seq, 1)
      self._tween = nil
      self:NextStep()
    end
  end
end

DungeonHintDialog.NextStep = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local step = (self._seq)[1]
  if not step then
    self._timer = (GameTimer.AddTask)((self._timeouts)[self._currentIndex], 0, self.Refresh, self)
    return 
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  if step.type == "appear" then
    (self._cells)[step.index] = {typeid = step.typeid, cell = step.cell}
    ;
    ((step.cell):GetRootWindow()):SetYPosition(0, (2 - step.index) * self._downY)
    ;
    (step.cell):SetData(self, (self._roles)[self._currentIndex], (self._textids)[self._currentIndex], (self._timeouts)[self._currentIndex])
    ;
    (step.cell):Appear()
  else
    if step.type == "disappear" then
      (((self._cells)[step.index]).cell):Disappear()
    else
      if step.type == "tween" then
        self._tween = (Tween.new)(0.5, {ypos = step.from}, {ypos = step.to}, "linear")
      end
    end
  end
end

DungeonHintDialog.GetCell = function(self, typeid)
  -- function num : 0_16 , upvalues : _ENV
  for i,v in pairs(self._recycled) do
    if v.typeid == typeid then
      local cell = v.cell
      -- DECOMPILER ERROR at PC9: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self._recycled)[i] = nil
      return cell
    end
  end
  local cell = nil
  if typeid == 1 then
    cell = (DialogManager.CreateDialog)("dungeon.hint.dungeonhintleftcell", (self._frame):GetUIObject())
  else
    cell = (DialogManager.CreateDialog)("dungeon.hint.dungeonhintrightcell", (self._frame):GetUIObject())
  end
  ;
  (cell:GetRootWindow()):SetYPosition(0, -1000)
  return cell
end

DungeonHintDialog.RecycleCell = function(self, index)
  -- function num : 0_17 , upvalues : _ENV
  local typeid = ((self._cells)[index]).typeid
  local cell = ((self._cells)[index]).cell
  cell:Reset()
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._recycled)[#self._recycled + 1] = {typeid = typeid, cell = cell}
  ;
  (table.remove)(self._cells, index)
end

DungeonHintDialog.OnBackBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return DungeonHintDialog

