local TableFrame = require("framework.ui.frame.table.tableframe")
local NPCManager = require("logic.scene.npcmanager")
local NpcObj = require("logic.manager.experimental.types.npcobj")
local cNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local cImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local cNpc = BeanManager.GetTableByName("npc.cnpc")
local NpcServiceAll = BeanManager.GetTableByName("npc.cserviceall")
local NpcChat = BeanManager.GetTableByName("npc.cnpcchat")
local NpcServerDialog = class("NpcServerDialog", Dialog)
NpcServerDialog.AssetBundleName = "ui/layouts.dramadialog"
NpcServerDialog.AssetName = "DramaMain"
NpcServerDialog.ChatType = {
  NpcLeftChat = 1,
  SelfChat = 0,
  NpcRightChat = 2
}

function NpcServerDialog:Ctor(...)
  NpcServerDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._timer = nil
  self._live2DID = 0
end

function NpcServerDialog:OnCreate()
  self._rightModelNamePanel = self:GetChild("UI/NameR")
  self._rightModelName = self:GetChild("UI/NameR/Text")
  self._rightRoleShowPanel = self:GetChild("PhotoR")
  self._rightModel = self:GetChild("PhotoR/Image")
  self._rightModelLive2D = self:GetChild("PhotoR/Live2D")
  self._skipBtn = self:GetChild("UI/SkipBtn")
  self._backBtn = self:GetChild("UI/BackBtn")
  self._backBtn:SetActive(false)
  self._nextBtn = self:GetChild("UI/Back/NextBtn")
  self._nextBtn:SetActive(false)
  self._nextTxt = self:GetChild("UI/Back/NextTxt")
  self._nextTxt:SetActive(false)
  self._uiBoard = self:GetChild("UI")
  self._leftModelNamePanel = self:GetChild("UI/NameL")
  self._leftModelName = self:GetChild("UI/NameL/Text")
  self._leftRoleShowPanel = self:GetChild("PhotoL")
  self._leftModel = self:GetChild("PhotoL/Image")
  self._leftModelLive2D = self:GetChild("PhotoL/Live2D")
  self._selection = self:GetChild("UI/Selection")
  self._board = self:GetChild("UI/Back")
  self._conversation = self:GetChild("UI/Back/Text")
  self._panelNext = self:GetChild("UI/Panel")
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
  self._frame = TableFrame.Create(self._selection, self, true, false, true)
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self._selection:GetPosition()
  local _dlt
  _dlt, self._initHeight = self._selection:GetHeight()
  self._skipBtn:Subscribe_PointerClickEvent(self.OnPanelNextClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnNpcServerIDReturn, Common.n_NPCServerIDReceive, nil)
end

function NpcServerDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  if self._backTxtTimer then
    GameTimer.RemoveTask(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._trashTalkID then
    LuaNotificationCenter.PostNotification(Common.n_NPCChatEnd, self, self._trashTalkID)
  end
  NPCManager.ShowNpcUI()
end

function NpcServerDialog:ShowNPC(npc, npcID, namepanel, showpanel, name, model, live2d, hidenamepanel, hideshowpanel, hidemodel, hidelive2d)
  namepanel:SetActive(true)
  showpanel:SetActive(true)
  hidenamepanel:SetActive(false)
  hideshowpanel:SetActive(false)
  hidemodel:SetActive(false)
  hidelive2d:SetActive(false)
  name:SetText(TextManager.GetText(npc.NameTextID))
  local shape = cNPCShape:GetRecorder(npc.NPCShapeID)
  if Live2DManager.CanUse() and shape.live2DPrefabName ~= "" and shape.live2DPrefabName ~= "" then
    model:SetActive(false)
    live2d:SetActive(true)
    if self._live2DID ~= npc.NPCShapeID then
      if self._live2d then
        live2d:Release(self._live2d)
        self._live2d = nil
      end
      self._live2d = live2d:AddLive2D(shape.live2DAssetBundleName, shape.live2DPrefabName, shape.live2DScale)
      self._live2DID = npc.NPCShapeID
    end
  elseif shape.lihuiID ~= 0 then
    local imageRecord = cImagePathTable:GetRecorder(shape.lihuiID)
    if imageRecord then
      model:SetActive(true)
      live2d:SetActive(false)
      model:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local scale = shape.photoScale
      model:SetLocalScale(scale, scale, scale)
      model:SetAnchoredPosition(shape.photoLocation[1], shape.photoLocation[2])
    else
      LogErrorFormat("NpcServerDialog", "image id %d isn't exist, the id comes from npcId %d with npcshapeId %d", shape.lihuiID, npcID, npc.NPCShapeID)
    end
  end
end

function NpcServerDialog:SetData(args)
  local npcID = args.npcID
  local npc = cNpc:GetRecorder(npcID)
  local chatRecord = NpcChat:GetRecorder(npc.chat_id)
  if chatRecord.type == NpcServerDialog.ChatType.NpcLeftChat then
    self:ShowNPC(npc, npcID, self._leftModelNamePanel, self._leftRoleShowPanel, self._leftModelName, self._leftModel, self._leftModelLive2D, self._rightModelNamePanel, self._rightRoleShowPanel, self._rightModel, self._rightModelLive2D)
  elseif chatRecord.type == NpcServerDialog.ChatType.NpcRightChat then
    self:ShowNPC(npc, npcID, self._rightModelNamePanel, self._rightRoleShowPanel, self._rightModelName, self._rightModel, self._rightModelLive2D, self._leftModelNamePanel, self._leftRoleShowPanel, self._leftModel, self._leftModelLive2D)
  elseif chatRecord.type == NpcServerDialog.ChatType.SelfChat then
    self._leftModelNamePanel:SetActive(false)
    self._leftRoleShowPanel:SetActive(false)
    self._rightModelNamePanel:SetActive(false)
    self._rightRoleShowPanel:SetActive(false)
  end
  local serverList = args.services
  if #serverList == 0 then
    self._selection:SetActive(false)
    self._skipBtn:SetActive(false)
    self._panelNext:Subscribe_PointerClickEvent(self.OnPanelNextClicked, self)
    if npc.chat_id ~= 0 then
      self._trashTalkID = self._trashTalkID or npc.chat_id
      if self._timer then
        GameTimer.RemoveTask(self._timer)
        self._timer = nil
      end
      self._timer = GameTimer.AddTask(chatRecord.SkipTime, 0, function()
        self:Destroy()
      end, nil)
      if tonumber(chatRecord.time) ~= 0 then
        local initString = TextManager.GetText(chatRecord.chatTextID)
        local deltTime = tonumber(chatRecord.time) / 3
        if self._backTxtTimer then
          GameTimer.RemoveTask(self._backTxtTimer)
          self._backTxtTimer = nil
        end
        local chars = stringutils.split2table(initString)
        local index = 0
        self._backTxtTimer = GameTimer.AddTask(0, deltTime, function()
          index = index + 1
          if index > #chars then
            self._conversation:SetText(table.concat(chars, ""))
            GameTimer.RemoveTask(self._backTxtTimer)
            self._backTxtTimer = nil
          else
            self._conversation:SetText(table.concat(chars, "", 1, index))
          end
        end, nil)
      else
        self._conversation:SetText(TextManager.GetText(chatRecord.chatTextID))
      end
    else
      LogWarningFormat("NpcServerDialog", "npc %d chat_id is 0", npcID)
    end
  else
    self._selection:SetActive(true)
    self._data = {}
    for _, v in ipairs(serverList) do
      local temp = {}
      temp.npcID = npcID
      temp.serverID = v
      table.insert(self._data, temp)
    end
    self._frame:ReloadAllCell()
    local itemFrameHeight = self._frame:GetTotalLength()
    self._selection:SetHeight(0, itemFrameHeight)
    self._frame:ReloadAllCell()
    self._selection:SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y + (self._initHeight - itemFrameHeight) / 2)
  end
end

local function SetNPCDir(npcID)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local npcIns = NekoData.BehaviorManager.BM_NPC:GetNpcInstance(controller:GetSceneID(), npcID)
  npcIns:SetNPCDirection(NpcObj.DirType.Default)
end

function NpcServerDialog:OnNpcServerIDReturn(args)
  local npcID = args.userInfo.npcID
  local serviceID = args.userInfo.serverID
  local service = NpcServiceAll:GetRecorder(serviceID)
  if service then
    self._conversation:SetText(service.servicedescribe)
  end
  if NPCManager.FinishNPCEvent then
    NPCManager.FinishNPCEvent(serviceID)
  end
  if #args.userInfo.childs ~= 0 then
    if self._frame then
      self._frame:Destroy()
      self._frame = nil
    end
    self._frame = TableFrame.Create(self._selection, self, true, false, true)
    self._data = {}
    for _, v in ipairs(args.userInfo.childs) do
      local temp = {}
      temp.npcID = npcID
      temp.serverID = v
      table.insert(self._data, temp)
    end
    self._frame:ReloadAllCell()
    local itemFrameHeight = self._frame:GetTotalLength()
    self._selection:SetHeight(0, itemFrameHeight)
    self._frame:ReloadAllCell()
    self._selection:SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y + (self._initHeight - itemFrameHeight) / 2)
  else
    SetNPCDir(npcID)
    self:Destroy()
  end
end

function NpcServerDialog:NumberOfCell(frame)
  return #self._data
end

function NpcServerDialog:CellAtIndex(frame)
  return "npc.npcservercell"
end

function NpcServerDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function NpcServerDialog:GetTotalLength()
  return self._frame:GetTotalLength()
end

function NpcServerDialog:OnPanelNextClicked()
  self:Destroy()
end

function NpcServerDialog:OnBackBtnClicked()
  self:OnPanelNextClicked()
end

return NpcServerDialog
