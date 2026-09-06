local RedDotManager = {}
local LAST_LOGIN_DATE_KEY = "LastLoginDate"
local IS_SEASON_REDDOT_SHOWN_KEY = "IsSeasonRedDotShownToday"
local IS_TOWER_REDDOT_SHOWN_KEY = "IsTowerRedDotShownToday"

local function getCurrentDate()
  return os.date("%Y-%m-%d")
end

function RedDotManager.CheckRedDotOnLogin()
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local roleId = userInfo.userid
  local today = getCurrentDate()
  local lastLogin = CS.UnityEngine.PlayerPrefs.GetString(LAST_LOGIN_DATE_KEY .. roleId, "")
  if lastLogin ~= today then
    CS.UnityEngine.PlayerPrefs.SetString(LAST_LOGIN_DATE_KEY .. roleId, today)
    CS.UnityEngine.PlayerPrefs.SetInt(IS_SEASON_REDDOT_SHOWN_KEY, 1)
    CS.UnityEngine.PlayerPrefs.SetInt(IS_TOWER_REDDOT_SHOWN_KEY, 1)
    CS.UnityEngine.PlayerPrefs.Save()
  end
end

function RedDotManager.ShouldSeasonShowRedDot()
  if CS.UnityEngine.PlayerPrefs.GetInt(IS_SEASON_REDDOT_SHOWN_KEY, 0) == 1 and NekoData.BehaviorManager.BM_Battle:GetSeasonNotify() and NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.OffLinePvp) then
    return true
  else
    return false
  end
end

function RedDotManager.ClearSeasonRedDot()
  CS.UnityEngine.PlayerPrefs.SetInt(IS_SEASON_REDDOT_SHOWN_KEY, 0)
  CS.UnityEngine.PlayerPrefs.Save()
end

function RedDotManager.ShouldTowerShowRedDot()
  if CS.UnityEngine.PlayerPrefs.GetInt(IS_TOWER_REDDOT_SHOWN_KEY, 0) == 1 then
    return true
  else
    return false
  end
end

function RedDotManager.ClearTowerRedDot()
  CS.UnityEngine.PlayerPrefs.SetInt(IS_TOWER_REDDOT_SHOWN_KEY, 0)
  CS.UnityEngine.PlayerPrefs.Save()
end

return RedDotManager
