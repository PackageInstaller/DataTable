-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/page/pageframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local LogicCell = require("framework.ui.frame.page.logiccell")
local PageFrame = class("PageFrame")
PageFrame.Ctor = function(self, window, delegate, noanimation, noloop)
  -- function num : 0_0 , upvalues : _ENV
  if not window then
    LogError("TabFrame", "tab must init with window")
    return 
  end
  if not delegate then
    LogError("TabFrame", "tab must have delegate")
    return 
  end
  self._window = window
  self._delegate = delegate
  if noanimation then
    self._noanimation = noanimation
  end
  if noloop then
    self._noloop = noloop
  end
  self._pageIndex = 0
  self._lastPageIndex = 0
  self._maxPage = 0
  self._cellList = {}
  self._deltaTime = 0.2
  ;
  (self._window):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  ;
  (self._window):Subscribe_EndDragEvent(self.OnEndDrag, self)
  ;
  (self._window):Subscribe_CancelDragEvent(self.OnEndDrag, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  self._width = 50
end

PageFrame.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for _,cell in pairs(self._cellList) do
    cell:Destroy()
    cell:RootWindowDestroy()
  end
  self._cellList = {}
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

PageFrame.ToPage = function(self, page)
  -- function num : 0_2 , upvalues : _ENV
  for i,v in pairs(self._cellList) do
    if v ~= page then
      (v:GetRootWindow()):SetAlpha(0)
    end
  end
  self._maxPage = (self._delegate):NumberOfCell(self)
  if self._maxPage <= 0 then
    return 
  end
  if page < 0 or self._maxPage < page then
    return 
  end
  self._pageIndex = page
  if not (self._cellList)[self._pageIndex] then
    self:GetCellAtIndex(self._pageIndex)
  end
  local cell = (self._cellList)[self._pageIndex]
  ;
  (cell:GetRootWindow()):SetAlpha(1)
  cell._cellData = (self._delegate):DataAtIndex(self, self._pageIndex)
  cell:RefreshCell(cell._cellData)
  ;
  (self._delegate):OnPageChanged(self._pageIndex)
end

PageFrame.ToPageWithAnimation = function(self, page)
  -- function num : 0_3 , upvalues : _ENV
  if not self._playAnimationTag then
    local tag = nil
    if page < 0 or self._maxPage < page then
      return 
    end
    self._lastPageIndex = self._pageIndex
    ;
    (self._window):SetBlocksRaycasts(false)
    if page == self._maxPage and self._pageIndex == 1 then
      tag = "left"
      self._pageIndex = page
    else
      if page == 1 and self._pageIndex == self._maxPage then
        tag = "right"
        self._pageIndex = page
      else
        if page < self._pageIndex then
          tag = "right"
          if self._pageIndex - 1 == 0 then
            self._pageIndex = self._maxPage
          else
            self._pageIndex = self._pageIndex - 1
          end
        else
          if self._pageIndex < page then
            tag = "left"
            self._pageIndex = self._pageIndex % self._maxPage + 1
          end
        end
      end
    end
    if self._pageIndex ~= self._lastPageIndex and tag == "right" then
      self._lastPageTask = (Tween.new)(self._deltaTime, {value = 1, Position = 0}, {value = 0, Position = self._width}, "linear")
      self._pageTask = (Tween.new)(self._deltaTime, {value = 0, Position = -self._width}, {value = 1, Position = 0}, "linear")
      self._playAnimationTag = true
    end
    if self._pageIndex ~= self._lastPageIndex and tag == "left" then
      self._lastPageTask = (Tween.new)(self._deltaTime, {value = 1, Position = 0}, {value = 0, Position = -self._width}, "linear")
      self._pageTask = (Tween.new)(self._deltaTime, {value = 0, Position = self._width}, {value = 1, Position = 0}, "linear")
      self._playAnimationTag = true
    end
    if (self._delegate).WillDrag then
      (self._delegate):WillDrag(true)
    end
  end
end

PageFrame.GetPage = function(self)
  -- function num : 0_4
  return self._pageIndex
end

PageFrame.FireEvent = function(self, eventName, ...)
  -- function num : 0_5 , upvalues : _ENV
  for i,cell in pairs(self._cellList) do
    if cell and cell.OnEvent then
      cell:OnEvent(eventName, ...)
    end
  end
end

PageFrame.OnBeginDrag = function(self)
  -- function num : 0_6
  if not self._playAnimationTag then
    self._dragDelta = 0
    self._lastPageIndex = self._pageIndex
    self._lastPageTask = nil
    self._pageTask = nil
    ;
    (self._window):SetBlocksRaycasts(false)
  end
end

PageFrame.OnEndDrag = function(self, args)
  -- function num : 0_7 , upvalues : UIManager, _ENV
  if not self._playAnimationTag then
    local pressPosition = args.pressPosition
    local position = args.position
    local localPressX, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._window)._uiObject, pressPosition.x, pressPosition.y)
    local localX, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._window)._uiObject, position.x, position.y)
    self._dragDelta = localX - localPressX
    if self._dragDelta > 0 then
      if self._pageIndex - 1 == 0 then
        if self._noloop then
          self._pageIndex = self._maxPage
          self._pageIndex = self._pageIndex - 1
          if self._dragDelta < 0 then
            if self._pageIndex == self._maxPage and self._noloop then
              self._pageIndex = self._pageIndex % self._maxPage + 1
              if not self._noanimation then
                if self._pageIndex ~= self._lastPageIndex and self._dragDelta > 0 then
                  self._lastPageTask = (Tween.new)(self._deltaTime, {value = 1, Position = 0}, {value = 0, Position = self._width}, "linear")
                  self._pageTask = (Tween.new)(self._deltaTime, {value = 0, Position = -self._width}, {value = 1, Position = 0}, "linear")
                  self._playAnimationTag = true
                end
                if self._pageIndex ~= self._lastPageIndex and self._dragDelta < 0 then
                  self._lastPageTask = (Tween.new)(self._deltaTime, {value = 1, Position = 0}, {value = 0, Position = -self._width}, "linear")
                  self._pageTask = (Tween.new)(self._deltaTime, {value = 0, Position = self._width}, {value = 1, Position = 0}, "linear")
                  self._playAnimationTag = true
                end
                if self._lastPageTask and self._pageTask and (self._delegate).WillDrag then
                  (self._delegate):WillDrag(true)
                end
              else
                self:ToPage(self._pageIndex)
              end
            end
          end
        end
      end
    end
  end
