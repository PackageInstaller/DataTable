local this = {};

--判定C#对象是否为空
function _G.IsNil(uobj)
	return uobj == nil or(uobj.Equals and uobj:Equals(nil));
end

--加载场景
--1：CSAPI.Load(123);
--2：CSAPI.Load("sceneName");
this.LoadScene = CS.CSAPI.LoadScene;
--预加载场景
this.PreLoadScene = CS.CSAPI.PreLoadScene;
--加载prefab
--CSAPI.LoadPrefab("prefabName",func);
this.LoadPrefab = CS.CSAPI.LoadPrefab;
--获取prefab，目标prefab必须已加载到内存
--CSAPI.GetPrefab("prefabName");
this.GetPrefab = CS.CSAPI.GetPrefab;


--加载sprite
--CSAPI.LoadSprite("spriteName",func);
--this.LoadSprite = CS.CSAPI.LoadSprite;
--获取sprite，目标sprite必须已加载到内存
--CSAPI.GetSprite("spriteName");
--this.GetSprite = CS.CSAPI.GetSprite;
--加载sprite到Image对象中
this.csLoadImg = CS.CSAPI.LoadImg;
this.csLoadImgInModule = CS.CSAPI.LoadImgInModule;

--inModule：是否模块中的sprite（放在prefab目录下）
function this.LoadImg(target, res, nativeSize, callBack, inModule)
	nativeSize = nativeSize == nil and true or nativeSize;
	if(inModule) then		
		this.csLoadImgInModule(target, res, nativeSize, callBack);
	else
		this.csLoadImg(target, res, nativeSize, callBack);
	end
end
--加载sprite到SpriteRenderer对象中
this.LoadSR = CS.CSAPI.LoadSR;
this.LoadSRInModule = CS.CSAPI.LoadSRInModule;
----inModule：是否模块中的sprite（放在prefab目录下）
--function this.LoadSR(target,res,callBack,inModule)
--    nativeSize = nativeSize==nil and true or nativeSize;
--    if(inModule)then        
--        this.csLoadImgInModule(target,res,nativeSize,callBack);
--    else
--        this.csLoadImg(target,res,nativeSize,callBack);
--    end
--end
--设置SpriteRenderer尺寸
this.SetSRSize = CS.CSAPI.SetSRSize;

--设置UI组件尺寸
this.SetRectSize = CS.CSAPI.SetRectSize;

this.GetCanvasMatch = CS.CSAPI.GetCanvasMatch;

--设置SpriteRenderer颜色
this.SetSRColor = CS.CSAPI.SetSRColor;

--设置Image灰色状态
this.csSetGrey = CS.CSAPI.SetGrey;
function this.SetGrey(go, isGrey, includeChildren)
	--LogError(go.name .. ":" .. tostring(isGrey) .. ":" .. tostring(includeChildren));
	this.csSetGrey(go, isGrey, includeChildren or false);
end

--有黑色遮罩状态
function this.SetImgMask(go, isMask, includeChildren)
	local value = isMask and 100 or 255
	this.SetImgColor(go, value, value, value, 255, includeChildren)
end

--设置Image颜色
this.csSetImgColor = CS.CSAPI.SetImgColor;
function this.SetImgColor(go, r, g, b, a, includeChildren)
	
	if(go == nil) then
		LogError("不能设置颜色，目标为空！！！");
	end
	
	r = r or 1;
	g = g or 1;
	b = b or 1;
	a = a or 1;
	includeChildren = includeChildren or false;
	this.csSetImgColor(go, r, g, b, a, includeChildren);
end
--设置Image颜色
this.csSetImgColorByCode = CS.CSAPI.SetImgColorByCode;
function this.SetImgColorByCode(go, code, includeChildren)
	if(go == nil) then
		LogError("不能设置颜色，目标会空！！！");
	end
	code = code or "FFFFFF"
	includeChildren = includeChildren or false;
	this.csSetImgColorByCode(go, code, includeChildren);
end
             
--设置Image颜色
this.csSetImgColorByCode2 = CS.CSAPI.SetImgColorByCode2;
function this.SetImgColorByCode2(go, code, includeChildren)
	if(go == nil) then
		LogError("不能设置颜色，目标会空！！！");
	end
	code = code or "FFFFFF"
	includeChildren = includeChildren or false;
	this.csSetImgColorByCode2(go, code, includeChildren);
end

--设置Text颜色
this.csSetTextColorByCode = CS.CSAPI.SetTextColorByCode;
function this.SetTextColorByCode(go, code, includeChildren)
	if(go == nil) then
		LogError("不能设置颜色，目标会空！！！");
	end
	code = code or "FFFFFF"
	includeChildren = includeChildren or false;
	this.csSetTextColorByCode(go, code, includeChildren);
end

--设置Text颜色
this.csSetTextColor = CS.CSAPI.SetTextColor;
function this.SetTextColor(go, r, g, b, a, includeChildren)
	
	if(go == nil) then
		LogError("不能设置颜色，目标会空！！！");
	end
	
	r = r or 1;
	g = g or 1;
	b = b or 1;
	a = a or 1;
	includeChildren = includeChildren or false;
	this.csSetTextColor(go, r, g, b, a, includeChildren);
end
--设置内容
this.SetText = CS.CSAPI.SetText;
--设置按钮状态
this.SetBtnState = CS.CSAPI.SetBtnState;
--禁用输入一段时间
this.DisableInput = CS.CSAPI.DisableInput;
--this.csDisableInput = CS.CSAPI.DisableInput;
--function this.DisableInput(time)
--    LogError(time);
--    this.csDisableInput(time);
--end
--设置秒变颜色
this.SetOutlineColor = CS.CSAPI.SetOutlineColor;
--播放Spine动画 todo 
-- this.csPlaySpine = CS.CSAPI.PlaySpine;
-- function this.PlaySpine(go, animationName, loop, trackIndex)
-- 	if(loop == nil) then
-- 		loop = false;
-- 	end
-- 	this.csPlaySpine(go, animationName, loop, trackIndex or 0);
-- end
--添加下拉菜单选项
this.AddDropdownOptions = CS.CSAPI.AddDropdownOptions;
--添加下拉菜单选项2
this.AddDropdownOptions2 = CS.CSAPI.AddDropdownOptions2;
--添加下拉菜单选择回调
this.AddDropdownCallBack = CS.CSAPI.AddDropdownCallBack;
--移除下拉菜单选择回调
this.RemoveDropdownCallBack = CS.CSAPI.RemoveDropdownCallBack;
--添加toggle选择回调
this.AddToggleCallBack = CS.CSAPI.AddToggleCallBack;
--移除Toggle选择回调
this.RemoveToggleCallBack = CS.CSAPI.RemoveToggleCallBack;
--设置Toggle状态
this.SetToggle = CS.CSAPI.SetToggle;
--InputField改变事件
this.AddInputFieldChange = CS.CSAPI.AddInputFieldChange
--InputField输入结束回调事件
this.RemoveInputFieldChange = CS.CSAPI.RemoveInputFieldChange
--移除InputField改变事件
this.AddInputFieldCallBack = CS.CSAPI.AddInputFieldCallBack
--移除InputField输入结束回调事件
this.RemoveInputFieldCallBack = CS.CSAPI.RemoveInputFieldCallBack
--Slider改变事件
this.AddSliderCallBack = CS.CSAPI.AddSliderCallBack
--移除Slider改变事件
this.RemoveSliderCallBack = CS.CSAPI.RemoveSliderCallBack
--设置slider
this.SetSlider = CS.CSAPI.SetSlider
--设置帧率（不开启垂直同步状态下才有效）
this.SetTargetFrameRate = CS.CSAPI.SetTargetFrameRate
--设置垂直同步数 (弃用该方法，因为游戏质量关联了这个属性，所以要固定为Dont Sync  rui20220117)
--this.SetVSyncCount = CS.CSAPI.SetVSyncCount
function this.SetImgValidState(go, isValid, includeChildren)
	local colorValue = isValid and 255 or 128;
	this.SetImgColor(go, colorValue, colorValue, colorValue, 255, includeChildren);	
