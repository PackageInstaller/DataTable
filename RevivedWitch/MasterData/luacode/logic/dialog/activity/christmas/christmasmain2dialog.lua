-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasmain2dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CInterEntry = (BeanManager.GetTableByName)("dungeonselect.cinterentry")
local CSecondEntryArray = (BeanManager.GetTableByName)("dungeonselect.csecondentryarray")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local CEventBoostRole = (BeanManager.GetTableByName)("activity.ceventboostrole")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CurrencyId = {DataCommon.ChristmasExpressiveForce, DataCommon.ChristmasJump, DataCommon.ChristmasSing}
local ChildDialogs = {"activity.christmas.christmasbagdialog", "activity.christmas.christmasbattledialog", "activity.christmas.christmasfoodstallsdialog", "activity.christmas.christmasfoodstallsshowdialog", "activity.christmas.christmasstorybattledialog", "activity.christmas.christmasstorymaindialog", "activity.christmas.christmasstorybranchdialog", "activity.christmas.christmasbossdialog", "activity.christmas.shopmaindialog", "activity.christmas.reminddialog"}
local MillisecondToDay = 86400000
local ChristmasMain2Dialog = class("ChristmasMain2Dialog", Dialog)
ChristmasMain2Dialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasMain2Dialog.AssetName = "ActivityChristmasMain2"
ChristmasMain2Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasMain2Dialog, _ENV
  ((ChristmasMain2Dialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)
  self._constructions = {}
  self._panelPos = 0
  self._focusPos = 0
end

local doors = {}
local doors1 = {"FrameIsland1", "FrameIsland2", "FrameIsland3", "FrameIsland4", "FrameIsland5", "FrameIsland6", "FrameIsland7", "FrameIsland8", "FrameIsland9", "FrameIsland10", "FrameIsland11", "FrameIsland12"}
local doors2 = {"2FrameIsland1", "2FrameIsland2", "2FrameIsland3", "2FrameIsland4", "2FrameIsland5", "2FrameIsland6", "2FrameIsland7", "2FrameIsland8", "2FrameIsland9", "2FrameIsland10", "2FrameIsland11", "2FrameIsland12", "2FrameIsland13", "2FrameIsland14", "2FrameIsland15", "2FrameIsland16", "2FrameIsland17", "2FrameIsland18", "2FrameIsland19", "2FrameIsland20", "2FrameIsland21", "2FrameIsland22", "2FrameIsland23", "2FrameIsland24", "2FrameIsland25", "2FrameIsland26", "2FrameIsland27", "2FrameIsland28", "2FrameIsland29", "2FrameIsland30", "2FrameIsland31", "2FrameIsland32", "2FrameIsland33", "2FrameIsland34", "2FrameIsland35"}
local doorType = {PLOT = "Trunk", Fight = "Fight", Top = "Top"}
local GetNextClientShowEntryId = function(self)
  -- function num : 0_1 , upvalues : _ENV, CSecondEntryArray
  if self._currentDoorPosID and self._currentDoorPosID ~= math.maxinteger and (self._constructions)[self._currentDoorPosID] ~= nil then
    local constructions = (self._constructions)[self._currentDoorPosID]
    local ID = nil
    for i,v in ipairs(CSecondEntryArray:GetAllIds()) do
      if (CSecondEntryArray:GetRecorder(v)).entryId == constructions.ID then
        ID = v
        if CSecondEntryArray:GetRecorder(ID + 1) then
          return (CSecondEntryArray:GetRecorder(ID + 1)).entryId
        end
      end
    end
  end
end

ChristmasMain2Dialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV, doors1, doorType, doors2, TableFrame, Item
  self._doors = {}
  self._doors1 = {}
  self._doors2 = {}
  self._back = self:GetChild("Background")
  ;
  (self._back):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_0
  end
, self)
  self._title = self:GetChild("Title")
  self._shopText = self:GetChild("ShopBtn/Text")
  self._bagText = self:GetChild("BagBtn/Text")
  self._powerName = self:GetChild("PowerBack/PowerName")
  self._remindBtn_text = self:GetChild("RemindBtn/Text")
  self._mailText = self:GetChild("MailBtn/Text")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._floorPanel = self:GetChild("Frame1")
  for i,v in ipairs(doors1) do
    do
      local door = {}
      do
        local name = "Frame1/" .. v .. "/ActivityChristmaIslandrCell"
        door.cell = self:GetChild("Frame1/" .. v)
        door.types = {}
        name = name .. "/TypeBtn"
        for _,type in pairs(doorType) do
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R13 in 'UnsetPending'

          (door.types)[type] = {}
          local btnName = name .. type
          do
            -- DECOMPILER ERROR at PC96: Confused about usage of register: R14 in 'UnsetPending'

            ((door.types)[type]).btn = self:GetChild(btnName)
            -- DECOMPILER ERROR at PC104: Confused about usage of register: R14 in 'UnsetPending'

            ;
            ((door.types)[type]).text = self:GetChild(btnName .. "/_Text")
            -- DECOMPILER ERROR at PC112: Confused about usage of register: R14 in 'UnsetPending'

            ;
            ((door.types)[type]).img = self:GetChild(btnName .. "/Img")
            local doorId = i
            ;
            (((door.types)[type]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_1 , upvalues : self, doorId, _ENV
    if (self._constructions)[doorId] then
      (self._bm):OnDoorClick(((self._constructions)[doorId]).ID)
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100428)
    end
  end
)
          end
        end
        -- DECOMPILER ERROR at PC124: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self._doors1)[i] = door
        ;
        (door.cell):SetActive(false)
      end
      do
        -- DECOMPILER ERROR at PC129: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for i,v in ipairs(doors2) do
    local door = {}
    local name = "Frame1/" .. v .. "/ActivityChristmaIslandBtnFight"
    door.cell = self:GetChild("Frame1/" .. v)
    door.types = {}
    -- DECOMPILER ERROR at PC150: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (door.types).Fight = {}
    -- DECOMPILER ERROR at PC156: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((door.types).Fight).btn = self:GetChild(name)
    -- DECOMPILER ERROR at PC164: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((door.types).Fight).text = self:GetChild(name .. "/_Text")
    -- DECOMPILER ERROR at PC172: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((door.types).Fight).img = self:GetChild(name .. "/Img")
    local doorId = i
    ;
    (((door.types).Fight).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_2 , upvalues : self, doorId, _ENV
    if (self._constructions)[doorId] then
      (self._bm):OnDoorClick(((self._constructions)[doorId]).ID)
    else
      if self._currentDoorPosID == math.maxinteger then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100427)
      else
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100428)
      end
    end
  end
)
    -- DECOMPILER ERROR at PC181: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._doors2)[i] = door
    ;
    (door.cell):SetActive(false)
  end
  self._turnBtn = self:GetChild("TurnBtn")
  self._turenBtn_Text = self:GetChild("TurnBtn/Text")
  ;
  (self._turenBtn_Text):SetText((TextManager.GetText)(1901213))
  ;
  (self._turnBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_3 , upvalues : self
    (self._bm):OnDoorClick(48)
  end
)
  self._boss1Btn = self:GetChild("Boss1Btn")
  self._boss2Btn = self:GetChild("Boss2Btn")
  self._boss1BtnText = self:GetChild("Boss1Btn/Text")
  self._boss2BtnText = self:GetChild("Boss2Btn/Text")
  ;
  (self._boss1Btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_4 , upvalues : self
    if (self._constructions)[101] then
      (self._bm):OnDoorClick(((self._constructions)[101]).ID)
    end
  end
)
  ;
  (self._boss2Btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_5 , upvalues : self
    if (self._constructions)[102] then
      (self._bm):OnDoorClick(((self._constructions)[102]).ID)
    end
  end
)
  self._shopBtn = self:GetChild("ShopBtn")
  self._bagBtn = self:GetChild("BagBtn")
  self._remindBtn = self:GetChild("RemindBtn")
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  ;
  (self._bagBtn):Subscribe_PointerClickEvent(self.OnBagBtnClick, self)
  ;
  (self._remindBtn):Subscribe_PointerClickEvent(self.OnRemindBtnClick, self)
  self._mailBtn = self:GetChild("MailBtn")
  self._mailBtn_RedDot = self:GetChild("MailBtn/RedDot")
  ;
  (self._mailBtn):Subscribe_PointerClickEvent(self.OnMailBtnClick, self)
  self._topGroup = self:GetChild("TopGroup")
  self._charFrame = self:GetChild("CharUp/CharFrame")
  self._charUpFrame = (TableFrame.Create)(self._charFrame, self, false, false)
  self._spiritNum = self:GetChild("TopGroup/Num2/Text")
  self._spiritAddBtn = self:GetChild("TopGroup/Num2/Add")
  self._spiritRedDot = self:GetChild("TopGroup/Num2/RedDot")
  self._spiritPanel = self:GetChild("TopGroup/Num2")
  ;
  (self._spiritPanel):Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._christmascurrency = {}
  for i = 1, 3 do
    local index = i + 2
    -- DECOMPILER ERROR at PC317: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._christmascurrency)[i] = {}
    -- DECOMPILER ERROR at PC325: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._christmascurrency)[i]).panel = self:GetChild("TopGroup/Num" .. index)
    -- DECOMPILER ERROR at PC334: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._christmascurrency)[i]).count = self:GetChild("TopGroup/Num" .. index .. "/Text")
    -- DECOMPILER ERROR at PC343: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._christmascurrency)[i]).img = self:GetChild("TopGroup/Num" .. index .. "/Icon")
    -- DECOMPILER ERROR at PC352: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._christmascurrency)[i]).add = self:GetChild("TopGroup/Num" .. index .. "/Add")
    -- DECOMPILER ERROR at PC361: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._christmascurrency)[i]).redDot = self:GetChild("TopGroup/Num" .. index .. "/RedDot")
    ;
    (((self._christmascurrency)[i]).redDot):SetActive(false)
    if ((self._christmascurrency)[i]).add then
      (((self._christmascurrency)[i]).add):SetActive(false)
    end
    ;
    (((self._christmascurrency)[i]).panel):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_6 , upvalues : self, i
    self:OnMaterialClick(i)
  end
