--等待报名界面
function Awake()
	CSAPI.SetGOActive(infoParent, false)
end

function Refresh()
	local data = WorldBossMgr:GetData()
	if(data) then
		local cfg = Cfgs.cfgWorldBoss:GetByID(data.nConfigID)
		--活动时间
		CSAPI.SetText(txtTime, cfg.nBeginTime .. "\n" .. cfg.nEndTime)
	end
end

function OnClickReward()
	WorldBossMgr:GetBossDamage()
end

function OnClickInfo()
	CSAPI.SetGOActive(infoParent, true)
end

function OnClickInfoParent()
	CSAPI.SetGOActive(infoParent, false)
end

--报名
function OnClickEnter()
	WorldBossMgr:EnterBoss()
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
icon=nil;
txtTime=nil;
view=nil;
end
----#End#----