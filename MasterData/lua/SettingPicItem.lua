--画面质量
function Refresh(_data)
	data = _data
	CSAPI.SetText(txtNormal, data.name)
	CSAPI.SetText(txtSel, data.name)
	--icon
	CSAPI.LoadImg(icon, "UIs/Setting/" .. data.iconName .. ".png", true, nil, true)
end

function SetClickCB(_cb)
	cb = _cb
end

function OnClick()
	local imgQuality = SettingMgr:GetValue(s_quality_key)
	if(data.index == imgQuality) then
		return
	end
	local tips = {}
	tips.content = data.desc
	tips.okCallBack = function()
		if(cb) then
			cb(data)
		end
		SettingMgr:SaveValue(s_quality_key, data.index)
		CSAPI.SetGameLv(data.index)
	end
	CSAPI.OpenView("Dialog", tips)
end

function SetSelect(_b)
	CSAPI.SetGOActive(normal, not _b)
	CSAPI.SetGOActive(sel, _b)
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
normal=nil;
txtNormal=nil;
sel=nil;
imgObj=nil;
txtSel=nil;
view=nil;
end
----#End#----