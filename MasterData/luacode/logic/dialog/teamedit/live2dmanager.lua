-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/live2dmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Live2DManager = class("Live2DManager")
local Time = 0.5
Live2DManager.Ctor = function(self, window, delegate)
  -- function num : 0_0
  self._time = 0
  self._fardelta = 50
  self._neardelta = 30
  self._characterList = {}
  self._live2DBehaviourList = {}
  self._characterPositionXList = {}
  self._window = window
  self._delegate = delegate
  ;
  (self._window):Subscribe_UpdateEvent(self.OnUpdate, self)
  self._tag = ""
  self._taskList = {}
end

Live2DManager.CharacterListDisappear = function(self, CharacterList, time)
  -- function num : 0_1 , upvalues : Time, _ENV
  if time then
    self._time = time
  else
    self._time = Time
  end
  self._tag = "Disappear"
  ;
  (self._delegate):AnimationPlayCompleted(true)
  self._characterList = CharacterList
  self._leftMoveTask1 = (Tween.new)(self._time, {alpha = 1}, {alpha = 0}, "linear")
  self._leftMoveTask2 = (Tween.new)(self._time, {alpha = 1}, {alpha = 0}, "linear")
  self._rightMoveTask3 = (Tween.new)(self._time, {alpha = 1}, {alpha = 0}, "linear")
  self._rightMoveTask4 = (Tween.new)(self._time, {alpha = 1}, {alpha = 0}, "linear")
end

Live2DManager.CharacterListAppear = function(self, CharacterList, time)
  -- function num : 0_2 , upvalues : Time, _ENV
  if time then
    self._time = time
  else
    self._time = Time
  end
  self._tag = "Appear"
  ;
  (self._delegate):AnimationPlayCompleted(true)
  self._characterList = CharacterList
  self._leftMoveTask1 = (Tween.new)(self._time, {alpha = 0}, {alpha = 1}, "linear")
  self._leftMoveTask2 = (Tween.new)(self._time, {alpha = 0}, {alpha = 1}, "linear")
  self._rightMoveTask3 = (Tween.new)(self._time, {alpha = 0}, {alpha = 1}, "linear")
  self._rightMoveTask4 = (Tween.new)(self._time, {alpha = 0}, {alpha = 1}, "linear")
end

