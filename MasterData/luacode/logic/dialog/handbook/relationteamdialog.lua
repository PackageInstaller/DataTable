local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local CNodeHandBookCfg = BeanManager.GetTableByName("handbook.cnodeconfig_handbook")
local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CNpcHandBookCfg = BeanManager.GetTableByName("handbook.cnpcconfig_handbook")
local RelationTeamDialog = class("RelationTeamDialog", Dialog)
RelationTeamDialog.AssetBundleName = "ui/layouts.tujiannew"
RelationTeamDialog.AssetName = "RelationTeam"

function RelationTeamDialog:Ctor(...)
  RelationTeamDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._raycastHits = nil
  self._deleget = nil
  self.currentGroupId = nil
  self._handBookSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.HandBook)
end

function RelationTeamDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._toggle_0 = self:GetChild("ToggleGroup/_Toggle_0")
  self._toggle_1 = self:GetChild("ToggleGroup/_Toggle_1")
  self._toggle_0:SetIsOnType(true)
  self._toggle_1:SetIsOnType(false)
  self._toggle_0:Subscribe_PointerClickEvent(function()
    self._toggle_0:SetIsOnType(true)
  end, self)
  self._toggle_1:Subscribe_PointerClickEvent(function()
    self._toggle_1:SetIsOnType(false)
    self:ToBookList()
  end, self)
  self._raycastHits = PhysicsStaticFunctions.CreateRaycastHits(1)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackClicked, self)
end

function RelationTeamDialog:Init(deleget, currentGroupId)
  self._deleget = deleget
  self.currentGroupId = currentGroupId
end

function RelationTeamDialog:OnDestroy()
  self._deleget:OnEnable()
  self._handBookSceneController:SetCameraAnimatorState(1)
  self._handBookSceneController:SetGroupAnimatorStateById(self.currentGroupId, 0)
end

function RelationTeamDialog:OnBackClicked(args)
  local position = args.position
  local camera = self._handBookSceneController:GetCamera()
  local outputViewPos = UIManager.ScreenToViewportPointInMargin("HandBook", position.x, position.y, position.z)
  local ray = camera:ViewportPointToRay(outputViewPos)
  local count
  self._raycastHits, count = PhysicsStaticFunctions.RaycastNonAlloc(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return
  end
  local raycastHit = self._raycastHits[0]
  local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(raycastHit.collider.gameObject)
  if sceneObjectClick == nil then
    return
  end
  if sceneObjectClick.StringData == "Lock" then
    return
  end
  if sceneObjectClick.IntData ~= 0 then
    local roleid = CNpcHandBookCfg:GetRecorder(sceneObjectClick.IntData).roleID
    if sceneObjectClick.StringData == "NpcUnLock" then
      DialogManager.CreateSingletonDialog("handbook.npcdetailinfodialog"):Refresh(sceneObjectClick.IntData)
    elseif sceneObjectClick.StringData == "AllUnLock" then
      DialogManager.CreateSingletonDialog("handbook.handbooksceneroledetailinfodialog"):Refresh(roleid, sceneObjectClick.IntData)
    elseif sceneObjectClick.StringData == "RoleUnLock" then
      DialogManager.CreateSingletonDialog("handbook.handbooksceneroledetailinfodialog"):Refresh(roleid)
    end
  elseif sceneObjectClick.IntData2 ~= 0 then
    local npcid
    for k, v in ipairs(CNpcHandBookCfg:GetAllIds()) do
      local recoder = CNpcHandBookCfg:GetRecorder(v)
      if recoder.roleID == sceneObjectClick.IntData2 then
        npcid = v
      end
    end
    if sceneObjectClick.StringData == "AllUnLock" or sceneObjectClick.StringData == "RoleUnLock" then
      DialogManager.CreateSingletonDialog("handbook.handbooksceneroledetailinfodialog"):Refresh(sceneObjectClick.IntData2, npcid)
    else
      DialogManager.CreateSingletonDialog("handbook.npcdetailinfodialog"):Refresh(npcid)
    end
  end
end

function RelationTeamDialog:ToBookList()
  self._deleget:ToBookList()
  self:Destroy()
end

function RelationTeamDialog:OnBackBtnClicked()
  self:Destroy()
end

return RelationTeamDialog
