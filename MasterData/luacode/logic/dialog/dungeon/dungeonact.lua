local DungeonAct = class("DungeonAct", Dialog)
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local CButtonTip = BeanManager.GetTableByName("message.cbuttontip")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
DungeonAct.AssetBundleName = "ui/layouts.dungeon"
DungeonAct.AssetName = "DungeonAct1"

function DungeonAct:Ctor(...)
  DungeonAct.super.Ctor(self, ...)
  self._groupName = "Default"
end

function DungeonAct:OnCreate()
  self._button = self:GetChild("Button0")
  self._image = self:GetChild("Button0/Image")
  self._text = self:GetChild("Button0/Text")
  self._button:Subscribe_PointerClickEvent(self.OnButtonClicked, self)
  local dialog = DialogManager.GetDialog("dungeon.dungeonhud")
  local hudX, huaY = 0, 0
  if dialog then
    hudX, huaY = dialog:GetRootWindow():GetRectSize()
  end
  local actAreaX, actAreaY = 0, 0
  if dialog then
    actAreaX, actAreaY = dialog._actArea:GetRectSize()
  end
  local selfX, selfY = self:GetRootWindow():GetRectSize()
  self:GetRootWindow():SetPosition(0, hudX - actAreaX / 2 - selfX / 2, 0, actAreaY / 2 - selfY / 2)
  NekoData.BehaviorManager.BM_Game:SetGMHideUIByDialog(DataCommon.GMHideUI.Dungeon, self)
end

function DungeonAct:OnDestroy()
end

function DungeonAct:SetData(eventid, itype, data)
  self._eventID = eventid
  self._type = itype
  self._data = data
  self._future = nil
  if self._type == 1 then
    if type(self._data) == "table" then
      self._data = self._data[1]
    end
    local object = UIInteraction.GetInteractiveObj(self._data)
    local btnType = CButtonTip:GetRecorder(object:GetButtonTextType())
    print(object:GetInteractiveId(), object:GetButtonTextType(), btnType)
    self._text:SetText(TextManager.GetText(btnType.ContentTextID))
    local image = ImageTable:GetRecorder(btnType.Icon)
    if image then
      self._image:SetSprite(image.assetBundle, image.assetName)
    else
      LogError("DungeonAct", "wrong Icon number in cbuttontip")
    end
  elseif self._type == 2 then
    local btnType = CButtonTip:GetRecorder(1)
    self._text:SetText(TextManager.GetText(btnType.ContentTextID))
    local image = ImageTable:GetRecorder(btnType.Icon)
    if image then
      self._image:SetSprite(image.assetBundle, image.assetName)
    else
      LogError("DungeonAct", "wrong Icon number in cbuttontip")
    end
  elseif self._type == 3 then
    if type(self._data) == "table" then
      self._data = self._data[1]
    end
    local skill = CMapSkill:GetRecorder(self._data)
    self._text:SetText(skill.name)
    local image = ImageTable:GetRecorder(skill.icon)
    if image then
      self._image:SetSprite(image.assetBundle, image.assetName)
    else
      LogError("DungeonAct", "wrong icon number in cmapskill")
    end
  end
end

function DungeonAct:OnButtonClicked()
  if self._future and not self._future:Finished() then
    return
  end
  if self._type == 1 then
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller then
      self._future = UIInteraction.RemoveUIReactEvent(controller, self._eventID, self._data)
    else
      LogError("DungeonAct", "there is no scene controller")
    end
  elseif self._type == 2 then
    if #self._data == 1 then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(4, nil, function(eventid)
        local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
        if controller then
          UIInteraction.RemoveUIReactEvent(controller, eventid, self._data[1])
        else
          LogError("DungeonAct", "there is no scene controller")
        end
      end, {
        self._eventID
      }, nil, {})
    elseif #self._data > 1 then
      DialogManager.CreateSingletonDialog("dungeon.dungeonuseitemssecondconfirm"):SetData(self._eventID, self._data)
    else
      LogError("DungeonAct", "there is no item can be used")
    end
  elseif self._type == 3 then
    self._roleId = 1
    DialogManager.CreateSingletonDialog("dungeon.dungeonskillbanner"):SetData(self._data, self._roleId)
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller then
      UIInteraction.RemoveUIReactEvent(controller, self._eventID, self._data)
    else
      LogError("DungeonAct", "there is no scene controller")
    end
    DialogManager.DestroySingletonDialog("dungeon.dungeonskillbubble")
  else
    LogError("DungeonAct", "wrong type for interaction")
  end
end

return DungeonAct
