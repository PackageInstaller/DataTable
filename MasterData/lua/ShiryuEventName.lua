ShiryuEventName = {


    MJ_LOGIN_SUCCESSFULLY = "mj_login_successfully";
    MJ_REGISTER_SUCCESSFULLY = "mj_register_successfully";
    MJ_GAME_USER_CREATE_ROLE = "mj_game_user_create_role";
    MJ_GAME_USER_UPDATE_ROLE = "mj_game_user_update_role";
    MJ_LOGIN_SERVER_FOR_GAME = "mj_login_server_for_game";
    MJ_PAY_CREATE_ORDER = "mj_pay_create_order";
    MJ_START_GAME = "mj_start_game";

    ---1. 开始更新客户端   C#  层
    MJ_START_UPDATING_CLIENT = "mj_start_updating_client";
    ---2.从地址1下载更新文件成功 C# 层
    MJ_DOWNLOAD_UPDATE_ADDRESS_ONE_SUCCESSFULLY = "mj_download_update_address_one_successfully";
    ---3.从地址2下载更新文件成功  C# 层
    MJ_DOWNLOAD_UPDATE_ADDRESS_TWO_SUCCESSFULLY = "mj_download_update_address_two_successfully";
    ---4.从2个地址下载客户端更新文件全部失败   C# 层
    MJ_DOWNLOAD_UPDATE_ADDRESS_ALL_FAIL = "mj_download_update_address_all_fail";
    ---5.更新结束    C# 层
    MJ_DOWNLOAD_UPDATE_END = "mj_download_update_end";
    ---6.开始预加载资源
    MJ_START_PRELOADING_RESOURCES = "mj_start_preloading_resources";
    ----7. 完成预加载资源
    MJ_FINISH_PRELOADING_RESOURCES = "mj_finish_preloading_resources";
    ----8.游戏公告显示 --- 弃用 2024-6-20 中台说不要了
    MJ_GAME_ANNOUNCEMENT_SHOWS = "mj_game_announcement_shows";
    ----9.点击活动公告按钮
    MJ_CLICK_ANNOUNCEMENT_BUTTON = "mj_click_announcement_button";
    ---10.点击选择服务器按钮---------------------------------------------------------------------没有这个功能
    MJ_CLICK_SELECT_SERVER_BUTTON = "mj_click_select_server_button";
    ---11.选择要登陆的服务器---------------------------------------------------------------------没有这个功能
    MJ_SELEC_SERVER_LOGIN = "mj_selec_server_login";
    ---12.支付完成 C# 层
    MJ_PAY_SUCCESS = "mj_pay_success";
    ---13.开始播放进入游戏动画
    MJ_ANIMATION_START = "mj_animation_start";
    ---14.动画播放完毕
    MJ_ANIMATION_END = "mj_animation_end";
    ---15.点击“确认”跳过开场动画
    MJ_ANIMATION_SKIP = "mj_animation_skip";
    ---16.点击“确认”选择信息与形象填写完毕
    MJ_ROLE_FILLIN = "mj_role_fillin";
    ---17.点击“确定”，选择确认角色名、生日、形象
    MJ_ROLE_CONFIRM = "mj_role_confirm";
    ---18.进入战斗引导--storyID=10051 已经添加
    MJ_FIGHT_START = "mj_fight_start";
    ---19.点击“确认”跳过战斗引导----引导相关---播放剧情-------跳过--添加通用
    MJ_FIGHT_SKIP = "mj_fight_skip";
    ---20.战斗完成--完成
    MJ_FIGHT_FINISH = "mj_fight_finish";
    ---21.点击“构建”---引导相关--配表完成
    MJ_STRUCTURE_START = "mj_structure_start";
    ---22.点击“确认”跳过构建引导---引导相关--配表完成
    MJ_STRUCTURE_SKIP = "mj_structure_skip";
    ---23.获取英雄
    MJ_STRUCTURE_FINISH = "mj_structure_finish";
    ---24.点击“编队”---引导相关--配表完成
    MJ_FORMATION_START = "mj_formation_start";
    ---25.点击“确认”跳过编队--5010引导相关-配表完成
    MJ_FORMATION_SKIP = "mj_formation_skip";
    ---26.点击返回首页--引导相关--配表完成
    MJ_FORMATION_FINISH = "mj_formation_finish";
    ---27.点击“出击”----引导相关--配表完成
    MJ_SORTIE_START = "mj_sortie_start";
    ---28.点击“确认”跳过出击引导---出击-6010-引导相关--跳过---完成--
    MJ_SORTIE_SKIP = "mj_sortie_skip";
    ---29.点击“主线剧情”--引导相关--配表完成
    MJ_PRINCIPAL_LINE = "mj_principal_line";
    ---30.0-1关卡战斗开始
    MJ_01_START = "mj_01_start";
    ---31.0-1战斗胜利
    MJ_01_FINISH = "mj_01_finish";
    ---32.0-2关卡战斗开始
    MJ_02_START = "mj_02_start";
    ---33.0-2关卡战斗胜利
    MJ_02_FINISH = "mj_02_finish";
    ---34.点击“任务”--引导相关---配表完成
    MJ_TASK_START = "mj_task_start";
    ----35.点击“确认”跳过任务引导---引导相关-常规任务-11020-跳过--完成
    MJ_TASK_SKIP = "mj_task_skip";
    ----36.日常任务奖励领取--MissionItem3-------96行--
    MJ_DAILYTASK_FINISH = "mj_dailytask_finish";
    ---37.主线任务奖励领取--引导相关------MissionItem1.lua-----95行---
    MJ_MAINTASK_FINISH = "mj_maintask_finish";
    ---38.点击“确定”构建,新手引导是一个顺序的流程，-------引导相关---配表完成----
    ---希望的是这个流程下来的每一步都打一个不同的序号。 可能会两次经过同一个功能按钮，但是也要区分开来。
    MJ_RESTRUCTURE_START = "mj_restructure_start";
    ---39.点击“确认”跳过再次构建引导 --引导相关----11310--跳过---完成
    MJ_RESTRUCTURE_SKIP = "mj_restructure_skip";
    ---40.点击“确定”构建
    MJ_RESTRUCTURE_CONFIRM = "mj_restructure_confirm";
    ---41.首次构建完成
    MJ_RESTRUCTURE_FIRST = "mj_restructure_first";
    ---42.点击“再次构建”
    MJ_RESTRUCTURE_NEXT = "mj_restructure_next";
    ---43.点击“确定”替换本次构建
    MJ_RESTRUCTURE_REPLACE = "mj_restructure_replace";
    ---44.点击“确定”构建结果
    MJ_RESTRUCTURE_RESULT = "mj_restructure_result";
    ---Unity 客户端运行版本
    Unity_Client_Version="Client_Version";
    ---Unity 客户端Lua 接收登录返回数据打点
    Unity_SDK_LuaLoginData="Unity_SDK_LuaLoginData";
    ---Unity 客户端Lua  LoginProto_SendLoginGame 发送给服务端数据打点
    Unity_LoginProto_SendLoginGame="Unity_LoginProto_SendLoginGame";
    ---中台UID验证
    Unity_center_web_uid_GotoVerify="Unity_center_web_uid_GotoVerify";
    Unity_DownFile_MD5_Different = "Unity_DownFile_MD5_Different";
    Unity_DownFile_MD5_Different_Quit = "Unity_DownFile_MD5_Different_Quit";
    ---获取服务器列表
    Unity_GetserverListUrl="Unity_GetserverListUrl";
    -- 通用打点
    Unity_Client_CommonData = "Unity_Client_CommonData";

    ------千禧打点下---------------------------------------------------------------------------------------------------------------------------------------------------------
    ---注册----上报一次  （默认SDK自带，无须接入客户端）
    QIANXI_Client_registration="registration";
    ---次日登录----上报一次（默认SDK自带，无须接入客户端）
    QIANXI_Client_next_day_login="next_day_login";
    ---发起储值----上报每次（默认SDK自带，无须接入客户端）
    QIANXI_Client_initiated_checkout="initiated_checkout";
    ---完成储值----上报每次（默认SDK自带，无须接入客户端）
    QIANXI_Client_af_purchase="af_purchase";
    ---创角----上报一次（默认SDK自带，无须接入客户端）
    QIANXI_Client_createdRole="createdRole";
    ---角色登录----上报每次（默认SDK自带，无须接入客户端）
    QIANXI_Client_loginRole="loginRole";
    ---角色登出----上报每次（默认SDK自带，无须接入客户端）
    QIANXI_Client_logoutRole="logoutRole";
    ---等级达到2----上报一次
    QIANXI_Client_upgradeRole_2="upgradeRole_2";
    ---等级达到3----上报一次
    QIANXI_Client_upgradeRole_3="upgradeRole_3";
    ---等级达到5----上报一次
    QIANXI_Client_upgradeRole_5="upgradeRole_5";
    ---等级达到10----上报一次
    QIANXI_Client_upgradeRole_10="upgradeRole_10";
    ---等级达到15----上报一次
    QIANXI_Client_upgradeRole_15="upgradeRole_15";
    ---等级达到20----上报一次
    QIANXI_Client_upgradeRole_20="upgradeRole_20";
    ---等级达到30----上报一次
    QIANXI_Client_upgradeRole_30="upgradeRole_30";
    ---完成首次任意充值----上报一次
    QIANXI_Client_firstpurchase="firstpurchase";
    ---累计充值达9.99美金----上报一次
    QIANXI_Client_pay_999="pay_9.99";
    ---累计充值达19.99美金----上报一次
    QIANXI_Client_pay_1999="pay_19.99";
    ---累计充值达49.99美金----上报一次
    QIANXI_Client_pay_4999="pay_49.99";
    ---累计充值达99.99美金----上报一次
    QIANXI_Client_pay_9999="pay_99.99";
    ------千禧打点上---------------------------------------------------------------------------------------------------------------------------------------------------------

}
local this = ShiryuEventName
return this