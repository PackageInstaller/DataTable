
-- data={
--     id,  --属性的id，对应CfgCardPropertyEnum表中的id
--     val
--     valColor, --不设置默认为FFFFFF
--     hideName, 是否显示名字
-- } 
function Refresh(_data)
	data = _data
	valColor = data.valColor and data.valColor or "FFFFFF"
	
	local cfg = Cfgs.CfgCardPropertyEnum:GetByID(data.id)

	CSAPI.SetText(txtName, cfg.sName2)

	--icon
	ResUtil.AttributeIcon:Load(icon,cfg.icon);
	
	CSAPI.SetGOActive(txtName,not data.hideName);
	
	local str1 = ""
	--val1
	if(data.val) then
		str1 = StringUtil:SetByColor(data.val, valColor)
	end
	CSAPI.SetText(val, "+"..str1)
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
txtName=nil;
val=nil;
view=nil;
end
----#End#----