, self)
  end
  self._scores = {}
  -- DECOMPILER ERROR at PC402: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._scores)[DataCommon.ChristmasSing] = {name = self:GetChild("PowerBack/PowerTextA"), scoreTxt = self:GetChild("PowerBack/NumA")}
  -- DECOMPILER ERROR at PC415: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._scores)[DataCommon.ChristmasJump] = {name = self:GetChild("PowerBack/PowerTextB"), scoreTxt = self:GetChild("PowerBack/NumB")}
  -- DECOMPILER ERROR at PC428: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._scores)[DataCommon.ChristmasExpressiveForce] = {name = self:GetChild("PowerBack/PowerTextC"), scoreTxt = self:GetChild("PowerBack/NumC")}
  self._scoreBtn = self:GetChild("PowerBack/PowerBtn")
  self._scoreBtn_RedDot = self:GetChild("PowerBack/PowerBtn/Img")
  self._scoreBtn_Text = self:GetChild("PowerBack/PowerBtn/Text")
  ;
  (self._scoreBtn):Subscribe_PointerClickEvent(self.OnScoreBtnClick, self)
  for k,v in pairs(self._scores) do
    local currencyItem = (Item.Create)(k)
    ;
    (v.name):SetText(currencyItem:GetName())
  end
  self._tipBtn = self:GetChild("TipBtn")
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClick, self)
  self._screenWidth = (self:GetRootWindow()):GetRectSize()
  ;
  (LuaAudioManager.StopBGM)(136)
  ;
  (LuaAudioManager.PlayBGM)(1356)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(6)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnOthersActivitysTimeOver, Common.n_OthersActivitysTimeOver, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateConstructionEvent, Common.n_OnSUpdateChristmasConstructionEvent, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshScorePanel, Common.n_RefreshChristmasScore, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshMaterials, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshChristmasMailRedDot, Common.n_RefreshChristmasMailRedDot, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEnterMianCity, Common.n_EnterMianCity, nil)
  self:Init()
