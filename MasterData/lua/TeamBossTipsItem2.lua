--{isTitle = false, isWin = , isLost = ,rewards = , index = })
function Refresh(_data)
	data = _data
	SetTitle()
	SetItems()
end

function SetTitle()
	local str = ""
	if(data.isWin) then
		str = "胜利"
	elseif(data.isLost) then
		str = "失败"
	else
		str = data.index .. ""
	end
	CSAPI.SetText(txt, str)
end

function SetItems()
	local list = GridUtil.GetGridObjectDatas2(data.rewards)
	for i, v in ipairs(list) do
		local go, item = ResUtil:CreateGridItem(grid.transform)
		item.Refresh(v)
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
txt=nil;
grid=nil;
view=nil;
end
----#End#----