end


--克隆
this.CloneGO = CS.Util.CloneGO; --(target,parent)
--单例根节点
this.singletonRoot = CS.Util.singletonRoot;

function this.GetSingletonGO()
	this.singletonGO = this.singletonGO or this.singletonRoot.gameObject;
	return this.singletonGO;
end

--设置父节点
this.SetParent = CS.Util.SetParent;  --(target,parent)
--设置对象激活状态
this.SetGOActive = CS.Util.SetGOActive;
--移除对象
this.RemoveGO = CS.Util.RemoveGO;
--随机Vector3
function this.RandomV3(x, y, z)
	y = y or x;
	z = z or x;
	
	x = this.RandomFloat(- x, x);
	y = this.RandomFloat(- y, y);
	z = this.RandomFloat(- z, z);
	
	return x, y, z;
end

function this.RandomInt(min, max)
	return math.random(min, max);
end
function this.RandomFloat(min, max)
	local value = math.random();
	return min +(max - min) * value;
end

--异步创建对象
--public static void CreateGOAsync(string prefabName, float x = 0, float y = 0, float z = 0, Transform parent = null,System.Action<GameObject> callBack = null)
this.CreateGOAsync = CS.CSAPI.CreateGOAsync;
--创建对象
--public static GameObject CreateGO(string prefabName, float x = 0, float y = 0, float z = 0,Transform parent = null)
this.CreateGO = CS.CSAPI.CreateGO;
this.CreateGOWithParent = CS.CSAPI.CreateGOWithParent;


this.GetGlobalGO = CS.CSAPI.GetGlobalGO;

--设置位置
this.SetPos = CS.CSAPI.SetPos;
--获取位置
this.csGetPos = CS.CSAPI.GetPos;
function this.GetPos(go)
	local arr = this.csGetPos(go);
	if(arr) then
		return arr[0], arr[1], arr[2];
	end
	return 0, 0, 0;
end

this.csGetPosScene2UI = CS.CSAPI.GetPosScene2UI;
function this.GetPosScene2UI(go)
	local arr = this.csGetPosScene2UI(go);
	if(arr) then
		return arr[0], arr[1], arr[2];
	end
	return 0, 0, 0;
end

--this.Scene2UI = CS.CSAPI.Scene2UI;
--this.UI2Scene = CS.CSAPI.UI2Scene;
--设置位置(RectTransform)
this.SetAnchor = CS.CSAPI.SetAnchor;
--获取位置(RectTransform)
this.csGetAnchor = CS.CSAPI.GetAnchor;
function this.GetAnchor(go)
	local arr = this.csGetAnchor(go);
	if(arr) then
		return arr[0], arr[1], arr[2];
	end
	return 0, 0, 0;
end
--设置大小(RectTransform)
this.SetRTSize = CS.CSAPI.SetRTSize;
--获取大小(RectTransform)
this.GetRTSize = CS.CSAPI.GetRTSize;
--真实大小，不随锚点变化
this.GetRealRTSize = CS.CSAPI.GetRealRTSize;  --获取过慢
--设置相对位置
this.SetLocalPos = CS.CSAPI.SetLocalPos;
--获取相对位置
this.csGetLocalPos = CS.CSAPI.GetLocalPos;
function this.GetLocalPos(go)
	local arr = this.csGetLocalPos(go);
	if(arr) then
		return arr[0], arr[1], arr[2];
	end
	return 0, 0, 0;
end
--设置缩放
this.SetScale = CS.CSAPI.SetScale;
--获取缩放
this.csGetScale = CS.CSAPI.GetScale;
function this.GetScale(go)
	local arr = this.csGetScale(go);
	if(arr) then
		return arr[0], arr[1], arr[2];
	end
	return 1, 1, 1;
end

--设置相对欧拉角
this.SetAngle = CS.CSAPI.SetAngle;
--获取相对欧拉角
this.csGetAngle = CS.CSAPI.GetAngle;
--设置相对欧拉角
this.SetRectAngle = CS.CSAPI.SetRectAngle;
--获取相对欧拉角
this.GetRectAngle = CS.CSAPI.GetRectAngle;
function this.GetAngle(go)
	local arr = this.csGetAngle(go);
	if(arr) then
		return arr[0], arr[1], arr[2];
	end
	return 0, 0, 0;
end

--设置绝对欧拉角
this.SetWorldAngle = CS.CSAPI.SetWorldAngle;
--获取绝对欧拉角
this.csGetWorldAngle = CS.CSAPI.GetWorldAngle;
function this.GetWorldAngle(go)
	local arr = this.csGetWorldAngle(go);
	return arr[0], arr[1], arr[2];
end

this.FaceToTarget = CS.CSAPI.FaceToTarget;

this.StringToHash = UnityEngine.Animator.StringToHash


this.ApplyAction = CS.CSAPI.ApplyAction;
--移动到指定位置
this.csMoveTo = CS.CSAPI.MoveToByTime;
--线性移动
function this.MoveTo(go, actionName, x, y, z, callBack, time, delay)
	if(go == nil) then
		LogError("移动目标不能为空，强制报错");
		LogError(a.b);
	end
	
	actionName = StringUtil:IsEmpty(actionName) and "move_linear" or actionName;
	x = x or 0;
	y = y or 0;
	z = z or 0;
	time = time or - 1;
	delay = delay or 0
	return this.csMoveTo(go, actionName, x, y, z, callBack, time, delay);
end
--移动到指定位置
this.csMoveToBySpeed = CS.CSAPI.MoveToBySpeed;
--线性移动
function this.MoveToBySpeed(go, actionName, x, y, z, callBack, speed, delay)
	actionName = actionName or "MoveToLinear";
	x = x or 0;
	y = y or 0;
	z = z or 0;
	speed = speed or - 1;
	delay = delay or 0
	this.csMoveToBySpeed(go, actionName, x, y, z, callBack, speed, delay);
