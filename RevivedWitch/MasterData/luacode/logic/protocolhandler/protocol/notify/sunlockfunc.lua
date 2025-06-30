-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/notify/sunlockfunc.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Game):OnSUnlockFunc(protocol)
  local list = {}
  for i,v in ipairs(protocol.funcLisk) do
    (table.insert)(list, v)
    if v.funId == (DataCommon.Functions).FirstReCharge then
      (((CS.UnityEngine).PlayerPrefs).SetInt)("FirstReChargeRedPoint", 1)
    else
      if v.funId == (DataCommon.Functions).Signboard then
        (((CS.UnityEngine).PlayerPrefs).SetInt)("FirstUnlockSignBoard", 1)
        local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
        if controller then
          controller:RefrashCharBubble()
        end
      else
        do
          do
            if v.funId == (DataCommon.Functions).Notice then
              (NoticeManager.SetAutoPopup)(false)
            else
              if v.funId == (DataCommon.Functions).Shop then
                (((NekoData.DataManager).DM_RedDot).CreateShopTree)(true)
              else
                if v.funId == (DataCommon.Functions).Friend then
                  (((NekoData.DataManager).DM_RedDot).CreateFriendTree)(true)
                else
                  if v.funId == (DataCommon.Functions).CourtYard then
                    (((NekoData.DataManager).DM_RedDot).CreateCourtYardTree)(true)
                  else
                    if v.funId == (DataCommon.Functions).Task_Every then
                      ((NekoData.DataManager).DM_Task):RefreshDailyTaskRedData()
                      ;
                      ((NekoData.DataManager).DM_Task):RefreshAchievementTaskRedData()
                    end
                  end
                end
              end
            end
            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_0_0
    do return a.sortId < b.sortId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(list) do
    ((NekoData.BehaviorManager).BM_Message):PopFunctionUnlockDialog(v.funId)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

