require("oo")
-- require("LuaPanda").start("127.0.0.1", 8818) 
--通用工具
require "CommonUtil"
--战斗启动
require "FightLauncher"
require("GCalculatorHelp");
--SDK
require "ShiryuSDK"
cfgLaucher = nil
function Awake()	
    if(not CSAPI.GetSingletonGO())then
        LogError("singleton gameObject is nil");
    end

	InitLogState();
	
	Log("Xlua启动完成")
	--LogTime()
	Launcher()

	--关闭AB包大小检测
	PlayerPrefs.SetInt("close_ab_size_proof",0);
end
--初始化日志状态
function InitLogState()
	local logState = PlayerPrefs.GetInt("key_log_state");
	
	if(logState and logState > 0) then
		_G.noLog = nil;
	end
end

function Launcher()
	--ReadAllConfig();
	cfgLaucher = Cfgs.launcher:GetByID(1)

    CSAPI.AddPersistentABs(cfgLaucher.base_abs);
    CSAPI.AddPersistentABs(cfgLaucher.auto_load_abs);
    CSAPI.AddPersistentABs(cfgLaucher.persistent_abs);
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_START_PRELOADING_RESOURCES)
	end
	--加载基础资源包
	LoadABs(cfgLaucher.base_abs)
end

----加载资源包
function LoadABs(abs)
	CSAPI.SetABLoadAsync(false)
	CSAPI.LoadABsByOrder(abs, OnLoadABsComplete, true, false)
end

function OnLoadABsComplete()
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_FINISH_PRELOADING_RESOURCES)
	end
	--LogTime("加载基础资源完成");
	local parent = CSAPI.GetSingletonGO();
	
	--自动创建对象
	if(cfgLaucher.auto_create_res ~= nil) then
		for _, v in pairs(cfgLaucher.auto_create_res) do
			CSAPI.CreateGO(v, 0, 0, 0, parent)
		end
	end
	
	--LogTime("自动创建对象完成");
	--Lua系统初始化
	Init()
	
	--LogTime("Init完成");
	--自动开启的界面
	if(cfgLaucher.auto_open_views ~= nil) then
		for _, v in pairs(cfgLaucher.auto_open_views) do
			CSAPI.OpenView(v)
		end
	end
	--LogTime("自启界面完成");
end

function OnLoadCommonABComplete()
	--LogTime("加载公用资源包完成")
end

--游戏启动后必须初始化的系统
function Init()
	--Log("Xlua开始初始化基础系统")
	NetMgr:Init()
	ResUtil:Init()
	
	InitSceneTypeDatas()
	InitSceneDatas()
	InitViewDatas()

	Init1();	
end

function Init1()
	InitForReadCfg();

	-- 读配置表的新loading
    ConfigParser.isClientInit = true
	ReadAllConfig()
	ConfigParser.isClientInit = nil
	-- FuncUtil:Call(ReadAllConfig,nil,500);
end

function Init2()    
    --多语言
	LanguageMgr:Init()
	--数数sdk
	ThinkingAnalyticsMgr:Init()
	
	CSAPI.SetGOActive(CSAPI.GetGlobalGO("CommonRT"), false)
    
    --CSAPI.CreateGO("LuaTest")

    CSAPI.OpenView("ColorMask");
    FuncUtil:Call(LoadFirstScene,nil,500);   

	--习惯设置
	SettingMgr:Init();
	FuncUtil:Call(SettingMgr.LoginSoundSet,SettingMgr,50);
end

function LoadFirstScene()
    EventMgr.AddListener(EventType.Loading_Complete, OnLoginSceneLoaded)
	Log("进入第一个场景" .. cfgLaucher.first_scene_key)
	EventMgr.Dispatch(EventType.Scene_Load, cfgLaucher.first_scene_key)
	
    --FuncUtil:Call(EventMgr.Dispatch,nil,10,EventType.Loading_View_Delay_Close,1000);
end

--初始化场景类型数据
function InitSceneTypeDatas()
	local cfgSceneTypes = Cfgs.scene_type:GetAll()
	
	local InitSceneTypeData = CS.CSAPI.InitSceneTypeData
	
	for _, v in pairs(cfgSceneTypes) do
		InitSceneTypeData(v.id, v.res, v.views)
	end
end
--初始化场景数据
function InitSceneDatas()
	local cfgScenes = Cfgs.scene:GetAll()
	
	local InitSceneData = CS.CSAPI.InitSceneData
	
	for _, v in pairs(cfgScenes) do
		InitSceneData(v.id, v.key, v.name, v.type, v.res, v.views)
	end
end

--初始化场景类型数据
function InitViewDatas()
	local cfgs = Cfgs.view:GetAll()
	
	local InitViewData = CS.CSAPI.InitViewData
	
	for _, v in pairs(cfgs) do
		local layerName = v.layer or ""
		
		local uniqueness = true
		if(v.multi) then
			uniqueness = false
		end
		--local donHidePreView = v.dont_hide_pre_view and true or false
		local donCloseWhenLoad = v.dont_close_when_load and true or false
		local donCloseWhenCloseAll = v.dont_close_when_close_all and true or false
		
		local mask = v.mask and true or false
        local isWindow = v.is_window and true or false;
		
		InitViewData(v.key, v.res, layerName, uniqueness, donCloseWhenLoad, donCloseWhenCloseAll, mask,isWindow)
	end
