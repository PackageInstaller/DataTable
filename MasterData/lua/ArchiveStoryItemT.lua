local isNew = false

function SetIndex(idx)
	index = idx
end

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data)
	data = _data
	--name
	CSAPI.SetText(txtTitle1, data.name or "")
	CSAPI.SetText(txtTitle2, data.sName or "")
	--icon
	if data.small then
		ResUtil.Archive:Load(icon,"Plot/" ..  data.small)
	end
	--per
	cur = 0
	max = 0
	if(data.id) then
		cur,max = ArchiveMgr:GetMemoryCountByID(data.id)
	end
	local str = ""
	if cur == max then
		str = StringUtil:SetByColor(cur .. "/" .. max, "FFC146")
	else
		str = StringUtil:SetByColor(cur, "FFFFFF") .. StringUtil:SetByColor("/" .. max, "FFC146")
	end
	CSAPI.SetText(txtPercent, str)

	--new 
	isNew = ArchiveMgr:GetNew(ArchiveType.Story, data.id)
	CSAPI.SetGOActive(new, isNew)
end

function OnClick()
	if(cur > 0) then
		if(cb) then
			cb(data.id)
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
icon=nil;
txtPercent=nil;
txtTitle1=nil;
txtTitle2=nil;
view=nil;
end
----#End#----