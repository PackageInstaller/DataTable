local PathUtil =
{
    Path_Bgm = "Bgm/",

    Path_Scene = "Scene/",

    Path_Sound = "Sound/",

    Path_SsUnit = "SsUnit/",
    Path_BattleCommonEffects = "SsUnit/Common/Effects/",
    Path_BattleCommonBuff = "SsUnit/Common/Buff/",
    Path_BattleCommonFightSoul ="SsUnit/Common/FightSoul/",

    Path_Storm = "Storm/",

    Path_UI = "UI/",
    Path_UIAtlas = "UI/Atlas/",
    Path_UIAtlasBodyHalf = "UI/Atlas/BodyHalf/",
    Path_UIAtlasCardLittle = "UI/Atlas/CardLittle/",
    Path_UICommonPrefab = "UI/Prefabs/Common/",
    Path_UIBattleEffects = "UI/Effects/Battle/",
    Path_UIBattleCommonPrefab = "UI/Prefabs/UI/Battle/Common/",
    Path_UIBattleCommonBuffGlancePrefab = "UI/Prefabs/UI/Battle/BuffGlances/",
    Path_UIPrefabsItems = "UI/Prefabs/View/Items/",

    Path_Language = "UI/Fonts/",
    Path_Dangrad = "UI/Dangrad/"
}

local Root = "AssetsPackage"

function PathUtil.DataPath()
    return CS.UnityEngine.Application.dataPath
end

function PathUtil.StreamingAssetsPath()
    return CS.UnityEngine.Application.streamingAssetsPath
end

function PathUtil.PackagePath()
    return CS.System.IO.Path.Combine(PathUtil.DataPath(), Root)
end

return ConstClass("PathUtil", PathUtil)