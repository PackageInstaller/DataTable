--事件类型，Lua事件100,000以上，C#100,000以下
local this = {};
-----------------------------------------------------------------------------------------------------------------------------
--C#层的事件
-----------------------------------------------------------------------------------------------------------------------------
--日志状态
this.GM_State_Changed = 11;


--Lua消息
this.Lua_Event = 1000;
--GM测试信息
this.GM_Test_Info = 1001;
--游戏质量变化
this.Game_Quality_Changed = 1002;
--日志状态
this.Game_Log_Changed = 1003;


--输入事件状态
this.Input_Event_State = 1004;
--输入事件触发
this.Input_Event_Trigger = 1005;


--弹窗提示
this.Show_Prompt = 1006;
--请求失败
this.Web_Error = 1007;
--重连成功推送
this.InitFinishRet = 1008
------------------------------------------界面
--界面被打开
this.View_Lua_Opened = 1100;
--界面被关闭
this.View_Lua_Closed = 1101;
--界面加载完毕
this.View_Lua_Ready = 1102;
--界面间消息传递
this.View_Message = 1103;

--静默下载模式选择
this.Version_SilentDownload_Select = 1112;
this.Version_SilentDownload_Complete = 1113;
this.Version_SilentDownload_Error_MD5 = 1114;

--通用颜色遮罩关闭
this.Common_Color_Mask_Close = 1120;
------------------------------------------声音
--台词声音语速设置
this.CriWave_Feature_Pitch = 1200;
------------------------------------------通用
--奖励面板关闭
this.RewardPanel_Close = 7000;
--推送关闭奖励面板
this.RewardPanel_Post_Close = 7001
--屏幕旋转后
this.Screen_Rotation_Occurs = 7002;
------------------------------------------网络
this.Net_Msg = 8000;
this.Net_Msg_New = 8001;
this.Net_Disconnect = 8002;
this.Net_Weak = 8003;
this.Net_Ping = 8004;
this.Net_Work = 8005;
this.Net_Connect_Fail = 8006;
this.Net_Loading = 8007;
this.Net_Msg_Wait = 8008;--等待指定的消息
this.Net_Msg_Getted = 8009;--收到指定的消息
this.Net_Tips_Disconnect=8010;--提示中需要主动断开连接的
------------------------------------------场景
--加载场景
this.Scene_Load = 9000;
--场景加载完成
this.Scene_Load_Complete = 9001;
--场景卸载开始   
this.Scene_Unload_Start = 9005;
--场景加载开始   
this.Scene_Load_Start = 9006;

--战斗场景加载   
this.Scene_Fight_Load = 9007;

------------------------------------------Loading界面消息
--加载权重设置
this.Loading_Weight_Apply = 9990;
--加载权重更新
this.Loading_Weight_Update = 9991;
--加载界面延迟关闭
this.Loading_View_Delay_Close = 9992;
--加载界面关闭
this.Loading_View_Close = 9997;
--加载完成
this.Loading_Start = 9998;
--加载完成
this.Loading_Complete = 9999;


------------------------------------------输入
--场景输入开始
this.Input_Scene_Down = 10020;
--场景输入移动
this.Input_Scene_Move = 10021;
--场景输入结束
this.Input_Scene_Up = 10022;
--场景输入状态变更
this.Input_Scene_State_Change = 10023;
--战棋格子点击
this.Input_Scene_Battle_Grid_Click = 10030;
--战棋旋转镜头结束
this.Input_Scene_Battle_End_Rot = 10031;
--战棋格子按下
this.Input_Scene_Battle_Grid_Down = 10032;
--战棋格子按下保持
this.Input_Scene_Battle_Grid_Keep = 10033;
--基地建筑按下
this.Input_Scene_Matrix_Building_Down = 10034
-- 基地/宿舍 拖动 开始/结束 = 1/2
this.Input_Scene_Matrix_Move = 10035
------------------------------------------登录
--登录成功
this.Login_Success = 11000;
--重新登录成功
this.Relogin_Success = 11001;
--登录服务器
this.Login_Server = 11002;
--登录退出
this.Login_Quit = 11003;
--登录IP地址
this.Login_Server_Address = 11004;
--SDK登陆调用
this.Login_SDK_Command = 11005;
--用户创建角色成功
this.Login_Create_Role = 11006;
--用户进入游戏
this.Login_Enter_Game = 11007;
--SDK登陆调用结果
this.Login_SDK_Result = 11008;
-- SDK登出回调
this.Login_SDK_Logout = 11009;
-- SDK登出命令
this.Login_SDK_LogoutCommand = 11010;
--登录排队
this.Login_Wait_Begin=11011;
--排队结束
this.Login_Wait_Over=11012;
--cd倒计时
this.Login_CD_Down=11013;
--排队数据刷新
this.Login_wait_Update=11014;

--登录界面白色遮罩淡出
this.Login_White_Mask_FadeOut=11015;

--登陆动画播放
this.Login_Tween_Enter=11016;
--切换到登录界面
this.Login_Switch_LoginView=11017;
--改变用户协议勾选状态
this.Login_State_Agree=11018;
--cd倒计时2
this.Login_CD_Down2=11019;
-- 调起SDK删除账号
this.Login_SDK_DelAccount = 11020;
-- SDK删除账号回调
this.Login_SDK_DelAccount_CallBack = 11021;
--选择服务器
this.Login_Switch_Server = 11022;
----------------------------SDK
--调用SDK支付
this.SDK_Pay = 12000;
--SDK支付结果
this.SDK_Pay_Result = 12001;
--SDK未消耗订单查询
this.SDK_Pay_CheckOrder=12003;
--SDK未消耗订单查询返回
this.SDK_Pay_CheckOrderRet=12004;
--热云初始化
this.SDK_ReYun_Init=12005;
--Bugly初始化
this.SDK_Bugly_Init=12006;
--支付SDK初始化
this.SDK_Pay_Init=12007;
--支付SDK初始化完毕
this.SDK_Pay_InitFinish=12008;
--支付验证完成（苹果用）
this.SDK_Pay_Verify=12009;
--支付验证订单（苹果用）
this.SDK_Pay_VerifyOrder=12010;
--检查本地是否还有剩余订单需要验证(苹果用)
this.SDK_Pay_VerifyCache = 12011;
--巨量初始化
this.SDK_JuLiang_Init = 12012
--二维码链接返回
this.SDK_Pay_QRURL=12013
--二维码支付完成
this.SDK_QRPay_Over=12014

-----------------------------------------------------------------------------------------------------------------------------
--以下Lua层事件
-----------------------------------------------------------------------------------------------------------------------------
------------------------------------------FightAction
--战斗行为
this.Fight_Action_Push		= 100000;
--FightAction入列
this.Fight_Action_Enqueue	= 100001;
--角色回合
this.Fight_Action_Turn		= 100002;
--Overload
this.Fight_Action_Overload	= 100003;
--战斗飘字
this.Fight_Float_Font		= 100004;
--战斗飘字（数值）
this.Fight_Float_Num		= 100005;
--移动角色
this.Fight_Move_Character	= 100006;
--灯光状态
this.Fight_Scene_Light_State	= 100007;
--场景自发光加强
this.Fight_Scene_Emission_Up = 100008;
--场景自发光恢复
this.Fight_Scene_Emission_Down = 100009;
--战斗数据
this.Fight_Action_Data_Push		= 100010;
--战斗投降
this.Fight_Surrender		= 100011;
--角色标记变化
--this.Fight_Flag_Changed		= 100012;
--跳过技能切换
this.Fight_Skill_Skip = 100013;
--跳过行为结束
this.Fight_Skill_Skip_Complete = 100014;
--自动跳过下一个大招（同调、召唤）
this.Fight_Skill_Skip_Next = 100015;

