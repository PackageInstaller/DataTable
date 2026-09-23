local cur = 1
local bs = 10 --1个数量对应的个数
local quantitynum=0;  ---数据量
function Awake()
	CSAPI.SetText(txtCancel, LanguageMgr:GetByID(1002))
	CSAPI.SetText(txtOk, LanguageMgr:GetByID(1001))
end

function OnOpen()
	cur = 1
	if openSetting == nil or openSetting == 1 then
		InitByRole()
	else
		InitByBag();
	end
	ShowAction()
	SetPanel()
end

function InitByBag()
	max = math.floor(g_EquipGridMaxSize - EquipMgr.maxSize) / bs
	local cfg = Cfgs.ItemInfo:GetByID(g_EquipGridAddCost[1]);
	itemName = cfg and cfg.name or ""
end

function InitByRole()
	max = math.floor(g_CardGridMaxSize - RoleMgr:GetMaxSize()) / bs
	
	local cfg = Cfgs.ItemInfo:GetByID(g_CardGirdAddCost[1])
	itemName = cfg and cfg.name or ""
end

function SetPanel()
	local num = math.floor(cur * bs)
	quantitynum=num;
	CSAPI.SetText(txtCount, math.floor(cur) .. "")
	local str = "";
	if openSetting == nil or openSetting == 1 then
		local str1 = LanguageMgr:GetByID(1015, num * g_CardGirdAddCost[2])
		local str2 = num--LanguageMgr:GetByID(1015, num)
		str = string.format(LanguageMgr:GetTips(3003), StringUtil:SetByColor(str1, "ffffff"), itemName, StringUtil:SetByColor(str2, "ffffff"), LanguageMgr:GetTips(3008))
	else
		str = string.format(LanguageMgr:GetTips(16004),(num * g_EquipGridAddCost[2]) .. itemName, num);
	end
	CSAPI.SetText(txtDesc, str)
end

function OnClickRemove()
	if(cur > 1) then
		cur = cur - 1
		SetPanel()
	end
end

function OnClickAdd()
	if(cur < max) then
		cur = cur + 1
		SetPanel()
	end
end

function OnClickMax()
	cur = max
	SetPanel()
end

function OnClickMin()
	cur = 1
	SetPanel()
end

function OnClickOK()
	if openSetting == nil or openSetting == 1 then
		RoleMgr:CardGirdAdd(cur * bs)	
	else
		if CSAPI.IsADVRegional(3) then
			CSAPI.ADVJPTitle(quantitynum * g_EquipGridAddCost[2],function() EquipProto:AddGrid(cur * bs); end)
		else
			EquipProto:AddGrid(cur * bs);
		end
	end
	Close()
end

function OnClickCancel()
	Close()
end

--入场动画
function ShowAction(callBack)
	CSAPI.ApplyAction(gameObject, "View_Open_Fade", callBack);
end

--退场动画
function HideAction(callBack)
	if close_tween then
		close_tween:Play(callBack);
	else
		close_tween = CSAPI.ApplyAction(gameObject, "View_Close_Fade", callBack);
	end
end

function Close()
	HideAction(function()
		if(not IsNil(view)) then
			view:Close()
		end
	end)
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
txtDesc=nil;
txtCount=nil;
txt1=nil;
btnL=nil;
imgL=nil;
btnR=nil;
imgR=nil;
btnMax=nil;
btnCancel=nil;
txtCancel=nil;
txtL2=nil;
btnOk=nil;
txtOk=nil;
txtR2=nil;
view=nil;
end
----#End#----