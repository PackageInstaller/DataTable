local ModuleConfig = {
    Lottery = {id = 10001, path = "Modules.LotteryModule"},
    OtakuMain = {
        id = 10003,
        path = "Modules.OtakuMainMoudule",
        isCS = false
    },
    Dorm = {id = 10004, path = "Modules.DormModule"},
    OtakuBridge = {
        id = 10005,
        path = "Modules.OtakuBridgeMoudule",
        director = "Camera.CameraDirector.BridgeCameraDirector",
        isCS = false
    },
    LuckDraw = {id = 10008, path = "Modules.LuckDrawModule", isCS = false},
    LoginModule = {id = 1, path = "Modules.LoginModule", isCS = false},
    MainModule = {id = 2, path = "GameX.MainModule", isCS = true},
    MainSceneModule = {id = 3, path = "Modules.MainSceneModule", isCS = false},
    GameEnterModule = {id = 6, path = "GameX.GameEnterModule", isCS = true},
    -- MissionModule = {id = 7, path = "Modules.MissionModule", isCS = false},
    BattleModule = {id = 8, path = "GameX.Battle.BattleModule", isCS = true},
    ChallengeModule = {id = 9, path = "GameX.ChallengeModule", isCS = true},
    StageModule = {
        id = 10,
        path = "Modules.StageModule",
        director = "Camera.CameraDirector.BaseCameraDirector",
        isCS = false
    },
    BattleModuleNew = {id = 12,path = "GameX.Battle.BattleModuleNew", isCS = true}
    ,
    RoleDevelopModule = {
        id = 10009,
        path = "Modules.RoleDevelopModule",
        director = "Camera.CameraDirector.RoleDevelopCameraDirector",
        isCS = false
    },
    ShopModule = {id = 11, path = "Modules.ShopModule", isCS = false},
    RoleFashionModule = {
        id = 10010,
        path = "Modules.RoleFashionModule",
        director = "Camera.CameraDirector.BaseCameraDirector",
        isCS = false
    },
    DormRoleFashionModule = {
        id = 10011,
        path = "Modules.DormRoleFashionModule",
        director = "Camera.CameraDirector.BaseCameraDirector",
        isCS = false
    },
}

return ModuleConfig
