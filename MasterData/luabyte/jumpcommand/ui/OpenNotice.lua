local M = BaseClass("OpenNotice",BaseJumpCommand)

function M:Execute()
    if not JumpMgr:GetInstance():CheckUnlockByFunctionOpenId(31) then
        CommandMgr:GetInstance():FinishExcute()
        return
    end
    local old = PlayerPrefabHelper.GetString("noticeTime");
    old = old == "" and "0" or old

    local isToday = TimeUtil.IsToday(tonumber(old))
    if isToday then
        CommandMgr:GetInstance():FinishExcute()
        return
    end
    -- C#里面会调用 CommandMgr:GetInstance():FinishExcute()
    local curtime = TimeUtil.GetNowTimeStamp()
    PlayerPrefabHelper.SetString("noticeTime", tostring(curtime));
    UIContextMgr:GetInstance():Show("Notice")
end

return M