--跳过
this.Fight_SkipCast2 = 100016;

--角色回合+1
this.Fight_Action_Turn_Add1		= 100017;

--战斗错误，无法继续战斗
this.Fight_Error_Msg = 100020;


--战斗活动，更新boss阶段信息
this.Fight_Activity_SetInvincible = 100030;
--战斗活动，更新总伤害
this.Fight_Activity_UpdateDamage = 100031;


------------------------------------------角色
--角色创建
this.Character_Create		= 110000;
--角色移除
this.Character_Removed		= 110001;
--角色死亡
this.Character_Dead			= 110002;
--角色战斗信息
this.Character_FightInfo_Show = 110003;
--角色战斗
this.Character_FightInfo_Changed = 110004;

--输出角色信息
this.Character_FightInfo_Log = 110005;

--Boss角色战斗信息
this.Character_Boss_FightInfo_Show = 110006;

--角色头顶信息缩放状态
this.Character_HeadInfo_Scale_State = 110007;

--角色受击
this.Character_Hited = 110008;
------------------------------------------镜头震动
this.Camera_Shake			= 120001;


------------------------------------------输入
--输入变化
this.Input_Target_Changed	= 130001;
--选择技能
this.Input_Select_Skill		= 130002;
--选择格子
this.Input_Select_Grid		= 130003;
--选择复活技能
this.Input_Select_Relive		= 130004;
--选择复活目标
this.Input_Select_Relive_Target = 130005;
--选择变身技能
this.Input_Select_Transform		= 130006;
--选择变身目标
this.Input_Select_Transform_Target = 130007;
--确认选择
this.Input_Select_OK	= 130008;

--自动战斗切换
this.Input_Auto_Change		= 130009;

--选中第N个技能
this.Input_Select_Skill_Item		= 130010;

--Overload状态变化
this.Input_Overload_State_Changed		= 130011;
--取消技能选择状态
this.Input_Select_Cancel = 130012;

--选择目标角色变化
this.Input_Select_Target_Character_Changed = 130013;
------------------------------------------战斗UI更新
--时间条更新
this.Fight_Time_Line_Update	= 140000;
--战斗信息更新
this.Fight_Info_Update		= 140001;
--战斗Boss
this.Fight_Boss				= 140002;
--战斗界面设置变化
this.Fight_View_Setting		= 140003;
--战斗事件（协战、追击、反击）
this.Fight_Trigger_Event_Update		= 140004;
--伤害更新
this.Fight_Damage_Update		= 140005;
--伤害统计状态
this.Fight_Damage_Show_State		= 140006;
--战斗显示翻转
this.Fight_Flip				= 140007;
this.Fight_Time_Line_Refresh = 140008;
--战斗摄像机镜头效果
this.Fight_Camera_Eff				= 140009;
--消耗np
this.Fight_Np_Cost = 140010;
--自动战斗切换
this.Fight_Auto_Changed = 140011;
--战斗界面显示
this.Fight_View_Show_Changed	= 140012;
--战斗移除镜头效果
this.Fight_Remove_Camera_Eff = 140013;
--战斗镜头淡入淡出
this.Fight_Fade = 140014;
--行动者立绘更新
this.Fight_Img_Update	= 140015;
--自动战斗状态切换
this.Fight_View_AutoFight_Changed	= 140016;

--战斗恢复
this.Fight_Restore = 140017;

--界面遮罩
this.Fight_Mask = 140018;

--AI技能设置
this.Fight_AI_Skill_Setting = 140019;

--战斗界面主要信息显示状态
this.Fight_View_Main_Info_Show_State = 140020;

--战斗AI设置调整
this.Fight_AI_Skill_Changed = 140021;

--战斗常驻遮罩启动状态
this.Fight_View_Mask = 140022;

--调整时间条项索引
this.Fight_Reset_TimeLineIndex = 140023;

--战斗UI入场
this.Fight_UI_Enter_Action = 140024;

--单场战斗总伤害更新
this.Fight_UI_TotalDamage_Update = 140025;

--战斗清理
this.Fight_Clean = 140026;

--显示目标UI
this.Fight_Focus_Show=140027;


--伤害统计再现
this.Fight_Damage_Reshow = 140028;

this.Fight_Over_Reward = 140029 --返回关卡结算奖励信息

this.Fight_ShowTips_SkillUnusable = 140030 --技能不可用

this.Fight_SetSettingBtn = 140031 --设置战斗界面的暂停按钮状态

this.Fight_Over_Panel_Show = 140032 --显示结算界面

--进入战斗失败
this.Fight_Enter_Fail=140033 --进入战斗失败

--战斗表情
this.Fight_Play_Face=140034
-----------------------------------------登录模块
--玩家登录成功
this.Login_Server_Success			= 150000;
--选择服务器
this.Login_Select_Server				= 150001;
--点击注册按钮
this.Login_Click_RegisterBtn			= 150002;
--点击已有账号
this.Login_Click_HasUserBtn				= 150003;
--返回登录界面
this.Login_Click_Return = 150004;
--点击登录按钮
this.Login_Click_In = 150005;
--登录失败
this.Login_Fial = 150006;
--实名验证返回
this.Authentication_Result = 150007;
--实名信息更新
this.Authentication_Update = 150008;
--显示点击遮罩
this.Login_Show_Mask = 150009;
--隐藏点击遮罩
this.Login_Hide_Mask = 150010;

--手机验证码登录
this.Login_Phone_Auth_Code = 150011;
--实名验证窗口关闭
this.Authentication_Close = 150012;

------------------------------------------剧情系统
--剧情选项
this.Select_Plot_Option			= 160000;
this.Init_Plot_Data = 160001;
--设置剧情界面延迟关闭时间，解决关闭剧情界面后，会闪一下后面界面的问题
this.Plot_Close_Delay = 160002;


------------------------------------------角色卡牌系统
--改名
--this.Role_Card_ReName		= 170000;
--选择素材数量
--this.Role_Choose_Fodder = 170001;
--从新排序
--this.Role_Sort_Refresh = 170002;
--上锁
--this.Role_Card_Lock	= 170003;
--角色升级+角色改修
--this.Role_Card_Upgrade = 170004;
--角色突破
--this.Role_Card_Break	= 170005;
--技能升级完成
--this.Role_Skill_Finish = 170006;
--技能列表更新
--this.Role_Skill_Update = 170007;
--技能槽扩容
this.Role_Skill_GridAdd = 170008;
--卡牌添加
this.Role_Card_Add = 170009;
--卡牌删除
this.Role_Card_Delete = 170010;

------------------------------------------热值冷却
--卡牌冷却信息列表
this.Role_Cool_List	= 170011;
--卡牌冷却
this.Role_Cool		= 170012;
--卡牌冷却完成通知
this.Role_Cool_Finish = 170013;
--卡牌冷却格子扩容通知
this.Role_Cool_GridAdd = 170014;
------------------------------------------卡牌建造
--建造信息列表
this.Role_Create_List = 170015
--建造
this.Role_Create		= 170016
--建造加速+完成
this.Role_Create_Finish = 170017
--分解
this.Role_Create_Disintegrate = 170018
--卡牌切换
this.Role_Card_Change = 170019;
--选择支援卡
this.Role_Card_Support = 170020;
--详情角色放大
this.Role_Card_Magnify = 170021;
--获取皮肤
this.Card_Skin_Get = 170023;
--角色列表关闭
this.RoleList_Close = 170024;
--建造加速+完成 首次10连
this.Role_FirstCreate_Finish = 170025
--建造加速+
this.Role_Refresh_Logs = 170026
--抽卡动画隐藏跳过按钮
this.Role_Create_Ani_Disable_Skip = 170027;

