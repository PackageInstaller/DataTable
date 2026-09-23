--战斗目标物体
-- local textMove=nil;
-- function Awake()
--     textMove = ComUtil.GetCom(nameMask, "TextMove");
-- end
function Awake()
	CSAPI.SetGOActive(action, false)
end

function OnDisable()
	CSAPI.SetGOActive(action, false)
end

function Init(tips, isComplete)
	type = type == nil and 1 or type;
	SetComplete(isComplete)
	CSAPI.SetText(text_tips, tips or "");
	-- textMove:SetMove();
end

function SetIndex(idx)
	index = idx
	SetTween()
end

function SetComplete(isComplete)
	isComplete = isComplete == true and true or false;
	local color = isComplete and {255, 193, 70, 255} or {255, 255, 255, 255}
	CSAPI.SetTextColor(text_tips, color[1], color[2], color[3], color[4])
	CSAPI.SetGOActive(unlock, isComplete)
	CSAPI.SetGOActive(lock, not isComplete)
	--CSAPI.SetTextColor(text_tips, color[1], color[2], color[3], color[4])
end

function SetTween()
	if not fade then
		fade = ComUtil.GetCom(action, "ActionFade")
	end
	if not move then
		move = ComUtil.GetCom(action, "ActionMoveByCurve")
	end	
	move.delay = 300 +(index - 1) * 85
	move.time = 250
	move.startPos = UnityEngine.Vector3(0, 30, 0)
	move.targetPos = UnityEngine.Vector3(0, 0, 0)
	fade.time = 250 -(index - 1) * 50
	fade.delay = 300 +(index - 1) * 85
	fade.to = 1
end

function PlayTween()
	CSAPI.SetGOActive(action, true)
end
-- --无星
-- function InitPvp(tips)
-- 	CSAPI.SetGOActive(unlock, false)
-- 	CSAPI.SetGOActive(lock, not false)
-- 	CSAPI.SetText(text_tips, tips or "")
-- end 
function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	text_tips = nil;
	unlock = nil;
	lock = nil;
	view = nil;
end
----#End#----
