

function Refresh(_data, elseData)
	data = _data
	isShow = false
	if(elseData and elseData == data.sViewName) then
		isShow = true
	end
	CSAPI.SetText(txtName1, data.sName1)
	--CSAPI.SetText(txtName1, isShow and "" or data.sName1)
	--CSAPI.SetText(txtName2, isShow and data.sName1 or "")
end

function OnClick()
	if(not isShow) then
		if(data.sViewName == "") then
			if(data.cb) then
				data.cb() --首页
			end
		else
			CSAPI.OpenView(data.sViewName, nil, nil, nil, true)
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
txtName1=nil;
view=nil;
end
----#End#----