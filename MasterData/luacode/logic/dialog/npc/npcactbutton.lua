local NpcActButton = class("NpcActButton", Dialog)
local NPCManager = require("logic.scene.npcmanager")
local NpcObj = require("logic.manager.experimental.types.npcobj")
local NpcServiceAll = BeanManager.GetTableByName("npc.cserviceall")
local CButtonTip = BeanManager.GetTableByName("message.cbuttontip")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
NpcActButton.AssetBundleName = "ui/layouts.dungeon"
NpcActButton.AssetName = "DungeonAct1"

function NpcActButton:Ctor(...)
  NpcActButton.super.Ctor(self, ...)
  self._groupName = "Default"
end

function NpcActButton:OnCreate()
  self._text = self:GetChild("Button0/Text")
  self._image = self:GetChild("Button0/Image")
  local record = CButtonTip:GetRecorder(13)
  self._text:SetText(TextManager.GetText(record.ContentTextID))
  local image = ImageTable:GetRecorder(record.Icon)
  if image then
    self._image:SetSprite(image.assetBundle, image.assetName)
  else
    LogError("NpcActButton", "wrong Icon number in cbuttontip")
  end
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnSelfClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnSVisitNpc, Common.n_NPCServerListReceive, nil)
  local dialog = DialogManager.GetDialog("npc.npcuidialog")
  local hudX, huaY = 0, 0
  if dialog then
    hudX, huaY = dialog:GetRootWindow():GetRectSize()
  end
  local selfX, selfY = self:GetRootWindow():GetRectSize()
  self:GetRootWindow():SetPosition(0, hudX - selfX - selfY / 2, 0, selfY / 2)
  LuaNotificationCenter.AddObserver(self, self.OnNpcServerIDReturn, Common.n_NPCServerIDReceive, nil)
  NekoData.BehaviorManager.BM_Game:SetGMHideUIByDialog(DataCommon.GMHideUI.Dungeon, self)
end

function NpcActButton:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function NpcActButton:SetData(eventID, npcID)
  self._eventID = eventID
  self._id = npcID
end

function NpcActButton:OnSelfClicked()
  if self._pending then
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.npc.cvisitnpc")
  csend.npcId = self._id
  csend:Send()
  DialogManager.CreateSingletonDialog("login.eventreconnectdialog")
  self._pending = true
  local freezeEffect = EffectFactory.CreateFreezeEffect()
  freezeEffect:Run()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local obj = NekoData.BehaviorManager.BM_NPC:GetNpcInstance(controller:GetSceneID(), self._id)
  obj:RemoveSimpleBubble()
end

local function SetNPCDir(npcID)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local npcIns = NekoData.BehaviorManager.BM_NPC:GetNpcInstance(controller:GetSceneID(), npcID)
  local actorObj = controller._sceneRef.actor.object
  local x, y, z = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(actorObj)
  local ax = math.floor(x / 0.4 + 0.5)
  local ay = math.floor(z * -1 / 0.56 + 0.5)
  local position = npcIns:GetPosition()
  x, y = position.x, position.y
  if x - 1 == ax then
    npcIns:SetNPCDirection(NpcObj.DirType.West)
  elseif x + 1 == ax then
    npcIns:SetNPCDirection(NpcObj.DirType.East)
  elseif y - 1 == ay then
    npcIns:SetNPCDirection(NpcObj.DirType.South)
  elseif y + 1 == ay then
    npcIns:SetNPCDirection(NpcObj.DirType.North)
  end
end

function NpcActButton:OnSVisitNpc(args)
  self._pending = false
  local thawEffect = EffectFactory.CreateThawEffect()
  thawEffect:Run()
  local npcID = args.userInfo.npcID
  SetNPCDir(npcID)
  if args.userInfo.effectId ~= 0 then
    local recorder = BeanManager.GetTableByName("npc.cnpc"):GetRecorder(npcID)
    local effect = NPCManager.BuildNPCInteractiveEffect(args.userInfo.effectId)
    if recorder.reconnect == 0 then
      effect:Run()
    else
      local event = EventManager.CreateTransactionalEvent(false, 2)
      event:SetConfigID(args.userInfo.npcID)
      event:AddEffect(effect)
      event:Fire()
    end
  else
    local serverList = args.userInfo.services
    local service = NpcServiceAll:GetRecorder(serverList[1])
    if service and service.quick == 1 and #serverList == 1 then
      local csend = LuaNetManager.CreateProtocol("protocol.npc.cnpcservice")
      csend.npcId = npcID
      csend.serviceId = serverList[1]
      csend:Send()
    else
      local show = true
      if #args.userInfo.services == 0 then
        local chat_id = BeanManager.GetTableByName("npc.cnpc"):GetRecorder(args.userInfo.npcID).chat_id
        show = chat_id ~= 0
      end
      if show then
        DialogManager.CreateSingletonDialog("npc.npcserverdialog"):SetData(args.userInfo)
        NPCManager.HideNpcUI()
      end
      local thawEffect = EffectFactory.CreateThawEffect()
      thawEffect:Run()
    end
  end
end

function NpcActButton:OnNpcServerIDReturn(args)
  local serviceID = args.userInfo.serverID
  if NPCManager.FinishNPCEvent then
    NPCManager.FinishNPCEvent(serviceID)
  end
  if #args.userInfo.childs ~= 0 then
    local data = {
      npcID = args.userInfo.npcID,
      services = args.userInfo.childs
    }
    DialogManager.CreateSingletonDialog("npc.npcserverdialog"):SetData(data)
  end
  NPCManager.HideNpcUI()
  local thawEffect = EffectFactory.CreateThawEffect()
  thawEffect:Run()
end

return NpcActButton
