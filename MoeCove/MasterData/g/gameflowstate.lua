-- Desc: 游戏流程状态

GameFlowState = 
{
    CheckState = 1,         --检查更新状态
    LoginState = 2,         --登录状态
    -- PrepareState = 3,    --废弃
    GameState = 5,          --游戏状态
    BattleState = 6,        --战斗状态
    SurvivalState = 7,      --幸存者状态
    SelectUserState = 8,    --选择用户状态，在舰L中不存在选择用户，先保留下来
    -- RoomState = 9,       --mby的代码，废弃
    AuditingState = 20,     -- 健康游戏忠告
    EmptyState = 21,        --空场景状态
}