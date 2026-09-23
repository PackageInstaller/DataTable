function Awake()
	CSAPI.PlayUISound("ui_popup_open")
	LanguageMgr:SetText(txtTitle,1076)--CSAPI.SetText(txtTitle, StringConstant.role_145)
end

function OnOpen()
	local key = data.key
	local cfg = Cfgs.CfgExplanatoryText:GetByKey(key)
	local str = cfg and cfg.desc or ""
	local title=cfg and cfg.title or ""
	CSAPI.SetText(txtContent, str)
	CSAPI.SetText(txtTitle,title);
end

function OnClickMask()
	view:Close()
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
txtTitle=nil;
txtContent=nil;
view=nil;
end
----#End#----