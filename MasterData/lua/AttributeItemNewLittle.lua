--装备显示的属性信息
-- data={
--     id,  --属性的id，对应CfgCardPropertyEnum表中的id
--     val1, --显示的第一个数字
--     val1Color, --不设置默认为FFFFFF
--      type,--数据类型，1或者nil为基本属性，2为装备技能数据
--		hideName,--是否隐藏名称
--		alpha--背景颜色
-- } 
function Refresh(_data)
	data = _data
	val1Color = data.val1Color and data.val1Color or "FFFFFF"
	if _data.type==1 or _data.type==nil then
        RefreshByBase()
    elseif _data.type==2 then
        RefreshByESkill()
    end
	--val1
	if(data.val1) then
		CSAPI.SetText(val1, StringUtil:SetByColor(data.val1, val1Color))
	else
		CSAPI.SetText(val1, "")
	end
	SetBGAlpha(_data.alpha);
	CSAPI.SetGOActive(txtName,not data.hideName);
end 

function RefreshByBase()
    local cfg = Cfgs.CfgCardPropertyEnum:GetByID(data.id)
    CSAPI.SetGOActive(icon,true);
	--icon
	ResUtil.AttributeIcon:Load(icon,cfg.icon);
	--name
	CSAPI.SetText(txtName, cfg.sName)
end

function RefreshByESkill()
    CSAPI.SetGOActive(icon,false);
    local cfg = Cfgs.CfgEquipSkillTypeEnum:GetByID(data.id)
    CSAPI.SetText(txtName, cfg.sName)
end

function SetBGAlpha(val)
	if node then
		CSAPI.SetImgColor(node,67,67,67,val or 0);
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
node=nil;
icon=nil;
txtName=nil;
val1=nil;
view=nil;
end
----#End#----