-------

--选素材
this.Role_Material_Click = 170028;
--卡牌切换结果
this.Role_Card_ChangeResult = 170029;
--页签
this.Role_Tag_Update = 170030;
--卡牌长按
this.Role_Card_Holder = 170031;

this.Card_Update = 170032     --卡牌更新
this.CardList_Update = 170033 --卡牌列表更新
this.CardCool_Update = 170034 --热值更新 
this.CardCool_Cnts_Update = 170035 --累计抽卡更新 

--按下卡牌时
this.Role_Card_PressDown=170036;

--卡牌更新（如使用皮肤）
--this.Role_Card_Update = 170025;
--卡牌扩容
this.Role_Card_GridAdd = 170037;
--卡牌点击
this.Role_Card_Click = 170038;

this.Role_Create_SetCard = 170039
this.Role_Jump_Skill = 170040 --跳转到指定技能页面
this.Role_Jump_Break = 170041 --跳转到指定突破页面

this.Role_FirstCreate_End = 170042
this.Role_Captain_ToFirst = 170043  --队长排在最前面
this.Role_LimitSkin_Refresh = 170044 --限时皮肤
this.CreateRoleView_ShareBtn_SH = 170045 --构建展示界面分享按钮的显示与隐藏
this.Choice_Card_Ret = 170046 --自选卡牌返回
this.Guide_RoleInfo_220040 = 170047 --点击装备区域引导
this.Guide_RoleInfo_230070 = 170048 --点击天赋区域引导
this.MainTalent_Upgrade = 170049  --一键升级主天赋
------------------------------------------主界面
--切换显示状态
this.Main_Menu_Show			= 180000;
--玩家更新
this.Player_Update		= 180001;
--同步正在进行中的副本信息
this.Main_Fight_Duplicate	= 180002;
--活动数据
this.Main_Activity	= 180003;
--设置 保存回调
--this.Main_Setting	= 180004;
--设置 屏幕适应大小推送
this.Screen_Scale	= 180005;
--点击角色
--this.Click_Role	= 180006;
--技能红点检测时间点
this.Main_SkillSuccess_Red = 180007;
--生活buff消失
this.Main_LifeBuff_Remove = 180008;
--体能改变：体能购买,使用体能道具
this.Player_HotChange = 180009;
--更新了货币
this.Update_Coin = 180010;
--更新了能力
this.Update_PlayerAbility = 180011;
--到点刷新（3点）
this.Update_Everyday = 180011;
--打开主界面
this.Main_Enter=180012;
-- 玩家累计充值金额发生改变
--this.Pay_Amount_Change=180013;
--更换头像框 
this.Head_Frame_Change=180014;
--更换头像
this.Head_Icon_Change=180015;
--问卷调查显示隐藏
this.Menu_WebView_Enabled=180016;
--累充领取
this.AccuCharge_Get=180017;
--活动表动态更改 
this.CfgActiveEntry_Change=180018;
--MenuBuyPanel关闭
this.MenuBuy_RechargeCB=180019;
--更换称号
this.Head_Title_Change=180020;
--累充领取s
this.AccuChargeS_Get=180021;
--对战表情
this.Head_Face_Change = 180022
--调查问卷
this.Menu_Questionnaire = 180023
--spineUI动画进入与退出
this.Menu_SpineUI = 180024
--女仆咖啡
this.Menu_Coffee = 180025 
--触发礼包 
this.Menu_PopupPack = 180026 
--触发礼包 
this.Menu_PopupPack_MinTime = 180027
--圣诞活动
this.Menu_Christmas = 180028
--主界面主题商品更换
this.MenuTheme_Change = 180029
--隐藏看板
this.Menu_Theme_HideKB = 180030
-------------------------------------------编队系统
--选中预设
this.Select_Perset_Item = 190000;
--放置卡牌
this.Drop_Card_Item = 190001;
--开始拖拽卡牌
this.Drag_Card_Begin = 190002;
--拖拽卡牌完成
this.Drag_Card_End = 190003;
--拖拽卡牌中
this.Drag_Card_Holding = 190004;
--卡牌可拖拽状态控制
this.Drag_Card_Ctrl_State = 190005;
--卡牌上阵
this.Team_Card_Join = 190006;
--展开预设
this.Team_Preset_Open = 190007;
--保存预设
-- this.Team_Preset_Save = 190008;
--选择助战卡牌
this.Team_Support_Select = 190009;
--点击上阵格子变更
this.Team_Item_Select = 190010;
--卡牌替换
this.Team_Card_Replace = 190011;
--队伍卡牌刷新
this.Team_Card_Refresh = 190012;
--队伍内的卡牌位置变更
this.Team_Item_Change = 190013;
--开始拖拽成员格子
this.Team_Item_BeginDrag = 190014;
--编队界面选中的格子变更
this.Team_Select_Index_Change = 190015;
--编队界面下阵事件
this.Team_Select_Leave = 190016;
--出战前界面刷新
this.Team_Confirm_Refreh = 190017;
--取消拖拽
this.Team_Item_Cancel = 190018;
--出站前界面显示技能选择
this.Team_Confirm_OpenSkill = 190019;
--刷新占位格颜色
this.Team_Grid_RefreshColor = 190020;
--FormationView格子点击事件
this.Team_FormationView_Select = 190021;
--
this.Team_Confirm_ItemDisable = 190022;
--编队移动限制
this.Team_FormationView_ForceMove = 190023;
--队伍更新事件
this.Team_Data_Update = 190024;
--队伍数据设置完成
this.Team_Data_Setted = 190025;

this.Team_Join_Scroll = 190026;
this.Team_Join_DragBegin = 190027;
this.Team_Join_DragEnd = 190028;
this.Team_Join_Drag = 190029;
--点击编队信息面板
this.Team_FormationInfo_Click = 190030;

this.Team_FormationInfo_SetLeader = 190031;
--在指定行列显示编队信息界面
this.Team_FormationInfo_SetRC = 190032;
--设置3D列阵是否可以旋转和缩放
this.Team_Formation3D_SetRAndZ = 190033;

--3D阵型盘加载完毕
this.Team_Model_LoadOver=190034;

--设置AI自动战斗策略
this.Team_Confirm_SetAIPrefab=190035;

--编队界面右侧面板角色是否可点击状态切换
this.Team_FormationView_CharacterItemClickState = 190036;

--编队界面关闭
this.TeamView_Close=190037;

--编队助战信息初始化完毕
this.Team_AssistInfo_Init=190038;

