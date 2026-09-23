--剧情选项
local pos1 = {};
local pos2 = {};
local pos3 = {};
local items = {};
local txts = {};
local isPlayInTween = false;
function Awake()
	for i = 1, 3 do
		table.insert(items, this["btnClick" .. i].gameObject)
		table.insert(txts, this["txtDesc" .. i].gameObject)
	end
	pos1 = {{0, 0}}
	pos2 = {{0, 75}, {0, - 75}}
	pos3 = {{0, 150}, {0, 0}, {0, - 150}}
end

function InitView(data)
	isPlayInTween = true;
	if data ~= nil then
		source = data;
		local pos = pos1
		pos = #data > 1 and pos2 or pos
		pos = #data > 2 and pos3 or pos
		for k, v in ipairs(pos) do
			CSAPI.SetAnchor(items[k], v[1], v[2])
		end
		for k, v in ipairs(items) do
			if k > #data then
				CSAPI.SetAnchor(v, 0, 10000)
			end
		end
	else
		for k, v in ipairs(items) do
			CSAPI.SetAnchor(v, 0, 10000)
		end
		for k, v in ipairs(txts) do
			CSAPI.SetText(txts[k], "")
		end
	end
	PlayIn();
end

function PlayIn(cb)
	local inTime = 200
	for k, v in ipairs(items) do
		if source and k <= #source then
			CSAPI.SetText(txts[k], source[k]:GetContent())
			CSAPI.SetRTSize(items[k].gameObject, 836, 132)
			PlotTween.FadeIn(items[k].gameObject, inTime / 1000, nil, 0.1)
		end
	end
	FuncUtil:Call(function()
		isPlayInTween = false;
	end, nil, inTime + 100);
end

function PlayOut(choosieObj, cb)
	for k, v in ipairs(txts) do
		CSAPI.SetText(txts[k], "")
	end
	for k, v in ipairs(items) do
		local func = nil;		
		if source then			
			if k == #source then
				func = cb;
			end
			if k <= #source then
				PlotTween.FadeOut(items[k].gameObject, 0.1, func)
			end
		end
		
	end
end

function DoMove(go, pos, callBack)
	CSAPI.csMoveTo(go, "UI_Local_Move", pos[1], pos[2], pos[3], callBack, 0.5);
end

function OnClickOption(go)
	if isPlayInTween then
		return
	end
	PlayOut(go, function()
		if isPlayInTween == false then
			CSAPI.SetGOActive(gameObject, false);
		end
	end);
	for k, v in ipairs(items) do
		if v == go and source and k <= #source then
			JumpNextPlot(source[k]);
			break;
		end
	end
end

--跳转到下一段对话
function JumpNextPlot(plotInfo)
	--抛出选择剧情选项事件
	EventMgr.Dispatch(EventType.Select_Plot_Option, plotInfo);
end

function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	mask = nil;
	btnClick1 = nil;
	txtDesc1 = nil;
	btnClick2 = nil;
	txtDesc2 = nil;
	btnClick3 = nil;
	txtDesc3 = nil;
	btnClick4 = nil;
	txtDesc4 = nil;
	btnClick5 = nil;
	txtDesc5 = nil;
	btnClick6 = nil;
	txtDesc6 = nil;
	btnClick7 = nil;
	txtDesc7 = nil;
	btnClick8 = nil;
	txtDesc8 = nil;
	view = nil;
end
----#End#----
