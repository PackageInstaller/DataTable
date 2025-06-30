-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/reddotmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RedDotManager = {}
local LAST_LOGIN_DATE_KEY = "LastLoginDate"
local IS_SEASON_REDDOT_SHOWN_KEY = "IsSeasonRedDotShownToday"
local getCurrentDate = function()
  -- function num : 0_0 , upvalues : _ENV
  return (os.date)("%Y-%m-%d")
end

RedDotManager.CheckRedDotOnLogin = function()
  -- function num : 0_1 , upvalues : _ENV, getCurrentDate, LAST_LOGIN_DATE_KEY, IS_SEASON_REDDOT_SHOWN_KEY
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  local roleId = userInfo.userid
  local today = getCurrentDate()
  local lastLogin = (((CS.UnityEngine).PlayerPrefs).GetString)(LAST_LOGIN_DATE_KEY .. roleId, "")
  if lastLogin ~= today then
    (((CS.UnityEngine).PlayerPrefs).SetString)(LAST_LOGIN_DATE_KEY .. roleId, today)
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)(IS_SEASON_REDDOT_SHOWN_KEY, 1)
    ;
    (((CS.UnityEngine).PlayerPrefs).Save)()
  end
end

RedDotManager.ShouldSeasonShowRedDot = function()
  -- function num : 0_2 , upvalues : _ENV, IS_SEASON_REDDOT_SHOWN_KEY
  if (((CS.UnityEngine).PlayerPrefs).GetInt)(IS_SEASON_REDDOT_SHOWN_KEY, 0) == 1 and ((NekoData.BehaviorManager).BM_Battle):GetSeasonNotify() and ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).OffLinePvp) then
    return true
  else
    return false
  end
end

RedDotManager.ClearSeasonRedDot = function()
  -- function num : 0_3 , upvalues : _ENV, IS_SEASON_REDDOT_SHOWN_KEY
  (((CS.UnityEngine).PlayerPrefs).SetInt)(IS_SEASON_REDDOT_SHOWN_KEY, 0)
  ;
  (((CS.UnityEngine).PlayerPrefs).Save)()
end

return RedDotManager

