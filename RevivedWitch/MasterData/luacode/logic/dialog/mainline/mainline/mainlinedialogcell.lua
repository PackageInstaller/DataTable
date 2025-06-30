-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/mainlinedialogcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local WorldInfoTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MainLineDialogCell = class("MainLineDialogCell", Dialog)
MainLineDialogCell.AssetBundleName = "ui/layouts.mainline"
MainLineDialogCell.AssetName = "MainLineWorldPanel"
MainLineDialogCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainLineDialogCell
  ((MainLineDialogCell.super).Ctor)(self, ...)
  self._world1GuideEffectHandler = nil
end

MainLineDialogCell.OnCreate = function(self)
  -- function num : 0_1
  self._worldBtn = {}
  for i = 1, 2 do
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

    (self._worldBtn)[i] = {whole = self:GetChild("Frame/World" .. i), lockImg = self:GetChild("Frame/World" .. i .. "/MapGrey"), unlockImg = self:GetChild("Frame/World" .. i .. "/Map"), namePanel = self:GetChild("Frame/World" .. i .. "/WorldName"), nameTxt = self:GetChild("Frame/World" .. i .. "/WorldName/Name"), describe = self:GetChild("Frame/World" .. i .. "/WorldName/Detail"), chapter = self:GetChild("Frame/World" .. i .. "/WorldName/Chapter"), lock = self:GetChild("Frame/World" .. i .. "/Lock"), new = self:GetChild("Frame/World" .. i .. "/New"), reddot = self:GetChild("Frame/World" .. i .. "/RedDot")}
  end
  -- DECOMPILER ERROR at PC125: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._worldBtn)[3] = {whole = self:GetChild("Frame/Break1"), lockImg = self:GetChild("Frame/Break1/MapGrey"), unlockImg = self:GetChild("Frame/Break1/Map"), namePanel = self:GetChild("Frame/Break1/WorldName"), nameTxt = self:GetChild("Frame/Break1/WorldName/Name"), describe = self:GetChild("Frame/Break1/WorldName/Detail"), chapter = self:GetChild("Frame/Break1/WorldName/Chapter"), lock = self:GetChild("Frame/Break1/Lock"), new = self:GetChild("Frame/Break1/New"), title = self:GetChild("Frame/Break1/Title"), reddot = self:GetChild("Frame/Break1/RedDot")}
  -- DECOMPILER ERROR at PC168: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._worldBtn)[4] = {whole = self:GetChild("Frame/World3"), lockImg = self:GetChild("Frame/World3/MapGrey"), unlockImg = self:GetChild("Frame/World3/Map"), namePanel = self:GetChild("Frame/World3/WorldName"), nameTxt = self:GetChild("Frame/World3/WorldName/Name"), describe = self:GetChild("Frame/World3/WorldName/Detail"), chapter = self:GetChild("Frame/World3/WorldName/Chapter"), lock = self:GetChild("Frame/World3/Lock"), new = self:GetChild("Frame/World3/New"), reddot = self:GetChild("Frame/World3/RedDot")}
  self._world1GuideEffect = self:GetChild("Frame/World1/Effect")
  self._leftArrow = self:GetChild("CanSlide/LeftArrow")
  self._rightArrow = self:GetChild("CanSlide/RightArrow")
  ;
  (self._leftArrow):SetActive(false)
  ;
  (self._rightArrow):SetActive(false)
  ;
  (((self._worldBtn)[1]).unlockImg):Subscribe_PointerClickEvent(self.OnWorld1UnlockClicked, self)
  ;
  (((self._worldBtn)[1]).lockImg):Subscribe_PointerClickEvent(self.OnWorld1LockClicked, self)
  ;
  (((self._worldBtn)[2]).unlockImg):Subscribe_PointerClickEvent(self.OnWorld2UnlockClicked, self)
  ;
  (((self._worldBtn)[2]).lockImg):Subscribe_PointerClickEvent(self.OnWorld2LockClicked, self)
  ;
  (((self._worldBtn)[3]).unlockImg):Subscribe_PointerClickEvent(self.OnWorld3UnlockClicked, self)
  ;
  (((self._worldBtn)[3]).lockImg):Subscribe_PointerClickEvent(self.OnWorld3LockClicked, self)
  ;
  (((self._worldBtn)[4]).unlockImg):Subscribe_PointerClickEvent(self.OnWorld4UnlockClicked, self)
  ;
  (((self._worldBtn)[4]).lockImg):Subscribe_PointerClickEvent(self.OnWorld4LockClicked, self)
end

MainLineDialogCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

MainLineDialogCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, WorldInfoTable, ImageTable
  self._data = {}
  for _,v in ipairs(data) do
    (table.insert)(self._data, v)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._data)[#self._data]).lock = false
  end
  for _,id in ipairs(WorldInfoTable:GetAllIds()) do
    local flag = false
    for _,v in ipairs(data) do
      if v.worldId == id then
        flag = true
        break
      end
    end
    do
      do
        if not flag then
          local temp = {}
          temp.worldId = id
          temp.lock = true
          ;
          (table.insert)(self._data, temp)
        end
        -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (table.sort)(self._data, function(a, b)
    -- function num : 0_3_0
    do return a.worldId < b.worldId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(self._data) do
    if (self._worldBtn)[i] then
      if v.lock then
        (((self._worldBtn)[i]).lockImg):SetActive(true)
        ;
        (((self._worldBtn)[i]).lock):SetActive(true)
        local worldOneLine = WorldInfoTable:GetRecorder(v.worldId)
        local image = ImageTable:GetRecorder(worldOneLine.worldimagegrey)
        if image then
          (((self._worldBtn)[i]).lockImg):SetSprite(image.assetBundle, image.assetName)
        end
        ;
        (((self._worldBtn)[i]).unlockImg):SetActive(false)
        ;
        (((self._worldBtn)[i]).namePanel):SetActive(false)
        if ((self._worldBtn)[i]).new then
          (((self._worldBtn)[i]).new):SetActive(false)
        end
        if ((self._worldBtn)[i]).title then
          (((self._worldBtn)[i]).title):SetActive(false)
        end
        ;
        (((self._worldBtn)[i]).reddot):SetActive(false)
      else
        do
          if ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldAwardReceiveByWorldId(v.worldId) and ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldAllZoneAwardReceive(v.worldId) then
            (((self._worldBtn)[i]).reddot):SetActive(false)
          else
            ;
            (((self._worldBtn)[i]).reddot):SetActive(true)
          end
          local worldLine = WorldInfoTable:GetRecorder(v.worldId)
          ;
          (((self._worldBtn)[i]).lockImg):SetActive(false)
          ;
          (((self._worldBtn)[i]).unlockImg):SetActive(true)
          ;
          (((self._worldBtn)[i]).lock):SetActive(false)
          do
            local image = ImageTable:GetRecorder(worldLine.worldimage)
            if image then
              (((self._worldBtn)[i]).unlockImg):SetSprite(image.assetBundle, image.assetName)
            end
            ;
            (((self._worldBtn)[i]).namePanel):SetActive(true)
            ;
            (((self._worldBtn)[i]).nameTxt):SetText((TextManager.GetText)(worldLine.worldTextID))
            ;
            (((self._worldBtn)[i]).chapter):SetText((TextManager.GetText)(worldLine.chapterTextID))
            ;
            (((self._worldBtn)[i]).describe):SetText((TextManager.GetText)(worldLine.detailTextID))
            if ((self._worldBtn)[i]).new then
              if v.clearZones == v.totalZones then
                (((self._worldBtn)[i]).new):SetActive(false)
              else
                ;
                (((self._worldBtn)[i]).new):SetActive(true)
              end
            end
            if ((self._worldBtn)[i]).title then
              (((self._worldBtn)[i]).title):SetActive(true)
            end
            -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

local ProcessUnlockClick = function(self, i)
  -- function num : 0_4 , upvalues : _ENV
  if (DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog") and not ((self._data)[i]).lock then
    local three = {
data = {}
, curZone = nil}
    three.curZone = ((self._data)[i]).curZone
    three.worldId = ((self._data)[i]).worldId
    three.clearZones = ((self._data)[i]).clearZones
    three.totalZones = ((self._data)[i]).totalZones
    three.isReceived = ((self._data)[i]).isReceived
    for _,d in ipairs(((self._data)[i]).floorDetail) do
      local temp = {}
      temp.id = d.floor
      temp.spirit = d.spirit
      temp.firstGet = d.firstGet
      temp.isReceived = d.isReceived
      temp.openedBoxes = d.openedBoxes
      temp.totalBoxes = d.totalBoxes
      temp.checkPointOpenBoxex = d.checkPointOpenBoxex
      temp.checkPointTotalBoxes = d.checkPointTotalBoxes
      temp.autoExplore = d.autoExplore
      temp.smallPoint = d.smallPoint
      ;
      (table.insert)(three.data, temp)
    end
    ;
    (table.sort)(three.data, function(a, b)
    -- function num : 0_4_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    ((DialogManager.CreateSingletonDialog)("mainline.mainline.newmainlinefloordialog")):SetData(three)
  end
end

local ProcessLockClick = function(self, i)
  -- function num : 0_5
end

MainLineDialogCell.OnWorld1UnlockClicked = function(self)
  -- function num : 0_6 , upvalues : ProcessUnlockClick
  ProcessUnlockClick(self, 1)
end

MainLineDialogCell.OnWorld1LockClicked = function(self)
  -- function num : 0_7 , upvalues : ProcessLockClick
  ProcessLockClick(1)
end

MainLineDialogCell.OnWorld2UnlockClicked = function(self)
  -- function num : 0_8 , upvalues : ProcessUnlockClick
  ProcessUnlockClick(self, 2)
end

MainLineDialogCell.OnWorld2LockClicked = function(self)
  -- function num : 0_9 , upvalues : ProcessLockClick
  ProcessLockClick(2)
end

MainLineDialogCell.OnWorld3UnlockClicked = function(self)
  -- function num : 0_10 , upvalues : ProcessUnlockClick
  ProcessUnlockClick(self, 3)
end

MainLineDialogCell.OnWorld3LockClicked = function(self)
  -- function num : 0_11 , upvalues : ProcessLockClick
  ProcessLockClick(3)
end

MainLineDialogCell.OnWorld4UnlockClicked = function(self)
  -- function num : 0_12 , upvalues : ProcessUnlockClick
  ProcessUnlockClick(self, 4)
end

MainLineDialogCell.OnWorld4LockClicked = function(self)
  -- function num : 0_13 , upvalues : ProcessLockClick
  ProcessLockClick(4)
end

MainLineDialogCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_14 , upvalues : _ENV
  if eventName == "RefreshRedDot" then
    for i,v in ipairs(self._data) do
      if (self._worldBtn)[i] and not v.lock then
        if ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldAwardReceiveByWorldId(v.worldId) and ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldAllZoneAwardReceive(v.worldId) then
          (((self._worldBtn)[i]).reddot):SetActive(false)
        else
          ;
          (((self._worldBtn)[i]).reddot):SetActive(true)
        end
      end
    end
  end
end

return MainLineDialogCell

