-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/chrismascall/callrankcellhelper.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CallRankCellHelper = class("CallRankCellHelper")
CallRankCellHelper.Ctor = function(self, rootElement, single)
  -- function num : 0_0 , upvalues : _ENV
  self._rootElement = rootElement
  self._single = single
  self._rankNum = (self._rootElement):FindChild("Back/RankNum/Num")
  self._headFrame = (self._rootElement):FindChild("Back/HeadPhoto/Frame")
  self._headPhoto = (self._rootElement):FindChild("Back/HeadPhoto/Photo")
  self._userName = (self._rootElement):FindChild("Back/NameBack/Name")
  self._callScoreNum = (self._rootElement):FindChild("Back/ExpNum")
  self._rankBack = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R7 in 'UnsetPending'

      (self._rankBack)[i] = (self._rootElement):FindChild("Rank" .. tostring(i))
    end
  end
  self._singleBack = (self._rootElement):FindChild("Rank5")
  self._rankNumImgs = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

    (self._rankNumImgs)[i] = (self._rootElement):FindChild("Back/Rank" .. tostring(i))
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._rankNumImgs)[4] = self._rankNum
  ;
  (self._headPhoto):Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._cellItem = {}
  for i = 1, 4 do
    -- DECOMPILER ERROR at PC82: Confused about usage of register: R7 in 'UnsetPending'

    (self._cellItem)[i] = {}
    -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._cellItem)[i]).root = (self._rootElement):FindChild("CellItem" .. tostring(i))
    -- DECOMPILER ERROR at PC105: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._cellItem)[i]).frame = (self._rootElement):FindChild("CellItem" .. tostring(i) .. "/Panel/ItemCell/_BackGround/Frame")
    -- DECOMPILER ERROR at PC117: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._cellItem)[i]).count = (self._rootElement):FindChild("CellItem" .. tostring(i) .. "/Panel/ItemCell/_Count")
    -- DECOMPILER ERROR at PC129: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._cellItem)[i]).icon = (self._rootElement):FindChild("CellItem" .. tostring(i) .. "/Panel/ItemCell/_BackGround/Icon")
    -- DECOMPILER ERROR at PC132: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._cellItem)[i]).item = nil
    ;
    (((self._cellItem)[i]).root):Subscribe_PointerClickEvent(function()
    -- function num : 0_0_0 , upvalues : self, i
    self:OnCellClick(i)
  end
, self)
  end
end

CallRankCellHelper.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

CallRankCellHelper.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : _ENV, CStringRes, HeadPhotoFrameTable, CImagePathTable, HeadPhotoTable, Item
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._data = data
  self._inRank = ((self._data).remoteData).rank ~= -1
  local userName, score, rank, frameId, avatarId = nil, nil, nil, nil, nil
  if not self._inRank then
    local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
    userName = userInfo.username
    score = (self._bm):GetNowScore()
    rank = (TextManager.GetText)((CStringRes:GetRecorder(1681)).msgTextID)
    frameId = userInfo.frameId
    avatarId = userInfo.avatarId
  else
    userName = (((self._data).remoteData).baseUserData).userName
    score = ((self._data).remoteData).score
    rank = ((self._data).remoteData).rank
    frameId = (((self._data).remoteData).baseUserData).frameId
    avatarId = (((self._data).remoteData).baseUserData).avatarId
  end
  for index,_ in ipairs(self._rankBack) do
    local isActive = ((self._data).remoteData).rank == index or (index == 4 and ((self._data).remoteData).rank < 4 and ((self._data).remoteData).rank == -1)
    if self._single then
      ((self._rankBack)[index]):SetActive(false)
      ;
      (self._singleBack):SetActive(true)
    else
      ((self._rankBack)[index]):SetActive(isActive)
      ;
      (self._singleBack):SetActive(false)
    end
    ;
    ((self._rankNumImgs)[index]):SetActive(isActive)
  end
  ;
  (self._rankNum):SetText(rank)
  ;
  (self._callScoreNum):SetText(score)
  ;
  (self._userName):SetText(userName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(frameId)
  if headPhotoFrameRecord then
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._headFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    LogErrorFormat("CallRankCell", "headPhotoFrameRecord not found. frameId = %s", frameId)
  end
  local headPhotoRecord = HeadPhotoTable:GetRecorder(avatarId)
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._headPhoto):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    LogErrorFormat("CallRankCell", "headPhotoRecord not found. avatarId = %s", avatarId)
  end
  if (self._data).localData then
    local rewardLen = #((self._data).localData).rankRewardId
    local cellItemLen = #self._cellItem
    local startIndex = cellItemLen - rewardLen + 1
    for index,_ in ipairs(self._cellItem) do
      if index < startIndex then
        (((self._cellItem)[index]).root):SetActive(false)
      else
        (((self._cellItem)[index]).root):SetActive(true)
        -- DECOMPILER ERROR at PC242: Confused about usage of register: R17 in 'UnsetPending'

        ;
        ((self._cellItem)[index]).item = (Item.Create)((((self._data).localData).rankRewardId)[index - startIndex + 1])
        local imageRecord = (((self._cellItem)[index]).item):GetIcon()
        ;
        (((self._cellItem)[index]).icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        imageRecord = (((self._cellItem)[index]).item):GetPinJiImage()
        ;
        (((self._cellItem)[index]).frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (((self._cellItem)[index]).count):SetNumber((((self._data).localData).rankRewardNum)[index - startIndex + 1])
      end
    end
  else
    for index,_ in ipairs(self._cellItem) do
      (((self._cellItem)[index]).root):SetActive(false)
    end
  end
  -- DECOMPILER ERROR: 19 unprocessed JMP targets
end

CallRankCellHelper.OnCellClick = function(self, index)
  -- function num : 0_3 , upvalues : _ENV
  local width, height = (((self._cellItem)[index]).root):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = ((self._cellItem)[index]).item})
    tipsDialog:SetTipsPosition(width, height, (((self._cellItem)[index]).root):GetLocalPointInUiRootPanel())
  end
end

CallRankCellHelper.OnHeadPhotoClicked = function(self)
  -- function num : 0_4
  if self._inRank then
    (self._bm):SendCLookOtherInfo((((self._data).remoteData).baseUserData).userId)
  end
end

return CallRankCellHelper

