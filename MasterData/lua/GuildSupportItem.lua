--协战格子
local cb=nil;
function Refresh(_data)
	data = _data
	AddChild()
end

function SetClickCB(_cb)
	cb=_cb;
end

function AddChild()
	if(roleItemN == nil) then
		ResUtil:CreateUIGOAsync("RoleCard/RoleLittleCard", rootNode, function(go)
			roleItemN = ComUtil.GetLuaTable(go)
			roleItemN.Refresh(data.cardData)
			roleItemN.ActiveClick(false)
		end)
	else
		roleItemN.Refresh(data.cardData);
	end
end

function OnClick()
	if cb and data and data.cardData then
		cb(data.cardData:GetID());
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
clickNode=nil;
rootNode=nil;
view=nil;
end
----#End#----