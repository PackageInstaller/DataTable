local weight_key = "Loading";
local currKey = nil;
local currCfg = nil;
local currIdx = 0;--当前显示的loading图下标
local changeTimer = nil  --图片更换时间  3s，nil无更换
list = {}

local isClose = false  --延迟关闭
local closeTime = nil
local isComplete = false
local blackWide = 70  --上下黑边够60时才显示
function Awake()
	-- if SceneMgr and SceneMgr:IsLoginLoading() then
	--     CSAPI.SetGOActive(bg,false);
	--     CSAPI.SetGOActive(movieRoot,true);
	--     UIUtil:AddLoginMovie(movieObj);
	-- else
	--     CSAPI.SetGOActive(movieRoot,false);
	--     CSAPI.SetGOActive(bg,true);
	-- end
	-- if(loadPercent)then
	--     txtPercent = ComUtil.GetCom(loadPercent,"Text");
	-- end
	CSAPI.SetGOActive(btnL, false)
	CSAPI.SetGOActive(btnR, false)
	CSAPI.SetGOActive(blackT, false)
	CSAPI.SetGOActive(blackD, false)
	CSAPI.SetGOActive(blackWTB, false)
	CSAPI.SetGOActive(blackBTW, false)
	CSAPI.SetGOActive(bg, false)
	--CSAPI.SetGOActive(effect, false)
end

function OnInit()
	-- bar = ComUtil.GetCom(goBar, "BarBase");	
	-- bar:AddCallBack(OnComplete);	
	-- list = {};
	--给自己设置一个Loading加载任务，500毫秒后自动完成，确保Loading界面不会立刻完成加载任务
	OnWeightApply(weight_key);
	FuncUtil:Call(OnWeightUpdate, nil, 500, weight_key);
	
	InitListener();
	
	--通知其他系统，加载界面已启动加载
	--其他系统通过Loading_Weight_Apply事件设置加载任务，通过Loading_Weight_Update事件更新加载任务状态
	EventMgr.Dispatch(EventType.Loading_Start);	
end

function InitListener()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Loading_Weight_Apply, OnWeightApply);
	eventMgr:AddListener(EventType.Loading_Weight_Update, OnWeightUpdate);
	eventMgr:AddListener(EventType.Loading_View_Delay_Close, OnDelayClose);
	eventMgr:AddListener(EventType.Scene_Load, OnSceneLoad);
end
function OnDestroy()
	eventMgr:ClearListener();
	EventMgr.Dispatch(EventType.Loading_View_Close);	
end


function Update()
	-- if(txtPercent) then
	-- 	txtPercent.text = string.format(math.ceil(bar.currFillProgress * 100)) .. "%";
	-- end
	if(changeTimer and Time.time > changeTimer) then
		changeTimer = Time.time + 3
		ChangeBG()
	end
	
	if(isClose and Time.time >= closeTime) then
		OnComplete()
	end
end


function OnSceneLoad(param)
	--设置loading背景图
	if param ~= currKey then
		currKey = param;
		currCfg = Cfgs.scene:GetByKey(currKey);
		currIdx = 0;
		changeTimer = nil
		if(not currCfg.loading_type) then
			--未配置
		else
			if(currCfg.loading_type == 1) then
				--图片
				SetBG()
			else
				--mv
				SetMV()
			end	
		end	
	end
end

--默认只有一个
function SetMV()
	local resID = currCfg.loading_res[1]
	local resCfg = Cfgs.CfgLoadingRes:GetByID(resID)
	ResUtil:PlayVideo(resCfg.name or "loading_neri", mv)
	SetTxts(resCfg)
end

function SetBG()
	--界面最短关闭时间
	closeTime = Time.time + 1.2
	
	resLen = #currCfg.loading_res
	--btns
	CSAPI.SetGOActive(btnL, resLen > 1)
	CSAPI.SetGOActive(btnR, resLen > 1)
	--effect
	FuncUtil:Call(SetEffect, nil, 200)
	--宽屏处理
	SetWidescene()
	--bg
	ChangeBG()
end

function SetWidescene()
	local isWide = CSAPI.Iswidescreen()
	local realHeight = CSAPI.GetMainCanvasSize() [1]
	--blackT,blackD,bg的size
	if(isWide) then	
		local moreHeight =(realHeight - 1080) / 2
		CSAPI.SetGOActive(blackT, moreHeight > blackWide)
		CSAPI.SetGOActive(blackD, moreHeight > blackWide)
		local _realHeight = realHeight
		if(moreHeight > blackWide) then
			_realHeight = realHeight - blackWide * 2
		end
		local width = 2400 *(_realHeight / 1080)
		CSAPI.SetRTSize(bg, width, _realHeight)
	else
		local width,height = 2400,1080
		local realWidth = CSAPI.GetMainCanvasSize() [0]
		width = realWidth>2400 and realWidth or 2400 
		height = (width/2400)*1080
		CSAPI.SetRTSize(bg, width, height)
	end
	--maskT,maskD
	local posY = realHeight / 2
	CSAPI.SetAnchor(maskT, 0, posY, 0)
	CSAPI.SetAnchor(maskD, 0, - posY, 0)
end

function SetEffect()
	CSAPI.SetGOActive(effect, true)
	ef = ComUtil.GetCom(Yvaine_Loading_triangle, "Animator")
end

