-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/roleevaluation/roleevaluationmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CRoleRarityCfgTable = (BeanManager.GetTableByName)("role.croleraritycfg")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CommentsEnum = (LuaNetManager.GetProtocolDef)("protocol.card.cgetcomments")
local RoleEvaluationMainDialog = class("RoleEvaluationMainDialog", Dialog)
RoleEvaluationMainDialog.AssetBundleName = "ui/layouts.tujian"
RoleEvaluationMainDialog.AssetName = "AppraiseMain"
RoleEvaluationMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleEvaluationMainDialog
  ((RoleEvaluationMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._messageInfo = {}
  self._userOwnMessage = nil
  self._maxIndex = nil
  self._commmentType = 0
  self._isMoveToTop = false
  self._selectReportContent = nil
  self._sendProtocol = false
end

RoleEvaluationMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  (self:GetRootWindow()):Subscribe_PointerDownEvent(nil, self)
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
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._sendBtn):Subscribe_PointerClickEvent(self.OnSendBtnClicked, self)
  ;
  (self._lastTimeBtn):Subscribe_PointerClickEvent(self.OnLastTimeBtnClicked, self)
  ;
  (self._hotMaxBtn):Subscribe_PointerClickEvent(self.OnHotMaxBtnClicked, self)
  self._massageFrame = (TableFrame.Create)(self._messageArea, self, true, true)
end

RoleEvaluationMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._massageFrame):Destroy()
  if self._handler then
    (self._roleLive2D):Release(self._handler)
    self._handler = nil
  end
end

