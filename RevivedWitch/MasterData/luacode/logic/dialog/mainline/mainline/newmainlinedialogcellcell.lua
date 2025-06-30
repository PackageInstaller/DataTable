-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/newmainlinedialogcellcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local WorldInfoTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local NewMainlineDialogCellCell = class("NewMainlineDialogCellCell", Dialog)
NewMainlineDialogCellCell.AssetBundleName = "ui/layouts.mainline"
NewMainlineDialogCellCell.AssetName = "MainLineWorldPanelCell"
local worldSelectType = {OneWorld = 1, SecondWorld = 2, ThirdWorld = 3}
NewMainlineDialogCellCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewMainlineDialogCellCell
  ((NewMainlineDialogCellCell.super).Ctor)(self, ...)
  self._effectHandler = nil
end

NewMainlineDialogCellCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._cell = {}
  self._lockImg = {}
  self._unlockImg = {}
  self._namePanel = {}
  self._nameTxt = {}
  self._chapter = {}
  self._lock = {}
  self._new = {}
  self._redDot = {}
  self._effect = {}
  self._levelLimit = {}
  self._levelLimitText = {}
  for i = 1, 3 do
    do
      local indexStr = ""
      if i > 1 then
        indexStr = tostring(i)
      end
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._cell)[i] = self:GetChild("Cell" .. indexStr)
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._lockImg)[i] = self:GetChild("Cell" .. indexStr .. "/MapGrey" .. indexStr)
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._unlockImg)[i] = self:GetChild("Cell" .. indexStr .. "/Map" .. indexStr)
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._namePanel)[i] = self:GetChild("Cell" .. indexStr .. "/WorldName")
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._nameTxt)[i] = self:GetChild("Cell" .. indexStr .. "/WorldName/Name")
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._chapter)[i] = self:GetChild("Cell" .. indexStr .. "/WorldName/Chapter")
      -- DECOMPILER ERROR at PC91: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._lock)[i] = self:GetChild("Cell" .. indexStr .. "/Lock")
      -- DECOMPILER ERROR at PC99: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._new)[i] = self:GetChild("Cell" .. indexStr .. "/New")
      -- DECOMPILER ERROR at PC107: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._redDot)[i] = self:GetChild("Cell" .. indexStr .. "/RedDot")
      -- DECOMPILER ERROR at PC115: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._effect)[i] = self:GetChild("Cell" .. indexStr .. "/WorldEffect")
      -- DECOMPILER ERROR at PC123: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._levelLimit)[i] = self:GetChild("Cell" .. indexStr .. "/LevelLimit")
      -- DECOMPILER ERROR at PC131: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._levelLimitText)[i] = self:GetChild("Cell" .. indexStr .. "/LevelLimit/Txt")
    end
  end
  for k,v in pairs(self._cell) do
    ((self._cell)[k]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, k
    self:OnCellClicked(k)
  end
, self)
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReceiveDungeonPointAward, Common.n_ReceiveDungeonPointAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReceiveDungeonWorldAward, Common.n_ReceiveDungeonWorldAward, nil)
end

NewMainlineDialogCellCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._effectHandler then
    ((self._effect)[self._newSelecttype]):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

NewMainlineDialogCellCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, WorldInfoTable, ImageTable, worldSelectType, CStringRes
  self._data = data
  for k,v in pairs(self._cell) do
    ((self._cell)[k]):SetActive(false)
  end
  for i,v in ipairs(self._data) do
    ((self._cell)[v.selecttype]):SetActive(true)
    if v.lock or (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel < v.unlockLv then
      ((self._lockImg)[v.selecttype]):SetActive(true)
      ;
      ((self._lock)[v.selecttype]):SetActive(true)
      local worldOneLine = WorldInfoTable:GetRecorder(v.worldId)
      local image = ImageTable:GetRecorder(worldOneLine.worldimagegrey)
      if image then
        ((self._lockImg)[v.selecttype]):SetSprite(image.assetBundle, image.assetName)
      end
      ;
      ((self._unlockImg)[v.selecttype]):SetActive(false)
      if v.selecttype == worldSelectType.ThirdWorld then
        ((self._namePanel)[v.selecttype]):SetActive(false)
      else
        ;
        ((self._namePanel)[v.selecttype]):SetActive(true)
        ;
        ((self._nameTxt)[v.selecttype]):SetText((TextManager.GetText)((CStringRes:GetRecorder(1279)).msgTextID))
        ;
        ((self._chapter)[v.selecttype]):SetText("")
      end
      ;
      ((self._new)[v.selecttype]):SetActive(false)
      ;
      ((self._redDot)[v.selecttype]):SetActive(false)
      ;
      ((self._effect)[v.selecttype]):SetActive(false)
      if not v.lock then
        ((self._levelLimit)[v.selecttype]):SetActive(true)
        local str = (CStringRes:GetRecorder(1374)).msgTextID
        str = (TextManager.GetText)(str)
        str = (string.gsub)(str, "%$parameter1%$", v.unlockLv)
        ;
        ((self._levelLimitText)[v.selecttype]):SetText(str)
      else
        do
          do
            ;
            ((self._levelLimit)[v.selecttype]):SetActive(false)
            local worldLine = WorldInfoTable:GetRecorder(v.worldId)
            ;
            ((self._lockImg)[v.selecttype]):SetActive(false)
            ;
            ((self._unlockImg)[v.selecttype]):SetActive(true)
            ;
            ((self._lock)[v.selecttype]):SetActive(false)
            do
              local image = ImageTable:GetRecorder(worldLine.worldimage)
              if image then
                ((self._unlockImg)[v.selecttype]):SetSprite(image.assetBundle, image.assetName)
              end
              ;
              ((self._namePanel)[v.selecttype]):SetActive(true)
              ;
              ((self._nameTxt)[v.selecttype]):SetText((TextManager.GetText)(worldLine.worldTextID))
              ;
              ((self._chapter)[v.selecttype]):SetText((TextManager.GetText)(worldLine.chapterTextID))
              if v.clearZones == v.totalZones then
                ((self._new)[v.selecttype]):SetActive(false)
                ;
                ((self._effect)[v.selecttype]):SetActive(false)
              else
                ;
                ((self._new)[v.selecttype]):SetActive(true)
                ;
                ((self._effect)[v.selecttype]):SetActive(true)
                if self._effectHandler then
                  ((self._effect)[v.selecttype]):ReleaseEffect(self._effectHandler)
                  self._effectHandler = nil
                end
                self._effectHandler = ((self._effect)[v.selecttype]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(worldLine.mainlineListEffect))
                self._newSelecttype = v.selecttype
              end
              if ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldAwardReceiveByWorldId(v.worldId) and ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldAllZoneAwardReceive(v.worldId) then
                ((self._redDot)[v.selecttype]):SetActive(false)
              else
                ;
                ((self._redDot)[v.selecttype]):SetActive(true)
              end
              ;
              ((self._levelLimit)[v.selecttype]):SetActive(false)
              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC308: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

NewMainlineDialogCellCell.OnCellClicked = function(self, index)
  -- function num : 0_4 , upvalues : _ENV
  if (DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog") then
    for i,v in ipairs(self._data) do
      if v.selecttype == index and not v.lock then
        do
          if (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel < v.unlockLv then
            local dialog = (DialogManager.CreateSingletonDialog)("dungeon.levellimitconfirmdialog")
            if dialog then
              dialog:Init(v.unlockLv, true)
            end
            return 
          end
          do
            do
              local three = {
data = {}
, curZone = nil}
              three.curZone = v.curZone
              three.worldId = v.worldId
              three.clearZones = v.clearZones
              three.totalZones = v.totalZones
              three.isReceived = v.isReceived
              for _,d in ipairs(v.floorDetail) do
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
              do break end
              -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

NewMainlineDialogCellCell.OnReceiveDungeonPointAward = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  for i,v in ipairs(self._data) do
    if not v.lock then
      for _,d in ipairs(v.floorDetail) do
        if (notification.userInfo).id == d.floor then
          d.isReceived = 1
          break
        end
      end
    end
  end
end

NewMainlineDialogCellCell.OnReceiveDungeonWorldAward = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  for i,v in ipairs(self._data) do
    if not v.lock and v.worldId == (notification.userInfo).id then
      v.isReceived = 1
    end
  end
end

NewMainlineDialogCellCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7 , upvalues : _ENV
  if eventName == "RefreshRedDot" then
    for i,v in ipairs(self._data) do
      if not v.lock then
        if ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldAwardReceiveByWorldId(v.worldId) and ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldAllZoneAwardReceive(v.worldId) then
          ((self._redDot)[v.selecttype]):SetActive(false)
        else
          ;
          ((self._redDot)[v.selecttype]):SetActive(true)
        end
      end
    end
  end
end

return NewMainlineDialogCellCell