end
--旋转 Transform
this.csRotateByTime = CS.CSAPI.RotateByTime;
function this.RotateTo(go, actionName, x, y, z, callBack, time, delay)
	if(go == nil) then
		LogError("旋转目标不能为空，强制报错");
		LogError(a.b);
	end
	
	actionName = StringUtil:IsEmpty(actionName) and "action_rotate_to_front" or actionName;
	x = x or 0;
	y = y or 0;
	z = z or 0;
	time = time or - 1;
	delay = delay or 0
	this.csRotateByTime(go, actionName, x, y, z, callBack, time, delay);
end
--旋转 ui (RectTransform)
this.csRotateUIByTime = CS.CSAPI.RotateUIByTime;
function this.RotateUITo(go, actionName, x, y, z, callBack, time, delay)
	if(go == nil) then
		LogError("旋转目标不能为空，强制报错");
		LogError(a.b);
	end
	
	actionName = StringUtil:IsEmpty(actionName) and "action_rotateUI_to_front" or actionName;
	x = x or 0;
	y = y or 0;
	z = z or 0;
	time = time or - 1;
	delay = delay or 0
	return this.csRotateUIByTime(go, actionName, x, y, z, callBack, time, delay);
end
--大小缩放 ui (RectTransform)
this.csSetUIScaleByTime = CS.CSAPI.SetUIScaleByTime;
function this.SetUIScaleTo(go, actionName, x, y, z, callBack, time, delay)
	if(go == nil) then
		LogError("旋转目标不能为空，强制报错");
		LogError(a.b);
	end
	
	actionName = StringUtil:IsEmpty(actionName) and "action_UIScale_to_front" or actionName;
	x = x or 0;
	y = y or 0;
	z = z or 0;
	time = time or - 1;
	delay = delay or 0
	this.csSetUIScaleByTime(go, actionName, x, y, z, callBack, time, delay);
end
--color改变 限Image 
this.csSetUIColorByTime = CS.CSAPI.SetUIColorByTime;
function this.SetUIColorTo(go, actionName, x, y, z, w, callBack, time, delay)
	if(go == nil) then
		LogError("旋转目标不能为空，强制报错");
		LogError(a.b);
	end
	
	actionName = StringUtil:IsEmpty(actionName) and "action_UIColor_to_front" or actionName;
	x = x or 0;
	y = y or 0;
	z = z or 0;
	w = w or 0;
	time = time or - 1;
	delay = delay or 0
	this.csSetUIColorByTime(go, actionName, x, y, z, w, callBack, time, delay);
end

--从a点移动到b点
this.MoveToByTime2 = CS.CSAPI.MoveToByTime2

--获取SoketMgr
this.GetSocketMgr = CS.CSAPI.GetSocketMgr;

--按序加载一组资源包
this.csLoadABsByOrder = CS.CSAPI.LoadABsByOrder;
function this.LoadABsByOrder(abNames, callBack, isPersistent, loadDenpendency)
	if(isPersistent == nil) then
		isPersistent = false;
	end
	if(loadDenpendency == nil) then
		loadDenpendency = true;
	end
	
	this.csLoadABsByOrder(abNames, callBack, isPersistent, loadDenpendency);	
end
--设置是否使用异步形式加载资源包
this.SetABLoadAsync = CS.CSAPI.SetABLoadAsync;
--释放资源包
this.ReleaseAB = CS.CSAPI.ReleaseAB;


--场景UI元素
this.AddSceneUIElement = CS.CSAPI.AddSceneUIElement;
--UI跟随场景目标
this.csAddUISceneElement = CS.CSAPI.AddUISceneElement;
function this.AddUISceneElement(ui,target,goCamera)
	if(not target)then
		return;
	end
	this.csAddUISceneElement(ui,target,goCamera);
end
--设置翻转状态
this.SetUISceneElementFlip = CS.CSAPI.SetUISceneElementFlip;

--添加跟随组件
--(GameObject target,GameObject followTarget, GameObject goCameraFrom, GameObject goCameraTo)
this.AddPosFollow_C2C = CS.CSAPI.AddPosFollow_C2C;
--设置相机渲染目标
this.SetCameraRenderTarget = CS.CSAPI.SetCameraRenderTarget;
--设置相机深度
this.SetCameraDepth = CS.CSAPI.SetCameraDepth;
--增加相机深度
this.AddCameraDepth = CS.CSAPI.AddCameraDepth;
--设置渲染图
this.SetRenderTexture = CS.CSAPI.SetRenderTexture;
--延迟调用
this.DelayCall = CS.CSAPI.DelayCall;

--打开界面
this.csOpenView = CS.CSAPI.OpenView;
--打开界面
--closeAll:关闭其它 默认为false，顶头跳转时用到
--jump:跨场景  默认为true
function this.OpenView(viewKey, data, openSetting, callBack, closeAll, jump)
	if(viewKey == nil) then
		LogError("打开界面失败，view key无效");
		return;
	end
	DebugLog("打开界面" .. viewKey);
	closeAll = closeAll == nil and false or closeAll
	jump = jump == nil and true or jump
	if(jump) then
		UIUtil:OpenView(viewKey, closeAll, function()
			this.csOpenView(viewKey, data, openSetting, function(go)
				UIUtil:AddQuestionItem(viewKey, go)
				AdaptiveConfiguration.SetLuaObjUIFit(viewKey,go.gameObject)
				if(callBack) then
					callBack(go)
				end
			end)
		end)
	else
		this.csOpenView(viewKey, data, openSetting, function(go)
			UIUtil:AddQuestionItem(viewKey, go)
			AdaptiveConfiguration.SetLuaObjUIFit(viewKey,go.gameObject)
			if(callBack) then
				callBack(go)
			end
		end)
	end
end
--关闭界面
this.CloseView = CS.CSAPI.CloseView;
--关闭所有打开的界面
this.CloseAllOpenned = CS.CSAPI.CloseAllOpenned;
--function this.CloseAllOpenned()
--    CS.CSAPI.CloseAllOpenned();
--end
--显示UI
this.ShowUI = CS.CSAPI.ShowUI;
--界面是否开启
this.IsViewOpen = CS.CSAPI.IsViewOpen;
this.IsLastOpenedView = CS.CSAPI.IsLastOpenedView;

--获取界面容器
this.GetViewPanel = CS.CSAPI.GetViewPanel;
--获取界面
this.GetView = CS.CSAPI.GetView
----添加按钮点击事件
--this.csAddClickEvent = CS.CSAPI.AddClickEvent
--function this.AddClickEvent(btn,func,enableClickScaleEffect)
--    enableClickScaleEffect = enableClickScaleEffect or true;
--    this.csAddClickEvent(btn,func,enableClickScaleEffect);
--end
--获取时间，游戏暂停，计时也会暂停
this.GetTime = CS.CSAPI.GetTime;
--获取时间，游戏暂停也会继续计时
this.GetRealTime = CS.CSAPI.GetRealTime;
--设置时间缩放
this.SetTimeScale = CS.CSAPI.SetTimeScale;
--设置时间缩放(指定key)
this.SetTimeScaleByKey = CS.CSAPI.SetTimeScaleByKey;
--设置时间速度控制状态
this.SetTimeScaleLockState = CS.CSAPI.SetTimeScaleLockState;
--移除时间缩放(指定key)
this.RemoveTimeScaleByKey = CS.CSAPI.RemoveTimeScaleByKey;
this.ClearTimeScaleCtrl = CS.CSAPI.ClearTimeScaleCtrl;

