local eventMgr = nil;
local lastGold = 0;
local lastDiamon = 0;
local lastCost = 0;
local goldAction;--数字攀升动画
local diamonAction;--数字攀升动画
local costAction;--消耗攀升动画
local goldMoveAction;--金币移动动画脚本列表
local diamonMoveAction;--钻石移动动画脚本列表
local goldCenterOffset;--金币距离中心点位置的偏移
local diamonCenterOffset;--钻石距离中心点位置的偏移
local getCostNumFunc=nil;--获取消耗数量方法
function Awake()
	CSAPI.SetGOActive(power, false);
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Bag_Update, Refresh);
	eventMgr:AddListener(EventType.Money_Update, RefreshByAction);
	lastGold = PlayerClient:GetGold();
	lastDiamon = PlayerClient:GetDiamond();
	goldAction = ComUtil.GetCom(text_gold, "ActionNumberRunner");
	diamonAction = ComUtil.GetCom(text_diamon, "ActionNumberRunner");
	costAction=ComUtil.GetCom(text_power,"ActionNumberRunner");
	goldMoveAction = ComUtil.GetComInChildren(goldEffect, "ActionMoveByCurve");
	diamonMoveAction = ComUtil.GetComInChildren(diamonEffect, "ActionMoveByCurve");
end

function OnEnable()
	Refresh();
end

function OnDisable()
	eventMgr:ClearListener();
	getCostNumFunc=nil;
end

--刷新，有动画
function RefreshByAction()
	CSAPI.SetText(text_power, "0");
	if((lastGold < PlayerClient:GetGold()) or(lastGold > PlayerClient:GetGold())) then
		CSAPI.SetText(text_gold, tostring(lastGold));
		local state = lastGold < PlayerClient:GetGold() and 1 or 2;
		PlayGoldAction(state);
	else
		CSAPI.SetText(text_gold, tostring(PlayerClient:GetGold()));
	end
	
	if((lastDiamon < PlayerClient:GetDiamond()) or(lastDiamon > PlayerClient:GetDiamond())) then
		CSAPI.SetText(text_diamon, tostring(lastDiamon));
		local state = lastDiamon < PlayerClient:GetDiamond() and 1 or 2;
		PlayDiamonAction(state);
	else
		CSAPI.SetText(text_diamon, tostring(PlayerClient:GetDiamond()));
	end	

	if getCostNumFunc~=nil then
		if ((lastCost<getCostNumFunc()) or (lastCost>getCostNumFunc())) then
			CSAPI.SetText(text_power, tostring(lastCost));
			PlayGetAction(powerImg, lastCost, getCostNumFunc(), costAction, refreshLastCost);
		else
			CSAPI.SetText(text_power, tostring(getCostNumFunc()));
		end
	end
end

--刷新，没动画
function Refresh()
	CSAPI.SetText(text_gold, tostring(PlayerClient:GetGold()));
	CSAPI.SetText(text_diamon, tostring(PlayerClient:GetDiamond()));
	if getCostNumFunc~=nil then
		CSAPI.SetText(text_power, tostring(getCostNumFunc()));
	end
end

--播放金币改变动画 state:1代表增加，2代表减少
function PlayGoldAction(state)
	if state == 1 then
		--计算距离中心点的偏移
		if goldCenterOffset == nil then
			goldCenterOffset = goldImg.transform.parent:InverseTransformPoint(UnityEngine.Vector3(0, 0, goldImg.transform.position.z));
		end
		PlayFlyAction(goldEffect,goldMoveAction,goldCenterOffset,function()
			--继续播放其他动画
			PlayGetAction(goldImg, lastGold, PlayerClient:GetGold(), goldAction, refreshLastGold);
		end);
	else
		--播放图标放大动画，数字跑动动画
		-- PlayGetAction(goldImg, lastGold, PlayerClient:GetGold(), goldAction, refreshLastGold);
		CSAPI.SetText(text_gold, tostring(PlayerClient:GetGold()));
	end
