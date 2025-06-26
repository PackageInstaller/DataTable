-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_roletouch.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CTouchPicConfig = (BeanManager.GetTableByName)("npc.ctouchpicconfig")
local CTouchPicConfig_Skin = (BeanManager.GetTableByName)("npc.ctouchpicconfig_skin")
local CTouchConfig = (BeanManager.GetTableByName)("npc.ctouchconfig")
local CTouchConfig_Skin = (BeanManager.GetTableByName)("npc.ctouchconfig_skin")
local CSoundCatalog = (BeanManager.GetTableByName)("sound.csoundcatalog")
local CSoundCatalog_Skin = (BeanManager.GetTableByNameWithLanguage)("sound.csoundcatalog_skin")
local BM_RoleTouch = class("BM_RoleTouch")
BM_RoleTouch.Ctor = function(self)
  -- function num : 0_0
end

BM_RoleTouch.GetPicTouchInfo = function(self, roleID, fashionID)
  -- function num : 0_1 , upvalues : CTouchPicConfig_Skin, _ENV, CTouchPicConfig, CSoundCatalog_Skin, CSoundCatalog
  local touchRecord = nil
  local allFashionTouchIDs = CTouchPicConfig_Skin:GetAllIds()
  for _,value in ipairs(allFashionTouchIDs) do
    local tempRecord = CTouchPicConfig_Skin:GetRecorder(value)
    if tempRecord.role_id == fashionID then
      touchRecord = tempRecord
      break
    end
  end
  do
    if touchRecord == nil then
      local allRoleTouchIDs = CTouchPicConfig:GetAllIds()
      for _,value in ipairs(allRoleTouchIDs) do
        local tempRecord = CTouchPicConfig:GetRecorder(value)
        if tempRecord.role_id == roleID then
          touchRecord = tempRecord
          break
        end
      end
    end
    do
      if touchRecord == nil then
        LogErrorFormat("BM_RoleTouch", "CTouchPicConfig_Skin No Exist fashionID:%s and CTouchPicConfig No Exist RoleId:%s", fashionID, roleID)
        return 
      end
      local allItemList1 = {}
      local allItemList2 = {}
      local tmpSkinRecord = CSoundCatalog_Skin:GetRecorder(fashionID)
      local tmpRoleRecord = CSoundCatalog:GetRecorder(roleID)
      local tmpRecord = tmpSkinRecord or tmpRoleRecord
      if tmpRecord == nil then
        LogErrorFormat("BM_RoleTouch", "CSoundCatalog_Skin No Exist fashionID:%s and CSoundCatalog No Exist RoleId:%s", fashionID, roleID)
        return 
      end
      local tmpValue = tmpRecord[touchRecord.pic_id]
      if tmpValue then
        if type(tmpValue) == "table" then
          for index,_ in pairs(tmpValue) do
            (table.insert)(allItemList1, {touchRecord.pic_id, index})
          end
        else
          do
            ;
            (table.insert)(allItemList1, {touchRecord.pic_id})
            for _,value in pairs(touchRecord.volume_id) do
              tmpValue = tmpRecord[value]
              if tmpValue then
                if type(tmpValue) == "table" then
                  for index,_ in pairs(tmpValue) do
                    (table.insert)(allItemList2, {value, index})
                  end
                else
                  do
                    do
                      ;
                      (table.insert)(allItemList2, {value})
                      -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                end
              end
            end
            return allItemList1, allItemList2, roleID, fashionID
          end
        end
      end
    end
  end
end

BM_RoleTouch.GetLive2DTouchInfo = function(self, roleID, fashionID)
  -- function num : 0_2 , upvalues : CTouchConfig_Skin, _ENV, CTouchConfig
  local touchRecordList = {}
  local allFashionTouchIDs = CTouchConfig_Skin:GetAllIds()
  for _,value in ipairs(allFashionTouchIDs) do
    local tempRecord = CTouchConfig_Skin:GetRecorder(value)
    if tempRecord.role_id == fashionID then
      (table.insert)(touchRecordList, tempRecord)
    end
  end
  if #touchRecordList == 0 then
    local allRoleTouchIDs = CTouchConfig:GetAllIds()
    for _,value in ipairs(allRoleTouchIDs) do
      local tempRecord = CTouchConfig:GetRecorder(value)
      if tempRecord.role_id == roleID then
        (table.insert)(touchRecordList, tempRecord)
      end
    end
  end
  do
    return touchRecordList, roleID, fashionID
  end
end

return BM_RoleTouch

