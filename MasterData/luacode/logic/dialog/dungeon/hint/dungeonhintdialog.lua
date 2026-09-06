local DungeonHintDialog = class("DungeonHintDialog", Dialog)
DungeonHintDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonHintDialog.AssetName = "DungeonCharTalk"
local cinteractivetipconfig = BeanManager.GetTableByName("sceneinteractive.cinteractivetipconfig")
local csceneinteractivechatlist = BeanManager.GetTableByName("dialog.csceneinteractivechatlist")
local cscenerolechatlist = BeanManager.GetTableByName("dialog.cscenerolechatlist")
local bm_allroles = NekoData.BehaviorManager.BM_AllRoles
local bm_team = NekoData.BehaviorManager.BM_Team
local Role = require("logic.manager.experimental.types.role")

function DungeonHintDialog:Ctor(...)
  DungeonHintDialog.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
end

function DungeonHintDialog:OnCreate()
  self._frame = self:GetChild("CharTalkArea")
  self:GetRootWindow():Subscribe_UpdateEvent(self.OnUpdate, self)
  local _, y = self._frame:GetRectSize()
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

function DungeonHintDialog:OnDestroy()
  for _, t in pairs({
    self._recycled,
    self._cells
  }) do
    for _, v in pairs(t) do
      v.cell:Destroy()
    end
  end
  if self._timer then
    GameTimer.RemoveTask(self._timer)
  end
end

function DungeonHintDialog:SetPriority(priority)
  self._priority = priority or 0
end

function DungeonHintDialog:GetPriority()
  return self._priority
end