--编队切换队伍时数据保存成功
this.Team_Switch_SaveOver=190039;
--编队预设购买返回
this.Team_Preset_Buy=190040;
--编辑的队伍下标变更
this.Team_EditIndex_Change=190041
--队伍数据变更
this.Team_Data_Change=190042;
--编队界面的编辑模式变更
this.TeamView_EditMode_Change=190043;
--编队界面刷新阵盘
this.TeamView_Refresh_Formation=190044;
--编队界面的加成状态变更
this.TeamView_AddtiveState_Change=190045;
--编队界面拖拽遮挡变更
this.TeamView_DragMask_Change=190046;
--显示队伍列表
this.TeamView_Show_TeamList=190047;
--隐藏队伍列表 
this.TeamView_Hide_TeamList=190048;
--编队界面3D2D切换
this.TeamView_ViewType_Change=190049;
--编队拖拽上阵事件丢失
this.TeamView_DragJoin_Lost=190050;
--设置子节点变更
this.TeamView_ChildNode_Change=190051;
--战斗派遣队伍修改
this.TeamView_RogueS_Change=190052;
--编队界面左边按钮&UI元素刷新
this.TeamView_Left_Refresh=190053;
--编队列表刷新
this.TeamView_List_Refresh=190054;
--队伍数据是否有更改
this.TeamView_Has_Change=190055;
--队伍预设名字更改
this.Team_PresetName_Change = 190056;
--队伍战力不足引导操作,进编队界面
this.Team_Raising_GoTeamView=190057;
--队伍战力不足引导操作，进战斗
this.Team_Raising_GoBattle=190058;
-------------------------------------------背包
--物品更新
this.Bag_Update = 200000;
this.Money_Update = 200001;
this.Bag_SellQuality_Change = 200002;
this.Goods_GiftFilter_GetRet=200003;--从材料箱中获取到符合需求数的材料时的返回

------------------------装备系统
--卡牌装备有变化
this.Equip_Change = 210000;
--装备加锁/解锁
this.Equip_Lock = 210001;
--强化素材选择完毕
this.Equip_Stuff_SelectOver = 210002;
--装备背包格子数量刷新
this.Equip_GridNum_Refresh = 210003;
--装备盘选中的位置变更
this.EquipCore_Slot_Change = 210004;
--装备预设穿戴
this.EquipPrefab_Ups = 210005;
--装备预设替换
this.EquipPrefab_Replace = 210006;
--添加装备预设槽位
this.EquipPrefab_AddLogSlot = 210007;
--选择的装备变更
this.Equip_Select_Change = 210008;
--打开装备选择界面
this.Equip_Open_Select = 210009;
--打开套装选择界面
this.Equip_Suit_Select = 210010;
--点击了装备核心的LT 按钮
this.Equip_Core_LT = 210011;
--点击了装备核心的LB按钮
this.Equip_Core_LB = 210012;
--点击了装备核心的RB按钮
this.Equip_Core_RB = 210013;
--装备预设界面刷新
this.EquipPrefab_Refresh=210014;
--装备设置Lock返回
this.Equip_SetLock_Ret=210015;
--装备升级返回
this.Equip_Upgrade_Ret=210016;
--装备出售返回
this.Equip_Sell_Ret=210017;
--装备卸载返回
this.Equip_Down_Ret=210018;
--单件装备穿戴返回
this.Equip_UpOne_Ret=210019;
--多件装备穿戴返回
this.Equip_Ups_Ret=210020;
--使用装备预设返回
this.Equip_UsePrefab_Ret=210021;
--添加装备预设栏返回
this.Equip_AddPrefab_Ret=210022;
--设置装备预设返回
this.Equip_SetPrefab_Ret=210023;
--获取装备预设返回
this.Equip_GetPrefabs_Ret=210024;
--点击套装物体
this.Equip_Suit_Click=210025;
--显示装备详情
this.Equip_SuitDetails_Click=210026;
--点击背景图
this.Equip_Click_BG=210027;
--点击整套替换
this.Equip_Click_SuitUps=210028;
--选择改造装备
this.Equip_Remould_Select=210029;
--装备动画点击遮罩
this.Equip_TweenMask_State=210030;
--装备数据更新
this.Equip_Update=210031;
--强化动画遮罩
this.Equip_StrengthTween_State=210032;
--装备合成类型选择
this.Equip_Combine_SelSlot=210033;
--移除合成素材
this.Equip_Remove_CombineM=210034;
--锁定词条
this.Equip_Lock_Attribute=210035
--合成返回
this.Equip_Combine_Ret=210036
--洗炼返回
this.Equip_Refining_Ret=210037
--洗炼确定返回
this.Equip_Refining_Comfirm=210038
--洗炼数据刷新
this.Equip_Refining_Update=210039
--点击锁定条件
this.Equip_Click_LockLimit=210040
--装备数据推送完毕
this.Init_Equip_Finish=210041
------------------------------------------战棋系统事件
--场地初始化完成
this.Battle_Ground_Inited = 220000;
--战棋角色创建
this.Battle_Character_Created = 220001;
--战棋控制角色切换
this.Battle_Character_Ctrl_Changed = 220002;
--战棋界面显示状态
this.Battle_View_Show_Changed = 220003;
--战棋界面显示点击的格子信息
this.Battle_Select_Ground_Info = 220004;
--宝箱数量更新
this.Battle_BoxNum_Change = 220005;
--战棋界面玩家角色移动
this.Battle_Character_Move = 220006;
--战棋角色死亡
this.Battle_My_Character_Dead = 220007;
--战棋界面锁定点击
this.Battle_Lock_Click = 220008;
--设置格子场景背景
this.Battle_Bg = 220009;
--副本战斗退出按钮激活状态变化
this.Battle_Quit_State_Changed = 220010;

--格子副本行动回合变化
this.Battle_Turn_Changed = 220011;

--格子场景视距变化时
this.Battle_Ground_Zoom = 220012;

--战旗角色数据更新
this.Battle_Character_Update = 220013;

--AI寻路UI更新
this.Battle_AIMove_UI_Update = 220014;

--格子场景UI变化
this.Battle_UI_BlackShow = 220015

-------------------------------------------邮件
--邮件操作
this.Mail_Operate = 230000;
--邮件新增
this.Mail_AddNotice = 230001;
--邮件点击
this.Mail_Click = 230002;
-------------------------------------------任务
--列表更新
this.Mission_List = 240001
--选择标签
--this.Mission_Tab_Sel = 240002

--刷新
--this.MIssion_Update = 240002
--领取奖励
--this.Mission_Reward = 240003
-- 任务重置 
this.Mission_ReSet = 240004
--任务阶段更新
this.Mission_Stage_Update=240005
--任务删除
this.Mission_Delete = 240006
--领取奖励返回
this.Mission_RewardRet = 240007
--限量任务更新
this.Mission_Limit_Update = 240008
-------------------------------------------好友
--刷新
this.Friend_Update = 250001
--查看协战
this.Friend_Team = 250002
--查看协战卡牌
this.Friend_Card = 250003
--搜索好友
this.Friend_Find = 250004
--操作
this.Friend_Op = 250005
--改名
this.Friend_ReName = 250006
--推荐
this.Friend_Recommend = 250007
--自己消息返回
this.Friend_MsgNotice_self = 250008
--消息返回
this.Friend_MsgNotice = 250009
--选中好友
--this.Friend_Select = 250010
--更多操作
this.Friend_More = 250011
--点击好友
this.Friend_Talk = 250012
--好友添加
this.Friend_Add = 2500013
--好友选项
this.Friend_Other = 2500014
--好友申请
this.Friend_Apply_Panel = 2500015
--接受申请
this.Friend_UI_Remove = 2500016

-------------------------------冷却界面关闭
this.CoolView_Close = 260001;

