function SetIndex(_index)
	index = _index
end

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(id)
	LanguageMgr:SetText(txtName, id)
	Select(false)
end

function Select(b)
	CSAPI.SetGOActive(sel, b)
	if(b) then
		CSAPI.SetTextColor(txtName, 255, 193, 70, 255)
	else
		CSAPI.SetTextColor(txtName, 255, 255, 255, 128)
	end
	
	CSAPI.SetGOActive(point1, b)
	CSAPI.SetGOActive(point2, not b)
end

--刷新红点
function SetRed(b)
	UIUtil:SetRedPoint2("Common/Red2", red, b)
end

function OnClick()
	cb(index)
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
point=nil;
point1=nil;
point2=nil;
clickNode=nil;
sel=nil;
txtName=nil;
red=nil;
view=nil;
end
----#End#----