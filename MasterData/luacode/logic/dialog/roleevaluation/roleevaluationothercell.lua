local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local RoleEvaluationOtherCell = class("RoleEvaluationOtherCell", Dialog)
RoleEvaluationOtherCell.AssetBundleName = "ui/layouts.tujian"
RoleEvaluationOtherCell.AssetName = "AppraiseOthers"

function RoleEvaluationOtherCell:Ctor(...)
  RoleEvaluationOtherCell.super.Ctor(self, ...)
end

function RoleEvaluationOtherCell:OnCreate()
  self._roleImg = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._roleFrame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._roleName = self:GetChild("PlayerInfo/Name")
  self._talk = self:GetChild("Bubble")
  self._txt = self:GetChild("Bubble/Text")
  self._thumbUpBtn = self:GetChild("ThumbUpBtn")
  self._thumbUpBtnTxt = self:GetChild("ThumbUpBtn/Txt")
  if NekoData.BehaviorManager.BM_Game:IsGM() then
    self._roleHead = self:GetChild("PlayerInfo/HeadPhoto")
    self._roleHead:Subscribe_PointerClickEvent(self.OnClickHeadPhoto, self)
  end
  self._thumbUpBtn:Subscribe_PointerClickEvent(self.OnThumbUpBtnClicked, self)
  self._info_size_x, self._info_size_offset_x, self._info_size_y, self._info_size_offset_y = self._txt:GetSize()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self._talk:GetSize()
  self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y = self:GetRootWindow():GetSize()
  self._talkHeight = self._talk_size_y * self._cell_size_offset_y + self._talk_size_offset_y
  self._infoHeight = self._info_size_y * self._talkHeight + self._info_size_offset_y
  self._reportBtn = self:GetChild("Bubble/ReportBtn")
  self._txt:Subscribe_PointerClickEvent(self.OnTextClicked, self)
  self._reportBtn:Subscribe_PointerClickEvent(self.OnReportBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function RoleEvaluationOtherCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function RoleEvaluationOtherCell:RefreshCell(data)
  self._data = data
  self._reportBtn:SetActive(false)
  self._commmentKey = data.messageinfo.baseInfo.key
  local headPhotoRecord = HeadPhotoTable:GetRecorder(data.messageinfo.baseInfo.userAvatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._roleImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.messageinfo.baseInfo.userFrameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._roleFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._roleName:SetText(data.messageinfo.baseInfo.userName)
  self._thumbUpBtnTxt:SetText(tostring(data.messageinfo.baseInfo.likes))
  self._txt:SetText(data.messageinfo.baseInfo.comment)
  self._isThumbUp = false
  if data.messageinfo.selfLike == 0 then
    self._thumbUpBtn:SetSelected(false)
  else
    self._isThumbUp = true
    self._thumbUpBtn:SetSelected(true)
  end
  local _, textheight = self._txt:GetPreferredSize()
  if textheight > self._infoHeight then
    local delta = textheight - self._infoHeight + 10
    self:GetRootWindow():SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y + delta)
  else
    self:GetRootWindow():SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y)
  end
end

function RoleEvaluationOtherCell:OnThumbUpBtnClicked()
  self._isThumbUp = not self._isThumbUp
  local protocol = LuaNetManager.CreateProtocol("protocol.card.clikecomment")
  if protocol then
    protocol.commentKey = self._commmentKey
    if self._isThumbUp then
      protocol.operate = 1
    else
      protocol.operate = 2
    end
    protocol.roleId = self._delegate._roleId
    protocol:Send()
  end
end

function RoleEvaluationOtherCell:OnEvent(eventName, arg)
  if eventName == "LikeChange" and self._commmentKey == arg.key then
    self._thumbUpBtnTxt:SetText(tostring(arg.likes))
    self._thumbUpBtn:SetSelected(self._isThumbUp)
  end
end

function RoleEvaluationOtherCell:OnClickHeadPhoto()
  local roleId = self._delegate._roleId
  local userId = NekoData.BehaviorManager.BM_Game:GetUserId()
  local commentKey = self._commmentKey
  local s = string.format("//delcomment %s %s %s", tostring(userId), tostring(commentKey), tostring(roleId))
  self:GetRootWindow():CopyToClipBoard(s)
  NekoData.BehaviorManager.BM_Message:SendMessageById(100201, {
    userId,
    commentKey,
    roleId
  })
end

function RoleEvaluationOtherCell:OnTextClicked()
  self._reportBtn:SetActive(true)
end

function RoleEvaluationOtherCell:OnReportBtnClicked()
  local extra = {
    commentKey = self._commmentKey,
    commentPage = self._data.messageinfo.baseInfo.page,
    roleId = self._delegate._roleId
  }
  local data = {
    reportid = self._data.messageinfo.baseInfo.userId,
    nickname = self._data.messageinfo.baseInfo.userName,
    content = self._data.messageinfo.baseInfo.comment,
    time = self._data.messageinfo.baseInfo.time // 1000,
    extra = JSON.encode(extra),
    type = 1
  }
  DialogManager.CreateSingletonDialog("report.reportplayerdialog"):SetData(data)
  self._reportBtn:SetActive(false)
end

function RoleEvaluationOtherCell:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self._reportBtn._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self._reportBtn:SetActive(false)
  end
end

return RoleEvaluationOtherCell
