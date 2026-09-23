local itemPath = "Archive2/ArchiveRoleCGItem"

function Awake()
	layout = ComUtil.GetComInChildren(sv, "UICircularScrollView")
	layout:Init(LayoutCallBack)
end

function LayoutCallBack(element)
	local index = tonumber(element.name) + 1
	local _data = curDatas[index]
	ItemUtil.AddCircularItems(element, itemPath, _data,nil,SelectItemCB)
end


function Refresh(_data)
	data = _data
	curDatas = CRoleMgr:GetCG(data:GetID()) or {}

	layout:IEShowList(#curDatas)

end


function SelectItemCB(item)
	selectCG = item
	
	Tips.ShowTips(StringTips.common1)  --todo

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
sv=nil;
view=nil;
end
----#End#----