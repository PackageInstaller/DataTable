
local runTime = false
local timer = 0
local t = 0.5
function Awake()
	acObj = ComUtil.GetCom(gameObject, "ActionUIMoveTo")
	
end

function Update()
	if(runTime) then
		timer = timer - Time.deltaTime
		if(timer < 0) then
			timer = t
			SetTime()
		end
	end
end

--强制退出
function ForceClose(_cb)
	local x, y, z = CSAPI.GetAnchor(gameObject)
	runTime = false
	acObj:PlayByTime(- 550, y, 0, t, function()
		view:Close()
		if(_cb) then
			_cb()
		end
	end)
end

--邀请tips
function Close()
	local x, y, z = CSAPI.GetAnchor(gameObject)
	acObj:PlayByTime(- 550, y, 0, t, function()
		view:Close()
		if(cb) then
			cb(index)
		end
	end)
end

function Refresh(_index, _data, _cb)
	index = _index
	data = _data
	cb = _cb
	
	friendData = FriendMgr:GetData(data.uid)
	local cfg = Cfgs.CfgTeamBoss:GetByID(data.cfgid)
	if(cfg) then
		--desc
		CSAPI.SetText(txtTime1, string.format("邀请你攻略 %s %s", cfg.name, cfg.infos[i].hard))
	end
	--lv
	local lvStr = LanguageMgr:GetByID(1033) or "LV."
	CSAPI.SetText(txtLv, lvStr .. friendData:GetLv())
	--name
	CSAPI.SetText(txtName, friendData:GetName())
	--time
	baseTime = data.invite_time + g_TeamBossTipsWaitTime
	SetTime()
end

function SetTime()
	if(baseTime > 0) then
		needTime = baseTime - TimeUtil:GetTime()
		needTime = needTime > 0 and needTime or 0
	else
		needTime = 0
	end
	runTime = needTime > 0
	CSAPI.SetText(txtTime2, math.floor(needTime) .. "s")
	if(runTime == false) then
		Close()
	end
end

function GetIndex()
	return index
end

--向上移动
function SetMoveUp(y)
	local x = CSAPI.GetAnchor(gameObject)
	acObj:PlayByTime(x, y, 0, t)
end

--拒绝
function OnClick1()
	if(data) then
		runTime = false
		TeamBoss:RoomBeInviteRet(data.uid, data.id, false)
		Close()
	end
end

--接受
function OnClick2()
	if(data) then
		runTime = false
		TeamBoss:RoomBeInviteRet(data.uid, data.id, true)
		Close()
	end
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
txtLv=nil;
txtName=nil;
txtTime1=nil;
txtTime2=nil;
btn1=nil;
txtBtn1=nil;
btn2=nil;
txtBtn2=nil;
view=nil;
end
----#End#----