-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/activetimedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ActiveTimeDialog = class("ActiveTimeDialog", Dialog)
ActiveTimeDialog.AssetBundleName = "ui/layouts.battle"
ActiveTimeDialog.AssetName = "ATB"
ActiveTimeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActiveTimeDialog
  ((ActiveTimeDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._cells = {}
  self._tweenTasks = {}
  self._deleteTweenTasks = {}
  self._activeOrientation = 0
  self._activeId = 0
  self._time = 200
  self._totalTime = 200
  self._activeTime = 100
  self._activeTotalTime = 100
  self._deleteId = 1
  self._deletes = {}
end

ActiveTimeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._bg = self:GetChild("BackGround")
  self._left1 = self:GetChild("BackGround/left1")
  self._left2 = self:GetChild("BackGround/left2")
  self._left5 = self:GetChild("BackGround/left5")
  self._right1 = self:GetChild("BackGround/right1")
  self._right2 = self:GetChild("BackGround/right2")
  self._right5 = self:GetChild("BackGround/right5")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBattleEnd, Common.n_BattleEnd, nil)
end

ActiveTimeDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  self._tweenTasks = {}
  for k,dialog in pairs(self._cells) do
    dialog:Destroy()
  end
  self._cells = {}
  self._deleteTweenTasks = {}
  for k,dialog in pairs(self._deletes) do
    dialog:Destroy()
  end
  self._deletes = {}
  self:UpdateDeleteBattlers(10000000)
end

ActiveTimeDialog.OnUpdate = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:UpdateActiveBattler(((CS.UnityEngine).Time).deltaTime * 1000)
  self:UpdateDeleteBattlers(((CS.UnityEngine).Time).deltaTime * 1000)
end

ActiveTimeDialog.OnBattleEnd = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("battle.activetimedialog")
end

ActiveTimeDialog.Show = function(self, show)
  -- function num : 0_5
  if show then
    (self:GetRootWindow()):PlayAnimation("ATBShow")
  else
    ;
    (self:GetRootWindow()):PlayAnimation("ATBHide")
  end
end

ActiveTimeDialog.UpdateDeleteBattlers = function(self, deltaTime)
  -- function num : 0_6 , upvalues : _ENV
  if #self._deleteTweenTasks > 0 then
    local deletes = {}
    for i,task in ipairs(self._deleteTweenTasks) do
      if task:update(deltaTime) then
        ((self._deletes)[(task.subject).id]):Destroy()
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self._deletes)[(task.subject).id] = nil
        deletes[#deletes + 1] = i
      else
        ;
        (((self._deletes)[(task.subject).id]):GetRootWindow()):SetLocalScale((task.subject).scale, (task.subject).scale, 1)
      end
    end
    for i = #deletes, 1, -1 do
      (table.remove)(self._deleteTweenTasks, deletes[i])
    end
  end
end

ActiveTimeDialog.UpdateActiveBattler = function(self, deltaTime)
  -- function num : 0_7
  if self._activeTime == self._activeTotalTime then
    return 
  end
  self._activeTime = self._activeTime + deltaTime
  if self._activeTotalTime <= self._activeTime then
    self._activeTime = self._activeTotalTime
  end
  local scale = self._activeTime / self._activeTotalTime
  local cell = (self._cells)[self._activeOrientation * self._activeId]
  if self._activeOrientation < 0 then
    local leftPos1AnchorX, leftPos1OffsetX, leftPos1AnchorY, leftPos1OffsetY = (self._left1):GetPosition()
    local leftPos2AnchorX, leftPos2OffsetX, leftPos2AnchorY, leftPos2OffsetY = (self._left2):GetPosition()
    ;
    (cell:GetRootWindow()):SetPosition(leftPos2AnchorX + (leftPos1AnchorX - leftPos2AnchorX) * scale, leftPos2OffsetX + (leftPos1OffsetX - leftPos2OffsetX) * scale, leftPos2AnchorY + (leftPos1AnchorY - leftPos2AnchorY) * scale, leftPos2OffsetY + (leftPos1OffsetY - leftPos2OffsetY) * scale)
    ;
    (cell:GetRootWindow()):SetLocalScale(1 + 0.5 * scale, 1 + 0.5 * scale, 1)
  else
    do
      local rightPos1AnchorX, rightPos1OffsetX, rightPos1AnchorY, rightPos1OffsetY = (self._right1):GetPosition()
      local rightPos2AnchorX, rightPos2OffsetX, rightPos2AnchorY, rightPos2OffsetY = (self._right2):GetPosition()
      ;
      (cell:GetRootWindow()):SetPosition(rightPos2AnchorX + (rightPos1AnchorX - rightPos2AnchorX) * scale, rightPos2OffsetX + (rightPos1OffsetX - rightPos2OffsetX) * scale, rightPos2AnchorY + (rightPos1AnchorY - rightPos2AnchorY) * scale, rightPos2OffsetY + (rightPos1OffsetY - rightPos2OffsetY) * scale)
      ;
      (cell:GetRootWindow()):SetLocalScale(1 + 0.5 * scale, 1 + 0.5 * scale, 1)
    end
  end
end

ActiveTimeDialog.Remove = function(self, orientation, id)
  -- function num : 0_8 , upvalues : _ENV
  local cell = (self._cells)[orientation * id]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  if cell then
    (self._cells)[orientation * id] = nil
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._deletes)[self._deleteId] = cell
    local start = {id = self._deleteId, scale = 1}
    local target = {id = self._deleteId, scale = 0}
    self._deleteId = self._deleteId + 1
    ;
    (table.insert)(self._deleteTweenTasks, (Tween.new)(300, start, target, "linear"))
  end
