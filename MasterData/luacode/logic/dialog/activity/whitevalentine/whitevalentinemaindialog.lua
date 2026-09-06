local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local Skill = require("logic.manager.experimental.types.skill")
local CRoleFaceCfg = BeanManager.GetTableByName("welfare.crolefacecfg")
local CRoleFaceText = BeanManager.GetTableByName("welfare.crolefacetext")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local WhiteValentineMainDialog = class("WhiteValentineMainDialog", Dialog)
WhiteValentineMainDialog.AssetBundleName = "ui/layouts.activityhud"
WhiteValentineMainDialog.AssetName = "ActivityValentinesMail"

function WhiteValentineMainDialog:Ctor(...)
  WhiteValentineMainDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._itemList = {}
end

function WhiteValentineMainDialog:OnCreate()
  self._normal = self:GetChild("BackImage")
  self._normal_rolePhoto = self:GetChild("BackImage/WhiteBack")
  self._special = self:GetChild("ActivityValentinesSpecial")
  self._special_rolePhoto = self:GetChild("ActivityValentinesSpecial/BackImage/WhiteBack")
  self._title = self:GetChild("Name")
  self._text = self:GetChild("TextTitle")
  self._description = self:GetChild("Text")
  self._getBtn = self:GetChild("GoBtn")
  self._cellPanel = self:GetChild("Frame")
  self._itemFrame = TableFrame.Create(self._cellPanel, self, false, false)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self:Init()
end

function WhiteValentineMainDialog:OnDestroy()
  self._itemFrame:Destroy()
end

function WhiteValentineMainDialog:Init()
  while self._itemList[#self._itemList] do
    table.remove(self._itemList, #self._itemList)
  end
  self._data = NekoData.BehaviorManager.BM_Activity:GetWhiteValentine()
  local record = CRoleFaceCfg:GetRecorder(self._data.id)
  if record then
    for i, v in ipairs(record.reward) do
      table.insert(self._itemList, {
        item = Item.Create(v),
        num = record.rewardNum[i]
      })
    end
    self._normal:SetActive(record.activeType == 1)
    self._special:SetActive(record.activeType ~= 1)
    local role
    if record.activeType == 1 then
      role = Role.Create(record.textID)
    elseif self._data.roleId ~= 0 then
      role = Role.Create(self._data.roleId)
    else
      local roleList = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
      table.sort(roleList, function(a, b)
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
              for i, v in ipairs(a_skillList) do
                if v.unlock then
                  local skill = Skill.Create(v.skillId, v.skillItemId or true)
                  a_sumSkillLv = a_sumSkillLv + skill:GetSkillLevel()
                end
              end
              for i, v in ipairs(b_skillList) do
                if v.unlock then
                  local skill = Skill.Create(v.skillId, v.skillItemId or true)
                  b_sumSkillLv = b_sumSkillLv + skill:GetSkillLevel()
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
                  return a_rarity > b_rarity
                end
              else
                return a_sumSkillLv > b_sumSkillLv
              end
            else
              return a_lv > b_lv
            end
          else
            return a_breakLv > b_breakLv
          end
        else
          return a_relationLv > b_relationLv
        end
      end)
      role = roleList[1]
    end
    if role then
      local roleConfigRecord = role:GetRoleConfig()
      local shapeRecord = CNpcShapeTable:GetRecorder(roleConfigRecord.shapeID)
      local recorder = CImagePathTable:GetRecorder(shapeRecord.lihuiID) or DataCommon.DefaultImageAsset
      self._normal_rolePhoto:SetSprite(recorder.assetBundle, recorder.assetName)
      self._special_rolePhoto:SetSprite(recorder.assetBundle, recorder.assetName)
      local textRecord = CRoleFaceText:GetRecorder(role:GetId())
      textRecord = textRecord or CRoleFaceText:GetRecorder(1)
      if record.activeType == 1 then
        self._description:SetText(TextManager.GetText(textRecord.textID3))
      elseif self._data.roleId == 0 then
        self._description:SetText(TextManager.GetText(textRecord.textID1))
      else
        self._description:SetText(TextManager.GetText(textRecord.textID2))
      end
      LogInfoFormat("WhiteValentineMainDialog", "roleId: %s", role:GetId())
      if record.activeType ~= 1 and self._data.roleId == 0 then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.crecordwhitevalentineroleid")
        protocol.roleId = role:GetId()
        protocol:Send()
      end
    else
      LogError("Data Error.")
    end
  else
    LogErrorFormat("WhiteValentineMainDialog", "id %s dont have record in CRoleFaceCfg", self._data.id)
    self:Destroy()
  end
  self._itemFrame:ReloadAllCell()
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1725))
  local str = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username
  self._text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1726, {str}))
end

function WhiteValentineMainDialog:OnGetBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceivewhitevalentinereward")
  protocol.id = self._data.id
  protocol:Send()
end

function WhiteValentineMainDialog:NumberOfCell(frame)
  return #self._itemList
end

function WhiteValentineMainDialog:CellAtIndex(frame)
  return "welfare.returnwelfare.returnwelfareactivitymailitemcell"
end

function WhiteValentineMainDialog:DataAtIndex(frame, index)
  return self._itemList[index]
end

return WhiteValentineMainDialog