--获取服务端时间438
this.GetServerTime = CS.CSAPI.GetServerTime;
--获取服务器星期索引
this.GetServerWeekIndex = CS.CSAPI.GetServerWeekIndex;  --1234560
function this.GetWeekIndex() --1-7
	local weekIndex = this.GetServerWeekIndex()
	weekIndex = weekIndex == 0 and 7 or weekIndex
	return weekIndex
end

--格式化字符串
this.FormatString = CS.CSAPI.FormatString;
--返回网络数据
this.GetServerInfo = CS.CSAPI.GetServerInfo;

this.GC = CS.CSAPI.GC;
this.csApplyReleaseRes = CS.CSAPI.ApplyReleaseRes;
function this.ApplyReleaseRes()
	this.csApplyReleaseRes(true);
end
this.GetPlatform = CS.CSAPI.GetPlatform;
--强行释放资源
this.ApplyReleaseForce = CS.CSAPI.ApplyReleaseForce;
--强行释放资源
this.AddPersistentABs = CS.CSAPI.AddPersistentABs;

--设置天空盒
this.SetSkyBox = CS.CSAPI.SetSkyBox;

--获取游戏质量
this.GetGameQualityLv = CS.CSAPI.GetGameQualityLv;
--获取画质等级
function this.GetImgLv()
	local lv = this.GetGameQualityLv() or 3;
	lv =(lv >= 5 and 3) or(lv >= 3 and 2) or 1;
	return lv;
end

--设置游戏质量
this.SetGameQualityLv = CS.CSAPI.SetGameQualityLv;
--设置图像层
this.SetGraphicsTier = CS.CSAPI.SetGraphicsTier;
--设置Shader LOD
this.SetShaderLOD = CS.CSAPI.SetShaderLOD;
--设置烘焙光启动状态
this.SetLightMapEnableState = CS.CSAPI.SetLightMapEnableState;
--设置雾启动状态
this.SetFogEnableState = CS.CSAPI.SetFogEnableState;
loadstring = CS.CSAPI.LoadString;

--设置游戏（品质）等级
--1：低
--2：中
--3：高
function this.SetGameLv(lv)
	this.gameLv = lv;
	
	CameraMgr:SetMotionBlurState(lv and lv >= 2);
	--CameraMgr:SwitchHDR(lv and lv >= 3);
	CSAPI.SetFogEnableState(lv and lv >= 3);
	CSAPI.SetShaderLOD(lv >= 3 and 700 or(lv >= 2 and 600) or 500)
	
	local tier = 1;
	local gameQualityLv = 1;
	
	if(lv >= 3) then
		tier = 1;
		gameQualityLv = 5;
	elseif(lv >= 2) then
		tier = 1;
		gameQualityLv = 3;
	elseif(lv >= 1) then
		tier = 1;
		gameQualityLv = 1;
	end
	
	--LogError("tier:" .. tier .. ",gameQualityLv:" .. gameQualityLv);
	CSAPI.SetGraphicsTier(tier);
	CSAPI.SetGameQualityLv(gameQualityLv);
	--描边开关
	CSAPI.SetShaderOutline(SettingMgr:GetValue(s_toggle_mb_key) == 1)
end

function this.GetGameLv()
	return this.gameLv or 2;
end

this.Vibrate = CS.CSAPI.Vibrate;
---定时震动
this.Vibrate2 = CS.CSAPI.Vibrate2;
--开始震动
this.StartVibrate = CS.CSAPI.StartVibrate;
--停止震动
this.StopVibrate = CS.CSAPI.StopVibrate;
--设置屏幕亮度
this.SetScreenLight = CS.CSAPI.SetScreenLight;

--写出到文件
this.SaveToFile = CS.CSAPI.SaveToFile;
--从文件读取
this.LoadStringByFile = CS.CSAPI.LoadStringByFile;

--获取当前EventSystem操作的GameObject
this.GetCurrUIEventObj=CS.CSAPI.GetCurrUIEventObj;

--释放声音资源
this.ReleaseSound = CS.CSAPI.ReleaseSound;
--播放声音
this.csPlaySound = CS.CSAPI.PlaySound;
function this.PlaySound(cueSheet, cueName, isLoop, feature, tag, fadeSpeed, callBack, fadeDelay, volumeCoeff,startTime,completeCB)
--	--屏蔽人声
--	if(cueSheet and string.find(cueSheet, "cv/"))then
--        LogError(cueSheet);    
--		return;
--	end
	if(soundOffState) then
		return;
	end
	
	
	tag = tag or(feature and "feature" or "");
	if(isLoop == nil) then
		isLoop = false;
	end
	if(feature == nil) then
		feature = false;
	end
	fadeSpeed = fadeSpeed or - 1;
	--LogError(tostring(cueSheet) .. ":" .. tostring(cueName) .. ",isLoop:" .. tostring(isLoop) .. ",tag:" .. tostring(tag));
	volumeCoeff = volumeCoeff or 100;
	startTime = startTime or 0
	if tonumber(CS.CSAPI.APKVersion()) > 6 then		
		return this.csPlaySound(cueSheet, cueName, isLoop, feature, tag, fadeSpeed, callBack, fadeDelay or 0, volumeCoeff,startTime,completeCB);
	else
		return this.csPlaySound(cueSheet, cueName, isLoop, feature, tag, fadeSpeed, callBack, fadeDelay or 0, volumeCoeff,startTime);
	end
end

--播放UI声音
function this.PlayUISound(cueName, isLoop)
	--LogError("播放UI声音" .. cueName);
	CSAPI.PlaySound("UI/UI.acb", cueName);
end
--停止UI声音
function this.StopUISound(cueName)
	--LogError("停止UI声音" .. cueName);
	--CSAPI.PlayUISound(cueName)
	CSAPI.StopTargetSound("UI/UI.acb", cueName);
end

--播放抽卡相关声音
function this.PlayUICardSound(cueName)
	CSAPI.PlaySound("UI/ui_card.acb", cueName);
end
--停止抽卡相关声音
function this.StopUICardSound(cueName)
	--CSAPI.PlayUICardSound(cueName)
	CSAPI.StopTargetSound("UI/ui_card.acb", cueName);
end

--播放催眠游戏相关声音
function this.PlayCounselingRoomSound(cueName)
	CSAPI.PlaySound("UI/Dorm_CounselingRoom.acb", cueName);
end
--停止催眠游戏声音
function this.StopCounselingRoomSound(cueName)
	--CSAPI.PlayUICardSound(cueName)
	CSAPI.StopTargetSound("UI/Dorm_CounselingRoom.acb", cueName);
end

--播放运营活动相关声音
function this.PlayTempSound(cueName, isLoop)
	--LogError("播放UI声音" .. cueName);
	CSAPI.PlaySound("temp/temp.acb", cueName);
