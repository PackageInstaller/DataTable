--剧情对话框
--播放文字效果参数
local isPlaying = false; --文字是否播放完
local isTween = false;--是否正在播放窗口动画
local playSpeed = 0.02;--文字播放速度，值越小越快
local plotOptionObj;--对话选项
local plotContent = nil
local contents = {}
local currLeftIndex= 0 --左侧对话文本下标
local recordInfo = {}
local isLastLeft = false
local currentPlotData;
local text_roleName1;  --角色名称控件
local text_roleName2;  --角色名称控件

local onPlotOver;--当字幕播放完成时

local isFirst = true;
local roleInfos = nil

local fade1 = nil --标题动画控件
local fade2 = nil --标题动画控件
local isMove = false --标题是否移动

local gradient = nil


function Awake()
	plotContent = PlotContent1
	text_roleName1 = ComUtil.GetCom(PlotTitle1, "Text");
	text_roleName2 = ComUtil.GetCom(PlotTitle2, "Text");
	fade1 = ComUtil.GetCom(titleFade1, "ActionFade");
	fade2 = ComUtil.GetCom(titleFade2, "ActionFade");
	gradient=ComUtil.GetCom(icon,"UIImageGradient");

	if content3 then
		table.insert(contents,content3.gameObject)
	end
end

function OnEnable()
	isTween = true;
	isFirst = true;
end

function OnDisable()
	CSAPI.SetText(plotContent, "")
	text_roleName1.text = ""
	text_roleName2.text = ""	
	isPlaying = false;
	isTween = false;
end

function OnDestroy()
	currentPlotData = nil;
	plotOptionObj = nil;
	onPlotOver = nil;
	SetIconGradient()
	ReleaseCSComRefs()
end

function IsPlaying()
	return isPlaying;
end

function IsTween()
	return isTween;
end

function ShowBox(data, isAuto)	
	if recordInfo[data:GetID()] then
		return
	end
	recordInfo[data:GetID()] = 1
	
	if data:IsLastContent() == false then
		currentPlotData = data;
		CSAPI.SetGOActive(gameObject, true);
		CSAPI.SetGOActive(centerObj, currentPlotData:IsCenter())
		CSAPI.SetGOActive(bottomObj, not currentPlotData:IsCenter() and not currentPlotData:IsLeft())
		if currentPlotData:IsCenter() then
			PlotTween.FadeIn(centerObj)
		end
		plotContent = currentPlotData:IsCenter() and PlotContent2 or PlotContent1
		ShowLeftBox()
		local talkName = currentPlotData:GetTalkName();
		if talkName == nil or talkName == "" then
			CSAPI.SetGOActive(titleObj, false);
		else
			SetTitlePos(currentPlotData)
			CSAPI.SetGOActive(titleObj, true);
		end
		CSAPI.SetGOActive(iconObj, currentPlotData:GetShowIcon());
		if currentPlotData:GetShowIcon() then
			SetIconGradient()
			--获取配置表头像
			if currentPlotData:IsLeader() then
				ResUtil.RoleCard:Load(icon, PlayerClient:GetIconName(), true);
			else
				local talkInfo = currentPlotData:GetTalkInfo();
				ResUtil.RoleCard:Load(icon, talkInfo:GetIcon(), true);

				local useGradient = currentPlotData:IsIconGradient()
				local iconGradient = talkInfo:GetIconGradient()
				if iconGradient and useGradient then
					iconGradient = iconGradient < 0 and 0 or iconGradient
					iconGradient = iconGradient> 100 and 100 or iconGradient
					SetIconGradient(iconGradient)
				end
			end
		end
		if isTween then
			PlotTween.FadeIn(childNode, nil, function()
				isPlaying = true;
				isTween = false;
				PlayPlot()
			end);
		else
			isPlaying = true;
			PlayPlot()
		end

		SetNextTween(isAuto)
	end
end

