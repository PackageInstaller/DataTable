-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonact.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonAct = class("DungeonAct", Dialog)
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local CButtonTip = (BeanManager.GetTableByName)("message.cbuttontip")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
DungeonAct.AssetBundleName = "ui/layouts.dungeon"
DungeonAct.AssetName = "DungeonAct1"
DungeonAct.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonAct
  ((DungeonAct.super).Ctor)(self, ...)
  self._groupName = "Default"
end

DungeonAct.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._button = self:GetChild("Button0")
  self._image = self:GetChild("Button0/Image")
  self._text = self:GetChild("Button0/Text")
  ;
  (self._button):Subscribe_PointerClickEvent(self.OnButtonClicked, self)
  local dialog = (DialogManager.GetDialog)("dungeon.dungeonhud")
  local hudX, huaY = 0, 0
  if dialog then
    hudX = (dialog:GetRootWindow()):GetRectSize()
  end
  local actAreaX, actAreaY = 0, 0
  if dialog then
    actAreaX = (dialog._actArea):GetRectSize()
  end
  local selfX, selfY = (self:GetRootWindow()):GetRectSize()
  ;
  (self:GetRootWindow()):SetPosition(0, hudX - actAreaX / 2 - selfX / 2, 0, actAreaY / 2 - selfY / 2)
  ;
  ((NekoData.BehaviorManager).BM_Game):SetGMHideUIByDialog((DataCommon.GMHideUI).Dungeon, self)
end

DungeonAct.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonAct.SetData = function(self, eventid, itype, data)
  -- function num : 0_3 , upvalues : _ENV, UIInteraction, CButtonTip, ImageTable
  self._eventID = eventid
  self._type = itype
  self._data = data
  self._future = nil
  if self._type == 1 then
    if type(self._data) == "table" then
      self._data = (self._data)[1]
    end
    local object = (UIInteraction.GetInteractiveObj)(self._data)
    local btnType = CButtonTip:GetRecorder(object:GetButtonTextType())
    print(object:GetInteractiveId(), object:GetButtonTextType(), btnType)
    ;
    (self._text):SetText((TextManager.GetText)(btnType.ContentTextID))
    local image = ImageTable:GetRecorder(btnType.Icon)
    if image then
      (self._image):SetSprite(image.assetBundle, image.assetName)
    else
      LogError("DungeonAct", "wrong Icon number in cbuttontip")
    end
  else
    do
      if self._type == 2 then
        local btnType = CButtonTip:GetRecorder(1)
        ;
        (self._text):SetText((TextManager.GetText)(btnType.ContentTextID))
        local image = ImageTable:GetRecorder(btnType.Icon)
        if image then
          (self._image):SetSprite(image.assetBundle, image.assetName)
        else
          LogError("DungeonAct", "wrong Icon number in cbuttontip")
        end
      else
        do
          if self._type == 3 then
            if type(self._data) == "table" then
              self._data = (self._data)[1]
            end
            local skill = CMapSkill:GetRecorder(self._data)
            ;
            (self._text):SetText(skill.name)
            local image = ImageTable:GetRecorder(skill.icon)
            if image then
              (self._image):SetSprite(image.assetBundle, image.assetName)
            else
              LogError("DungeonAct", "wrong icon number in cmapskill")
            end
          end
        end
      end
    end
  end
end

DungeonAct.OnButtonClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, UIInteraction
  if self._future and not (self._future):Finished() then
    return 
  end
  if self._type == 1 then
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller then
      self._future = (UIInteraction.RemoveUIReactEvent)(controller, self._eventID, self._data)
    else
      LogError("DungeonAct", "there is no scene controller")
    end
  else
    do
      if self._type == 2 then
        if #self._data == 1 then
          ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(4, nil, function(eventid)
    -- function num : 0_4_0 , upvalues : _ENV, UIInteraction, self
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller then
      (UIInteraction.RemoveUIReactEvent)(controller, eventid, (self._data)[1])
    else
      LogError("DungeonAct", "there is no scene controller")
    end
  end
, {self._eventID}, nil, {})
        else
          if #self._data > 1 then
            ((DialogManager.CreateSingletonDialog)("dungeon.dungeonuseitemssecondconfirm")):SetData(self._eventID, self._data)
          else
            LogError("DungeonAct", "there is no item can be used")
          end
        end
      else
        if self._type == 3 then
          self._roleId = 1
          ;
          ((DialogManager.CreateSingletonDialog)("dungeon.dungeonskillbanner")):SetData(self._data, self._roleId)
          local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
          if controller then
            (UIInteraction.RemoveUIReactEvent)(controller, self._eventID, self._data)
          else
            LogError("DungeonAct", "there is no scene controller")
          end
          ;
          (DialogManager.DestroySingletonDialog)("dungeon.dungeonskillbubble")
        else
          do
            LogError("DungeonAct", "wrong type for interaction")
          end
        end
      end
    end
  end
end

return DungeonAct