end


function OnLoginSceneLoaded()
    FuncUtil:Call(EventMgr.Dispatch,nil,500,EventType.Common_Color_Mask_Close);
    --EventMgr.Dispatch(EventType.Common_Color_Mask_Close);

    local criMovie = ResUtil:PlayVideo("login_enter");
	criMovie:AddCompleteEvent(function()
		EventMgr.Dispatch(EventType.Login_White_Mask_FadeOut);
	end)

	EventMgr.RemoveListener(EventType.Loading_Complete, OnLoginSceneLoaded)
	
	--加载公用资源包
	CSAPI.SetABLoadAsync(true)
	CSAPI.LoadABsByOrder(cfgLaucher.auto_load_abs, OnLoadCommonABComplete, true, false)
	
	--读取所有配置，--提交到前面加载
	--ReadAllConfig()
	
	--服务端启动脚本
	require "ServerLauncher"
	--模块脚本
	require "Module"
	
	--服务端逻辑
	FuncUtil:Timer(FightMgrTimer, nil, 0, 1000)

	--引导初始化
	GuideMgr:Init();	

    --习惯设置
    -- SettingMgr:Init();
    --if(CSAPI.GetGlobalGO("CommonRT"))then
	--	 SettingMgr:LoginSet();
	--else
		--音量的设置提交到前面加载
		FuncUtil:Call(SettingMgr.LoginSet,SettingMgr,50);
	--end

	--多语言 
	--LanguageMgr:ChangeLanguage(4) --1234  中文，繁体，日语，英文
    local verSetting = require "VerSetting";
    verSetting:Init();

    PreCreate();

    --登录场景刚初始化完成，小段时间内禁止点击
    CSAPI.DisableInput(500);
end

function PreCreate()  
	for i=1,20 do
		ResUtil:CreateUIGOAsync("Grid/GridItem", gameObject, function(go)
			local tab = ComUtil.GetLuaTable(go)
			tab.Remove();
		end)
	end
end


-------配置加载进度显示-------
--读取配置前的初始化
local cfgBar = nil;
local txtBar = nil;
function InitForReadCfg()	
	local launcher = transform and transform.parent and transform.parent.gameObject;
	local bar = ComUtil.GetComInChildren(launcher,"BarBase");
	cfgBar = bar;	
	local barParent = bar and bar.transform.parent.parent.parent;
	if(not barParent)then
		return;
	end
	local childCount = barParent.childCount;

	local isUpdateNodeActive = false;
	for i = 0,childCount - 1 do
		local t = barParent:GetChild(i);
		if(t.name == "updateNode")then
			isUpdateNodeActive = t.gameObject.activeInHierarchy;
		elseif(t.name == "block")then
			txtBar = ComUtil.GetComInChildren(t.gameObject,"Text");
		elseif(t.name == "img")then
			if(t.gameObject.activeInHierarchy)then
				local descBar = ComUtil.GetComInChildren(t.gameObject,"Text");
				descBar.text = "loading...";
			end
			
		end
		--LogError(string.format("name = %s,active = %s",t.name,t.gameObject.activeInHierarchy));
	end
	if(not isUpdateNodeActive)then
		local imageCom = ComUtil.GetCom(barParent.gameObject,"Image");
		if(imageCom)then
			imageCom.enabled = false;
		end
		barParent:SetSiblingIndex(1);
	end

	EventMgr.AddListener(EventType.Read_Cfg_Progress, OnUpdateCfgProgress);
	EventMgr.AddListener(EventType.Read_Cfg_Complete, OnCfgComplete);

	SetCfgReadProgress(1,true);
	--EventMgr.Dispatch(EventType.Read_Cfg_Progress,1);

	-- ---模拟进度
	-- FuncUtil:Call(function()
	-- 	EventMgr.Dispatch(EventType.Read_Cfg_Progress,20);
	-- end,nil,100);
	-- FuncUtil:Call(function()
	-- 	EventMgr.Dispatch(EventType.Read_Cfg_Complete);
	-- end,nil,1000);
end

function OnUpdateCfgProgress(p)
	SetCfgReadProgress(p);
end
function OnCfgComplete()
	SetCfgReadProgress(100,true);
	Init2();

	EventMgr.RemoveListener(EventType.Read_Cfg_Progress, OnUpdateCfgProgress);
	EventMgr.RemoveListener(EventType.Read_Cfg_Complete, OnCfgComplete);
end

function SetCfgReadProgress(p,immediatelyFill)
	p = math.ceil(p);
	p = math.max(5,p);
	p = math.min(100,p);
	if(cfgBar)then
		cfgBar:SetFullProgress(p,100,immediatelyFill and true or false);
	end
	if(txtBar)then
		txtBar.text = string.format("%s%%",tostring(p));
	end
end