function DungeonHintDialog:PlayFixedChat(groupid)
  self:Clear()
  local records = {}
  for _, i in pairs(cscenerolechatlist:GetAllIds()) do
    local record = cscenerolechatlist:GetRecorder(i)
    if record.Dialogid == groupid then
      records[#records + 1] = record
    end
  end
  table.sort(records, function(lhs, rhs)
    return lhs.id < rhs.id
  end)
  local roles = {}
  for i, record in ipairs(records) do
    if record.isRandom == 0 then
      self._roles[i] = Role.Create(record.Roleid)
    elseif record.isRandom == 1 then
      local roleid = roles[record.Roleid]
      roleid = roleid or self:PickRandomRoleID()
      self._roles[i] = bm_allroles:GetRole(roleid)
      roles[record.Roleid] = roleid
    end
    self._textids[i] = record.Textid
    self._timeouts[i] = record.SkipTime
  end
  self:Refresh()
end

function DungeonHintDialog:PickRandomRoleID()
  local keys = NekoData.BehaviorManager.BM_Team:GetCurrentRoleKeys()
  local id
  local list = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  if #list == 1 then
    return 3
  end
  local valid_keys = {}
  for _, v in pairs(keys) do
    if v ~= 0 and v ~= 1 then
      valid_keys[#valid_keys + 1] = v
    end
  end
  if #valid_keys < 2 then
    id = list[math.random(#list)]:GetId()
  else
    id = valid_keys[math.random(#valid_keys)]
  end
  return id
end

function DungeonHintDialog:PlayRandomChat(typeid)
  self:Clear()
  local id = self:PickRandomRoleID()
  self._roles = {
    bm_allroles:GetRole(id)
  }
  self._textids = {}
  for _, role in ipairs(self._roles) do
    for _, i in pairs(cinteractivetipconfig:GetAllIds()) do
      local record = cinteractivetipconfig:GetRecorder(i)
      if record.Roleid == role:GetId() then
        local candidates = string.split(record.Dialogid, ",")
        for _, c in pairs(candidates) do
          local chat_record = csceneinteractivechatlist:GetRecorder(tonumber(c))
          if chat_record.ChatType == typeid then
            self._textids[#self._textids + 1] = chat_record.Textid
            self._timeouts[#self._timeouts + 1] = chat_record.SkipTime
            break
          end
        end
        break
      end
    end
  end
  self:Refresh()
end

function DungeonHintDialog:Clear()
  self._seq = {}
  self._currentIndex = 0
  self._tween = nil
  if self._timer then
    GameTimer.RemoveTask(self._timer)
  end
  self._timer = nil
  for _, v in pairs(self._cells) do
    v.cell:Destroy()
  end
  self._cells = {}
  for _, v in pairs(self._recycled) do
    v.cell:Destroy()
  end
  self._recycled = {}
end

function DungeonHintDialog:Refresh()
  self._currentIndex = self._currentIndex + 1
  if self._currentIndex > #self._roles then
    DialogManager.DestroySingletonDialog("dungeon.hint.dungeonhintdialog")
    return
  end
  local side = self:CheckSide(self._currentIndex)
  local cell = self:GetCell(side)
  local count = #self._cells
  if count == 0 then
    table.insert(self._seq, {
      type = "appear",
      index = 1,
      typeid = side,
      cell = cell
    })
  elseif count == 1 then
    table.insert(self._seq, {
      type = "appear",
      index = 2,
      typeid = side,
      cell = cell
    })
  elseif count == 2 then
    table.insert(self._seq, {type = "disappear", index = 1})
    table.insert(self._seq, {
      type = "tween",
      from = 0,
      to = self._downY
    })
    table.insert(self._seq, {
      type = "appear",
      index = 2,
      typeid = side,
      cell = cell
    })
  end
  self:NextStep()
end

function DungeonHintDialog:CheckSide(index)
  if index == 1 then
    return 1
  end
  if self._roles[index]:GetId() == self._roles[index - 1]:GetId() then
    return self:CheckSide(index - 1)
  else
    return -1 * self:CheckSide(index - 1)
  end
end

function DungeonHintDialog:CellToDisappear()
  table.remove(self._seq, 1)
  self:NextStep()
end

function DungeonHintDialog:OnCellDisappear(cell)
  if self._currentIndex == #self._roles and #self._seq == 0 then
    DialogManager.DestroySingletonDialog("dungeon.hint.dungeonhintdialog")
  else
    table.remove(self._seq, 1)
    self:RecycleCell(1)
    self:NextStep()
  end
end

function DungeonHintDialog:OnCellAppear(textid)
  table.remove(self._seq, 1)
  self:NextStep()
end

function DungeonHintDialog:OnUpdate(deltaTime, unscaledDeltaTime)
  if self._tween then
    local finished = self._tween:update(deltaTime)
    self._cells[1].cell:GetRootWindow():SetYPosition(0, self._tween.subject.ypos)
    if finished then
      table.remove(self._seq, 1)
      self._tween = nil
      self:NextStep()
    end
  end
end

function DungeonHintDialog:NextStep()
  local step = self._seq[1]
  if not step then
    self._timer = GameTimer.AddTask(self._timeouts[self._currentIndex], 0, self.Refresh, self)
    return
  end
  if step.type == "appear" then
    self._cells[step.index] = {
      typeid = step.typeid,
      cell = step.cell
    }
    step.cell:GetRootWindow():SetYPosition(0, (2 - step.index) * self._downY)
    step.cell:SetData(self, self._roles[self._currentIndex], self._textids[self._currentIndex], self._timeouts[self._currentIndex])
    step.cell:Appear()
  elseif step.type == "disappear" then
    self._cells[step.index].cell:Disappear()
  elseif step.type == "tween" then
    self._tween = Tween.new(0.5, {
      ypos = step.from
    }, {
      ypos = step.to
    }, "linear")
  end
end

function DungeonHintDialog:GetCell(typeid)
  for i, v in pairs(self._recycled) do
    if v.typeid == typeid then
      local cell = v.cell
      self._recycled[i] = nil
      return cell
    end
  end
  local cell
  if typeid == 1 then
    cell = DialogManager.CreateDialog("dungeon.hint.dungeonhintleftcell", self._frame:GetUIObject())
  else
    cell = DialogManager.CreateDialog("dungeon.hint.dungeonhintrightcell", self._frame:GetUIObject())
  end
  cell:GetRootWindow():SetYPosition(0, -1000)
  return cell
end

function DungeonHintDialog:RecycleCell(index)
  local typeid = self._cells[index].typeid
  local cell = self._cells[index].cell
  cell:Reset()
  self._recycled[#self._recycled + 1] = {typeid = typeid, cell = cell}
  table.remove(self._cells, index)
end

function DungeonHintDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return DungeonHintDialog
