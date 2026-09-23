PetViewType={ --宠物切页类型
    Bag=62001, --背包
    Store=62002, --商店
    Sport=62003, --运动
    Book=62004, --图鉴
    Pet=62005,  --宠物
}

PetTweenType={ --宠物动画类型
    idle="idle",
    sleep="sleep",
    eat="eat",
    wash="wash",
    clean="clean",
    play="play",
    walk="walk",
    sport="sport",
    move="move",
}

PetSportType={
    Stop=0,--停止
    Move=1, --散步
    Run=2,  --跑步
}

PetHeadType={
    All=1,
    Wash=2,
    Food=3,
    Toy=4,
}

PetItemType={
    Toy=1,
    Food=2,
    Wash=3,
}
--宠物状态用于判断的属性类型
PetStateAttrType={
    Happy=1,
    Wash=2,
    Food=3,
    Life=4,
}

PetStateOption={
    Greater=1, --大于
    GreaterOrEqual=2,--大于等于
    Equal=3, --等于
    Less=5, --小于
    LessOrEqual=4,--小于等于
}

--台词框触发条件
PetTalkCondType={
    EnterView=1,
    EnterState=2,
    StayState=3,
    ExitState=4,
}

PetQualityColor={
    "c6ac91",
    "4aaf36",
    "72AEFF",
    "CE77FF",
    "FFb500",
    "FFb500",
}

PetTweenTimes={
    [1]={
        ["roel_Bath"] = 0.317,
        ["roel_Eat1"] = 0.167,
        ["role_Relax"] = 0.267,
        ["role_Run2"] = 2.883,
        ["role_Sleep2"] = 1.217,
        ["role_Sleep3"] = 8.467,
        ["role_Standby1"] = 3.217,
        ["Standby1_Weightlifting"] = 0.533,
        ["role_ride"] = 0.467,
        ["role_Move"] = 2.883,
    },
    [2]={
        ["eggplant_Ballet"] = 0.200,
        ["eggplant_Eat2"] = 1.717,
        ["eggplant_Music"] = 0.783,
        ["eggplant_Run1"] = 0.450,
        ["eggplant_Sleep1"] = 4.767,
        ["eggplant_Standby2"] = 3.233,
        ["eggplant_Wash"] = 0.433,
        ["eggplant_Watered"] = 0.433,
        ["eggplant_Move"] = 0.200,
    },
    [3]={
        ["Pet02_Eat"] = 2.050,
        ["Pet02_Fish"] = 1.817,
        ["Pet02_Idel"] = 0.600,
        ["Pet02_Move"] = 0.283,
        ["Pet02_Run"] = 0.417,
        ["Pet02_Sleep"] = 1.800,
        ["Pet02_Wash"] = 0.600,
        ["Pet02_Wash02"] = 0.550,
        ["Pet02_Move02"] = 0.283,
    },
}