end

local RefreshDoorByID = function(self, doorID)
  -- function num : 0_3 , upvalues : CInterEntry, _ENV, doorType, GetNextClientShowEntryId, CInterfaceFunction, CChristmasActivityEvent
  local door = (self._doors)[doorID]
  if door then
    if self:IsCommonBattlePhase() then
      local data = (self._constructions)[doorID]
      if data and #data.event > 0 then
        local name = ""
        local block = CInterEntry:GetRecorder(data.ID)
        if block then
          name = (TextManager.GetText)(block.name)
        end
        ;
        (((door.types)[doorType.Fight]).text):SetText(name)
        ;
        (door.cell):SetActive(true)
        local _, posy = (door.cell):GetYPosition()
        self._focusPos = posy
        self:SetSingletonSlideFrame()
        self:MoveFrameToPos(posy)
        if not self._handler then
          self._handler = ((NekoData.BehaviorManager).BM_Game):CreateGuideClickEffectDialog(door.cell, 1155)
        else
          ;
          ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler)
          self._handler = ((NekoData.BehaviorManager).BM_Game):CreateGuideClickEffectDialog(door.cell, 1155)
        end
      else
        do
          if self._currentDoorPosID == doorID - 1 then
            local id = GetNextClientShowEntryId(self)
            if id and CInterEntry:GetRecorder(id) then
              local name = ""
              local block = CInterEntry:GetRecorder(id)
              if block and #block.functionList > 0 then
                name = (TextManager.GetText)(block.name)
                ;
                (((door.types)[doorType.Fight]).text):SetText(name)
                ;
                (door.cell):SetActive(true)
                local type = (CInterfaceFunction:GetRecorder(tonumber(block.functionList))).type
                if type == CChristmasActivityEvent.MAINLINE_BATTLE or type == CChristmasActivityEvent.COMMON_TOWER then
                  (((door.types)[doorType.Fight]).btn):SetActive(true)
                  ;
                  (((door.types)[doorType.Fight]).text):SetText(name)
                else
                  if type == CChristmasActivityEvent.MAINLINE_PLOT or type == CChristmasActivityEvent.BRANCH_PLOT then
                    (((door.types)[doorType.PLOT]).btn):SetActive(true)
                    ;
                    (((door.types)[doorType.PLOT]).text):SetText(name)
                  end
                end
              end
            else
              do
                do
                  do
                    ;
                    (door.cell):SetActive(false)
                    if doorID - 1 < self._currentDoorPosID then
                      (door.cell):SetActive(false)
                    else
                      if self._currentDoorPosID < doorID then
                        (door.cell):SetActive(false)
                      end
                    end
                    local data = (self._constructions)[doorID]
                    if data and #data.event > 0 then
                      local type = (CInterfaceFunction:GetRecorder((data.event)[1])).type
                      for _,type in pairs(doorType) do
                        (((door.types)[type]).btn):SetActive(false)
                      end
                      local name = ""
                      local block = CInterEntry:GetRecorder(data.ID)
                      if block then
                        name = (TextManager.GetText)(block.name)
                      end
                      ;
                      (door.cell):SetActive(true)
                      ;
                      (((door.types)[doorType.Top]).btn):SetActive(false)
                      if type == CChristmasActivityEvent.MAINLINE_BATTLE or type == CChristmasActivityEvent.COMMON_TOWER then
                        (((door.types)[doorType.Fight]).btn):SetActive(true)
                        ;
                        (((door.types)[doorType.Fight]).text):SetText(name)
                      else
                        if type == CChristmasActivityEvent.MAINLINE_PLOT or type == CChristmasActivityEvent.BRANCH_PLOT then
                          (((door.types)[doorType.PLOT]).btn):SetActive(true)
                          ;
                          (((door.types)[doorType.PLOT]).text):SetText(name)
                        end
                      end
                      local _, posy = (door.cell):GetYPosition()
                      self._focusPos = posy
                      self:SetSingletonSlideFrame()
                      self:MoveFrameToPos(posy)
                      if not self._handler then
                        self._handler = ((NekoData.BehaviorManager).BM_Game):CreateGuideClickEffectDialog(door.cell, 1155)
                      else
                        ;
                        ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler)
                        self._handler = ((NekoData.BehaviorManager).BM_Game):CreateGuideClickEffectDialog(door.cell, 1155)
                      end
                    else
                      do
                        local id = GetNextClientShowEntryId(self)
                        if self._currentDoorPosID == doorID - 1 then
                          if id then
                            local name = ""
                            local block = CInterEntry:GetRecorder(id)
                            if block and #block.functionList > 0 then
                              for _,type in pairs(doorType) do
                                (((door.types)[type]).btn):SetActive(false)
                              end
                              name = (TextManager.GetText)(block.name)
                              ;
                              (((door.types)[doorType.Fight]).text):SetText(name)
                              ;
                              (door.cell):SetActive(true)
                              local type = (CInterfaceFunction:GetRecorder(tonumber(block.functionList))).type
                              if type == CChristmasActivityEvent.MAINLINE_BATTLE or type == CChristmasActivityEvent.COMMON_TOWER then
                                (((door.types)[doorType.Fight]).btn):SetActive(true)
                                ;
                                (((door.types)[doorType.Fight]).text):SetText(name)
                              else
                                if type == CChristmasActivityEvent.MAINLINE_PLOT or type == CChristmasActivityEvent.BRANCH_PLOT then
                                  (((door.types)[doorType.PLOT]).btn):SetActive(true)
                                  ;
                                  (((door.types)[doorType.PLOT]).text):SetText(name)
                                end
                              end
                            end
                          else
                            do
                              ;
                              (door.cell):SetActive(false)
                              if doorID - 1 < self._currentDoorPosID then
                                (door.cell):SetActive(false)
                              else
                                if self._currentDoorPosID < doorID then
                                  (door.cell):SetActive(false)
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