end
--停止运营活动相关声音
function this.StopTempSound(cueName)
	--LogError("停止UI声音" .. cueName);
	--CSAPI.PlayUISound(cueName)
	CSAPI.StopTargetSound("temp/temp.acb", cueName);
end


function this.SetSoundOff(state)
	soundOffState = state;
end

function this.SetBGMLock(key)
	bgmLockKey = key;
end
function this.GetBGMLock()
    return bgmLockKey;
end

--播放背景音乐
function this.PlayBGM(bgm, fadeDelay, volumeCoeff, lockKey)
	
	if(bgmLockKey and bgmLockKey ~= lockKey) then
		return;
	end
	
	if(StringUtil:IsEmpty(bgm)) then
		return;
	end
	
	if(this.bgmLast and this.bgmLast == bgm) then
		return;
	end
	local _bgm = this.bgmLast
	this.bgmLast = bgm;
	--LogError("切换背景音乐：" .. bgm);
	volumeCoeff = volumeCoeff or 100;
	local cueSheet = "bgms/" .. bgm .. ".acb";	
	
	local isLoop = false;
	this.sound = CSAPI.PlaySound(cueSheet, bgm, isLoop, false, "bgm", 0.5, nil, fadeDelay, volumeCoeff);
	return _bgm
end
function this.StopBGM(fadeSpeed)
	--LogError("停止BGM");
	local bgm = this.bgmLast
	this.bgmLast = nil;
	local isLoop = false;
	CSAPI.PlaySound("", "", isLoop, false, "bgm", fadeSpeed or 0.5);
	return bgm
end
function this.ReplayBGM(bgm)
	if(bgm) then 
		CSAPI.PlayBGM(bgm)
	end 
end

function this.GetSound()
	return this.sound
end

--设置声音语言后缀
this.SetSoundLanguage = CS.CSAPI.SetSoundLanguage;
function this.SetCVLanguage(cvName,language)
    local cueSheet = string.format("cv/%s.acb",cvName);
    this.SetSoundLanguage(cueSheet,language);
end
function this.DownloadCV(cvName,language,callBack)
    if(StringUtil:IsEmpty(language)) then
        if(callBack)then
            callBack();
        end
        return;
    end
    local path = string.format("sounds_%s/cv/%s.acb",language,cvName);
    this.DownloadFile(path,callBack);
end
function this.IsDownloadedCV(cvName,language)
    if(StringUtil:IsEmpty(language)) then        
        return true;
    end
    local path = string.format("sounds_%s/cv/%s.acb",language,cvName);
    return this.IsDownloadedFile(path);
end
--重置全部语音设置
this.ResetAllLanguage = CS.CSAPI.ResetAllLanguage;

--预加载一组声音
this.PreloadSound = CS.CSAPI.PreloadSound;
--停止全部声音
this.StopSound = CS.CSAPI.StopSound;
--停止指定声音
this.csStopTargetSound = CS.CSAPI.StopTargetSound;
function this.StopTargetSound(cueSheet, cueName)
	if tonumber(CS.CSAPI.APKVersion()) > 6 then		
		this.PlaySound(cueSheet, cueName,nil,nil,nil,nil,nil,nil,nil,nil,function(playedCueName)
			-- LogError("停止指定声音" .. cueName);
			this.csStopTargetSound(cueSheet, cueName);
		end);
	else
		this.PlaySound(cueSheet, cueName);
		this.csStopTargetSound(cueSheet, cueName);
	end	
end
this.StopExceptTag = CS.CSAPI.StopExceptTag;
--设置音量
this.SetVolume = CS.CSAPI.SetVolume;
--获取音量
this.GetVolume = CS.CSAPI.GetVolume;
--移除
this.RemoveCueSheet = CS.CSAPI.RemoveCueSheet;
--播放配置声音
function this.PlayCfgSoundByID(id, feature, tag, volumeCoeff)
	local cfg = Cfgs.Sound:GetByID(id);
	if(not cfg) then
		return;
	end
	CRoleMgr:AddRoleAudioById(cfg.id) --记录已展示在台词列表
	--LogError("cfg:".. tostring(cueSheet) .. ":" .. tostring(volumeCoeff));
	this.PlaySound(cfg.cue_sheet, cfg.cue_name, false, feature, tag, nil, nil, nil, volumeCoeff);
end
--播放配置声音
function this.PlayCfgSound(key, feature, tag, volumeCoeff)
	local cfg = Cfgs.Sound:GetByKey(key);
	if(not cfg) then
		return;
	end
	CRoleMgr:AddRoleAudioById(cfg.id) --记录已展示在台词列表
	--LogError("cfg:".. tostring(cueSheet) .. ":" .. tostring(volumeCoeff));
	this.PlaySound(cfg.cue_sheet, cfg.cue_name, false, feature, tag, nil, nil, nil, volumeCoeff);
end
--随机播放一组声音中的一个
function this.PlayRandSound(keys, feature, tag, volumeCoeff)
	local len = keys and #keys or 0;
	if(len == 0) then
		return;
	end
	--LogError("rand:".. tostring(cueSheet) .. ":" .. tostring(volumeCoeff));
	local index = this.RandomInt(1, len);
	this.PlayCfgSound(keys[index], feature, tag, volumeCoeff);
end

function this.PlayPlotSound(key, isLoop, volumeCoeff)
	if(not key and key == "") then
		return;
	end
	-- LogError("key:" .. key .. ",isLoop:" .. tostring(isLoop));
	local feature = false
	CSAPI.PlaySound("plot_effect/plot_effect.acb", key, isLoop, feature, tag, 0.5, nil, nil, volumeCoeff);
end

function this.StopPlotSound(key)
	--CSAPI.PlayPlotSound(key)
	CSAPI.StopTargetSound("plot_effect/plot_effect.acb", key)	
end


--shader等级
this.GetShaderLv = CS.CSAPI.GetShaderLv;

--获取设备类型
--this.GetDeviceType = CS.CSAPI.GetDeviceType;
function this.GetDeviceType()
	if(not this.deviceType) then
		this.deviceType = CS.CSAPI.GetDeviceType()
	end
	return this.deviceType
end


--是否只读本地服务器
this.IsLocalMode = CS.CSAPI.IsLocalMode;

this.Quit = CS.CSAPI.Quit;

function this.UnityQuit()
 	 UnityEngine.Application.Quit();
end

this.ChangeConstraintCount = CS.CSAPI.ChangeConstraintCount


--播放文字显示效果
this.ApplyTextTween = CS.CSAPI.ApplyTextTween;
this.StopTextTween = CS.CSAPI.StopTextTween;
this.ApplyTextTweenFull = CS.CSAPI.ApplyTextTweenFull;

--安装APP
this.InstallAPP = CS.CSAPI.InstallAPP;

--设置渲染层级
this.SetSortOrder = CS.CSAPI.SetSortOrder;

--设置GridLayoutGroup的对齐方式
this.ChangeAlignment = CS.CSAPI.ChangeAlignment;
--修改GridLayoutGroup的size
this.ChangeGridCellSize = CS.CSAPI.ChangeGridCellSize;
--修改HorizontalLayoutGroup的childControlWidth
this.ChangeChildControlWidth = CS.CSAPI.ChangeChildControlWidth

