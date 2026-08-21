local EnumConst = {
    StageState =     --当前阶段状态
    {
        NotOpen=1,  --未开启
        Doing = 2,  --进行中
        Over=3,     --结束
    },
    VotingState = 
    {
        All = 1,   --海选
        Eight =2,   --八强
        First = 3, --冠军
    }
}
return EnumConst
