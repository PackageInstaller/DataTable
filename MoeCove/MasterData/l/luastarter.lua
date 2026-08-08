
--require "zbdebug"

local LuaLoadErrorHandler

function Main(gameMain, serverdata)
    --Debugger.Log("Enter Main {0}", tostring(gameMain))
    --Debugger.Log("BundleMode {0}", tostring(EngineGlobal.Instance.BundleMode))
    --Debugger.Log("LuaMode {0}", tostring(EngineGlobal.Instance.luaMode))

    local gameMainObj = gameMain.gameObject
    g_GameMain = gameMain
    
    LuaMgr.Instance.LoadLuaError = LuaLoadErrorHandler

    if EngineGlobal.Instance.luaMode == EngineGlobal.LuaMode.PackMode then

        LuaMgr.Instance:AddLuaSearchPath(UpdateManager.Instance.LuaPath)
        LuaMgr.Instance:AddFileSearchPath(UpdateManager.Instance.LuaPath)
    elseif EngineGlobal.Instance.luaMode == EngineGlobal.LuaMode.ContentMode then
        if not DFileUtil.DirExists("../../common/script") then
            LuaMgr.Instance:AddLuaSearchPath("../../../luaj")
        end
        LuaMgr.Instance:AddLuaSearchPath("Content/Lua")
        LuaMgr.Instance:AddLuaSearchPath(UnityEngine.Application.dataPath .. "/LuaFramework/ToLua/Lua")  -- LuaConst.toluaDir
        LuaMgr.Instance:AddLuaSearchPath(UnityEngine.Application.dataPath .. "/LuaFramework/Lua")        -- LuaConst.luaDir
    elseif EngineGlobal.Instance.luaMode == EngineGlobal.LuaMode.ResourceMode then
        LuaMgr.Instance:AddLuaSearchPath("Resources/Lua")
        LuaMgr.Instance:AddFileSearchPath("Resources/Proto")
    end

    if EngineGlobal.GetPlatformName() == "WebGL" then
        g_GameMain:SetUpdateProgress(0.6, function()
            LuaMain = g_GameMain.gameObject:AddComponentLua("LuaMain")
        end)
    else
        LuaMain = g_GameMain.gameObject:AddComponentLua("LuaMain")
    end

end

Restart = function()
    if ClientData then
        ClientData:Clear()
    end
    if ResMgr then
        ResMgr:Clear()
    end
    if PoolMgr then
        PoolMgr:Clear()
    end
    if UIMgr then
        UIMgr:Clear()
    end
    if StateMgr then
        StateMgr:Clear()
    end
    if GameMsgMgr then
        GameMsgMgr:Clear()
    end
    if DTimer then
        DTimer.Instance:Clear()
    end
    g_GameMain:Restart()
end

LuaLoadErrorHandler = function (fileName, msg)

    Debugger.LogError("Error in lua {0} {1}", fileName, msg)
    if g_GameMain then
        g_GameMain:LuaError()
    end
    if WXLuaManager and WXLuaManager.LogError then
        WXLuaManager:LogError(string.format("Error in lua {0} {1}", fileName, msg))
    end
end

function ReloadModule(mdname)
	if package.loaded[mdname] then
        package.loaded[mdname] = nil
        Debugger.Log("module{0} will be reload", mdname)
    end

    Debugger.Log(" module{0} load", mdname)
    return require( mdname )
end