--背景适配
this.PlayShrinkAction = CS.CSAPI.PlayShrinkAction
this.GetLayersRect = CS.CSAPI.GetLayersRect
this.SetLayersRect = CS.CSAPI.SetLayersRect
this.SetRtRect = CS.CSAPI.SetRtRect


--通过颜色码设置文字渐变颜色
this.SetTextGradient = CS.CSAPI.SetTextGradient;
--启用/禁用gameObject上的脚本
this.SetScriptEnable = CS.CSAPI.SetScriptEnable;

--获取ContentSizeFitter的宽和高区域(挂载ContentSizeFitter的组件无法通过sizeDelta或rect获取大小)
this.GetPreferredSize = CS.CSAPI.GetPreferredSize

--屏幕分辨率(在华为等手机下不准确)
this.GetScreenSize = CS.CSAPI.GetScreenSize

--主画布分辨率
function this.GetMainCanvasSize()
	return CS.UIUtil.mainCanvasRectTransform.sizeDelta
end

--获取与主画布分辨率比例差
function this.GetSizeOffset()
	local size = CSAPI.GetMainCanvasSize()
	local xScale,yScale = 1,1
	if size then
		xScale = size[0] / 1920
		yScale = size[1] / 1080	
	end
	return xScale > yScale and xScale or yScale
end

--是否是宽屏（平板之类）
function this.Iswidescreen()
	return CS.UIUtil.mainCanvasMatch < 1
end

--设置TextMesh的文字内容
this.SetTextMesh = CS.CSAPI.SetTextMesh;

--网络请求
this.WebRequest = CS.CSAPI.WebRequest;

--多语言界面文字 (GameObject go, string id)
this.csSetTranText = CS.CSAPI.SetTranText;

--获取电量
this.GetElectricQuantity = CS.CSAPI.GetElectricQuantity;

--设置描边是否启用
this.SetShaderOutline = CS.CSAPI.SetShaderOutline

--锯齿是否启用
this.SetAA = CS.CSAPI.SetAA

--[[iPhoneX: “iPhone10,3”, “iPhone10,6”
iPhoneXS: “iPhone11,2”
iPhoneXS Max: “iPhone11,6”
iPhoneXR: “iPhone11,8”
]]
--==============================--
--iPhone设备model表: https://www.theiphonewiki.com/wiki/Models
--desc:是否是IphoneX机型
--time:2021-07-31 02:21:59
--@args:
--@return 
--==============================--
function this.IsIphoneX()
	if(not CSAPI.IsIOS()) then
		return false
	end
	local tabs = {"iPhone8,1", "iPhone8,2", "iPhone8,3", "iPa"} --排除8
	local modelStr = UnityEngine.SystemInfo.deviceModel
	if(not StringUtil:IsEmpty(modelStr)) then
		for i, v in ipairs(tabs) do
			if(string.find(modelStr, v)) then
				return false
			end
		end
	end
	return true --除了排除的都要做刘海适配
end

this.SetToMousePosition = CS.CSAPI.SetToMousePosition

--提前获取字符串长度
this.GetTextWidth = CS.CSAPI.GetTextWidth

--是否是渠道服
this.IsChannel = CS.CSAPI.IsChannel;

this.IsPCPlatform=CS.CSAPI.IsPCPlatform;

--返回渠道服类型
local _channelType =nil;
function this.GetChannelType()
	if _channelType==nil then
		_channelType=CS.CSAPI.GetChannelType();
	end
	return _channelType;
end

function this.GetChannelName()
	local channelType=this.GetChannelType();
	if channelType==ChannelType.Normal then
		return "米茄"
	elseif channelType==ChannelType.BliBli then
		return "B站"
	elseif channelType==ChannelType.TapTap then
		return "TAPTAP"
	elseif channelType==ChannelType.QOO then
		return "QOO"
	elseif channelType==ChannelType.ZiLong then
		return "台服"
	end
end

--返回平台英文字符串
function this.GetChannelStr()
    local channelType=CSAPI.GetChannelType();
    if channelType==ChannelType.Normal then
        return "mega"
    elseif channelType==ChannelType.BliBli then
        return "bilibili"
    elseif channelType==ChannelType.TapTap then
        return "taptap"
    elseif channelType==ChannelType.QOO then
        return "qoo"
	elseif channelType==ChannelType.ZiLong then
		return "tw"
    end
end

--测试用接口
this.ConnectToNetworkServer = CS.CSAPI.ConnectToNetworkServer;
this.SendToNetworkServer = CS.CSAPI.SendToNetworkServer;

--post 上传数据
function this.PostUpload(url, dataStr,cb)
	CS.CSAPI.PostUpload(url, dataStr,cb)
end

--设置透明度
function this.SetGOAlpha(go, alpha)
	local canvasGroup = ComUtil.GetOrAddCom(go, "CanvasGroup")
	canvasGroup.alpha = alpha
end
--是否无视父类透明度
function this.SetGOIgnoreAlpha(go, b)
    if(not go)then
        return;
    end
	local canvasGroup = ComUtil.GetOrAddCom(go, "CanvasGroup")
	canvasGroup.ignoreParentGroups = b
end


this.OpenWebBrowser = CS.CSAPI.OpenWebBrowser
this.InitViewData = CS.CSAPI.InitViewData;
this.WebPostRequest = CS.CSAPI.WebPostRequest;
this.WebPostRequestJsonStr=CS.CSAPI.WebPostRequestJsonStr;
--this.csWebPostRequest = CS.CSAPI.WebPostRequest;
--function this.WebPostRequest(url,formData,func)
--    LogError(string.format("Post内容：%s\n参数：%s",url,table.tostring(formData)));
--    this.csWebPostRequest(url,formData,func);
--end
this.DownloadFile = CS.CSAPI.DownloadFile;
this.IsDownloadedFile = CS.CSAPI.IsDownloadedFile;

this.IsPhoneLogin = CS.CSAPI.IsPhoneLogin;

--public static bool ApplyCallBtn(string goName, string msg = "OnClick")
this.ApplyCallBtn = CS.CSAPI.ApplyCallBtn;

--设置多点触控
this.SetMultiTouchEnable = CS.CSAPI.SetMultiTouchEnable;

--检测是否是模拟器
this.CheckEmulator = CS.CSAPI.CheckEmulator;

this.IsIOS = CS.CSAPI.IsIOS

--检测主干还是分支
this.GetPublishType = CS.CSAPI.GetPublishType

this.SetImgClicker=CS.CSAPI.SetImgClicker;

this.GetSystemInfo=function(func)
	if this.systemInfo~=nil then
		if(func)then
			func(this.systemInfo);
		end
	else
		CS.CSAPI.GetSystemInfo(function(js)
			this.systemInfo=js;
			if(func)then
				func(js);
			end
		end);
	end
end;

_G.ReYunSDK=CS.ReYunSDK.ins;

_G.JuLiangSDK = CS.JuLiangSDK.ins;

