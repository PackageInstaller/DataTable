function SetClickCB(_cb)
	cb = _cb
end
function Refresh(_data)
	data = _data
	state = data:GetState()
	isEnd = state == TeamBossRoomState.Win or state == TeamBossRoomState.Lost
	isEnd_s = not data:GetIsStarting()
	--难度
	CSAPI.SetText(txtHard, data:GetCfg().hard)
	--boss名称
	CSAPI.SetText(txtName, data:GetCfg().name)
	--准备状态
	SetState()
	--创建者
	CSAPI.SetText(txtCreate, string.format("创建：%s", data:GetCreateInfo().name))
	--人数
	CSAPI.SetText(txtRole, string.format("人数%s/%s", #data:GetRoles(), 5))
	--hp
	if(hp_bar == nil) then
		hp_bar = ComUtil.GetCom(bar, "BarBase")
	end
	local curHP, maxHP = data:GetHP()
	hp_bar:SetFullProgress(curHP, maxHP, true)
	--btn
	local str =(isEnd or isEnd_s) and "查看信息" or "参战"
	CSAPI.SetText(txtIn, str)
end

function SetState()
	CSAPI.SetGOActive(stateObj, isEnd)
	local str = ""
	if(isEnd) then
		str = state == TeamBossRoomState.Win and "战斗胜利" or "战斗失败"
	else
		str = state == TeamBossRoomState.Wait and "准备中" or "战斗中"
	end
	CSAPI.SetText(txtState, str)
	CSAPI.SetText(txtState2, str)
end


function OnClickIn()
	if(cb) then
		cb(this)
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
txtHard=nil;
txtState=nil;
txtName=nil;
txtCreate=nil;
txtRole=nil;
bar=nil;
txtHP=nil;
btnIn=nil;
txtIn=nil;
stateObj=nil;
txtState2=nil;
view=nil;
end
----#End#----