------------------------------玩家
--玩家信息
this.Player_Info = 270000;
--名字变更
this.Player_EditName = 270001;
--修改签名
this.Player_Change_Sign = 270002;
--选择看版卡牌
this.Player_Select_Card = 270003;
--玩家能力更新
this.Player_Ability_Refresh = 270004;
--玩家能力显示
--this.Player_Ability_Show = 270005;
--玩家能力添加
this.Player_Ability_Add = 270006;
--点击卡牌角色头像
this.Player_Icon_Click = 270007
--选择看版背景
--this.Player_Select_BG = 270008;
--能力点击
this.Player_Ability_CanClick = 270009;
--玩家能力信息界面状态
this.Player_AbilityInfo_ViewActive = 270010;
--玩家能力信息界面位置
this.Player_AbilityInfo_ViewPos = 270011;
--玩家能力信息界面刷新
this.Player_AbilityInfo_Refresh = 270012;
--刷新看板界面
this.CRoleDisplayMain_Refresh = 270013;
--看板列表更新
this.CRoleDisplayMain_Change = 270014;
--随机看板刷新（移除，添加）
this.CRoleDisplayS_Change = 270015;
--玩家名称和性别变更
this.Player_SexOrName_Change = 270016
--多选刷新
this.CRoleDisplayDX_Refresh = 270017;
--看板动作是否缓存修改
this.Player_KBCache_Change = 270018;
----------------------------镜头相关事件
--当前天空盒变化
this.SkyBox_Changed = 280001;
--场景遮罩
this.Scene_Mask_Changed = 280002;
------------------------------演习
--信息刷新
this.Exercise_Update = 290001
--演习对手刷新
this.Exercise_Enemy_Update = 290002
--查看对手
this.Exercise_Enemy_Info = 290003
--查看排行榜
this.Exercise_Rank_Info = 290004
--匹配
--this.Exercise_Yq_CB = 290005
--主动退出自由军演
--this.Exercise_Yq_Cancel = 290006
--对方拒绝邀请
this.Exercise_Yq_Refuse = 290007
--被邀请通知
--this.Exercise_Yq_Notice = 290008
--军演匹配或邀请成功
this.Exercise_Pp_Success = 290009
--军演进入
--this.Exercise_In = 290010
--准备好
this.Exercise_Ready = 290011
--对手离线
this.Exercise_Army_Out = 290012
--对战列表
--this.Exercise_WaringList = 290013
--选择好友
--this.Exercise_Friend_Select = 290014
this.Exercise_End = 290013 --本赛季结束
this.ExerciseL_New = 290014 --参加此时重置
this.ExerciseL_BuyCount = 290015 --购买挑战次数
this.Rogue_CancelBack = 290016 --放弃
this.RogueS_phase_Change = 290017 --战力派遣期数变更
this.RogueT_Buff_Upgrade = 290018 --buff升级回调
--this.Exercise_Role_Panel = 290019 --军演看板修改
this.ExerciseR_End = 290020 --pvp 赛季结束或者开发时间结束
this.ExerciseR3_ChangeTeam = 290021 --对方修改队伍顺序通知
this.ExerciseR3_FixNotice = 290022 --双方都结算完成的通知
--------------------------------------------------物品合成
--合成成功
this.Goods_Combine_Success = 300001
--物品手动转换成功
this.Goods_Converted_Success=300002


------------------------------天赋
--主天赋升级回调
--this.Talent_Upgrade = 310000
--副天赋学习
this.Talent_Study = 310001
--副天赋替换
this.Talent_Replace = 310002
------------------------------卡牌角色
--排序回调
this.CRole_Sort = 320001
--触发立绘行为
this.CRole_Touch = 320002
--皮肤剧情播放回调
this.CRole_PlayJQ = 320003
--角色更新请求
this.CRole_Update = 320004
--角色添加
this.CRole_Add = 320005
------------------------------天赋
--ui效果（开）
this.UI_Eff_Enter = 330001
--ui效果（关）
this.UI_Eff_Exit = 330002

------------------------------活动列表
this.Activity_Get_SignIn = 340001 --签到记录
this.Activity_SignIn = 340002 --签到
this.Activity_OpenQueue = 340003 --活动预开启队列
this.Activity_Click = 340004 --活动强制点击
this.Acitivty_List_Pop = 340006 --活动弹出
this.Activity_List_Panel_Refresh = 340007 --活动界面刷新
this.Activity_List_Cfg_Change = 340008 --活动表配置修改
this.Activity_SkinRebate_Refresh = 340009 --皮肤返利按钮刷新
this.Activity_DuanWu_Refresh = 340010 --端午签到界面刷新
this.Activity_PopUp_View = 340011 --活动界面弹出
this.Activity_OldSkinRebate_Refresh = 340012 --旧皮肤返利刷新
------------------------------------------背景音乐
--播放背景音乐
this.Play_BGM = 350001
--重播背景音乐
this.Replay_BGM = 350002
--播放背景音乐(新)
this.Play_BGM_New = 350003
-----------------------------------------基地
--建筑 更新
this.Matrix_Building_Update = 360001
--预警级别更新
this.Matrix_WarningLv_Update = 360002
--点击装备
this.Matrix_Equip_Click = 360003
--突袭
this.Matrix_Assualt = 360004
--拖拽 
this.Matrix_Drag_Begin = 360005
--拖拽 
this.Matrix_Drag = 360006
--拖拽结束
this.Matrix_Drag_End = 360007
--建造选择
--this.Matrix_Create_Select = 360008
--是否可以点击建筑或地面
--this.Matrix_View_Show_Changed = 360009
--点击3d建筑
this.Matrix_Building_Click = 360010
--建造返回
this.Matrix_Building_CreateRet = 360011
--建筑生成
--this.Matrix_BuildingObj_Create = 360012
--生产中心奖励领取回调
--this.Matrix_Building_Get = 360013
this.Matrix_Grid_Click = 360012
this.Matrix_Indoor_Change = 360013
this.Matrix_Building_Upgrade = 360014
this.Matrix_Trading_FlrUpgrade = 360015 --好友订单刷新
this.Matrix_Compound_Success = 360016 --订单合成成功
this.Matrix_Building_UpdateEnd = 360017 --建筑更新完成 
this.Matrix_Add_PresetTeam = 360018 --新增预设队伍 
--------------------------------------------商店
--商店主界面点击按钮
this.Shop_Main_ClickBtn = 370001
--点击商店页签
this.Shop_Tab_Change = 370002
--商店货币更换
this.Shop_Money_Refresh = 370003
--点击商店二级页签
this.Shop_TopTab_Change=370004
--月卡信息返回
this.Shop_MemberCard_Ret=370005
--随机商店信息刷新
this.Shop_RandComm_Refresh=370006
--商店购买记录刷新
this.Shop_RecordInfos_Refresh=370007
--商店内跳转
this.Shop_Jump_Refresh=370008
--商店页面刷新
this.Shop_View_Refresh=370009
--购买返回
this.Shop_Buy_Ret=370010;
--兑换返回
this.Shop_Exchange_Ret=370011;
--月卡剩余时间刷新
this.Shop_MonthCard_DaysChange=370012;
--商店的新商品信息刷新
this.Shop_NewInfo_Refresh=370013;
--商店购买遮罩
this.Shop_Buy_Mask=370014;
--商店刷新时间返回
this.Shop_ResetTime_Ret=370015;
--商店开启时间返回
this.Shop_OpenTime_Ret=370016;
--抵扣券信息变更
this.Shop_PayVoucher_Change=370017;
--皮肤返利领取记录
this.Shop_SkinRebate_Get_Record = 370018
--皮肤返利可领取记录
this.Shop_SkinRebate_Finish_Record = 370019
--设置抵扣券说明按钮
this.Shop_QuestionItem_Active=370020
--添加计时器
this.Shop_Timer_Add=370021
--删除计时器
this.Shop_Timer_Remove=370022
--提交购买
this.Shop_Pay_OnSubmit=370023
--自选物品索引变更
this.Shop_Pay_SelectIdx=370024
--显示选择列表
this.Shop_Pay_ShowSwitchList=370025
--选择列表选择完毕
this.Shop_Pay_SwitchListSubmit=370026
--购买时货币不够的跳转
this.Shop_Buy_NoMoneyJump=370027;
--商店购买
this.Shop_Dorm_OnSubmit=370028
--商店动画遮罩
this.Shop_Tween_Mask=370029;
--------------------------------------------引导
--引导完成
this.Guide_Complete = 380001
--引导单步骤完成
this.Guide_Step_Complete = 380002
--跳过本次引导
this.Guide_Skip = 380003
--触发引导
this.Guide_Trigger = 380004
--引导状态变化
--this.Guide_State_Changed=380005
--引导挂起
this.Guide_HangUp = 380006