_G.SilentDownloadMgr = CS.SilentDownloadMgr.ins;

local packageName=nil;
this.GetPackageName = function()
	if packageName==nil or packageName=="" then
		packageName=UnityEngine.Application.identifier;
	end
	return packageName;
end;

this.EncyptStr=CS.CSAPI.EncyptStr;

this.WriteInternation=CS.CSAPI.WriteInternation;
--跳转链接
this.JumpUri=CS.CSAPI.JumpUri;
--是否安装了某个APP
this.IsInstallApp=CS.CSAPI.IsInstallApp;
--创建二维码
this.CreateQRImg=CS.CSAPI.CreateQRImg;

--是否和谐
this.csIsInternation = CS.CSAPI.IsInternation;
function this.IsInternation()
    return this.csIsInternation and this.csIsInternation();
end

this.csGetADID = CS.CSAPI.GetADID;
--- 获取广告ID
function this.GetADID()
	if(this.csGetADID)then
		return this.csGetADID();
	end
	return 0;
end
this.DispatchEvent=CS.CSAPI.DispatchEvent;
this.Currentplatform=CS.UnityEngine.Application.platform;
this.Android=CS.UnityEngine.RuntimePlatform.Android;
this.IPhonePlayer=CS.UnityEngine.RuntimePlatform.IPhonePlayer;
this.WindowsEditor=CS.UnityEngine.RuntimePlatform.WindowsEditor;
this.OpenHarmony=CS.UnityEngine.RuntimePlatform.OpenHarmony;


this.IsADV=CS.CSAPI.IsADV;
this.IsDomestic=CS.CSAPI.IsDomestic;
--function this.IsDomestic()
--	return false;
--end
this.SetUIFit=CS.CSAPI.SetUIFit;
this.AddUIAdaptive=CS.CSAPI.AddUIAdaptive;
this.RemoveAdaptive=CS.CSAPI.RemoveAdaptive;
this.AddEventListener=CS.CSAPI.AddEventListener;
this.RemoveEventListener=CS.CSAPI.RemoveEventListener;
this.UIFitoffsetTop=CS.CSAPI.UIFitoffsetTop;
this.UIFoffsetBottom=CS.CSAPI.UIFoffsetBottom;
this.UIFittopAnchor=CS.CSAPI.UIFittopAnchor;
this.UIbottomAnchor=CS.CSAPI.UIbottomAnchor;
this.QuitGame =CS.CSAPI.QuitGame;
this.GetDeviceID =CS.CSAPI.GetDeviceID;
--this.GetInside =CS.CSAPI.GetInside;

this.GetsSDKInitSuccess =CS.CSAPI.GetsSDKInitSuccess;

this.ZLongServerListUrl=CS.ShiryuStreamingAssets.ins.GetServerListUrl;
this.GetSdkEnvironmentType=CS.ShiryuStreamingAssets.ins.GetSdkEnvironmentType
this.channel=CS.CSAPI.channel;
function this.GetInside()
	return this.GetSdkEnvironmentType
end


this.PCSetWindow=CS.CSAPI.PCSetWindow;
this.APKVersion=CS.CSAPI.APKVersion;
this.RegionalCode=CS.CSAPI.RegionalCode;
---是否存在新手引导
function this.IsBeginnerGuidance()
	if GuideMgr.IsGuideEnd==true then
		return true;
	end
	local PlotSimple = CSAPI.GetView("PlotSimple")
	if (PlotSimple) then
		return true;
	end
	local Plot = CSAPI.GetView("Plot")
	if (Plot) then
		return true;
	end
	local VideoPlayer = CSAPI.GetView("VideoPlayer")
	if (VideoPlayer) then
		return true;
	end
	if  FightClient.Intheamplificationmove then
		return true;
	end
	if  FightClient.NewPlayerDrasu then
		return true;
	end

	return false;
end

---是否是移动平台
this.IsMobileplatform=false;
--获取平台
function this.Getplatform()
	this.IsMobileplatform=false;
	if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.Android or
			UnityEngine.Application.platform ==UnityEngine.RuntimePlatform.IPhonePlayer or
			UnityEngine.Application.platform ==UnityEngine.RuntimePlatform.OpenHarmony or
			UnityEngine.Application.platform ==UnityEngine.RuntimePlatform.WindowsEditor
	then
		this.IsMobileplatform=true;
	else
		this.IsMobileplatform=false;
	end
end

---是否提审模式
function this.IsAppReview()
	if tonumber(CS.CSAPI.APKVersion()) > 6 then
		if this.IsAppReviewMode ~= nil then
			return this.IsAppReviewMode();
		else
			return true
		end
	else
		return false
	end
end
---获取当前平台指定热更新文件夹路径(指定文件夹内)
this.PlatformURL=CS.CSAPI.PlatformURL;
---获取当前平台指定热更新文件夹路径
this.HotFileUrl=CS.CSAPI.HotFileUrl;
--字符串替换 (string str = "",string pattern = "",bool isMatch = false)
this.FilterChar = CS.CSAPI.FilterChar
this.server_list_enc_close=false;
--- 海外日服璨晶购买提示
function this.ADVJPTitle(consume,action)
	---璨晶总数
	local  TotalDiamonds=PlayerClient:GetCoin(ITEM_ID.DIAMOND);
	--- 充值获得的璨晶
	local RechargeDiamonds=PlayerClient:GetCoin(ITEM_ID.DIAMOND_PAY);
	---Log("A----TotalDiamonds:"..TotalDiamonds.." RechargeDiamonds:"..RechargeDiamonds)
	---免费璨晶
	local FreeDiamonds=TotalDiamonds-RechargeDiamonds;
	---Log("A----FreeDiamonds:"..FreeDiamonds)
	if 0>FreeDiamonds then
		LogError("A----数据异常，服务器并未及时更新璨晶总数和充值璨晶总数:".."璨晶总数:"..TotalDiamonds.." 充值获得的璨晶:"..RechargeDiamonds)
		FreeDiamonds=0;
	end
	---需要消耗的璨晶
	local consumeIcon=consume;
	---Log("A----consumeIcon:"..consumeIcon)
	---免费减去  消耗 等于剩余
	local RemainderDiamonds=FreeDiamonds-consumeIcon;
	---Log("A----RemainderDiamonds:"..RemainderDiamonds)
	---剩余充值钻石
	local RemainrechargeDiamonds=RemainderDiamonds;
	---Log("A----RemainrechargeDiamonds:"..RemainrechargeDiamonds)
	---如果 得到的 是负数，需要和充值的相加得到剩余的
	if 0>RemainderDiamonds then
		--- RemainderDiamonds=RemainderDiamonds+RechargeDiamonds;
		---充值钻石 数量
		RechargeDiamonds=TotalDiamonds-FreeDiamonds;
		---Log("A----RechargeDiamonds:"..RechargeDiamonds)
		--使用后 剩余充值钻石
		RemainrechargeDiamonds=RemainderDiamonds+RechargeDiamonds;
		---Log("A----RemainrechargeDiamonds:"..RemainrechargeDiamonds)
		--不可能剩余负数，只能为0，代表免费的使用完毕
		RemainderDiamonds=0;

	else
		RemainrechargeDiamonds=RechargeDiamonds;
		---Log("A----*RemainrechargeDiamonds:"..RemainrechargeDiamonds)
	end

	local JPTitleTable=
	{
		TotalDiamonds,---总璨晶
	    FreeDiamonds, ---免费璨晶
		RechargeDiamonds,---充值的璨晶
		RemainderDiamonds,---使用后剩余的免费璨晶
		RemainrechargeDiamonds,---使用后剩余的充值璨晶
	}
	local dialogData = {}
	dialogData.title=LanguageMgr:GetByID(66003);
	dialogData.content =LanguageMgr:GetTips(15124,JPTitleTable[1],JPTitleTable[2],JPTitleTable[3],JPTitleTable[4],JPTitleTable[5])
	dialogData.okText =LanguageMgr:GetByID(1001)
	dialogData.cancelText =LanguageMgr:GetByID(1002)
	dialogData.okCallBack = function() if action~=nil then action(); end end
	dialogData.cancelCallBack = function()  end
	CSAPI.OpenView("Dialog", dialogData)