ChristmasMain2Dialog.RefreshChristmasMailRedDot = function(self)
  -- function num : 0_4
  (self._mailBtn_RedDot):SetActive((self._bm):ShowMailRedDot())
end

ChristmasMain2Dialog.OnDestroy = function(self)
  -- function num : 0_5 , upvalues : _ENV, ChildDialogs
  (UIBackManager.SetUIBackShow)(false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (LuaAudioManager.PlayBGM)(((NekoData.BehaviorManager).BM_Game):GetMainCityBgmID())
  ;
  (LuaAudioManager.StopBGM)(1356)
  for _,dialogName in pairs(ChildDialogs) do
    local dialog = (DialogManager.GetDialog)(dialogName)
    if dialog then
      dialog:Destroy()
    end
  end
  if self._charUpFrame then
    (self._charUpFrame):Destroy()
  end
  if self._singletonSlideFrame then
    (self._singletonSlideFrame):Destroy()
  end
  if self._handler then
    ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler)
    self._handler = nil
  end
  if self._handler1 then
    ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler1)
    self._handler1 = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("activity.christmas.accumulaterewarddialog")
end

ChristmasMain2Dialog.RefreshScorePanel = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self._scoreBtn_RedDot):SetActive((self._bm):ShowScoreRedDot())
  for k,v in pairs(self._scores) do
    (v.scoreTxt):SetText((self._bm):GetScoreByType(R10_PC15))
  end