--弱引导提示
this.Guide_Hint = 380007

--引导滚动界面调整
this.Guide_Scroll_Switch = 380008;
--引导自定义完成
this.Guide_Custom_Complete = 380009;

--引导关闭界面
this.Guide_Close_View = 380011;

--触发引导(开启界面)
this.Guide_Trigger_View = 3800012;

--引导界面显示状态（不影响功能）
this.Guide_SetShowState = 3800013;

--引导触发标志
this.Guide_Trigger_Flag = 3800014;

--置顶引导界面
this.Guide_View_SetTop = 3800015;
--跳过引导线
this.Guide_Skip_Line = 3800016;

-------------------------------------------公会
--推荐列表刷新
this.Guild_Recoment_Update = 390001
--个人申请记录刷新
this.Guild_ApplyLog_Update = 390002
--取消申请
this.Guild_Apply_Cancel = 390003
--退出公会/被踢
this.Guild_Quit = 390004
--公会信息刷新
this.Guild_Info_Refresh = 390005
--公会申请记录刷新
this.Guild_GuildApply_Update = 390006;
--公会玩家列表刷新
this.Guild_GuildMem_Update = 390007;
--公会申请记录结果
this.Guild_GuildApply_Return = 390008;
--公会玩家详情信息
this.Guild_GuildMem_Info = 390009;
--公会玩家权限变更
this.Guild_GuildTitle_Change = 390010;
--玩家权限有变化
this.Guild_MemTitle_Change = 390011;
--玩家列表有变化
this.Guild_GuildMem_Change = 390012;
--申请列表有新增
this.Guild_GuildApply_Add = 390013;
--公会头像变更
this.Guild_Icon_Change = 390014;
--玩家支援队伍信息
this.Guild_MemTeam_Info = 390015;
--加入通知
this.Guild_ApplyRet_Notice = 390016;
--公会战信息更新
this.Guild_FightInfo_Update = 390017;
--公会战房间数据更新
this.Guild_Rooms_Update = 390018;
--公会战排名信息返回
this.Guild_RankInfo_Ret = 390019;
--公会战战绩信息返回
this.Guild_LogInfo_Ret = 390020;


-------------------------------------------红点
--刷新红点
this.RedPoint_Refresh = 400001;

-------------------------------------------世界boss
this.WorldBoss_List = 410001;
this.WorldBoss_Enter = 410002;
this.WorldBoss_Start = 410003;
this.WorldBoss_Over = 410004;
this.WorldBoss_UpdateHP = 410005;
this.WorldBoss_Damage = 410006;
this.WorldBoss_RoleList = 410007;

--------------------------------------关卡
this.Dungeon_Data_Setted = 420001;
this.Dungeon_Group_Open = 420002;
this.Dungeon_PlotPlay_Over = 420003;--剧情类的关卡播放完毕
this.Dungeon_DailyData_Update = 420004 --日常变量更新
this.Dungeon_MainLine_Update = 420005 --主线更新
this.Dungeon_Box_Refresh = 420006 --星级奖励更新
this.Update_Dungeon_Data = 420007;--副本结束
this.Dungeon_InfoPanel_Update = 420008 --副本信息界面设置
this.Dungeon_Double_Update = 420009 --副本多倍更新
this.Dungeon_InfoItem_Update = 420010 --副本信息组件更新
this.Dungeon_MainLine_Guide_Refresh= 420011 --主线选关界面引导
this.Dungeon_TeamReplace_View_Refresh = 420012 -- 副本队伍推荐刷新
--------------------------------------组队boss
this.TeamBoss_List = 430001
this.TeamBoss_Room_Update = 430002 --房间更新
this.TeamBoss_Room_Leave = 430003  --离开房间
this.TeamBoss_Room_Start = 430004  --房间开始广播
this.TeamBoss_Invite_Update = 430005 --单房间邀请信息更新
this.TeamBoss_Over = 430006          --boss战时限

--------------------------------------宿舍
this.Dorm_Furniture_Add = 440001 --添加/移除家具
--this.Dorm_Role_Speak =440002 --添加说话文本
this.Dorm_Change = 440003 --切换房间
this.Dorm_Update = 440004 --房间更新/添加
this.Dorm_UseGiftRet = 440005 --使用礼物回调
this.Dorm_Theme_Buy = 440006 --购买主题
this.Dorm_Furniture_Buy = 440007 --购买单件家具
this.Dorm_Theme_Change = 440008 --房间更换主题
this.Dorm_SaveTheme_Change = 440022 --自由主题移除或者保存
this.Dorm_GetWorldTheme = 440009    --发现主题
this.Dorm_Change_Clothes = 440010    --更换服装
this.Dorm_Screenshot = 440011    --截图
this.Dorm_Share = 440012    --分享
this.Dorm_SetRoleList = 440013
this.Dorm_Furnitrue_Select = 440014  --编辑家具时，选中家具与否
--this.Dorm_Talk = 440015         --动作文本
this.Dorm_Role_Select = 440016  --选中角色与否
this.Dorm_Roles_Remove = 440017  --移除角色
this.Favour_CM_Success = 440018 --催眠成功回调
this.Dorm_UIFurnitrue_Click = 440019 --点击已放置的家具
this.Dorm_Furnitrues_Update = 440020 --编辑的家具发生改变
this.Dorm_Change_Clothes = 440021 --点击换装
-- 440022已占用
--------------------------------------聊天
this.Chat_UpdateInfos = 450001 --所有信息刷新
this.Chat_NewInfo_Menu = 450003 --主界面新信息

-------------------------------------AI预设
this.AIPreset_Update=460001;--数据更新
this.AIPreset_SetRet=460002;--数据保存完毕
this.AIPreset_Switch=460003;--切换方案
this.AIPreset_Use=460004;--队员使用了AI方案
this.AIPreset_ShowSkill=460005;--显示技能信息
this.AIPreset_Battle_SetRet=460006;--战斗中修改了AI预设

-----------------------------------勘探（大月卡）
this.Exploration_Init_Data=470001;--数据初始化
this.Exploration_Update_Data=470002;--数据更新
this.Exploration_Reveice_Ret=470003;--领取返回
this.Exploration_Upgrade_Ret=470004;--购买等级返回 
this.Exploration_Open_Ret=470005;--开通返回
this.Exploration_Click_Open=470006;--开通大月卡
this.Exploration_Click_Lv=470007;--点击等级
this.Exploration_Exp_TweenBegin=470008;--播放经验条动画
this.Exploration_Exp_TweenUp=470009;--播放经验条动画时升级
this.Exploration_TaskTime_Ret=470010;--获取勘探任务时间返回
this.SpecialExploration_Revice_Ret=470011;--获取特殊勘探领取返回
this.SpecialExploration_Info_Ret=470012;--获取特殊勘探数据返回
this.SpecialExploration_Tween_Over=470013;--特殊勘探无线滚动动画完毕

