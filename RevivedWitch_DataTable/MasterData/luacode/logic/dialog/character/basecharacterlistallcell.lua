-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterlistallcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local BaseCharacterListAllCell = class("BaseCharacterListAllCell", Dialog)
BaseCharacterListAllCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListAllCell.AssetName = "BaseCharacterListSelectAllCell"
BaseCharacterListAllCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterListAllCell
  ((BaseCharacterListAllCell.super).Ctor)(self, ...)
  self._data = nil
  self._rarityEffectHandler = nil
end

local ShowCharUpgrade = function(self, level)
  -- function num : 0_1
  ((self._charUpgrade).panel):SetActive(level ~= 0)
  for i = 1, 5 do
    (((self._charUpgrade).levelImage)[i]):SetActive(level == i)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BaseCharacterListAllCell.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self._photo = self:GetChild("CharacterCell/Photo")
  self._rank = self:GetChild("CharacterCell/Rank")
  self._lock = self:GetChild("CharacterCell/Lock")
  self._lockBlack = self:GetChild("CharacterCell/Grey")
  if (self._lockBlack):IsActive() then
    (self._lockBlack):SetActive(false)
  end
  self._select = self:GetChild("CharacterCell/Select")
  if (self._select):IsActive() then
    (self._select):SetActive(false)
  end
  self._job = self:GetChild("CharacterCell/Job")
  self._evolveLevel = self:GetChild("CharacterCell/EvolveStar")
  self._frame = self:GetChild("CharacterCell/Frame")
  self._back = self:GetChild("CharacterCell/Back")
  self._downBack = self:GetChild("CharacterCell/DownBack")
  self._resolveGrey = self:GetChild("CharacterCell/ResolveGrey")
  self._inTeamText = self:GetChild("CharacterCell/Txt")
  self._unableResolveText = self:GetChild("CharacterCell/Same")
  self._characterCell = self:GetChild("CharacterCell")
  self._characterNewIcon = self:GetChild("CharacterCell/New")
  self._characterRedIcon = self:GetChild("CharacterCell/EvolveRedDot")
  self._breakLevelBack = self:GetChild("CharacterCell/BreakLevelBack")
  self._breakLevelBackBlack = self:GetChild("CharacterCell/BreakLevelBackBlack")
  self._breakLevel = self:GetChild("CharacterCell/BreakLevelNum")
  self._level = self:GetChild("CharacterCell/Down/Level")
  self._lvNum = self:GetChild("CharacterCell/Down/Level/Num")
  self._lvMaxNum = self:GetChild("CharacterCell/Down/Level/MaxNum")
  self._relation = self:GetChild("CharacterCell/Down/Relation")
  self._relationNum = self:GetChild("CharacterCell/Down/Relation/Num")
  self._relationMaxNum = self:GetChild("CharacterCell/Down/Relation/MaxNum")
  self._break = self:GetChild("CharacterCell/Down/Break")
  self._date = self:GetChild("CharacterCell/Down/Date")
  self._dateText = self:GetChild("CharacterCell/Down/Date/Text")
  self._property = self:GetChild("CharacterCell/Down/Property")
  self._propertyName = self:GetChild("CharacterCell/Down/Property/Name")
  self._propertyNum = self:GetChild("CharacterCell/Down/Property/Num")
  self._effect = self:GetChild("CharacterCell/EvolveEffect")
  self._elementImg = self:GetChild("CharacterCell/Element")
  self._charUpgrade = {panel = self:GetChild("CharacterCell/CharUpgrade"), 
levelImage = {}
}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC169: Confused about usage of register: R5 in 'UnsetPending'

    ((self._charUpgrade).levelImage)[i] = self:GetChild("CharacterCell/CharUpgrade/Img" .. i)
  end
  self._guideEffect = self:GetChild("Effect")
  if (self._level):IsActive() then
    (self._level):SetActive(false)
  end
  if (self._relation):IsActive() then
    (self._relation):SetActive(false)
  end
  if (self._break):IsActive() then
    (self._break):SetActive(false)
  end
  if (self._date):IsActive() then
    (self._date):SetActive(false)
  end
  if (self._property):IsActive() then
    (self._property):SetActive(false)
  end
  if (self._resolveGrey):IsActive() then
    (self._resolveGrey):SetActive(false)
  end
  if (self._inTeamText):IsActive() then
    (self._inTeamText):SetActive(false)
  end
  if (self._unableResolveText):IsActive() then
    (self._unableResolveText):SetActive(false)
  end
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRedPointNumChanged, Common.n_RedPointNumChanged, nil)
end

BaseCharacterListAllCell.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  if self._rarityEffectHandler then
    (self._guideEffect):ReleaseEffect(self._rarityEffectHandler)
    self._rarityEffectHandler = nil
  end
end

BaseCharacterListAllCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, ShowCharUpgrade
  self._data = data
  ;
  (self._photo):SetSprite((data:GetShapeBustImageRecord()).assetBundle, (data:GetShapeBustImageRecord()).assetName)
  if data:GetIsLeader() then
    (self._rank):SetActive(false)
  else
    ;
    (self._rank):SetActive(true)
    ;
    (self._rank):SetSprite((data:GetRarityImageRecord()).assetBundle, (data:GetRarityImageRecord()).assetName)
  end
  ;
  (self._job):SetSprite((data:GetVocationImageRecord()).assetBundle, (data:GetVocationImageRecord()).assetName)
  local curEvolveLv = (self._data):GetEvolution()
  local maxEvolveLv = (self._data):GetEvolutionLimit()
  local str = ""
  for i = 1, maxEvolveLv do
    if i <= curEvolveLv then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  ;
  (self._evolveLevel):SetActive(curEvolveLv > 0)
  ;
  (self._evolveLevel):SetText(str)
  ;
  (self._frame):SetSprite((data:GetRarityFrameRecord()).assetBundle, (data:GetRarityFrameRecord()).assetName)
  ;
  (self._back):SetSprite((data:GetRarityBackRecord()).assetBundle, (data:GetRarityBackRecord()).assetName)
  ;
  (self._downBack):SetSprite((data:GetRarityDownBackRecord()).assetBundle, (data:GetRarityDownBackRecord()).assetName)
  local image = data:GetElementImageRecord()
  ;
  (self._elementImg):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._lock):SetActive(data:GetIsLock())
  if (self._delegate)._lock then
    (self._lockBlack):SetActive(data:GetIsLock())
  else
    (self._lockBlack):SetActive(false)
  end
  ;
  (self._level):SetActive(false)
  ;
  (self._relation):SetActive(false)
  ;
  (self._break):SetActive(false)
  ;
  (self._date):SetActive(false)
  ;
  (self._property):SetActive(false)
  ;
  (self._characterNewIcon):SetActive(data:IsNew())
  ;
  (self._characterRedIcon):SetActive(((NekoData.BehaviorManager).BM_RedPoint):GetRedPointNum(100002, {(self._data):GetId()}) > 0)
  local breakLv = data:GetBreakLv()
  ;
  (self._breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._breakLevelBack):SetActive(breakLv > 0)
  ;
  (self._breakLevel):SetActive(breakLv > 0)
  do
    if breakLv > 0 then
      local imageRecord = data:GetCurBreakFrame2ImageRecord()
      ;
      (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._breakLevel):SetText(breakLv)
    end
    if (self._delegate)._sortNameId == nil or (self._delegate)._sortNameId == 24 or (self._delegate)._sortNameId == 27 or (self._delegate)._sortNameId == 29 or (self._delegate)._sortNameId == 31 then
      (self._level):SetActive(true)
      ;
      (self._lvNum):SetText(tostring(data:GetShowLv()))
      ;
      (self._lvMaxNum):SetText(tostring(data:GetShowMaxBreakLv()))
    elseif (self._delegate)._sortNameId == 25 then
      (self._relation):SetActive(true)
      ;
      (self._relationNum):SetText(tostring(((NekoData.BehaviorManager).BM_AllRoles):GetRoleRelationLevelWithRoleId(data:GetId())))
      ;
      (self._relationMaxNum):SetText(tostring(data:GetFavorMaxLv()))
    elseif (self._delegate)._sortNameId == 28 and not (self._break):IsActive() then
      (self._break):SetActive(true)
    elseif (self._delegate)._sortNameId == 30 then
      (self._date):SetActive(true)
      ;
      (self._dateText):SetText(tostring((os.date)("!%Y/%m/%d", data:GetBirthDay() // 1000)))
    else
      (self._property):SetActive(true)
      if (self._delegate)._sortNameId == 32 then
        (self._propertyName):SetText(tostring((TextManager.GetText)(32)))
        ;
        (self._propertyNum):SetText(tostring(data:GetMaxHp()))
      elseif (self._delegate)._sortNameId == 33 then
        (self._propertyName):SetText(tostring((TextManager.GetText)(39)))
        ;
        (self._propertyNum):SetText(tostring(data:GetAttack()))
      elseif (self._delegate)._sortNameId == 35 then
        (self._propertyName):SetText(tostring((TextManager.GetText)(41)))
        ;
        (self._propertyNum):SetText(tostring(data:GetDefend()))
      elseif (self._delegate)._sortNameId == 36 then
        (self._propertyName):SetText(tostring((TextManager.GetText)(42)))
        ;
        (self._propertyNum):SetText(tostring(data:GetMagDefend()))
      end
    end
    if (self._delegate)._inResolvePanel then
      if (self._delegate):IsInSelectResolveRoles(self._data) then
        (self._select):SetActive(true)
        ;
        (self._resolveGrey):SetActive(false)
        ;
        (self._inTeamText):SetActive(false)
        ;
        (self._unableResolveText):SetActive(false)
      elseif not (self._data):GetIsLock() and not (self._data):IsInTeams() and (self._data):CanResolve() then
        (self._select):SetActive(false)
        ;
        (self._inTeamText):SetActive(false)
        ;
        (self._unableResolveText):SetActive(false)
        if #(self._delegate)._selectResolveRoles >= 20 then
          (self._resolveGrey):SetActive(true)
        else
          (self._resolveGrey):SetActive(false)
        end
      elseif (self._data):GetIsLock() or (self._data):IsInTeams() or not (self._data):CanResolve() then
        (self._select):SetActive(false)
        ;
        (self._resolveGrey):SetActive(true)
        if (self._data):GetIsLeader() then
          (self._unableResolveText):SetActive(true)
          ;
          (self._inTeamText):SetActive(false)
        elseif (self._data):IsInTeams() then
          (self._inTeamText):SetActive(true)
          ;
          (self._unableResolveText):SetActive(false)
        else
          (self._inTeamText):SetActive(false)
          ;
          (self._unableResolveText):SetActive(false)
        end
      end
    else
      (self._resolveGrey):SetActive(false)
      ;
      (self._inTeamText):SetActive(false)
      ;
      (self._unableResolveText):SetActive(false)
      ;
      (self._select):SetActive(false)
    end
    ShowCharUpgrade(self, (self._data):GetRuneLevel())
    -- DECOMPILER ERROR: 25 unprocessed JMP targets
  end
end

BaseCharacterListAllCell.OnCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self._delegate)._inResolvePanel and not (self._resolveGrey):IsActive() and not (self._data):GetIsLock() and not (self._data):IsInTeams() and (self._data):CanResolve() and #(self._delegate)._selectResolveRoles <= 20 then
    (self._delegate):ChooseResolveRoles(self._cellData)
  end
  if (self._delegate)._isLock then
    local croleLock = (LuaNetManager.CreateProtocol)("protocol.login.crolelock")
    if croleLock then
      croleLock.roleId = (self._cellData):GetRoleId()
      croleLock:Send()
    end
  else
    do
      local dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
      ;
      (self._delegate):SetRoleHelperCurPos()
      if dialog then
        dialog:Refresh(self._data)
      end
    end
  end
end

BaseCharacterListAllCell.OnCellLongPress = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (self._delegate)._inResolvePanel then
    local dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
    if dialog then
      dialog:Refresh(self._data)
      ;
      (self._delegate):SetRoleHelperCurPos()
    end
  end
end

BaseCharacterListAllCell.OnRedPointNumChanged = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_RedPoint):GetRedPointNum(100002, {(self._data):GetId()}) <= 0 then
    (self._characterRedIcon):SetActive(not notification or (notification.userInfo).redPointID ~= 100002 or not (notification.userInfo).redPointParams or ((notification.userInfo).redPointParams)[1] ~= (self._data):GetId())
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BaseCharacterListAllCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_8
  if arg.lock ~= 1 then
    (self._lock):SetActive(arg.lock ~= 1 and (self._lock):IsActive() == eventName ~= "RoleLock" or (self._data):GetRoleId() ~= arg.key)
    if arg.lock ~= 1 then
      (self._lockBlack):SetActive((self._lockBlack):IsActive() == arg.lock == 1)
      if eventName == "EnterLockEvent" then
        if arg and (self._lockBlack):IsActive() ~= (self._data):GetIsLock() then
          (self._lockBlack):SetActive((self._data):GetIsLock())
        else
          (self._lockBlack):SetActive(false)
        end
      end
      if eventName == "RoleDusted" then
        (self._resolveGrey):SetActive(false)
        ;
        (self._select):SetActive(false)
        if (self._data):GetIsLeader() then
          (self._unableResolveText):SetActive(false)
          ;
          (self._inTeamText):SetActive(false)
        elseif (self._data):IsInTeams() then
          (self._inTeamText):SetActive(false)
        end
      end
      if eventName == "RoleDust" then
        if (self._data):GetIsLock() or (self._data):IsInTeams() or not (self._data):CanResolve() then
          (self._resolveGrey):SetActive(true)
          if (self._data):GetIsLeader() and not (self._unableResolveText):IsActive() then
            (self._unableResolveText):SetActive(true)
          elseif (self._data):IsInTeams() and not (self._inTeamText):IsActive() then
            (self._inTeamText):SetActive(true)
          end
        else
          (self._resolveGrey):SetActive(false)
        end
      end
      if eventName == "ChooseResolveRole" then
        if (self._delegate):IsInSelectResolveRoles(self._data) then
          (self._select):SetActive(true)
          ;
          (self._resolveGrey):SetActive(false)
        elseif not (self._data):GetIsLock() and not (self._data):IsInTeams() and (self._data):CanResolve() then
          (self._select):SetActive(false)
          if #(self._delegate)._selectResolveRoles >= 20 then
            (self._resolveGrey):SetActive(true)
          else
            (self._resolveGrey):SetActive(false)
          end
        end
      end
      -- DECOMPILER ERROR: 17 unprocessed JMP targets
    end
  end
end

return BaseCharacterListAllCell