end

ChristmasMain2Dialog.Init = function(self)
  -- function num : 0_7 , upvalues : _ENV, Item, CurrencyId, CEventBoostRole
  (self._title):SetText((TextManager.GetText)(1901211))
  ;
  (self._powerName):SetText((TextManager.GetText)(1901217))
  ;
  (self._shopText):SetText((TextManager.GetText)(1901205))
  ;
  (self._bagText):SetText((TextManager.GetText)(1901204))
  ;
  (self._remindBtn_text):SetText((TextManager.GetText)(1901216))
  ;
  (self._scoreBtn_Text):SetText((TextManager.GetText)(1901396))
  ;
  (self._mailText):SetText((TextManager.GetText)(1901206))
  self:RefreshChristmasMailRedDot()
  self:RefreshAllConstruction()
  self:RefreshScorePanel()
  for i,v in ipairs(self._christmascurrency) do
    local item = (Item.Create)(CurrencyId[i])
    ;
    (v.img):SetSprite(item:GetIconAB())
    ;
    (v.count):SetText(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(CurrencyId[i]))
  end
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
  ;
  (self._spiritNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit))
  ;
  (self._spiritRedDot):SetActive(self:HaveSpiritItemSoonExpire())
  self._charUpData = {}
  local allIds = CEventBoostRole:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CEventBoostRole:GetRecorder(allIds[i])
    if record.eventid == (DataCommon.Activities).Christmas then
      (table.insert)(self._charUpData, record)
    end
  end
  ;
  (table.sort)(self._charUpData, function(a, b)
    -- function num : 0_7_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._charUpFrame):ReloadAllCell()
  self._originalX = (self._floorPanel):GetPosition()
  local _ = nil
  _ = (self._floorPanel):GetRectSize()
  self._screenWidth = (self:GetRootWindow()):GetRectSize()
end

