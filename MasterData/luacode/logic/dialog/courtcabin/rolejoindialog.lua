local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleJoinDialog = class("RoleJoinDialog", Dialog)
RoleJoinDialog.AssetBundleName = "ui/layouts.yard"
RoleJoinDialog.AssetName = "HouseCharDetail"

function RoleJoinDialog:Ctor(...)
  RoleJoinDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._roleList = {}
  self._task = nil
  self._willDestroy = false
end

function RoleJoinDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._roomIdTxt = self:GetChild("Back/Top/FloorNum")
  self._curRoleNum = self:GetChild("Back/Num/Num")
  self._maxRoleNum = self:GetChild("Back/Num/Total")
  self._clearBtn = self:GetChild("Back/ClearBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._quickBtn = self:GetChild("Back/QuickBtn")
  self._panel = self:GetChild("Back/CharFrame")
  self._frame = TableFrame.Create(self._panel, self, false, false)
  self._clearBtn:Subscribe_PointerClickEvent(self.OnClearBtnClick, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._quickBtn:Subscribe_PointerClickEvent(self.OnQuickBtnClick, self)
  self._back:Subscribe_PointerClickEvent(self.OnBackClick, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoom, Common.n_RefreshRoom, nil)
  self:GetRootWindow():PlayAnimation("CharLiveShow")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
end

function RoleJoinDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  self._frame:Destroy()
  DialogManager.DestroySingletonDialog("magictree.chooseroledialog")
end

function RoleJoinDialog:Init(roomId)
  local roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(roomId)
  self._roomInfo = roomInfo
  local maxRoleNum = NekoData.BehaviorManager.BM_Cabin:GetDispatchLimitRoleNum()
  local roles = NekoData.BehaviorManager.BM_Cabin:GetRoles()
  self._roomId = roomId
  local count = 0
  for i, v in ipairs(roomInfo.roles) do
    table.insert(self._roleList, {
      role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v),
      energyInfo = roles[v]
    })
    count = count + 1
  end
  for i = count, maxRoleNum do
    table.insert(self._roleList, {role = nil})
  end
  self._roomIdTxt:SetText(self._roomId)
  self._curRoleNum:SetText(count)
  self._maxRoleNum:SetText(maxRoleNum)
  self._frame:ReloadAllCell()
  if not self._task then
    self._task = GameTimer.AddTask(0, 60, function()
      self:RefreshRolesEnergy()
    end, nil)
  end
end

function RoleJoinDialog:OnRefreshRoom()
  while self._roleList[#self._roleList] do
    table.remove(self._roleList, #self._roleList)
  end
  local roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(self._roomId)
  self._roomInfo = roomInfo
  local maxRoleNum = NekoData.BehaviorManager.BM_Cabin:GetDispatchLimitRoleNum()
  local roles = NekoData.BehaviorManager.BM_Cabin:GetRoles()
  local count = 0
  for i, v in ipairs(roomInfo.roles) do
    table.insert(self._roleList, {
      role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v),
      energyInfo = roles[v]
    })
    count = count + 1
  end
  for i = count, maxRoleNum do
    table.insert(self._roleList, {role = nil})
  end
  self._roomIdTxt:SetText(self._roomId)
  self._curRoleNum:SetText(count)
  self._maxRoleNum:SetText(maxRoleNum)
  self._frame:ReloadAllCell()
end

function RoleJoinDialog:RefreshRolesEnergy()
  self._frame:FireEvent("RefreshEnergyAndRelation")
end

function RoleJoinDialog:OnClearBtnClick()
  if not self._willDestroy and #self._roomInfo.roles > 0 then
    local caddRolesInRoom = LuaNetManager.CreateProtocol("protocol.yard.caddrolesinroom")
    caddRolesInRoom.floorId = self._roomId
    caddRolesInRoom.roles = {}
    caddRolesInRoom:Send()
  end
end

function RoleJoinDialog:NumberOfCell(frame)
  return #self._roleList
end

function RoleJoinDialog:CellAtIndex(frame, index)
  return "courtcabin.rolecell"
end

function RoleJoinDialog:DataAtIndex(frame, index)
  return self._roleList[index]
end

function RoleJoinDialog:OnBackClick()
end

function RoleJoinDialog:OnBackBtnClicked()
  self:GetRootWindow():PlayAnimation("CharLiveHide")
  self._willDestroy = true
end

function RoleJoinDialog:OnQuickBtnClick()
  local nowRoleList = {}
  for _, v in ipairs(self._roleList) do
    if v.role and v.role:GetEnergy() and v.role:GetEnergy() < DataCommon.TotalEnergy then
      table.insert(nowRoleList, v.role:GetId())
    end
  end
  if #nowRoleList == 5 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100300)
    return
  end
  local canUseList = {}
  local roleList = NekoData.BehaviorManager.BM_AllRoles:GetContainMaterialRoleList()
  for _, v in ipairs(roleList) do
    if (not v:GetBuildingId() or v:GetBuildingId() and v:GetBuildingId() ~= DataCommon.Explore and v:GetBuildingId() ~= DataCommon.TrainCamp) and v:GetEnergy() and v:GetEnergy() < DataCommon.TotalEnergy and not table.isContain(nowRoleList, v:GetId()) then
      local tempInRole = NekoData.BehaviorManager.BM_Cabin:GetRoles()[v:GetId()]
      if tempInRole == nil or tempInRole.roomId == self._roomId then
        table.insert(canUseList, v)
      end
    end
  end
  table.sort(canUseList, function(v1, v2)
    return v1:GetEnergy() < v2:GetEnergy()
  end)
  local addRoleNum = NekoData.BehaviorManager.BM_Cabin:GetDispatchLimitRoleNum() - #nowRoleList
  for i = 1, addRoleNum do
    if canUseList[i] then
      table.insert(nowRoleList, canUseList[i]:GetId())
    end
  end
  if #nowRoleList == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100301)
  end
  if not self._willDestroy then
    local caddRolesInRoom = LuaNetManager.CreateProtocol("protocol.yard.caddrolesinroom")
    caddRolesInRoom.floorId = self._roomId
    caddRolesInRoom.roles = nowRoleList
    caddRolesInRoom:Send()
  end
end

function RoleJoinDialog:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "CharLiveShow" then
    self._canOperate = true
  elseif stateName == "CharLiveHide" then
    self:Destroy()
  end
end

return RoleJoinDialog