RoleEvaluationMainDialog.SetData = function(self, protocol)
  -- function num : 0_3 , upvalues : RoleConfigTable, CNpcShapeTable, CVocationCfgTable, _ENV, CRoleRarityCfgTable, CImagePathTable
  self._roleId = protocol.roleId
  local roleConfigRecord = RoleConfigTable:GetRecorder(self._roleId)
  local shapeRecord = CNpcShapeTable:GetRecorder(roleConfigRecord.shapeID)
  local vocationRecord = CVocationCfgTable:GetRecorder(roleConfigRecord.vocation)
  local jobText = (TextManager.GetText)(vocationRecord.nameTextID)
  local roleRarityRecord = CRoleRarityCfgTable:GetRecorder(roleConfigRecord.rarity)
  ;
  (self._roleRank):SetActive(self._roleId > 1)
  if self._roleId == 1 then
    (self._roleName):SetText((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username)
  else
    (self._roleName):SetText((TextManager.GetText)(roleConfigRecord.nameTextID))
    if not CImagePathTable:GetRecorder(roleRarityRecord.imgbigid) then
      local rankImgCfg = DataCommon.DefaultImageAsset
    end
    ;
    (self._roleRank):SetSprite(rankImgCfg.assetBundle, rankImgCfg.assetName)
  end
  ;
  (self._roleJobText):SetText(jobText)
  local jobImgCfg = nil
  if roleConfigRecord.rarity == 1 then
    if not CImagePathTable:GetRecorder(vocationRecord.imgR) then
      jobImgCfg = DataCommon.DefaultImageAsset
      if roleConfigRecord.rarity == 2 then
        if not CImagePathTable:GetRecorder(vocationRecord.imgSR) then
          jobImgCfg = DataCommon.DefaultImageAsset
          if roleConfigRecord.rarity == 3 then
            if not CImagePathTable:GetRecorder(vocationRecord.imgSSR) then
              jobImgCfg = DataCommon.DefaultImageAsset
              if roleConfigRecord.rarity == 4 then
                if not CImagePathTable:GetRecorder(vocationRecord.imgUR) then
                  jobImgCfg = DataCommon.DefaultImageAsset
                  if roleConfigRecord.rarity == 5 and not CImagePathTable:GetRecorder(vocationRecord.imgEX) then
                    jobImgCfg = DataCommon.DefaultImageAsset
                  end
                  ;
                  (self._roleJobImg):SetSprite(jobImgCfg.assetBundle, jobImgCfg.assetName)
                  local roleData = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(self._roleId)
                  if roleData:GetDefaultFashion() > 0 then
                    shapeRecord = roleData:GetNpcShapeRecord()
                  end
                  if roleData:IsFashionLive2D() and (Live2DManager.CanUse)() and shapeRecord.live2DPrefabName and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName and shapeRecord.live2DAssetBundleName ~= "" and not self._handler then
                    (self._rolePhoto):SetActive(false)
                    self._handler = (self._roleLive2D):AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
                  end
                  if not CImagePathTable:GetRecorder(shapeRecord.lihuiID) then
                    local lihuiImage = DataCommon.DefaultImageAsset
                  end
                  ;
                  (self._rolePhoto):SetActive(true)
                  ;
                  (self._rolePhoto):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
                  do
                    local scale = shapeRecord.photoScale
                    ;
                    (self._rolePhoto):SetLocalScale(scale, scale, scale)
                    ;
                    (self._rolePhoto):SetAnchoredPosition((shapeRecord.photoLocation)[1], (shapeRecord.photoLocation)[2])
                    if self._commmentType ~= protocol.commentType then
                      self._commmentType = protocol.commentType
                      self._messageInfo = {}
                      self._maxIndex = 0
                    end
                    if protocol.commentType == 1 then
                      (self._hotMaxBtn):SetSelected(true)
                      ;
                      (self._lastTimeBtn):SetSelected(false)
                    elseif protocol.commentType == 2 then
                      (self._hotMaxBtn):SetSelected(false)
                      ;
                      (self._lastTimeBtn):SetSelected(true)
                    end
                    if protocol.userComment and ((protocol.userComment).baseInfo).userId ~= 0 then
                      self._userOwnMessage = protocol.userComment
                    end
                    self._sendProtocol = false
                    -- DECOMPILER ERROR at PC267: Unhandled construct in 'MakeBoolean' P1

                    if not protocol.firstIndex and (table.nums)(protocol.comments) > 0 then
                      for i,v in pairs(protocol.comments) do
                        if self._userOwnMessage and ((self._userOwnMessage).baseInfo).userId == (v.baseInfo).userId then
                          do
                            (table.insert)(self._messageInfo, 1, v)
                            self._maxIndex = self._maxIndex + 1
                            -- DECOMPILER ERROR at PC288: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC288: LeaveBlock: unexpected jumping out IF_STMT

                          end
                        end
                      end
                      ;
                      (self._massageFrame):ReloadAllCell()
                    end
                    while protocol.firstIndex <= self._maxIndex do
                      (table.remove)(self._messageInfo, 1)
                      self._maxIndex = self._maxIndex - 1
                    end
                    for k,v in pairs(protocol.comments) do
                      if self._userOwnMessage and ((self._userOwnMessage).baseInfo).userId == (v.baseInfo).userId then
                        do
                          (table.insert)(self._messageInfo, 1, v)
                          ;
                          (self._massageFrame):InsertCellsAtIndex({1})
                          self._maxIndex = self._maxIndex + 1
                          -- DECOMPILER ERROR at PC337: LeaveBlock: unexpected jumping out IF_THEN_STMT

                          -- DECOMPILER ERROR at PC337: LeaveBlock: unexpected jumping out IF_STMT

                        end
                      end
                    end
                    -- DECOMPILER ERROR: 30 unprocessed JMP targets
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

RoleEvaluationMainDialog.DeleteComment = function(self)
  -- function num : 0_4
  self._userOwnMessage = nil
  self._maxIndex = self._maxIndex - 1
  ;
  (self._massageFrame):ReloadAllCell()
end

RoleEvaluationMainDialog.NewComment = function(self, userComment)
  -- function num : 0_5
  (self._input):SetText("")
  self._userOwnMessage = userComment
  self._maxIndex = self._maxIndex + 1
  ;
  (self._massageFrame):ReloadAllCell()
end

RoleEvaluationMainDialog.RefreshOtherCommentLikeState = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in pairs(self._messageInfo) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

    if (v.baseInfo).key == protocol.key then
      (v.baseInfo).likes = protocol.likes
    end
  end
  ;
  (self._massageFrame):FireEvent("LikeChange", {key = protocol.key, likes = protocol.likes})
end

RoleEvaluationMainDialog.OnSprintTaskEndDrag = function(self)
  -- function num : 0_7
  do
    if self._needUpdate then
      local cellNum = self:NumberOfCell()
      if self._lastCellNum and self._lastCellNum < cellNum then
        (self._massageFrame):MoveDownToIndex(cellNum - self._lastCellNum)
      end
    end
    self._needUpdate = false
  end
end

RoleEvaluationMainDialog.OnFrameBeginDrag = function(self, frame)
  -- function num : 0_8
  self._canSend = true
  self._needUpdate = false
end

RoleEvaluationMainDialog.OnCurPosChange = function(self, frame, tag)
  -- function num : 0_9 , upvalues : _ENV
  if not self._sendProtocol and self._canSend and (not (self._massageFrame):GetDownIndex() or (self._massageFrame):GetDownIndex() == 1) then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.card.cgetcomments")
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

RoleEvaluationMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_10 , upvalues : _ENV
  if self._userOwnMessage then
    return 1 + (table.nums)(self._messageInfo)
  else
    return (table.nums)(self._messageInfo)
  end
end

RoleEvaluationMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_11 , upvalues : _ENV
  if self._userOwnMessage then
    if index == 1 + (table.nums)(self._messageInfo) then
      return "roleevaluation.roleevaluationmecell"
    else
      return "roleevaluation.roleevaluationothercell"
    end
  else
    return "roleevaluation.roleevaluationothercell"
  end
end

RoleEvaluationMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12 , upvalues : _ENV
  if self._userOwnMessage then
    if index == 1 + (table.nums)(self._messageInfo) then
      local temp = {}
      temp.messageinfo = self._userOwnMessage
      return temp
    else
      do
        do
          local temp = {}
          temp.messageinfo = (self._messageInfo)[index]
          do return temp end
          local temp = {}
          temp.messageinfo = (self._messageInfo)[index]
          do return temp end
        end
      end
    end
  end
end

RoleEvaluationMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

RoleEvaluationMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

RoleEvaluationMainDialog.OnSendBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV, CVarConfig
  if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarConfig:GetRecorder(92)).Value == "0" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100336)
    return 
  end
  local msg = (self._input):GetText()
  local wordCount = (utf8.len)(msg)
  if wordCount > 35 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100123)
    return 
  end
  if wordCount == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100125)
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.card.cnewcomment")
  if protocol then
    protocol.roleId = self._roleId
    protocol.comment = (self._input):GetText()
    protocol:Send()
  end
end

RoleEvaluationMainDialog.OnLastTimeBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self._commmentType == 2 then
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.card.cgetcomments")
  if protocol then
    protocol.roleId = self._roleId
    protocol.commentType = 2
    protocol.lastIndex = 0
    protocol:Send()
  end
end

RoleEvaluationMainDialog.OnHotMaxBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self._commmentType == 1 then
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.card.cgetcomments")
  if protocol then
    protocol.roleId = self._roleId
    protocol.commentType = 1
    protocol.lastIndex = 0
    protocol:Send()
  end
end

return RoleEvaluationMainDialog