end

PageFrame.OnLateUpdate = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV
  if self._lastPageTask then
    if (self._lastPageTask):update((notification.userInfo).deltaTime) then
      self._lastPageTask = nil
      self._lastPageAlpha = 0
      self._lastPageXPosition = -self._width
    else
      self._lastPageAlpha = ((self._lastPageTask).subject).value
      self._lastPageXPosition = ((self._lastPageTask).subject).Position
    end
  end
  if self._pageTask then
    if (self._pageTask):update((notification.userInfo).deltaTime) then
      self._pageTask = nil
      self._PageAlpha = 1
      self._PageXPosition = 0
    else
      self._PageAlpha = ((self._pageTask).subject).value
      self._PageXPosition = ((self._pageTask).subject).Position
    end
  end
  if self._playAnimationTag then
    self:UpdateView()
  end
  if not self._lastPageTask and not self._pageTask then
    self._playAnimationTag = false
  end
  if not self._playAnimationTag then
    (self._window):SetBlocksRaycasts(true)
    for k,v in pairs(self._cellList) do
      if k == self._pageIndex then
        (v:GetRootWindow()):SetActive(true)
      else
        ;
        (v:GetRootWindow()):SetActive(false)
      end
    end
  else
    do
      ;
      (self._window):SetBlocksRaycasts(false)
      for k,v in pairs(self._cellList) do
        if k == self._pageIndex or k == self._lastPageIndex then
          (v:GetRootWindow()):SetActive(true)
        else
          ;
          (v:GetRootWindow()):SetActive(false)
        end
      end
    end
  end
end

PageFrame.UpdateView = function(self)
  -- function num : 0_9
  if self._lastPageIndex > 0 and self._lastPageIndex <= self._maxPage then
    if not (self._cellList)[self._lastPageIndex] then
      self:GetCellAtIndex(self._lastPageIndex)
    end
    local cell = (self._cellList)[self._lastPageIndex]
    cell._cellData = (self._delegate):DataAtIndex(self, self._lastPageIndex)
    cell:RefreshCell(cell._cellData)
  end
  do
    if self._pageIndex > 0 and self._pageIndex <= self._maxPage then
      if not (self._cellList)[self._pageIndex] then
        self:GetCellAtIndex(self._pageIndex)
      end
      local cell = (self._cellList)[self._pageIndex]
      cell._cellData = (self._delegate):DataAtIndex(self, self._pageIndex)
      cell:RefreshCell(cell._cellData)
    end
    do
      if self._lastPageIndex > 0 and self._lastPageIndex <= self._maxPage then
        (((self._cellList)[self._lastPageIndex]):GetRootWindow()):SetAlpha(self._lastPageAlpha)
        ;
        (((self._cellList)[self._lastPageIndex]):GetRootWindow()):SetPosition(0, self._lastPageXPosition, 0, 0)
      end
      if self._pageIndex > 0 and self._pageIndex <= self._maxPage then
        (((self._cellList)[self._pageIndex]):GetRootWindow()):SetAlpha(self._PageAlpha)
        ;
        (((self._cellList)[self._pageIndex]):GetRootWindow()):SetPosition(0, self._PageXPosition, 0, 0)
        ;
        (self._delegate):OnPageChanged(self._pageIndex)
      end
    end
  end
end

PageFrame.GetCellAtIndex = function(self, page)
  -- function num : 0_10 , upvalues : _ENV, LogicCell
  if (self._cellList)[page] then
    return 
  else
    if not (self._delegate).CellAtIndex then
      LogError("TabFrame", "tab delegate need function CellAtIndex")
      return 
    end
    local logicCell = (LogicCell.Create)()
    logicCell._dialogName = (self._delegate):CellAtIndex(self, page)
    self:GetCellDialog(logicCell)
    ;
    ((logicCell._cell):GetRootWindow()):SetAlpha(0)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (logicCell._cell)._delegate = self._delegate
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (logicCell._cell)._cellData = (self._delegate):DataAtIndex(self, page)
    ;
    (logicCell._cell):RefreshCell((logicCell._cell)._cellData)
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._cellList)[page] = logicCell._cell
  end
end

PageFrame.GetCellDialog = function(self, logicCell)
  -- function num : 0_11 , upvalues : _ENV
  if logicCell._cell then
    return 
  end
  logicCell._cell = (DialogManager.CreateDialog)(logicCell._dialogName, (self._window)._uiObject)
end

return PageFrame

