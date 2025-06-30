-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/whitevalentine/whitevalentinemaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local Skill = require("logic.manager.experimental.types.skill")
local CRoleFaceCfg = (BeanManager.GetTableByName)("welfare.crolefacecfg")
local CRoleFaceText = (BeanManager.GetTableByName)("welfare.crolefacetext")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local WhiteValentineMainDialog = class("WhiteValentineMainDialog", Dialog)
WhiteValentineMainDialog.AssetBundleName = "ui/layouts.activityhud"
WhiteValentineMainDialog.AssetName = "ActivityValentinesMail"
WhiteValentineMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : WhiteValentineMainDialog
  ((WhiteValentineMainDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._itemList = {}
end

WhiteValentineMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._normal = self:GetChild("BackImage")
  self._normal_rolePhoto = self:GetChild("BackImage/WhiteBack")
  self._special = self:GetChild("ActivityValentinesSpecial")
  self._special_rolePhoto = self:GetChild("ActivityValentinesSpecial/BackImage/WhiteBack")
  self._title = self:GetChild("Name")
  self._text = self:GetChild("TextTitle")
  self._description = self:GetChild("Text")
  self._getBtn = self:GetChild("GoBtn")
  self._cellPanel = self:GetChild("Frame")
  self._itemFrame = (TableFrame.Create)(self._cellPanel, self, false, false)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self:Init()
end

WhiteValentineMainDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._itemFrame):Destroy()
end

WhiteValentineMainDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CRoleFaceCfg, Item, Role, Skill, CNpcShapeTable, CImagePathTable, CRoleFaceText
  while (self._itemList)[#self._itemList] do
    (table.remove)(self._itemList, #self._itemList)
  end
  self._data = ((NekoData.BehaviorManager).BM_Activity):GetWhiteValentine()
  local record = CRoleFaceCfg:GetRecorder((self._data).id)
  if record then
    for i,v in ipairs(record.reward) do
      (table.insert)(self._itemList, {item = (Item.Create)(v), num = (record.rewardNum)[i]})
    end
    ;
    (self._normal):SetActive(record.activeType == 1)
    ;
    (self._special):SetActive(record.activeType ~= 1)
    local role = nil
    if record.activeType == 1 then
      role = (Role.Create)(record.textID)
    elseif (self._data).roleId ~= 0 then
      role = (Role.Create)((self._data).roleId)
    else
      local roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
      ;
      (table.sort)(roleList, function(a, b)
    -- function num : 0_3_0 , upvalues : _ENV, Skill
    local a_relationLv, b_relationLv = a:GetRelationLevel(), b:GetRelationLevel()
    if a:GetIsLeader() then
      a_relationLv = -1
    end
    if b:GetIsLeader() then
      b_relationLv = -1
    end
    if a_relationLv == b_relationLv then
      local a_breakLv, b_breakLv = a:GetBreakLv(), b:GetBreakLv()
      if a_breakLv == b_breakLv then
        local a_lv, b_lv = a:GetLevel(), b:GetLevel()
        if a_lv == b_lv then
          local a_skillList, b_skillList = a:GetShowSkillData(), b:GetShowSkillData()
          local a_sumSkillLv, b_sumSkillLv = 0, 0
          for i,v in ipairs(a_skillList) do
            if not v.skillItemId then
              do
                local skill = (Skill.Create)(v.skillId, not v.unlock or true)
                a_sumSkillLv = a_sumSkillLv + skill:GetSkillLevel()
                -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
          for i,v in ipairs(b_skillList) do
            if not v.skillItemId then
              do
                local skill = (Skill.Create)(v.skillId, not v.unlock or true)
                b_sumSkillLv = b_sumSkillLv + skill:GetSkillLevel()
                -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
          if a_sumSkillLv == b_sumSkillLv then
            local a_rarity, b_rarity = a:GetRarityId(), b:GetRarityId()
            if a_rarity == 5 then
              a_rarity = 0
            end
            if b_rarity == 5 then
              b_rarity = 0
            end
            if a_rarity == b_rarity then
              local a_id, b_id = a:GetId(), b:GetId()
              return a_id < b_id
            else
              return b_rarity < a_rarity
            end
          else
            return b_sumSkillLv < a_sumSkillLv
          end
        else
          return b_lv < a_lv
        end
      else
        return b_breakLv < a_breakLv
      end
    else
      return b_relationLv < a_relationLv
    end
    -- DECOMPILER ERROR: 12 unprocessed JMP targets
  end
)
      role = roleList[1]
    end
    if role then
      local roleConfigRecord = role:GetRoleConfig()
      local shapeRecord = CNpcShapeTable:GetRecorder(roleConfigRecord.shapeID)
      if not CImagePathTable:GetRecorder(shapeRecord.lihuiID) then
        local recorder = DataCommon.DefaultImageAsset
      end
      ;
      (self._normal_rolePhoto):SetSprite(recorder.assetBundle, recorder.assetName)
      ;
      (self._special_rolePhoto):SetSprite(recorder.assetBundle, recorder.assetName)
      local textRecord = CRoleFaceText:GetRecorder(role:GetId())
      if not textRecord then
        textRecord = CRoleFaceText:GetRecorder(1)
      end
      if record.activeType == 1 then
        (self._description):SetText((TextManager.GetText)(textRecord.textID3))
      elseif (self._data).roleId == 0 then
        (self._description):SetText((TextManager.GetText)(textRecord.textID1))
      else
        (self._description):SetText((TextManager.GetText)(textRecord.textID2))
      end
      LogInfoFormat("WhiteValentineMainDialog", "roleId: %s", role:GetId())
      if record.activeType ~= 1 and (self._data).roleId == 0 then
        local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.crecordwhitevalentineroleid")
        protocol.roleId = role:GetId()
        protocol:Send()
      end
    else
      LogError("Data Error.")
    end
  else
    LogErrorFormat("WhiteValentineMainDialog", "id %s dont have record in CRoleFaceCfg", (self._data).id)
    self:Destroy()
  end
  ;
  (self._itemFrame):ReloadAllCell()
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1725))
  local str = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username
  ;
  (self._text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1726, {str}))
  -- DECOMPILER ERROR: 13 unprocessed JMP targets
end

WhiteValentineMainDialog.OnGetBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceivewhitevalentinereward")
  protocol.id = (self._data).id
  protocol:Send()
end

WhiteValentineMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._itemList
end

WhiteValentineMainDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "welfare.returnwelfare.returnwelfareactivitymailitemcell"
end

WhiteValentineMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._itemList)[index]
end

return WhiteValentineMainDialog