ChristmasMain2Dialog.RefreshAllConstruction = function(self)
  -- function num : 0_8 , upvalues : _ENV, CInterfaceFunction, CChristmasActivityEvent, doors, doors1, doors2, RefreshDoorByID, GetNextClientShowEntryId, CInterEntry, doorType, CSecondEntryArray
  self._currentDoorPosID = nil
  local constructions = (self._bm):GetConstructions()
  self._constructions = {}
  for _,construction in pairs(constructions) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

    if next(construction.event) ~= nil then
      (self._constructions)[construction.doorID] = construction
      local type = (CInterfaceFunction:GetRecorder((construction.event)[1])).type
      if type == CChristmasActivityEvent.MAINLINE_BATTLE or type == CChristmasActivityEvent.MAINLINE_PLOT or type == CChristmasActivityEvent.COMMON_TOWER then
        self._currentDoorPosID = construction.doorID
      end
    end
  end
  ;
  ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler)
  self._handler = nil
  if self._currentDoorPosID == nil then
    self._currentDoorPosID = math.maxinteger
  end
  if not self:IsCommonBattlePhase() then
    doors = doors1
    self._doors = self._doors1
  else
    doors = doors2
    self._doors = self._doors2
  end
  _ = (self._floorPanel):GetYPosition()
  self._originalX = (self._floorPanel):GetPosition()
  local _ = nil
  _ = (self._floorPanel):GetRectSize()
  for i,_ in ipairs(doors) do
    RefreshDoorByID(self, i)
  end
  if not self:IsCommonBattlePhase() then
    local id = GetNextClientShowEntryId(self)
    if id then
      local name = ""
      local block = CInterEntry:GetRecorder(id)
      if block and #block.functionList > 0 then
        local type = (CInterfaceFunction:GetRecorder(tonumber(block.functionList))).type
        if type == CChristmasActivityEvent.COMMON_TOWER then
          local door = (self._doors2)[1]
          name = (TextManager.GetText)(block.name)
          ;
          (door.cell):SetActive(true)
          ;
          (((door.types)[doorType.Fight]).btn):SetActive(true)
          ;
          (((door.types)[doorType.Fight]).text):SetText(name)
        end
      end
    end
  end
  do
    if self._currentDoorPosID == math.maxinteger then
      _ = (self._floorPanel):GetPosition()
      local door = (self._doors2)[#self._doors2]
      local entryId = (CSecondEntryArray:GetRecorder(#CSecondEntryArray:GetAllIds())).entryId
      local block = CInterEntry:GetRecorder(entryId)
      local name = (TextManager.GetText)(block.name)
      ;
      (door.cell):SetActive(true)
      ;
      (((door.types)[doorType.Fight]).btn):SetActive(true)
      ;
      (((door.types)[doorType.Fight]).text):SetText(name)
      local _, posy = (door.cell):GetYPosition()
      self._focusPos = posy
      self:SetSingletonSlideFrame()
      self:MoveFrameToPos(posy)
    end
    do
      self:RefreshBossDoor()
      ;
      (self._mailBtn):SetActive((self._bm):IsUnlockMail())
      ;
      (self._remindBtn):SetActive((self._bm):IsUnlockBook())
      ;
      (self._shopBtn):SetActive((self._bm):IsUnlockShop())
      ;
      (self._bagBtn):SetActive((self._bm):IsUnlockBag())
    end
  end
end

ChristmasMain2Dialog.RefreshBossDoor = function(self)
  -- function num : 0_9 , upvalues : _ENV, CInterfaceFunction, CInterEntry
  if self._handler1 then
    ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler1)
    self._handler1 = nil
  end
  local boss1Data = (self._constructions)[101]
  if boss1Data and #boss1Data.event > 0 then
    (self._boss1Btn):SetActive(true)
    local type = (CInterfaceFunction:GetRecorder((boss1Data.event)[1])).type
    local block = CInterEntry:GetRecorder(boss1Data.ID)
    if boss1Data.ID == 46 and not self._handler1 then
      self._handler1 = ((NekoData.BehaviorManager).BM_Game):CreateGuideClickEffectDialog(self._boss1Btn, 1155)
    end
    if self._handler1 then
      ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler1)
      self._handler1 = nil
    end
    ;
    (self._boss1BtnText):SetText((TextManager.GetText)(block.name))
  else
    do
      ;
      (self._boss1Btn):SetActive(false)
      if self._handler1 then
        ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler1)
        self._handler1 = nil
      end
      local boss2Data = (self._constructions)[102]
      if boss2Data and #boss2Data.event > 0 then
        (self._boss2Btn):SetActive(true)
        local type = (CInterfaceFunction:GetRecorder((boss2Data.event)[1])).type
        local block = CInterEntry:GetRecorder(boss2Data.ID)
        ;
        (self._boss2BtnText):SetText((TextManager.GetText)(block.name))
      else
        do
          ;
          (self._boss2Btn):SetActive(false)
        end
      end
    end
  end
end

ChristmasMain2Dialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

ChristmasMain2Dialog.OnMenuBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ChristmasMain2Dialog.OnShopBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  protocol.shopId = ((DataCommon.Christmas).Shop).Sing
  protocol:Send()
end

ChristmasMain2Dialog.OnBagBtnClick = function(self)
  -- function num : 0_13 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.christmas.christmasbagdialog")):SetData((self._bm):GetBuffInfo())
end