end

ActiveTimeDialog.SetBattler = function(self, info)
  -- function num : 0_9 , upvalues : _ENV
  local leftPos2AnchorX, leftPos2OffsetX, leftPos2AnchorY, leftPos2OffsetY = (self._left2):GetPosition()
  local leftPos5AnchorX, leftPos5OffsetX, leftPos5AnchorY, leftPos5OffsetY = (self._left5):GetPosition()
  local rightPos2AnchorX, rightPos2OffsetX, rightPos2AnchorY, rightPos2OffsetY = (self._right2):GetPosition()
  local rightPos5AnchorX, rightPos5OffsetX, rightPos5AnchorY, rightPos5OffsetY = (self._right5):GetPosition()
  local newCells = {}
  for k,v in pairs(info) do
    if v.active then
      if self._activeOrientation ~= v.orientation or self._activeId ~= v.battlerId then
        self._activeOrientation = v.orientation
        if not (self._cells)[v.orientation * v.battlerId] then
          if v.orientation < 0 then
            newCells[v.orientation * v.battlerId] = (DialogManager.CreateDialog)("battle.leftcell", (self._bg):GetUIObject())
          else
            newCells[v.orientation * v.battlerId] = (DialogManager.CreateDialog)("battle.rightcell", (self._bg):GetUIObject())
          end
        else
          newCells[v.orientation * v.battlerId] = (self._cells)[v.orientation * v.battlerId]
        end
        if v.orientation < 0 then
          ((newCells[v.orientation * v.battlerId]):GetRootWindow()):SetPosition(leftPos2AnchorX, leftPos2OffsetX, leftPos2AnchorY + (leftPos5AnchorY - leftPos2AnchorY) * v.progress, leftPos2OffsetY + (leftPos5OffsetY - leftPos2OffsetY) * v.progress)
          ;
          ((newCells[v.orientation * v.battlerId]):GetRootWindow()):SetLocalScale(1, 1, 1)
        else
          ;
          ((newCells[v.orientation * v.battlerId]):GetRootWindow()):SetPosition(rightPos2AnchorX, rightPos2OffsetX, rightPos2AnchorY + (rightPos5AnchorY - rightPos2AnchorY) * v.progress, rightPos2OffsetY + (rightPos5OffsetY - rightPos2OffsetY) * v.progress)
          ;
          ((newCells[v.orientation * v.battlerId]):GetRootWindow()):SetLocalScale(1, 1, 1)
        end
        self._activeTime = 0
      else
        newCells[v.orientation * v.battlerId] = (self._cells)[v.orientation * v.battlerId]
      end
    else
      if not (self._cells)[v.orientation * v.battlerId] then
        if v.orientation < 0 then
          newCells[v.orientation * v.battlerId] = (DialogManager.CreateDialog)("battle.leftcell", (self._bg):GetUIObject())
        else
          newCells[v.orientation * v.battlerId] = (DialogManager.CreateDialog)("battle.rightcell", (self._bg):GetUIObject())
        end
      else
        newCells[v.orientation * v.battlerId] = (self._cells)[v.orientation * v.battlerId]
      end
      if v.orientation < 0 then
        ((newCells[v.orientation * v.battlerId]):GetRootWindow()):SetPosition(leftPos2AnchorX, leftPos2OffsetX, leftPos2AnchorY + (leftPos5AnchorY - leftPos2AnchorY) * v.progress, leftPos2OffsetY + (leftPos5OffsetY - leftPos2OffsetY) * v.progress)
        ;
        ((newCells[v.orientation * v.battlerId]):GetRootWindow()):SetLocalScale(1, 1, 1)
      else
        ;
        ((newCells[v.orientation * v.battlerId]):GetRootWindow()):SetPosition(rightPos2AnchorX, rightPos2OffsetX, rightPos2AnchorY + (rightPos5AnchorY - rightPos2AnchorY) * v.progress, rightPos2OffsetY + (rightPos5OffsetY - rightPos2OffsetY) * v.progress)
        ;
        ((newCells[v.orientation * v.battlerId]):GetRootWindow()):SetLocalScale(1, 1, 1)
      end
    end
  end
  local deletes = {}
  for k,v in pairs(self._cells) do
    if not newCells[k] then
      (table.insert)(deletes, k)
    end
  end
  for i,v in ipairs(deletes) do
    local cell = (self._cells)[v]
    -- DECOMPILER ERROR at PC278: Confused about usage of register: R26 in 'UnsetPending'

    ;
    (self._cells)[v] = nil
    -- DECOMPILER ERROR at PC283: Confused about usage of register: R26 in 'UnsetPending'

    if cell then
      (self._deletes)[self._deleteId] = cell
      local start = {id = self._deleteId, scale = 1}
      local target = {id = self._deleteId, scale = 0}
      self._deleteId = self._deleteId + 1
      ;
      (table.insert)(self._deleteTweenTasks, (Tween.new)(300, start, target, "linear"))
    end
  end
  self._cells = newCells
end

ActiveTimeDialog.Update = function(self, deltaTime)
  -- function num : 0_10 , upvalues : _ENV
  if self._time == self._totalTime then
    return deltaTime
  end
  local retValue = 0
  self._time = self._time + deltaTime
  if self._totalTime <= self._time then
    retValue = self._time - self._totalTime
    if retValue < 0 then
      retValue = 0
    end
    self._time = self._totalTime
  end
  for k,task in pairs(self._tweenTasks) do
    task:set(self._time)
    local subject = task.subject
    local key = subject.orientation * subject.id
    if subject.alpha == 0 then
      ((self._cells)[key]):Destroy()
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (self._cells)[key] = nil
    else
      ;
      (((self._cells)[key]):GetRootWindow()):SetPosition(subject.anchorX, subject.offsetX, subject.anchorY, subject.offsetY)
    end
  end
  if self._time == self._totalTime then
    self._tweenTasks = {}
    self._activeTime = 0
  end
  return retValue
end

return ActiveTimeDialog

