local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CRoleRarityCfgTable = BeanManager.GetTableByName("role.croleraritycfg")
local CVocationCfgTable = BeanManager.GetTableByName("role.cvocationcfg")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local CommentsEnum = LuaNetManager.GetProtocolDef("protocol.card.cgetcomments")
local RoleEvaluationMainDialog = class("RoleEvaluationMainDialog", Dialog)
RoleEvaluationMainDialog.AssetBundleName = "ui/layouts.tujian"
RoleEvaluationMainDialog.AssetName = "AppraiseMain"

function RoleEvaluationMainDialog:Ctor(...)
  RoleEvaluationMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._messageInfo = {}
  self._userOwnMessage = nil
  self._maxIndex = nil
  self._commmentType = 0
  self._isMoveToTop = false
  self._selectReportContent = nil
  self._sendProtocol = false
end

function RoleEvaluationMainDialog:OnCreate()
  self:GetRootWindow():Subscribe_PointerDownEvent(nil, self)
  self._rolePanel = self:GetChild("Role")
  self._roleLive2D = self:GetChild("Role/Live2D")
  self._rolePhoto = self:GetChild("Role/Photo")
  self._roleName = self:GetChild("BackGround/UI/CharName/Back/Name")
  self._roleRank = self:GetChild("BackGround/UI/CharName/Rank")
  self._roleJobImg = self:GetChild("BackGround/UI/CharName/JobImg")
  self._roleJobText = self:GetChild("BackGround/UI/CharName/JobTxt")
  self._cvName = self:GetChild("BackGround/UI/CharName/CVName")
  self._artistName = self:GetChild("BackGround/UI/CharName/ArtistName")
  self._sendBtn = self:GetChild("BackGround/RightPanel/Down/SendBtn")
  self._input = self:GetChild("BackGround/RightPanel/Down/InputField")
  self._messageArea = self:GetChild("BackGround/RightPanel/MessageArea")
  self._lastTimeBtn = self:GetChild("BackGround/RightPanel/GroupBtn1")
  self._hotMaxBtn = self:GetChild("BackGround/RightPanel/GroupBtn2")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._sendBtn:Subscribe_PointerClickEvent(self.OnSendBtnClicked, self)
  self._lastTimeBtn:Subscribe_PointerClickEvent(self.OnLastTimeBtnClicked, self)
  self._hotMaxBtn:Subscribe_PointerClickEvent(self.OnHotMaxBtnClicked, self)
  self._massageFrame = TableFrame.Create(self._messageArea, self, true, true)
end

function RoleEvaluationMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._massageFrame:Destroy()
  if self._handler then
    self._roleLive2D:Release(self._handler)
    self._handler = nil
  end
end

function RoleEvaluationMainDialog:SetData(protocol)
  self._roleId = protocol.roleId
  local roleConfigRecord = RoleConfigTable:GetRecorder(self._roleId)
  local shapeRecord = CNpcShapeTable:GetRecorder(roleConfigRecord.shapeID)
  local vocationRecord = CVocationCfgTable:GetRecorder(roleConfigRecord.vocation)
  local jobText = TextManager.GetText(vocationRecord.nameTextID)
  local roleRarityRecord = CRoleRarityCfgTable:GetRecorder(roleConfigRecord.rarity)
  self._roleRank:SetActive(self._roleId > 1)
  if self._roleId == 1 then
    self._roleName:SetText(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username)
  else
    self._roleName:SetText(TextManager.GetText(roleConfigRecord.nameTextID))
    local rankImgCfg = CImagePathTable:GetRecorder(roleRarityRecord.imgbigid) or DataCommon.DefaultImageAsset
    self._roleRank:SetSprite(rankImgCfg.assetBundle, rankImgCfg.assetName)
  end
  self._roleJobText:SetText(jobText)
  local jobImgCfg
  if roleConfigRecord.rarity == 1 then
    jobImgCfg = CImagePathTable:GetRecorder(vocationRecord.imgR) or DataCommon.DefaultImageAsset
  elseif roleConfigRecord.rarity == 2 then
    jobImgCfg = CImagePathTable:GetRecorder(vocationRecord.imgSR) or DataCommon.DefaultImageAsset
  elseif roleConfigRecord.rarity == 3 then
    jobImgCfg = CImagePathTable:GetRecorder(vocationRecord.imgSSR) or DataCommon.DefaultImageAsset
  elseif roleConfigRecord.rarity == 4 then
    jobImgCfg = CImagePathTable:GetRecorder(vocationRecord.imgUR) or DataCommon.DefaultImageAsset
  elseif roleConfigRecord.rarity == 5 then
    jobImgCfg = CImagePathTable:GetRecorder(vocationRecord.imgEX) or DataCommon.DefaultImageAsset
  end
  self._roleJobImg:SetSprite(jobImgCfg.assetBundle, jobImgCfg.assetName)
  local roleData = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(self._roleId)
  if roleData:GetDefaultFashion() > 0 then
    shapeRecord = roleData:GetNpcShapeRecord()
  end
  if roleData:IsFashionLive2D() and Live2DManager.CanUse() and shapeRecord.live2DPrefabName and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName and shapeRecord.live2DAssetBundleName ~= "" then
    if not self._handler then
      self._rolePhoto:SetActive(false)
      self._handler = self._roleLive2D:AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
    end
  else
    local lihuiImage = CImagePathTable:GetRecorder(shapeRecord.lihuiID) or DataCommon.DefaultImageAsset
    self._rolePhoto:SetActive(true)
    self._rolePhoto:SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = shapeRecord.photoScale
    self._rolePhoto:SetLocalScale(scale, scale, scale)
    self._rolePhoto:SetAnchoredPosition(shapeRecord.photoLocation[1], shapeRecord.photoLocation[2])
  end
  if self._commmentType ~= protocol.commentType then
    self._commmentType = protocol.commentType
    self._messageInfo = {}
    self._maxIndex = 0
  end
  if protocol.commentType == 1 then
    self._hotMaxBtn:SetSelected(true)
    self._lastTimeBtn:SetSelected(false)
  elseif protocol.commentType == 2 then
    self._hotMaxBtn:SetSelected(false)
    self._lastTimeBtn:SetSelected(true)
  end
  if protocol.userComment and protocol.userComment.baseInfo.userId ~= 0 then
    self._userOwnMessage = protocol.userComment
  end
  self._sendProtocol = false
  if not protocol.firstIndex then
    if 0 < table.nums(protocol.comments) then
      for i, v in pairs(protocol.comments) do
        if self._userOwnMessage and self._userOwnMessage.baseInfo.userId == v.baseInfo.userId then
        else
          table.insert(self._messageInfo, 1, v)
        end
        self._maxIndex = self._maxIndex + 1
      end
      self._massageFrame:ReloadAllCell()
    end
  else
    while self._maxIndex >= protocol.firstIndex do
      table.remove(self._messageInfo, 1)
      self._maxIndex = self._maxIndex - 1
    end
    for k, v in pairs(protocol.comments) do
      if self._userOwnMessage and self._userOwnMessage.baseInfo.userId == v.baseInfo.userId then
      else
        table.insert(self._messageInfo, 1, v)
        self._massageFrame:InsertCellsAtIndex({1})
      end
      self._maxIndex = self._maxIndex + 1
    end
  end