ChristmasMain2Dialog.OnRemindBtnClick = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("activity.christmas.reminddialog")
end

ChristmasMain2Dialog.OnScoreBtnClick = function(self)
  -- function num : 0_15 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.christmas.accumulaterewarddialog")):SetType(DataCommon.ChristmasSing)
end

ChristmasMain2Dialog.OnSUpdateConstructionEvent = function(self, notification)
  -- function num : 0_16
  self:RefreshAllConstruction()
end

ChristmasMain2Dialog.OnSpiritAddBtnClick = function(self)
  -- function num : 0_17 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

ChristmasMain2Dialog.RefreshSpirit = function(self, notification)
  -- function num : 0_18 , upvalues : _ENV
  self._spirit = (notification.userInfo).spirit
  ;
  (self._spiritNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit))
end

ChristmasMain2Dialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_19 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < MillisecondToDay then
      return true
    end
  end
  return false
end

ChristmasMain2Dialog.RefreshMaterials = function(self, notification)
  -- function num : 0_20 , upvalues : _ENV, CurrencyId
  for i,v in ipairs(self._christmascurrency) do
    (v.count):SetText(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(CurrencyId[i]))
  end
end

ChristmasMain2Dialog.MoveFrameToPos = function(self, posy)
  -- function num : 0_21
  self._panelPos = -posy + self._screenHeight / 4
  ;
  (self._floorPanel):SetPosition(self._originalX, self._originalOX, 0, self._panelPos)
end

ChristmasMain2Dialog.OnBeginDrag = function(self, args)
  -- function num : 0_22
  self._dragSpeed = 0
  self._dragDelta = 0
  self._slideTime = 0.5
  self._needUpdate = false
end

ChristmasMain2Dialog.OnDrag = function(self, args)
  -- function num : 0_23 , upvalues : UIManager
  local pressPosition = args.pressPosition
  local position = args.position
  local _, localPressY = (UIManager.ScreenPointToLocalPointInRectangle)((self._floorPanel)._uiObject, pressPosition.x, pressPosition.y)
  local _, localY = (UIManager.ScreenPointToLocalPointInRectangle)((self._floorPanel)._uiObject, position.x, position.y)
  self._dragSpeed = args.ySpeed / 10
  local currentPosition = self._panelPos
  self._panelPos = currentPosition - self._dragDelta
  self._dragDelta = localY - localPressY
  self._panelPos = self._panelPos + self._dragDelta
  if self._panelPos < -self._focusPos + self._screenHeight / 4 then
    self._panelPos = -self._focusPos + self._screenHeight / 4
  end
  if self._focusPos - self._screenHeight / 4 < self._panelPos then
    self._panelPos = self._focusPos - self._screenHeight / 4
  end
  if currentPosition ~= self._panelPos then
    self._needUpdate = true
    self:UpdateView(0)
  end
end

ChristmasMain2Dialog.OnEndDrag = function(self, args)
  -- function num : 0_24 , upvalues : UIManager, _ENV
  self._dragDelta = 0
  local _, original = (UIManager.ScreenPointToLocalPointInRectangle)((self._floorPanel)._uiObject, 0, 0)
  local _, speed = (UIManager.ScreenPointToLocalPointInRectangle)((self._floorPanel)._uiObject, 0, self._dragSpeed)
  speed = original - speed
  self._dragSpeed = speed
  if self._panelPos < -self._focusPos + self._screenHeight / 4 then
    self._panelPos = -self._focusPos + self._screenHeight / 4
  end
  if self._focusPos - self._screenHeight / 4 < self._panelPos then
    self._panelPos = self._focusPos - self._screenHeight / 4
  end
  self._slideOriPos = self._panelPos
  local first = {spe = speed}
  local last = {spe = 0}
  self._slideTask = (Tween.new)(self._slideTime, first, last, "linear")
  self._needUpdate = true
end

ChristmasMain2Dialog.UpdateView = function(self, deltaTime)
  -- function num : 0_25
  if self._needUpdate then
    (self._floorPanel):SetPosition(self._originalX, self._originalOX, 0, self._panelPos)
    if not self._slideTask and not self._moveTask then
      self._needUpdate = false
    end
  end
end