function ShowLeftBox()
	CSAPI.SetGOActive(leftObj,currentPlotData:IsLeft())
	if currentPlotData:IsLeft() then
		currLeftIndex = currLeftIndex + 1
		if contents[currLeftIndex] then
			plotContent = contents[currLeftIndex]
		else
			local go = CSAPI.CloneGO(contents[1],grid.transform)
			go.transform:SetSiblingIndex(currLeftIndex - 1)
			plotContent = go
			contents[currLeftIndex] = go
		end
		isLastLeft =true
	elseif isLastLeft then
		isLastLeft = false
		if #contents > 0 then
			for i, v in ipairs(contents) do
				CSAPI.SetText(v,"")
			end
		end
		currLeftIndex = 0
	end
end

function HideBox(isTween)
	if isTween and gameObject.activeSelf == true then
		PlotTween.FadeOut(childNode, nil, function()
			isTween = false;
			CSAPI.SetGOActive(gameObject, false);
		end);
	else
		CSAPI.SetGOActive(gameObject, false);
	end
end

--初始化选项
function InitSelectObj(info)
	if plotOptionObj == nil then
		local go = ResUtil:CreateUIGO("Plot/PlotOption", view.myParent);
		plotOptionObj = ComUtil.GetLuaTable(go);
	else
		CSAPI.SetGOActive(plotOptionObj.gameObject, true);
	end
	CSAPI.SetGOActive(gameObject,false)
	plotOptionObj.InitView(info);
end

--跳过对话输出
function JumpPlot()
	CSAPI.ApplyTextTweenFull(plotContent);
end

function PlayPlot()
	PlayPlotContent()
end

function PlayPlotContent()
	if currentPlotData:IsLastContent() == false then
		local textContent = currentPlotData:GetContent();
		CSAPI.ApplyTextTween(plotContent, textContent, playSpeed, PlayFullPolt);
	else
		isPlaying = false;
		OnPlotOver();
	end
end

--播放完的回调
function PlayFullPolt()
	if isPlaying then
		isPlaying = false;
		OnPlotOver();
	end
end

function PlayOut()
	CSAPI.ApplyAction(plotContent, "action_text_exit");
end

function SetOnPlotOver(func)
	if func ~= nil then
		onPlotOver = func;
	end
end

--剧情播放完成时
function OnPlotOver()
	if onPlotOver ~= nil then
		onPlotOver();
	end
end

--标题左右
function SetTitlePos(data)
	local isRight = false
	roleInfos = roleInfos or {}
	
	local dataInfos = data:GetRoleInfos()
	if dataInfos ~= nil and #dataInfos > 0 then
		for _, v in ipairs(dataInfos) do
			roleInfos[v.id] = v.pos
		end
	end
	
	local id = data:GetTalkID()
	if roleInfos and id then
		if roleInfos[id[1]] and roleInfos[id[1]] == 3 then
			isRight = true
		end								
	end
	
	local title = imgTitle1
	local txtRole = text_roleName1
	local fade = fade1
	local otherFade = fade2
	txtRole.text = currentPlotData:GetTalkName();	
	CSAPI.SetText(text_title2, currentPlotData:GetTalkEnName())		
end

--设置NEXT动画
function SetNextTween(isAuto, isClick)
	CSAPI.SetGOActive(nextTween, isAuto)	
	if(not isAuto) then
		CSAPI.SetLocalPos(moveObj, 0, 0)		
		if(isClick) then
			PlotTween.TweenMoveByPingPong2(moveObj, {0, 13}, 0.1)
		end
	end	
end

function SetIconGradient(num)
	local keys = {}
	if num then
		num = 100 - num
		table.insert(keys,{0, 100, 100, 100})
		table.insert(keys,{num, 0, 0, 0})
		table.insert(keys,{100, 0, 0, 0})
	else
		table.insert(keys,{0, 100, 100, 100})
		table.insert(keys,{100, 100, 100, 100})
	end
	gradient:SetGradientColor(keys)
	gradient.enabled = num ~= nil
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	childNode = nil;
	bottomObj = nil;
	PlotContent1 = nil;
	moveObj = nil;
	nextObj1 = nil;
	titleObj = nil;
	imgTitle1 = nil;
	PlotTitle1 = nil;
	text_title2 = nil;
	imgTitle2 = nil;
	PlotTitle2 = nil;
	centerObj = nil;
	PlotContent2 = nil;
	iconObj = nil;
	icon = nil;
	titleFade1 = nil;
	titleFade2 = nil;
	nextTween = nil;
	view = nil;
end
----#End#----