end

function RoleEvaluationMainDialog:DeleteComment()
  self._userOwnMessage = nil
  self._maxIndex = self._maxIndex - 1
  self._massageFrame:ReloadAllCell()
end

function RoleEvaluationMainDialog:NewComment(userComment)
  self._input:SetText("")
  self._userOwnMessage = userComment
  self._maxIndex = self._maxIndex + 1
  self._massageFrame:ReloadAllCell()
end

function RoleEvaluationMainDialog:RefreshOtherCommentLikeState(protocol)
  for _, v in pairs(self._messageInfo) do
    if v.baseInfo.key == protocol.key then
      v.baseInfo.likes = protocol.likes
    end
  end
  self._massageFrame:FireEvent("LikeChange", {
    key = protocol.key,
    likes = protocol.likes
  })
end

function RoleEvaluationMainDialog:OnSprintTaskEndDrag()
  if self._needUpdate then
    local cellNum = self:NumberOfCell()
    if self._lastCellNum and cellNum > self._lastCellNum then
      self._massageFrame:MoveDownToIndex(cellNum - self._lastCellNum)
    end
  end
  self._needUpdate = false
end

function RoleEvaluationMainDialog:OnFrameBeginDrag(frame)
  self._canSend = true
  self._needUpdate = false
end

function RoleEvaluationMainDialog:OnCurPosChange(frame, tag)
  if not self._sendProtocol and self._canSend and (not self._massageFrame:GetDownIndex() or self._massageFrame:GetDownIndex() == 1) then
    local protocol = LuaNetManager.CreateProtocol("protocol.card.cgetcomments")
    if protocol then
      protocol.roleId = self._roleId
      protocol.commentType = self._commmentType
      protocol.lastIndex = self._maxIndex
      self._lastCellNum = self:NumberOfCell()
      protocol:Send()
      self._canSend = false
      self._sendProtocol = true
      self._needUpdate = true
    end
  end
end

function RoleEvaluationMainDialog:NumberOfCell(frame)
  if self._userOwnMessage then
    return 1 + table.nums(self._messageInfo)
  else
    return table.nums(self._messageInfo)
  end
end

function RoleEvaluationMainDialog:CellAtIndex(frame, index)
  if self._userOwnMessage then
    if index == 1 + table.nums(self._messageInfo) then
      return "roleevaluation.roleevaluationmecell"
    else
      return "roleevaluation.roleevaluationothercell"
    end
  else
    return "roleevaluation.roleevaluationothercell"
  end
end

function RoleEvaluationMainDialog:DataAtIndex(frame, index)
  if self._userOwnMessage then
    if index == 1 + table.nums(self._messageInfo) then
      local temp = {}
      temp.messageinfo = self._userOwnMessage
      return temp
    else
      local temp = {}
      temp.messageinfo = self._messageInfo[index]
      return temp
    end
  else
    local temp = {}
    temp.messageinfo = self._messageInfo[index]
    return temp
  end
end

function RoleEvaluationMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function RoleEvaluationMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function RoleEvaluationMainDialog:OnSendBtnClicked()
  if NekoData.BehaviorManager.BM_Game:IsGuest() and CVarConfig:GetRecorder(92).Value == "0" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100336)
    return
  end
  local msg = self._input:GetText()
  local wordCount = utf8.len(msg)
  if 35 < wordCount then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100123)
    return
  end
  if wordCount == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100125)
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.card.cnewcomment")
  if protocol then
    protocol.roleId = self._roleId
    protocol.comment = self._input:GetText()
    protocol:Send()
  end
end

function RoleEvaluationMainDialog:OnLastTimeBtnClicked()
  if self._commmentType == 2 then
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.card.cgetcomments")
  if protocol then
    protocol.roleId = self._roleId
    protocol.commentType = 2
    protocol.lastIndex = 0
    protocol:Send()
  end
end

function RoleEvaluationMainDialog:OnHotMaxBtnClicked()
  if self._commmentType == 1 then
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.card.cgetcomments")
  if protocol then
    protocol.roleId = self._roleId
    protocol.commentType = 1
    protocol.lastIndex = 0
    protocol:Send()
  end
end

return RoleEvaluationMainDialog