Live2DManager.CharacterListFirstMove = function(self, CharacterList, time)
  -- function num : 0_3 , upvalues : Time, _ENV
  if time then
    self._time = time
  else
    self._time = Time
  end
  self._tag = "FirstMove"
  while (self._characterPositionXList)[#self._characterPositionXList] do
    (table.remove)(self._characterPositionXList, #self._characterPositionXList)
  end
  self._characterList = CharacterList
  for i,v in ipairs(CharacterList) do
    local position = {}
    position.pos_x = v:GetXPosition()
    ;
    (table.insert)(self._characterPositionXList, position)
  end
  local initPosition = ((self._characterPositionXList)[1]).pos_offset_x - self._fardelta
  local stopPosition = ((self._characterPositionXList)[1]).pos_offset_x
  self._leftMoveTask1 = (Tween.new)(self._time, {alpha = 0, position = initPosition}, {alpha = 1, position = stopPosition}, "linear")
  initPosition = ((self._characterPositionXList)[2]).pos_offset_x - self._neardelta
  stopPosition = ((self._characterPositionXList)[2]).pos_offset_x
  self._leftMoveTask2 = (Tween.new)(self._time, {alpha = 0, position = initPosition}, {alpha = 1, position = stopPosition}, "linear")
  initPosition = ((self._characterPositionXList)[3]).pos_offset_x + self._neardelta
  stopPosition = ((self._characterPositionXList)[3]).pos_offset_x
  self._rightMoveTask3 = (Tween.new)(self._time, {alpha = 0, position = initPosition}, {alpha = 1, position = stopPosition}, "linear")
  initPosition = ((self._characterPositionXList)[4]).pos_offset_x + self._fardelta
  stopPosition = ((self._characterPositionXList)[4]).pos_offset_x
  self._rightMoveTask4 = (Tween.new)(self._time, {alpha = 0, position = initPosition}, {alpha = 1, position = stopPosition}, "linear")
end

Live2DManager.CharacterMove = function(self, Character, start, stop)
  -- function num : 0_4 , upvalues : _ENV
  self._tag = "Move"
  self._character = Character
  self._stop = stop
  self._moveTask = (Tween.new)(self._time, {positionX = start.x, positionY = start.y}, {positionX = stop.x, positionY = stop.y}, "linear")
  ;
  (self._delegate):AnimationPlayCompleted(true)
end

Live2DManager.OnUpdate = function(self, deltaTime)
  -- function num : 0_5
  if self._tag == "Move" and self._moveTask then
    if (self._moveTask):update(deltaTime) then
      (self._character):SetAnchoredPosition((self._stop).x, (self._stop).y)
      self._moveTask = nil
    else
      ;
      (self._character):SetAnchoredPosition(((self._moveTask).subject).positionX, ((self._moveTask).subject).positionY)
    end
    if not self._moveTask then
      self._tag = ""
      ;
      (self._delegate):AnimationPlayCompleted(false)
    else
      ;
      (self._delegate):AnimationPlayCompleted(true)
    end
  end
  if self._tag == "FirstMove" then
    do
      if self._leftMoveTask1 then
        local position = (self._characterPositionXList)[1]
        if (self._leftMoveTask1):update(deltaTime) then
          ((self._characterList)[1]):SetXPosition(position.pos_x, position.pos_offset_x)
          ;
          ((self._characterList)[1]):SetAlpha(1)
          self._leftMoveTask1 = nil
        else
          ;
          ((self._characterList)[1]):SetXPosition(position.pos_x, ((self._leftMoveTask1).subject).position)
          ;
          ((self._characterList)[1]):SetAlpha(((self._leftMoveTask1).subject).alpha)
        end
      end
      do
        if self._leftMoveTask2 then
          local position = (self._characterPositionXList)[2]
          if (self._leftMoveTask2):update(deltaTime) then
            ((self._characterList)[2]):SetXPosition(position.pos_x, position.pos_offset_x)
            ;
            ((self._characterList)[2]):SetAlpha(1)
            self._leftMoveTask2 = nil
          else
            ;
            ((self._characterList)[2]):SetXPosition(position.pos_x, ((self._leftMoveTask2).subject).position)
            ;
            ((self._characterList)[2]):SetAlpha(((self._leftMoveTask2).subject).alpha)
          end
        end
        do
          if self._rightMoveTask3 then
            local position = (self._characterPositionXList)[3]
            if (self._rightMoveTask3):update(deltaTime) then
              ((self._characterList)[3]):SetXPosition(position.pos_x, position.pos_offset_x)
              ;
              ((self._characterList)[3]):SetAlpha(1)
              self._rightMoveTask3 = nil
            else
              ;
              ((self._characterList)[3]):SetXPosition(position.pos_x, ((self._rightMoveTask3).subject).position)
              ;
              ((self._characterList)[3]):SetAlpha(((self._rightMoveTask3).subject).alpha)
            end
          end
          do
            if self._rightMoveTask4 then
              local position = (self._characterPositionXList)[4]
              if (self._rightMoveTask4):update(deltaTime) then
                ((self._characterList)[4]):SetXPosition(position.pos_x, position.pos_offset_x)
                ;
                ((self._characterList)[4]):SetAlpha(1)
                self._rightMoveTask4 = nil
              else
                ;
                ((self._characterList)[4]):SetXPosition(position.pos_x, ((self._rightMoveTask4).subject).position)
                ;
                ((self._characterList)[4]):SetAlpha(((self._rightMoveTask4).subject).alpha)
              end
            end
            if not self._leftMoveTask1 and not self._leftMoveTask2 and not self._rightMoveTask3 and not self._rightMoveTask4 then
              (self._delegate):AnimationPlayCompleted(false)
              self._tag = ""
            else
              ;
              (self._delegate):AnimationPlayCompleted(true)
            end
            if self._tag == "Disappear" then
              if self._leftMoveTask1 then
                if (self._leftMoveTask1):update(deltaTime) then
                  ((self._characterList)[1]):SetAlpha(0)
                  self._leftMoveTask1 = nil
                else
                  ;
                  ((self._characterList)[1]):SetAlpha(((self._leftMoveTask1).subject).alpha)
                end
              end
              if self._leftMoveTask2 then
                if (self._leftMoveTask2):update(deltaTime) then
                  ((self._characterList)[2]):SetAlpha(0)
                  self._leftMoveTask2 = nil
                else
                  ;
                  ((self._characterList)[2]):SetAlpha(((self._leftMoveTask2).subject).alpha)
                end
              end
              if self._rightMoveTask3 then
                if (self._rightMoveTask3):update(deltaTime) then
                  ((self._characterList)[3]):SetAlpha(0)
                  self._rightMoveTask3 = nil
                else
                  ;
                  ((self._characterList)[3]):SetAlpha(((self._rightMoveTask3).subject).alpha)
                end
              end
              if self._rightMoveTask4 then
                if (self._rightMoveTask4):update(deltaTime) then
                  ((self._characterList)[4]):SetAlpha(0)
                  self._rightMoveTask4 = nil
                else
                  ;
                  ((self._characterList)[4]):SetAlpha(((self._rightMoveTask4).subject).alpha)
                end
              end
              if not self._leftMoveTask1 and not self._leftMoveTask2 and not self._rightMoveTask3 and not self._rightMoveTask4 then
                self._tag = ""
                ;
                (self._delegate):AnimationPlayCompleted(false)
              else
                ;
                (self._delegate):AnimationPlayCompleted(true)
              end
            end
            if self._tag == "Appear" then
              if self._leftMoveTask1 then
                if (self._leftMoveTask1):update(deltaTime) then
                  ((self._characterList)[1]):SetAlpha(1)
                  self._leftMoveTask1 = nil
                else
                  ;
                  ((self._characterList)[1]):SetAlpha(((self._leftMoveTask1).subject).alpha)
                end
              end
              if self._leftMoveTask2 then
                if (self._leftMoveTask2):update(deltaTime) then
                  ((self._characterList)[2]):SetAlpha(1)
                  self._leftMoveTask2 = nil
                else
                  ;
                  ((self._characterList)[2]):SetAlpha(((self._leftMoveTask2).subject).alpha)
                end
              end
              if self._rightMoveTask3 then
                if (self._rightMoveTask3):update(deltaTime) then
                  ((self._characterList)[3]):SetAlpha(1)
                  self._rightMoveTask3 = nil
                else
                  ;
                  ((self._characterList)[3]):SetAlpha(((self._rightMoveTask3).subject).alpha)
                end
              end
              if self._rightMoveTask4 then
                if (self._rightMoveTask4):update(deltaTime) then
                  ((self._characterList)[4]):SetAlpha(1)
                  self._rightMoveTask4 = nil
                else
                  ;
                  ((self._characterList)[4]):SetAlpha(((self._rightMoveTask4).subject).alpha)
                end
              end
              if not self._leftMoveTask1 and not self._leftMoveTask2 and not self._rightMoveTask3 and not self._rightMoveTask4 then
                (self._delegate):AnimationPlayCompleted(false)
                self._tag = ""
              else
                ;
                (self._delegate):AnimationPlayCompleted(true)
              end
            end
          end
        end
      end
    end
  end
end

return Live2DManager

