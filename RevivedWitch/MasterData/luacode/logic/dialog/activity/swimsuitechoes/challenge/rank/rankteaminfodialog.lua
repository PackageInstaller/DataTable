-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/rank/rankteaminfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local csrchallengerank = (BeanManager.GetTableByName)("activity.csrchallengerank")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RankType = (LuaNetManager.GetBeanDef)("protocol.ranking.ranktype")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RankTeamInfoDialog = class("RankTeamInfoDialog", Dialog)
RankTeamInfoDialog.AssetBundleName = "ui/layouts.activitysummer2"
RankTeamInfoDialog.AssetName = "ActivitySummer2XiGuaTeam"
RankTeamInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RankTeamInfoDialog
  ((RankTeamInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._levelId = 0
  self._protoData = nil
  self._roleList = {}
end

RankTeamInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._name = self:GetChild("TeamBack/PlayerInfo/NameBack/Name")
  self._photo = self:GetChild("TeamBack/PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("TeamBack/PlayerInfo/HeadPhoto/Frame")
  self._level = self:GetChild("TeamBack/PlayerInfo/LvBack/Level")
  self._bossIcon = self:GetChild("TeamBack/Team/Team/Boss")
  self._bossName = self:GetChild("TeamBack/Team/Team/Text")
  self._time = self:GetChild("TeamBack/Team/Time")
  ;
  (self:GetChild("TeamBack/Team/Txt2")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2156))
  self._difficultyTxt2 = self:GetChild("TeamBack/Team/Time/DifficultyTxt")
  self._difficultyTxt = self:GetChild("TeamBack/Team/Level")
  self._rank = self:GetChild("TeamBack/Team/Rank")
  self._panel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._alternatePanel = self:GetChild("TeamBack/CharacterPanel/Frame2")
  self._frame = (TableFrame.Create)(self._panel, self, false, false, false)
  self._alternateFrame = (TableFrame.Create)(self._alternatePanel, self, false, false, false)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshData, Common.n_ReceiveOtherUserLineupData, nil)
end

RankTeamInfoDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
  ;
  (self._alternateFrame):Destroy()
end

RankTeamInfoDialog.InitDataInfo = function(self, data, levelId)
  -- function num : 0_3 , upvalues : HeadPhotoTable, CImagePathTable, _ENV, HeadPhotoFrameTable, csrchallengerank, CNPCShape, RankType
  self._levelId = levelId
  ;
  (self._name):SetText((data.baseUserData).userName)
  local headPhotoRecord = HeadPhotoTable:GetRecorder((data.baseUserData).avatarId)
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      ;
      (self._photo):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
      LogErrorFormat("RankTeamInfoDialog", "headPhotoRecord not found. avatarId = %s", (data.baseUserData).avatarId)
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((data.baseUserData).frameId)
      if headPhotoFrameRecord then
        if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        do
          ;
          (self._photoFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
          LogErrorFormat("RankTeamInfoDialog", "headPhotoFrameRecord not found. frameId = %s", (data.baseUserData).frameId)
          ;
          (self._level):SetText((data.baseUserData).userLv)
          local rankRecord = csrchallengerank:GetRecorder(levelId)
          local npcShapeRecorder = CNPCShape:GetRecorder(rankRecord.bossshapeid)
          if npcShapeRecorder then
            if self._handler ~= 0 then
              (self._bossIcon):ReleaseModel(self._handler)
              self._handler = 0
            end
            self._handler = (self._bossIcon):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
            local list = (string.split)(rankRecord.bosspos, ",")
            local position = {x = tonumber(list[1]), y = tonumber(list[2])}
            local scale = tonumber(rankRecord.bossscale)
            ;
            (self._bossIcon):SetAnchoredPosition(position.x, position.y)
            ;
            (self._bossIcon):SetLocalScale(scale, scale, scale)
          end
          do
            ;
            (self._bossName):SetText((TextManager.GetText)(rankRecord.nameTextID))
            ;
            (self._rank):SetText(data.rank)
            ;
            (self._name):SetText((data.baseUserData).userName)
            local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1107)).msgTextID
            str = (TextManager.GetText)(str)
            local num = (data.undrPanelData).passTime / 1000
            local ret = ((NekoData.BehaviorManager).BM_Game):GetPreciseDecimal(num, 1)
            str = (string.gsub)(str, "%$parameter1%$", ret)
            ;
            (self._time):SetText(str)
            ;
            (self._difficultyTxt2):SetActive(false)
            ;
            (self._difficultyTxt):SetText((data.undrPanelData).score)
            self._roleList = {}
            for index = #(data.undrPanelData).roleIdList, 1, -1 do
              local info = {}
              info.roleId = ((data.undrPanelData).roleIdList)[index]
              info.level = ((data.undrPanelData).roleLvList)[index]
              info.breakLv = ((data.undrPanelData).roleBreakList)[index]
              info.userId = (data.baseUserData).userId
              info.skin = ((data.undrPanelData).roleSkinList)[index]
              info.runeLevel = ((data.undrPanelData).runeLevelList)[index]
              ;
              (table.insert)(self._roleList, info)
            end
            local userId = ((self._roleList)[1]).userId
            local csend = (LuaNetManager.CreateProtocol)("protocol.ranking.cuserlineupdata")
            csend.uniqueId = userId
            csend.rankType = RankType.SUMMER_ECHO
            csend.rankId = tostring((DataCommon.Activities).SummerEchoes)
            csend:Send()
            ;
            (self._frame):ReloadAllCell()
            ;
            (self._alternateFrame):ReloadAllCell()
          end
        end
      end
    end
  end
end

RankTeamInfoDialog.RefreshData = function(self, notification)
  -- function num : 0_4 , upvalues : RankType, _ENV
  if RankType.SUMMER_ECHO == (notification.userInfo).rankType and tonumber((notification.userInfo).rankId) == (DataCommon.Activities).SummerEchoes then
    self._protoData = notification
    local roles = ((notification.userInfo).lineup).roles
    for k,v in pairs(roles) do
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

      ((self._roleList)[6 - k + 1]).skin = v.skin
    end
  end
  do
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._alternateFrame):ReloadAllCell()
  end
end

RankTeamInfoDialog.GetRoleList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local temp = {}
  for i,v in ipairs(self._roleList) do
    (table.insert)(temp, v)
  end
  return temp
end

RankTeamInfoDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return 3
end

RankTeamInfoDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_7
  if helper == self._frame then
    return "mainline.bossrush.bossrushrankteamcell"
  else
    return "mainline.bossrush.bossrushrankteamalternatecell"
  end
end

RankTeamInfoDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_8
  if helper == self._frame then
    return (self._roleList)[index + 3]
  else
    return (self._roleList)[index]
  end
end

RankTeamInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

RankTeamInfoDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return RankTeamInfoDialog

