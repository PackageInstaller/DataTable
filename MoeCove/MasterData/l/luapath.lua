
local testLuaJ = false
if EngineGlobal.luaMode == EngineGlobal.LuaMode.ContentMode then
    local LuaMgr = LuaMgr.Instance

    if testLuaJ or not DFileUtil.DirExists("../../common/script") then
        LuaMgr:AddLuaSearchPath("../../../luaj")
    end

    LuaMgr:AddLuaSearchPath("../../../common/table/lua/Client")
    LuaMgr:AddLuaSearchPath("../../../common/table/lua/cfg")
    LuaMgr:AddLuaSearchPath("../../../common/table/lua/client/story")
    LuaMgr:AddLuaSearchPath("../../../common/table/lua/cfg/level")
    LuaMgr:AddLuaSearchPath("../../../common/table/lua/cfg/scene")
    LuaMgr:AddLuaSearchPath("../../../common/table/lua/cfg/sceneitem")
    LuaMgr:AddLuaSearchPath("../../../common/table/lua/cfg/combineData")
    LuaMgr:AddLuaSearchPath("../../../common/table/lua/cfg/npc")
    LuaMgr:AddLuaSearchPath("../../../common/table/lua/Client/language")
    LuaMgr:AddLuaSearchPath("../../../common/table/lua/Client/uilanguage")
    if not testLuaJ then
        LuaMgr:AddLuaSearchPath("../../../common/script/Logic")
        LuaMgr:AddLuaSearchPath("../../../common/script/Data")
        LuaMgr:AddLuaSearchPath("../../../common/script/Core")
        LuaMgr:AddLuaSearchPath("../../../common/script/Business")
        LuaMgr:AddLuaSearchPath("../../../common/script/Net")
    end
        LuaMgr:AddLuaSearchPath("../BattleLog")
    if not testLuaJ then
        LuaMgr:AddLuaSearchPath("../../../common/script/Battle/Logic")
        LuaMgr:AddLuaSearchPath("../../../common/script/Battle/Core")
        LuaMgr:AddLuaSearchPath("../../../common/script/Battle/Manager")
        LuaMgr:AddLuaSearchPath("../../../common/script/Battle/Event")
    end


    if not testLuaJ then
        LuaMgr:AddLuaSearchPath("Content/Lua/UI")
        LuaMgr:AddLuaSearchPath("Content/Lua/UI/Wnd")
        LuaMgr:AddLuaSearchPath("Content/Lua/UI/Common")
        LuaMgr:AddLuaSearchPath("Content/Lua/UI/Toast")
        LuaMgr:AddLuaSearchPath("Content/Lua/UI/MsgBox")
        LuaMgr:AddLuaSearchPath("Content/Lua/UI/Loader")
        LuaMgr:AddLuaSearchPath("Content/Lua/UI/Battle")
        LuaMgr:AddLuaSearchPath("Content/Lua/UI/MiniGame/BombGame")
        LuaMgr:AddLuaSearchPath("Content/Lua/TestClass")
        LuaMgr:AddLuaSearchPath("Content/Lua/Core")
        LuaMgr:AddLuaSearchPath("Content/Lua/Engine")
        LuaMgr:AddLuaSearchPath("Content/Lua/GameFlow")
        LuaMgr:AddLuaSearchPath("Content/Lua/Logic")
        LuaMgr:AddLuaSearchPath("Content/Lua/Sim")
        LuaMgr:AddLuaSearchPath("Content/Lua/Data")
        LuaMgr:AddLuaSearchPath("Content/Lua/Manager")
        LuaMgr:AddLuaSearchPath("Content/Lua/SDK")
        LuaMgr:AddLuaSearchPath("Content/Lua/GameScene")
        LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Cove")
        LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Survival")
        LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Cove/CoveMgr")
        LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Cove/CoveBattle")
        LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Cove/CoveAction")
        LuaMgr:AddLuaSearchPath("Content/Lua/Controller")

        --LuaMgr:AddLuaSearchPath("ZContent/Lua/UI")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/UI/Wnd")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/UI/Common")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/UI/Toast")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/UI/MsgBox")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/UI/Loader")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/UI/Battle")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/TestClass")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/Core")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/Engine")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/GameFlow")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/Logic")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/Data")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/Manager")
        --LuaMgr:AddLuaSearchPath("ZContent/Lua/SDK")   
        LuaMgr:AddLuaSearchPath("Content/Lua/Battle/Performance")
    end

    LuaMgr:AddLuaSearchPath("Plugins/LuaEditor")
    LuaMgr:AddLuaSearchPath("Resources/Proto")
    LuaMgr:AddLuaSearchPath("LuaFramework/ToLua/Lua")
    LuaMgr:AddLuaSearchPath("LuaFramework/Lua")
    LuaMgr:AddLuaSearchPath("../../../common/protocol")
    LuaMgr:AddFileSearchPath("../../../common/protocol")
    LuaMgr:AddLuaSearchPath("LuaFramework/Lua/3rd/cjson")
    
    LuaMgr:AddLuaSearchPath("LuaFramework/ToLua/Lua/UnityEngine")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Jumper-master")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Jumper-master/examples")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Jumper-master/jumper")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Jumper-master/jumper/core")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Jumper-master/jumper/search")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/Jumper-master/specs")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/AutoChess")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/AutoChess/Skill")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/AutoChess/Bullet")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/AutoChess/Buff")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/AutoChess/AI")
    LuaMgr:AddLuaSearchPath("Content/Lua/GameScene/AutoChess/Controller")
end