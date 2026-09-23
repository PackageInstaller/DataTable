local cfg = nil

function SetIndex(idx)
	index = idx
end

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data)
	cfg = _data
	if cfg then
		CSAPI.SetText(txtTitle1, cfg.name or "")
		CSAPI.SetText(txtTitle2, cfg.eName or "")
		if cfg.small_id then
			ResUtil.Archive:Load(icon,"Course/" .. cfg.small_id)
		end
	end
end

function GetCfg()
	return cfg
end

function OnClick()
	if cb then
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
icon=nil;
txtTitle1=nil;
txtTitle2=nil;
view=nil;
end
----#End#----