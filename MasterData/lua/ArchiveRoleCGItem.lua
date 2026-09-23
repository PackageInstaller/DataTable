

function SelectItemCB(_cb)
	cb = _cb
end

function Refresh(_data)
	data = _data
	if(data) then
		SetImg()
		SetMask()		
	end
end

function SetImg()
	if(data.cg_icon) then
		ResUtil.CGIcon:Load(icon, "cg") -- data.cg_icon) --todo
	end
end

function SetMask()
	CSAPI.SetGOActive(mask, true)
	
	--todo
	LanguageMgr:SetText(txtLock1, 40011)
	-- CSAPI.SetText(txtLock1, "解锁条件")
	LanguageMgr:SetText(txtLock2, 29070)
	-- CSAPI.SetText(txtLock2, "好感度")
	CSAPI.SetText(txtLock3, "100")

	--new
	CSAPI.SetText(new,"")
end


function OnClick()
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
bg=nil;
icon=nil;
mask=nil;
txtLock1=nil;
txtLock2=nil;
txtLock3=nil;
new=nil;
view=nil;
end
----#End#----