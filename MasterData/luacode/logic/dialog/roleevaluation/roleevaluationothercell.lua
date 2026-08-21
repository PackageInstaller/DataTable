-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/roleevaluation/roleevaluationothercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local RoleEvaluationOtherCell = class("RoleEvaluationOtherCell", Dialog)
RoleEvaluationOtherCell.AssetBundleName = "ui/layouts.tujian"
RoleEvaluationOtherCell.AssetName = "AppraiseOthers"
RoleEvaluationOtherCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleEvaluationOtherCell
  ((RoleEvaluationOtherCell.super).Ctor)(self, ...)
end

RoleEvaluationOtherCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._roleImg = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._roleFrame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._roleName = self:GetChild("PlayerInfo/Name")
  self._talk = self:GetChild("Bubble")
  self._txt = self:GetChild("Bubble/Text")
  self._thumbUpBtn = self:GetChild("ThumbUpBtn")
  self._thumbUpBtnTxt = self:GetChild("ThumbUpBtn/Txt")
  if ((NekoData.BehaviorManager).BM_Game):IsGM() then
    self._roleHead = self:GetChild("PlayerInfo/HeadPhoto")
    ;
    (self._roleHead):Subscribe_PointerClickEvent(self.OnClickHeadPhoto, self)
  end
  ;
  (self._thumbUpBtn):Subscribe_PointerClickEvent(self.OnThumbUpBtnClicked, self)
  self._info_size_x = (self._txt):GetSize()
  self._talk_size_x = (self._talk):GetSize()
  self._cell_size_x = (self:GetRootWindow()):GetSize()
  self._talkHeight = self._talk_size_y * self._cell_size_offset_y + self._talk_size_offset_y
  self._infoHeight = self._info_size_y * self._talkHeight + self._info_size_offset_y
  self._reportBtn = self:GetChild("Bubble/ReportBtn")
  ;
  (self._txt):Subscribe_PointerClickEvent(self.OnTextClicked, self)
  ;
  (self._reportBtn):Subscribe_PointerClickEvent(self.OnReportBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

RoleEvaluationOtherCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

RoleEvaluationOtherCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : HeadPhotoTable, CImagePathTable, _ENV, HeadPhotoFrameTable
  self._data = data
  ;
  (self._reportBtn):SetActive(false)
  self._commmentKey = ((data.messageinfo).baseInfo).key
  local headPhotoRecord = HeadPhotoTable:GetRecorder(((data.messageinfo).baseInfo).userAvatarId)
  do
    if headPhotoRecord then
      if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._roleImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(((data.messageinfo).baseInfo).userFrameId)
    do
      if headPhotoFrameRecord then
        if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._roleFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      ;
      (self._roleName):SetText(((data.messageinfo).baseInfo).userName)
      ;
      (self._thumbUpBtnTxt):SetText(tostring(((data.messageinfo).baseInfo).likes))
      ;
      (self._txt):SetText(((data.messageinfo).baseInfo).comment)
      self._isThumbUp = false
      if (data.messageinfo).selfLike == 0 then
        (self._thumbUpBtn):SetSelected(false)
      else
        self._isThumbUp = true
        ;
        (self._thumbUpBtn):SetSelected(true)
      end
      local _, textheight = (self._txt):GetPreferredSize()
      if self._infoHeight < textheight then
        local delta = textheight - self._infoHeight + 10
        ;
        (self:GetRootWindow()):SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y + delta)
      else
        do
          ;
          (self:GetRootWindow()):SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y)
        end
      end
    end
  end
end

RoleEvaluationOtherCell.OnThumbUpBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._isThumbUp = not self._isThumbUp
  local protocol = (LuaNetManager.CreateProtocol)("protocol.card.clikecomment")
  if protocol then
    protocol.commentKey = self._commmentKey
    if self._isThumbUp then
      protocol.operate = 1
    else
      protocol.operate = 2
    end
    protocol.roleId = (self._delegate)._roleId
    protocol:Send()
  end
end

RoleEvaluationOtherCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV
  if eventName == "LikeChange" and self._commmentKey == arg.key then
    (self._thumbUpBtnTxt):SetText(tostring(arg.likes))
    ;
    (self._thumbUpBtn):SetSelected(self._isThumbUp)
  end
end

RoleEvaluationOtherCell.OnClickHeadPhoto = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local roleId = (self._delegate)._roleId
  local userId = ((NekoData.BehaviorManager).BM_Game):GetUserId()
  local commentKey = self._commmentKey
  local s = (string.format)("//delcomment %s %s %s", tostring(userId), tostring(commentKey), tostring(roleId))
  ;
  (self:GetRootWindow()):CopyToClipBoard(s)
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100201, {userId, commentKey, roleId})
end

RoleEvaluationOtherCell.OnTextClicked = function(self)
  -- function num : 0_7
  (self._reportBtn):SetActive(true)
end

RoleEvaluationOtherCell.OnReportBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local extra = {commentKey = self._commmentKey, commentPage = (((self._data).messageinfo).baseInfo).page, roleId = (self._delegate)._roleId}
  local data = {reportid = (((self._data).messageinfo).baseInfo).userId, nickname = (((self._data).messageinfo).baseInfo).userName, content = (((self._data).messageinfo).baseInfo).comment, time = (((self._data).messageinfo).baseInfo).time // 1000, extra = (JSON.encode)(extra), type = 1}
  ;
  ((DialogManager.CreateSingletonDialog)("report.reportplayerdialog")):SetData(data)
  ;
  (self._reportBtn):SetActive(false)
end

RoleEvaluationOtherCell.OnEveryWhereClick = function(self, args)
  -- function num : 0_9 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._reportBtn)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    (self._reportBtn):SetActive(false)
  end
end

return RoleEvaluationOtherCell