ChristmasMain2Dialog.OnLateUpdate = function(self, notification)
  -- function num : 0_26
  local deltaTime = (notification.userInfo).deltaTime
  if self._needUpdate then
    if self._slideTask then
      if (self._slideTask):update(deltaTime) then
        self._panelPos = self._slideOriPos - (self._dragSpeed + ((self._slideTask).subject).spe) * self._slideTime / 2
        self._slideTask = nil
        self._slideOriPos = nil
      else
        self._panelPos = self._slideOriPos - (self._dragSpeed + ((self._slideTask).subject).spe) * (self._slideTask).clock / 2
      end
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R3 in 'UnsetPending'

      if self._slideTask and (self._panelPos < self._focusPos - self._screenHeight / 4 or -self._focusPos + self._screenHeight / 4 < self._panelPos) then
        (self._slideTask).clock = (self._slideTask).clock + 2 * deltaTime
      end
      if self._panelPos < -self._focusPos + self._screenHeight / 4 then
        self._panelPos = -self._focusPos + self._screenHeight / 4
      end
      if self._focusPos - self._screenHeight / 4 < self._panelPos then
        self._panelPos = self._focusPos - self._screenHeight / 4
      end
    end
    if self._moveTask then
      if (self._moveTask):update(deltaTime) then
        self._panelPos = self._moveDesPos
        self._moveTask = nil
        self._moveDesPos = nil
      else
        self._panelPos = ((self._moveTask).subject).pos
      end
    end
    self:UpdateView(deltaTime)
  end
end

ChristmasMain2Dialog.IsCommonBattlePhase = function(self)
  -- function num : 0_27 , upvalues : _ENV, CInterfaceFunction, CChristmasActivityEvent
  if self._currentDoorPosID == math.maxinteger then
    return true
  end
  local constructions = (self._bm):GetConstructions()
  for _,construction in pairs(constructions) do
    if next(construction.event) ~= nil then
      local type = (CInterfaceFunction:GetRecorder((construction.event)[1])).type
      if type == CChristmasActivityEvent.COMMON_TOWER then
        return true
      end
    end
  end
  return false
end

ChristmasMain2Dialog.OnTipBtnClick = function(self)
  -- function num : 0_28 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.christmas.christmastipsdialog")):SetData(1901377)
end

ChristmasMain2Dialog.OnMaterialClick = function(self, index)
  -- function num : 0_29 , upvalues : _ENV, Item, CurrencyId
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(CurrencyId[index])})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

ChristmasMain2Dialog.AddNewModal = function(self, dialog)
  -- function num : 0_30 , upvalues : _ENV, ChildDialogs
  if (table.contain)(ChildDialogs, dialog._dialogName) then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

ChristmasMain2Dialog.OnMailBtnClick = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cchristmasactivityevent")
  csend.eventID = ((DataCommon.Christmas).Function).Mail
  csend:Send()
end

ChristmasMain2Dialog.OnEnterMianCity = function(self)
  -- function num : 0_32 , upvalues : _ENV
  (LuaAudioManager.StopBGM)(136)
  ;
  (LuaAudioManager.PlayBGM)(1356)
  if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).Christmas) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100033)
    self:OnBackBtnClicked()
  end
end

ChristmasMain2Dialog.OnNPCChatEnd = function(self)
  -- function num : 0_33
end

ChristmasMain2Dialog.NumberOfCell = function(self, frame)
  -- function num : 0_34
  if frame == self._charUpFrame then
    return #self._charUpData
  end
end

ChristmasMain2Dialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_35
  if frame == self._charUpFrame then
    return "activity.christmas.christmasmaincharcell"
  end
end

ChristmasMain2Dialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_36
  if frame == self._charUpFrame then
    return (self._charUpData)[index]
  end
end

ChristmasMain2Dialog.SetSingletonSlideFrame = function(self)
  -- function num : 0_37 , upvalues : SingletonSlideFrame
  if self._singletonSlideFrame then
    (self._singletonSlideFrame):Destroy()
  end
  local xMinEdge = -self._focusPos + self._panelHeight / 2 - self._screenHeight / 6
  local xMaxEdge = -self._focusPos + self._panelHeight / 2 - self._screenHeight / 4
  self._singletonSlideFrame = (SingletonSlideFrame.Create)(self._floorPanel, true, xMinEdge, xMaxEdge)
end

ChristmasMain2Dialog.OnOthersActivitysTimeOver = function(self)
  -- function num : 0_38 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).Christmas) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100033)
    self:OnBackBtnClicked()
  end
end

ChristmasMain2Dialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_39
  local dialogName = (notification.userInfo)._dialogName
  if dialogName == "npcchat.newnpcchatdialog" or dialogName == "bag.spiritrecoverdialog" then
    (self._rootWindow):SetActive(true)
  end
end

return ChristmasMain2Dialog

