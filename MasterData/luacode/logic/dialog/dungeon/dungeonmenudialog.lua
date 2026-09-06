local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local DungeonMenuDialog = class("DungeonMenuDialog", Dialog)
DungeonMenuDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonMenuDialog.AssetName = "DungeonMenu"
local TableFrame = require("framework.ui.frame.table.tableframe")

function DungeonMenuDialog:Ctor(...)
  DungeonMenuDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

local function get_tasks()
  local tm = NekoData.BehaviorManager.BM_Task
  local list = {}
  local isUnlock = NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_Every)
  local status = 0
  for _, v in ipairs(tm:GetTasksByGroup(2)) do
    status = v:GetStatus()
    if status ~= 1 then
      local typ = v:GetType()
      if typ == 3 or typ == 8 then
        if isUnlock then
          list[#list + 1] = v
        end
      else
        list[#list + 1] = v
      end
    end
  end
  return {
    {
      id = 1,
      data = tm:GetTasksByGroup(1)
    },
    {id = 3, data = list}
  }
end

function DungeonMenuDialog:OnCreate()
  self._chapter = self:GetChild("DungeonInfo/Txt1")
  self._floor = self:GetChild("DungeonInfo/Txt2")
  self._title = self:GetChild("TaskBack/WorldTitle/Name")
  self._area = self:GetChild("TaskBack/WorldTitle/Area")
  self._settingBtn = self:GetChild("DungeonMenu/Setting")
  self._leaveBtn = self:GetChild("DungeonMenu/Leave")
  self._miniMapOrigin = self:GetChild("Map/Empty")
  self._taskFrame = self:GetChild("TaskFrame")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._settingBtn:Subscribe_PointerClickEvent(self.OnSettingBtnClicked, self)
  NekoData.BehaviorManager.BM_MiniMap:SetFullScreen()
  self._showTasks = get_tasks()
  self._helper = TableFrame.Create(self._taskFrame, self, true, true, true)
  self._helper:SetMargin(40, 0)
  self._helper:ReloadAllCell()
  self._helper:MoveToTop()
  self._leaveBtn:SetActive(false)
  local str = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon):GetSceneShowName()
  self._title:SetText(str)
  local temp = string.split(str, "·")
  if temp[1] then
    self._chapter:SetText(temp[1])
  end
  if temp[2] then
    self._floor:SetText(temp[2])
  end
  if #temp < 2 then
    temp = string.split(str, "-")
    if temp[1] then
      self._chapter:SetText(temp[1])
    end
    if temp[2] then
      self._floor:SetText(temp[2])
    end
  end
  local sceneId = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon):GetSceneID()
  for _, value in pairs(CDungeonSelectMainLine:GetAllIds()) do
    local recorder = CDungeonSelectMainLine:GetRecorder(value)
    if recorder.sceneid == sceneId then
      str = recorder.floor
      break
    end
    local smallNodeJHave = false
    for _, value in pairs(recorder.smallnodeid) do
      if value == sceneId then
        str = recorder.floor
        smallNodeJHave = true
        break
      end
    end
    if smallNodeJHave then
      break
    end
  end
  self._area:SetText(str)
  local dlg = DialogManager.GetDialog("dungeon.rockerdialog")
  if dlg then
    dlg:Mute()
  end
end

function DungeonMenuDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._helper then
    self._helper:Destroy()
  end
  NekoData.BehaviorManager.BM_MiniMap:SetSmall()
  local dlg = DialogManager.GetDialog("dungeon.rockerdialog")
  if dlg then
    dlg:UnMute()
  end
end

function DungeonMenuDialog:GetMiniMapOrigin()
  return self._miniMapOrigin
end

function DungeonMenuDialog:OnSettingBtnClicked()
  DialogManager.CreateSingletonDialog("systemsetting.systemsettingdialog")
end

function DungeonMenuDialog:OnBackBtnClicked()
  self:Destroy()
end

function DungeonMenuDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function DungeonMenuDialog:NumberOfCell()
  local count = 0
  for _, v in pairs(self._showTasks) do
    if table.nums(v.data) ~= 0 then
      count = count + 1
    end
  end
  return count
end

function DungeonMenuDialog:CellAtIndex()
  return "dungeon.dungeontaskframe"
end

function DungeonMenuDialog:DataAtIndex(helper, index)
  for _, v in pairs(self._showTasks) do
    if table.nums(v.data) ~= 0 then
      if index == 1 then
        return v
      else
        index = index - 1
      end
    end
  end
end

function DungeonMenuDialog:ShouldLengthChange()
  return true
end

return DungeonMenuDialog