-----------------------------------爬塔
this.Tower_Update_Data = 480001
this.NewTower_ResetCnt_Update = 480002 --异构空间角色重置刷新
this.NewTower_CardInfo_Update_Finish = 480003 --异构空间角色协议接收完毕
this.NewTower_AssistCardInfo_Update_Finish=480004 --易构空间助战角色信息接收完毕

-----------------------------------活动关卡
this.Activity_Open_State = 490001 --活动关卡开启状态
this.TaoFa_Count_Refresh = 490002 --讨伐次数刷新
this.TaoFa_Count_BuyRefresh = 490003 --讨伐购买次数刷新
this.Arachnid_Count_Refresh = 490004 --活动购买次数刷新
this.Activity_Open_Refresh = 490005 --活动时间刷新
this.TotalBattle_Rank_Update = 490006 --十二星宫排行榜
this.Activity_Rank_Update= 490007 --活动排行榜
this.Trials_Panel_Refresh = 490008 --试炼界面刷新
this.Trials_List_Refresh = 490009 --试炼界面刷新
this.Dungeon_Activity_RankInfo = 490010 --活动排行榜信息
this.Trials2_Panel_Refresh = 490011 --连锁战线界面刷新

-----------------------------------战场
this.BattleField_Show_List = 500001 --战区设置
this.BattleField_BossData_Refresh = 500002 --战场boss数据刷新
this.BattleField_BossRank_Info = 500003 --战场boss排行榜

-----------------------------------扫荡
this.Sweep_Show_Panel = 510001
this.Sweep_Close_Panel = 510002

-----------------------------------------章节
this.Section_Red_Update = 520001
this.Section_Daily_Double_Update = 520002
this.Section_Guide_Update = 520003

-----------------------------------------等待
this.Wait_Panel_Close = 530001  --关闭等待界面

-----------------------------------------设置,BGM 
this.Setting_Window_Logout_Agree = 540001
this.BGM_Select = 540002
this.BGM_Set = 540003
-----------------------------------------通用购买窗口
this.Universal_Purchase_Refresh_Panel = 550001

this.Client_Init_Finish=550001;--客户端初始化完成

-----------------------------------------回归相关 
this.HuiGui_Check = 560001 --回归判断
--this.HuiGui_Res_Recovery = 560002 --资源找回 

-----------------------------------------成就
this.Achievement_Data_Update = 570001 --数据更新

-----------------------------------------徽章
this.Badge_Data_Update = 580001 --数据更新
this.Badge_Sort_Update = 580002 --装备位数据更新
-----------------------------------------特殊掉落
this.SpecialDrops_Info_Update = 590001 --掉落更新

--------------------------------道具池活动相关
this.ItemPool_Date_Update=600001;--道具池数据刷新
this.ItemPool_Draw_Ret=600002;--道具池抽卡返回
--------------------------------回归绑定活动相关
this.Collaboration_Info_Update=610001;--回归绑定数据刷新
this.Collaboration_TaskTab_Change=610002;--回归绑定tab变更
this.Collaboration_BindInvite_Ret=610003;--绑定请求结果返回
this.Collaboration_BindRecoment_Update=610004;--推荐列表更新
this.Collaboration_BindInvite_Update=610005;--申请绑定列表更新
this.Collaboration_BindReward_Ret=610009;--领取阶段奖励回调
this.Collaboration_InviteOption_Ret=610006;--绑定操作结果返回
this.Collaboration_StageTaskInfo_Ret=610007;--绑定任务阶段信息返回
this.Collaboration_Invite_Req=610008;--别人邀请绑定我

----------------------------------夏活宠物活动
this.PetActivity_Head_Click=620000;--宠物页签2点击
this.PetActivity_Tab_Click=620001;--宠物页签1点击
this.PetActivity_PetInfo_Ret=620002;--宠物信息返回
this.PetActivity_Sport_Ret=620003;--宠物运动返回信息
this.PetActivity_Switch_Ret=620004;--宠物切换返回
this.PetActivity_GainReward_Ret=620005;--领取宠物养成奖励返回
this.PetActivity_GainGift_Ret=620006;--领取宠物礼物奖励返回
this.PetActivity_UpdatePet_Ret=620007;--宠物更新返回
this.PetActivity_Bestiary_Ret=620008;--已解锁图鉴更新
this.PetActivity_BestiaryReward_Ret=620009;--领取图鉴奖励返回
this.PetActivity_SetLine_State=620010;--领取图鉴奖励返回
this.PetActivity_UseItem_Ret=620011;--使用物品返回
this.PetActivity_FSMState_Change=620012;--宠物状态变更
this.PetActivity_ActionBar_Set=620013;--动作倒计时框
this.PetActivity_AttrCount_Ret=620014;--本地宠物属性计算更新
this.PetActivity_TalkCond_Trigger=620015;--台词条件触发
this.PetActivity_EmojiCond_Trigger=620016;--宠物状态气泡检查条件触发
this.PetActivity_SportScene_Check=620017;--检查是否变更宠物运动场景
this.PetActivity_BagSelect_Change=620018;--宠物背包选择变更
this.PetActivity_TimeStamp_Change=620019;--宠物更新时间戳变更
this.PetActivity_Click_BookItem=620020;--点击图鉴奖励中的格子
this.PetActivity_Exit_Sport=620021;--退出运动状态
----------------------------------夏活宠物活动
this.Regression_Fund_Buy=630000 --回归基金购买
this.Hot_Supply_Refresh = 630001 -- 燃料补给刷新
this.Regression_Rebate_Refresh = 630002 --活跃返利界面刷新
----------------------------------爱相随
this.LovePlus_Chat_Update = 640000 --聊天数据更新
this.LovePlus_Data_Update = 640001 --章节数据更新
this.LovePlus_Story_Update =640002 --剧情数据更新
this.LovePlus_Spine_Select = 640003 --live2d动作选择
this.LovePlus_Story_Select = 640004 --节点选中
this.LovePlus_List_View_Change = 640005 -- 跳转界面
----------------------------------角斗场
this.Colosseum_Refresh_Time = 650000 --时间刷新
this.Colosseum_SelectCard = 650001 --选卡回调
this.Colosseum_RandomReward = 650002 --随机模式领奖
this.Colosseum_GetData = 650003 --获取赛季数据
----------------------------------设置
this.Setting_Live_Change = 660000 --直播设置
----------------------------------新世界boss
this.GlobalBoss_Data_Update = 670000 --数据刷新
this.GlobalBoss_Rank_Update = 670001 --活动排名刷新
--------------------------------------------------拼图活动
this.Puzzle_Data_Ret=680000--活动数据返回
this.Puzzle_Selected_Goods=680001--选择购买商品
this.Puzzle_Buy_Ret=680002 --购买返回
this.Puzzle_Unlock_Ret=680003 --解锁格子返回
this.Puzzle_GetReward_Ret=680004 --领取奖励返回
this.Puzzle_Item_TweenBegin=680005 --点击点亮
----------------------------------秘境探索
this.RogueMap_Ground_Inited = 690000 --场景初始化
this.RogueMap_Battle_View_Show = 690001 --显示场景UI
this.RogueMap_Battle_Character_Ctrl_Changed = 690002 --变更场景控制角色
this.RogueMap_Battle_Grid_Click = 690003 --点击格子
this.RogueMap_Battle_Step_Refresh = 690004 --步数显示
this.RogueMap_Battle_Grid_Keep = 690005 --滑动选择路径
this.RogueMap_Battle_View_Update = 690006 --更新场景UI
this.RogueMap_Battle_GridInfo_Create = 690007 --格子UI显示
this.RogueMap_Battle_Prop_Use = 690008 --道具使用
this.RogueMap_Battle_FloatFont_Show = 690009 --飘字显示
this.RogueMap_Battle_Support_Update = 690010 --副本支援刷新
this.RogueMap_Battle_Support_Show = 690011 --显示求援选择
this.RogueMap_Battle_Mist_Refresh = 690012 --刷新格子
this.RogueMap_Assist_Refresh = 690013 --支援列表刷新
this.RogueMap_Battle_GridEvent_Trigger = 690014 --格子事件触发
this.RogueMap_Log_Refresh = 690015 --日志刷新
this.RogueMap_Battle_Pass_Show = 690016 -- 通关窗口弹出
this.RogueMap_Boss_Grid_State_Update = 690017 --boss格子相关更新
this.RogueMap_Boss_UI_State_Update = 690018 --boss图标相关更新
this.RogueMap_Assist_Need_Update = 690019 --请求刷新援助
this.RogueMap_Update = 690020 --数据刷新
--------------------------------递归沙盒
this.MTB_Click_Dungeon=700001;--点击关卡
this.MTB_Click_Reward=700002;--点击结算奖励
this.MTB_Data_Update=700003;--活动数据更新

