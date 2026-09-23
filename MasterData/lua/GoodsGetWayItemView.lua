--获取途径项
local isLock = false;
local lockStr=LanguageMgr:GetTips(16005);
function Awake()
	txtDesc = ComUtil.GetCom(desc, "Text");
end

function SetNull()
	CSAPI.SetGOActive(root,false);
	CSAPI.SetGOActive(desc2,false);
	CSAPI.SetGOActive(line,true);
end

function Refresh(cfgId)
	if cfgId==nil then
		-- LogError("cfgId不能为nil");
		SetNull();
		return
	end
	cfg = Cfgs.CfgJump:GetByID(cfgId);
	if cfg==nil then
		-- LogError("未获取到配置信息！");
		SetNull();
		return
	end
	txtDesc.text = cfg.desc;
	CSAPI.SetText(desc2,cfg.desc);
	if MenuMgr:CheckSystemIsOpenByJumpID(cfgId)~=true then
	--if UIUtil:CheckIsOpenNormal(cfg.sName)~=true then
		SetState(false);
	elseif cfg.sName == "Dungeon" and cfg.val3 then --打开关卡界面
		local isOpen = DungeonMgr:IsDungeonOpen(cfg.val3);
		lockStr=LanguageMgr:GetTips(16006);
		SetState(isOpen);
	elseif (cfg.sName=="Dungeon" and cfg.val3==nil) then --关卡界面
		local isOpen = false;
		local sectionData=DungeonMgr:GetSectionData(cfg.val1);
		lockStr=LanguageMgr:GetTips(16006);
		if sectionData:GetState(cfg.val2)~=0 then
			isOpen= true;
		end
		SetState(isOpen);
	elseif cfg.sName=="Section" then
		local isOpen = true;
		local sectionData=DungeonMgr:GetSectionData(cfg.val1);
		local isUnLock=sectionData:GetState();
		local _lockStr=sectionData:GetLockDesc();
		if isUnLock==false then
			lockStr=_lockStr;
			isOpen=false;
		elseif DungeonMgr:IsDailyOpenTime(sectionData:GetOpenTime())==false  then
			lockStr=LanguageMgr:GetTips(16007);
			isOpen=false;
		end
		SetState(isOpen);
	else
		SetState(true);
	end
end

function SetState(_isUnLock)
	isLock=not _isUnLock;
	local a = _isUnLock==false and math.modf(255 * 0.25) or 255;
	CSAPI.SetGOActive(root,not _isUnLock);
	CSAPI.SetGOActive(desc2, _isUnLock);
	CSAPI.SetTextColor(gameObject, 255, 255, 255, a, true);
	CSAPI.SetGOActive(line,false);
end

function SetClickCB(func)
end

function OnClickGo()
	-- Log( "未支持的功能！！");
	if cfg then
		if isLock then
			Tips.ShowTips(lockStr);
		else
			CSAPI.CloseAllOpenned();
			JumpMgr:Jump(cfg.id);
		end
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
root=nil;
lock=nil;
desc=nil;
desc2=nil;
line=nil;
view=nil;
end
----#End#----