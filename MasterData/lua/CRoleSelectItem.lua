
function SetIndex(_index)
	index = _index
end

function SetClickCB(_cb)
	cb = _cb
end

-- data : CRoleInfo
function Refresh(_data)
	data = _data
	
	--icon
	SetIcon(data:GetIcon())
	--arrows
	LoadFrame(data:GetQuality())
	--name    
	CSAPI.SetText(txtName, data:GetAlias())
end

function SetIcon(_iconName)
	if(_iconName) then
		ResUtil.Card:Load(icon, _iconName)
	end
end

function LoadFrame(lvQuality)
	lvQuality = lvQuality or 1;
	local frame = GridFrame[lvQuality];
	--local tirangleImg = GridFrame2[lvQuality];
	ResUtil.IconGoods:Load(bg, frame, false)
	--ResUtil.IconGoods:Load(triangle1, tirangleImg);
	--ResUtil.IconGoods:Load(triangle2, tirangleImg);
end

function OnClick()
	if(cb) then
		cb(index)
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
clickNode=nil;
root=nil;
bg=nil;
icon=nil;
txtName=nil;
view=nil;
end
----#End#----