--------------------------------猜谜活动
this.Riddle_Data_Ret=710001;--猜谜活动数据返回
this.Riddle_Draw_Ret=710002;--猜谜活动答题返回
this.Riddle_Reward_Ret=710003;--猜谜活动领取奖励返回

--------------------------------光环
this.Halo_RangeSelected_Change=720001;--光环范围选择变更
this.Halo_RoleSelected_Change=720002;--光环主界面选择的卡牌变更
this.Halo_Upgrade_Ret=720003;--光环升级返回
this.Halo_Equip_Update=720004;--光环装备列表更新
this.Halo_Equip_Wear=720005;--光环装备穿戴/卸载
this.Halo_Equip_SellRet=720006;--光环装备分解
this.Halo_Upgrade_Ret2=720007;--光环升级返回2
this.Halo_EquipReplace_Close=720008;--光环替换界面关闭
--------------------------------万圣节
this.Halloween_data_Update = 730001 --数据更新

--大富翁
this.RichMan_data_Update=740001;--数据更新
this.RichMan_ActionQueue_Push=740002;--播放列表更新
this.RichMan_ActionQueue_Start=740003;--播放列表开始播放
this.RichMan_ActionQueue_End=740004;--播放列表结束播放
this.RichMan_Mask_Changed=740005;--更改遮罩状态
this.RichMan_Map_Update=740006;--地图更新
this.RichMan_GridIcon_Alpha=740007;--地图格子图标渐隐
this.RichMan_PlayRand_Begin=740008;--播放骰子动画
this.RichMan_PlayRand_Over=740009;--播放骰子动画结束
this.RichMan_LoadGrid_Quality=740010;--设置图标光晕效果
this.RichMan_Create_HUD=740011;--创建HUD
this.RichMan_Throw_Ret=740012;--投掷回调
this.RichMan_PlayTP_Begin=740013;--播放骰子动画
this.RichMan_PlayTP_Over=740014;--播放骰子动画结束
this.RichMan_Map_Refresh=740015;--地图刷新
this.RichMan_Dice_Refresh=740016;--骰子数量刷新
this.RichMan_Set_TargetEff=740017;--目标点特效
this.RichMan_UIState_Switch=740018;--切换主UI
this.RichMan_MoveAction_State=740019;--移动动作开始
this.RichMan_AutoThrow_Reward=740020;--自动投掷奖励返回
this.RichMan_AutoThrow_RewardOver=740021;--自动奖励展示完毕

-------------------------------------皮肤折扣券
this.SkinDeals_Update=750001;
-------------------------------------早餐卡
this.BreakfastCard_Update = 760001
-------------------------------------皮肤通行证
this.SkinPass_Update = 770001
-------------------------------------培养引导
this.CharacterRaising_Tab_Click = 780001
this.CharacterRaising_Update=780002
this.CharacterRaising_NewInfo_Update=780003
this.CharacterRaising_Reward_Update=780004
-------------------------------------虚数天灾
this.VirtualCataclysm_Panel_Update = 790001 --界面更新
this.VirtualCataclysm_Save_Update = 790002 --存档更新
this.Guide_VirtualCataclysm_Item_Select = 790003 --点击打开信息界面
-------------------------------------周期boss
this.PeriodicBoss_Panel_Update = 1000001 --界面更新
----------------------------------------------海外SDK----下-----------------------------------------------------
---通知SDK初始化
this.SDK_ShiryuSDK_Init=800001;
---SDK初始化完成 返回通知
this.SDK_ShiryuSDK_Init_complete=800002;
---获取SDK数据结构
this.SDK_ShiryuSDK_GetSdkProperties=800003;
---获取SDK数据结构完成数据返回
this.SDK_ShiryuSDK_GetSdkProperties_complete=800004;
---通知SDK登录
this.SDK_ShiryuSDK_Login=800005;
---通知SDK登录返回
this.SDK_ShiryuSDK_Login_complete=800006;
--- 登出---退出账号/切换账号时候
this.SDK_ShiryuSDK_Logout=800007;
---游戏退出杀死进程
this.SDK_ShiryuSDK_ExitGame=800008;
---SDK登出账号成功，游戏需在此做游戏切换账号操作
this.DK_ShiryuSDK_SetLogoutCallback=800009;
---SDK登出账号成功，游戏需在此做游戏切换账号操作完成数据返回结果
this.SDK_ShiryuSDK_SetLogoutCallback_complete=800010;
---获取商品列表
this.SDK_ShiryuSDK_GetGoodsList=800011;
--- 获取商品列表 返回
this.SDK_ShiryuSDK_GetGoodsList_complete=800012;
---支付接口
this.SDK_ShiryuSDK_Pay=800013;
--- 支付接口 返回
this.SDK_ShiryuSDK_Pay_complete=800014;
---  角色上报_创建角色调用
this.SDK_ShiryuSDK_OnCreateRole=800015;
--- 角色上报_角色进入区服
this.SDK_ShiryuSDK_OnLoginServe=800016;
--- 角色上报_玩家角色信息更新
this.SDK_ShiryuSDK_OnRoleInfoUpdate=800017;
---角色上报_设置角色名称
this.SDK_ShiryuSDK_OnSetRoleName=800018;
---屏幕自适应 关闭 UI页面数据
this.LuaView_Lua_Closed=800019;
---抵扣券支付完成
this.SDK_Deduction_voucher_paymentcompleted=800020;
---分享功能通知 下一帧截图
this.ShareView_NoticeTheNextFrameScreenshot=800021;
---分享通知截图完成
this.ShareView_NoticeScreenshotCompleted=800022;
----------------------------------------------海外SDK----上
this.SDK_ShiryuSDK_GetActivitys = 800023;
this.SDK_ShiryuSDK_GetActivitys_Complete = 800024;
this.SDK_ShiryuSDK_Redeem = 800025;
this.SDK_ShiryuSDK_Redeem_Complete = 800026;-----------------------------------------------------

----------------------------配置读取进度
this.Read_Cfg_Progress = 900001;
this.Read_Cfg_Complete = 900002;

return this; 