end

---海外指定地区判断
function this.IsADVRegional(RegionalCode)
	if CSAPI.IsADV() and CSAPI.RegionalCode()==RegionalCode then
		return true;
	else
		return false
	end
end


---JP 支付年龄显示
function this.PayAgeTitle()
	local Age=PlayerPrefs.GetInt(CSAPI.GetSetkey("JPChooseAgeNotdisplay"));
	if Age==1 then
		return  false;
	else
		return true;
	end
end

---获取JP支付限制类型
function this.JPGetTypelimit()
	if CSAPI.PayAgeTitle()==false then
		return 0;  ---如果满足不显示  就是 18岁以上
	end
	local AgeType=PlayerPrefs.GetInt(CSAPI.GetSetkey("JPSelectAge"));
	Log("AgeType-----------------:"..AgeType)
	if AgeType==0 then
		return 0;   ----  没有也默认18岁以上
	elseif AgeType==1 then
		return 1    ----16岁以上
	elseif AgeType==2 then
		return 2    ---16-17岁以上
	elseif AgeType==3 then
		return 0  ---18岁随以上
	else
		return 0   ------错误 也默认 18岁随以上
	end
end

---服务器id_玩家UID_缓存key 组成的  缓存记录
function this.GetSetkey(key)
	local  Backkey=tostring(this.ServerID).."_"..tostring(this.PlayerUID).."_"..tostring(key)
	return Backkey;
end

---所选服务器id
this.ServerID=0;
---设置服务器id
function this.SetServerID(id)
	if id~=nil then
		this.ServerID=id;
	end
end
---玩家UID
this.PlayerUID=0;
---设置游戏UID
function this.SetGameUID(id)
	if id~=nil then
		this.PlayerUID=id;
	end
end
---通用打点版本号
function this.UnityClientVersion(uid)
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		local platform="PC"
		if CSAPI.Currentplatform == CSAPI.Android then
			platform="Android"
		elseif CSAPI.Currentplatform == CSAPI.IPhonePlayer then
			platform="IPhonePlayer"
		else
			platform="PC"
		end
		local ClientVersion=
		{
			ClientVersion=_G.g_ver_name,
			ClientPlatform=platform,
			UID=tostring(uid),
		};
		BuryingPointMgr:TrackEvents(ShiryuEventName.Unity_Client_Version,ClientVersion)
	end
end

this.IsAppReviewMode = CS.CSAPI.IsAppReviewMode;

--是否根据分辨率动态检测修改matchWidthOrHeight
function this.IsCheckRate(b)
	CS.CSAPI.IsCheckRate(b)
end
---首次安装或者修改了默认时会重置一次玩家选择,其他时候用玩家选择的或者默认值
this.SetDelaultLanguageIndex = CS.CSAPI.SetDelaultLanguageIndex;
---获取默认语言下标 目前已有（简体中文1、繁體中文2、日文3、英文4、韩文5）
this.GetDefaultLanguageIndex = CS.CSAPI.GetDefaultLanguageIndex;
---语言设置
this.ChangeLanguageType = CS.CSAPI.ChangeLanguageType;
---跟包默认语言(临时注销)
---this.GlobalRegionalLanguage=CS.CSAPI.GlobalRegionalLanguage();
---跟包默认语言
function this.GetRegionalLanguage()
	---返回4 默认英语 返回6默认俄语（临时注销）
	---return this.GlobalRegionalLanguage();
	return this.GetBaseLanguageType();
end

--打包时决定的默认语言类型  GameLauncher.cs 的 defaultLanguageIdx
function this.GetBaseLanguageType()
	local key1 = "DEFAULT_LANGUAGE_INDEX"
	local type = PlayerPrefs.GetInt(key1) or 1
	return type
end

---满足分享图片
---CSAPI.IsSharePicture()
function this.IsSharePicture()
	if CSAPI.IsMobileplatform then
		if CSAPI.RegionalCode()==1 or CSAPI.RegionalCode()==5 or CSAPI.RegionalCode()==6 then
			---如果是国服:1， 韩服：5  英俄地区：6  存在分享  返回true
			return true;
		end
	end
	return false;
end

---海外-英俄地区，当前状态是否处于审核模式
this.ReviewMode=CS.CSAPI.ReviewMode;
---每次初始化固定获取一次当前启动的语言类型
this.Currentlanguagetype=this.GetDefaultLanguageIndex();
---海外 英俄地区，俄语模式下，由  货币+价格 调整为  价格+货币显示
--- 卢布价格显示是否满足修改 左右互换， 返回false 不满足，返回true 满足
function this.IsSwapleftandright()
	if CSAPI.RegionalCode()==6  and CSAPI.Currentlanguagetype==6 then
		---英俄地区+当前使用语言为俄语，满足条件返回true
		 return true;
	end
	---处于编辑器状态下的调试模式
	--if UnityEngine.Application.platform ==UnityEngine.RuntimePlatform.WindowsEditor then
	--	return true
	--end
   return false
end

---海外 英俄地区， 货币和价格 设置左右调换位置
function this.SetSwapleftandright(Item,state)
	if CSAPI.IsSwapleftandright()==false then
		return;
	end
	if Item then
		if state==1 then
          ---层级向下，  显示层越高
		  Item.gameObject.transform:SetAsLastSibling();
		elseif state==2 then
        ---向上，显示层越低
		Item.gameObject.transform:SetAsFirstSibling();
		end
	end
end

--是否是反和谐(true:暴露)
function this.CheckFHX()
	if CSAPI.IsADV() then
		return nil --不做小开关的判断
	end
	if tonumber(CS.CSAPI.APKVersion()) >=12 then
		return CS.CSAPI.GetInternationState()
	else 
		return false 
	end
end

--资源是否是反和谐
function this.CheckHXRes(resName)
	if resName~=nil and tonumber(CS.CSAPI.APKVersion()) >=12 then
		return CS.CSAPI.CheckInternationRes(resName)
	else 
		return false 
	end
end


return this;