end

--播放钻石改变动画 state:1代表增加，2代表减少
function PlayDiamonAction(state)
	if state == 1 then
		--计算距离中心点的偏移
		if diamonCenterOffset == nil then
			diamonCenterOffset = diamonImg.transform.parent:InverseTransformPoint(UnityEngine.Vector3(0, 0, diamonImg.transform.position.z));
		end
		PlayFlyAction(diamonEffect,diamonMoveAction,diamonCenterOffset,function()
			--继续播放其他动画
			PlayGetAction(diamonImg, lastDiamon, PlayerClient:GetDiamond(), diamonAction, refreshLastDiamon);
		end);
	else
		--播放图标放大动画，数字跑动动画
		CSAPI.SetText(text_diamon, tostring(PlayerClient:GetDiamond()));
		-- PlayGetAction(diamonImg, lastDiamon, PlayerClient:GetDiamond(), diamonAction, refreshLastDiamon);
	end
end

--==============================--
--desc:播放收到动画
--time:2019-06-24 04:43:25
--@img: 播放放大渐出动画的图片
--@currNum:当前的数字（ActionNumberRunner脚本对象使用）
--@targetNum:目标数字（ActionNumberRunner脚本对象使用）
--@actionRunner:ActionNumberRunner脚本对象
--@return 
--==============================--
function PlayGetAction(img, currNum, targetNum, actionRunner, func)
	if img == nil or currNum == nil or targetNum == nil or actionRunner == nil then
		LogError("参数不能为nil！！");
		return;
	end
	local oldScale = img.transform.localScale;
	CSAPI.SetGOActive(img, true);
	CSAPI.ApplyAction(img, "action_fade_scale", function()
		CSAPI.SetScale(img, oldScale.x, oldScale.y, oldScale.z);
		CSAPI.SetGOActive(img, false);
		if(actionRunner) then
			actionRunner.currentNum = currNum;
			actionRunner.targetNum = targetNum;
			actionRunner:Play(func);
		end
	end);
end

function PlayFlyAction(moveObj, actionScript, offset, callBack)
	--设置起始位置
	CSAPI.SetLocalPos(moveObj, offset.x, offset.y, offset.z);
	actionScript.startPos = offset;
	--播放飞行动画、图标放大动画，数字跑动动画
	CSAPI.SetGOActive(moveObj, true);
	CSAPI.ApplyAction(moveObj, actionScript.transform.parent.gameObject, function()
		--完成后重置位置、大小
		CSAPI.SetGOActive(moveObj, false);
		CSAPI.SetLocalPos(moveObj, offset.x, offset.y, offset.z);
		CSAPI.SetScale(moveObj, 1, 1, 1);
		if callBack then
			callBack();
		end
	end);
end

--点击钻石
function OnClickDiamon()
	
end

--点击金币
function OnClickGold()
	
end

function OnClickPower()
	
end

function refreshLastDiamon()
	lastDiamon = PlayerClient:GetDiamond();
end

function refreshLastGold()
	lastGold = PlayerClient:GetGold();
end 

function refreshLastCost()
	lastCost=getCostNumFunc();
end

--设置第三种货币的显示 icon:货币icon getNumFunc:获取物品数量的方法
function InitCost(icon,getNumFunc)
	CSAPI.SetGOActive(power, true);
	lastCost=getNumFunc();
	CSAPI.SetText(text_power,tostring(lastCost));
	ResUtil.IconGoods:Load(powerImg,icon);
	ResUtil.IconGoods:Load(powerIcon,icon);
	CSAPI.SetRectSize(powerImg,46,46);
	CSAPI.SetRectSize(powerIcon,46,46);
	getCostNumFunc=getNumFunc;
end

function RemoveCost()
	CSAPI.SetGOActive(power, false);
	getCostNumFunc=nil;
	lastCost=0;
end