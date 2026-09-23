function SetIndex(_index)
	index = _index
end
function Refresh(data)
	--index
	CSAPI.SetText(txtSort, index .. "")
	--name
	CSAPI.SetText(txtName, data.name)
	--damage
	CSAPI.SetText(txtName, data.hurtCnt)
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
txtIndex=nil;
txtName=nil;
txtDamage=nil;
hight=nil;
view=nil;
end
----#End#----