function ChangeBG(isL)	
	--黑到白
	CSAPI.SetGOActive(blackBTW, true)
	FuncUtil:Call(function()
		CSAPI.SetGOActive(blackBTW, false)
	end, nil, 300)
	if(isL == nil) then
		if(resLen < 2) then
			changeTimer = nil
			currIdx = 1
		else
			changeTimer = Time.time + 3
			if(currCfg.loading_random == 1) then
				--随机
				local index = CSAPI.RandomInt(1, resLen)
				if(index == currIdx) then
					currIdx =(index + 1) > resLen and 1 or(index + 1)
				else
					currIdx = index
				end
			else
				--顺序
				currIdx =(currIdx + 1) > resLen and 1 or(currIdx + 1)
			end
		end
	else
		if(isL) then
			currIdx =(currIdx - 1) < 1 and resLen or(currIdx - 1)
		else
			currIdx =(currIdx + 1) > resLen and 1 or(currIdx + 1)
		end
	end
	
	local resID = currCfg.loading_res[currIdx]
	local resCfg = Cfgs.CfgLoadingRes:GetByID(resID)
	CSAPI.SetGOActive(bg, false)
	ResUtil:LoadBigImg2(bg, "UIs/BGs/" .. resCfg.name .. "/bg", false, function()
		CSAPI.SetGOActive(bg, true)
	end)
	SetTxts(resCfg)
end

--标题、文本
function SetTxts(resCfg)
	CSAPI.SetGOActive(txts, resCfg.title ~= nil)
	if(resCfg.title ~= nil) then
		--title
		CSAPI.SetText(txtTitle, resCfg.title or "")
		--desc
		CSAPI.SetText(txtDesc, resCfg.desc or "")
	end	
end

function OnClickBG()
	ChangeBG()
end

-- function ChangeBG()
-- 	if currCfg and currCfg.loading_bg then
-- 		local bgs = currCfg.loading_bg;
-- 		local isRand = currCfg.loading_player and currCfg.loading_player == 2 or false;
-- 		if #bgs > 1 and isRand then
-- 			local rand = math.random(1, #bgs);
-- 			if rand == currIdx then --重复则id+1或重置
-- 				currIdx = rand + 1 > #bgs and 1 or rand + 1;
-- 			else
-- 				currIdx = rand;
-- 			end
-- 		elseif #bgs > 1 then
-- 			currIdx = currIdx + 1 > #bgs and 1 or currIdx + 1;
-- 		else
-- 			currIdx = 1;
-- 		end
-- 		ResUtil:LoadBigImg(bg, "UIs/BGs/" .. bgs[currIdx] .. "/bg", false);
-- 	else
-- 		CSAPI.LoadImg(bg, "UIs/Loading/bg.png", false, nil, true);
-- 	end
-- end
function OnDelayClose(time)
	delayCloseTime = time;
	--LogError(delayCloseTime);
end

function RefreshLoadContent()
--	local str = "";
--	for k, v in pairs(list) do
--		str = k .. ":" .. v .. "\n";
--	end
--    if(loadContent)then
--	    CSAPI.SetText(loadContent, str);
--    end
    LogError(table.tostring(list,true));
--    LogError(str);
end

function OnWeightApply(name)
	list[name] = 0;
	--RefreshLoadContent();
	--LogError(list);
end

function OnWeightUpdate(name)
	list[name] = 1;
	--RefreshLoadContent();
	--LogError(list);
	local count = 0;
	local max = 0;
	for _, v in pairs(list) do
		max = max + 1;
		if(v == 1) then
			count = count + 1;
		end
	end
	--LogError("加载进度：" .. count .. "/" .. max);
	--bar:SetFullProgress(count, max);
	if(not isComplete and count >= max) then
		isComplete = true
		OnComplete()
	end
end

function OnComplete()
	if(closeTime and Time.time < closeTime) then
		isClose = true  --未满足最短关闭时间，在update里处理
		return
	end
	isClose = false
	
	-- if(true) then
	-- 	return
	-- end
	--LogError("加载完成===========================");
	CSAPI.SetGOActive(blackBTW, false)
	if blackWTB then --播放变黑动画
		CSAPI.SetGOActive(blackWTB, true);
		FuncUtil:Call(OnCompleteFunc, nil, 400);
		
		if(ef) then
			ef:Play("End")
		end
	else
		OnCompleteFunc();
	end
end

function OnCompleteFunc()
	CSAPI.SetGOActive(effect, false)
	
	EventMgr.Dispatch(EventType.Loading_Complete);
	
	--if(CSAPI.GetPlatform() == )
	--移除登陆动画
	if SceneMgr and SceneMgr:IsLoginLoading() then
		SceneMgr:SetLoginLoaded(false);
		UIUtil:RemoveLoginMovie();
	end
	ApplyClose();
	
	--加载完成，尝试触发引导
	EventMgr.Dispatch(EventType.Guide_Trigger, "Loaded");
end

function ApplyClose()
	if(delayCloseTime) then
		FuncUtil:Call(Close, nil, delayCloseTime);
	else
		Close()
	end
end
function Close()	
	--LogError("close loading view");
	if(view and view.Close) then		
		view:Close();
		view = nil;
		
		CSAPI.DisableInput(500);
	end
end

-- function OnClick()
-- 	CSAPI.SetGOActive(loadContent, true);
-- 	CSAPI.SetText(loadContent, table.tostring(list));	
-- end 
function OnClickL()
	ChangeBG(true)
end

function OnClickR()
	ChangeBG(false)
end 